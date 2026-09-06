-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/model/FamilyHonorModel.lua

module("logic.extensions.newfamily.model.FamilyHonorModel", package.seeall)

local FamilyHonorModel = class("FamilyHonorModel", BaseModel)

function FamilyHonorModel:ctor()
	self.wallWide = 24
	self.wallHigh = 12
	self._cacheHonorWall = nil
	self._honorWallInfo = nil
	self._cacheHonorInfo = nil
	self._cacheShareInfo = nil
	self._taskInfo = nil
end

function FamilyHonorModel:onInit()
	FamilyHonorModel.super.onInit(self)
	self:onReset()
end

function FamilyHonorModel:onReset()
	self._honorWallInfo = nil
	self._cacheHonorWall = nil
	self._cacheHonorInfo = nil
	self._cacheShareInfo = nil
	self._taskInfo = nil
end

function FamilyHonorModel:getFamilyHonorInfo(isReset)
	if self._honorWallInfo == nil or isReset then
		self._honorWallInfo = {}
		self._honorWallInfo.medalList = {}
	end

	return self._honorWallInfo
end

function FamilyHonorModel:getCacheHonorWall()
	return self._cacheHonorWall
end

function FamilyHonorModel:getHonorByDefineId(defineId)
	local info = self:getFamilyHonorInfo()

	if info and info.medalList then
		return info.medalList[defineId]
	end

	return nil
end

function FamilyHonorModel:getCacheHonorInfo()
	return self._cacheHonorInfo
end

function FamilyHonorModel:getRightHonorInfoList(search, labels)
	self:getFamilyHonorInfo()

	if self._honorWallInfo.medalList == nil then
		return
	end

	local targetList = {}
	local cfg
	local str = ""

	if not string.nilorempty(search) then
		str = StringUtil.RelpaceEscapeChar(search)
	end

	for _, info in pairs(self._honorWallInfo.medalList) do
		if info and checknumber(info.gainedTime) > 0 then
			cfg = FamilyHonorConfig.instance:getFamilyMedalCfg(info.defineId)

			if cfg then
				if not string.nilorempty(str) then
					if string.find(cfg.name, str) then
						table.insert(targetList, {
							info = info,
							cfg = cfg
						})
					end
				elseif self:_isFilterHonorByLabels(labels, cfg) then
					table.insert(targetList, {
						info = info,
						cfg = cfg
					})
				end
			end
		end
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			return a.cfg.id < b.cfg.id
		end)
	end

	return targetList
end

function FamilyHonorModel:_isFilterHonorByLabels(labels, cfg)
	if labels == nil or #labels == 0 then
		return true
	end

	if cfg == nil then
		return false
	end

	if table.indexof(labels, cfg.level) then
		return true
	end

	if table.indexof(labels, cfg.labelType) then
		return true
	end

	return false
end

function FamilyHonorModel:isHonorCurrentEditWall(defineId)
	if self._honorWallInfo.medalList == nil or self._honorWallInfo.medalList[defineId] == nil then
		return false
	end

	if self._cacheHonorInfo then
		local tempInfo = self._cacheHonorInfo[defineId]

		if checknumber(self._honorWallInfo.medalList[defineId].wallId) > 0 then
			if tempInfo == nil or checknumber(tempInfo.wallId) > 0 then
				return true
			end
		elseif tempInfo and checknumber(tempInfo.wallId) > 0 then
			return true
		end

		return false
	end
end

function FamilyHonorModel:getAllAndHaveHonorInfo(num, isOn)
	local allCfgs = FamilyHonorConfig.instance:getAllFamilyMedalCfgs()
	local allCount, haveCount = 0, 0
	local starInfo = {}
	local tempList = {}

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and checknumber(cfg.id) > 0 then
			allCount = allCount + 1

			if starInfo[cfg.level] == nil then
				starInfo[cfg.level] = {
					have = 0,
					all = 0
				}
			end

			starInfo[cfg.level].all = starInfo[cfg.level].all + 1

			local info = self:getHonorByDefineId(cfg.id)
			local isHave = false

			if info and checknumber(info.gainedTime) > 0 then
				isHave = true
				haveCount = haveCount + 1
				starInfo[cfg.level].have = starInfo[cfg.level].have + 1
			end

			if isOn and cfg.notAvailable > 0 or num == 0 and isHave or num == 1 and not isHave then
				-- block empty
			else
				table.insert(tempList, cfg)
			end
		end
	end

	if #tempList > 1 then
		table.sort(tempList, function(a, b)
			return a.id < b.id
		end)
	end

	return allCount, haveCount, starInfo, tempList
end

function FamilyHonorModel:getOtherHonorWallInfo()
	self:getFamilyHonorInfo()

	local tempList = {}

	for _, info in pairs(self._honorWallInfo.medalList) do
		if info and info.defineId and checknumber(info.wallId) > 0 then
			table.insert(tempList, info)
		end
	end

	return tempList
end

function FamilyHonorModel:getEditHonorWallInfo()
	self:getFamilyHonorInfo()

	local tempList = {}

	for _, info in pairs(self._honorWallInfo.medalList) do
		if info and info.defineId and checknumber(info.defineId) > 0 then
			if self._cacheHonorInfo and self._cacheHonorInfo[info.defineId] then
				if self._cacheHonorInfo[info.defineId].wallId > 0 then
					table.insert(tempList, self._cacheHonorInfo[info.defineId])
				end
			elseif info.wallId > 0 then
				table.insert(tempList, info)
			end
		end
	end

	return tempList
end

function FamilyHonorModel:resetCacheHonorWall()
	self._cacheHonorInfo = {}
	self._cacheHonorWall = {}

	for i = 1, self.wallWide * self.wallHigh do
		self._cacheHonorWall[i] = 0
	end

	for _, info in pairs(self._honorWallInfo.medalList or {}) do
		if info and info.defineId and checknumber(info.wallId) > 0 then
			self._cacheHonorInfo[info.defineId] = {
				wallId = -1,
				defineId = info.defineId
			}
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataNewFamilyHonorInfo)
end

function FamilyHonorModel:getCacheHonorByDefineId(defineId)
	if self._cacheHonorInfo == nil then
		return
	end

	return self._cacheHonorInfo[defineId]
end

function FamilyHonorModel:updataCacheHonorWall(oldInfo, newInfo)
	self._cacheHonorInfo = self._cacheHonorInfo or {}

	if (oldInfo == nil or oldInfo.defineId == nil) and (newInfo == nil or newInfo.defineId == nil) then
		return
	end

	if oldInfo then
		if not oldInfo.defineId then
			local defineId = newInfo.defineId

			if oldInfo and checknumber(oldInfo.positionX) >= 0 then
				self:updateSingleCacheHonor(oldInfo, true)

				self._cacheHonorInfo[defineId] = {
					wallId = -1,
					defineId = defineId
				}
			end

			if newInfo and checknumber(newInfo.positionX) >= 0 and self:updateSingleCacheHonor(newInfo, false) then
				local data = {}

				data.defineId = newInfo.defineId
				data.progress = checknumber(newInfo.progress)
				data.gainedTime = newInfo.gainedTime
				data.wallId = 1
				data.positionX = newInfo.positionX
				data.positionY = newInfo.positionY
				self._cacheHonorInfo[defineId] = data
			end

			GlobalDispatcher:dispatch(GlobalNotify.UpdataNewFamilyHonorInfo)

			return true
		end
	end
end

function FamilyHonorModel:updateSingleCacheHonor(info, isCancel)
	if info == nil or info.defineId == nil then
		return
	end

	local cfg = FamilyHonorConfig.instance:getFamilyMedalCfg(info.defineId)

	if cfg == nil or cfg.width <= 0 or cfg.height <= 0 then
		return
	end

	local startW, startH = info.positionX, info.positionY

	for h = 1, cfg.height do
		for w = 1, cfg.width do
			self._cacheHonorWall[(startH - 1 + h) * self.wallWide + startW + w] = isCancel and 0 or info.defineId
		end
	end

	return true
end

function FamilyHonorModel:scPushFamilyMedalGetMedalList(msg)
	self:getFamilyHonorInfo(true)

	self._cacheHonorInfo = {}
	self._cacheHonorWall = {}

	for i = 1, self.wallWide * self.wallHigh do
		self._cacheHonorWall[i] = 0
	end

	local data

	for _, info in pairs(msg.medalList or {}) do
		if info and checknumber(info.defineId) > 0 then
			data = {
				defineId = info.defineId,
				progress = checknumber(info.progress),
				gainedTime = info.gainedTime,
				wallId = info.wallId,
				positionX = info.positionX,
				positionY = info.positionY
			}
			self._honorWallInfo.medalList[info.defineId] = data

			if checknumber(info.wallId) > 0 then
				self._cacheHonorInfo[info.defineId] = data

				self:updateSingleCacheHonor(info, false)
			end
		end
	end
end

function FamilyHonorModel:scPushFamilyMedalgetChatMedals(msg, familyId, sokStr)
	self._cacheShareInfo = self._cacheShareInfo or {}
	self._cacheShareInfo[familyId] = self._cacheShareInfo[familyId] or {}
	self._cacheShareInfo[familyId][sokStr] = msg
end

function FamilyHonorModel:getFamilyMedalgetChatMedals(familyId, sokStr)
	if self._cacheShareInfo == nil or self._cacheShareInfo[familyId] == nil then
		return nil
	end

	if self._cacheShareInfo[familyId][sokStr] == nil then
		return nil
	end

	return self._cacheShareInfo[familyId][sokStr]
end

function FamilyHonorModel:getFamilyTaskInfo(isReset)
	if self._taskInfo == nil or isReset then
		self._taskInfo = {}
		self._taskInfo.score = 0
		self._taskInfo.info = {}
	end

	return self._taskInfo
end

function FamilyHonorModel:getAllFinishTaskId()
	local tpyeList = FamilyHonorConfig.instance:getFamilyTaskIdsList()
	local list = {}

	for _, idsList in pairs(tpyeList or {}) do
		for i, taskId in ipairs(idsList) do
			local task = self._taskInfo.info[taskId]

			if task and not task.hasGain then
				local cfg = FamilyHonorConfig.instance:getFamilyTaskInfoCfg(taskId)

				if not task.progress then
					if task.progress >= cfg.maxProgress then
						table.insert(list, taskId)
					end
				end
			end
		end
	end

	return list
end

function FamilyHonorModel:getFamilyTaskCfgList()
	local tpyeList = FamilyHonorConfig.instance:getFamilyTaskIdsList()
	local info
	local targetList = {}

	for _, idsList in pairs(tpyeList or {}) do
		info = self:_getFamilyTaskToDo(idsList)

		if info then
			table.insert(targetList, info)
		end
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			if a.stage == b.stage then
				return a.cfg.id > b.cfg.id
			end

			return a.stage < b.stage
		end)
	end

	return targetList
end

function FamilyHonorModel:_getFamilyTaskToDo(idsList)
	if idsList == nil or #idsList == 0 then
		return
	end

	local taskId = idsList[#idsList]

	for i = 1, #idsList do
		if self._taskInfo.info[idsList[i]] == nil or not self._taskInfo.info[idsList[i]].hasGain then
			taskId = idsList[i]

			break
		end
	end

	if checknumber(taskId) <= 0 then
		return
	end

	local info = {}

	info.taskId = taskId
	info.cfg = FamilyHonorConfig.instance:getFamilyTaskInfoCfg(taskId)

	if self._taskInfo.info[taskId] then
		info.progress = self._taskInfo.info[taskId].progress or 0
	end

	if self._taskInfo.info[taskId] then
		info.hasGain = self._taskInfo.info[taskId].hasGain or false
	end

	info.stage = info.hasGain and 3 or info.progress >= info.cfg.maxProgress and 1 or 2

	return info
end

function FamilyHonorModel:getFamilyTaskLevelByScore(score)
	local allCfgs = FamilyHonorConfig.instance:getAllFamilyTaskLevelCfgs()
	local level = 0
	local maxLevel = 0

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and score >= checknumber(cfg.startScore) and level < checknumber(cfg.level) then
			level = cfg.level
		end

		if maxLevel < checknumber(cfg.level) then
			maxLevel = cfg.level
		end
	end

	return level, maxLevel
end

function FamilyHonorModel:scPushFamilyTaskInfo(msg)
	self:getFamilyTaskInfo(true)

	if msg == nil then
		return
	end

	self._taskInfo.score = checknumber(msg.familyTaskScore)

	for _, info in pairs(msg.taskInfos or {}) do
		if info and checknumber(info.taskId) > 0 then
			self._taskInfo.info[info.taskId] = {
				taskId = info.taskId,
				progress = info.progress,
				hasGain = info.hasGain
			}
		end
	end
end

function FamilyHonorModel:scPushFamilyTaskGainPrize(taskId)
	if checknumber(taskId) <= 0 then
		return
	end

	self:getFamilyTaskInfo()

	if self._taskInfo.info[taskId] == nil then
		self._taskInfo.info[taskId] = {
			progress = 0,
			hasGain = false,
			taskId = taskId
		}
	end

	self._taskInfo.info[taskId].hasGain = true
end

FamilyHonorModel.instance = FamilyHonorModel.New()

return FamilyHonorModel
