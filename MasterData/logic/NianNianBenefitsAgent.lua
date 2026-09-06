-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianwelfare/agent/NianNianBenefitsAgent.lua

module("logic.extensions.niannianbenefits.agent.NianNianBenefitsAgent", package.seeall)

local NianNianBenefitsAgent = class("NianNianBenefitsAgent", BaseAgent)

function NianNianBenefitsAgent:sendPM_NianNianBenefitsInfoReq(actId)
	local req = NianNianBenefitsExtension_pb.PM_NianNianBenefitsInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function NianNianBenefitsAgent:handlePM_NianNianBenefitsInfoRes(status, msg)
	if status == 0 then
		NianNianWelfareController.instance:handlePM_NianNianBenefitsInfoRes(msg)
	end
end

function NianNianBenefitsAgent:sendPM_NianNianBenefitsUpgradeReq(actId, partsId)
	local req = NianNianBenefitsExtension_pb.PM_NianNianBenefitsUpgradeReq()

	req.actId = actId
	req.partsId = partsId

	self:sendMsg(req)
end

function NianNianBenefitsAgent:handlePM_NianNianBenefitsUpgradeRes(status, msg)
	if status == 0 then
		NianNianWelfareController.instance:handlePM_NianNianBenefitsUpgradeRes()
	end
end

function NianNianBenefitsAgent:sendPM_NianNianBenefitsGainDailPrizeReq(actId)
	local req = NianNianBenefitsExtension_pb.PM_NianNianBenefitsGainDailPrizeReq()

	req.actId = actId

	self:sendMsg(req)
end

function NianNianBenefitsAgent:handlePM_NianNianBenefitsGainDailPrizeRes(status, msg)
	if status == 0 then
		NianNianWelfareController.instance:handlePM_NianNianBenefitsGainDailPrizeRes(msg)
	end
end

function NianNianBenefitsAgent:sendPM_NianNianBenefitsRefineReq(actId)
	local req = NianNianBenefitsExtension_pb.PM_NianNianBenefitsRefineReq()

	req.actId = actId

	self:sendMsg(req)
end

function NianNianBenefitsAgent:handlePM_NianNianBenefitsRefineRes(status, msg)
	if status == 0 then
		NianNianWelfareController.instance:handlePM_NianNianBenefitsRefineRes(msg)
	end
end

function NianNianBenefitsAgent:sendPM_NianNianBenefitsAchievementPrizeReq(acrId, achievementId)
	local req = NianNianBenefitsExtension_pb.PM_NianNianBenefitsAchievementPrizeReq()

	req.acrId = acrId
	req.achievementId = achievementId

	self:sendMsg(req)
end

function NianNianBenefitsAgent:handlePM_NianNianBenefitsAchievementPrizeRes(status, msg)
	if status == 0 then
		NianNianWelfareController.instance:handlePM_NianNianBenefitsAchievementPrizeRes(msg)
	end
end

NianNianBenefitsAgent.instance = NianNianBenefitsAgent.New()

return NianNianBenefitsAgent
