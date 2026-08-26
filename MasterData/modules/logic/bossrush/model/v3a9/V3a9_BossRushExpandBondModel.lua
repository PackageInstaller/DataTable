-- chunkname: @modules/logic/bossrush/model/v3a9/V3a9_BossRushExpandBondModel.lua

module("modules.logic.bossrush.model.v3a9.V3a9_BossRushExpandBondModel", package.seeall)

local V3a9_BossRushExpandBondModel = class("V3a9_BossRushExpandBondModel", BaseModel)

function V3a9_BossRushExpandBondModel:_initExpandBondGroup(actId)
	if not actId then
		return
	end

	self._expandBondGroupMos = self._expandBondGroupMos or {}

	if not self._expandBondGroupMos[actId] then
		self._expandBondGroupMos[actId] = {}

		local cos = BossRushConfig.instance:getExpandBondCosByActId(actId)

		if cos then
			for _, co in ipairs(cos) do
				local group = self._expandBondGroupMos[actId][co.groupId]

				if not group then
					group = V3a9_BossRushExpandBondGroupMO.New()

					group:init(co.groupId)

					self._expandBondGroupMos[actId][co.groupId] = group
				end

				local mo = V3a9_BossRushExpandBondMO.New()

				mo:init(co)
				group:AddMo(mo)
			end
		end

		for _, co in ipairs(lua_character.configList) do
			if co.isOnline == "1" then
				for _, mo in pairs(self._expandBondGroupMos[actId]) do
					mo:refreshHero(co.id)
				end
			end
		end
	end
end

function V3a9_BossRushExpandBondModel:getAllExpandBondGroup()
	local actId = BossRushConfig.instance:getActivityId(V3a9BossRushEnum.Mode.Act)

	if not actId then
		return
	end

	if not self._expandBondGroupMos or not self._expandBondGroupMos[actId] then
		self:_initExpandBondGroup(actId)
	end

	return self._expandBondGroupMos[actId]
end

function V3a9_BossRushExpandBondModel:getExpandBondGroupsList()
	if not self._expandBondGroupMoList then
		local expandBondGroupMos = self:getAllExpandBondGroup()

		self._expandBondGroupMoList = {}

		for _, mo in pairs(expandBondGroupMos) do
			table.insert(self._expandBondGroupMoList, mo)
		end
	end

	table.sort(self._expandBondGroupMoList, function(a, b)
		local a_curActiveMo = a:getCurActiveMo()
		local b_curActiveMo = b:getCurActiveMo()
		local a_config = a_curActiveMo and a_curActiveMo:getConfig()
		local b_config = b_curActiveMo and b_curActiveMo:getConfig()
		local a_backingIcon = a_config and tonumber(a_config.backingIcon) or 0
		local b_backingIcon = b_config and tonumber(b_config.backingIcon) or 0

		if a_backingIcon ~= b_backingIcon then
			return b_backingIcon < a_backingIcon
		end

		local a_curActiveNum = a:getCurActiveHeroNum()
		local b_curActiveNum = b:getCurActiveHeroNum()

		if a_curActiveNum ~= b_curActiveNum then
			return b_curActiveNum < a_curActiveNum
		end

		return a:getGroupId() < b:getGroupId()
	end)

	return self._expandBondGroupMoList
end

function V3a9_BossRushExpandBondModel:getExpandBondGroupMo(groupId)
	local actId = BossRushConfig.instance:getActivityId(V3a9BossRushEnum.Mode.Act)

	if not actId then
		return
	end

	if not self._expandBondGroupMos or not self._expandBondGroupMos[actId] then
		self:_initExpandBondGroup(actId)
	end

	return self._expandBondGroupMos[actId][groupId]
end

function V3a9_BossRushExpandBondModel:hasBossRushExpand()
	local groupMos = self:getAllExpandBondGroup()

	if groupMos then
		for _, mo in pairs(groupMos) do
			if mo:getCurActiveHeroNum() > 0 then
				return true
			end
		end
	end
end

function V3a9_BossRushExpandBondModel:refreshHeroList(heroList)
	local groupMos = self:getAllExpandBondGroup()

	if groupMos then
		for _, mo in pairs(groupMos) do
			mo:checkExpandBonds(heroList)
		end
	end
end

function V3a9_BossRushExpandBondModel:refreshExpandBondGroup()
	local stage = V3a9_BossRushModel.instance:getEnterActStage()
	local heroList = V3a9_BossRushModel.instance:getHeroIds(stage)

	self:refreshHeroList(heroList)
	V3a9_BossRushController.instance:dispatchEvent(V3a9_BossRushEvent.onRefreshExpandBond)
end

function V3a9_BossRushExpandBondModel:refreshEditorExpandBondGroup(heroList)
	self:refreshHeroList(heroList)
end

function V3a9_BossRushExpandBondModel:refreshAssestExpandBondGroup(assistMo)
	local heroIdList = V3a9_BossRushModel.instance:getEditorHeroIdList()

	if not heroIdList then
		return
	end

	local list = tabletool.copy(heroIdList)

	if assistMo then
		local pos = V3a9_BossRushModel.instance:getEditorAssistPos(assistMo.heroId)

		if pos then
			list[pos] = assistMo.heroId
		end
	end

	self:refreshHeroList(list)
end

function V3a9_BossRushExpandBondModel:getHeroExpandBondGroupsList(heroId)
	self._heroExpandBondGroups = self._heroExpandBondGroups or {}

	if not self._heroExpandBondGroups[heroId] then
		self:refreshHeroExpandBondGroupsList(heroId)
	end

	return self._heroExpandBondGroups[heroId]
end

function V3a9_BossRushExpandBondModel:refreshHeroExpandBondGroupsList(heroId)
	local groupMos = self:getExpandBondGroupsList()

	self._heroExpandBondGroups = self._heroExpandBondGroups or {}
	self._heroExpandBondGroups[heroId] = {}

	if groupMos then
		for i, mo in ipairs(groupMos) do
			if mo:isContainsHeroBattleTags(heroId) then
				table.insert(self._heroExpandBondGroups[heroId], mo)
			end
		end
	end
end

function V3a9_BossRushExpandBondModel:refreshAddBondGroupId()
	local groupMos = self:getAllExpandBondGroup()
	local maxCount = 0
	local list = {}
	local isAdd = false

	for _, mo in pairs(groupMos) do
		local num = mo:getRealActiveHeroNum()
		local groupId = mo:getGroupId()
		local tagType = mo:getTagType()

		if num > 0 then
			if tagType == V3a9BossRushEnum.TagType.BattleTag and not mo:isOverMaxLevel() then
				if maxCount < num then
					maxCount = num
					list = {
						groupId
					}
				elseif maxCount == num then
					table.insert(list, groupId)
				end
			end

			if V3a9BossRushEnum.SpecialExpandBondGroupId == groupId then
				isAdd = true
			end
		end
	end

	if #list == 0 or not isAdd then
		local isChange = not self._editorAddBondGroupId or self._editorAddBondGroupId ~= 0

		self._editorAddBondGroupId = 0

		if isChange then
			V3a9_BossRushController.instance:dispatchEvent(V3a9_BossRushEvent.onRefreshAddBondGroupId)
		end

		return
	end

	local index = 1

	if #list > 1 then
		index = Mathf.Random(1, #list)
	end

	local isChange = not self._editorAddBondGroupId or self._editorAddBondGroupId ~= list[index]

	self._editorAddBondGroupId = list[index] or 0

	if isChange then
		V3a9_BossRushController.instance:dispatchEvent(V3a9_BossRushEvent.onRefreshAddBondGroupId)
	end
end

function V3a9_BossRushExpandBondModel:getEditorAddBondGroupId()
	return self._editorAddBondGroupId or 0
end

function V3a9_BossRushExpandBondModel:setStageEditorAddBondGroupId()
	V3a9_BossRushController.instance:dispatchEvent(V3a9_BossRushEvent.onRefreshAddBondGroupId)
end

function V3a9_BossRushExpandBondModel:getBattleTagCos()
	if not self._tagCos then
		self._tagCos = {}
		self._tagGroupMos = {}

		local expandBondGroupMos = self:getAllExpandBondGroup()

		for _, mo in pairs(expandBondGroupMos) do
			local battleTags = mo:getBattleTags()
			local co, tag = self:_getOneBattleTags(battleTags)

			if co then
				local typeId = V3a9BossRushEnum.SearchFilterTagType[co.typeid]

				self._tagCos[typeId] = self._tagCos[typeId] or {}

				table.insert(self._tagCos[typeId], co)

				self._tagGroupMos[tag] = self._tagGroupMos[tag] or {}

				table.insert(self._tagGroupMos[tag], mo)
			end
		end

		for _, cos in pairs(self._tagCos) do
			table.sort(cos, function(a, b)
				return a.id < b.id
			end)
		end
	end

	return self._tagCos
end

function V3a9_BossRushExpandBondModel:_getOneBattleTags(tags)
	if not tags then
		return
	end

	if #tags then
		local co = lua_character_battle_tag.configDict[tostring(tags[1])]

		if co and not string.nilorempty(co.typeid) then
			return co, tags[1]
		end
	end

	for _, tag in ipairs(tags) do
		local co = lua_character_battle_tag.configDict[tostring(tag)]

		if co and not string.nilorempty(co.typeid) then
			return co, tag
		end
	end
end

V3a9_BossRushExpandBondModel.instance = V3a9_BossRushExpandBondModel.New()

return V3a9_BossRushExpandBondModel
