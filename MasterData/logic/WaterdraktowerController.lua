-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/controller/WaterdraktowerController.lua

module("logic.extensions.waterdraktower.controller.WaterdraktowerController", package.seeall)

local WaterdraktowerController = class("WaterdraktowerController", BaseController)

WaterdraktowerController.PM_WaterDarkTowerAfterFightRes = "WaterdraktowerController.PM_WaterDarkTowerAfterFightRes"
WaterdraktowerController.PM_WaterDarkTowerGetRankInfoRes = "WaterdraktowerController.PM_WaterDarkTowerGetRankInfoRes"
WaterdraktowerController.PM_WaterDarkTowerBuyTimesRes = "WaterdraktowerController.PM_WaterDarkTowerBuyTimesRes"
WaterdraktowerController.PM_WaterDarkTowerFightRes = "WaterdraktowerController.PM_WaterDarkTowerFightRes"
WaterdraktowerController.PM_WaterDarkTowerGetInfoRes = "WaterdraktowerController.PM_WaterDarkTowerGetInfoRes"
WaterdraktowerController.PM_WaterDarkTowerGetFormRes = "aterdraktowerController.PM_WaterDarkTowerGetFormRes"
WaterdraktowerController.PM_WaterDarkTowerSetFormRes = "WaterdraktowerController.PM_WaterDarkTowerSetFormRes"

function WaterdraktowerController:ctor()
	return
end

function WaterdraktowerController:onInit()
	GlobalDispatcher:addListener(WaterDarkTowerAgent.PM_WaterDarkTowerAfterFightRes, self._PM_WaterDarkTowerAfterFightRes, self)
	GlobalDispatcher:addListener(WaterDarkTowerAgent.PM_WaterDarkTowerGetRankInfoRes, self._PM_WaterDarkTowerGetRankInfoRes, self)
	GlobalDispatcher:addListener(WaterDarkTowerAgent.PM_WaterDarkTowerBuyTimesRes, self._PM_WaterDarkTowerBuyTimesRes, self)
	GlobalDispatcher:addListener(WaterDarkTowerAgent.PM_WaterDarkTowerFightRes, self._PM_WaterDarkTowerFightRes, self)
	GlobalDispatcher:addListener(WaterDarkTowerAgent.PM_WaterDarkTowerGetInfoRes, self._PM_WaterDarkTowerGetInfoRes, self)
	GlobalDispatcher:addListener(WaterDarkTowerAgent.PM_WaterDarkTowerGetFormRes, self._PM_WaterDarkTowerGetFormRes, self)
	GlobalDispatcher:addListener(WaterDarkTowerAgent.PM_WaterDarkTowerSetFormRes, self._PM_WaterDarkTowerSetFormRes, self)
	self:onReset()
end

function WaterdraktowerController:onReset()
	self:resetPassRankData()
end

function WaterdraktowerController:_PM_WaterDarkTowerAfterFightRes(status, msg)
	if status == 0 then
		local finishSize = checknumber(msg.finishSize)

		if msg.isWin and finishSize > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

			self._passRankData = {
				rank = finishSize,
				changeSetId = msg.changeSetId
			}
		elseif msg.isWin then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		end
	end

	GlobalDispatcher:dispatch(WaterdraktowerController.PM_WaterDarkTowerAfterFightRes, status, msg)
end

function WaterdraktowerController:_PM_WaterDarkTowerGetRankInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(WaterdraktowerController.PM_WaterDarkTowerGetRankInfoRes, status, msg)
end

function WaterdraktowerController:_PM_WaterDarkTowerBuyTimesRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("购买次数成功")
		WaterdraktowerModel.instance:addBuyTime()
	end

	GlobalDispatcher:dispatch(WaterdraktowerController.PM_WaterDarkTowerBuyTimesRes, status, msg)
end

function WaterdraktowerController:_PM_WaterDarkTowerFightRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(WaterdraktowerController.PM_WaterDarkTowerFightRes, status, msg)
end

function WaterdraktowerController:_PM_WaterDarkTowerGetInfoRes(status, msg)
	if status == 0 then
		WaterdraktowerModel.instance:setInfo(msg)
	end

	GlobalDispatcher:dispatch(WaterdraktowerController.PM_WaterDarkTowerGetInfoRes, status, msg)
end

function WaterdraktowerController:_PM_WaterDarkTowerGetFormRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(WaterdraktowerController.PM_WaterDarkTowerGetFormRes, status, msg)
end

function WaterdraktowerController:_PM_WaterDarkTowerSetFormRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(WaterdraktowerController.PM_WaterDarkTowerSetFormRes, status, msg)
end

function WaterdraktowerController:openView()
	local actType = GameEnum.ActivityType.WaterDrakTower
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(actType)

	if cfgs then
		local activityId = false

		for k, v in pairs(cfgs) do
			if ActivityDefineController.instance:isInActivityTimeById(actType, v.activityId) then
				activityId = v.activityId

				break
			end
		end

		if activityId then
			UIStateManager.instance:push(ViewName.WaterdraktowermainView, activityId)
		else
			FloatWordMgr.instance:show("不在活动开放时间内")
		end
	end
end

function WaterdraktowerController:getPassRankData()
	return self._passRankData
end

function WaterdraktowerController:resetPassRankData()
	self._passRankData = false
end

function WaterdraktowerController:sendPM_WaterDarkTowerSetFormReq(actId, towerType, simpleForm_pb)
	local req = WaterDarkTowerExtension_pb.PM_WaterDarkTowerSetFormReq()

	req.actId = actId
	req.towerType = towerType

	if simpleForm_pb ~= nil then
		req.simpleForm:ParseFromString(simpleForm_pb:SerializeToString())
	end

	WaterDarkTowerAgent.instance:sendMsg(req)
end

function WaterdraktowerController:csGetWaterDarkTowerGetInfoReq()
	local actId = WaterdraktowerModel.instance.openActId

	if checknumber(actId) <= 0 then
		return
	end

	WaterDarkTowerAgent.instance:sendPM_WaterDarkTowerGetInfoReq(actId, 1)
end

function WaterdraktowerController:scSendWaterDarkTowerGetInfo(msg)
	WaterdraktowerModel.instance:scSendWaterDarkTowerGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.WaterDarkTowerGetInfo)
end

function WaterdraktowerController:csGetWaterDarkTowerBuyTimesReq()
	local actId = WaterdraktowerModel.instance.openActId

	if checknumber(actId) <= 0 then
		return
	end

	WaterDarkTowerAgent.instance:sendPM_WaterDarkTowerBuyTimesReq(WaterdraktowerModel.instance.openActId)
end

function WaterdraktowerController:scSendWaterDarkTowerBuyTimes(msg)
	WaterdraktowerModel.instance:scSendWaterDarkTowerBuyTimes()
	GlobalDispatcher:dispatch(GlobalNotify.WaterDarkTowerBuyTimes)
end

function WaterdraktowerController:csGetWaterDarkTowerGetRankInfoReq()
	local actId = WaterdraktowerModel.instance.openActId

	if checknumber(actId) <= 0 then
		return
	end

	WaterDarkTowerAgent.instance:sendPM_WaterDarkTowerGetRankInfoReq(actId, WaterdraktowerModel.instance.openTowerType)
end

function WaterdraktowerController:scSendWaterDarkTowerGetRankInfo(msg)
	if msg == nil or msg.rankInfos == nil then
		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.WaterDarkTowerGetRankInfo, msg.rankInfos, msg.myRank)
end

function WaterdraktowerController:csGetWaterDarkTowerFightReq(actId, towerType)
	if checknumber(actId) <= 0 or checknumber(towerType) <= 0 then
		return
	end

	WaterDarkTowerAgent.instance:sendPM_WaterDarkTowerFightReq(actId, towerType)
end

function WaterdraktowerController:scSendWaterDarkTowerAfterFight(msg)
	WaterdraktowerModel.instance:scSendWaterDarkTowerAfterFight(msg)
end

function WaterdraktowerController:csGetWaterDarkTowerSetFormReq(actId, towerType, simpleForm)
	if checknumber(actId) <= 0 or checknumber(towerType) <= 0 then
		return
	end

	local req = WaterDarkTowerExtension_pb.PM_WaterDarkTowerSetFormReq()

	req.actId = actId
	req.towerType = towerType

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	WaterDarkTowerAgent.instance:sendMsg(req)
end

function WaterdraktowerController:scSendWaterDarkTowerSetForm(msg, status)
	GlobalDispatcher:dispatch(GlobalNotify.WaterDarkTowerSetForm, status)
end

function WaterdraktowerController:csGetWaterDarkTowerGetFormReq(actId, towerType)
	if checknumber(actId) <= 0 or checknumber(towerType) <= 0 then
		return
	end

	WaterDarkTowerAgent.instance:sendPM_WaterDarkTowerGetFormReq(actId, towerType)
end

function WaterdraktowerController:scSendWaterDarkTowerGetForm(msg)
	if msg == nil or msg.simpleForm == nil then
		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.WaterDarkTowerGetForm, msg.simpleForm)
end

WaterdraktowerController.instance = WaterdraktowerController.New()

return WaterdraktowerController
