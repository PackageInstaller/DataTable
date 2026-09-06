-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/agent/WaterDarkTowerAgent.lua

module("logic.extensions.waterdarktower.agent.WaterDarkTowerAgent", package.seeall)

local WaterDarkTowerAgent = class("WaterDarkTowerAgent", BaseAgent)

WaterDarkTowerAgent.PM_WaterDarkTowerAfterFightRes = "WaterDarkTowerAgent_PM_WaterDarkTowerAfterFightRes"
WaterDarkTowerAgent.PM_WaterDarkTowerGetFormRes = "WaterDarkTowerAgent_PM_WaterDarkTowerGetFormRes"
WaterDarkTowerAgent.PM_WaterDarkTowerSetFormRes = "WaterDarkTowerAgent_PM_WaterDarkTowerSetFormRes"
WaterDarkTowerAgent.PM_WaterDarkTowerGetRankInfoRes = "WaterDarkTowerAgent_PM_WaterDarkTowerGetRankInfoRes"
WaterDarkTowerAgent.PM_WaterDarkTowerBuyTimesRes = "WaterDarkTowerAgent_PM_WaterDarkTowerBuyTimesRes"
WaterDarkTowerAgent.PM_WaterDarkTowerFightRes = "WaterDarkTowerAgent_PM_WaterDarkTowerFightRes"
WaterDarkTowerAgent.PM_WaterDarkTowerGetInfoRes = "WaterDarkTowerAgent_PM_WaterDarkTowerGetInfoRes"

function WaterDarkTowerAgent:sendPM_WaterDarkTowerGetInfoReq(actId, towerType)
	local req = WaterDarkTowerExtension_pb.PM_WaterDarkTowerGetInfoReq()

	req.actId = actId
	req.towerType = towerType

	self:sendMsg(req)
end

function WaterDarkTowerAgent:handlePM_WaterDarkTowerGetInfoRes(status, msg)
	if status == 0 then
		WaterdraktowerController.instance:scSendWaterDarkTowerGetInfo(msg)
	end
end

function WaterDarkTowerAgent:sendPM_WaterDarkTowerFightReq(actId, towerType)
	local req = WaterDarkTowerExtension_pb.PM_WaterDarkTowerFightReq()

	req.actId = actId
	req.towerType = towerType

	self:sendMsg(req)
end

function WaterDarkTowerAgent:handlePM_WaterDarkTowerFightRes(status, msg)
	if status == 0 then
		BattleFacade.instance:startWLTowerBattle(true)
	elseif ViewMgr.instance:isOpen(ViewName.WLTowerMission) then
		UIStateManager.instance:clear(true)
	end
end

function WaterDarkTowerAgent:sendPM_WaterDarkTowerBuyTimesReq(actId)
	local req = WaterDarkTowerExtension_pb.PM_WaterDarkTowerBuyTimesReq()

	req.actId = actId

	self:sendMsg(req)
end

function WaterDarkTowerAgent:handlePM_WaterDarkTowerBuyTimesRes(status, msg)
	if status == 0 then
		WaterdraktowerController.instance:scSendWaterDarkTowerBuyTimes(msg)
	end
end

function WaterDarkTowerAgent:sendPM_WaterDarkTowerGetRankInfoReq(actId, towerType)
	local req = WaterDarkTowerExtension_pb.PM_WaterDarkTowerGetRankInfoReq()

	req.actId = actId
	req.towerType = towerType

	self:sendMsg(req)
end

function WaterDarkTowerAgent:handlePM_WaterDarkTowerGetRankInfoRes(status, msg)
	if status == 0 then
		WaterdraktowerController.instance:scSendWaterDarkTowerGetRankInfo(msg)
	end
end

function WaterDarkTowerAgent:sendPM_WaterDarkTowerSetFormReq(actId, towerType, simpleForm)
	local req = WaterDarkTowerExtension_pb.PM_WaterDarkTowerSetFormReq()

	req.actId = actId
	req.towerType = towerType
	req.simpleForm = simpleForm

	self:sendMsg(req)
end

function WaterDarkTowerAgent:handlePM_WaterDarkTowerSetFormRes(status, msg)
	if status == 0 then
		-- block empty
	end

	WaterdraktowerController.instance:scSendWaterDarkTowerSetForm(msg, status)
end

function WaterDarkTowerAgent:sendPM_WaterDarkTowerGetFormReq(actId, towerType)
	local req = WaterDarkTowerExtension_pb.PM_WaterDarkTowerGetFormReq()

	req.actId = actId
	req.towerType = towerType

	self:sendMsg(req)
end

function WaterDarkTowerAgent:handlePM_WaterDarkTowerGetFormRes(status, msg)
	if status == 0 then
		WaterdraktowerController.instance:scSendWaterDarkTowerGetForm(msg)
	end
end

function WaterDarkTowerAgent:handlePM_WaterDarkTowerAfterFightRes(status, msg)
	if status == 0 then
		WaterdraktowerController.instance:scSendWaterDarkTowerAfterFight(msg)
	end
end

WaterDarkTowerAgent.instance = WaterDarkTowerAgent.New()

return WaterDarkTowerAgent
