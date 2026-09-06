-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preheatsale/model/PreheatSaleModel.lua

module("logic.extensions.preheatsale.model.PreheatSaleModel", package.seeall)

local PreheatSaleModel = class("PreheatSaleModel", BaseModel)

function PreheatSaleModel:onInit()
	self:onReset()
end

function PreheatSaleModel:onReset()
	self._infos = {}
end

function PreheatSaleModel:onGetInfo(msg)
	self._infos = {}

	for _, v in ipairs(msg.infos) do
		local info = {}

		info.isHasBuy = v.buyState
		self._infos[v.activityId] = info
	end
end

function PreheatSaleModel:getIsHasBuy(actId)
	local info = self._infos[actId]

	return info and info.isHasBuy
end

function PreheatSaleModel:onFinishPay(msg)
	local info = self._infos[msg.activityId]

	if info then
		info.isHasBuy = msg.buyState
	end
end

function PreheatSaleModel:getCurActId()
	local actTimeCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.PerheatSale)

	if actTimeCfg then
		return actTimeCfg.activityId, actTimeCfg
	else
		return 0, nil
	end
end

function PreheatSaleModel:isOverTime(actId)
	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.PerheatSale, actId)

	if actCfg then
		return not ActivityDefineController.instance:_isInActivityTimeByCfg(actCfg)
	end

	return true
end

PreheatSaleModel.instance = PreheatSaleModel.New()

return PreheatSaleModel
