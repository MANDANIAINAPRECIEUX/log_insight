# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "log_insight"
  spec.version       = "0.1.0"
  spec.summary       = "HTTP log analyzer CLI"
  spec.description   = "Analyze HTTP logs, extract stats, export CSV/JSON."
  spec.authors       = ["MANDANIA INAPRECIEUX"] # change si besoin
  spec.homepage      = "https://github.com/MANDANIAINAPRECIEUX/log_insight"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.7"

  spec.bindir        = "exe"
  spec.executables   = ["log_insight"]
  spec.require_paths = ["lib"]

  spec.files = Dir[
    "lib/**/*",
    "exe/*",
    "README.md",
    "LICENSE*"
  ]
end
