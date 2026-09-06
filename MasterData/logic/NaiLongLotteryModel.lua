-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonglottery/model/NaiLongLotteryModel.lua

module("logic.extensions.nailonglottery.model.NaiLongLotteryModel", package.seeall)

local NaiLongLotteryModel = class("NaiLongLotteryModel", BaseModel)

function NaiLongLotteryModel:onInit()
	self:onReset()
end

function NaiLongLotteryModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function NaiLongLotteryModel:getNaiLongLotteryMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = NaiLongLotteryMo.New(activityId)
	end

	return self._moPool[activityId]
end

NaiLongLotteryModel.instance = NaiLongLotteryModel.New()

return NaiLongLotteryModel
