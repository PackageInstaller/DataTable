-- chunkname: @modules/logic/battlepass/config/BpConfig.lua

module("modules.logic.battlepass.config.BpConfig", package.seeall)

local BpConfig = class("BpConfig", BaseConfig)

function BpConfig:ctor()
	self._taskBpId2List = {}
	self._taskBpId2Dict = {}
	self._bonusBpId2List = {}
	self._desDict = {}
	self._skinDict = {}
	self._headDict = {}
	self.taskPreposeIds = {}
	self._newItems = {}
end

function BpConfig:reqConfigNames()
	return {
		"bp",
		"bp_lv_bonus",
		"bp_task",
		"bp_des",
		"bp_update_popup",
		"bp_skin_view_param"
	}
end

function BpConfig:onConfigLoaded(configName, configTable)
	if configName == "bp_task" then
		for _, taskCO in ipairs(configTable.configList) do
			local bpId = taskCO.bpId
			local loopType = taskCO.loopType

			self._taskBpId2List[bpId] = self._taskBpId2List[bpId] or {}
			self._taskBpId2Dict[bpId] = self._taskBpId2Dict[bpId] or {}

			table.insert(self._taskBpId2List[bpId], taskCO)

			self._taskBpId2Dict[bpId][loopType] = self._taskBpId2Dict[bpId][loopType] or {}

			table.insert(self._taskBpId2Dict[bpId][loopType], taskCO)

			if not string.nilorempty(taskCO.prepose) then
				local preposeIds = string.splitToNumber(taskCO.prepose, "#")
				local dict = {}

				for _, id in pairs(preposeIds) do
					dict[id] = true
				end

				self.taskPreposeIds[taskCO.id] = dict
			end
		end

		local addPreIds

		function addPreIds(id, dict, preId)
			if id == preId then
				return
			end

			dict[preId] = true

			local preDict = self.taskPreposeIds[preId]

			if not preDict then
				return
			end

			for ppId in pairs(preDict) do
				if not dict[ppId] then
					addPreIds(id, dict, ppId)
				end
			end
		end

		for id, dict in pairs(self.taskPreposeIds) do
			for preId in pairs(dict) do
				addPreIds(id, dict, preId)
			end
		end
	elseif configName == "bp_lv_bonus" then
		for _, bonusCO in ipairs(configTable.configList) do
			local bpId = bonusCO.bpId

			self._bonusBpId2List[bpId] = self._bonusBpId2List[bpId] or {}

			table.insert(self._bonusBpId2List[bpId], bonusCO)
		end
	elseif configName == "bp_des" then
		for _, desCO in ipairs(configTable.configList) do
			local bpId = desCO.bpId
			local type = desCO.type

			self._desDict[bpId] = self._desDict[bpId] or {}
			self._desDict[bpId][type] = self._desDict[bpId][type] or {}

			table.insert(self._desDict[bpId][type], desCO)
			self:_processBonus(bpId, desCO.items)
		end
	end
end

function BpConfig:_processBonus(bpId, bonusStr)
	if string.nilorempty(bonusStr) then
		return
	end

	self._newItems[bpId] = self._newItems[bpId] or {}

	local dict = GameUtil.splitString2(bonusStr, true)

	for _, arr in pairs(dict) do
		if arr[1] == MaterialEnum.MaterialType.HeroSkin then
			self._skinDict[bpId] = arr[2]
		elseif arr[1] == MaterialEnum.MaterialType.Item then
			local itemCo = lua_item.configDict[arr[2]]

			if not itemCo then
				logError("道具配置不存在" .. tostring(arr[2]))
			end

			if itemCo and itemCo.subType == ItemEnum.SubType.Portrait then
				self._headDict[bpId] = arr[2]
			end
		end

		if arr[5] == 1 then
			table.insert(self._newItems[bpId], arr)
		end
	end
end

function BpConfig:getNewItems(bpId)
	return self._newItems[bpId] or {}
end

function BpConfig:getBpCO(bpId)
	return lua_bp.configDict[bpId]
end

function BpConfig:getTaskCO(taskId)
	return lua_bp_task.configDict[taskId]
end

function BpConfig:getTaskCOList(bpId)
	return self._taskBpId2List[bpId]
end

function BpConfig:getDesConfig(bpId, type)
	if not self._desDict[bpId] then
		return {}
	end

	return self._desDict[bpId][type]
end

function BpConfig:getCurSkinId(bpId)
	if not self._skinDict[bpId] then
		return 301703
	end

	return self._skinDict[bpId]
end

function BpConfig:getBpSkinBonusId(bpId)
	return self._skinDict[bpId]
end

function BpConfig:getCurHeadItemName(bpId)
	if not self._headDict[bpId] then
		return ""
	end

	local itemId = self._headDict[bpId]
	local itemCo = lua_item.configDict[itemId]

	return itemCo.name, itemId
end

function BpConfig:getTaskCOListByLoopType(bpId, loopType)
	local dict = self._taskBpId2Dict[bpId]

	if dict then
		return dict[loopType]
	end
end

function BpConfig:getBonusCO(bpId, level)
	local dict = lua_bp_lv_bonus.configDict[bpId]

	if dict then
		return dict[level]
	end
end

function BpConfig:getBonusCOList(bpId)
	return self._bonusBpId2List[bpId]
end

function BpConfig:getLevelScore(bpId)
	local co = self:getBpCO(bpId)

	if not co then
		return 1000
	end

	return co.expLevelUp
end

function BpConfig:getItemShowSize(itemType, itemId)
	if not self._itemSizeCo then
		local itemSizeCo = lua_const.configDict[ConstEnum.BpItemSize]
		local itemSizeStr = itemSizeCo and itemSizeCo.value

		self._itemSizeCo = {}

		if not string.nilorempty(itemSizeStr) then
			local arr = GameUtil.splitString2(itemSizeStr, true)

			for _, info in pairs(arr) do
				self._itemSizeCo[info[1]] = self._itemSizeCo[info[1]] or {}
				self._itemSizeCo[info[1]][info[2]] = {
					itemSize = info[3],
					x = info[4],
					y = info[5]
				}
			end
		end
	end

	if self._itemSizeCo[itemType] then
		local co = self._itemSizeCo[itemType][itemId]

		if co then
			return co.itemSize, co.x, co.y
		end

		return 1.2
	end
end

function BpConfig:getSpActId(fallback)
	return ActivityConfig.instance:getConstAsNum(ActivityEnum.ConstId.BpSpActId, fallback or VersionActivity2_2Enum.ActivityId.BPSP)
end

function BpConfig:getBpSkinViewParamCO(skilId)
	return bp_skin_view_param.configDict[skilId]
end

BpConfig.instance = BpConfig.New()

return BpConfig
