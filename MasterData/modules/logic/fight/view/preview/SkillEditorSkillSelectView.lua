-- chunkname: @modules/logic/fight/view/preview/SkillEditorSkillSelectView.lua

module("modules.logic.fight.view.preview.SkillEditorSkillSelectView", package.seeall)

local SkillEditorSkillSelectView = class("SkillEditorSkillSelectView")

function SkillEditorSkillSelectView:ctor()
	self._curSkillId = nil
	self._attackerId = nil
	self._entityMO = nil
	self._clickMask = nil
	self._skillIds = {}
	self._skillItemGOs = {}
end

function SkillEditorSkillSelectView:init(go)
	self._selectSkillGO = gohelper.findChild(go, "btnSelectSkill")
	self._txtSelect = gohelper.findChildText(go, "btnSelectSkill/Text")
	self.scrollView = gohelper.findChild(go, "skillScroll")
	self._skillsGO = gohelper.findChild(go, "skillScroll/Viewport/selectSkills")
	self._skillItemPrefab = gohelper.findChild(go, "skillScroll/Viewport/selectSkills/skill")
	self._clickMask = gohelper.findChildClick(go, "skillScroll/ClickMask")

	self._clickMask:AddClickListener(self._onClickMask, self)
	gohelper.setActive(self._skillItemPrefab, false)
end

function SkillEditorSkillSelectView:dispose()
	self._clickMask:RemoveClickListener()

	for _, skillItemGO in ipairs(self._skillItemGOs) do
		SLFramework.UGUI.UIClickListener.Get(skillItemGO):RemoveClickListener()
	end
end

function SkillEditorSkillSelectView:show()
	gohelper.setActive(self.scrollView, true)
	recthelper.setAnchorX(self._skillsGO.transform, 0)
	self:_updateSelect()
end

function SkillEditorSkillSelectView:hide()
	gohelper.setActive(self.scrollView, false)
end

function SkillEditorSkillSelectView:getSelectSkillId()
	return self._curSkillId
end

function SkillEditorSkillSelectView:setAttacker(entityId)
	local last_entity_mo = FightDataHelper.entityMgr:getById(self._attackerId)

	self._attackerId = entityId
	self._entityMO = FightDataHelper.entityMgr:getById(self._attackerId)
	self._skillIds = {}

	if last_entity_mo then
		if last_entity_mo.modelId == self._entityMO.modelId then
			-- block empty
		else
			self._curSkillId = nil
		end
	else
		self._curSkillId = nil
	end

	local skillCOList = self:_getEntitySkillCOList(self._entityMO)

	for i, skillCO in ipairs(skillCOList) do
		local skillId = skillCO.id
		local timeline = FightConfig.instance:getSkinSkillTimeline(self._entityMO.skin, skillId)

		table.insert(self._skillIds, skillId)

		if not self._curSkillId then
			self._curSkillId = skillId
			SkillEditorView.selectSkillId[entityId] = self._curSkillId
		end

		local skillItemGO = self._skillItemGOs[i]

		if not skillItemGO then
			skillItemGO = gohelper.clone(self._skillItemPrefab, self._skillsGO, "skill" .. i)

			table.insert(self._skillItemGOs, skillItemGO)
		end

		SLFramework.UGUI.UIClickListener.Get(skillItemGO):AddClickListener(self._onClickSkillItem, self, skillId)
		gohelper.setActive(skillItemGO, true)

		local txtSkillName = gohelper.findChildText(skillItemGO, "Text")
		local temp = string.split(timeline, "_")
		local tag = self:_getStrengthenTag(self._entityMO.modelId, skillId) or ""

		txtSkillName.text = skillId .. "\n" .. skillCO.name .. "\n" .. temp[#temp] .. tag
	end

	for i = #skillCOList + 1, #self._skillItemGOs do
		gohelper.setActive(self._skillItemGOs[i], false)
	end

	self:_updateSelect()
end

local ExKey = {
	"skillGroup1",
	"skillGroup2",
	"skillEx",
	"passiveSkill"
}

function SkillEditorSkillSelectView:_getStrengthenTag(modelId, skillId)
	local exList = lua_skill_ex_level.configDict[modelId]

	if exList then
		for _, exCO in pairs(exList) do
			for _, exKey in ipairs(ExKey) do
				local skillStr = exCO[exKey]
				local list = string.splitToNumber(skillStr, "|")

				if tabletool.indexOf(list, skillId) then
					return "塑造" .. exCO.skillLevel
				end
			end
		end
	end
end

function SkillEditorSkillSelectView:_getEntitySkillCOList(entityMO)
	local skillEffectDict = {}
	local list = {}

	for i, skillId in ipairs(entityMO.skillIds) do
		local skillCO = lua_skill.configDict[skillId]
		local timeline = FightConfig.instance:getSkinSkillTimeline(entityMO.skin, skillId)

		if skillCO and not string.nilorempty(timeline) then
			skillEffectDict[skillCO.skillEffect] = true

			table.insert(list, skillCO)
		end
	end

	local modelIdStr = tostring(entityMO.modelId)

	for _, skillCO in ipairs(lua_skill.configList) do
		local skillIdStr = tostring(skillCO.id)
		local timeline = skillCO.timeline

		if string.find(skillIdStr, modelIdStr) == 1 and not string.nilorempty(timeline) and not skillEffectDict[skillCO.skillEffect] then
			skillEffectDict[skillCO.skillEffect] = true

			table.insert(list, skillCO)
		end
	end

	return list
end

function SkillEditorSkillSelectView:_onClickMask()
	gohelper.setActive(self.scrollView, false)
end

function SkillEditorSkillSelectView:_onClickSkillItem(skillId)
	TaskDispatcher.cancelTask(self.hide, self)
	TaskDispatcher.runDelay(self.hide, self, 0.2)

	self._curSkillId = skillId
	SkillEditorView.selectSkillId[self._attackerId] = self._curSkillId

	self:_updateSelect()
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectSkill, self._entityMO, skillId)
end

function SkillEditorSkillSelectView:_updateSelect()
	for i, skillId in ipairs(self._skillIds) do
		local skillItemGO = self._skillItemGOs[i]

		if skillItemGO then
			local selectGO = gohelper.findChild(skillItemGO, "imgSelect")

			gohelper.setActive(selectGO, skillId == self._curSkillId)
		end
	end

	local skillCO = lua_skill.configDict[self._curSkillId]

	if skillCO then
		local timeline = FightConfig.instance:getSkinSkillTimeline(self._entityMO.skin, self._curSkillId)
		local temp = string.split(timeline, "_")

		self._txtSelect.text = self._curSkillId .. "\n" .. skillCO.name .. "\n" .. temp[#temp]
	else
		self._txtSelect.text = "None"
	end
end

return SkillEditorSkillSelectView
