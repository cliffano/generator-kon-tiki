ci: clean stage deps test-static-content test-static-content-partials test-static-redirect test-static-redirect-partials

clean:
	rm -rf stage/

stage:
	mkdir -p stage/

deps:
	npm install .

########################################
# Utility targets
########################################

GENERATOR_CONFIG ?= knut-haugland.yml

define set_generator_vars
$(1): GENERATOR_COMPONENT = $$(shell yq .generator.component $(2))
$(1): GENERATOR_INPUTS_PROJECT_ID = $$(shell yq .generator.inputs.project_id $(2))
$(1): GENERATOR_INPUTS_PROJECT_NAME = $$(shell yq .generator.inputs.project_name $(2))
$(1): GENERATOR_INPUTS_PROJECT_DESC = $$(shell yq .generator.inputs.project_desc $(2))
$(1): GENERATOR_INPUTS_AUTHOR_NAME = $$(shell yq .generator.inputs.author_name $(2))
$(1): GENERATOR_INPUTS_AUTHOR_EMAIL = $$(shell yq .generator.inputs.author_email $(2))
$(1): GENERATOR_INPUTS_AUTHOR_URL = $$(shell yq .generator.inputs.author_url $(2))
$(1): GENERATOR_INPUTS_GITHUB_ID = $$(shell yq .generator.inputs.github_id $(2))
$(1): GENERATOR_INPUTS_GITHUB_REPO = $$(shell yq .generator.inputs.github_repo $(2))
$(1): GENERATOR_INPUTS_GITHUB_TOKEN_PREFIX = $$(shell yq .generator.inputs.github_token_prefix $(2))
endef

# static-redirect also takes a redirect_url input on top of the standard set
define set_generator_redirect_url_var
$(1): GENERATOR_INPUTS_REDIRECT_URL = $$(shell yq .generator.inputs.redirect_url $(2))
endef

########################################
# static-content targets
########################################

clean-static-content:
	rm -rf stage/static-content/

generate-static-content: clean-static-content
	node_modules/.bin/plop static-content

$(eval $(call set_generator_vars,generate-static-content-with-config,$(GENERATOR_CONFIG)))
generate-static-content-with-config: clean-static-content
	node_modules/.bin/plop $(GENERATOR_COMPONENT) -- \
	    --project_id "$(GENERATOR_INPUTS_PROJECT_ID)" \
		--project_name "$(GENERATOR_INPUTS_PROJECT_NAME)" \
		--project_desc "$(GENERATOR_INPUTS_PROJECT_DESC)" \
		--author_name "$(GENERATOR_INPUTS_AUTHOR_NAME)" \
		--author_email "$(GENERATOR_INPUTS_AUTHOR_EMAIL)" \
		--author_url "$(GENERATOR_INPUTS_AUTHOR_URL)" \
		--github_id "$(GENERATOR_INPUTS_GITHUB_ID)" \
		--github_repo "$(GENERATOR_INPUTS_GITHUB_REPO)" \
		--github_token_prefix "$(GENERATOR_INPUTS_GITHUB_TOKEN_PREFIX)"

test-static-content: clean-static-content
	make generate-static-content-with-config GENERATOR_CONFIG=examples/knut-haugland-static-content.yml
	cd stage/static-content/ && \
	  make ci

########################################
# static-content-partials targets
########################################

clean-static-content-partials:
	rm -rf stage/static-content-partials/

generate-static-content-partials: clean-static-content-partials
	node_modules/.bin/plop static-content-partials

$(eval $(call set_generator_vars,generate-static-content-partials-with-config,$(GENERATOR_CONFIG)))
generate-static-content-partials-with-config: clean-static-content-partials
	node_modules/.bin/plop $(GENERATOR_COMPONENT) -- \
	    --project_id "$(GENERATOR_INPUTS_PROJECT_ID)" \
		--project_name "$(GENERATOR_INPUTS_PROJECT_NAME)" \
		--project_desc "$(GENERATOR_INPUTS_PROJECT_DESC)" \
		--author_name "$(GENERATOR_INPUTS_AUTHOR_NAME)" \
		--author_email "$(GENERATOR_INPUTS_AUTHOR_EMAIL)" \
		--author_url "$(GENERATOR_INPUTS_AUTHOR_URL)" \
		--github_id "$(GENERATOR_INPUTS_GITHUB_ID)" \
		--github_repo "$(GENERATOR_INPUTS_GITHUB_REPO)" \
		--github_token_prefix "$(GENERATOR_INPUTS_GITHUB_TOKEN_PREFIX)"

test-static-content-partials: clean-static-content-partials
	make generate-static-content-partials-with-config GENERATOR_CONFIG=examples/knut-haugland-static-content-partials.yml

########################################
# static-redirect targets
########################################

clean-static-redirect:
	rm -rf stage/static-redirect/

generate-static-redirect: clean-static-redirect
	node_modules/.bin/plop static-redirect

$(eval $(call set_generator_vars,generate-static-redirect-with-config,$(GENERATOR_CONFIG)))
$(eval $(call set_generator_redirect_url_var,generate-static-redirect-with-config,$(GENERATOR_CONFIG)))
generate-static-redirect-with-config: clean-static-redirect
	node_modules/.bin/plop $(GENERATOR_COMPONENT) -- \
	    --project_id "$(GENERATOR_INPUTS_PROJECT_ID)" \
		--project_name "$(GENERATOR_INPUTS_PROJECT_NAME)" \
		--project_desc "$(GENERATOR_INPUTS_PROJECT_DESC)" \
		--author_name "$(GENERATOR_INPUTS_AUTHOR_NAME)" \
		--author_email "$(GENERATOR_INPUTS_AUTHOR_EMAIL)" \
		--author_url "$(GENERATOR_INPUTS_AUTHOR_URL)" \
		--github_id "$(GENERATOR_INPUTS_GITHUB_ID)" \
		--github_repo "$(GENERATOR_INPUTS_GITHUB_REPO)" \
		--github_token_prefix "$(GENERATOR_INPUTS_GITHUB_TOKEN_PREFIX)" \
		--redirect_url "$(GENERATOR_INPUTS_REDIRECT_URL)"

test-static-redirect: clean-static-redirect
	make generate-static-redirect-with-config GENERATOR_CONFIG=examples/knut-haugland-static-redirect.yml
	cd stage/static-redirect/ && \
	  make ci

########################################
# static-redirect-partials targets
########################################

clean-static-redirect-partials:
	rm -rf stage/static-redirect-partials/

generate-static-redirect-partials: clean-static-redirect-partials
	node_modules/.bin/plop static-redirect-partials

$(eval $(call set_generator_vars,generate-static-redirect-partials-with-config,$(GENERATOR_CONFIG)))
generate-static-redirect-partials-with-config: clean-static-redirect-partials
	node_modules/.bin/plop $(GENERATOR_COMPONENT) -- \
	    --project_id "$(GENERATOR_INPUTS_PROJECT_ID)" \
		--project_name "$(GENERATOR_INPUTS_PROJECT_NAME)" \
		--project_desc "$(GENERATOR_INPUTS_PROJECT_DESC)" \
		--author_name "$(GENERATOR_INPUTS_AUTHOR_NAME)" \
		--author_email "$(GENERATOR_INPUTS_AUTHOR_EMAIL)" \
		--author_url "$(GENERATOR_INPUTS_AUTHOR_URL)" \
		--github_id "$(GENERATOR_INPUTS_GITHUB_ID)" \
		--github_repo "$(GENERATOR_INPUTS_GITHUB_REPO)" \
		--github_token_prefix "$(GENERATOR_INPUTS_GITHUB_TOKEN_PREFIX)"

test-static-redirect-partials: clean-static-redirect-partials
	make generate-static-redirect-partials-with-config GENERATOR_CONFIG=examples/knut-haugland-static-redirect-partials.yml

update-knut-haugland-to-latest:
	cd templates/static-content && make update-to-latest
	cd templates/static-redirect && make update-to-latest

.PHONY: ci clean clean-static-content clean-static-content-partials clean-static-redirect clean-static-redirect-partials stage deps generate-static-content generate-static-content-with-config test-static-content generate-static-content-partials generate-static-content-partials-with-config test-static-content-partials generate-static-redirect generate-static-redirect-with-config test-static-redirect generate-static-redirect-partials generate-static-redirect-partials-with-config test-static-redirect-partials update-knut-haugland-to-latest
