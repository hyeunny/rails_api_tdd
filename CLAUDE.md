# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Setup
bin/setup               # Initial dev setup (idempotent)
bin/setup --reset       # Reset the database and re-setup

# Development
bin/dev                 # Start development server (port 3000)

# Testing
bin/rails test                                        # Full test suite
bin/rails test test/models/some_model_test.rb         # Single file
bin/rails test test/models/some_model_test.rb:42      # Single test at line

# Code quality
bin/rubocop             # Lint
bin/brakeman            # Security static analysis
bin/bundler-audit       # Check for vulnerable gems
bin/ci                  # Run the full CI pipeline locally (setup + lint + security + tests)

# Database
bin/rails db:prepare    # Create and migrate
bin/rails db:seed       # Seed data
```

## Architecture

Rails 8.1.3 **API-only** app (`ActionController::API`), no views or helpers. Ruby 3.4.9.

**Key design choices:**
- SQLite3 for development and test; production uses separate SQLite databases for primary, cache, queue, and cable
- Solid Queue for background jobs, Solid Cache for caching, Solid Cable for WebSockets — all database-backed, no Redis dependency
- Puma + Thruster for HTTP/2 acceleration in production
- Kamal for containerized deployment (see `config/deploy.yml` and `Dockerfile`)

**Testing:** Minitest (Rails default), parallel execution configured via `:number_of_processors` workers. Tests live in `test/`, fixtures in `test/fixtures/`.

**CI (GitHub Actions):** Three jobs — `scan_ruby` (Brakeman + bundler-audit), `lint` (RuboCop), `test`. Runs on PRs and pushes to main.

**Linting:** RuboCop with `rubocop-rails-omakase` — run `bin/rubocop` before committing.
