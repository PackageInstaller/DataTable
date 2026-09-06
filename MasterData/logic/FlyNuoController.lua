-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/controller/FlyNuoController.lua

module("logic.extensions.flyingnuo.controller.FlyNuoController", package.seeall)

local FlyNuoController = class("FlyNuoController", BaseController)
local msgId = -999999999

function FlyNuoController:ctor()
	return
end

function FlyNuoController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.FlyNuoSystemMsg, self._resSystemMsg, self)
end

function FlyNuoController:onReset()
	removetimer(self._autoShowMsg, self)

	msgId = -9999999999
end

function FlyNuoController:_resSystemMsg(tab)
	self._msgTable = tab

	removetimer(self._autoShowMsg, self)
	settimer(3600, self._autoShowMsg, self, true)
end

function FlyNuoController:_autoShowMsg()
	msgId = msgId - 1

	local t = {}

	self._msgTable.sendTime = ServerTime.nowMs()
	self._msgTable.msgId = msgId
	self._msgTable.isCustom = true
	self._msgTable.channelType = GameEnum.ChatChannel.System

	table.insert(t, self._msgTable)
	NewChatModel.instance:OnNotifyNewMsg(t)
end

function FlyNuoController:openView()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.FlyNuo)

	if cfgs then
		local activityId = false

		for k, v in pairs(cfgs) do
			if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.FlyNuo, v.activityId) then
				activityId = v.activityId

				break
			end
		end

		if activityId then
			UIStateManager.instance:push(ViewName.FlynuomainView, activityId)
		else
			FloatWordMgr.instance:show("不在活动开放时间内")
		end
	end
end

function FlyNuoController:startGame(activityid, clientkey, encryptedkey)
	self._encryptedkey = encryptedkey
	self._activityid = activityid
	self._clientkey = clientkey
	self._serverKey = bit.bxor(encryptedkey, clientkey)

	FlyNuoModel.instance:resetGame()
	UIStateManager.instance:push(ViewName.FlynuoplayView, activityid)
end

function FlyNuoController:endGame()
	local itemScore = FlyNuoModel.instance:getPropScore()
	local disScore = FlyNuoModel.instance:getPipeScore()
	local key = bit.bor(bit.bxor(self._clientkey, itemScore), bit.bxor(self._serverKey, disScore))

	FlyingNuoAgent.instance:sendPM_EndGameReq(itemScore, disScore, key)
end

function FlyNuoController:endGameShowReward(info)
	UIStateManager.instance:push(ViewName.FlynuoitemgetView, info)
end

FlyNuoController.instance = FlyNuoController.New()

return FlyNuoController
