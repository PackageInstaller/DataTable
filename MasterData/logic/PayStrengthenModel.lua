-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paystrengthen/model/PayStrengthenModel.lua

module("logic.extensions.paystrengthen.model.PayStrengthenModel", package.seeall)

local PayStrengthenModel = class("PayStrengthenModel", BaseModel)

PayStrengthenModel.LEVEL = 1
PayStrengthenModel.STARGOD = 2
PayStrengthenModel.AWAKELEVEL = 3
PayStrengthenModel.SKILLLEVEL = 4
PayStrengthenModel.EQUIPMENT = 5
PayStrengthenModel.SELECTSTARGOD = 6
PayStrengthenModel.NORMALSKILL = 7
PayStrengthenModel.ULTIMATESKILL = 8
PayStrengthenModel.PASSIVESKILL = 9

function PayStrengthenModel:onInit()
	self:onReset()
end

function PayStrengthenModel:onReset()
	self._curSelectPetId = nil
	self.limitTimeInfoMap = {}
	self._activityId = 0
	self._infos = {}
	self._infos[PayStrengthenModel.LEVEL] = 0
	self._infos[PayStrengthenModel.STARGOD] = 0
	self._infos[PayStrengthenModel.AWAKELEVEL] = 0
	self._infos[PayStrengthenModel.SKILLLEVEL] = 0
	self._infos[PayStrengthenModel.EQUIPMENT] = 0
	self._infos[PayStrengthenModel.SELECTSTARGOD] = 0
	self._infos[PayStrengthenModel.NORMALSKILL] = 0
	self._infos[PayStrengthenModel.ULTIMATESKILL] = 0
	self._infos[PayStrengthenModel.PASSIVESKILL] = 0
end

function PayStrengthenModel:onActivityPayStrengthenInfoRes(activityId, msg)
	self._activityId = activityId

	for i, v in ipairs(msg.infos) do
		self._infos[v.type] = v.times
	end
end

function PayStrengthenModel:onActivityPayStrengthenTimeLimitInfo(activityId, msg)
	self._activityId = activityId

	local map = {}

	for i, v in ipairs(msg.infos or {}) do
		map[v.type] = GameUtil.pbToTable(v)
	end

	self.limitTimeInfoMap[activityId] = map
end

function PayStrengthenModel:getInfoIsLimit(activityId, type)
	if self.limitTimeInfoMap[activityId] then
		return self.limitTimeInfoMap[activityId][type]
	end
end

function PayStrengthenModel:addInfoIsLimit(type)
	if self._activityId and self.limitTimeInfoMap then
		if not self.limitTimeInfoMap[self._activityId] then
			if not self.limitTimeInfoMap[self._activityId][type] then
				local info = {}

				info.times = checknumber(info.times) + 1
				self.limitTimeInfoMap[self._activityId][type] = info
				self.limitTimeInfoMap[self._activityId] = self.limitTimeInfoMap[self._activityId]
			end
		end
	end
end

function PayStrengthenModel:onNotifyCommonPayStrengthenSucRes(msg)
	return
end

function PayStrengthenModel:onNotifyActivityPayStrengthenSucRes(msg)
	self._infos[msg.type] = msg.times
end

function PayStrengthenModel:getUsedTimes(typeId)
	if self._infos[typeId] then
		return self._infos[typeId]
	else
		return 0
	end
end

function PayStrengthenModel:setCurSelectPetId(petId)
	self._curSelectPetId = petId
end

function PayStrengthenModel:getCurSelectPetId()
	return self._curSelectPetId
end

PayStrengthenModel.instance = PayStrengthenModel.New()

return PayStrengthenModel
