-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cashback/model/CashBackModel.lua

module("logic.extensions.cashback.model.CashBackModel", package.seeall)

local CashBackModel = class("CashBackModel", BaseModel)

function CashBackModel:onInit()
	self:onReset()
end

function CashBackModel:onReset()
	self._curActId = 0
	self._hasGainPrizeIds = {}
	self._luckyInfos = {}
	self._curLuckyValue = 0
	self._curConsume = 0
end

function CashBackModel:onGetInfo(msg)
	self._curLuckyValue = checkint(msg.luckyValue)
	self._curConsume = checkint(msg.totalConsume)
	self._hasGainPrizeIds = msg.gainPrizeIds
	self._luckyInfos = msg.luckyList or {}
end

function CashBackModel:onGainPrize(msg)
	for k, v in ipairs(msg.gainPrizeIds) do
		if not self:isGainPrizeId(v) then
			table.insert(self._hasGainPrizeIds, v)
		end
	end
end

function CashBackModel:getCurLuckyValue()
	return self._curLuckyValue
end

function CashBackModel:getCurConsume()
	return self._curConsume
end

function CashBackModel:isGainPrizeId(id)
	if checkint(id) > 0 then
		return table.keyof(self._hasGainPrizeIds, id)
	end
end

function CashBackModel:getCurLuckyInfoList()
	return self._luckyInfos
end

CashBackModel.instance = CashBackModel.New()

return CashBackModel
