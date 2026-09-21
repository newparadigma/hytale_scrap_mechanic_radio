zip:
	@rm -f ScrapMechanicRadio.zip
	@cd ScrapMechanicRadio && zip -rq ../ScrapMechanicRadio.zip . -x '*.DS_Store'
