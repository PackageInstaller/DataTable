-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookHeroInfoDlg.lua

local LuaToolkit = Framework.Tools.LuaToolkit
local ARUtils = Framework.AR.ARUtils
local HandBookHeroInfoPanel = require("UI/HandBook/HandBookHeroInfoPanel")
local HeroCVNamePanel = require("UI/HandBook/HeroCVNamePanel")
local ModelTool = require("Entity/ModelTool")
local DeviceHelper = require("Helper/DeviceHelper")
local ARHelper = require("Helper/ARHelper")
local CustomShadowManager = require("System/CustomShadowManager")
local RoleImageEnjoy = require("UI/Hero/RoleImageEnjoy")
local GROUP_BG_PATH = {
	"NoAlpha/HandBookRank/HandBookHeroBg/TxtGroup01",
	"NoAlpha/HandBookRank/HandBookHeroBg/TxtGroup02",
	"NoAlpha/HandBookRank/HandBookHeroBg/TxtGroup03",
	"NoAlpha/HandBookRank/HandBookHeroBg/TxtGroup04",
	"NoAlpha/HandBookRank/HandBookHeroBg/TxtGroup05"
}
local ModelFactory = Framework.Entity.ModelFactory
local strClassName = "HandBookHeroInfoDlg"
local HandBookHeroInfoDlg = Class(strClassName, UIControls.Window)

function HandBookHeroInfoDlg:ctor()
	self._slot4LoadNewModelEnd = Slot(self.initModelLoadedEnd, self)

	self:initUI()
end

function HandBookHeroInfoDlg:initUI()
	self.rawImgBg = UIControls.RawImage(self, "BgImage")
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnVoice = UIControls.Button(self, "MainInfoPanel/ListFunPanel/BtnVoice")

	self.btnVoice:addEventClick(self.onBtnVoiceClick)

	self.btnPortrait = UIControls.Button(self, "MainInfoPanel/ListFunPanel/BtnPortrait", "Text")

	self.btnPortrait:addEventClick(self.onBtnPortraitClick)

	self.imgIconPortrait = UIControls.Image(self, "MainInfoPanel/ListFunPanel/BtnPortrait/Image")
	self.btnExperience = UIControls.Button(self, "MainInfoPanel/ListFunPanel/BtnExperience")

	self.btnExperience:addEventClick(self.onBtnExperienceClick)

	self.btnAR = UIControls.Button(self, "MainInfoPanel/ListFunPanel/BtnAR", "Text")

	self.btnAR:addEventClick(self.onBtnARClick, 1)

	self.panelBaseInfo = HandBookHeroInfoPanel(self, "MainInfoPanel/HeroContentBaseInfoPanel")
	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/HandBookDlgModelStage")
	self.panelPortrait = UIControls.Panel(self, "BgPortrait")
	self.rolePortrait = UIControls.Role(self, "BgPortrait", 0, 0)
	self.modelControl = UIControls.Panel(self, "ModelControl")

	self.modelStage:initOperation(self.modelControl)

	self.modelStage.mEventOprFingerDown = Slot(self.onDragStart, self)
	self.modelStage.mEventOprFingerUp = Slot(self.onDragEnd, self)
	self.panelCvName = HeroCVNamePanel(self, "MainInfoPanel/CvPanel")
	self.txtLog = UIControls.Label(self, "MainInfoPanel/CvPanel/TxtPanel/TxtLog")
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnHeroNext = UIControls.Button(self, "MainInfoPanel/BtnHeroNext")

	self.btnHeroNext:addEventClick(self.onBtnHeroNextClick)

	self.btnHeroLast = UIControls.Button(self, "MainInfoPanel/BtnHeroLast")

	self.btnHeroLast:addEventClick(self.onBtnHeroLastClick)

	self.btnUniqueHero = UIControls.Button(self, "MainInfoPanel/BtnVanityHero")

	self.btnUniqueHero:addEventClick(self.onUniqueHeroClick)

	self.bgVoiceBullet = UIControls.UIAni(self, "MainInfoPanel/BgSubtitle")
	self.txtVoiceBullet = UIControls.Label(self, "MainInfoPanel/BgSubtitle/Text")

	self:_updateARBtn()
end

function HandBookHeroInfoDlg:_updateARBtn()
	return
end

function HandBookHeroInfoDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HANDBOOK_HERO_INFO)
end

function HandBookHeroInfoDlg:onOpen()
	HandBookHeroInfoDlg.super.onOpen(self)
	self.modelStage:connectImage(self.modelViewport)
end

function HandBookHeroInfoDlg:onClose()
	HandBookHeroInfoDlg.super.onClose(self)

	if self.panelBaseInfo.setScrollStatus then
		coroutine.stop(self.panelBaseInfo.setScrollStatus)
	end
end

function HandBookHeroInfoDlg:setHero(hero, filterList)
	self.hero = hero
	self.voiceIdx = 1

	self.rawImgBg:setImage(GROUP_BG_PATH[self.hero.camp])

	self.filterList = filterList

	if self.filterList then
		for idx = 1, #self.filterList do
			if self.filterList[idx].id == self.hero.id then
				self.curIdx = idx
			end
		end

		self.btnHeroLast:setVisible(self.curIdx ~= 1)
		self.btnHeroNext:setVisible(self.curIdx ~= #self.filterList)
	else
		self.btnHeroLast:setVisible(false)
		self.btnHeroNext:setVisible(false)
	end

	local showPortraitId = self.hero:getShowPortId()

	if showPortraitId == self.hero.id then
		self.rolePortrait:showRole(self.hero.handInfo.role_id or showPortraitId, UIConst.ROLEIMAGE_SHOWTYPE_HANDBOOK)
	else
		self.rolePortrait:showRole(showPortraitId, UIConst.ROLEIMAGE_SHOWTYPE_HANDBOOK)
	end

	self.panelBaseInfo:setHero(self.hero)

	if self.curModelInsId then
		self.autoRotateComponent = nil

		self.modelStage:delModel(self.curModelInsId)
	end

	local modelId = self.hero:getShowModelId()
	local baseModelId = self.hero:getShowBaseModelId()

	self.curModelInsId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, nil, self._slot4LoadNewModelEnd, nil, baseModelId)

	if self.curModelInsId then
		self.modelStage:setOperateModel(self.curModelInsId)
	end

	self.panelCvName:setHero(self.hero)
	CueManager.stopVocal()
	CueManager.playHeroVocal(hero.id, Const.HERO_VOCAL_CHOOSE)
	self.bgVoiceBullet:setVisible(false)

	if self.bulletCloseTimer then
		self.bulletCloseTimer:Stop()
	end

	local voiceId = ClientUtils.getHeroVoiceIdByType(self.hero.id, Const.HERO_VOCAL_CHOOSE)

	if voiceId then
		local state, desc = ClientUtils.checkCanShowVoCalBullet(voiceId)

		if state then
			local function closeBullet(...)
				self.bgVoiceBullet:startAni("HideSubtitle")
			end

			local function showBullet(...)
				self.bgVoiceBullet:setVisible(true)
				self.bgVoiceBullet:startAni("ShowSubtitle")
			end

			if not self.bulletShowTimer then
				self.bulletShowTimer = Timer.New(Slot(showBullet, self), 0.5, 1)
			end

			if not self.bulletCloseTimer then
				self.bulletCloseTimer = Timer.New(Slot(closeBullet, self), 6, 1)
			end

			self.bulletCloseTimer:Restart()
			self.bulletShowTimer:Restart()
			self.txtVoiceBullet:setText(desc)
		end
	end

	self.btnUniqueHero:setVisible(self.hero:isUniqueHero())
end

function HandBookHeroInfoDlg:setHeroByResId(heroId)
	local hero = CurAvatar:getHandBookHeroById(heroId)

	self:setHero(hero)
end

function HandBookHeroInfoDlg:onBtnHeroLastClick()
	if self.filterList[self.curIdx - 1] then
		self:setHero(self.filterList[self.curIdx - 1], self.filterList)
	end
end

function HandBookHeroInfoDlg:onUniqueHeroClick()
	local ui = UIManager.getUI("relatedHeroInfoDlg", true)

	ui:bindWindow(self)
	ui:showHero(self.hero.id, true)
end

function HandBookHeroInfoDlg:onBtnHeroNextClick()
	if self.filterList[self.curIdx + 1] then
		self:setHero(self.filterList[self.curIdx + 1], self.filterList)
	end
end

function HandBookHeroInfoDlg:onDragStart()
	if self.autoRotateComponent then
		self.autoRotateComponent:EndRotate()
	end
end

function HandBookHeroInfoDlg:onDragEnd()
	if self.autoRotateComponent then
		self.autoRotateComponent:StartRotate()
	end
end

function HandBookHeroInfoDlg:initModelLoadedEnd(modelInsId, modelResID)
	self.autoRotateComponent = ModelTool.addAutoRotateComponent(modelInsId)

	if modelResID then
		ModelTool.addBaseModel(modelInsId, modelResID, 1, Const.HERO_BASE_TYPE.Hero1)
	end

	if modelInsId then
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:SetAnimatorNoCulling()
			modelAux:PlayAnimatorNow("Newshow_idle")
		end
	end
end

function HandBookHeroInfoDlg:onBtnCloseClick()
	if self.enjoyPanel and self.enjoyPanel.isAppreciate then
		self.enjoyPanel:outEnjoyClick()
	else
		self:setVisible(false)
	end
end

function HandBookHeroInfoDlg:onBtnVoiceClick()
	local voiceList = self.hero.handInfo.voice_id

	if voiceList then
		if self.voiceIdx >= #voiceList then
			self.voiceIdx = 1
		else
			self.voiceIdx = self.voiceIdx + 1
		end

		local playVoiceId = voiceList[self.voiceIdx]

		CueManager.playVocal(playVoiceId)
		self.bgVoiceBullet:setVisible(false)

		if self.bulletCloseTimer then
			self.bulletCloseTimer:Stop()
		end

		if self.bulletShowTimer then
			self.bulletShowTimer:Stop()
		end

		local showstate, desc = ClientUtils.checkCanShowVoCalBullet(playVoiceId)

		if showstate and desc then
			local function closeBullet(...)
				self.bgVoiceBullet:startAni("HideSubtitle")
			end

			if not self.bulletCloseTimer then
				self.bulletCloseTimer = Timer.New(Slot(closeBullet, self), 5.5, 1)
			end

			self.bulletCloseTimer:Restart()
			self.bgVoiceBullet:setVisible(true)
			self.bgVoiceBullet:startAni("ShowSubtitle")
			self.txtVoiceBullet:setText(desc)
		end
	else
		MsgManager.clientNotice(139)
	end
end

function HandBookHeroInfoDlg:onBtnPortraitClick()
	local isModelVisible = self.modelViewport:getVisible()
	local txtPortrait = isModelVisible and Lang.get(30236) or Lang.get(958)
	local spritePortrait = isModelVisible and "Icon3D" or "Icon2D"

	self.imgIconPortrait:setImage("Atlas/HandBookAtlas/HandBookAtlas", spritePortrait)
	self.btnPortrait:setText(txtPortrait)
	self.rawImgBg:changeVisible()
	self.modelViewport:changeVisible()
	self.modelControl:changeVisible()
	self.panelPortrait:changeVisible()

	if isModelVisible then
		if not self.enjoyPanel then
			self.enjoyPanel = RoleImageEnjoy(self, "MainInfoPanel/EnjoyPanel", "System/Hero/EnjoyPanel", 0, 0)

			local btnEnjoy = UIControls.Button(self, "MainInfoPanel/ListFunPanel/BtnEnjoy")

			self.enjoyPanel:setBtnEnjoy(btnEnjoy)
		end

		self.enjoyPanel:addDrage(self.panelPortrait, self.rolePortrait.image)
	end

	if self.enjoyPanel then
		self.enjoyPanel:showEnjoyPanel(isModelVisible)
	end
end

function HandBookHeroInfoDlg:onBtnExperienceClick()
	MsgManager.clientNotice(139)
end

function HandBookHeroInfoDlg:onBtnARClick()
	CustomShadowManager.clearShadow()
	ARHelper.tryOpenARDlg(self.hero.id)
end

function HandBookHeroInfoDlg:destroy(...)
	HandBookHeroInfoDlg.super.destroy(self)

	if self.bulletCloseTimer then
		self.bulletCloseTimer:Stop()
	end

	if self.bulletShowTimer then
		self.bulletShowTimer:Stop()
	end
end

return HandBookHeroInfoDlg
