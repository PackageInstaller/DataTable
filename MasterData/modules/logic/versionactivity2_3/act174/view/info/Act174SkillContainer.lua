-- chunkname: @modules/logic/versionactivity2_3/act174/view/info/Act174SkillContainer.lua

module("modules.logic.versionactivity2_3.act174.view.info.Act174SkillContainer", package.seeall)

local Act174SkillContainer = class("Act174SkillContainer", LuaCompBase)

function Act174SkillContainer:init(go)
	self._goskills = gohelper.findChild(go, "line/go_skills")
	self._skillitems = self:getUserDataTb_()

	for i = 1, 3 do
		local item = gohelper.findChild(self._goskills, "skillicon" .. tostring(i))
		local o = {}

		o.icon = gohelper.findChildSingleImage(item, "imgIcon")
		o.tag = gohelper.findChildSingleImage(item, "tag/tagIcon")
		o.btn = gohelper.findChildButtonWithAudio(item, "bg", AudioEnum.UI.Play_ui_role_description)
		o.index = i

		o.btn:AddClickListener(self._onSkillCardClick, self, o.index)

		self._skillitems[i] = o
	end
end

function Act174SkillContainer:onDestroy()
	for i = 1, 3 do
		self._skillitems[i].btn:RemoveClickListener()
		self._skillitems[i].icon:UnLoadImage()
		self._skillitems[i].tag:UnLoadImage()
	end
end

function Act174SkillContainer:onUpdateMO(heroCo)
	self._roleId = heroCo.id
	self._heroId = heroCo.heroId
	self._heroName = heroCo.name

	self:_refreshSkillUI()
end

function Act174SkillContainer:_refreshSkillUI()
	if self._roleId then
		local skillIdDict = Activity174Config.instance:getHeroSkillIdDic(self._roleId, true)

		for i, skillId in pairs(skillIdDict) do
			local skillCO = lua_skill.configDict[skillId]

			if not skillCO then
				logError(string.format("heroID : %s, skillId not found : %s", self._roleId, skillId))
			end

			self._skillitems[i].icon:LoadImage(ResUrl.getSkillIcon(skillCO.icon))
			self._skillitems[i].tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillCO.showTag))
			gohelper.setActive(self._skillitems[i].tag.gameObject, i ~= 3)
		end
	end
end

function Act174SkillContainer:_onSkillCardClick(index)
	if self._roleId then
		local info = {}
		local skillDict = Activity174Config.instance:getHeroSkillIdDic(self._roleId)

		info.super = index == 3
		info.skillIdList = skillDict[index]
		info.isBalance = false
		info.monsterName = self._heroName
		info.heroId = self._heroId
		info.skillIndex = index

		ViewMgr.instance:openView(ViewName.SkillTipView, info)
	end
end

return Act174SkillContainer
