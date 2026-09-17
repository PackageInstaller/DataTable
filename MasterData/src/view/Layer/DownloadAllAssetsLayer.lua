DownloadAllAssetsLayer = class("DownloadAllAssetsLayer", function()
	return cc.Layer:create()
end)

local download_all_resource_helper = require("controller.filedownloader.download_all_resource_helper")
local TempWidget = require("view.Sprite.TempWidget")
local assets_ui_manager = require("controller.assets_ui_manager")
local login_bg_manager = require("controller.login_bg_manager")
local var_0_4 = 1073741824
local var_0_5 = 1048576
local var_0_6 = 1024
local var_0_7 = {
	bar = "update/upgrade.png",
	dialogbox = "update/box.png",
	loadsp = "update/sp.png",
	surebtnoff = "update/button_off.png",
	bg = "mainScenebg/loginBG.jpg",
	loadingbg = "update/load.png",
	surebtnpressed = "update/button_on.png",
	surebtnnormal = "update/button.png",
	barbg = "update/upgrade_background.png"
}

function DownloadAllAssetsLayer.create(arg_2_0)
	local var_2_0 = DownloadAllAssetsLayer.new()

	var_2_0:init()

	return var_2_0
end

function DownloadAllAssetsLayer:init()
	local var_3_0 = ccui.Layout:create()

	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setTouchEnabled(true)
	self:addChild(var_3_0)

	self._downloadinglist = {}
	self._filelist = {}
	self._totalsize = 0

	self:initUI()
	self:initEventListener()
	self:startCheck()
end

function DownloadAllAssetsLayer:initUI()
	local var_4_0, var_4_1 = login_bg_manager:getLoginBg()

	self:addChild(var_4_0, 1)
	self:addChild(var_4_1)

	local var_4_2 = cc.Sprite:create(var_0_7.loadingbg)

	var_4_2:setAnchorPoint(cc.p(0.5, 0))
	var_4_2:setPosition(cc.p(320, 0))
	self:addChild(var_4_2, 1)

	self.barbg = TempWidget:CreateTempLayout()

	self.barbg:setAnchorPoint(cc.p(0.5, 0))
	self.barbg:setContentSize(cc.size(GameDisplay.width, 14))
	self.barbg:setPosition(cc.p(var_4_2:getContentSize().width / 2, var_4_2:getContentSize().height - 5))
	var_4_2:addChild(self.barbg, 1)

	self.bar = cc.ProgressTimer:create(cc.Sprite:create(var_0_7.bar))

	self.bar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.bar:setBarChangeRate(cc.p(1, 0))
	self.bar:setMidpoint(cc.p(0, 0))
	self.bar:setAnchorPoint(cc.p(0.5, 0.5))
	self.bar:setPosition(cc.p(self.barbg:getContentSize().width / 2, self.barbg:getContentSize().height / 2))
	self.barbg:addChild(self.bar, 2)
	self.bar:setPercentage(0)

	self.loadSp = cc.Sprite:create(var_0_7.loadsp)

	self.loadSp:setPosition(cc.p(self.barbg:getContentSize().width * 0 / 100, self.barbg:getContentSize().height / 2))
	self.barbg:addChild(self.loadSp, 3)

	self.updateInfo = cc.Label:createWithTTF("正在检查资源...", "fonts/number.ttf", 18)

	self.updateInfo:setAnchorPoint(cc.p(0.5, 0))
	self.updateInfo:setPosition(cc.p(var_4_2:getContentSize().width / 2, 18))
	var_4_2:addChild(self.updateInfo, 3)

	local var_4_3 = assets_ui_manager:getLoadAni()

	self.ani = sp.SkeletonAnimation:create(var_4_3 .. ".json", var_4_3 .. ".atlas", 1)

	self.ani:setPosition(cc.p(self.barbg:getContentSize().width * 0 / 100, self.barbg:getContentSize().height))
	self.barbg:addChild(self.ani, 4)
	self.ani:setAnimation(0, "run", true)
end

function DownloadAllAssetsLayer:registerCustomEvent(arg_5_1, arg_5_2)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create(arg_5_1, arg_5_2), self)
end

function DownloadAllAssetsLayer:initEventListener()
	self:registerCustomEvent("CHECK_DOWNLOAD_RESOURCE_COMPLETE", function(arg_7_0)
		self:onCheckComplete()
	end)
	self:registerCustomEvent("DOWNLOAD_EVENT_COMPLETE", function(arg_8_0)
		if self._downloadinglist[arg_8_0.fileName] then
			self._downloadinglist[arg_8_0.fileName] = nil
			self._downloaded = self._downloaded + 1

			self:onDownloadProgress()

			if not next(self._downloadinglist) then
				self:onDownloadComplete()
			end
		end
	end)
end

function DownloadAllAssetsLayer.startCheck(arg_9_0)
	download_all_resource_helper:checkResource()
end

function DownloadAllAssetsLayer:onCheckComplete()
	local var_10_0 = download_all_resource_helper:getDownloadList()
	local var_10_1 = download_all_resource_helper:getDownloadSize()

	if var_10_1 == 0 then
		self:noNeedDownload()

		return
	end

	self._filelist = var_10_0
	self._totalsize = var_10_1
	self._totalcount = #var_10_0
	self._downloaded = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		self._downloadinglist[iter_10_1.filename] = iter_10_1.size
	end

	local var_10_3 = string.format("是否下载完整资源(%s)", self._totalsize >= 1 * var_0_4 and string.format("%.1fGB", self._totalsize / var_0_4) or self._totalsize >= 1 * var_0_5 and string.format("%.1fMB", self._totalsize / var_0_5) or self._totalsize >= 1 * var_0_6 and string.format("%.1fKB", self._totalsize / var_0_6) or string.format("%dB", self._totalsize))

	require("view.Layer.DialogLayer")
	self:addChild(DialogLayer:create(L_LOGOUT_MSG[5].Title, var_10_3, 500, 250, function()
		self:startDownload()
	end, function()
		self:runAction(cc.RemoveSelf:create())
	end, true), 10001)
end

function DownloadAllAssetsLayer:startDownload()
	require("controller.filedownloader.download_manager"):insertManualDownloadPool(self._filelist)
end

function DownloadAllAssetsLayer:onDownloadProgress()
	if self._downloaded >= self._totalcount then
		self.updateInfo:setString("下载成功")
	else
		local var_14_0 = math.floor(self._downloaded * 100 / self._totalcount)

		self.updateInfo:setString(string.format("正在下载资源(%d%%)", var_14_0))
		self.bar:setPercentage(var_14_0)
		self.loadSp:setPosition(cc.p(self.barbg:getContentSize().width * var_14_0 / 100, self.barbg:getContentSize().height / 2))
		self.ani:setPositionX(self.barbg:getContentSize().width * var_14_0 / 100)
	end
end

function DownloadAllAssetsLayer:onDownloadComplete()
	cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("ON_ALL_RESOURCE_DOWNLOAD_COMPLETE")))
	self.updateInfo:setString("下载成功")
	self.bar:setPercentage(100)
	self.loadSp:setPosition(cc.p(self.barbg:getContentSize().width, self.barbg:getContentSize().height / 2))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.RemoveSelf:create()))
end

function DownloadAllAssetsLayer:noNeedDownload()
	require("view.Layer.DialogLayer")
	self:addChild(DialogLayer:create(L_LOGOUT_MSG[5].Title, "资源已下载完毕", 500, 250, function()
		self:runAction(cc.RemoveSelf:create())
	end), 10001)
end
