-- chunkname: @modules/logic/fight/view/preview/SkillEditorToolAutoPlaySkillModel.lua

module("modules.logic.fight.view.preview.SkillEditorToolAutoPlaySkillModel", package.seeall)

local SkillEditorToolAutoPlaySkillModel = class("SkillEditorToolAutoPlaySkillModel", ListScrollModel)

function SkillEditorToolAutoPlaySkillModel:onInit()
	self._selectList = {}
end

function SkillEditorToolAutoPlaySkillModel:setSelect(searchText)
	self:_buildCOList()

	local list = {}

	for key, config in pairs(self._dataList) do
		if key ~= SkillEditorMgr.SelectType.Group then
			for i, co in ipairs(config) do
				if not string.find(tostring(co.id), searchText) and not string.find(tostring(co.skinId), searchText) then
					if not string.find(co.name or "", searchText) then
						if string.find(FightConfig.instance:getSkinCO(co.skinId) and FightConfig.instance:getSkinCO(co.skinId).name or "", searchText) then
							local mo = {
								co = co,
								type = key,
								skinId = co.skinId
							}

							table.insert(list, mo)
						end
					end
				end
			end
		else
			for i, co in ipairs(config) do
				self:_cacheGroupNames()

				local groupMonsterName = self._groupId2NameDict[co.id]

				if groupMonsterName and string.find(groupMonsterName, searchText) then
					local mo = {
						co = co,
						type = key,
						skinId = co.skinId
					}

					table.insert(list, mo)
				end
			end
		end
	end

	self:setList(list)
end

function SkillEditorToolAutoPlaySkillModel:_buildCOList()
	self._dataList = {}
	self._dataList[SkillEditorMgr.SelectType.Hero] = self._dataList[SkillEditorMgr.SelectType.Hero] or {}

	tabletool.addValues(self._dataList[SkillEditorMgr.SelectType.Hero], lua_character.configList)

	local dict = {}
	local list = {}

	for _, monsterCO in ipairs(lua_monster.configList) do
		if not dict[monsterCO.skinId] then
			dict[monsterCO.skinId] = true

			table.insert(list, monsterCO)
		end
	end

	self._dataList[SkillEditorMgr.SelectType.Monster] = self._dataList[SkillEditorMgr.SelectType.Monster] or {}
	self._dataList[SkillEditorMgr.SelectType.Group] = self._dataList[SkillEditorMgr.SelectType.Group] or {}

	tabletool.addValues(self._dataList[SkillEditorMgr.SelectType.Monster], list)
	tabletool.addValues(self._dataList[SkillEditorMgr.SelectType.Group], lua_monster_group.configList)
	self:_cacheGroupNames()
end

function SkillEditorToolAutoPlaySkillModel:_cacheGroupNames()
	if self._groupId2NameDict then
		return
	end

	self._groupId2NameDict = {}

	for _, co in ipairs(lua_monster_group.configList) do
		local monsterIds = string.splitToNumber(co.monster, "#")
		local monsterCO = lua_monster.configDict[monsterIds[1]]

		for i = 2, #monsterIds do
			if tabletool.indexOf(string.splitToNumber(co.bossId, "#"), monsterIds[i]) then
				monsterCO = lua_monster.configDict[monsterIds[i]]

				break
			end
		end

		self._groupId2NameDict[co.id] = monsterCO and monsterCO.name
	end
end

function SkillEditorToolAutoPlaySkillModel:addSelect(mo)
	local existIndex = tabletool.indexOf(self._selectList, mo)

	if existIndex then
		self._list[existIndex] = mo
	else
		table.insert(self._selectList, mo)
	end
end

function SkillEditorToolAutoPlaySkillModel:removeSelect(mo)
	tabletool.removeValue(self._selectList, mo)
end

function SkillEditorToolAutoPlaySkillModel:getSelectList()
	return self._selectList
end

SkillEditorToolAutoPlaySkillModel.instance = SkillEditorToolAutoPlaySkillModel.New()

return SkillEditorToolAutoPlaySkillModel
