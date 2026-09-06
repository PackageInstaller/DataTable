-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/agent/PassportAgent.lua

module("logic.extensions.passport.agent.PassportAgent", package.seeall)

local PassportAgent = class("PassportAgent", BaseAgent)

PassportAgent.PM_PassportGetInfoRes = "PassportAgent_PM_PassportGetInfoRes"
PassportAgent.PM_PassportGainPrizeRes = "PassportAgent_PM_PassportGainPrizeRes"
PassportAgent.PM_PassportOneKeyGainPrizeRes = "PassportAgent_PM_PassportOneKeyGainPrizeRes"
PassportAgent.PM_PassportBuyProgressRes = "PassportAgent_PM_PassportBuyProgressRes"
PassportAgent.PM_NotifyPassportPayBuyCertSucRes = "PassportAgent_PM_NotifyPassportPayBuyCertSucRes"
PassportAgent.PM_GainPayAllPrizeRes = "PassportAgent_PM_GainPayAllPrizeRes"

function PassportAgent:ctor()
	return
end

function PassportAgent:setExtId(extId)
	PassportAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PassportAgent:sendPM_PassportGetInfoReq(funcId, handler, handlerObj, errHandler)
	local req = PassportExtension_pb.PM_PassportGetInfoReq()

	req.funcId = funcId

	self:sendMsg(req)
	self:addEventOnce(PassportAgent.PM_PassportGetInfoRes, handler, handlerObj, errHandler)
end

function PassportAgent:handlePM_PassportGetInfoRes(status, msg)
	if status == 0 then
		PassportController.instance:_GetInfoRes(msg)
	end

	self:dispatch(PassportAgent.PM_PassportGetInfoRes, status, msg)
end

function PassportAgent:sendPM_PassportGainPrizeReq(actId, funcId, prizeIndex, prizeType, handler, handlerObj, errHandler)
	local req = PassportExtension_pb.PM_PassportGainPrizeReq()

	req.actId = actId
	req.funcId = funcId
	req.prizeIndex = prizeIndex
	req.prizeType = prizeType

	self:sendMsg(req)
	self:addEventOnce(PassportAgent.PM_PassportGainPrizeRes, handler, handlerObj, errHandler)
end

function PassportAgent:handlePM_PassportGainPrizeRes(status, msg)
	PassportController.instance:_GainPrizeRes(msg)
	self:dispatch(PassportAgent.PM_PassportGainPrizeRes, status, msg)
end

function PassportAgent:sendPM_PassportOneKeyGainPrizeReq(actId, funcId, handler, handlerObj, errHandler)
	local req = PassportExtension_pb.PM_PassportOneKeyGainPrizeReq()

	req.actId = actId
	req.funcId = funcId

	self:sendMsg(req)
	self:addEventOnce(PassportAgent.PM_PassportOneKeyGainPrizeRes, handler, handlerObj, errHandler)
end

function PassportAgent:handlePM_PassportOneKeyGainPrizeRes(status, msg)
	PassportController.instance:_OneKeyGainPrizeRes(msg)
	self:dispatch(PassportAgent.PM_PassportOneKeyGainPrizeRes, status, msg)
end

function PassportAgent:sendPM_PassportBuyProgressReq(actId, funcId, num, handler, handlerObj, errHandler)
	local req = PassportExtension_pb.PM_PassportBuyProgressReq()

	req.actId = actId
	req.funcId = funcId
	req.num = num

	self:sendMsg(req)
	self:addEventOnce(PassportAgent.PM_PassportBuyProgressRes, handler, handlerObj, errHandler)
end

function PassportAgent:handlePM_PassportBuyProgressRes(status, msg)
	PassportController.instance:_BuyProgressRes(msg)
	self:dispatch(PassportAgent.PM_PassportBuyProgressRes, status, msg)
end

function PassportAgent:handlePM_NotifyPassportPayBuyCertSucRes(status, msg)
	self:dispatch(PassportAgent.PM_NotifyPassportPayBuyCertSucRes, status, msg)
end

function PassportAgent:sendPM_PassportGainExtraPrizeReq(actId, funcId)
	local req = PassportExtension_pb.PM_PassportGainExtraPrizeReq()

	req.actId = actId
	req.funcId = funcId

	self:sendMsg(req)
end

function PassportAgent:handlePM_PassportGainExtraPrizeRes(status, msg)
	if status == 0 then
		PassportController.instance:handleGainExtraPrize(msg)
	end
end

function PassportAgent:sendPM_BuyPassportReq(actId, funcId, goodsId, prizeType)
	local req = PassportExtension_pb.PM_BuyPassportReq()

	req.actId = actId
	req.funcId = funcId
	req.goodsId = goodsId
	req.prizeType = prizeType

	self:sendMsg(req)
end

function PassportAgent:handlePM_BuyPassportRes(status, msg)
	if status == 0 then
		PassportController.instance:handleBuyPassportRes(msg)
	end
end

function PassportAgent:sendPM_PassportViewReq(viewId, funId)
	local req = PassportExtension_pb.PM_PassportViewReq()

	req.viewId = viewId
	req.funId = funId

	self:sendMsg(req)
end

function PassportAgent:handlePM_PassportViewRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function PassportAgent:sendPM_GainPayAllPrizeReq(actId, funcId)
	local req = PassportExtension_pb.PM_GainPayAllPrizeReq()

	req.actId = actId
	req.funcId = funcId

	self:sendMsg(req)
end

function PassportAgent:handlePM_GainPayAllPrizeRes(status, msg)
	if status == 0 then
		local info = PassportModel.instance:getInfo(msg.funcId)

		if info then
			info.gainPayAll = true
		end

		GlobalDispatcher:dispatch(PassportAgent.PM_GainPayAllPrizeRes)
	end
end

function PassportAgent:sendPM_PassportGetAllUserValidPermanentActsReq()
	local req = PassportExtension_pb.PM_PassportGetAllUserValidPermanentActsReq()

	self:sendMsg(req)
end

function PassportAgent:handlePM_PassportGetAllUserValidPermanentActsRes(status, msg)
	if status == 0 then
		PassportModel.instance:setPassActIds(msg)
		GlobalDispatcher:dispatch(GlobalNotify.Passport_ActIds_Update)
	end
end

PassportAgent.instance = PassportAgent.New()

return PassportAgent
