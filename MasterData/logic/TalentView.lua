-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/talent/view/TalentView.lua

module("logic.extensions.talent.view.TalentView", package.seeall)

local PnlIndexs = {
	Training = {
		animattionName = "talent_training_idle",
		btnName = "Btn_PnlTraining"
	},
	Strengthen = {
		animattionName = "talent_strength_idle",
		btnName = "Btn_PnlStrengthen"
	}
}
local AttrShow = {
	2,
	4,
	6,
	3,
	5,
	7,
	1,
	8
}

local function GetPetInfo(petId)
	local petMo = BagModel.instance:getPet(petId)
	local petCfg = CharacterConfig.instance:getPetCo(petMo.raceId)
	local modelCfg = CharacterConfig.instance:getModelCo(checknumber(petCfg.faceIds))

	return petMo, petCfg, modelCfg
end

local TalentView = class("TalentView", ViewComponent)

function TalentView:ctor()
	TalentView.super.ctor(self)

	self._pnlIndex = nil
	self._pnlInfos = {}
	self.petId = nil
	self._geniusValues = nil
	self._curGeniusType = 0
end

function TalentView:buildUI()
	self._animator = self.mainGO:GetComponent("Animator")

	local _Nego_Left = goutil.findChild(self.mainGO, "Nego_Left")
	local _Nego_Right = goutil.findChild(self.mainGO, "Nego_Right")

	self._Nego_Effect = goutil.findChild(self.mainGO, "Nego_Effect")
	self._pnlInfos = {}

	for k, v in pairs(PnlIndexs) do
		local go = goutil.findChild(_Nego_Left, v.btnName)
		local changeGroup = go:GetComponent("UIChangeGroup")

		self._pnlInfos[k] = {
			go = go,
			changeGroup = changeGroup
		}
	end

	self._Btn_Close = goutil.findChild(_Nego_Right, "Btn_Close")

	local _Nego_Pet = goutil.findChild(_Nego_Right, "Nego_Pet")

	self._Nego_Icon = goutil.findChild(_Nego_Pet, "Nego_Icon"):GetComponent("UIImageSpriteChange")
	self._ImgC_PetIcon = goutil.findChild(self._Nego_Icon, "ImgC_PetIcon"):GetComponent(goutil.Type_UIImage)
	self._Btn_Change = goutil.findChild(self._Nego_Icon, "Btn_Change")
	self._TxtC_Name = goutil.findChild(_Nego_Pet, "Nego_Name/TxtC_Name"):GetComponent(goutil.Type_UIText)

	local _Nego_GeniusType = goutil.findChild(_Nego_Pet, "Nego_GeniusType")

	self._ImgC_GeniusType = goutil.findChild(_Nego_GeniusType, "ImgC_GeniusType"):GetComponent("UIImageSpriteChange")
	self._TxtC_GeniusType = goutil.findChild(_Nego_GeniusType, "TxtC_GeniusType"):GetComponent(goutil.Type_UIText)
	self._Nego_Talent = goutil.findChild(_Nego_Right, "Nego_Talent")
	self._Item_Talents = {}

	for i, v in ipairs(AttrShow) do
		local go = goutil.findChild(self._Nego_Talent, string.format("Item_Talent_%d", i))
		local item = ItemTalent.AddOnce(go)

		item:AddClickStrengthListner(function(attr)
			self:_OnClickStrength(attr)
		end)
		item:Init(v)

		self._Item_Talents[i] = {
			go = go,
			item = item
		}
	end

	self._TxtC_TrainingCost = goutil.findChild(_Nego_Right, "Nego_Training/Nego_TrainingCost/TxtC_TrainingCost"):GetComponent("Text")
	self._TxtC_TrainingMy = goutil.findChild(_Nego_Right, "Nego_Training/Nego_TrainingMy/TxtC_TrainingCost"):GetComponent("Text")
	self._TxtC_TrainingRate = goutil.findChild(_Nego_Right, "Nego_Training/Nego_TrainingRate/TxtC_TrainingRate"):GetComponent("Text")
	self._TxtC_StrengthenMy = goutil.findChild(_Nego_Right, "Nego_Strengthen/TxtC_StrengthenMy"):GetComponent("Text")
	self._Btn_Training = goutil.findChild(_Nego_Right, "Nego_Training/Btn_Training")
	self._Btn_Training_Text = goutil.findChild(self._Btn_Training, "Text"):GetComponent("Text")
end

function TalentView:destroyUI()
	self._pnlInfos = {}

	for k, v in pairs(self._Item_Talents) do
		ItemTalent.Remove(v.go)

		v.item = nil
	end

	self._Item_Talents = {}
end

function TalentView:bindEvents()
	self._onClickCloseHandler = PointerClickHandler.Get(self._Btn_Close):AddLuaHandler(function()
		self:_OnClickClose()
	end)

	for k, v in pairs(self._pnlInfos) do
		v.handler = PointerClickHandler.Get(v.go):AddLuaHandler(function()
			self:_OnClickPnlBtn(k)
		end)
	end

	self._onClickTrainingHandler = PointerClickHandler.Get(self._Btn_Training):AddLuaHandler(function()
		self:_OnClickTraining()
	end)
	self._onClickSelectPetHandler = PointerClickHandler.Get(self._Btn_Change):AddLuaHandler(function()
		self:_OnClickSelectPet()
	end)

	GlobalDispatcher:addListener(GlobalNotify.TalentTraining, self._OnTalentTraining, self)
	GlobalDispatcher:addListener(GlobalNotify.TalentStrength, self._OnTalentStrength, self)
end

function TalentView:unbindEvents()
	PointerClickHandler.Get(self._Btn_Close):RemoveLuaHandler(self._onClickCloseHandler)

	for k, v in pairs(self._pnlInfos) do
		if v.handler then
			PointerClickHandler.Get(v.go):RemoveLuaHandler(v.handler)

			v.handler = nil
		end
	end

	PointerClickHandler.Get(self._Btn_Training):RemoveLuaHandler(self._onClickTrainingHandler)
	PointerClickHandler.Get(self._Btn_Change):RemoveLuaHandler(self._onClickSelectPetHandler)
	GlobalDispatcher:removeListener(GlobalNotify.TalentTraining, self._OnTalentTraining, self)
	GlobalDispatcher:removeListener(GlobalNotify.TalentStrength, self._OnTalentStrength, self)
end

function TalentView:onEnter()
	self._curGeniusType = 0

	local petId = self:getFirstParam()

	petId = petId or BagPetsController.instance:GetCurPetId()
	petId = petId or table.keys(BagPetsController.instance:getBagPets())[1]

	self:_OnClickPnlBtn("Training")
	self:_SetData(petId)
end

function TalentView:onEnterFinished()
	return
end

function TalentView:onExit()
	return
end

function TalentView:onExitFinished()
	return
end

function TalentView:_OnClickClose()
	self:close()
end

function TalentView:_OnClickSelectPet()
	local function onSeletCallBack(petId)
		self:_SetData(petId)
	end

	local function filterFunc(petData)
		return true
	end

	PetSelectController.instance:OpenViewWithOnce("选择精灵", filterFunc, onSeletCallBack)
end

function TalentView:_OnClickTraining()
	local petMo, petCfg = GetPetInfo(self.petId)
	local type = petMo:GetGeniusType()
end

function TalentView:_OnClickStrength(attr)
	local petMo = GetPetInfo(self.petId)
	local isEnable = TalentConfig.instance:GetGeniusMaxValue() > petMo._geniusValues[attr].value

	if isEnable then
		local tips = string.format("本次天赋增强将消耗 <color=#ff0000ff>%d</color> 钻石\n你现在拥有 <color=#ff0000ff>%d</color> 钻石", 5, RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond())

		TipsFacade.instance:openPopupWindow(lang("tip"), tips, function()
			return
		end)
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), "该属性已满，不可增强了")
	end
end

function TalentView:_OnClickPnlBtn(pnlName)
	if self._pnlIndex == pnlName then
		return
	end

	self._pnlIndex = pnlName

	self._animator:Play(PnlIndexs[pnlName].animattionName)

	for k, v in pairs(self._Item_Talents) do
		v.item:SetOnStrength(pnlName == "Strengthen")
	end
end

function TalentView:_SetData(petId)
	if petId ~= nil then
		self.petId = petId
	end

	self:_SetPetInfo()
	self:_SetGeniusType()
	self:_SetTalents(true)
	self:_SetTrainingTips()
	self:_CheckBtnTrainingState()
end

function TalentView:_SetPetInfo()
	local petMo, petCfg, modelCfg = GetPetInfo(self.petId)
	local race = GameEnum.Races[GameUtil.splitRaceTypes(petCfg.raceTypes)[1]]

	self._Nego_Icon:SetState(race - 1)
	uGuiUtil.setSpriteToImage(self._ImgC_PetIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCfg.headName))

	self._TxtC_Name.text = petMo.name
end

function TalentView:_SetGeniusType()
	local petMo = GetPetInfo(self.petId)
	local type = petMo:GetGeniusType()

	self._curGeniusType = type
	self._TxtC_GeniusType.text = lang("tips_geniustype") .. ConstString.GeniusName[type]

	self._ImgC_GeniusType:SetState(type)
end

function TalentView:_SetTalents(isNormal)
	local petMo = GetPetInfo(self.petId)
	local talents = petMo._geniusValues
	local index = 0

	for i, show in ipairs(AttrShow) do
		local obj, talent = self._Item_Talents[i], talents[show]

		if talent.value == 0 then
			obj.go:SetActive(false)
			print(i, show)
		else
			index = index + 1

			obj.go:SetActive(true)
			obj.item:SetBg(math.fmod(index, 2) == 0)

			if isNormal then
				obj.item:SetNormal(talent.value, talent.star)
			else
				local oldValue = self._geniusValues[show].value

				obj.item:SetChange(oldValue, talent.value, talent.star)
			end
		end
	end

	self._geniusValues = clone(talents)
end

function TalentView:_SetTrainingTips()
	local petMo, petCfg = GetPetInfo(self.petId)
	local type = petMo:GetGeniusType()

	self._TxtC_TrainingCost.text = TalentConfig.instance:GetUpgradeCost(type)
	self._TxtC_TrainingRate.text = ""
	self._TxtC_TrainingMy.text = "" .. RoleModel.instance:getCoin()
	self._TxtC_StrengthenMy.text = "" .. RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()
end

function TalentView:_CheckBtnTrainingState()
	local petMo = GetPetInfo(self.petId)
	local isDisable = petMo:IsGeniusFull()

	uGuiUtil.setGoGrayState(self._Btn_Training, isDisable)

	self._Btn_Training_Text.text = isDisable and "MAX" or lang("tips_geniustrain")
end

function TalentView:_OnTalentTraining(isSuc)
	self:_PlayEff()
	self:_CheckGeniusTypeChange()
	self:_SetGeniusType()
	self:_SetTalents(false)
	self:_CheckBtnTrainingState()
	self:_SetTrainingTips()
end

function TalentView:_OnTalentStrength()
	self:_PlayEff()
	self:_CheckGeniusTypeChange()
	self:_SetGeniusType()
	self:_SetTalents(false)
	self:_CheckBtnTrainingState()
	self:_SetTrainingTips()
end

function TalentView:_PlayEff()
	UIEffectManager.instance:playEffect(self, "fx_ui_tianfu/fx_ui_tianfu.prefab", self._Nego_Effect, 0, 0, false)
end

function TalentView:_CheckGeniusTypeChange()
	local petMo = GetPetInfo(self.petId)
	local cur = petMo:GetGeniusType()
	local last = self._curGeniusType

	if last < cur then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), string.format("%s -> %s", ConstString.GeniusName[last], ConstString.GeniusName[cur]))
	end
end

return TalentView
