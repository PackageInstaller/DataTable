-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetUpStarPreviewDlg.lua

local ResPetStar = require("ClientData/ResPetStar")
local ResPet = require("ClientData/ResPet")
local ModelTool = require("Entity/ModelTool")
local ModelFactory = Framework.Entity.ModelFactory
local strClassName = "PetUpStarPreviewDlg"
local PetUpStarPreviewDlg = Class(strClassName, UIControls.Window)

function PetUpStarPreviewDlg:ctor()
	self._slotOfModelLoaded = Slot(self.initModelLoadedEnd, self)

	self:initUI()
end

function PetUpStarPreviewDlg:initUI()
	self.modelViewport = UIControls.RawImage(self, "BgPanel/ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/NewPetDlgModelStage_01")
	self.starGroups = {}

	for idx = 1, 3 do
		local stars = {}
		local panelStarGroup = UIControls.Panel(self, "BgPanel/PetShow0" .. idx .. "/StartGroup")
		local panelTextTips = UIControls.Panel(self, "BgPanel/PetShow0" .. idx .. "/TextTips")

		for i = 1, 5 do
			local checkmark = UIControls.Image(self, "BgPanel/PetShow0" .. idx .. "/StartGroup/Start0" .. i .. "/Background/Checkmark")

			table.insert(stars, checkmark)
		end

		self.starGroups[idx] = {
			panelStarGroup = panelStarGroup,
			panelTextTips = panelTextTips,
			stars = stars
		}
	end

	self._petModelInsIDs = {}
	self.text = UIControls.Label(self, "BgPanel/TextTips/Content/Text")
end

function PetUpStarPreviewDlg:onOpen()
	PetUpStarPreviewDlg.super.onOpen(self)
	self.modelStage:connectImage(self.modelViewport)
end

function PetUpStarPreviewDlg:setData(pet)
	self.pet = pet

	local modelResID = pet:getShowModelId()
	local baseModels = ResPet[self.pet.id].base_model
	local changeStarTable, myStage = self.pet:getModelChangeStar()

	for idx = 1, 3 do
		if changeStarTable[idx] then
			local stars = self.starGroups[idx].stars

			for i, v in ipairs(stars) do
				stars[i]:setVisible(i <= changeStarTable[idx])
			end

			self.starGroups[idx].panelTextTips:setVisible(myStage == idx)
		end

		local baseId = baseModels[idx]

		self._petModelInsIDs[idx] = self.modelStage:showHeroByModId(modelResID, Const.MODEL_TYPE.RearHouse, idx, self._slotOfModelLoaded, nil, baseId)
	end

	self.text:setText(ResPet[self.pet.id].desc)
end

function PetUpStarPreviewDlg:initModelLoadedEnd(modelInsId, baseModelId)
	self.autoRotateComponent = ModelTool.addAutoRotateComponent(modelInsId)

	if baseModelId then
		ModelTool.addBaseModel(modelInsId, baseModelId, 1, Const.HERO_BASE_TYPE.Rear)
	end

	if modelInsId then
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:SetAnimatorNoCulling()
			modelAux:PlayAnimatorNow("Newshow_idle")
		end
	end
end

return PetUpStarPreviewDlg
