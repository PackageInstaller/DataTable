-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\HeroPreviewTips.lua

local HeroPreviewTipsInfoPanel = require("UI/Common/Tips/HeroPreviewTipsInfoPanel")
local ModelTool = require("Entity/ModelTool")
local ModelFactory = Framework.Entity.ModelFactory
local ResHandBookHero = require("ClientData/ResHandBookHero")
local ARHelper = require("Helper/ARHelper")
local CustomShadowManager = require("System/CustomShadowManager")
local HeroCVNamePanel = require("UI/HandBook/HeroCVNamePanel")
local GROUP_BG_PATH = {
	"NoAlpha/HandBookRank/HandBookHeroBg/TxtGroup01",
	"NoAlpha/HandBookRank/HandBookHeroBg/TxtGroup02",
	"NoAlpha/HandBookRank/HandBookHeroBg/TxtGroup03",
	"NoAlpha/HandBookRank/HandBookHeroBg/TxtGroup04",
	"NoAlpha/HandBookRank/HandBookHeroBg/TxtGroup05"
}
local strClassName = "HeroPreviewTips"
local HeroPreviewTips = Class(strClassName, UIControls.Tips)

function HeroPreviewTips:ctor()
	self._slot4LoadNewModelEnd = Slot(self.initModelLoadedEnd, self)

	self:_initUI()
end

function HeroPreviewTips:_initUI()
	self.rawImgBg = UIControls.RawImage(self, "BgImage")
	self.panelBaseInfo = HeroPreviewTipsInfoPanel(self, "MainInfoPanel/HeroContentBaseInfoPanel")
	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/HandBookDlgModelStage")
	self.modelControl = UIControls.Panel(self, "ModelControl")
	self.imgIconPortrait = UIControls.Image(self, "MainInfoPanel/ListFunPanel/BtnPortrait/Image")

	self.modelStage:initOperation(self.modelControl)

	self.modelStage.mEventOprFingerDown = Slot(self.onDragStart, self)
	self.modelStage.mEventOprFingerUp = Slot(self.onDragEnd, self)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.panelCvName = HeroCVNamePanel(self, "MainInfoPanel/CvPanel")
	self.txtCvNameList = {}

	for i = 1, 2 do
		local cvName = UIControls.Label(self, "MainInfoPanel/CvPanel/TxtPanel/TxtName" .. i)

		table.insert(self.txtCvNameList, cvName)
	end

	self.txtLog = UIControls.Label(self, "MainInfoPanel/CvPanel/TxtPanel/TxtLog")
	self.panelPortrait = UIControls.Panel(self, "BgPortrait")
	self.rolePortrait = UIControls.Role(self, "BgPortrait", 0, 0)
	self.modelControl = UIControls.Panel(self, "ModelControl")
	self.btnVoice = UIControls.Button(self, "MainInfoPanel/ListFunPanel/BtnVoice")

	self.btnVoice:addEventClick(self.onBtnVoiceClick)

	self.btnPortrait = UIControls.Button(self, "MainInfoPanel/ListFunPanel/BtnPortrait", "Text")

	self.btnPortrait:addEventClick(self.onBtnPortraitClick)

	self.btnExperience = UIControls.Button(self, "MainInfoPanel/ListFunPanel/BtnExperience")

	self.btnExperience:addEventClick(self.onBtnExperienceClick)

	self.btnGuideEvaluate = UIControls.Button(self, "MainInfoPanel/ListFunPanel/BtnGuideEvaluate")

	self.btnGuideEvaluate:setVisible(true)
	self.btnGuideEvaluate:addEventClick(self.onBtnGuideEvaluateClick)

	self.btnUniqueHero = UIControls.Button(self, "MainInfoPanel/BtnVanityHero")

	self.btnUniqueHero:addEventClick(self.onUniqueHeroClick)

	self.bgVoiceBullet = UIControls.UIAni(self, "MainInfoPanel/BgSubtitle")
	self.txtVoiceBullet = UIControls.Label(self, "MainInfoPanel/BgSubtitle/Text")
end

function HeroPreviewTips:onBtnExperienceClick()
	MsgManager.clientNotice(139)
end

function HeroPreviewTips:onBtnARClick()
	CustomShadowManager.clearShadow()
	ARHelper.tryOpenARDlg(self.hero.id)
end

function HeroPreviewTips:onBtnPortraitClick()
	local txtPortrait = self.modelViewport:getVisible() and Lang.get(30236) or Lang.get(958)
	local spritePortrait = self.modelViewport:getVisible() and "Icon3D" or "Icon2D"

	self.imgIconPortrait:setImage("Atlas/HandBookAtlas/HandBookAtlas", spritePortrait)
	self.btnPortrait:setText(txtPortrait)
	self.rawImgBg:changeVisible()
	self.modelViewport:changeVisible()
	self.modelControl:changeVisible()
	self.panelPortrait:changeVisible()
end

function HeroPreviewTips:onOpen()
	HeroPreviewTips.super.onOpen(self)
	self.modelStage:connectImage(self.modelViewport)
end

function HeroPreviewTips:onBtnCloseClick()
	self:setVisible(false)
end

function HeroPreviewTips:_setObj(gridHero)
	self.hero = gridHero.object

	for i, handInfo in pairs(ResHandBookHero) do
		if self.hero.id == handInfo.hero_id then
			self.handInfo = handInfo
		end
	end

	self.voiceIdx = 1

	self.panelBaseInfo:setHero(self.hero)
	self.rawImgBg:setImage(GROUP_BG_PATH[self.hero.camp])

	if self.curModelInsId then
		self.autoRotateComponent = nil

		self.modelStage:delModel(self.curModelInsId)
	end

	local modelId = self.hero:getShowModelId()
	local baseModelId = self.hero:getShowBaseModelId()

	self.rolePortrait:showRole(self.handInfo.role_id or self.hero.id, UIConst.ROLEIMAGE_SHOWTYPE_HANDBOOK)
	self.panelBaseInfo:setHero(self.hero)

	self.curModelInsId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, nil, self._slot4LoadNewModelEnd, nil, baseModelId)

	if self.curModelInsId then
		self.modelStage:setOperateModel(self.curModelInsId)
	end

	self.panelCvName:setHero(self.hero)
	self.btnUniqueHero:setVisible(self.hero:isUniqueHero())
end

function HeroPreviewTips:initModelLoadedEnd(modelInsId, modelResID)
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

function HeroPreviewTips:onDragStart()
	if self.autoRotateComponent then
		self.autoRotateComponent:EndRotate()
	end
end

function HeroPreviewTips:onUniqueHeroClick()
	local ui = UIManager.getUI("relatedHeroInfoDlg", true)

	ui:bindWindow(self)
	ui:showHero(self.hero.id, true)
end

function HeroPreviewTips:onDragEnd()
	if self.autoRotateComponent then
		self.autoRotateComponent:StartRotate()
	end
end

function HeroPreviewTips:onBtnVoiceClick()
	local voiceList = self.handInfo.voice_id

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

		local showstate, desc = ClientUtils.checkCanShowVoCalBullet(playVoiceId)

		if showstate and desc then
			local function closeBullet(...)
				self.bgVoiceBullet:startAni("HideSubtitle")
			end

			if not self.bulletCloseTimer then
				self.bulletCloseTimer = Timer.New(Slot(closeBullet, self), 4, 1)
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

function HeroPreviewTips:onBtnGuideEvaluateClick()
	local commentDlg = UIManager.getUI("commentDlg", true)

	commentDlg:setHeroId(self.hero.id, true)
end

function HeroPreviewTips:destroy(...)
	HeroPreviewTips.super.destroy(self)

	if self.bulletCloseTimer then
		self.bulletCloseTimer:Stop()
	end
end

return HeroPreviewTips
