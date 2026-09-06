-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/agent/NewHandAgent.lua

module("logic.extensions.newhand.agent.NewHandAgent", package.seeall)

local NewHandAgent = class("NewHandAgent", BaseAgent)

NewHandAgent.GainFinalGiftRes = "NewHandAgent_GainFinalGiftRes"
NewHandAgent.GetKirinInfoRes = "NewHandAgent_GetKirinInfoRes"
NewHandAgent.GetAllNewHandGuideKVsRes = "NewHandAgent_GetAllNewHandGuideKVsRes"
NewHandAgent.UpdateNewHandGuideKVsRes = "NewHandAgent_UpdateNewHandGuideKVsRes"
NewHandAgent.ClearAllNewHandGuideKVsRes = "NewHandAgent_ClearAllNewHandGuideKVsRes"

function NewHandAgent:ctor()
	return
end

function NewHandAgent:setExtId(extId)
	NewHandAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function NewHandAgent:sendGainFinalGiftReq(index, handler, handlerObj, errHandler)
	local req = NewHandExtension_pb.GainFinalGiftReq()

	req.index = index

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(NewHandAgent.GainFinalGiftRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function NewHandAgent:handleGainFinalGiftRes(status, msg)
	self:dispatch(NewHandAgent.GainFinalGiftRes, status, msg)
end

function NewHandAgent:sendGetKirinInfoReq(handler, handlerObj, errHandler)
	local req = NewHandExtension_pb.GetKirinInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(NewHandAgent.GetKirinInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function NewHandAgent:handleGetKirinInfoRes(status, msg)
	self:dispatch(NewHandAgent.GetKirinInfoRes, status, msg)
end

function NewHandAgent:sendGetAllNewHandGuideKVsReq(handler, handlerObj, errHandler)
	forcePrint("==========LoginController._enterGame=======NewHandAgent:sendGetAllNewHandGuideKVsReq====")

	local req = NewHandExtension_pb.GetAllNewHandGuideKVsReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(NewHandAgent.GetAllNewHandGuideKVsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function NewHandAgent:handleGetAllNewHandGuideKVsRes(status, msg)
	forcePrint("==========LoginController._enterGame=======NewHandAgent:sendGetAllNewHandGuideKVsReq====back")
	self:dispatch(NewHandAgent.GetAllNewHandGuideKVsRes, status, msg)
end

function NewHandAgent:sendUpdateNewHandGuideKVsReq(newKvs_pb_Ary, handler, handlerObj, errHandler)
	local req = NewHandExtension_pb.UpdateNewHandGuideKVsReq()

	if newKvs_pb_Ary ~= nil then
		for i, v1 in ipairs(newKvs_pb_Ary) do
			local newKvs = req.newKvs:add()

			newKvs:ParseFromString(v1:SerializeToString())
		end
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(NewHandAgent.UpdateNewHandGuideKVsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function NewHandAgent:handleUpdateNewHandGuideKVsRes(status, msg)
	self:dispatch(NewHandAgent.UpdateNewHandGuideKVsRes, status, msg)
end

function NewHandAgent:sendClearAllNewHandGuideKVsReq(handler, handlerObj, errHandler)
	local req = NewHandExtension_pb.ClearAllNewHandGuideKVsReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(NewHandAgent.ClearAllNewHandGuideKVsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function NewHandAgent:handleClearAllNewHandGuideKVsRes(status, msg)
	self:dispatch(NewHandAgent.ClearAllNewHandGuideKVsRes, status, msg)
end

NewHandAgent.instance = NewHandAgent.New()

return NewHandAgent
