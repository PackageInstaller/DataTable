-- chunkname: @modules/logic/survival/model/SurvivalDifficultyModel.lua

module("modules.logic.survival.model.SurvivalDifficultyModel", package.seeall)

local SurvivalDifficultyModel = class("SurvivalDifficultyModel", ListScrollModel)

function SurvivalDifficultyModel:refreshDifficulty()
	self.difficultyList = self:getDifficultyList()

	local difficultyIndex = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SurvivalHardSelect, 1)
	local firstUnLock

	for i, v in ipairs(self.difficultyList) do
		if self:isUnLockDiff(v.id) then
			firstUnLock = i
		end
	end

	difficultyIndex = math.min(firstUnLock, difficultyIndex)
	self.difficultyIndex = difficultyIndex
	self.customSelectIndex = 1
	self.customDifficultyList = self:getCustomDifficultyList()
	self.customFragmentMoDic = {}
	self.customFragmentMos = {}
	self.customFragmentSelect = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SurvivalHardTempSelect, 1)

	local list = self:getCustomTempDiffIds()

	for i, difficultyId in ipairs(list) do
		local mo = SurvivalCustomFragmentMo.New()

		mo:setData(difficultyId, i)

		self.customFragmentMos[i] = mo
	end
end

function SurvivalDifficultyModel:setCustomFragmentSelect(index)
	if self.customFragmentSelect == index then
		return
	end

	self.customFragmentSelect = index

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SurvivalHardTempSelect, index)

	return true
end

function SurvivalDifficultyModel:getCustomFragmentSelect()
	return self.customFragmentSelect
end

function SurvivalDifficultyModel:getCustomDiffSelectIds()
	local mo = self.customFragmentMos[self.customFragmentSelect]

	return mo.tempDiffSelectIds
end

function SurvivalDifficultyModel:getCustomDifficulty()
	local mo = self.customFragmentMos[self.customFragmentSelect]

	return mo.customDifficulty
end

function SurvivalDifficultyModel:getCustomDifficultyDict()
	local mo = self.customFragmentMos[self.customFragmentSelect]

	return mo.customDifficultyDict
end

function SurvivalDifficultyModel:getDifficultyId()
	local diff = self.difficultyList[self.difficultyIndex]

	if diff and diff.id == SurvivalConst.CustomDifficulty then
		local list = self:getCustomTempDiffIds()

		return list[self.customFragmentSelect]
	end

	return (diff or nil) and (diff.id or 0)
end

function SurvivalDifficultyModel:isCustomFragment()
	return self:isCustomDifficulty() or self:isCustomTempDiff()
end

function SurvivalDifficultyModel:isCustomDifficulty()
	local difficultyId = self:getDifficultyId()

	return difficultyId == SurvivalConst.CustomDifficulty
end

function SurvivalDifficultyModel:isStoryDifficulty()
	local difficultyId = self:getDifficultyId()

	return difficultyId == SurvivalConst.StoryDifficulty
end

function SurvivalDifficultyModel:isCustomTempDiff()
	local difficultyId = self:getDifficultyId()
	local list = self:getCustomTempDiffIds()

	for i, id in ipairs(list) do
		if difficultyId == id then
			local cfg = lua_survival_hardness_mod.configDict[id]

			if cfg.subTab > 1 then
				return true
			end
		end
	end

	return false
end

function SurvivalDifficultyModel:changeDifficultyIndex(value)
	local animName
	local lastIsCustom = self:isCustomFragment()

	self.difficultyIndex = self.difficultyIndex + value

	if self.difficultyIndex < 1 then
		self.difficultyIndex = #self.difficultyList
	end

	if self.difficultyIndex > #self.difficultyList then
		self.difficultyIndex = 1
	end

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SurvivalHardSelect, self.difficultyIndex)

	local curIsCustom = self:isCustomFragment()

	if lastIsCustom and not curIsCustom then
		animName = "panel_out"
	elseif not lastIsCustom and curIsCustom then
		animName = "panel_in"
	elseif not lastIsCustom and not curIsCustom then
		animName = value > 0 and "switch_right" or "switch_left"
	end

	return animName
end

function SurvivalDifficultyModel:getArrowStatus()
	local left = self.difficultyIndex > 1
	local right = self.difficultyIndex < #self.difficultyList

	return left, right
end

function SurvivalDifficultyModel:getDifficultyList()
	local info = SurvivalModel.instance:getOutSideInfo()
	local list = {}

	for i, v in ipairs(lua_survival_hardness_mod.configList) do
		if v.id == SurvivalConst.CustomDifficulty and v.optional == 1 then
			table.insert(list, v)
		elseif v.optional == 1 and info:isUnlockDifficultyMod(v.id) then
			table.insert(list, v)
		end
	end

	table.sort(list, SortUtil.keyLower("id"))

	return list
end

function SurvivalDifficultyModel:getCustomDifficultyList()
	local list = {}

	for i, v in ipairs(lua_survival_hardness.configList) do
		if v.optional == 1 then
			list[v.type] = list[v.type] or {}
			list[v.type][v.subtype] = list[v.type][v.subtype] or {}

			table.insert(list[v.type][v.subtype], v)
		end
	end

	for type, typeList in pairs(list) do
		for subType, subList in pairs(typeList) do
			local levelMap = {}

			for _, config in ipairs(subList) do
				if levelMap[config.level] then
					logError(string.format("有相同等级的配置, type:%s subType:%s level:%s id:%s %s", type, subType, config.level, levelMap[config.level].id, config.id))
				end

				levelMap[config.level] = config
			end

			local newSubList = {}

			for level = 1, 5 do
				table.insert(newSubList, levelMap[level] or {})
			end

			typeList[subType] = newSubList
		end
	end

	return list
end

function SurvivalDifficultyModel:getDifficultyAssess()
	local list = self:getList()
	local assess = 0

	for _, v in pairs(list) do
		local hardId = v.hardId

		if hardId then
			local hardConfig = lua_survival_hardness.configDict[hardId]

			assess = assess + hardConfig.scoreRate
		end
	end

	return 1 + assess * 0.001
end

function SurvivalDifficultyModel:getDifficultyAssessByCustomTempDiff(tabIndex)
	local cfg = SurvivalConfig.instance:getCustomDiffBySubTab(tabIndex)
	local assess = 0
	local hardness = string.splitToNumber(cfg.hardness, "#")

	for _, hardId in ipairs(hardness) do
		local hardConfig = lua_survival_hardness.configDict[hardId]

		assess = assess + hardConfig.scoreRate
	end

	return 1 + assess * 0.001
end

function SurvivalDifficultyModel:getDifficultyShowList()
	local list = {}
	local diffConfig = lua_survival_hardness_mod.configDict[self:getDifficultyId()]
	local hardness = string.splitToNumber(diffConfig.hardness, "#")

	if hardness then
		for _, hardId in pairs(hardness) do
			table.insert(list, {
				hardId = hardId
			})
		end
	end

	if self:isCustomFragment() then
		local hardness = self:getCustomDifficulty()

		if hardness then
			for _, hardId in pairs(hardness) do
				table.insert(list, {
					hardId = hardId
				})
			end
		end
	end

	return list
end

function SurvivalDifficultyModel:refreshDifficultyShowList()
	local list = self:getDifficultyShowList()
	local filterList = self:filterSameTypeHard(list, true)
	local dataList = {}

	for _, v in ipairs(filterList) do
		local hardConfig = lua_survival_hardness.configDict[v.hardId]

		if hardConfig.isShow == 0 then
			table.insert(dataList, v)
		end
	end

	local listCount = #dataList

	if listCount < 4 then
		for i = listCount + 1, 4 do
			table.insert(dataList, {})
		end
	end

	self:setList(dataList)
end

function SurvivalDifficultyModel:filterSameTypeHard(list)
	local dataList = {}
	local typeSubtypeMap = {}

	for i, v in ipairs(list) do
		local hardId = v.hardId

		if hardId then
			local hardConfig = lua_survival_hardness.configDict[hardId]

			if hardConfig then
				local key = string.format("%s_%s", hardConfig.type, hardConfig.subtype)

				if typeSubtypeMap[key] then
					local existingConfig = lua_survival_hardness.configDict[typeSubtypeMap[key].hardId]

					if hardConfig.level > existingConfig.level then
						typeSubtypeMap[key] = v
					end
				else
					typeSubtypeMap[key] = v
				end
			end
		end
	end

	for i, v in ipairs(list) do
		local hardId = v.hardId

		if hardId then
			local hardConfig = lua_survival_hardness.configDict[hardId]

			if hardConfig then
				local key = string.format("%s_%s", hardConfig.type, hardConfig.subtype)

				if typeSubtypeMap[key] and typeSubtypeMap[key].hardId == hardId then
					table.insert(dataList, v)
				end
			end
		end
	end

	return dataList
end

function SurvivalDifficultyModel:sendDifficultyChoose(roleId, callback, callbackobj)
	local difficultyId = self:getDifficultyId()

	if self:isCustomFragment() then
		local list = self:getDifficultyShowList()
		local dataList = self:filterSameTypeHard(list)
		local hardness = {}

		if dataList then
			local diffConfig = lua_survival_hardness_mod.configDict[self:getDifficultyId()]
			local hardIds = string.splitToNumber(diffConfig.hardness, "#")

			for _, v in pairs(dataList) do
				local hardId = v.hardId

				if hardId then
					local hardConfig = lua_survival_hardness.configDict[hardId]

					if hardConfig and hardConfig.optional == 1 and not tabletool.indexOf(hardIds, hardId) then
						table.insert(hardness, hardId)
					end
				end
			end
		end

		SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(difficultyId, hardness, roleId, callback, callbackobj)
	else
		SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(difficultyId, nil, roleId, callback, callbackobj)
	end
end

function SurvivalDifficultyModel:setCustomSelectIndex(index)
	if self.customSelectIndex == index then
		return
	end

	self.customSelectIndex = index

	return true
end

function SurvivalDifficultyModel:getCustomSelectIndex()
	return self.customSelectIndex
end

function SurvivalDifficultyModel:getCustomDifficultyAssess(index, fragmentIndex)
	local hardness = self:getCustomDifficulty()
	local assess = 0

	if hardness then
		for _, hardId in pairs(hardness) do
			local config = lua_survival_hardness.configDict[hardId]

			if config and config.type == index then
				assess = assess + config.level
			end
		end
	end

	return assess
end

function SurvivalDifficultyModel:isSelectCustomDifficulty(hardId)
	local customDifficultyDict = self:getCustomDifficultyDict()

	return customDifficultyDict[hardId] ~= nil
end

function SurvivalDifficultyModel:selectCustomDifficulty(hardId)
	local curConfig = lua_survival_hardness.configDict[hardId]
	local removeIndex, removeHard
	local customDifficulty = self:getCustomDifficulty()
	local customDifficultyDict = self:getCustomDifficultyDict()
	local isSelect

	for i, v in ipairs(customDifficulty) do
		if v ~= hardId then
			local config = lua_survival_hardness.configDict[v]

			if curConfig.type == config.type and curConfig.subtype == config.subtype then
				removeIndex = i
				removeHard = v

				break
			end
		end
	end

	if removeIndex then
		customDifficultyDict[removeHard] = nil

		table.remove(customDifficulty, removeIndex)
	end

	if self:isSelectCustomDifficulty(hardId) then
		customDifficultyDict[hardId] = nil

		tabletool.removeValue(customDifficulty, hardId)

		isSelect = true
	else
		customDifficultyDict[hardId] = true

		if not tabletool.indexOf(customDifficulty, hardId) then
			table.insert(customDifficulty, hardId)
		end

		isSelect = false
	end

	self:saveCustomHard()

	return true, isSelect
end

function SurvivalDifficultyModel:saveCustomHard()
	local mo = self.customFragmentMos[self.customFragmentSelect]

	mo:saveCustomHard()
end

function SurvivalDifficultyModel:getCustomTempDiffIds()
	if self.templaterIds == nil then
		self.templaterIds = SurvivalConfig.instance:getCustomDiffIds()
	end

	return self.templaterIds
end

function SurvivalDifficultyModel:markBtnDiff()
	local marks = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.SurvivalDiffNewButtonMark, "")
	local list = not string.nilorempty(marks) and string.splitToNumber(marks, "#") or {}
	local info = SurvivalModel.instance:getOutSideInfo()
	local ids = self:getCustomTempDiffIds()

	for i, id in ipairs(ids) do
		if info:isUnlockDifficultyMod(id) and not tabletool.indexOf(list, id) then
			table.insert(list, id)
		end
	end

	local str = ""

	for i, v in ipairs(list) do
		str = i == 1 and v or str .. "#" .. v
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.SurvivalDiffNewButtonMark, str)
end

function SurvivalDifficultyModel:haveBtnNewDiff()
	local marks = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.SurvivalDiffNewButtonMark, "")
	local list

	if not string.nilorempty(marks) then
		list = string.splitToNumber(marks, "#")
	end

	local ids = self:getCustomTempDiffIds()

	for i, id in ipairs(ids) do
		local info = SurvivalModel.instance:getOutSideInfo()

		if info:isUnlockDifficultyMod(id) then
			local have = false

			if list then
				for _, v in ipairs(list) do
					if v == id then
						have = true

						break
					end
				end
			end

			if not have then
				return true
			end
		end
	end
end

function SurvivalDifficultyModel:isUnLockDiff(id)
	return SurvivalModel.instance:getOutSideInfo():isUnlockDifficultyMod(id)
end

function SurvivalDifficultyModel:isNewDiff(id)
	local newDiffIds = SurvivalModel.instance:getOutSideInfo().newDiffIds

	return LuaUtil.tableContains(newDiffIds, id)
end

function SurvivalDifficultyModel:markNewCustomDiff()
	SurvivalOutSideRpc.instance:sendSurvivalMarkModNotNewRequest({
		SurvivalConst.CustomDifficulty
	}, function()
		local newDiffIds = SurvivalModel.instance:getOutSideInfo().newDiffIds

		tabletool.removeValue(newDiffIds, SurvivalConst.CustomDifficulty)
	end)
end

function SurvivalDifficultyModel:markNewDiffs()
	local newDiffIds = SurvivalModel.instance:getOutSideInfo().newDiffIds
	local t = {}

	for i, v in ipairs(newDiffIds) do
		if v ~= SurvivalConst.CustomDifficulty then
			table.insert(t, v)
		end
	end

	if #t > 0 then
		SurvivalOutSideRpc.instance:sendSurvivalMarkModNotNewRequest(t, function()
			SurvivalModel.instance:getOutSideInfo().newDiffIds = {}
		end)
	end
end

SurvivalDifficultyModel.instance = SurvivalDifficultyModel.New()

return SurvivalDifficultyModel
