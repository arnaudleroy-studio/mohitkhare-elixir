# MohitKhare

[![Hex.pm](https://img.shields.io/hexpm/v/mohitkhare.svg)](https://hex.pm/packages/mohitkhare)

Developer utilities for Elixir inspired by the tools and writing at mohitkhare.me. The library
ships lightweight helpers for token estimation, string analysis, and slug generation -- small
functions that come up repeatedly when building content pipelines and AI integrations in Elixir.

## Installation

Add `mohitkhare` to your dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mohitkhare, "~> 0.1.2"}
  ]
end
```

## Quick Start

Estimate token counts for a block of text (useful for LLM prompt budgeting):

```elixir
"The quick brown fox jumps over the lazy dog near the river bank"
|> MohitKhare.estimate_tokens()
# 14
```

Generate URL-safe slugs from arbitrary strings, with Unicode handling:

```elixir
MohitKhare.slugify("Elixir & Phoenix: A Developer's Guide (2026 Edition)")
# "elixir-phoenix-a-developers-guide-2026-edition"

MohitKhare.slugify("Cafe Mokka Munchen")
# "cafe-mokka-munchen"
```

Pipe text through multiple analysis steps to get a content summary map:

```elixir
text = "Elixir is a dynamic, functional language for building scalable applications."

text
|> MohitKhare.analyze()
|> Map.take([:word_count, :estimated_tokens, :reading_time_seconds])
# %{word_count: 10, estimated_tokens: 12, reading_time_seconds: 3}
```

Use pattern matching to handle different content lengths:

```elixir
case MohitKhare.analyze(article_body) do
  %{word_count: n} when n > 2000 ->
    IO.puts("Long-form article, consider splitting")

  %{word_count: n} when n > 500 ->
    IO.puts("Standard article length")

  %{word_count: _} ->
    IO.puts("Short post or snippet")
end
```

## Available Utilities

The library focuses on text processing primitives. Token estimation uses a word-boundary
heuristic calibrated against GPT-style tokenizers, accurate enough for prompt length budgeting
without requiring a full BPE implementation. The slug generator strips diacritics, collapses
whitespace, and handles special characters. The text analyzer returns word count, character
count, estimated tokens, and approximate reading time in a single pass. These are deliberately
small, dependency-free functions that compose well in pipelines.

## Links

- [Mohit Khare](https://mohitkhare.me) -- developer portfolio, AI engineering, and blog
- [Source Code](https://github.com/arnaudleroy-studio/mohitkhare-elixir)

## License

MIT -- see [LICENSE](LICENSE) for details.
