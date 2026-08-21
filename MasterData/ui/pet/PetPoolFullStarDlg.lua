-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetPoolFullStarDlg.lua

local ModelTool = require("Entity/ModelTool")
local ModelFactory = Framework.Entity.ModelFactory
local ResPetRune = require("ClientData/ResPetRune")
local ResPet = require("ClientData/ResPet")
local ResPetMisc = require("ClientData/ResPetMisc")
local strClassName = "PetPoolFullStarDlg"
local PetPoolFullStarDlg = Class(strClassName, UIControls.Window)

function PetPoolFullStarDlg:ctor()
	self._slotOfModelLoaded = Slot(self.initModelLoadedEnd, self)

	self:initUI()
end

function PetPoolFullStarDlg:initUI()
	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self.onAniFinish)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.modelViewport = UIControls.RawImage(self, "BgPanel/ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/NewPetDlgModelStage_04")
	self.textName = UIControls.Label(self, "BgPanel/TextNamePanel/TextName")
	self.textTips = UIControls.Label(self, "BgPanel/FullStarInfo/Content/IntroducePanel/TextTips")
	self.textTitle = UIControls.Label(self, "BgPanel/FullStarInfo/Content/InspirationPanel/TextTitle")
	self.textAttrName = UIControls.Label(self, "BgPanel/FullStarInfo/Content/InspirationPanel/Attr1/TextName")
	self.image = UIControls.Image(self, "BgPanel/FullStarInfo/Content/InspirationPanel/IconImg/Image")
	self.arrowNext = UIControls.Panel(self, "BgPanel/ArrowNext")
	self.fullStarInfo = UIControls.ScrollView(self, "BgPanel/FullStarInfo")

	self.fullStarInfo:addEventValueChanged(self.onScrollValueChanged)
end

function PetPoolFullStarDlg:onOpen()
	PetPoolFullStarDlg.super.onOpen(self)
	self.modelStage:connectImage(self.modelViewport)
end

function PetPoolFullStarDlg:onAniFinish()
	local contentSize = self.fullStarInfo:getContentSize()
	local maxHeight = self.fullStarInfo:getSize().height

	if maxHeight >= contentSize[2] then
		self.fullStarInfo:cancelScroll()
		self.arrowNext:setVisible(false)
	else
		self.arrowNext:setVisible(true)
		self.fullStarInfo:openScroll(true)

		self.isScroll = true
	end
end

function PetPoolFullStarDlg:setData(petId)
	self.pet = BaseObject.GetObject(petId)
	self.pet.star = ResPetMisc[1].max_star or 5

	local modelId = self.pet:getShowModelId()
	local baseModelId = self.pet:getShowBaseModelId()

	self.curModelInsId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, nil, self._slotOfModelLoaded, nil, baseModelId)

	self.textName:setText(self.pet.name)
	self.textTips:setText(ResPet[self.pet.id].desc)

	local exRuneId = self.pet:getMaxExRuneId()

	if ResPetRune[exRuneId] then
		self.textTitle:setText(ResPetRune[exRuneId].name)
		self.textAttrName:setText(ResPetRune[exRuneId].buff_desc)
		self.image:setImage(ResPetRune[exRuneId].icon_path or "Atlas/PetAtlas/PetRuneMainAtlas2", ResPetRune[exRuneId].icon or "IconDog01")
	end
end

function PetPoolFullStarDlg:initModelLoadedEnd(modelInsId, baseModelId)
	self.autoRotateComponent = ModelTool.addAutoRotateComponent(modelInsId)

	if baseModelId then
		ModelTool.addBaseModel(modelInsId, baseModelId, 1, Const.HERO_BASE_TYPE.Hero1)
	end

	if modelInsId then
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:SetAnimatorNoCulling()
			modelAux:PlayAnimatorNow("Newshow_idle")
		end
	end
end

function PetPoolFullStarDlg:onScrollValueChanged()
	if not self.isScroll then
		return
	end

	local barValue = self.fullStarInfo:getVerticalValue()

	if barValue == self.oldBarValue then
		return
	end

	self.oldBarValue = barValue

	if barValue == 0 then
		self.arrowNext:setVisible(false)
	else
		self.arrowNext:setVisible(true)
	end
end

function PetPoolFullStarDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

return PetPoolFullStarDlg
