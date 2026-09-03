-- chunkname: @/tmp/or_script/lua_compile/dm/main.lua

if _G.GameConfigs == nil then
	_G.GameConfigs = {}
end

if app.args.userData == "REBOOT_NOUPDATE" then
	GameConfigs.noUpdate = true
end

if cc.Application:getInstance():getTargetPlatform() ~= 2 then
	local pid = cc.UserDefault:getInstance():getStringForKey("playerRid")

	dpsBugTracer.setUserId(pid or "")
end

if app.reboot then
	local reboot = app.reboot

	app.reboot = nil

	function REBOOT(...)
		trycall(function()
			if MemCacheUtils then
				MemCacheUtils:clear()
			end

			if dmAudio then
				dmAudio.destroy()
			end
		end)

		local director = cc.Director:getInstance()
		local runingScene = director:getRunningScene()

		if runingScene then
			runingScene:removeAllChildren()
		end

		director:popToRootScene()

		local winSize = director:getWinSize()

		runingScene = director:getRunningScene()

		if runingScene then
			local sprite = cc.Sprite:create("asset/scene/denglu_bg_new.jpg")

			if sprite then
				sprite:setPosition(cc.p(winSize.width / 2, winSize.height / 2))
				runingScene:addChild(sprite)
			end
		end

		local param = {
			...
		}

		local function rebootAction()
			if VideoSprite then
				VideoSprite.cleanVideoSprite()
			end

			reboot(unpack(param))
			director:popToRootScene()

			local scene = cc.Scene:create()

			director:replaceScene(scene)

			local sprite = cc.Sprite:create("asset/scene/denglu_bg_new.jpg")

			if sprite then
				sprite:setPosition(cc.p(winSize.width / 2, winSize.height / 2))
				scene:addChild(sprite)
			end
		end

		if runingScene then
			local delay = cc.DelayTime:create(0.016666666666666666)
			local sequence = cc.Sequence:create(delay, cc.CallFunc:create(rebootAction))

			runingScene:runAction(sequence)
		else
			rebootAction()
		end
	end
end

function cleanWriteableCache()
	local fileUtils = cc.FileUtils:getInstance()
	local writablePath = fileUtils:getWritablePath()
	local assetsDbPath = "assets.db"
	local gameConfigDbPath = "gameConfig.db"
	local extensionsDbPath = "extensions.db"
	local assetsSourceDirPath = "release"
	local patchDirPath = "patch"
	local writeableDbPath = writablePath .. assetsDbPath
	local writeableConfigDbPath = writablePath .. gameConfigDbPath
	local writeableExtensionsDbPath = writablePath .. extensionsDbPath
	local writeableSourceDirPath = writablePath .. assetsSourceDirPath
	local writeablePatchDirPath = writablePath .. patchDirPath

	fileUtils:removeFile(writeableDbPath)
	fileUtils:removeFile(writeableExtensionsDbPath)
	fileUtils:removeFile(writeableConfigDbPath)
	fileUtils:removeDirectory(writeableSourceDirPath)
	fileUtils:removeDirectory(writeablePatchDirPath)
	app.getPatchManager():switchPatch(tostring(0))
	REBOOT("cleanWriteableCache")
end

trycall(require, "cocos.init")
trycall(require, "cocos.cocos2d.Cocos2d")
trycall(require, "cocos.cocos2d.Cocos2dConstants")
trycall(require, "cocos.framework.display")
trycall(function()
	PlatformHelper = require("sdk.PlatformHelper")
end)
trycall(require, "dm.language")

function deleteExploreResouce()
	local fileList = require("asset.exploreMap.ExploreMap")
	local fileUtils = cc.FileUtils:getInstance()
	local writablePath = fileUtils:getWritablePath()
	local allKeys = {}

	for k, v in pairs(fileList) do
		allKeys[#allKeys + 1] = "asset/exploreMap/" .. k .. ".lua"
	end

	app.copyFile(writablePath .. "assets.db", writablePath .. "assets_temp.db")
	app.getAssetsManager():mergeDbBySQLString(writablePath .. "assets_temp.db", (string.format("DELETE FROM assets WHERE logic IN('%s');", table.concat(allKeys, "', '"))))
	fileUtils:renameFile(writablePath .. "assets_temp.db", writablePath .. "assets.db")
	print("sub exploremap resouce!!!!")
end

local target = cc.Application:getInstance():getTargetPlatform()

if target == cc.PLATFORM_OS_ANDROID then
	local current_v = app.getAssetsManager():getCurrentVersion()

	print("android current_v" .. current_v)

	if tonumber(current_v) > 6514 and tonumber(current_v) < 6694 then
		print("android platform")

		local LUA_EXCEPTION_FIXED = cc.UserDefault:getInstance():getBoolForKey("LUA_EXCEPTION_FIX", false)

		print("android LUA_EXCEPTION_FIXED" .. tostring(LUA_EXCEPTION_FIXED))

		if not LUA_EXCEPTION_FIXED then
			cc.UserDefault:getInstance():setBoolForKey("LUA_EXCEPTION_FIX", true)
			deleteExploreResouce()
			require("dm.UpdateNoticPopup").new():alert({
				title = "NOTIC",
				okBtnDes = "OK",
				msg = "Resources have been optimized for you, please restart the game!",
				callBack = function()
					print("exit game!!!")
					cc.Director:getInstance():endToLua()
				end
			})

			return
		end
	end
end

local fileUtils = cc.FileUtils:getInstance()
local writablePath = fileUtils:getWritablePath()
local unZipErrorMsg = {
	"The decompression file does not exist！",
	"The decompression file is damaged！",
	"There is not enough disk space. Clean up the disk space and try again！"
}
local DB_ERROR_NO_DISK_SPACE = "There is not enough disk space. Clean up the disk space and try again！"
local DB_ERROR_DATA_DAMAGE = "Data corruption, please reinstall the game, or clean the game storage data and try again!"
local DB_ERROR_MERGE_FAILED = "Data file merge failed, please reboot game and try again!"
local fileUtils = cc.FileUtils:getInstance()
local writablePath = fileUtils:getWritablePath()
local destDBFilePath = writablePath .. "gameConfig.db"
local backupDBPath = writablePath .. "gameConfig_backup.db"
local updateDBPath = fileUtils:fullPathForFilename("gameUpdateConfig.db")

function showError(errorMsg, callback)
	callback = callback or function()
		REBOOT()
	end
	errorMsg = errorMsg or ""

	local updateNoticPopup = require("dm.UpdateNoticPopup")

	updateNoticPopup:alert({
		msg = errorMsg,
		callBack = callBack
	})
end

function checkDBDamage(dbPath)
	local table, errorinfo = DBReader:getInstance(true):getTable(dbPath, "Translate")

	return table == nil, errorinfo
end

function isPatchDB(dbPath)
	local PATCH_FOLDER = "patch"
	local n, p = string.find(dbPath, writablePath .. PATCH_FOLDER)

	return n ~= nil
end

function copyDB(srcDB, dstDB)
	if not fileUtils:isFileExist(srcDB) then
		return false
	end

	app.copyFile(srcDB, dstDB)

	if not fileUtils:isFileExist(dstDB) then
		return false
	end

	if checkDBDamage(dstDB) then
		fileUtils:removeFile(dstDB)

		return false
	end

	return true
end

function mergeDB(originDB, updateDB)
	local errorInfo = DBReader:getInstance(true):mergeDb(originDB, updateDB)

	if #errorInfo == 0 then
		return true
	end

	return false
end

function backupDB()
	fileUtils:removeFile(backupDBPath)

	return copyDB(destDBFilePath, backupDBPath)
end

function rollbackDB()
	if fileUtils:isFileExist(backupDBPath) then
		fileUtils:removeFile(destDBFilePath)
		fileUtils:renameFile(backupDBPath, destDBFilePath)
	end

	return true
end

local UpdateDBCode = {
	kBackupErr = 1,
	kOk = 0,
	kCopyTempDBErr = 2,
	kMergeDBErr = 3
}

function updateDB()
	if isPatchDB(updateDBPath) and not backupDB() then
		return UpdateDBCode.kBackupErr
	end

	local tempUpdateDBPath = writablePath .. "gameConfig_temp.db"

	fileUtils:removeFile(tempUpdateDBPath)

	if not copyDB(destDBFilePath, tempUpdateDBPath) then
		return UpdateDBCode.kCopyTempDBErr
	end

	if not mergeDB(tempUpdateDBPath, updateDBPath) then
		fileUtils:removeFile(tempUpdateDBPath)

		return UpdateDBCode.kMergeDBErr
	end

	fileUtils:removeFile(destDBFilePath)
	fileUtils:renameFile(tempUpdateDBPath, destDBFilePath)
	fileUtils:removeFile(updateDBPath)

	return UpdateDBCode.kOk
end

function processConfigDBFile()
	if GameConfigs and GameConfigs.noUpdate then
		local isFileExistWritablePath = fileUtils:isFileExist(destDBFilePath)
		local localPath = fileUtils:fullPathForFilename("gameConfig.db")
		local isFileExistLocalPath = fileUtils:isFileExist(localPath)

		if cc.Application:getInstance():getTargetPlatform() == 3 and not isFileExistWritablePath and isFileExistLocalPath then
			app.copyFile(localPath, destDBFilePath)
		end

		return true
	end

	if not fileUtils:isFileExist(destDBFilePath) then
		local writableDBZipPath = writablePath .. "gameConfig.db.zip"

		fileUtils:removeFile(backupDBPath)
		fileUtils:removeFile(writableDBZipPath)

		local originDBZipPath = fileUtils:fullPathForFilename("gameConfig.db.zip")

		app.copyFile(originDBZipPath, writableDBZipPath)

		if not fileUtils:isFileExist(writableDBZipPath) then
			showError(DB_ERROR_NO_DISK_SPACE)

			return false
		end

		local unZipResult = app.unZipFileToDir(writableDBZipPath, writablePath)

		fileUtils:removeFile(writableDBZipPath)

		if unZipResult ~= 0 then
			fileUtils:removeFile(destDBFilePath)
			showError(unZipErrorMsg[unZipResult])

			return false
		end
	end

	if checkDBDamage(destDBFilePath) then
		fileUtils:removeFile(destDBFilePath)
		showError(DB_ERROR_DATA_DAMAGE)

		return false
	end

	if fileUtils:isFileExist(updateDBPath) then
		DBReader:getInstance(true)
		rollbackDB()

		local result = updateDB()

		if result == UpdateDBCode.kCopyTempDBErr then
			showError(DB_ERROR_NO_DISK_SPACE)

			return false
		elseif result == UpdateDBCode.kMergeDBErr then
			showError(DB_ERROR_MERGE_FAILED)

			return false
		end
	end

	return true
end

if not processConfigDBFile() then
	return
end

if not GameConfigs or not GameConfigs.noUpdate then
	require("dm.gameupdate.GameExtPackUpdater")
	require("dm.gameupdate.GameExtPackUpdaterManager")
	GameExtPackUpdater.initUpdateCfg()
end

trycall(require, "dm.init")

if cc.Application:getInstance():getTargetPlatform() ~= 2 then
	trycall(require, "sdk.SDKUtils")
end

trycall(function()
	require("dm.assets.dmAudio")
	dmAudio.startupWithAcfFile("sound/Sound_Basic/MengJingLianJie.acf")

	local fileUtils = cc.FileUtils:getInstance()
	local isFileExist = fileUtils:isFileExist("asset/sound/UI.acb")

	if dmAudio and dmAudio.loadAcbFile and isFileExist then
		dmAudio.loadAcbFile("common/UI")
	end

	if dmAudio and dmAudio.setAcbFileIsResident and isFileExist then
		dmAudio.setAcbFileIsResident("common/UI", true)
	end
end)

local function initLibs()
	require("foundation.init")
	require("dm.utils.StringUtils")
	require("dragon.init")
	require("dm.lateInit")
	require("dm.DmGame")
	require("dm.EventsConfig")
end

local function startGame()
	if DEBUG == 0 then
		function _G.dump()
			return
		end

		function _G.print()
			return
		end
	end

	initLibs()

	local game = DmGame:new()

	game:startup()
	game:switchToScene(GAME_STARTUP_SCENE or "launchScene")
end

local unzipScene, unzipView

local function unzipOBB(callback)
	require("dm.gameupdate.GameUnzip")

	local director = cc.Director:getInstance()
	local gameUnzip = GameUnzip:new()

	if gameUnzip:checkOBBFinish() then
		callback()

		return
	end

	local status, err = trycall(function()
		unzipScene = cc.Scene:create()

		director:replaceScene(unzipScene)
		require("dm.gameupdate.view.GameUnzipMediator")

		unzipView = GameUnzipMediator:new()

		unzipScene:addChild(unzipView:getView())

		local winSize = director:getWinSize()

		unzipView:getView():setPosition(winSize.width / 2 - CC_DESIGN_RESOLUTION.width / 2, winSize.height / 2 - CC_DESIGN_RESOLUTION.height / 2)
		unzipView:enterWithData({
			delegate = gameUnzip
		})

		return unzipView
	end)

	if not status then
		unzipView = nil
	end

	gameUnzip:setCallback(function(event)
		local status, ret

		if unzipView and unzipView.refresh then
			status, ret = trycall(function()
				unzipView:refresh(event)
			end)
		end
	end)
	gameUnzip:setFinishDelegate(callback)
	gameUnzip:run()
end

local nextStepFun
local playVideoOver = true
local scene, view

local function startUpdate()
	require("dm.gameupdate.GameUpdater")

	if GameConfigs and GameConfigs.noUnzipOBB then
		-- block empty
	else
		require("dm.gameupdate.GameUnzip")
		GameUnzip:checkOBBFinish()
	end

	local director = cc.Director:getInstance()
	local gameUpdater = GameUpdater:new()
	local status, err = trycall(function()
		scene = cc.Scene:create()

		director:replaceScene(scene)
		require("dm.gameupdate.view.GameUpdateMediator")

		view = GameUpdateMediator:new()

		scene:addChild(view:getView())

		local winSize = director:getWinSize()

		view:getView():setPosition(winSize.width / 2 - CC_DESIGN_RESOLUTION.width / 2, winSize.height / 2 - CC_DESIGN_RESOLUTION.height / 2)
		view:enterWithData({
			gameUpdater = gameUpdater
		})

		return view
	end)

	if not status then
		view = nil
	end

	gameUpdater:setCallback(function(event)
		local status, ret

		if view and view.refreshGameUpdate then
			status, ret = trycall(function()
				view:refreshGameUpdate(event)
			end)
		end

		local data = event.data

		if event.type == "updateFinish" then
			function nextStepFun()
				view = nil

				REBOOT()
			end

			if playVideoOver then
				local func = nextStepFun

				nextStepFun = nil

				func()
			end
		elseif event.type == "noUpdate" then
			if data ~= nil and data == true then
				REBOOT()
			else
				function nextStepFun()
					view = nil

					if GameConfigs and GameConfigs.noUnzipOBB then
						startGame()
					else
						unzipOBB(function()
							startGame()
						end)
					end
				end

				if playVideoOver then
					local func = nextStepFun

					nextStepFun = nil

					func()
				end
			end
		elseif event.type == "ensureUpdate" then
			local netStatus = app.getDevice():getNetworkStatus()

			if netStatus ~= NetStatus.kWWAN then
				gameUpdater:excuteUpdateCmd(event.vmsData)
			end
		end

		if not status then
			if event.type == "forceupdate" then
				app.showMessageBox("Please update the client to the newest version", "Need Update")
			elseif event.type == "ensureUpdate" then
				local netStatus = app.getDevice():getNetworkStatus()

				if netStatus == NetStatus.kWWAN then
					app.showMessageBox("Please connect to Wifi and try again!", "Need Update")
				end
			end
		end
	end)

	local function callback()
		return
	end

	gameUpdater:run(callback)
end

local function main()
	if GameConfigs and GameConfigs.noUpdate then
		if GameConfigs and GameConfigs.noUnzipOBB then
			startGame()
		else
			unzipOBB(function()
				startGame()
			end)
		end

		return
	end

	startUpdate()
end

local function showLogo()
	if not _G.delayCallByTime then
		local function delayCallByTime(delayMilliseconds, func, ...)
			local callFunc = func
			local arglist = {
				n = select("#", ...),
				...
			}
			local animTickEntry

			local function timeUp(time)
				if animTickEntry ~= nil then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(animTickEntry)

					animTickEntry = nil

					if arglist ~= nil and arglist.n > 0 then
						callFunc(unpack(arglist, 1, arglist.n))
					else
						callFunc()
					end
				end
			end

			local delay = (delayMilliseconds or 0) * 0.001

			animTickEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(timeUp, delay, false)

			return animTickEntry
		end

		local winSize = cc.Director:getInstance():getWinSize()

		local function showFuncVideo(currentScene, path, cb)
			require("dm.utils.VideoSprite")

			local video = VideoSprite.create(path, function(instance, eventName, index)
				if eventName == "complete" then
					instance:getPlayer():pause(true)
					cb()
				end
			end)

			video:addTo(currentScene)

			scale = 1
			videoSize = cc.size(winSize.width, winSize.height)
			videoPos = cc.p(585, 447)

			video:setContentSize(videoSize)
			video:setPosition(winSize.width / 2, winSize.height / 2)
		end

		local function showFuncImage(currentScene, path, cb)
			local logoImg = cc.Sprite:create(path)

			logoImg:setOpacity(0)
			logoImg:setPosition(cc.p(winSize.width / 2, winSize.height / 2))
			currentScene:addChild(logoImg)

			local fadeInAct = cc.FadeIn:create(1)
			local delayTimeAct = cc.DelayTime:create(1)

			local function endFunc()
				delayCallByTime(0, function()
					cb()
				end)
			end

			local callFuncAct1 = cc.CallFunc:create(endFunc)
			local action = cc.Sequence:create(fadeInAct, delayTimeAct, callFuncAct1)

			logoImg:runAction(action)
		end

		local function showFunc(path, cb)
			local backgroundColor = cc.c4b(255, 255, 255, 255)
			local director = cc.Director:getInstance()
			local currentScene = cc.Scene:create()

			if director:getRunningScene() then
				director:replaceScene(currentScene)
			else
				director:runWithScene(currentScene)
			end

			local winSize = director:getWinSize()
			local backgroundLayer = cc.LayerColor:create(backgroundColor, winSize.width, winSize.height)

			currentScene:addChild(backgroundLayer)

			local suffix = string.sub(path, -3)

			if suffix == "usm" then
				showFuncVideo(currentScene, path, cb)
			else
				showFuncImage(currentScene, path, cb)
			end
		end

		local logoImgPath = "asset/scene/lanuch.png"
		local logoImgPath_def = "asset/scene/lanuch_tiantian.png"

		if cc.FileUtils:getInstance():isFileExist(logoImgPath) then
			showFunc(logoImgPath, function()
				if cc.FileUtils:getInstance():isFileExist(logoImgPath_def) then
					showFunc(logoImgPath_def, function()
						main()
					end)
				else
					main()
				end
			end)
		elseif cc.FileUtils:getInstance():isFileExist(logoImgPath_def) then
			showFunc(logoImgPath_def, function()
				main()
			end)
		else
			main()
		end
	end
end

local success, err

if app.args.bootTimes == 1 then
	success, err = trycall(function()
		require("cocos.cocos2d.Cocos2d")
		showLogo()
	end)
end

if not success then
	main()
end
