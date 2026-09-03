-- chunkname: @/tmp/or_script/lua_compile/dm/gameupdate/view/GameUnzipMediator.lua

trycall(function()
	device = require("cocos.framework.device")
end)
trycall(require, "cocos.framework.extends.NodeEx")
trycall(require, "foundation.ccext.CCLayoutUtil")
trycall(require, "foundation.ccext.CCUIExtends")
trycall(require, "dm.utils.AdjustUtils")
trycall(require, "dm.assets.DataReader")
trycall(require, "dm.assets.ConfigReader")
trycall(require, "dragon.misc.TextTemplate")
trycall(require, "dm.assets.Strings")
trycall(require, "dm.assets.Constants")

local UnzipGame = {}

function UnzipGame:appWillResignActive()
	print("[info]", "appWillResignActive")
	trycall(function()
		if dmAudio then
			dmAudio.pauseAll()
		end

		cri.suspendLibraryContext()
	end)
end

function UnzipGame:appDidBecomeActive()
	print("[info]", "appDidBecomeActive")
	trycall(function()
		if dmAudio then
			dmAudio.resumeAll()
		end

		cri.resumeLibraryContext()
	end)
end

function UnzipGame:appDidEnterBackground()
	print("[info]", "appDidEnterBackground")
	trycall(function()
		if dmAudio then
			dmAudio.pauseAll()
		end

		cri.suspendLibraryContext()
	end)
end

function UnzipGame:appWillEnterForeground()
	print("[info]", "appWillEnterForeground")
	trycall(function()
		if dmAudio then
			dmAudio.resumeAll()
		end

		cri.resumeLibraryContext()
	end)
end

function UnzipGame:appWillTerminate()
	print("[info]", "appWillTerminate")
end

function UnzipGame:didReceiveMemoryWarning()
	print("[info]", "didReceiveMemoryWarning")
end

function UnzipGame:resolveStringContent(strid)
	return Strings:get(strid)
end

GameUnzipMediator = GameUnzipMediator or {}
GameUnzipMediator.Strings = Strings

function GameUnzipMediator:new()
	local result = setmetatable({}, {
		__index = GameUnzipMediator
	})

	result:initialize()

	if not DmGame then
		app.setLuaAppDelegate(UnzipGame)
	end

	return result
end

local resId = "asset/ui/gameUnzipOBB.csb"

function GameUnzipMediator:initialize()
	self._view = cc.CSLoader:createNode(resId)
	self._curProgress = 0
	self._effectLayer = cc.Node:create()

	self._effectLayer:setPosition(568, 320)
	self._view:addChild(self._effectLayer, 1001)
end

function GameUnzipMediator:getView()
	return self._view
end

function GameUnzipMediator:setVisible(visible)
	self._view:setVisible(visible)
end

function GameUnzipMediator:enterWithData(data)
	self._delegate = data.delegate
	self._enterGameDirect = true

	self:launchLoading()
end

function GameUnzipMediator:dismiss()
	self._view:removeFromParent()

	if self._timeSchedule then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._timeSchedule)

		self._timeSchedule = nil
	end

	self._curProgress = 0
end

function GameUnzipMediator:refresh(event)
	if event.type == "success" then
		self:playLoadingToEnd()
	elseif event.type == "unziping" then
		self._enterGameDirect = false

		self:playLoading()
	elseif event.type == "failed" then
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
end

function GameUnzipMediator:randomLoadingView()
	local LoadingWidgetMap
	local status = trycall(function()
		LoadingWidgetMap = require("dm.gameupdate.view.GameUpdateLoadingWidget")
	end)

	if not status or not LoadingWidgetMap then
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

	return nil
end

function GameUnzipMediator:launchLoading()
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

		changeTips:setVisible(true)
		changeTips:setString(Strings:get("UPDATE_UI24"))

		self._loadingWidget = loadingWidget

		bottom:getChildByFullName("loading.node_pro"):setVisible(false)
	end
end

function GameUnzipMediator:playLoading()
	local function update(time)
		if self._loadingWidget and self._curProgress <= 0.75 then
			self._curProgress = self._curProgress + 0.015

			self._loadingWidget:onProgress(nil, self._curProgress)
		else
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._timeSchedule)

			self._timeSchedule = nil
		end
	end

	self._timeSchedule = self._timeSchedule or cc.Director:getInstance():getScheduler():scheduleScriptFunc(update, 0.1, false)
end

function GameUnzipMediator:playLoadingToEnd()
	if self._enterGameDirect then
		self._delegate:excuteFinishCmd()

		return
	end

	local curProgress = self._curProgress

	local function update(time)
		if self._loadingWidget and self._curProgress <= 1 then
			self._curProgress = self._curProgress + (1 - curProgress) / 10

			self._loadingWidget:onProgress(nil, math.min(self._curProgress, 1))
		else
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._timeSchedule)

			self._timeSchedule = nil

			self._delegate:excuteFinishCmd()
		end
	end

	if self._timeSchedule then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._timeSchedule)

		self._timeSchedule = nil
	end

	self._timeSchedule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(update, 0.1, false)
end

local UpdateAlertView

function GameUnzipMediator:showAlertView(data)
	if not UpdateAlertView then
		require("dm.gameupdate.view.GameUpdateMediator")

		UpdateAlertView = require("dm.gameupdate.view.UpdateAlertView")
	end

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

function GameUnzipMediator:showToast(toast, options)
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
