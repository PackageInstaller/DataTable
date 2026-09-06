-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiuclg/model/HeartOfAoJiuClgModel.lua

module("logic.extensions.heartofaojiuclg.model.HeartOfAoJiuClgModel", package.seeall)

local HeartOfAoJiuClgModel = class("HeartOfAoJiuClgModel", BaseModel)

function HeartOfAoJiuClgModel:onInit()
	self:onReset()
end

function HeartOfAoJiuClgModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._fmtMo = nil
	self._rank0926Map = {}
end

function HeartOfAoJiuClgModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = HeartOfAoJiuClgSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function HeartOfAoJiuClgModel:getFmtMo()
	if self._fmtMo == nil then
		self._fmtMo = HeartOfAoJiuClgFmtMo.New()
	end

	return self._fmtMo
end

function HeartOfAoJiuClgModel:setRankMsg(msg)
	local activityId = msg.activityId

	self._rank0926Map[activityId] = GameUtil.pbToTable(msg) or {}
end

function HeartOfAoJiuClgModel:get0926RankInfo(activityId)
	return self._rank0926Map[activityId]
end

HeartOfAoJiuClgModel.instance = HeartOfAoJiuClgModel.New()

return HeartOfAoJiuClgModel
