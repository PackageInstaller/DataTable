-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/model/VersionActivity1_2DungeonModel.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.model.VersionActivity1_2DungeonModel", package.seeall)

local VersionActivity1_2DungeonModel = class("VersionActivity1_2DungeonModel", BaseModel)

function VersionActivity1_2DungeonModel:onInit()
	return
end

function VersionActivity1_2DungeonModel:reInit()
	return
end

function VersionActivity1_2DungeonModel:getTrapPutting()
	return self.putTrap ~= 0 and self.putTrap
end

function VersionActivity1_2DungeonModel:onReceiveGet116InfosReply(proto)
	self._activity_id = proto.activityId
	self.element_data = {}

	for i, v in ipairs(proto.infos) do
		local element_id = v.elementId
		local tab = {}

		tab.elementId = v.elementId
		tab.level = v.level
		self.element_data[element_id] = tab
	end

	self.trapIds = {}

	for i, v in ipairs(proto.trapIds) do
		self.trapIds[v] = v
	end

	self.putTrap = proto.putTrap
	self.spStatus = {}

	for i, v in ipairs(proto.spStatus) do
		local episodeId = v.episodeId
		local tab = {}

		tab.episodeId = v.episodeId
		tab.chapterId = v.chapterId
		tab.status = v.status
		tab.refreshTime = v.refreshTime
		self.spStatus[episodeId] = tab
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveGet116InfosReply)
end

function VersionActivity1_2DungeonModel:getSpStatus(episodeId)
	return self.spStatus and self.spStatus[episodeId]
end

function VersionActivity1_2DungeonModel:onReceiveAct116InfoUpdatePush(proto)
	self.newSp = {}

	for i, v in ipairs(proto.spStatus) do
		if self.spStatus then
			if v.status == 1 and self.spStatus[v.episodeId].status ~= 1 then
				self.newSp[v.episodeId] = true
			end
		else
			self.newSp[v.episodeId] = true
		end
	end

	self:onReceiveGet116InfosReply(proto)
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveAct116InfoUpdatePush)
end

function VersionActivity1_2DungeonModel:onReceiveUpgradeElementReply(proto)
	self.element_data = self.element_data or {}
	self.element_data[proto.elementId] = {}
	self.element_data[proto.elementId].elementId = proto.elementId
	self.element_data[proto.elementId].level = proto.level

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveUpgradeElementReply, proto.elementId)
end

function VersionActivity1_2DungeonModel:getElementData(id)
	return self.element_data and self.element_data[id]
end

function VersionActivity1_2DungeonModel:onReceiveBuildTrapReply(proto)
	self.trapIds = self.trapIds or {}
	self.trapIds[proto.trapId] = proto.trapId

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveBuildTrapReply, proto.trapId)
end

function VersionActivity1_2DungeonModel:onReceivePutTrapReply(proto)
	self.putTrap = proto.trapId

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceivePutTrapReply)
end

function VersionActivity1_2DungeonModel:getCurActivityID()
	return self._activity_id or VersionActivity1_2Enum.ActivityId.Dungeon
end

function VersionActivity1_2DungeonModel:getAttrUpDic()
	local _configList = {}

	for k, v in pairs(self.element_data) do
		if v.level > 0 then
			local configList = VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(v.elementId)

			for index, config in pairs(configList) do
				if config.level == v.level then
					table.insert(_configList, config)

					break
				end
			end
		end
	end

	local upDic = {}

	for i, config in ipairs(_configList) do
		if config.buildingType == 2 then
			local arr = string.split(config.configType, "|")

			for index, attrStr in ipairs(arr) do
				local attrData = string.splitToNumber(attrStr, "#")
				local attrId = attrData[1]
				local addValue = attrData[2]

				upDic[attrId] = (upDic[attrId] or 0) + addValue
			end
		end
	end

	return upDic
end

function VersionActivity1_2DungeonModel:getBuildingGainList()
	local _configList = {}

	if self.element_data then
		for k, v in pairs(self.element_data) do
			if v.level > 0 then
				local configList = VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(v.elementId)

				for index, config in pairs(configList) do
					if (config.buildingType == 2 or config.buildingType == 3) and config.level == v.level then
						table.insert(_configList, config)

						break
					end
				end
			end
		end
	end

	if self.putTrap ~= 0 then
		table.insert(_configList, lua_activity116_building.configDict[self.putTrap])
	end

	return _configList
end

function VersionActivity1_2DungeonModel:haveNextLevel(elementId)
	local elementData = self:getElementData(elementId)

	if not elementData then
		return true
	end

	local levelList = {}

	for k, v in pairs(VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(elementId)) do
		table.insert(levelList, v)
	end

	table.sort(levelList, function(item1, item2)
		return item1.level < item2.level
	end)

	return levelList[elementData.level + 2]
end

function VersionActivity1_2DungeonModel:getDailyEpisodeConfigByElementId(elementId)
	local elementConfig = lua_chapter_map_element.configDict[elementId]

	if elementConfig.type == DungeonEnum.ElementType.DailyEpisode then
		local buildingConfigDic = VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(elementConfig.id)
		local buildingConfig

		if buildingConfigDic then
			for k, v in pairs(buildingConfigDic) do
				buildingConfig = v

				break
			end
		end

		if buildingConfig then
			local episodeList = string.splitToNumber(buildingConfig.configType, "#")

			for index, episodeId in ipairs(episodeList) do
				local data = VersionActivity1_2DungeonModel.instance:getSpStatus(episodeId)

				if data and data.status == 1 then
					return DungeonConfig.instance:getEpisodeCO(episodeId)
				end
			end
		end
	end
end

function VersionActivity1_2DungeonModel:jump2DailyEpisode(jumpId)
	local jumpConfig = JumpConfig.instance:getJumpConfig(jumpId)
	local paramArr = string.splitToNumber(jumpConfig.param, "#")

	if paramArr[1] == 100 and paramArr[2] == JumpEnum.ActIdEnum.Act1_2Dungeon and paramArr[3] == JumpEnum.Activity1_2DungeonJump.Jump2Daily then
		local tarEpisodeId = paramArr[4]
		local buildingConfig = VersionActivity1_2DungeonConfig.instance:getConfigByEpisodeId(tarEpisodeId)

		if buildingConfig then
			local elementId = buildingConfig.elementId
			local elementData = DungeonMapModel.instance:getElementById(elementId)

			if not elementData then
				local elementConfig = lua_chapter_map_element.configDict[elementId]
				local unlockEpisodeId = string.splitToNumber(elementConfig.condition, "=")[2]
				local unlockEpisodeConfig = DungeonConfig.instance:getEpisodeCO(unlockEpisodeId)
				local chapterConfig = DungeonConfig.instance:getChapterCO(unlockEpisodeConfig.chapterId)
				local unlockStr = string.format(luaLang("dungeon_unlock_episode_mode"), luaLang("dungeon_story_mode") .. chapterConfig.chapterIndex .. "-" .. VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(unlockEpisodeId))

				GameFacade.showToastString(unlockStr)
			else
				local fightEpisodeConfig = self:getDailyEpisodeConfigByElementId(elementId)

				if fightEpisodeConfig then
					if fightEpisodeConfig.id == tarEpisodeId then
						ViewMgr.instance:closeView(ViewName.VersionActivity1_2TaskView)
						VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.clickDailyEpisode, elementId)
					else
						GameFacade.showMessageBox(MessageBoxIdDefine.Dungeon1_2Jump2Daily, MsgBoxEnum.BoxType.Yes_No, function()
							ViewMgr.instance:closeView(ViewName.VersionActivity1_2TaskView)
							VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.clickDailyEpisode, elementId)
						end)
					end
				else
					for i, v in ipairs(VersionActivity1_2DungeonConfig.instance:getType4List()) do
						if self:getDailyEpisodeConfigByElementId(v.elementId) then
							GameFacade.showMessageBox(MessageBoxIdDefine.Dungeon1_2Jump2Daily, MsgBoxEnum.BoxType.Yes_No, function()
								ViewMgr.instance:closeView(ViewName.VersionActivity1_2TaskView)
								VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.clickDailyEpisode, v.elementId)
							end)

							return true
						end
					end

					GameFacade.showToast(ToastEnum.Dungeon1_2CanNotJump2Daily)
				end
			end
		end

		return true
	end

	return false
end

VersionActivity1_2DungeonModel.instance = VersionActivity1_2DungeonModel.New()

return VersionActivity1_2DungeonModel
