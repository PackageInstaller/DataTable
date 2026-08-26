-- chunkname: @modules/logic/versionactivity2_2/lopera/model/Activity168Model.lua

module("modules.logic.versionactivity2_2.lopera.model.Activity168Model", package.seeall)

local Activity168Model = class("Activity168Model", BaseModel)

function Activity168Model:onInit()
	self._passEpisodes = {}
	self._unlockEpisodes = {}
	self._episodeDatas = {}
	self._itemDatas = {}
	self._unLockCount = 0
	self._finishedCount = 0
	self._curActionPoint = 0
	self._curGameState = nil
end

function Activity168Model:reInit()
	self._passEpisodes = {}
	self._unlockEpisodes = {}
	self._episodeDatas = {}
	self._itemDatas = {}
	self._unLockCount = 0
	self._finishedCount = 0
	self._curActionPoint = 0
	self._curGameState = nil
end

function Activity168Model:setCurActId(actId)
	self._curActId = actId
end

function Activity168Model:getCurActId()
	return self._curActId
end

function Activity168Model:setCurEpisodeId(episodeId)
	self._curEpisodeId = episodeId
end

function Activity168Model:getCurEpisodeId()
	return self._curEpisodeId
end

function Activity168Model:setCurBattleEpisodeId(episodeId)
	self._curBattleEpisodeId = episodeId
end

function Activity168Model:getCurBattleEpisodeId()
	return self._curBattleEpisodeId
end

function Activity168Model:setCurActionPoint(point)
	self._curActionPoint = point
end

function Activity168Model:getCurActionPoint()
	return self._curActionPoint
end

function Activity168Model:setCurGameState(state)
	self._curGameState = state
end

function Activity168Model:getCurGameState()
	return self._curGameState
end

function Activity168Model:isEpisodeFinish(episodeId)
	return self._passEpisodes[episodeId]
end

function Activity168Model:onGetActInfoReply(act168Episodes)
	self._unLockCount = 0
	self._finishedCount = 0

	for _, episodeData in ipairs(act168Episodes) do
		local episodeId = episodeData.episodeId

		self._episodeDatas[episodeId] = episodeData
		self._unlockEpisodes[episodeId] = true
		self._unLockCount = self._unLockCount + 1

		if episodeData.isFinished then
			self._passEpisodes[episodeId] = true
			self._finishedCount = self._finishedCount + 1
		end

		if episodeData.act168Game then
			self:onItemInfoUpdate(episodeId, episodeData.act168Game.act168Items)
		end
	end
end

function Activity168Model:onEpisodeInfoUpdate(episodeData)
	local episodeId = episodeData.episodeId

	self._episodeDatas[episodeId] = episodeData

	if not self._passEpisodes[episodeId] and episodeData.isFinished then
		self._passEpisodes[episodeId] = true
		self._finishedCount = self._finishedCount + 1
	end

	if not self._unlockEpisodes[episodeId] then
		self._unlockEpisodes[episodeId] = true
		self._unLockCount = self._unLockCount + 1
	end

	if episodeData.act168Game then
		self:onItemInfoUpdate(episodeId, episodeData.act168Game.act168Items)
	end
end

function Activity168Model:getUnlockCount()
	return (self._unLockCount or nil) and (self._unLockCount or 10)
end

function Activity168Model:getFinishedCount()
	return self._finishedCount
end

function Activity168Model:isEpisodeUnlock(episodeId)
	return self._unlockEpisodes[episodeId]
end

function Activity168Model:isEpisodeFinished(episodeId)
	return self._passEpisodes[episodeId]
end

function Activity168Model:getEpisodeData(episodeId)
	return self._episodeDatas[episodeId]
end

function Activity168Model:getCurMoveCost(oriCost)
	oriCost = oriCost or 1

	local curGameState = self:getCurGameState()
	local buffs = curGameState and curGameState.buffs

	if buffs then
		for _, buff in ipairs(buffs) do
			oriCost = buff.ext + oriCost
		end
	end

	return oriCost
end

function Activity168Model:clearEpisodeItemInfo(episodeId)
	self._itemDatas[episodeId] = {}
end

function Activity168Model:onItemInfoUpdate(episodeId, updateItems, deleteItems, changed)
	self._itemChanged = self._itemChanged or {}
	self._itemDatas[episodeId] = self._itemDatas[episodeId] or {}

	local episodeItems = self._itemDatas[episodeId]

	if updateItems then
		for idx, itemData in ipairs(updateItems) do
			local itemId = itemData.itemId
			local count = itemData.count

			if not episodeItems[itemId] then
				episodeItems[itemId] = count

				if changed then
					self._itemChanged[itemId] = count - episodeItems[itemId]
				end
			end
		end
	end

	if deleteItems then
		for idx, itemData in ipairs(deleteItems) do
			local itemId = itemData.itemId

			if changed then
				self._itemChanged[itemId] = -itemData.count
			end

			episodeItems[itemId] = 0
		end
	end
end

function Activity168Model:getItemCount(itemId)
	local curEpisodeId = self:getCurEpisodeId()

	return (self._itemDatas[curEpisodeId] or nil) and (self._itemDatas[curEpisodeId][itemId] or 0)
end

function Activity168Model:clearItemChangeDict()
	self._itemChanged = {}
end

function Activity168Model:getItemChangeDict()
	return self._itemChanged
end

function Activity168Model:getCurEpisodeItems()
	local curEpisodeId = self:getCurEpisodeId()

	return self._itemDatas[curEpisodeId]
end

Activity168Model.instance = Activity168Model.New()

return Activity168Model
