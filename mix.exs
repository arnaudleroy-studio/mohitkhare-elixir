defmodule MohitKhare.MixProject do
  use Mix.Project

  def project do
    [
      app: :mohitkhare,
      version: "0.1.0",
      elixir: "~> 1.14",
      description: "Developer utilities and token counting tools.",
      package: package(),
      docs: docs(),
      source_url: "https://github.com/arnaudleroy-studio/mohitkhare-elixir",
      homepage_url: "https://mohitkhare.me"
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "Homepage" => "https://mohitkhare.me",
        "GitHub" => "https://github.com/arnaudleroy-studio/mohitkhare-elixir",
        "Documentation" => "https://mohitkhare.me/blog"
      }
    ]
  end

  defp docs do
    [main: "MohitKhare"]
  end
end
