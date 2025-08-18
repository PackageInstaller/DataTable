-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Social\\CaptureDlg.lua

local DeviceHelper = require("Helper/DeviceHelper")
local SocialShare = require("SDK/Plugin/SocialShare")
local NativeHelper = require("Helper/NativeHelper")
local resShareFrame = require("ClientData/ResShareFrame")
local Analytics = require("SDK/Analytics")
local FileUtils = Framework.Tools.FileUtils
local framePanelChild = Class("framePanelChild", UIControls.Child)

function framePanelChild:ctor()
	return
end

local strClassName = "CaptureDlg"
local CaptureDlg = Class(strClassName, UIControls.Window)

CaptureDlg.ArQRtab = {
	haoyoukuaibao = "IconQRHaoYou",
	bilibili = "IconQRBiliBili",
	taptap = "IconQRTapTap",
	xy = "IconQRhxLNY5"
}

local TEMP_PIC_PATH = "Temp/pic_temp.jpg"

CaptureDlg._tempDirCreated = false

function CaptureDlg:ctor()
	self.isShared = 0
	self.btnClose = UIControls.Button(self, "ImgPhoto/BtnClose")

	self.btnClose:setVisible(false)
	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.panelMain = UIControls.UIAni(self, "ImgPhoto")
	self.imgScreenshot = UIControls.ScreenshotImage(self, "ImgPhoto")
	self.btnSave = UIControls.Button(self, "ImgPhoto/OtherPanel/BtnPhone")

	self.btnSave:addEventClick(self._onClickSave)

	self.sharePanel = UIControls.Panel(self, "ImgPhoto/OtherPanel")
	self.infoPanel = UIControls.Panel(self, "InfoPanel")

	self.infoPanel:setVisible(true)

	self.bgImg = UIControls.Panel(self, "Image")

	self.bgImg:setVisible(false)

	self.bg2 = UIControls.Panel(self, "ImgPhoto/Bg2")
	self.otherPanel = UIControls.Panel(self, "ImgPhoto/OtherPanel")
	self.ionLogo = UIControls.Panel(self, "InfoPanel/IconLogo")
	self.ionQRCode = UIControls.Image(self, "InfoPanel/IconQRCode")
	self.framePanel = UIControls.Panel(self, "FramePanel")

	self:_setQRCode()
	self:_screenshot()
	self:_initImage()
end

function CaptureDlg:onOpen()
	CaptureDlg.super.onOpen(self)

	if CurAvatar and RegionUtils.isJP() then
		local data = Analytics.getByteSendLogPubParameter()

		data.page_id = "captureDlg"

		Analytics.sendLogByted("page_flow", ClientUtils.table2String(data))
	end
end

function CaptureDlg:_checkFramePanel()
	if resShareFrame and self.showFramePanel and self.showFramePanel.frameType then
		local specialFrame = self.showFramePanel.frameType or -1
		local serverTime = ClientUtils.getServerTime()
		local hadFrame = false

		for _, v in pairs(resShareFrame) do
			if specialFrame == v.universal and (v.actID == (self.showFramePanel and self.showFramePanel.actId or -1) or serverTime > ClientUtils.getTimeConfigTimestamp(v.startTime) and serverTime < ClientUtils.getTimeConfigTimestamp(v.endTime)) and (v.region == "ALL" or RegionUtils.isCurrentRegion(v.region)) then
				hadFrame = true

				framePanelChild(self, "FramePanel", v.framePath, 0, 0, true)
			end
		end

		if specialFrame >= 0 and hadFrame then
			self.ionLogo:setVisible(false)
		end
	end
end

function CaptureDlg:_initImage()
	self.shareButtons = {}

	local sharePlatformConfig = SocialShare.getSharePlatforms()

	if sharePlatformConfig then
		for i, v in ipairs(sharePlatformConfig) do
			local btn = UIControls.Button(self, "ImgPhoto/OtherPanel/Btn" .. i, "Text")

			btn:addEventClick(Functor(self._sharePicture, self, v.platform))
			btn:setImage(v.filePath, v.spriteName)
			btn:setVisible(true)
			table.insert(self.shareButtons, btn)
		end
	end
end

function CaptureDlg:_setQRCode()
	local subChannel = ChannelUtil.getSubChannelID()
	local imagePath = self.ArQRtab[subChannel]

	if imagePath then
		self.ionQRCode:setVisible(true)
		self.ionQRCode:setImage("Atlas/ArAtlas", imagePath)
	else
		self.ionQRCode:setVisible(false)
	end
end

function CaptureDlg:_screenshot()
	self.imgScreenshot:setColorByRGBA(0, 0, 0, 0)

	self.coCapture = coroutine.start(function()
		coroutine.wait(0.3)
		self.imgScreenshot:refresh()
		coroutine.step()
		self.imgScreenshot:setColorByRGBA(255, 255, 255, 255)
		self.infoPanel:setVisible(false)
		self.bgImg:setVisible(true)
		self.btnClose:setVisible(true)
		self.panelMain:startAni("ShowShareImgPhoto")
		self.framePanel:setVisible(false)
	end)
end

function CaptureDlg:onBtnCloseClick()
	if not VersionUtils.hasAbilityShareCN() then
		self.isShared = 1
	end

	if DeviceHelper.isWindows() and RegionUtils.isJP() then
		self.isShared = 1
	end

	if self.callback then
		self.callback(self.isShared)
	end

	self:setVisible(false)
end

function CaptureDlg:capture(callback, showFrame)
	self.sharePanel:setVisible(true)

	self.callback = callback
	self.showFramePanel = showFrame

	self:_checkFramePanel()
end

function CaptureDlg:captureDMM(callback, showFrame)
	self.sharePanel:setVisible(false)

	self.callback = callback
	self.showFramePanel = showFrame

	self:_checkFramePanel()
	coroutine.start(function()
		coroutine.wait(1)
		self:_onClickSave()
	end)
end

function CaptureDlg:_onClickSave()
	self:_saveTempPic()
	self:_saveToGallery()
end

function CaptureDlg:_onCaptureFinish()
	return
end

function CaptureDlg:_saveTempPic(force)
	if self._tempPath and not force then
		return
	end

	self:_clearTempPic()

	local path = ClientUtils.getDocumentPath() .. TEMP_PIC_PATH

	self:_makeTempDir(path)
	self.imgScreenshot:saveJPG(path)

	self._tempPath = path
	self._savedToGallery = false
end

function CaptureDlg:_makeTempDir(filePath)
	if not CaptureDlg._tempDirCreated then
		CaptureDlg._tempDirCreated = true

		self.imgScreenshot:savePNG(filePath .. ".png")
	end
end

function CaptureDlg:_clearTempPic()
	if self._tempPath ~= nil then
		FileUtils.DelFile(self._tempPath)

		self._tempPath = nil
	end
end

function CaptureDlg:_saveToGallery()
	if self._tempPath == nil or self._savedToGallery then
		MsgManager.notice(Lang.get(30763))

		return
	end

	local done = false

	if not self:_checkPermission() then
		return
	end

	if DeviceHelper.isIOS() then
		Framework.Plugin.NativeUtils.AddToGallery(self._tempPath)

		if VersionUtils.getEngineVersion() <= 154872 then
			MsgManager.notice(Lang.get(30695))
		end
	elseif DeviceHelper.isAndroid() then
		local fileName = string.format("pic_%s_%s.jpg", os.date("%Y_%m_%d_%H_%M_%S"), math.random(1000))

		done = Framework.Plugin.NatvieGalleryHelper.SaveToGallery(self._tempPath, "Figure", fileName)

		self:saveResult(done)
	end

	if ChannelUtil.isSteam() then
		self.isShared = 1

		if self.callback then
			self.callback(self.isShared)
		end
	end
end

function CaptureDlg:saveResult(succ)
	if succ then
		MsgManager.notice(Lang.get(30695))
	else
		MsgManager.notice(Lang.get(30764))
	end

	self._savedToGallery = succ
end

function CaptureDlg:_checkPermission()
	local granted = NativeHelper.checkExternalWritePermission(NativeHelper.PERMISSION_REASON.PHOTO)

	if not granted then
		MsgManager.notice(Lang.get(31312))
	end

	return granted
end

function CaptureDlg:_sharePicture(platform)
	self.isShared = 1

	local includeText = false
	local ShareConfig = SocialShare.getShareConfig()

	if ShareConfig and ShareConfig[platform] then
		includeText = ShareConfig[platform][1]
	end

	if self._tempPath == nil then
		self:_saveTempPic(true)
	end

	if self._tempPath ~= nil then
		local text

		if includeText and self._text ~= nil then
			text = Lang.get(30002)
		end

		text = RegionUtils.isJP() and self.showFramePanel.title or text

		SocialShare.sharePicture(platform, self._tempPath, text)
	end
end

function CaptureDlg:destroy()
	CaptureDlg.super.destroy(self)

	if self.coCapture then
		coroutine.stop(self.coCapture)
	end
end

return CaptureDlg
