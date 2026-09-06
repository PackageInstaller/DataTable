-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/FightEditView.lua

module("logic.extensions.gm.view.FightEditView", package.seeall)

local FightEditView = class("FightEditView", ViewComponent)

function FightEditView:ctor()
	FightEditView.super:ctor()
end

function FightEditView:buildUI()
	self._editPanel = self:getGo("editPanel")
	self._editClosePanel = self:getBtn("editPanel/container/closeBtn")
	self._txtName = goutil.findChildTextComponent(self._editPanel, "container/TxtName")
	self._inputId = self:getInput("editPanel/container/idInput")
	self.skinInput = self:getInput("editPanel/container/skinInput")
	self._inputLvl = self:getInput("editPanel/container/InputField")
	self.InputJuexing = self:getInput("editPanel/container/InputJuexing")
	self._geniusInput = self:getInput("editPanel/container/geniusInput")
	self._stargodInput = self:getInput("editPanel/container/stargodInput")
	self.contractInput = self:getInput("editPanel/container/contractInput")
	self._equipInput = self:getInput("editPanel/container/equipInput")
	self.skillLvlInput = self:getInput("editPanel/container/skillLvlInput")
	self._buffInput = self:getInput("editPanel/container/buffInput")
	self._extInput = self:getInput("editPanel/container/extInput")
	self._btnLvl = self:getBtn("editPanel/container/BtnLvl")
	self._btnTuijianAll = self:getBtn("editPanel/container/BtnTuijianAll")
	self._btnGenius = self:getBtn("editPanel/container/BtnGenius")
	self._btnStargod = self:getBtn("editPanel/container/BtnStargod")
	self._btnEquip = self:getBtn("editPanel/container/BtnEquip")
	self._btnQishi = self:getBtn("editPanel/container/BtnQishi")
	self._BtnHp = self:getBtn("editPanel/container/BtnHp")
	self.BtnQishi2 = self:getBtn("editPanel/container/BtnQishi2")
	self.BtnSpd = self:getBtn("editPanel/container/BtnSpd")
	self.BtnMyPet = self:getBtn("editPanel/container/BtnMyPet")
	self.BtnDelMyPet = self:getBtn("editPanel/container/BtnDelMyPet")
	self.btnChoose = Framework.ToggleAdapter.Get(self:getGo("editPanel/container/btnChoose"))
end

function FightEditView:onEnter()
	return
end

function FightEditView:bindEvents()
	self.BtnMyPet:AddClickListener(self._onClickSelectMyPet, self)
	self.BtnDelMyPet:AddClickListener(self._onClickDeleteMyPet, self)
	self._btnLvl:AddClickListener(self._onLvlClick, self)
	self._btnTuijianAll:AddClickListener(self._onTuijianAllClick, self)
	self._btnGenius:AddClickListener(self._onGeniusClick, self)
	self._btnStargod:AddClickListener(self._onStargodClick, self)
	self._btnEquip:AddClickListener(self._onEquipClick, self)
	self._btnQishi:AddClickListener(self._onQishiClick, self)
	self.BtnQishi2:AddClickListener(self._onQishiClick2, self)
	self.BtnSpd:AddClickListener(self.onSpeedClick, self)
	self._BtnHp:AddClickListener(self._onHpClick, self)
	self._editClosePanel:AddClickListener(self._onCloseClick, self)

	local function onOurIdInputValue(value)
		self:_onOurIdInputValue(value)
	end

	self._inputId:AddOnValueChanged(onOurIdInputValue)

	local function onOurSkinInputValue(value)
		self:_onOurSkinInputValue(value)
	end

	self.skinInput:AddOnValueChanged(onOurSkinInputValue)

	local function onOurLvlInputValue(value)
		self:_onOurLvlInputValue(value)
	end

	self._inputLvl:AddOnValueChanged(onOurLvlInputValue)
	self._geniusInput:AddOnValueChanged(self._onGeniusChange, self)
	self._stargodInput:AddOnValueChanged(self._onStargodChange, self)
	self.contractInput:AddOnValueChanged(self._onContractInputChange, self)
	self.InputJuexing:AddOnValueChanged(self.onJuexingChange, self)
	self._equipInput:AddOnValueChanged(self._onEquipChange, self)
	self.skillLvlInput:AddOnValueChanged(self._onSkillLvlChange, self)
	self._buffInput:AddOnValueChanged(self._onBuffChange, self)
	self._extInput:AddOnValueChanged(self._onExtChange, self)
	self.btnChoose:AddOnValueChanged(self._onChoose, self)
end

function FightEditView:_onGeniusChange(value)
	FightModel.instance:setCreeGenius(self._type, self._idx, value)
end

function FightEditView:_onStargodChange(value)
	FightModel.instance:setCreeStargod(self._type, self._idx, value)
end

function FightEditView:_onContractInputChange(value)
	FightModel.instance:setContractSkill(self._type, self._idx, value)
end

function FightEditView:onJuexingChange(value)
	FightModel.instance:onJuexingChange(self._type, self._idx, value)
end

function FightEditView:_onEquipChange(value)
	FightModel.instance:setCreeEquip(self._type, self._idx, value)
end

function FightEditView:_onSkillLvlChange(value)
	FightModel.instance:setSkillLvl(self._type, self._idx, value)
end

function FightEditView:_onExtChange(value)
	FightModel.instance:setCreeExt(self._type, self._idx, value)
end

function FightEditView:_onBuffChange(value)
	FightModel.instance:setCreeBuff(self._type, self._idx, value)
end

function FightEditView:_onChoose(value)
	local creep = FightModel.instance:getData(self._type, self._idx)

	creep.onlyUseExtProperties = self.btnChoose.isOn
end

function FightEditView:_onLvlClick()
	local creep = FightModel.instance:getData(self._type, self._idx)

	creep.level = 100

	self:_initAllChild()
end

function FightEditView:_onClickDeleteMyPet()
	local creep = FightModel.instance:getData(self._type, self._idx)

	creep.myPetId = -1

	self:_initAllChild()
end

function FightEditView:_onClickSelectMyPet()
	local function filterFunc(petData)
		return true
	end

	PetSelectController.instance:OpenView(true, "选一个精灵 用于战斗", filterFunc, function(petId)
		local mo = BagModel.instance:getPet(petId)

		if mo then
			local creep = FightModel.instance:getData(self._type, self._idx)

			creep.raceId = mo.raceId
			creep.curFace = tostring(mo.curFaceId)
			creep.myPetId = petId
			creep.level = mo.level

			self:_initAllChild()
		end
	end, nil)
end

function FightEditView:_onTuijianAllClick()
	local creep = FightModel.instance:getData(self._type, self._idx)

	creep.level = 100
	creep.talentLevel = 10
	creep.awakenLv = 12
	creep.equipment = "&5#11"
	creep.runeSuit = "&5"

	self:_initAllChild()
end

function FightEditView:_onGeniusClick()
	local creep = FightModel.instance:getData(self._type, self._idx)

	creep.talentLevel = 10

	self:_initAllChild()
end

function FightEditView:_onStargodClick()
	local creep = FightModel.instance:getData(self._type, self._idx)

	creep.runeSuit = "&5"

	self:_initAllChild()
end

function FightEditView:_onEquipClick()
	local creep = FightModel.instance:getData(self._type, self._idx)

	creep.equipment = "&5#11"

	self:_initAllChild()
end

function FightEditView:_onQishiClick()
	local creep = FightModel.instance:getData(self._type, self._idx)
	local value = creep.extProperties
	local str = "起始气势+50"

	value = self:_replaceStr(value, str)

	FightModel.instance:setCreeExt(self._type, self._idx, value)

	self._extInput.input.text = creep.extProperties
end

function FightEditView:_onQishiClick2()
	local creep = FightModel.instance:getData(self._type, self._idx)
	local value = creep.extProperties
	local str = "起始气势+100"

	value = self:_replaceStr(value, str)

	FightModel.instance:setCreeExt(self._type, self._idx, value)

	self._extInput.input.text = creep.extProperties
end

function FightEditView:_onHpClick()
	local creep = FightModel.instance:getData(self._type, self._idx)
	local value = creep.extProperties
	local str = "生命+1000000"

	value = self:_replaceStr(value, str)

	FightModel.instance:setCreeExt(self._type, self._idx, value)

	self._extInput.input.text = creep.extProperties
end

function FightEditView:onSpeedClick()
	local creep = FightModel.instance:getData(self._type, self._idx)
	local value = creep.extProperties
	local str = "速度+99999"

	value = self:_replaceStr(value, str)

	FightModel.instance:setCreeExt(self._type, self._idx, value)

	self._extInput.input.text = creep.extProperties
end

function FightEditView:_replaceStr(value, str)
	local fstr = string.gsub(str, "[%[%]&=+%%%c%(%)]", function(c)
		return "%" .. c
	end)

	if string.find(value, fstr) ~= nil then
		value = string.gsub(value, "#" .. fstr, "")
		value = string.gsub(value, fstr .. "#", "")
		value = string.gsub(value, fstr, "")
	else
		value = value == "" and value .. str or value .. "#" .. str
	end

	return value
end

function FightEditView:unbindEvents()
	self._btnLvl:RemoveClickListener()
	self._btnTuijianAll:RemoveClickListener()
	self._btnGenius:RemoveClickListener()
	self._btnStargod:RemoveClickListener()
	self._btnEquip:RemoveClickListener()
	self._btnQishi:RemoveClickListener()
	self._BtnHp:RemoveClickListener()
	self.BtnQishi2:RemoveClickListener()
	self.BtnSpd:RemoveClickListener()
	self._editClosePanel:RemoveClickListener()
	self.btnChoose:RemoveOnValueChanged()
end

function FightEditView:_onOurIdInputValue(value)
	local petCO = CharacterConfig.instance:getPetCo(checknumber(value))

	if petCO == nil then
		FightModel.instance:setCreeRaceId(self._type, self._idx, 0)

		return nil
	end

	FightModel.instance:setCreeRaceId(self._type, self._idx, checknumber(value))
end

function FightEditView:_onOurSkinInputValue(value)
	self._txtName.text = ""

	local petCO = PetSkinConfig.instance:getPetSkinCfg(value)

	if petCO == nil then
		FightModel.instance:setCreeFaceId(self._type, self._idx, 0)
		FightModel.instance:setCreeName(self._type, self._idx, "")

		return nil
	end

	self._txtName.text = petCO.skinName

	FightModel.instance:setCreeFaceId(self._type, self._idx, value)
	FightModel.instance:setCreeName(self._type, self._idx, petCO.skinName)
end

function FightEditView:_onOurLvlInputValue(value)
	FightModel.instance:setCreeLevel(self._type, self._idx, checknumber(value))
end

function FightEditView:_initAllChild()
	local creep = FightModel.instance:getData(self._type, self._idx)

	self._inputId.input.text = creep.raceId
	self.skinInput.input.text = creep.curFace
	self._inputLvl.input.text = creep.level
	self._geniusInput.input.text = creep.talentLevel
	self._stargodInput.input.text = creep.runeSuit
	self.contractInput.input.text = creep.contractSkillId
	self.InputJuexing.input.text = creep.awakenLv
	self._equipInput.input.text = creep.equipment
	self._buffInput.input.text = creep.extBuffs
	self._extInput.input.text = creep.extProperties
	self.btnChoose.isOn = creep.onlyUseExtProperties
	self.skillLvlInput.input.text = creep.normalSkillLv + creep.ultimateSkillLv + creep.passiveSkillLv + creep.psychicedNormalSkillLv + creep.psychicedUltimateSkillLv > 0 and creep.normalSkillLv .. "#" .. creep.ultimateSkillLv .. "#" .. creep.passiveSkillLv .. "#" .. creep.psychicedNormalSkillLv .. "#" .. creep.psychicedUltimateSkillLv or ""
end

function FightEditView:onShowPanel(type, idx)
	self._type = type
	self._idx = idx

	self._editPanel:SetActive(true)
	self:_initAllChild()
end

function FightEditView:_onCloseClick()
	self._editPanel:SetActive(false)
	self:localNotify(FightModel.EVENT_IDX_UPDATE, {
		idx = self._idx,
		type = self._type
	})
end

return FightEditView
