-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaGameModel.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaGameModel", package.seeall)

local AiZiLaGameModel = class("AiZiLaGameModel", BaseModel)

function AiZiLaGameModel:onInit()
	self:_clearData()
end

function AiZiLaGameModel:reInit()
	self:_clearData()
end

function AiZiLaGameModel:clear()
	AiZiLaGameModel.super.clear(self)
	self:_clearData()
end

function AiZiLaGameModel:_clearData()
	self._curEpisodeId = 0
	self._roundCount = 0
	self._elevation = 0
	self._isSafe = false
	self._isFirstPass = false
	self._curActivityId = VersionActivity1_5Enum.ActivityId.AiZiLa
	self._itemModel = self:_clearOrCreateModel(self._itemModel)
	self._resultItemModel = self:_clearOrCreateModel(self._resultItemModel)
	self._equipModel = self:_clearOrCreateModel(self._equipModel)
	self._curEpisodeMO = self._curEpisodeMO or AiZiLaEpsiodeMO.New()
end

function AiZiLaGameModel:_clearOrCreateModel(model)
	return AiZiLaHelper.clearOrCreateModel(model)
end

function AiZiLaGameModel:_updateMOModel(clsMO, model, moId, info)
	return AiZiLaHelper.updateMOModel(clsMO, model, moId, info)
end

function AiZiLaGameModel:_updateItemModel(itemInfo)
	return self:_updateMOModel(AiZiLaItemMO, self._itemModel, itemInfo.itemId, itemInfo)
end

function AiZiLaGameModel:setEpisodeId(episodeId, actId)
	self._curEpisodeId = episodeId
	self._curEpisodeMO = AiZiLaEpsiodeMO.New()

	self._curEpisodeMO:init(episodeId)

	local actId = VersionActivity1_5Enum.ActivityId.AiZiLa

	self._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(actId, episodeId)
end

function AiZiLaGameModel:getEpisodeId()
	return self._curEpisodeId
end

function AiZiLaGameModel:getActivityID()
	return self._curActivityId
end

function AiZiLaGameModel:getItemList()
	return self._itemModel:getList()
end

function AiZiLaGameModel:getItemQuantity(itemId)
	local itemMO = self._itemModel:getById(itemId)

	return itemMO and itemMO:getQuantity() or 0
end

function AiZiLaGameModel:getResultItemList(eventId)
	return self._resultItemModel:getList()
end

function AiZiLaGameModel:setIsSafe(isSafe)
	self._isSafe = isSafe
end

function AiZiLaGameModel:getIsSafe()
	return self._isSafe
end

function AiZiLaGameModel:isPass()
	return self._curEpisodeMO and self._curEpisodeMO:isPass() or false
end

function AiZiLaGameModel:getIsFirstPass()
	return self._isFirstPass
end

function AiZiLaGameModel:getEventId()
	return (self._curEpisodeMO or nil) and (self._curEpisodeMO.eventId or 0)
end

function AiZiLaGameModel:getBuffIdList()
	return self._curEpisodeMO and self._curEpisodeMO.buffIds
end

function AiZiLaGameModel:getElevation()
	return (self._curEpisodeMO or nil) and (self._curEpisodeMO.altitude or 0)
end

function AiZiLaGameModel:getRoundCount()
	return self._curEpisodeMO and self._curEpisodeMO.day
end

function AiZiLaGameModel:getEpisodeMO()
	return self._curEpisodeMO
end

function AiZiLaGameModel:updateEpisode(info)
	self._curEpisodeMO:updateInfo(info)
end

function AiZiLaGameModel:addAct144Items(tempAct144Items)
	self:_addModelAct144Items(self._itemModel, tempAct144Items)
end

function AiZiLaGameModel:setAct144Items(tempAct144Items)
	self._itemModel = self:_clearOrCreateModel(self._itemModel)

	self:_addModelAct144Items(self._itemModel, tempAct144Items)
end

function AiZiLaGameModel:_addModelAct144Items(model, tempAct144Items)
	for i, itemInfo in ipairs(tempAct144Items) do
		local itemMO = model:getById(itemInfo.itemId)

		if itemMO then
			itemMO:addInfo(itemInfo)
		else
			itemMO = AiZiLaItemMO.New()

			itemMO:init(itemInfo.itemId, itemInfo.itemId, itemInfo.quantity)
			model:addAtLast(itemMO)
		end
	end
end

function AiZiLaGameModel:setAct144ResultItems(tempAct144Items)
	self._resultItemModel = self:_clearOrCreateModel(self._resultItemModel)

	self:_addModelAct144Items(self._resultItemModel, tempAct144Items)
end

function AiZiLaGameModel:settlePush(msg)
	self._isSafe = msg.isSafe
	self._isFirstPass = msg.isFirstPass

	if not msg.tempAct144Items then
		self:setAct144ResultItems(msg.tempAct144Items)
		self:updateEpisode(msg)
	end
end

function AiZiLaGameModel:settleEpisodeReply(msg)
	local act144Episode = msg.act144Episode

	if act144Episode then
		if not act144Episode.tempAct144Items then
			local tempAct144Items = {}

			self:setAct144ResultItems(tempAct144Items)
			self:updateEpisode(act144Episode)
		end
	end
end

AiZiLaGameModel.instance = AiZiLaGameModel.New()

return AiZiLaGameModel
