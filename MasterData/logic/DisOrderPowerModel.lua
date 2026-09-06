-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/disorderpower/model/DisOrderPowerModel.lua

module("logic.extensions.disorderpower.model.DisOrderPowerModel", package.seeall)

local DisOrderPowerModel = class("DisOrderPowerModel", BaseModel)

function DisOrderPowerModel:onInit()
	self:onReset()
end

function DisOrderPowerModel:onReset()
	self._ModelPool = {}
	self._fmtMoPool = {}
	self._itemStack = {}
end

function DisOrderPowerModel:GetModel(activityId)
	if self._ModelPool[activityId] == nil then
		local cur = {}

		cur.finishCardIds = nil
		cur.gainPrizeIds = nil
		cur.curCardId = 0
		self._ModelPool[activityId] = cur
	end

	return self._ModelPool[activityId]
end

function DisOrderPowerModel:getFmtMo(activityId)
	if self._fmtMoPool[activityId] == nil then
		self._fmtMoPool[activityId] = DisOrderPowerFmtMo.New()
	end

	return self._fmtMoPool[activityId]
end

function DisOrderPowerModel:addItemStack(cardId)
	table.insert(self._itemStack, cardId)
end

function DisOrderPowerModel:getTopItemStack(cardId)
	if #self._itemStack == 0 then
		return 0
	end

	return self._itemStack[#self._itemStack]
end

function DisOrderPowerModel:popItemStack()
	if #self._itemStack == 0 then
		return 0
	end

	return table.remove(self._itemStack, #self._itemStack)
end

function DisOrderPowerModel:handlePM_DisorderPowerGetInfoRes(msg)
	local pb = GameUtil.pbToTable(msg)
	local curModel = self:GetModel(msg.activityId)

	curModel.finishCardIds = msg.finishCardIds
	curModel.gainPrizeIds = msg.gainPrizeIds
	curModel.curCardId = msg.curCardId
end

function DisOrderPowerModel:handlePM_DisorderPowerLotteryRes(msg)
	local curModel = self:GetModel(msg.activityId)

	curModel.curCardId = msg.curCardId
end

function DisOrderPowerModel:handlePM_DisorderPowerNotifyFightRes(msg)
	local curModel = self:GetModel(msg.activityId)
	local win = msg.isWin

	if win then
		curModel.finishCardIds = msg.finishCardIds
		curModel.curCardId = msg.curCardId

		self:addItemStack(msg.fightCardId)
	end
end

function DisOrderPowerModel:handlePM_DisorderPowerGainPrizeRes(msg)
	local curModel = self:GetModel(msg.activityId)

	curModel.gainPrizeIds = curModel.gainPrizeIds or {}

	table.insert(curModel.gainPrizeIds, msg.prizeId)
end

DisOrderPowerModel.instance = DisOrderPowerModel.New()

return DisOrderPowerModel
