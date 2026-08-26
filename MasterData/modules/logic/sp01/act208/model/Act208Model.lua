-- chunkname: @modules/logic/sp01/act208/model/Act208Model.lua

module("modules.logic.sp01.act208.model.Act208Model", package.seeall)

local Act208Model = class("Act208Model", BaseModel)

function Act208Model:onInit()
	self:reInit()
end

function Act208Model:reInit()
	self._infoMoDic = {}
end

function Act208Model:onGetInfo(activityId, bonus)
	local infoMo

	if self._infoMoDic[activityId] == nil then
		infoMo = Act208InfoMo.New()

		infoMo:init()

		self._infoMoDic[activityId] = infoMo
	else
		infoMo = self._infoMoDic[activityId]
	end

	infoMo:setInfo(activityId, bonus)
	Act208Controller.instance:dispatchEvent(Act208Event.onGetInfo, activityId)
end

function Act208Model:onGetBonus(activityId, id)
	local infoMo = self._infoMoDic[activityId]

	if infoMo == nil then
		logError("Act208 不存在的活动id ：" .. tostring(activityId))

		return
	end

	local bonusMo = infoMo.bonusDic[id]

	if bonusMo == nil then
		logError("Act208 不存在的活动id: " .. tostring(activityId) .. " 奖励id: " .. tostring(id))

		return
	end

	bonusMo.status = Act208Enum.BonusState.HaveGet

	Act208Controller.instance:dispatchEvent(Act208Event.onGetBonus, activityId, id)
end

function Act208Model:getInfo(activityId)
	if self._infoMoDic then
		return self._infoMoDic[activityId]
	end

	return nil
end

Act208Model.instance = Act208Model.New()

return Act208Model
