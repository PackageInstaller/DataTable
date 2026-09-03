-- chunkname: @/tmp/or_script/lua_compile/dm/gameupdate/view/GameUpdateMediator.lua

trycall(function()
	device = require("cocos.framework.device")
end)
trycall(require, "cocos.framework.extends.NodeEx")
trycall(require, "foundation.ccext.CCLayoutUtil")
trycall(require, "foundation.ccext.CCUIExtends")
trycall(require, "dm.base.waiting.WaitingView")
trycall(require, "dm.utils.AdjustUtils")
trycall(require, "dm.assets.DataReader")
trycall(require, "dm.assets.ConfigReader")
trycall(require, "dragon.misc.TextTemplate")
trycall(require, "dm.assets.Strings")
trycall(require, "dm.assets.Constants")

local UpdateGame = {}
local cjson = require("cjson.safe")

function UpdateGame:appWillResignActive()
	print("UpdateGame")
	print("[info]", "appWillResignActive")
	trycall(function()
		if dmAudio then
			dmAudio.pauseAll()
		end

		cri.suspendLibraryContext()
	end)
end

function UpdateGame:appDidBecomeActive()
	print("UpdateGame")
	print("[info]", "appDidBecomeActive")
	trycall(function()
		if dmAudio then
			dmAudio.resumeAll()
		end

		cri.resumeLibraryContext()
	end)
end

function UpdateGame:appDidEnterBackground()
	print("UpdateGame")
	print("[info]", "appDidEnterBackground")
	trycall(function()
		if dmAudio then
			dmAudio.pauseAll()
		end

		cri.suspendLibraryContext()
	end)
end

function UpdateGame:appWillEnterForeground()
	print("UpdateGame")
	print("[info]", "appWillEnterForeground")
	trycall(function()
		if dmAudio then
			dmAudio.resumeAll()
		end

		cri.resumeLibraryContext()
	end)
end

function UpdateGame:appWillTerminate()
	print("UpdateGame")
	print("[info]", "appWillTerminate")
end

function UpdateGame:didReceiveMemoryWarning()
	print("UpdateGame")
	print("[info]", "didReceiveMemoryWarning")
end

function UpdateGame:resolveStringContent(strid)
	print("UpdateGame get string:", strid)

	return Strings:get(strid)
end

GameUpdateMediator = GameUpdateMediator or {}
GameUpdateMediator.Strings = Strings

function GameUpdateMediator:new()
	local result = setmetatable({}, {
		__index = GameUpdateMediator
	})

	result:initialize()

	if not DmGame then
		app.setLuaAppDelegate(UpdateGame)
	end

	return result
end

local resId = "asset/ui/gameUpdateUI.csb"

function GameUpdateMediator:initialize()
	self._view = cc.CSLoader:createNode(resId)
	self._totalBytesExpected = 0
	self._pkgsDownloadData = {}
	self._effectLayer = cc.Node:create()

	self._effectLayer:setPosition(568, 320)
	self._view:addChild(self._effectLayer, 1001)
end

function GameUpdateMediator:getView()
	return self._view
end

function GameUpdateMediator:setVisible(visible)
	self._view:setVisible(visible)
end

function GameUpdateMediator:enterWithData(data)
	self:initMember()

	self._gameUpdater = data.gameUpdater
end

function GameUpdateMediator:dismiss()
	self._view:removeFromParent()
end

function GameUpdateMediator:initMember()
	self._tagText = self:getView():getChildByFullName("main.progress_tag")
	self._progressText = self:getView():getChildByFullName("main.progress_text")
	self._curVersion = self:getView():getChildByFullName("main.info_text_0")
	self._curPackVersion = self:getView():getChildByFullName("main.info_text_1_0")
	self._vmsUrl = self:getView():getChildByFullName("main.info_text_1_0_1")

	if self._curVersion and app and app.getAssetsManager then
		local curVersionCode = app:getAssetsManager():getCurrentVersion()

		self._curVersion:setString(tostring(curVersionCode))
	end

	if self._vmsUrl and self._curPackVersion and app and app.pkgConfig and app.pkgConfig.captainUrl and app.pkgConfig.packJobId then
		self._curPackVersion:setString(tostring(app.pkgConfig.packJobId))
		self._vmsUrl:setString(tostring(app.pkgConfig.captainUrl))
	end
end

function GameUpdateMediator:refreshGameUpdate(event)
	local data = event

	if data.type == "noUpdate" then
		self:launchLoading()
	elseif data.type == "forceupdate" then
		self:launchLoading()

		local content = ""

		content = device.platform == "ios" and Strings:get("UPDATE_UI3") or Strings:get("UPDATE_UI4")

		self:showAlertView({
			title = Strings:get("UPDATE_UI2"),
			title1 = Strings:get("UITitle_EN_Gengxintishi"),
			content = content,
			sureBtn = {
				btnText = Strings:get("UPDATE_UI5")
			},
			okCallback = function()
				PlatformHelper:thirdUpdate()
			end
		})
		self:showForceUpdate()
	elseif data.type == "updateFinish" then
		if self._loadingWidget then
			self._loadingWidget = nil
		end

		self:dismiss()
	elseif data.type == "downloadError" then
		local tips = "UPDATE_UI8"

		self:showAlertView({
			title = Strings:get("UPDATE_UI7"),
			title1 = Strings:get("UITitle_EN_Tishi"),
			content = Strings:get(tips) .. ((data.data and data.data.errorCodeInternal and data.data.errorStr or nil) and "\n(" .. tostring(data.data.errorCodeInternal) .. ":" .. tostring(data.data.errorStr) .. ")"),
			sureBtn = {},
			okCallback = function()
				REBOOT()
			end
		})
	elseif data.type == "vmsRequestError" then
		self:launchLoading()

		if data.data and data.data.status == 408 or data.data and data.data.status == 0 then
			self:showAlertView({
				title = Strings:get("UPDATE_UI7"),
				title1 = Strings:get("UITitle_EN_Tishi"),
				content = Strings:get("UPDATE_UI1"),
				sureBtn = {
					btnText = Strings:get("Common_button5")
				},
				okCallback = function()
					REBOOT()
				end
			})
		else
			self:showAlertView({
				title = Strings:get("UPDATE_UI7"),
				title1 = Strings:get("UITitle_EN_Tishi"),
				content = Strings:get("UPDATE_UI8"),
				sureBtn = {},
				okCallback = function()
					REBOOT()
				end
			})
		end
	elseif data.type == "maintain" then
		local notice = cjson.decode(data.notice)
		local content = notice[getCurrentLanguage()] or notice.en

		content = content or ""

		self:launchLoading()
		self:showAlertView({
			title = Strings:get("UPDATE_UI6"),
			title1 = Strings:get("UITitle_EN_Tishi"),
			content = content,
			sureBtn = {},
			okCallback = function()
				REBOOT()
			end
		})
	elseif data.type == "ensureUpdate" then
		self:launchLoading()

		local netStatus = app.getDevice():getNetworkStatus()

		self._totalBytesExpected = data.size

		if netStatus == NetStatus.kWWAN then
			self:showAlertView({
				title = Strings:get("UPDATE_UI2"),
				title1 = Strings:get("UITitle_EN_Gengxintishi"),
				content = Strings:get("UPDATE_UI11", {
					size = self:formatBytes(data.size - data.totalBytesReceived),
					fontName = TTF_FONT_FZYH_R
				}),
				sureBtn = {},
				cancelBtn = {},
				okCallback = function()
					self._gameUpdater:excuteUpdateCmd(data.vmsData)
				end,
				cancelCallback = function()
					REBOOT()
				end
			})
		end
	elseif data.type == "vmsState" then
		if data.state == kVMSState.kVmsStart then
			-- block empty
		elseif data.state == kVMSState.kVmsEnded then
			-- block empty
		end
	elseif data.type == "downloading" then
		local downloadData = data.data
		local pkgDownloadData = self._pkgsDownloadData[downloadData.task.storagePath]

		pkgDownloadData.bytesReceived = downloadData.bytesReceived
		pkgDownloadData.totalBytesReceived = downloadData.totalBytesReceived
		pkgDownloadData.totalBytesExpected = downloadData.totalBytesExpected

		self:launchLoading(data.data)
	elseif data.type == "installPackage" then
		local event = data.data.event

		if event == "started" then
			if self._updateTips then
				self._updateTips:setString(Strings:get("UPDATE_UI23", {
					fontName = TTF_FONT_FZYH_R,
					content = Strings:get("UPDATE_UI21")
				}))
			end
		elseif event == "failed" then
			self:showAlertView({
				title = Strings:get("UPDATE_UI7"),
				title1 = Strings:get("UITitle_EN_Tishi"),
				content = Strings:get("UPDATE_UI22"),
				sureBtn = {},
				okCallback = function()
					REBOOT()
				end
			})
		end
	elseif data.type == "updateError" then
		self:showAlertView({
			title = Strings:get("UPDATE_UI7"),
			title1 = Strings:get("UITitle_EN_Tishi"),
			content = "updateError" .. Strings:get("UPDATE_UI8"),
			sureBtn = {},
			okCallback = function()
				REBOOT()
			end
		})
	elseif data.type == "downloadStart" then
		local downloadData = data.data

		self._pkgsDownloadData[downloadData.task.storagePath] = {}
	end
end

function GameUpdateMediator:formatBytes(data)
	local num = data / 1024

	num = num >= 1024 and string.format("%.1fM", num / 1024) or string.format("%.1fK", num)

	return num
end

function GameUpdateMediator:randomLoadingView()
	local LoadingWidgetMap
	local status = trycall(function()
		LoadingWidgetMap = require("dm.gameupdate.view.GameUpdateLoadingWidget")
	end)

	if not status or not LoadingWidgetMap then
		print("require LoadingWidget Error:", LoadingWidgetMap)

		return nil
	end

	local loadingList = {
		"GUIDENEWBEE"
	}

	if #loadingList > 0 then
		local index = math.random(1, #loadingList)
		local widget = LoadingWidgetMap[loadingList[index]]

		if widget then
			return widget:new(self:getView())
		end
	end

	print("require LoadingWidget Error", LoadingWidgetMap)

	return nil
end

function GameUpdateMediator:launchLoading(data)
	if self._loadingWidget == nil then
		local loadingWidget = self:randomLoadingView()

		if not loadingWidget then
			return
		end

		loadingWidget:getView():addTo(self:getView())
		loadingWidget:setupView()
		loadingWidget:onProgress(nil, 0)

		local bottom = loadingWidget:getView():getChildByFullName("bottom")
		local changeTips = bottom:getChildByFullName("changeTips")

		changeTips:setVisible(false)

		local updateTips = ccui.RichText:createWithXML("", {})

		updateTips:ignoreContentAdaptWithSize(true)
		updateTips:rebuildElements()
		updateTips:formatText()
		updateTips:setAnchorPoint(cc.p(0.5, 0.5))
		updateTips:renderContent()

		local x, y = changeTips:getPosition()

		self._yPos = y

		updateTips:addTo(changeTips:getParent()):posite(changeTips:getPosition())

		self._updateTips = updateTips

		local curVersion = app:getAssetsManager():getCurrentVersion()
		local curVersionText = ccui.RichText:createWithXML(Strings:get("UPDATE_UI15", {
			version = curVersion,
			fontName = TTF_FONT_FZYH_R
		}), {})

		curVersionText:setAnchorPoint(cc.p(0, 0.5))
		curVersionText:addTo(bottom):posite(36, self._yPos - 20)

		self._loadingWidget = loadingWidget

		bottom:getChildByFullName("loading.node_pro"):setVisible(false)
	end

	local loadingWidget = self._loadingWidget
	local bottom = loadingWidget:getView():getChildByFullName("bottom")
	local targetVersion = self._gameUpdater:getTargetVersion()

	if targetVersion ~= 0 and (loadingWidget.targetVersion == nil or loadingWidget.targetVersion ~= targetVersion) then
		bottom:removeChildByName("targetVersion")

		local targetVersionText = ccui.RichText:createWithXML(Strings:get("UPDATE_UI16", {
			version = targetVersion,
			fontName = TTF_FONT_FZYH_R
		}), {})

		targetVersionText:setAnchorPoint(cc.p(1, 0.5))
		targetVersionText:addTo(bottom):posite(1100, self._yPos - 20)
		targetVersionText:setName("targetVersion")

		loadingWidget.targetVersion = targetVersion
	end

	if data then
		local current = 0
		local total = self._totalBytesExpected

		for k, v in pairs(self._pkgsDownloadData) do
			current = current + (v.totalBytesReceived or 0)
		end

		local percent = current / math.max(total, 1)

		self._loadingWidget:onProgress(nil, percent)

		local bottom = self._loadingWidget:getView():getChildByFullName("bottom")
		local netStatus = app.getDevice():getNetworkStatus()
		local var_33_1 = "UPDATE_UI12"
		local var_33_2 = {
			fontName = TTF_FONT_FZYH_R,
			totalByte = self:formatBytes(total)
		}

		if netStatus == NetStatus.kWifi then
			var_33_2.status = Strings:get("UPDATE_UI13") or Strings:get("UPDATE_UI14")
		end

		var_33_2.progress = self:formatBytes(current) .. "/" .. self:formatBytes(total)

		self._updateTips:setString(Strings:get(var_33_1, var_33_2))
	end
end

function GameUpdateMediator:showWaiting()
	print("GameUpdateMediator:showWaiting")
	WaitingView:getInstance():show(WaitingStyle.kLoadingAndTip, {
		noAction = true,
		delay = 200,
		tip = Strings:get("WAITING_CONNECTING")
	})
end

function GameUpdateMediator:hideWaiting()
	print("GameUpdateMediator:hideWaiting")
	WaitingView:getInstance():hide()
end

local UpdateAlertView

function GameUpdateMediator:showAlertView(data)
	print("GameUpdateMediator:showAlertView")

	UpdateAlertView = UpdateAlertView or require("dm.gameupdate.view.UpdateAlertView")

	if UpdateAlertView then
		data.isRich = true
		data.noClose = true
		data.bgType = 2

		if not data.content then
			local text = ""
			local textData = string.split(text, "<font")

			if #textData <= 1 then
				data.content = Strings:get("UPDATE_UI9", {
					text = text,
					fontName = TTF_FONT_FZYH_R
				})
			end

			local alertDelegate = {}

			function alertDelegate:willClose(view, info)
				if info.response == UpdateAlertResponse.kOK then
					if data.okCallback then
						data.okCallback()
					end
				elseif data.cancelCallback then
					data.cancelCallback()
				end
			end

			local alertView = UpdateAlertView:new()

			self:getView():addChild(alertView:getView(), 10)
			alertView:setDelegate(alertDelegate)
			alertView:enterWithData(data)
		end
	end
end

local UpdateToast

function GameUpdateMediator:showForceUpdate()
	print("GameUpdateMediator:showForceUpdate")

	UpdateToast = UpdateToast or require("dm.gameupdate.view.UpdateToast")

	if UpdateToast then
		local toast = UpdateToast:new(Strings:get("FORCE_UPDATE"))

		self:showToast(toast, {})
	end
end

function GameUpdateMediator:showToast(toast, options)
	if toast == nil then
		return
	end

	local winSize = cc.Director:getInstance():getWinSize()

	if self._activeToasts == nil then
		self._activeToasts = {}
	end

	local layer = self._effectLayer

	if not toast:setup(layer, options) then
		return
	end

	for i, v in pairs(self._activeToasts) do
		local view = v:getView()

		view:setPositionY(view:getPositionY() + toast:getView():getContentSize().height)

		if view:getPositionY() > winSize.height * 0.5 - 20 then
			view:setVisible(false)
		end

		local action = view:getActionByTag(101)

		if action then
			action:setSpeed(action:getSpeed() * 2)
		end
	end

	self._activeToasts[toast] = toast

	toast:startAnimation(function(theToast)
		self._activeToasts[theToast] = nil

		if toastsInTheGroup ~= nil then
			for i = 1, #toastsInTheGroup do
				if toastsInTheGroup[i] == theToast then
					table.remove(toastsInTheGroup, i)

					break
				end
			end
		end

		theToast:dispose()
	end)
end
