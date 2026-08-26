-- chunkname: @modules/logic/versionactivity1_4/act134/model/Activity134Model.lua

module("modules.logic.versionactivity1_4.act134.model.Activity134Model", package.seeall)

local Activity134Model = class("Activity134Model", BaseModel)

function Activity134Model:ctor()
	self.super:ctor()

	self.serverTaskModel = BaseModel.New()
end

function Activity134Model:onInitMo(info)
	self.actId = info.activityId

	self:initStory(info.hasGetBonusIds)
	self:setTasksInfo(info.tasks)
end

function Activity134Model:getCurActivityID()
	return self.actId
end

function Activity134Model:initStory(getBonusId)
	self.storyMoList = {}
	self.finishStoryCount = #getBonusId
	self.maxNeedClueCount = 0

	for i, v in ipairs(Activity134Config.instance:getBonusAllConfig()) do
		local mo = Activity134StoryMo.New()

		mo:init(i, v)

		if getBonusId[v.id] then
			if not Activity134Enum.StroyStatus.Finish then
				mo.status = Activity134Enum.StroyStatus.Orgin
				self.maxNeedClueCount = Mathf.Max(self.maxNeedClueCount, mo.needTokensQuantity)

				table.insert(self.storyMoList, mo)
			end
		end
	end

	table.sort(self.storyMoList, function(a, b)
		return a.needTokensQuantity < b.needTokensQuantity
	end)
end

function Activity134Model:getStoryMoByIndex(index)
	for _, v in ipairs(self.storyMoList) do
		if v.index == index then
			return v
		end
	end
end

function Activity134Model:getStoryMoById(id)
	for _, v in ipairs(self.storyMoList) do
		if id == v.config.id then
			return v
		end
	end
end

function Activity134Model:getAllStoryMo()
	return self.storyMoList
end

function Activity134Model:getStoryTotalCount()
	return #self.storyMoList
end

function Activity134Model:getFinishStoryCount()
	return self.finishStoryCount
end

function Activity134Model:getClueCount()
	local clueCurrencyMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act134Clue)

	if clueCurrencyMo then
		return clueCurrencyMo.quantity
	end
end

function Activity134Model:getMaxClueCount()
	return self.maxNeedClueCount
end

function Activity134Model:checkGetStoryBonus()
	local clueCount = self:getClueCount()
	local isHas

	for _, v in ipairs(self.storyMoList) do
		if v.status == Activity134Enum.StroyStatus.Orgin and clueCount >= tonumber(v.needTokensQuantity) then
			Activity134Rpc.instance:sendGet134BonusRequest(self.actId, v.config.id)

			isHas = true
		end
	end

	return isHas
end

function Activity134Model:onReceiveBonus(bonusId)
	if not bonusId then
		return
	end

	local mo = self.storyMoList[bonusId]

	if not mo or mo.status == Activity134Enum.StroyStatus.Finish then
		return
	end

	mo.status = Activity134Enum.StroyStatus.Finish
	self.finishStoryCount = Mathf.Max(self.finishStoryCount, mo.index)
end

function Activity134Model:getTaskMoById(id)
	for _, v in ipairs(self.serverTaskModel) do
		if id == v.config.id then
			return v
		end
	end
end

function Activity134Model:getTasksInfo()
	return self.serverTaskModel:getList()
end

function Activity134Model:setTasksInfo(taskInfo)
	local hasChange

	for i, info in ipairs(taskInfo) do
		local mo = self.serverTaskModel:getById(info.id)

		if mo then
			mo:update(info)
		else
			local co = Activity134Config.instance:getTaskConfig(info.id)

			if co then
				mo = TaskMo.New()

				mo:init(info, co)
				self.serverTaskModel:addAtLast(mo)
			end
		end

		hasChange = true
	end

	if hasChange then
		self:sortList()
	end

	return hasChange
end

function Activity134Model:deleteInfo(taskInfo)
	local removeDict = {}

	for _, id in pairs(taskInfo) do
		local mo = self.serverTaskModel:getById(id)

		if mo then
			removeDict[id] = mo
		end
	end

	for id, mo in pairs(removeDict) do
		self.serverTaskModel:remove(mo)
	end

	local isChange = next(removeDict)

	if isChange then
		self:sortList()
	end

	return isChange
end

function Activity134Model:sortList()
	self.serverTaskModel:sort(function(a, b)
		local aValue = a.finishCount > 0 and 3 or a.progress >= a.config.maxProgress and 1 or 2
		local bValue = b.finishCount > 0 and 3 or b.progress >= b.config.maxProgress and 1 or 2

		if aValue ~= bValue then
			return aValue < bValue
		else
			return a.config.id < b.config.id
		end
	end)
end

function Activity134Model:getBonusFillWidth()
	local clueCount = self:getClueCount()

	if clueCount <= 0 then
		return 0
	end

	local index, width, tokens, nexttokens = 0, 0, 0, 0
	local total = self:getStoryTotalCount()

	for _, v in ipairs(self.storyMoList) do
		if clueCount > v.needTokensQuantity then
			index = v.index

			break
		end
	end

	if clueCount > self:getMaxClueCount() then
		index = total
	end

	if index == 0 then
		tokens = -30
		nexttokens = self.storyMoList[1].needTokensQuantity
	elseif total <= index then
		tokens = self.storyMoList[total].needTokensQuantity
		nexttokens = self.storyMoList[total].needTokensQuantity
	else
		tokens = self.storyMoList[index].needTokensQuantity
		nexttokens = self.storyMoList[index + 1].needTokensQuantity
	end

	local progress = nexttokens == tokens and 0 or (clueCount - tokens) / (nexttokens - tokens)

	return 970 + 310 * (index - 1 + progress)
end

Activity134Model.instance = Activity134Model.New()

return Activity134Model
