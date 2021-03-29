pkg="net.julianchu.applinktest"
launchActivity="net.julianchu.applinktest.MainActivity"
view_param="-a android.intent.action.VIEW -c android.intent.category.BROWSABLE"

.PHONY: all
all: dev
	@echo "Done"

.PHONY: check
check:
	adb shell dumpsys package d |tr -d '\n' |sed $'s/Package/\\\nPackage/g' |grep net.julianchu.applinktest |sed $'s/Domain/\\\nDomain/' |sed $'s/Status/\\\nStatus/'

.PHONY: test
test:
	adb shell am start $(view_param) -d "https://applinks.cmds.dev"

.PHONY: test2
test2:
	adb shell am start $(view_param) -d "https://secondapplinks.cmds.dev"

.PHONY: logcat
logcat:
	adb logcat |grep IntentFilterIntentOp

.PHONY: clean
clean:
	./gradlew clean

### use dev variant by default ###

.PHONY: install
install: devInstall

.PHONY: launch
launch: devLaunch

.PHONY: uninstall
uninstall:
	adb uninstall $(pkg)

.PHONY: remove
remove: uninstall

#### dev build ####
.PHONY: dev
dev: devBuild devInstall devLaunch

.PHONY: devBuild
devBuild:
	./gradlew :app:packageDebug

.PHONY: devInstall
devInstall:
	adb install -r app/build/outputs/apk/debug/app-debug.apk

.PHONY: devLaunch
devLaunch:
	adb shell am start -n $(pkg)/$(launchActivity)

