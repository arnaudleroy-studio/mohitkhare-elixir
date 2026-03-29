defmodule MohitKhare.MixProject do
  use Mix.Project

  def project do
    [
      app: :mohitkhare,
      version: "0.1.1",
      elixir: "~> 1.14",
      description: "Developer utilities and token counting tools.",
      package: package(),
      deps: deps(),
      docs: docs(),
      source_url: "https://github.com/arnaudleroy-studio/mohitkhare-elixir",
      homepage_url: "https://mohitkhare.me"
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
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
    [
      main: "MohitKhare",
      extras: ["README.md"]
    ]
  end
end
