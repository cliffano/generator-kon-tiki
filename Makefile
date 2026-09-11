ci: clean stage deps test-static-content test-static-content-partials test-static-redirect test-static-redirect-partials

clean:
	rm -rf stage/

########################################
# static-content targets
########################################

clean-static-content:
	rm -rf stage/static-content/

stage:
	mkdir -p stage/

deps:
	npm install .

generate-static-content: clean-static-content
	node_modules/.bin/plop static-content

test-static-content:
	node_modules/.bin/plop static-content -- \
	  --project_id "static-content" \
		--project_name "Static Content" \
		--project_desc "Kon-Tiki web site static content" \
		--author_name "Pakkun" \
		--author_email "pakkunbot@users.noreply.github.com" \
		--author_url "https://github.com/pakkunbot" \
		--github_id "pakkunbot" \
		--github_repo "static-content" \
		--github_token_prefix "STUDIO"
	cd stage/static-content/ && \
	  make ci

########################################
# static-content-partials targets
########################################

clean-static-content-partials:
	rm -rf stage/static-content-partials/

generate-static-content-partials: clean-static-content-partials
	node_modules/.bin/plop static-content-partials

test-static-content-partials:
	node_modules/.bin/plop static-content-partials -- \
	  --project_id "staticcontent" \
		--project_name "StaticContent" \
		--project_desc "A sample static website" \
		--author_name "Pakkun" \
		--author_email "pakkunbot@users.noreply.github.com" \
		--author_url "https://github.com/pakkunbot" \
		--github_id "pakkunbot" \
		--github_repo "static-content" \
		--github_token_prefix "STUDIO"

########################################
# static-redirect targets
########################################

clean-static-redirect:
	rm -rf stage/static-redirect/

generate-static-redirect: clean-static-redirect
	node_modules/.bin/plop static-redirect

test-static-redirect:
	node_modules/.bin/plop static-redirect -- \
	  --project_id "static-redirect" \
		--project_name "Static Redirect" \
		--project_desc "Kon-Tiki web site static redirect" \
		--author_name "Pakkun" \
		--author_email "pakkunbot@users.noreply.github.com" \
		--author_url "https://github.com/pakkunbot" \
		--github_id "pakkunbot" \
		--github_repo "static-redirect" \
		--github_token_prefix "STUDIO" \
		--redirect_url "https://www.britannica.com/topic/Kon-Tiki-raft"
	cd stage/static-redirect/ && \
	  make ci

########################################
# static-redirect-partials targets
########################################

clean-static-redirect-partials:
	rm -rf stage/static-redirect-partials/

generate-static-redirect-partials: clean-static-redirect-partials
	node_modules/.bin/plop static-redirect-partials

test-static-redirect-partials:
	node_modules/.bin/plop static-redirect-partials -- \
	  --project_id "staticredirect" \
		--project_name "StaticRedirect" \
		--project_desc "A sample static redirect" \
		--author_name "Pakkun" \
		--author_email "pakkunbot@users.noreply.github.com" \
		--author_url "https://github.com/pakkunbot" \
		--github_id "pakkunbot" \
		--github_repo "static-redirect" \
		--github_token_prefix "STUDIO"

update-knut-haugland-to-latest:
	cd templates/static-content && make update-to-latest
	cd templates/static-redirect && make update-to-latest

.PHONY: ci clean clean-static-content clean-static-content-partials clean-static-redirect clean-static-redirect-partials stage deps generate-static-content test-static-content generate-static-content-partials test-static-content-partials generate-static-redirect test-static-redirect generate-static-redirect-partials test-static-redirect-partials update-knut-haugland-to-latest
