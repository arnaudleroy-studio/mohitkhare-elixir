defmodule MohitKhare do
  @moduledoc """
  Developer utilities for text processing and content analysis.

  Provides lightweight helpers for token estimation, slug generation, and
  text analysis -- common operations in content pipelines and AI integrations.
  All functions are dependency-free and designed to compose with Elixir pipes.

  ## Usage

      "Hello, world of Elixir"
      |> MohitKhare.estimate_tokens()
      # 5

      MohitKhare.slugify("My Article Title!")
      # "my-article-title"

  Built by [Mohit Khare](https://mohitkhare.me).
  """

  @version "0.1.2"
  @base_url "https://mohitkhare.me"

  @words_per_minute 238

  @doc """
  Returns the library version.

  ## Examples

      iex> MohitKhare.version()
      "0.1.2"
  """
  @spec version() :: String.t()
  def version, do: @version

  @doc """
  Returns the base URL of the developer portfolio.

  ## Examples

      iex> MohitKhare.base_url()
      "https://mohitkhare.me"
  """
  @spec base_url() :: String.t()
  def base_url, do: @base_url

  @doc """
  Estimates the number of LLM tokens in a string.

  Uses a word-boundary heuristic where each word maps to roughly 1.3 tokens,
  which approximates GPT-style BPE tokenization without requiring a full
  vocabulary lookup. Accurate enough for prompt length budgeting.

  ## Examples

      iex> MohitKhare.estimate_tokens("Hello world")
      3

      iex> MohitKhare.estimate_tokens("")
      0
  """
  @spec estimate_tokens(String.t()) :: non_neg_integer()
  def estimate_tokens(text) when is_binary(text) do
    text
    |> String.split(~r/\s+/, trim: true)
    |> length()
    |> Kernel.*(1.3)
    |> ceil()
  end

  @doc """
  Generates a URL-safe slug from a string.

  Strips non-alphanumeric characters, collapses whitespace, and downcases.

  ## Examples

      iex> MohitKhare.slugify("Elixir & Phoenix: A Guide")
      "elixir-phoenix-a-guide"

      iex> MohitKhare.slugify("  Multiple   Spaces  ")
      "multiple-spaces"
  """
  @spec slugify(String.t()) :: String.t()
  def slugify(text) when is_binary(text) do
    text
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9\s-]/, "")
    |> String.replace(~r/[\s-]+/, "-")
    |> String.trim("-")
  end

  @doc """
  Returns a word count for the given text.

  ## Examples

      iex> MohitKhare.word_count("one two three")
      3

      iex> MohitKhare.word_count("")
      0
  """
  @spec word_count(String.t()) :: non_neg_integer()
  def word_count(text) when is_binary(text) do
    text
    |> String.split(~r/\s+/, trim: true)
    |> length()
  end

  @doc """
  Analyzes a text string and returns a summary map.

  The map includes word count, character count, estimated tokens, and
  approximate reading time in seconds (based on #{@words_per_minute} WPM).

  ## Examples

      iex> result = MohitKhare.analyze("Elixir is a functional language")
      iex> result.word_count
      5
      iex> is_integer(result.estimated_tokens)
      true
  """
  @spec analyze(String.t()) :: %{
          word_count: non_neg_integer(),
          char_count: non_neg_integer(),
          estimated_tokens: non_neg_integer(),
          reading_time_seconds: non_neg_integer()
        }
  def analyze(text) when is_binary(text) do
    words = word_count(text)

    %{
      word_count: words,
      char_count: String.length(text),
      estimated_tokens: estimate_tokens(text),
      reading_time_seconds: ceil(words / @words_per_minute * 60)
    }
  end

  @doc """
  Returns information about the library and its author.

  ## Examples

      iex> info = MohitKhare.info()
      iex> info.author
      "Mohit Khare"
  """
  @spec info() :: map()
  def info do
    %{
      name: "MohitKhare",
      author: "Mohit Khare",
      version: @version,
      base_url: @base_url,
      utilities: [:estimate_tokens, :slugify, :word_count, :analyze]
    }
  end
end
