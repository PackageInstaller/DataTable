-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitejigsaw/model/InfiniteJigsawModel.lua

module("logic.extensions.infinitejigsaw.model.InfiniteJigsawModel", package.seeall)

local InfiniteJigsawModel = class("InfiniteJigsawModel", BaseModel)
local MAXPIECECOUNT = 15
local MAXPICTURECOUNT = 1
local MAXREWARDCOUNT = 8

InfiniteJigsawModel.DailyRedPoint = "InfiniteJigsawDaily"

function InfiniteJigsawModel:ctor()
	return
end

function InfiniteJigsawModel:onInit()
	self:onReset()
end

function InfiniteJigsawModel:onReset()
	self._taskInfos = {}
	self._curPictureId = 1
	self._curPictureActiveJigsawIds = {}
	self._prizeInfos = {}
end

function InfiniteJigsawModel:onJEGetTaskInfoRes(msg)
	self._taskInfos = GameUtil.pbToTable(msg.taskInfos) or {}
end

function InfiniteJigsawModel:onJEGainTaskPrizeRes(msg)
	for i, v in ipairs(self._taskInfos) do
		if v.taskId == msg.taskId then
			v.prizeGained = true

			break
		end
	end
end

function InfiniteJigsawModel:onJEGetPictureInfoRes(msg)
	self._curPictureId = msg.curPictureId
	self._curPictureActiveJigsawIds = GameUtil.pbToTable(msg.curPictureActiveJigsawIds) or {}
	self._prizeInfos = GameUtil.pbToTable(msg.prizeInfos) or {}
end

function InfiniteJigsawModel:onJEActivateJigsawRes(msg)
	MaterialController.instance:setChangeSetPopup(msg.changeSetId, MaterialController.CI_SHOW_TYPE_FLY)

	if not TableUtil.isHad(self._curPictureActiveJigsawIds, msg.jigsawId) then
		table.insert(self._curPictureActiveJigsawIds, msg.jigsawId)
		TableUtil.UpperSort(self._curPictureActiveJigsawIds, nil, true)
	end

	if #self._curPictureActiveJigsawIds >= MAXPIECECOUNT then
		self._curPictureId = msg.pictureId + 1

		table.clear(self._curPictureActiveJigsawIds)

		if self._curPictureId <= MAXPICTURECOUNT then
			local PM_JEPicturePrizeInfo = {}

			PM_JEPicturePrizeInfo.pictureId = self._curPictureId
			PM_JEPicturePrizeInfo.bigPrizeGained = false
			PM_JEPicturePrizeInfo.gainedGroupPrizeIds = {}

			table.insert(self._prizeInfos, PM_JEPicturePrizeInfo)
		end
	end
end

function InfiniteJigsawModel:onJEGainGroupPrizeRes(msg)
	local isExistPictureId = true

	for i, v in ipairs(self._prizeInfos) do
		if v.pictureId == msg.pictureId then
			isExistPictureId = true
			v.gainedGroupPrizeIds = v.gainedGroupPrizeIds or {}

			table.insert(v.gainedGroupPrizeIds, msg.groupPrizeId)

			break
		end
	end

	if not isExistPictureId then
		local PM_JEPicturePrizeInfo = {}

		PM_JEPicturePrizeInfo.pictureId = msg.pictureId
		PM_JEPicturePrizeInfo.bigPrizeGained = false
		PM_JEPicturePrizeInfo.gainedGroupPrizeIds = {}

		table.insert(PM_JEPicturePrizeInfo.gainedGroupPrizeIds, msg.groupPrizeId)
		table.insert(self._prizeInfos, PM_JEPicturePrizeInfo)
	end
end

function InfiniteJigsawModel:onJEGainBigPrizeRes(msg)
	local isExistPictureId = true

	for i, v in ipairs(self._prizeInfos) do
		if v.pictureId == msg.pictureId then
			isExistPictureId = true
			v.bigPrizeGained = true

			break
		end
	end

	if not isExistPictureId then
		local PM_JEPicturePrizeInfo = {}

		PM_JEPicturePrizeInfo.pictureId = msg.pictureId
		PM_JEPicturePrizeInfo.bigPrizeGained = true
		PM_JEPicturePrizeInfo.gainedGroupPrizeIds = {}

		table.insert(self._prizeInfos, PM_JEPicturePrizeInfo)
	end
end

function InfiniteJigsawModel:onJEGiveGiftRes(msg)
	return
end

function InfiniteJigsawModel:getActivityId()
	self._activityId = checknumber(InfiniteJigsawConfig.instance:getConstValue("ACTIVITYID"))

	return self._activityId
end

function InfiniteJigsawModel:getTaskPlanId()
	local cfg = InfiniteJigsawConfig.instance:getActivityCfg(self:getActivityId())

	if cfg then
		return cfg.taskPlanId
	end

	return 0
end

function InfiniteJigsawModel:getPictureId()
	return math.min(self._curPictureId, MAXPICTURECOUNT)
end

function InfiniteJigsawModel:isTaskFinished(taskId, maxProgress)
	for i, v in ipairs(self._taskInfos) do
		if v.taskId == taskId then
			return maxProgress <= v.curProgress
		end
	end

	return false
end

function InfiniteJigsawModel:curTaskProgress(taskId)
	for i, v in ipairs(self._taskInfos) do
		if v.taskId == taskId then
			return v.curProgress
		end
	end

	return 0
end

function InfiniteJigsawModel:isTaskPrizeGained(taskId)
	for i, v in ipairs(self._taskInfos) do
		if v.taskId == taskId then
			return v.prizeGained
		end
	end

	return false
end

function InfiniteJigsawModel:isUnlockAllPicture()
	return self._curPictureId > MAXPICTURECOUNT
end

function InfiniteJigsawModel:isActiveJigsawId(jigsawId, pictureId)
	if self._curPictureId == pictureId then
		return TableUtil.isHad(self._curPictureActiveJigsawIds, jigsawId)
	elseif pictureId > self._curPictureId then
		return false
	else
		return true
	end
end

function InfiniteJigsawModel:isActiveHorizontalOrVertical(groupPrizeId)
	if groupPrizeId >= 1 and groupPrizeId <= 3 then
		local isActive = true

		for curNum = 1, 5 do
			isActive = isActive and TableUtil.isHad(self._curPictureActiveJigsawIds, (groupPrizeId - 1) * 5 + curNum)
		end

		return isActive
	elseif groupPrizeId >= 4 and groupPrizeId <= 8 then
		local isActive = true

		for i = 1, 3 do
			isActive = isActive and TableUtil.isHad(self._curPictureActiveJigsawIds, groupPrizeId - 3 + (i - 1) * 5)
		end

		return isActive
	else
		return false
	end
end

function InfiniteJigsawModel:isRewardCanGet(pictureId, groupPrizeId)
	if pictureId > self._curPictureId then
		return false
	else
		for i, v in ipairs(self._prizeInfos) do
			if v.pictureId == pictureId then
				if groupPrizeId <= 0 then
					if pictureId < self._curPictureId then
						return not v.bigPrizeGained
					elseif #self._curPictureActiveJigsawIds >= MAXPIECECOUNT then
						return not v.bigPrizeGained
					else
						return false
					end
				elseif v.gainedGroupPrizeIds then
					local isGeted = TableUtil.isHad(v.gainedGroupPrizeIds, groupPrizeId)

					if pictureId < self._curPictureId then
						local isActive = true

						return not isGeted and isActive
					else
						local isActive = self:isActiveHorizontalOrVertical(groupPrizeId)

						return not isGeted and isActive
					end
				end
			end
		end
	end
end

function InfiniteJigsawModel:isRewardGeted(pictureId, groupPrizeId)
	if pictureId > self._curPictureId then
		return false
	else
		for i, v in ipairs(self._prizeInfos) do
			if v.pictureId == pictureId then
				if groupPrizeId <= 0 then
					if pictureId < self._curPictureId then
						return v.bigPrizeGained
					elseif #self._curPictureActiveJigsawIds >= MAXPIECECOUNT then
						return v.bigPrizeGained
					else
						return false
					end
				elseif v.gainedGroupPrizeIds then
					return (TableUtil.isHad(v.gainedGroupPrizeIds, groupPrizeId))
				end
			end
		end
	end
end

function InfiniteJigsawModel:isPictureAllUnlock(pictureId)
	if pictureId < self._curPictureId then
		return true
	else
		return #self._curPictureActiveJigsawIds >= MAXPIECECOUNT
	end
end

function InfiniteJigsawModel:isPictureAllLock(pictureId)
	if pictureId < self._curPictureId then
		return false
	else
		return #self._curPictureActiveJigsawIds == 0
	end
end

function InfiniteJigsawModel:isExistRewardCanGet(pictureId)
	for i, v in ipairs(self._prizeInfos) do
		if v.pictureId == pictureId then
			if pictureId > self._curPictureId then
				return false
			else
				if not v.bigPrizeGained and v.gainedGroupPrizeIds and #v.gainedGroupPrizeIds >= MAXREWARDCOUNT then
					return true
				end

				if v.gainedGroupPrizeIds then
					if #v.gainedGroupPrizeIds >= MAXREWARDCOUNT then
						return false
					else
						for i = 1, MAXREWARDCOUNT do
							if self:isRewardCanGet(pictureId, i) then
								return true
							end
						end

						return false
					end
				else
					for i = 1, MAXREWARDCOUNT do
						if self:isRewardCanGet(pictureId, i) then
							return true
						end
					end

					return false
				end
			end
		end
	end

	return false
end

function InfiniteJigsawModel:isExistTaskRewardCanGet()
	local taskPlanId = self:getTaskPlanId()
	local taskList = InfiniteJigsawConfig.instance:getTaskList(taskPlanId)

	for i, v in ipairs(self._taskInfos) do
		if not v.prizeGained and taskList[v.taskId] then
			local isTaskFinished = v.curProgress >= taskList[v.taskId].maxProgress

			if isTaskFinished then
				return true
			end
		end
	end

	return false
end

function InfiniteJigsawModel:isShowDailyRedPoint()
	return not GameUtil.getUserDayData(InfiniteJigsawModel.DailyRedPoint)
end

InfiniteJigsawModel.instance = InfiniteJigsawModel.New()

return InfiniteJigsawModel
