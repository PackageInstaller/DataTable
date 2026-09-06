-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckymoney/model/LuckyMoneyModel.lua

module("logic.extensions.luckymoney.model.LuckyMoneyModel", package.seeall)

local LuckyMoneyModel = class("LuckyMoneyModel", BaseModel)

function LuckyMoneyModel:ctor()
	return
end

function LuckyMoneyModel:onInit()
	self:onReset()
end

function LuckyMoneyModel:onReset()
	self._infos = {}
end

function LuckyMoneyModel:getInfo(activityId)
	if self._infos[activityId] == nil then
		self._infos[activityId] = {}
	end

	return self._infos[activityId]
end

function LuckyMoneyModel:handlePM_LuckyMoneyGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
	self._infos[msg.activityId].gainedDataBitId = msg.gainedDataBitId or {}
end

function LuckyMoneyModel:handlePM_LuckyMoneyActEndRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
end

function LuckyMoneyModel:handlePM_LuckyMoneyGainProgressPrizeRes(msg)
	local info = self._infos[msg.activityId]

	info.gainedDataBitId = info.gainedDataBitId or {}

	table.insert(info.gainedDataBitId, msg.dataBitId)
end

function LuckyMoneyModel:getTodayHasActCount(activityId)
	local info = self._infos[activityId]

	return info.todayHasActCount or 0
end

function LuckyMoneyModel:getChoosePetId(activityId)
	local info = self._infos[activityId]

	return info.choosePetId or 0
end

function LuckyMoneyModel:setChoosePetId(activityId, choosePetId)
	local info = self._infos[activityId]

	info.choosePetId = choosePetId
end

function LuckyMoneyModel:getSelectWordId(activityId)
	local info = self._infos[activityId]

	return info.selectWordId or 0
end

function LuckyMoneyModel:setSelectWordId(activityId, selectWordId)
	local info = self._infos[activityId]

	info.selectWordId = selectWordId
end

function LuckyMoneyModel:getPlayerTotalScore(activityId)
	local info = self._infos[activityId]

	return info.scoreProgress or 0
end

LuckyMoneyModel.instance = LuckyMoneyModel.New()

return LuckyMoneyModel
