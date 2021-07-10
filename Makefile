REACH = reach

.PHONY: clean
clean:
	rm -rf build/*.main.mjs

build/%.main.mjs: %.rsh
	$(REACH) compile $^

.PHONY: build
build: build/index.main.mjs
	docker build -f Dockerfile --tag=reachsh/reach-app-91c8035dadd9c7f489c25b392b8ac2675e77602cebd2f91fca268bff56f94ccc:latest .

.PHONY: run
run:
	$(REACH) run index

.PHONY: run-target
run-target: build
	docker-compose -f "docker-compose.yml" run --rm reach-app-91c8035dadd9c7f489c25b392b8ac2675e77602cebd2f91fca268bff56f94ccc-$${REACH_CONNECTOR_MODE} $(ARGS)

.PHONY: down
down:
	docker-compose -f "docker-compose.yml" down --remove-orphans
.PHONY: run-alice
run-alice:
	docker-compose run --rm alice

.PHONY: run-bob
run-bob:
	docker-compose run --rm bob