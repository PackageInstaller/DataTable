-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTalentPetItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTalentPetItem", package.seeall)

local Rouge2_BackpackTalentPetItem = class("Rouge2_BackpackTalentPetItem", LuaCompBase)

function Rouge2_BackpackTalentPetItem:init(go)
	self.go = go
	self._goPetEffectRoot = gohelper.findChild(self.go, "#go_PetEffectRoot")
	self._txtPetName = gohelper.findChildText(self.go, "#txt_PetName")
	self._goSkillList = gohelper.findChild(self.go, "#go_SkillList")
	self._goSkillItem = gohelper.findChild(self.go, "#go_SkillList/#go_SkillItem")
	self._initInfoDone = false

	self:initSkillList()
	self:initPetEffect()
end

function Rouge2_BackpackTalentPetItem:initSkillList()
	self._skillItemTab = self:getUserDataTb_()

	for i = 1, Rouge2_Enum.MaxActiveSkillNum do
		local goSkill = gohelper.cloneInPlace(self._goSkillItem, "skill_" .. i)
		local skillItem = MonoHelper.addNoUpdateLuaComOnceToGo(goSkill, Rouge2_BackpackTalentPetSkillItem, i)

		skillItem:onUpdateMO()

		self._skillItemTab[i] = skillItem
	end

	gohelper.setActive(self._goSkillItem, false)
end

function Rouge2_BackpackTalentPetItem:initPetEffect()
	self._isLoadPetDone = false
	self._effectTab = self:getUserDataTb_()
	self._petLoader = PrefabInstantiate.Create(self._goPetEffectRoot)

	self._petLoader:startLoad(Rouge2_Enum.ResPath.BackpackPet, self._onLoadPetEffectDone, self)
end

function Rouge2_BackpackTalentPetItem:_onLoadPetEffectDone()
	self._isLoadPetDone = true
	self._goPetEffect = self._petLoader:getInstGO()

	for i = 1, math.huge do
		local goLevelEffect = gohelper.findChild(self._goPetEffect, "#lv" .. i)

		if gohelper.isNil(goLevelEffect) then
			break
		end

		self._effectTab[i] = goLevelEffect

		gohelper.setActive(goLevelEffect, false)
	end

	self:refreshPetEffect()
end

function Rouge2_BackpackTalentPetItem:onUpdateMO()
	self._talentId, self._talentIndex = Rouge2_BackpackModel.instance:getLastTransformTalentId()
	self._talentCo = Rouge2_CareerConfig.instance:getTalentConfig(self._talentId)
	self._initInfoDone = true
	self._txtPetName.text = self._talentCo and self._talentCo.name

	self:refreshPetEffect()
end

function Rouge2_BackpackTalentPetItem:refreshPetEffect()
	if not self._isLoadPetDone or not self._initInfoDone then
		return
	end

	self:activeTargetLevelEffect(self._talentIndex)
end

function Rouge2_BackpackTalentPetItem:activeTargetLevelEffect(targetLevel)
	targetLevel = targetLevel or 1

	for i, goEffect in pairs(self._effectTab) do
		gohelper.setActive(goEffect, i == targetLevel)
	end
end

return Rouge2_BackpackTalentPetItem
