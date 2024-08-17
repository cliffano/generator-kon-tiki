ci: clean stage deps test-static-redirect test-static-content

clean:
	rm -rf stage/

stage:
	mkdir -p stage/

deps:
	npm install .

clean-static-redirect:
	rm -rf stage/static-redirect/

clean-static-content:
	rm -rf stage/static-content/

generate-static-redirect: clean-static-redirect
	node_modules/.bin/plop static-redirect

generate-static-content: clean-static-content
	node_modules/.bin/plop static-content

test-static-redirect:
	node_modules/.bin/plop static-redirect -- \
	  --project_id "static-redirect" \
		--project_name "Static Redirect" \
		--project_desc "Kon-Tiki web site static redirect" \
		--author_name "Pakkun" \
		--author_email "blah+pakkun@cliffano.com" \
		--author_url "https://github.com/pakkunbot" \
		--github_id "pakkunbot" \
		--redirect_url "https://www.britannica.com/topic/Kon-Tiki-raft"
	cd stage/static-redirect/ && \
	  make ci

test-static-content:
	node_modules/.bin/plop static-content -- \
	  --project_id "static-content" \
		--project_name "Static Content" \
		--project_desc "Kon-Tiki web site static content" \
		--author_name "Pakkun" \
		--author_email "blah+pakkun@cliffano.com" \
		--author_url "https://github.com/pakkunbot" \
		--github_id "pakkunbot"
	cd stage/static-content/ && \
	  make ci

.PHONY: ci clean clean-static-redirect clean-static-content stage deps generate-static-redirect generate-static-content test-static-redirect test-static-content
