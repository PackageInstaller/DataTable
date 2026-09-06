-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandcard/agent/NewHandCardAgent.lua

module("logic.extensions.newhandcard.agent.NewHandCardAgent", package.seeall)

local NewHandCardAgent = class("NewHandCardAgent", BaseAgent)

NewHandCardAgent.NewHandCardInfoRes = "NewHandCardAgent.NewHandCardInfoRes"
NewHandCardAgent.NotifyNewHandCardBuySucRes = "NewHandCardAgent.NotifyNewHandCardBuySucRes"

function NewHandCardAgent:sendPM_NewHandCardInfoReq()
	local req = NewHandCardExtension_pb.PM_NewHandCardInfoReq()

	self:sendMsg(req)
end

function NewHandCardAgent:handlePM_NewHandCardInfoRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadNewHandCardInfo===back")

	if status == 0 then
		local buycardtime = msg.buyCardTime
		local gaintime = msg.gainTime

		NewHandCardModel.instance:setCardInfo(buycardtime, gaintime)
		GlobalDispatcher:dispatch(NewHandCardAgent.NewHandCardInfoRes)
	end
end

function NewHandCardAgent:handlePM_NotifyNewHandCardBuySucRes(status, msg)
	if status == 0 then
		local buycardtime = msg.buyCardTime

		NewHandCardModel.instance:setBuyCardInfo(buycardtime)
		TipsFacade.instance:openTipWindowNoX("新手卡激活成功", "记得登录游戏领取每日奖励喔", nil, "我知道了")
		GlobalDispatcher:dispatch(NewHandCardAgent.NotifyNewHandCardBuySucRes)
		ActivityPopupController.instance:onBuyCheckLuoshiqi()
	end
end

NewHandCardAgent.instance = NewHandCardAgent.New()

return NewHandCardAgent
