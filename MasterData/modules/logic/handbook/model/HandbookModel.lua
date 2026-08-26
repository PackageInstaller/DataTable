-- chunkname: @modules/logic/handbook/model/HandbookModel.lua

module("modules.logic.handbook.model.HandbookModel", package.seeall)

local HandbookModel = class("HandbookModel", BaseModel)

function HandbookModel:onInit()
	self._cgReadDict = {}
	self._fragmentDict = {}
	self._characterReadDict = {}
	self._equipDict = {}
	self._skinRedDotReadDict = {}
	self._skinRedDotDict = {}
	self._skinRedDotUnlockReadDict = {}
	self._skinRedDotUnlockDict = {}
end

function HandbookModel:reInit()
	self._cgReadDict = {}
	self._fragmentDict = {}
	self._characterReadDict = {}
	self._equipDict = {}
	self._skinRedDotReadDict = {}
	self._skinRedDotDict = {}
	self._skinRedDotUnlockReadDict = {}
	self._skinRedDotUnlockDict = {}
end

function HandbookModel:setReadInfos(infos)
	self._cgReadDict = {}

	for i, info in ipairs(infos) do
		self:setReadInfo(info)
	end
end

function HandbookModel:setReadInfo(info)
	if info.type == HandbookEnum.Type.CG then
		if info.isRead then
			self._cgReadDict[info.id] = true
		elseif self._cgReadDict[info.id] then
			self._cgReadDict[info.id] = nil
		end
	elseif info.type == HandbookEnum.Type.Character then
		if info.isRead then
			self._characterReadDict[info.id] = true
		end
	elseif info.type == HandbookEnum.Type.Equip then
		local handbookEquipCo = lua_handbook_equip.configDict[info.id]

		if not handbookEquipCo then
			logError(string.format("handbook equip not found id : %s config", info.id))

			return
		end

		self._equipDict[handbookEquipCo.equipId] = true
	end
end

function HandbookModel:setFragmentInfo(infos)
	self._fragmentDict = {}

	for i, info in ipairs(infos) do
		local elementConfig = lua_chapter_map_element.configDict[info.element]

		if elementConfig and elementConfig.fragment ~= 0 then
			local dialogIdList = {}

			for j, dialogId in ipairs(info.dialogIds) do
				table.insert(dialogIdList, dialogId)
			end

			self._fragmentDict[elementConfig.fragment] = dialogIdList
		end
	end
end

function HandbookModel:isRead(type, id)
	if type == HandbookEnum.Type.CG then
		return self._cgReadDict[id]
	elseif type == HandbookEnum.Type.Character then
		return self._characterReadDict[id]
	end

	return false
end

function HandbookModel:isCGUnlock(cgId)
	local config = HandbookConfig.instance:getCGConfig(cgId)
	local episodeId = config.episodeId
	local herostoryId = config.herostoryId

	if episodeId == 0 and herostoryId == 0 then
		return true
	end

	if episodeId ~= 0 then
		return DungeonModel.instance:hasPassLevelAndStory(episodeId)
	end

	return RoleStoryModel.instance:isCGUnlock(herostoryId)
end

function HandbookModel:getCGUnlockCount(storyChapterId, cgType)
	local count = 0
	local cgList = HandbookConfig.instance:getCGList(cgType)

	for i, config in ipairs(cgList) do
		if (not storyChapterId or config.storyChapterId == storyChapterId) and HandbookModel.instance:isCGUnlock(config.id) then
			count = count + 1
		end
	end

	return count
end

function HandbookModel:getCGUnlockIndex(cgId, cgType)
	local count = 1
	local cgList = HandbookConfig.instance:getCGList(cgType)

	for i, config in ipairs(cgList) do
		if config.id == cgId then
			return count
		end

		if HandbookModel.instance:isCGUnlock(config.id) then
			count = count + 1
		end
	end
end

function HandbookModel:getCGUnlockIndexInChapter(chapterId, cgId, cgType)
	local count = 1
	local cgList = HandbookConfig.instance:getCGDictByChapter(chapterId, cgType)

	for i, config in ipairs(cgList) do
		if config.id == cgId then
			return count
		end

		if HandbookModel.instance:isCGUnlock(config.id) then
			count = count + 1
		end
	end
end

function HandbookModel:getNextCG(cgId, cgType)
	local index = HandbookConfig.instance:getCGIndex(cgId, cgType)
	local cgList = HandbookConfig.instance:getCGList(cgType)

	for i = index + 1, #cgList do
		local config = cgList[i]

		if self:isCGUnlock(config.id) then
			return config
		end
	end

	for i = 1, index - 1 do
		local config = cgList[i]

		if self:isCGUnlock(config.id) then
			return config
		end
	end

	return nil
end

function HandbookModel:getPrevCG(cgId, cgType)
	local index = HandbookConfig.instance:getCGIndex(cgId, cgType)
	local cgList = HandbookConfig.instance:getCGList(cgType)

	for i = index - 1, 1, -1 do
		local config = cgList[i]

		if self:isCGUnlock(config.id) then
			return config
		end
	end

	for i = #cgList, index + 1, -1 do
		local config = cgList[i]

		if self:isCGUnlock(config.id) then
			return config
		end
	end

	return nil
end

function HandbookModel:isStoryGroupUnlock(storyGroupId)
	local storyGroupConfig = HandbookConfig.instance:getStoryGroupConfig(storyGroupId)
	local episodeId = storyGroupConfig.episodeId

	return episodeId == 0 or DungeonModel.instance:hasPassLevelAndStory(episodeId)
end

function HandbookModel:getStoryGroupUnlockCount(storyChapterId)
	local count = 0
	local storyGroupList = HandbookConfig.instance:getStoryGroupList()

	for i, config in ipairs(storyGroupList) do
		if (not storyChapterId or config.storyChapterId == storyChapterId) and HandbookModel.instance:isStoryGroupUnlock(config.id) then
			count = count + 1
		end
	end

	return count
end

function HandbookModel:getFragmentDialogIdList(fragmentId)
	return self._fragmentDict[fragmentId]
end

function HandbookModel:haveEquip(equipId)
	return self._equipDict[equipId]
end

function HandbookModel:updateSkinRedDotInfo(param)
	tabletool.clear(self._skinRedDotReadDict)
	tabletool.clear(self._skinRedDotUnlockReadDict)

	if not string.nilorempty(param) then
		local redDotInfoList = string.split(param, "|")

		for _, singleRedDotInfoList in ipairs(redDotInfoList) do
			local redDotInfo = string.split(singleRedDotInfoList, "#")
			local redDotGroupId = tonumber(redDotInfo[1])
			local singleDic

			if not self._skinRedDotReadDict[redDotGroupId] then
				singleDic = {}
				self._skinRedDotReadDict[redDotGroupId] = singleDic
			else
				singleDic = self._skinRedDotReadDict[redDotGroupId]
			end

			local singleReadDic

			if not self._skinRedDotUnlockReadDict[redDotGroupId] then
				singleReadDic = {}
				self._skinRedDotUnlockReadDict[redDotGroupId] = singleReadDic
			else
				singleReadDic = self._skinRedDotUnlockReadDict[redDotGroupId]
			end

			if #redDotInfo > 1 then
				for i = 2, #redDotInfo do
					if not string.nilorempty(redDotInfo[i]) then
						local singleSkinParam = string.splitToNumber(redDotInfo[i], ":")
						local skinId = singleSkinParam[1]

						if not singleSkinParam[2] then
							if not singleSkinParam[3] then
								singleDic[skinId] = singleSkinParam[2]
								singleReadDic[skinId] = 0
							end
						end
					end
				end
			end
		end
	end

	self:initSkinRedDotInfo()
	self:initSkinRedDotUnlockInfo()
end

function HandbookModel:initSkinRedDotInfo()
	tabletool.clear(self._skinRedDotDict)

	local suitConfigs = HandbookConfig.instance:getSkinThemeGroupCfgs(true)

	for _, config in ipairs(suitConfigs) do
		local suitThemeConfigList = HandbookConfig.instance:getSkinSuitCfgListInGroup(config.id)

		if suitThemeConfigList and next(suitThemeConfigList) then
			for _, themeConfig in ipairs(suitThemeConfigList) do
				local showRedDot = false
				local skinList = HandbookConfig.instance:getSkinIdListBySuitId(themeConfig.id)

				if skinList and next(skinList) then
					for _, skinId in ipairs(skinList) do
						if skinId ~= 0 then
							local skinConfig = SkinConfig.instance:getSkinCo(skinId)

							if not skinConfig then
								logError(string.format("skinConfig not found skinId: %s", skinId))
							elseif skinConfig.handbookRedDot and skinConfig.handbookRedDot ~= 0 and (not self._skinRedDotReadDict[themeConfig.id] or not self._skinRedDotReadDict[themeConfig.id][skinId] or self._skinRedDotReadDict[themeConfig.id][skinId] < skinConfig.handbookRedDot) then
								showRedDot = true

								break
							end
						end
					end
				end

				if showRedDot then
					self._skinRedDotDict[config.id] = self._skinRedDotDict[config.id] or {}

					logNormal("增加皮肤图鉴 未读红点 groupId: " .. tostring(config.id) .. " 套组id: " .. tostring(themeConfig.id))

					self._skinRedDotDict[config.id][themeConfig.id] = showRedDot
				end
			end
		end
	end
end

function HandbookModel:initSkinRedDotUnlockInfo()
	tabletool.clear(self._skinRedDotUnlockDict)

	local suitConfigs = HandbookConfig.instance:getSkinThemeGroupCfgs(true)

	for _, config in ipairs(suitConfigs) do
		local suitThemeConfigList = HandbookConfig.instance:getSkinSuitCfgListInGroup(config.id)

		if suitThemeConfigList and next(suitThemeConfigList) then
			for _, themeConfig in ipairs(suitThemeConfigList) do
				local showRedDot = false
				local skinList = HandbookConfig.instance:getSkinIdListBySuitId(themeConfig.id)

				if skinList and next(skinList) then
					for _, skinId in ipairs(skinList) do
						if skinId ~= 0 and self._skinRedDotUnlockReadDict[themeConfig.id] and self._skinRedDotUnlockReadDict[themeConfig.id][skinId] and self._skinRedDotUnlockReadDict[themeConfig.id][skinId] > 0 then
							showRedDot = true

							break
						end
					end
				end

				if showRedDot then
					self._skinRedDotUnlockDict[config.id] = self._skinRedDotUnlockDict[config.id] or {}

					logNormal("增加皮肤图鉴 未读解锁红点 groupId: " .. tostring(config.id) .. " 套组id: " .. tostring(themeConfig.id))

					self._skinRedDotUnlockDict[config.id][themeConfig.id] = showRedDot
				end
			end
		end
	end
end

function HandbookModel:getSkinRedDotInfoParam()
	local resultList = {}
	local needSaveSkinIdDic = {}

	for redDotGroupId, singleDic in pairs(self._skinRedDotReadDict) do
		for skinId, redDotVersion in pairs(singleDic) do
			local skinConfig = SkinConfig.instance:getSkinCo(skinId)

			if skinConfig and skinConfig.handbookRedDot and skinConfig.handbookRedDot ~= 0 then
				needSaveSkinIdDic[redDotGroupId] = needSaveSkinIdDic[redDotGroupId] or {}
				needSaveSkinIdDic[redDotGroupId][skinId] = true
			end
		end
	end

	for redDotGroupId, singleDic in pairs(self._skinRedDotUnlockReadDict) do
		for skinId, unlockReadState in pairs(singleDic) do
			if unlockReadState ~= 0 then
				needSaveSkinIdDic[redDotGroupId] = needSaveSkinIdDic[redDotGroupId] or {}
				needSaveSkinIdDic[redDotGroupId][skinId] = true
			end
		end
	end

	for redDotGroupId, singleDic in pairs(needSaveSkinIdDic) do
		local groupParam = redDotGroupId .. "#"
		local redDotParam = {}

		for skinId, needSave in pairs(singleDic) do
			if needSave then
				if self._skinRedDotReadDict[redDotGroupId] then
					if not self._skinRedDotReadDict[redDotGroupId][skinId] then
						local redDotVersion = 0

						if self._skinRedDotUnlockReadDict[redDotGroupId] then
							if not self._skinRedDotUnlockReadDict[redDotGroupId][skinId] then
								local unlockReadState = 0

								table.insert(redDotParam, skinId .. ":" .. tostring(redDotVersion) .. ":" .. tostring(unlockReadState))
							end
						end
					end
				end
			end
		end

		groupParam = groupParam .. table.concat(redDotParam, "#")

		table.insert(resultList, groupParam)
	end

	if resultList and next(resultList) then
		return table.concat(resultList, "|")
	else
		return ""
	end
end

function HandbookModel:markHandbookSkinRedDotShow(suitId)
	local config = HandbookConfig.instance:getSkinSuitCfg(suitId)

	if config then
		local skinList = HandbookConfig.instance:getSkinIdListBySuitId(suitId)

		if skinList and next(skinList) then
			local singleDic

			if not self._skinRedDotReadDict[suitId] then
				singleDic = {}
				self._skinRedDotReadDict[suitId] = singleDic
			else
				singleDic = self._skinRedDotReadDict[suitId]
			end

			for _, skinId in ipairs(skinList) do
				if skinId ~= 0 then
					local skinConfig = SkinConfig.instance:getSkinCo(skinId)

					if not skinConfig then
						logError(string.format("skinConfig not found skinId: %s", skinId))
					else
						singleDic[skinId] = skinConfig.handbookRedDot
					end
				end
			end
		end

		if self._skinRedDotDict[config.highId] and self._skinRedDotDict[config.id] then
			self._skinRedDotDict[config.highId][config.id] = nil

			if next(self._skinRedDotDict[config.highId]) == nil then
				self._skinRedDotDict[config.highId] = nil
			end
		end
	end
end

function HandbookModel:markHandbookSkinUnlockRedDotShow(skinId)
	if skinId == 0 then
		return
	end

	local suitId = HandbookConfig.instance:getSkinSuitIdBySkinId(skinId)
	local config = HandbookConfig.instance:getSkinSuitCfg(suitId)

	if config then
		local singleDic

		if not self._skinRedDotUnlockReadDict[suitId] then
			singleDic = {}
			self._skinRedDotUnlockReadDict[suitId] = singleDic
		else
			singleDic = self._skinRedDotUnlockReadDict[suitId]
		end

		singleDic[skinId] = 0
	end
end

function HandbookModel:addOrRemoveUnlockSkinId(skinId, isAdd)
	if skinId == 0 then
		return
	end

	local suitId = HandbookConfig.instance:getSkinSuitIdBySkinId(skinId)

	if suitId then
		local singleDic

		if not self._skinRedDotUnlockReadDict[suitId] then
			singleDic = {}
			self._skinRedDotUnlockReadDict[suitId] = singleDic
		else
			singleDic = self._skinRedDotUnlockReadDict[suitId]
		end

		singleDic[skinId] = isAdd and 1 or 0
	end
end

function HandbookModel:getSkinRedDotInfo(skinGroupId)
	return self._skinRedDotDict and self._skinRedDotDict[skinGroupId]
end

function HandbookModel:getAllSkinRedDotInfo()
	return self._skinRedDotDict
end

function HandbookModel:getSkinUnlockRedDotInfo(skinGroupId)
	return self._skinRedDotUnlockDict and self._skinRedDotUnlockDict[skinGroupId]
end

function HandbookModel:getAllSkinUnlockRedDotInfo()
	return self._skinRedDotUnlockDict
end

function HandbookModel:getSkinUnlockRedDotReadInfo()
	return self._skinRedDotUnlockReadDict
end

HandbookModel.instance = HandbookModel.New()

return HandbookModel
