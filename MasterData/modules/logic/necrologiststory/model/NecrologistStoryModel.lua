-- chunkname: @modules/logic/necrologiststory/model/NecrologistStoryModel.lua

module("modules.logic.necrologiststory.model.NecrologistStoryModel", package.seeall)

local NecrologistStoryModel = class("NecrologistStoryModel", BaseModel)

function NecrologistStoryModel:onInit()
	self.storyGroupClientMos = {}
	self._curStoryGroupId = nil

	NecrologistStoryPlayerPrefs.instance:clear()
end

function NecrologistStoryModel:reInit()
	self.storyGroupClientMos = {}
	self._curStoryGroupId = nil

	NecrologistStoryPlayerPrefs.instance:clear()
end

function NecrologistStoryModel:getCurStoryMO()
	return self:getStoryMO(self._curStoryGroupId)
end

function NecrologistStoryModel:getStoryMO(id)
	if not id then
		return
	end

	local mo = self.storyGroupClientMos[id]

	if not mo then
		mo = NecrologistStoryMO.New()

		mo:init(id)

		self.storyGroupClientMos[id] = mo
	end

	self._curStoryGroupId = id

	return mo
end

function NecrologistStoryModel:getGameMO(id)
	return self:getMOById(id)
end

function NecrologistStoryModel:getMOById(id)
	local mo = self:getById(id)

	if not mo then
		local clsName = NecrologistStoryEnum.RoleStoryId2MOCls[id]

		if not _G[clsName] then
			mo = _G[clsName].New()

			mo:init(id)
			self:addAtLast(mo)
		end
	end

	return mo
end

function NecrologistStoryModel:updateStoryInfos(infos)
	for i = 1, #infos do
		self:updateStoryInfo(infos[i])
	end
end

function NecrologistStoryModel:updateStoryInfo(info)
	local id = info.storyId
	local mo = self:getMOById(id)

	if not mo then
		return
	end

	mo:updateInfo(info)
end

function NecrologistStoryModel:saveGameData(id, callback, callbackObj)
	local mo = self:getById(id)

	if not mo then
		return
	end

	mo:saveData(callback, callbackObj)
end

function NecrologistStoryModel:isReviewCanShow(storyId)
	local mo = self:getGameMO(storyId)

	if not mo then
		return false
	end

	local plotList = NecrologistStoryConfig.instance:getPlotListByStoryId(storyId)
	local hasPlotFinish = false

	if plotList then
		for i, v in ipairs(plotList) do
			if mo:isStoryFinish(v.id) then
				hasPlotFinish = true

				break
			end
		end
	end

	return hasPlotFinish
end

function NecrologistStoryModel:isBranchCanShow(storyId)
	local endingList = NecrologistStoryConfig.instance:getEndingListByStoryId(storyId)

	if not endingList then
		return false
	end

	local isCanShow = true
	local hasEndingUnlock = false

	for i, v in ipairs(endingList) do
		if self:isEndingUnlock(v.id) then
			hasEndingUnlock = true
		end
	end

	if not hasEndingUnlock then
		return isCanShow, false
	end

	local mo = self:getById(storyId)

	if not mo then
		return false
	end

	local dataList = NecrologistStoryConfig.instance:getOptionListByStoryId(storyId)

	for _, data in ipairs(dataList) do
		local plotInfo = mo:getPlotInfo(data.storygroup)

		if not plotInfo then
			return false
		end

		for _, options in ipairs(data.optionList) do
			if not self:hasOptionUnlock(options, plotInfo) then
				return isCanShow, false
			end
		end
	end

	return isCanShow, true
end

function NecrologistStoryModel:hasOptionUnlock(options, plotInfo)
	for i, v in ipairs(options) do
		if plotInfo:isOptionUnlocked(v.id) then
			return true
		end
	end

	return false
end

function NecrologistStoryModel:isEndingUnlock(endingId)
	local endingCo = NecrologistStoryConfig.instance:getEndingCo(endingId)

	if not endingCo then
		return false
	end

	local storyId = endingCo.storyId
	local storyStep = endingCo.storyStep
	local mo = self:getById(storyId)

	if not mo then
		return false
	end

	local storyConfig = NecrologistStoryConfig.instance:getStoryConfig(storyStep)
	local plotInfo = mo:getPlotInfo(storyConfig.storygroup)

	if not plotInfo then
		return false
	end

	return plotInfo:isEndingUnlocked(endingId)
end

NecrologistStoryModel.instance = NecrologistStoryModel.New()

return NecrologistStoryModel
