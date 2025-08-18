-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Loadingui.lua

local ResLoadingConfig = require("ClientData/ResLoadingConfig")
local VersionUtils = require("System/VersionUtils")
local UIUtils = require("Framework.UI.UIUtils")
local NetService = require("Network/NetService")
local strClassName = "LoadingUI"
local LoadingUI = Class(strClassName, UIControls.Window)
local LoadingValidTable = {}

local function InitLoadingValidTable()
	LoadingValidTable = {}

	for loadingId, loadingInfo in pairs(ResLoadingConfig) do
		if ClientUtils.isTimeConfigPassed(loadingInfo.valid_time_id) then
			if loadingInfo.close_time_id then
				if not ClientUtils.isTimeConfigPassed(loadingInfo.close_time_id) then
					table.insert(LoadingValidTable, loadingInfo)
				end
			else
				table.insert(LoadingValidTable, loadingInfo)
			end
		end
	end
end

function LoadingUI:ctor()
	self.bar = UIControls.Slider(self, "Slider")
	self.aniPanel = UIControls.Panel(self, "AniPanel")
	self.imgBg = UIControls.RawImage(self, "BgImage")
	self.imgBgSpec = UIControls.RawImage(self, "BgImageS")
	self.panelInfo = UIControls.Panel(self, "InfoPanel")
	self.textCampLogo = UIControls.Label(self, "InfoPanel/TextLogo")
	self.textName = UIControls.Label(self, "InfoPanel/TextName")
	self.bgName = UIControls.Image(self, "InfoPanel/BgName")
	self.textShortDesc = UIControls.Label(self, "InfoPanel/ImgVer/TextDes")
	self.textHero = UIControls.Label(self, "InfoPanel/TextBasicInfo")
	self.imgGroup = UIControls.Image(self, "InfoPanel/IconGroup")
	self.textGroup = UIControls.Label(self, "InfoPanel/TextGroup")
	self.panelSec = UIControls.Panel(self, "CpPanel")
	self.textLName = UIControls.Label(self, "CpPanel/InfoL/TextName")
	self.textLShortDesc = UIControls.Label(self, "CpPanel/InfoL/ImgVer/TextDes")
	self.imgLGroup = UIControls.Image(self, "CpPanel/InfoL/IconGroup")
	self.textRName = UIControls.Label(self, "CpPanel/InfoR/TextName")
	self.textRShortDesc = UIControls.Label(self, "CpPanel/InfoR/ImgVer/TextDes")
	self.imgRGroup = UIControls.Image(self, "CpPanel/InfoR/IconGroup")
	self.panelThird = UIControls.Panel(self, "TriPanel")
	self.iconThirdLogo = UIControls.Image(self, "TriPanel/InfoL/ImgGameLogo")
	self.textThirdDesc = UIControls.Label(self, "TriPanel/InfoL/TextGame")
	self.imgThirdGroup = UIControls.Image(self, "TriPanel/InfoR/IconGroup")
	self.textThirdGroup = UIControls.Label(self, "TriPanel/InfoR/TextLogo")
	self.panelTips = UIControls.Panel(self, "TipsPanel")
	self.textTips = UIControls.Label(self, "TipsPanel/Text")
end

function LoadingUI:startLoad()
	self:checkState()
	self.bar:setValue(0)
	self.bar:setLoadingMode(Slot(self.onRunFinish, self))

	self._isOver = false

	CueManager.fadeOutBGM()
end

function LoadingUI:checkState()
	self.aniPanel:setVisible(false)

	if Const.REVIEW_VERSION then
		self.imgBgSpec:setVisible(false)
		self.imgBg:setImage("NoAlpha/PlayerGuide/Story/071")
		self.imgBg:setVisible(true)
	else
		if #LoadingValidTable == 0 then
			InitLoadingValidTable()
		end

		local num = math.random(1, #LoadingValidTable)

		self.loadingConfig = LoadingValidTable[num]

		if self.loadingConfig.multi_mode == 3 or self.loadingConfig.multi_mode == 4 then
			local realImgBg

			if not self.loadingConfig.width_mode then
				self.imgBgSpec:setVisible(true)
				self.imgBg:setVisible(false)

				realImgBg = self.imgBgSpec
			else
				self.imgBgSpec:setVisible(false)
				self.imgBg:setVisible(true)

				realImgBg = self.imgBg
			end

			if self.loadingConfig.multi_mode == 4 then
				realImgBg:setImage(self.loadingConfig.bg_id)
			else
				realImgBg:setImage("NoAlpha/PlayerGuide/Story/" .. (self.loadingConfig.bg_id or num))
			end

			self.aniPanel:setVisible(true)

			local tips = CurAvatar and CurAvatar:getNoticeTips(1)

			if tips then
				self.panelTips:setVisible(true)
				self.textTips:setText(tips.tips_desc or "")
			else
				self.panelTips:setVisible(false)
			end
		else
			self.imgBgSpec:setVisible(false)
			self.imgBg:setImage("NoAlpha/Loading/" .. (self.loadingConfig.bg_id or num))
			self.imgBg:setVisible(true)

			if self.loadingConfig.multi_mode == 1 then
				self:setSecondMode()
			elseif self.loadingConfig.multi_mode == 2 then
				self:setThirdMode()
			else
				self.panelInfo:setVisible(true)
				self.panelSec:setVisible(false)
				self.panelThird:setVisible(false)
				self.textName:setText(self.loadingConfig.hero_name or "")
				self.textShortDesc:setText(self.loadingConfig.hero_short_desc or "")
				self.textHero:setText(self.loadingConfig.hero_desc or "")

				local camp = self.loadingConfig.hero_camp
				local campConfig = Const.CAMP_CONFIG[camp]

				if campConfig then
					self.textCampLogo:setText(campConfig.en_name)
					self.textGroup:setText(campConfig.detail_des or "")

					local groupIconPath = UIConst.getHeroCampLargeIconPath(camp)

					self.imgGroup:setImage(groupIconPath[1], groupIconPath[2])
				end

				if self.loadingConfig.hero_bg_icon then
					self.bgName:setImage("Atlas/" .. self.loadingConfig.hero_bg_icon_path, self.loadingConfig.hero_bg_icon)
				end
			end
		end
	end
end

function LoadingUI:setSecondMode()
	self.panelInfo:setVisible(false)
	self.panelSec:setVisible(true)
	self.panelThird:setVisible(false)
	self.textLName:setText(self.loadingConfig.hero_name or "")
	self.textLShortDesc:setText(self.loadingConfig.hero_short_desc or "")

	local camp = self.loadingConfig.hero_camp

	if camp then
		local groupIconPath = UIConst.getHeroCampLargeIconPath(camp)

		self.imgLGroup:setImage(groupIconPath[1], groupIconPath[2])
	end

	self.textRName:setText(self.loadingConfig.sec_hero_name or "")
	self.textRShortDesc:setText(self.loadingConfig.sec_hero_short_desc or "")

	camp = self.loadingConfig.sec_hero_camp

	if camp then
		local groupIconPath = UIConst.getHeroCampLargeIconPath(camp)

		self.imgRGroup:setImage(groupIconPath[1], groupIconPath[2])
	end
end

function LoadingUI:setThirdMode()
	self.panelInfo:setVisible(false)
	self.panelSec:setVisible(false)
	self.panelThird:setVisible(true)

	if self.loadingConfig.third_logo_icon_path then
		self.iconThirdLogo:setImage("Atlas/" .. self.loadingConfig.third_logo_icon_path, self.loadingConfig.third_logo_icon)
	end

	local camp = self.loadingConfig.hero_camp

	if camp then
		local groupIconPath = UIConst.getHeroCampLargeIconPath(camp)

		self.imgThirdGroup:setImage(groupIconPath[1], groupIconPath[2])
	end

	self.textThirdGroup:setText(self.loadingConfig.third_hero_camp_desc or "")
	self.textThirdDesc:setText(self.loadingConfig.hero_desc or "")
end

function LoadingUI:onRunFinish(self)
	self._isOver = true
end

function LoadingUI:onClose()
	if self.bar then
		self.bar:setValue(0)
	end

	LoadingUI.super.onClose(self)
end

function LoadingUI:setRate(r)
	self.bar:setValue(r)

	if not self._isOver then
		return true
	end
end

function LoadingUI:setVisible(v, hideAndDestroy)
	if not v and VersionUtils.getEngineVersion() >= 142870 then
		self:getController():clearImage()
	end

	self._visible = v
	self._hide2Destroy = false

	UIManager.visibleReject(self)
	UIUtils.SetUIVisible(self.id, v, false)
end

return LoadingUI
