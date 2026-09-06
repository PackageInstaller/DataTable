-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/growup/view/HeartGrowUpTipView.lua

module("logic.extensions.growup.view.HeartGrowUpTipView", package.seeall)

local HeartGrowUpTipView = class("HeartGrowUpTipView", ViewComponent)

function HeartGrowUpTipView:unbindEvents()
	HeartGrowUpTipView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
	self._enterBtn:RemoveClickListener()
end

function HeartGrowUpTipView:bindEvents()
	HeartGrowUpTipView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._cancelBtn:AddClickListener(self.close, self)
	self._enterBtn:AddClickListener(self._onClickEnter, self)
end

function HeartGrowUpTipView:buildUI()
	HeartGrowUpTipView.super.buildUI(self)

	self._title = self:getTxt("txtTitle")
	self._desc = self:getTxt("bg/desc")
	self._old = self:getTxt("bg/old")
	self._oldPotential = self:getGo("bg/old/potential")
	self._oldPotentialLv = goutil.findChildTextComponent(self._oldPotential, "txtLevel")
	self._new = self:getTxt("bg/new")
	self._newPotential = self:getGo("bg/new/potential")
	self._newPotentialLv = goutil.findChildTextComponent(self._newPotential, "txtLevel")
	self._oldPower = self:getTxt("bg/oldPower")
	self._newPower = self:getTxt("bg/newPower")
	self._closeBtn = self:getBtn("closeBtn")
	self._cancelBtn = self:getBtn("cancelBtn")
	self._enterBtn = self:getBtn("enterBtn")
end

function HeartGrowUpTipView:onExit()
	HeartGrowUpTipView.super.onExit(self)
	GlobalDispatcher:removeListener(GrowUpRoadController.PM_PetGrowthPathStrengthenRes, self.close, self)
end

function HeartGrowUpTipView:onEnter()
	HeartGrowUpTipView.super.onEnter(self)

	local _openParam = self:getOpenParam()

	self._petInfo = _openParam[2]
	self._activityId = _openParam[3]
	self._strengthPlan = GrowUpRoadConfig.instance:getStrengthById(_openParam[4])

	goutil.setActive(self._oldPotential, _openParam[1] == GameEnum.GrowUpRoad.Potential)
	goutil.setActive(self._newPotential, _openParam[1] == GameEnum.GrowUpRoad.Potential)

	if self._petInfo.sham then
		self:_updateCfgPet()
	else
		self:_updateLocalPet()
	end

	GlobalDispatcher:addListener(GrowUpRoadController.PM_PetGrowthPathStrengthenRes, self.close, self)
end

function HeartGrowUpTipView:_updateLocalPet()
	self._oldPower.text = lang("pet_power") .. "+" .. self._petInfo:getFightingPower()

	local newInfo = clone(self._petInfo)
	local _openParam = self:getOpenParam()

	if _openParam[1] == GameEnum.GrowUpRoad.Lv then
		self._old.text = "Lv. " .. self._petInfo.curLv
		self._title.text = string.format(lang("heart_grow_up_tip_title"), lang("tip_level"))
		self._desc.text = string.format(lang("heart_grow_up_tip_desc"), self._strengthPlan[1].needScore, lang("tip_level"))
		newInfo.curLv = CharacterConfig.instance:GetMaxLevel(newInfo.raceId)
		newInfo.level = newInfo.curLv
		self._new.text = "Lv." .. newInfo.curLv
	elseif _openParam[1] == GameEnum.GrowUpRoad.Star then
		local maxLv = 1

		for i, starGod in ipairs(self._petInfo.starGodPlusSlots) do
			local Lv = StargodplusModel.instance:getSlotLv(i, starGod.exp)

			if maxLv < Lv then
				maxLv = Lv
			end
		end

		self._old.text = lang("tip_stargod") .. "Lv. " .. maxLv
		self._title.text = string.format(lang("heart_grow_up_tip_title"), lang("tip_stargod"))
		self._desc.text = string.format(lang("heart_grow_up_tip_desc"), self._strengthPlan[2].needScore, lang("tip_stargod"))
		maxLv = 0

		for i, starGod in ipairs(newInfo.starGodPlusSlots) do
			local cfg = StargodplusConfig.instance:getSlotCfg(i)
			local planCfg = StargodplusConfig.instance:getSlotLvPlan(cfg.slotLvPlan)

			starGod.exp = planCfg[#planCfg].exp

			local Lv = StargodplusModel.instance:getSlotLv(i, starGod.exp)

			if maxLv < Lv then
				maxLv = Lv
			end
		end

		self._new.text = lang("tip_stargod") .. "Lv." .. maxLv
	elseif _openParam[1] == GameEnum.GrowUpRoad.Potential then
		self._old.text = lang("tip_potential")
		self._oldPotentialLv.text = math.max(math.max(self._petInfo.normalSkillLv, self._petInfo.ultimateSkillLv), self._petInfo.passiveSkillLv)
		self._title.text = string.format(lang("heart_grow_up_tip_title"), lang("tip_potential"))
		self._desc.text = string.format(lang("heart_grow_up_tip_desc"), self._strengthPlan[4].needScore, lang("tip_potential"))

		local Passive = BagPetsController.instance:getPetSkillMaxLevel(newInfo.raceId, GameEnum.SkillRaceType.Passive)
		local Normal = BagPetsController.instance:getPetSkillMaxLevel(newInfo.raceId, GameEnum.SkillRaceType.Normal)
		local Ult = BagPetsController.instance:getPetSkillMaxLevel(newInfo.raceId, GameEnum.SkillRaceType.Ult)

		newInfo.normalSkillLv = Normal
		newInfo.passiveSkillLv = Passive
		newInfo.ultimateSkillLv = Ult
		self._new.text = lang("tip_potential")
		self._newPotentialLv.text = math.max(math.max(Passive, Normal), Ult)
	elseif _openParam[1] == GameEnum.GrowUpRoad.Awake then
		self._old.text = self._petInfo.awakeLevel == 0 and lang("tip_null_awake") or lang("tip_awake") .. GameEnum.RomanNumber[self._petInfo.awakeLevel]
		self._title.text = string.format(lang("heart_grow_up_tip_title"), lang("tip_awake"))
		self._desc.text = string.format(lang("heart_grow_up_tip_desc"), self._strengthPlan[5].needScore, lang("tip_awake"))
		newInfo.awakeLevel = CharacterConfig.instance:getMaxAwaken(newInfo.raceId)
		self._new.text = lang("tip_awake") .. GameEnum.RomanNumber[newInfo.awakeLevel]
	end

	newInfo:calcAllAttr()

	self._newPower.text = lang("pet_power") .. "+" .. newInfo:getFightingPower()
end

function HeartGrowUpTipView:_updateCfgPet()
	self._oldPower.text = lang("pet_power") .. "+" .. self._petInfo:getFightingPower()

	local _openParam = self:getOpenParam()

	if _openParam[1] == GameEnum.GrowUpRoad.Lv then
		self._old.text = "Lv. " .. self._petInfo.level
		self._title.text = string.format(lang("heart_grow_up_tip_title"), lang("tip_level"))
		self._desc.text = string.format(lang("heart_grow_up_tip_desc"), self._strengthPlan[1].needScore, lang("tip_level"))
		self._new.text = "Lv." .. self._petInfo.maxLv
	elseif _openParam[1] == GameEnum.GrowUpRoad.Star then
		self._old.text = lang("tip_stargod") .. "Lv. 1"
		self._title.text = string.format(lang("heart_grow_up_tip_title"), lang("tip_stargod"))
		self._desc.text = string.format(lang("heart_grow_up_tip_desc"), self._strengthPlan[2].needScore, lang("tip_stargod"))
		self._new.text = lang("tip_stargod") .. "Lv. 50"
	elseif _openParam[1] == GameEnum.GrowUpRoad.Potential then
		self._old.text = lang("tip_potential")
		self._oldPotentialLv.text = 1
		self._title.text = string.format(lang("heart_grow_up_tip_title"), lang("tip_potential"))
		self._desc.text = string.format(lang("heart_grow_up_tip_desc"), self._strengthPlan[4].needScore, lang("tip_potential"))
		self._new.text = lang("tip_potential")
		self._newPotentialLv.text = 5
	elseif _openParam[1] == GameEnum.GrowUpRoad.Awake then
		self._old.text = lang("tip_null_awake")
		self._title.text = string.format(lang("heart_grow_up_tip_title"), lang("tip_awake"))
		self._desc.text = string.format(lang("heart_grow_up_tip_desc"), self._strengthPlan[5].needScore, lang("tip_awake"))

		local awakeLevel = CharacterConfig.instance:getMaxAwaken(self._petInfo.raceId)

		self._new.text = lang("tip_awake") .. GameEnum.RomanNumber[awakeLevel]
	end

	self._newPower.text = lang("pet_power") .. "+" .. self._petInfo.sham.power[GrowUpRoadModel.instance:getCurStrengthenType() + 2]
end

function HeartGrowUpTipView:_onClickEnter()
	if self._petInfo.sham then
		PetGrowthPathAgent.instance:sendPM_PetGrowthPathStrengthenReq(self._activityId, -1)
	else
		PetGrowthPathAgent.instance:sendPM_PetGrowthPathStrengthenReq(self._activityId, self._petInfo.petId)
	end
end

return HeartGrowUpTipView
