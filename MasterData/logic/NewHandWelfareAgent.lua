-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/agent/NewHandWelfareAgent.lua

module("logic.extensions.newhandwelfare.agent.NewHandWelfareAgent", package.seeall)

local NewHandWelfareAgent = class("NewHandWelfareAgent", BaseAgent)

NewHandWelfareAgent.PM_NotifyNewHandWelfarePaySucRes = "NewHandWelfareAgent_PM_NotifyNewHandWelfarePaySucRes"
NewHandWelfareAgent.NewHandWelfareOneKeyGainZdlPrizeRes = "NewHandWelfareAgent_NewHandWelfareOneKeyGainZdlPrizeRes"
NewHandWelfareAgent.NewHandWelfareGainZdlPrizeRes = "NewHandWelfareAgent_NewHandWelfareGainZdlPrizeRes"
NewHandWelfareAgent.NewHandWelfareOneKeyGainOnlinePrizeRes = "NewHandWelfareAgent_NewHandWelfareOneKeyGainOnlinePrizeRes"
NewHandWelfareAgent.NewHandWelfareGainOnlinePrizeRes = "NewHandWelfareAgent_NewHandWelfareGainOnlinePrizeRes"
NewHandWelfareAgent.NewHandWelfareGainSignInPrizeRes = "NewHandWelfareAgent_NewHandWelfareGainSignInPrizeRes"
NewHandWelfareAgent.NewHandWelfareGetInfoRes = "NewHandWelfareAgent_NewHandWelfareGetInfoRes"

function NewHandWelfareAgent:sendNewHandWelfareGetInfoReq()
	forcePrint("==========LoginController._enterGame=======NewHandWelfareAgent:sendNewHandWelfareGetInfoReq====")

	local req = NewHandWelfareExtension_pb.NewHandWelfareGetInfoReq()

	self:sendMsg(req)
end

function NewHandWelfareAgent:handleNewHandWelfareGetInfoRes(status, msg)
	forcePrint("==========LoginController._enterGame=======NewHandWelfareAgent:sendNewHandWelfareGetInfoReq====back")

	if status == 0 then
		-- block empty
	end

	self:dispatch(NewHandWelfareAgent.NewHandWelfareGetInfoRes, status, msg)
end

function NewHandWelfareAgent:sendNewHandWelfareGainSignInPrizeReq(day)
	local req = NewHandWelfareExtension_pb.NewHandWelfareGainSignInPrizeReq()

	req.day = day

	self:sendMsg(req)
end

function NewHandWelfareAgent:handleNewHandWelfareGainSignInPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(NewHandWelfareAgent.NewHandWelfareGainSignInPrizeRes, status, msg)
end

function NewHandWelfareAgent:sendNewHandWelfareGainOnlinePrizeReq(prizeId)
	local req = NewHandWelfareExtension_pb.NewHandWelfareGainOnlinePrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function NewHandWelfareAgent:handleNewHandWelfareGainOnlinePrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(NewHandWelfareAgent.NewHandWelfareGainOnlinePrizeRes, status, msg)
end

function NewHandWelfareAgent:sendNewHandWelfareOneKeyGainOnlinePrizeReq()
	local req = NewHandWelfareExtension_pb.NewHandWelfareOneKeyGainOnlinePrizeReq()

	self:sendMsg(req)
end

function NewHandWelfareAgent:handleNewHandWelfareOneKeyGainOnlinePrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(NewHandWelfareAgent.NewHandWelfareOneKeyGainOnlinePrizeRes, status, msg)
end

function NewHandWelfareAgent:sendNewHandWelfareGainZdlPrizeReq(prizeId, normalPrize)
	local req = NewHandWelfareExtension_pb.NewHandWelfareGainZdlPrizeReq()

	req.prizeId = prizeId
	req.normalPrize = normalPrize

	self:sendMsg(req)
end

function NewHandWelfareAgent:handleNewHandWelfareGainZdlPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(NewHandWelfareAgent.NewHandWelfareGainZdlPrizeRes, status, msg)
end

function NewHandWelfareAgent:sendNewHandWelfareOneKeyGainZdlPrizeReq()
	local req = NewHandWelfareExtension_pb.NewHandWelfareOneKeyGainZdlPrizeReq()

	self:sendMsg(req)
end

function NewHandWelfareAgent:handleNewHandWelfareOneKeyGainZdlPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(NewHandWelfareAgent.NewHandWelfareOneKeyGainZdlPrizeRes, status, msg)
end

function NewHandWelfareAgent:handlePM_NotifyNewHandWelfarePaySucRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(NewHandWelfareAgent.PM_NotifyNewHandWelfarePaySucRes, status, msg)
end

function NewHandWelfareAgent:sendNewHandWelfareGetBoundInfoReq()
	local req = NewHandWelfareExtension_pb.NewHandWelfareGetBoundInfoReq()

	self:sendMsg(req)
end

function NewHandWelfareAgent:handleNewHandWelfareGetBoundInfoRes(status, msg)
	if status == 0 then
		NewhandwelfareController.instance:handleNewHandWelfareGetBoundInfoRes(msg)
	end
end

function NewHandWelfareAgent:sendNewHandWelfareSubmitFormZdlReq(teamId, form)
	local req = NewHandWelfareExtension_pb.NewHandWelfareSubmitFormZdlReq()

	req.teamId = teamId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function NewHandWelfareAgent:handleNewHandWelfareSubmitFormZdlRes(status, msg)
	if status == 0 then
		NewhandwelfareController.instance:handleNewHandWelfareSubmitFormZdlRes(msg)
	end
end

function NewHandWelfareAgent:sendNewHandWelfareGainBoundPrizeReq(prizeId)
	local req = NewHandWelfareExtension_pb.NewHandWelfareGainBoundPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function NewHandWelfareAgent:handleNewHandWelfareGainBoundPrizeRes(status, msg)
	if status == 0 then
		NewhandwelfareController.instance:handleNewHandWelfareGainBoundPrizeRes(msg)
	end
end

NewHandWelfareAgent.instance = NewHandWelfareAgent.New()

return NewHandWelfareAgent
