prefix ?= /usr

.PHONY: clean build vendor

build:
	rm -rf vendor
	tar pxf vendor.tar
	cargo build --release --frozen --offline

clean:
	cargo clean

install:
	install -Dm0755 target/release/bindgen "$(DESTDIR)/$(prefix)/bin/bindgen"

vendor:
	mkdir -p .cargo
	cargo vendor | head -n -1 > .cargo/config.toml
	echo 'directory = "vendor"' >> .cargo/config.toml
	tar pcf vendor.tar vendor
	rm -rf vendor

