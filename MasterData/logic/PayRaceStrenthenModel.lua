-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payracestrengthen/model/PayRaceStrenthenModel.lua

module("logic.extensions.payracestrengthen.model.PayRaceStrenthenModel", package.seeall)

local PayRaceStrenthenModel = class("PayRaceStrenthenModel", BaseModel)

function PayRaceStrenthenModel:onInit()
	self:onReset()
end

function PayRaceStrenthenModel:onReset()
	self._strengthTimesList = {}
	self._id = 0
	self._petId = 0
	self._usedTimes = 0
end

function PayRaceStrenthenModel:onPayRaceStrengthenInfoRes(msg)
	table.clear(self._strengthTimesList)

	local list = GameUtil.pbToTable(msg.times) or {}

	for i, v in ipairs(list) do
		self._strengthTimesList[v.id] = v
	end
end

function PayRaceStrenthenModel:onNotifyPayRaceStrengthenSucRes(msg)
	self._id = msg.id
	self._petId = msg.petId
	self._usedTimes = msg.usedTimes

	if self._strengthTimesList[msg.id] then
		self._strengthTimesList[msg.id].usedTimes = msg.usedTimes
	else
		self._strengthTimesList[msg.id] = {}
		self._strengthTimesList[msg.id].id = msg.id
		self._strengthTimesList[msg.id].usedTimes = msg.usedTimes
	end

	local cfg = DirectPurchaseConfig.instance:getDirectLevelUp(msg.id)

	if cfg and cfg.excludeGroup and #cfg.excludeGroup > 0 then
		for i, id in ipairs(cfg.excludeGroup) do
			if self._strengthTimesList[id] then
				self._strengthTimesList[id].usedTimes = self._strengthTimesList[id].usedTimes + 1
			else
				self._strengthTimesList[id] = {}
				self._strengthTimesList[id].id = id
				self._strengthTimesList[id].usedTimes = 1
			end
		end
	end
end

function PayRaceStrenthenModel:getUsedTimes(id)
	if self._strengthTimesList[id] then
		return self._strengthTimesList[id].usedTimes
	end

	return 0
end

function PayRaceStrenthenModel:getCurBuySuccessId()
	return self._id
end

PayRaceStrenthenModel.instance = PayRaceStrenthenModel.New()

return PayRaceStrenthenModel
