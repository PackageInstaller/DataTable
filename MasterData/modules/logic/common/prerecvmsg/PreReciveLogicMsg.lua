-- chunkname: @modules/logic/common/prerecvmsg/PreReciveLogicMsg.lua

module("modules.logic.common.prerecvmsg.PreReciveLogicMsg", package.seeall)

local PreReciveLogicMsg = class("PreReciveLogicMsg", BasePreReceiver)

function PreReciveLogicMsg:ctor()
	return
end

function PreReciveLogicMsg:init()
	LuaSocketMgr.instance:registerPreReceiver(self)
end

function PreReciveLogicMsg:preReceiveMsg(resultCode, cmd, responseName, msg, downTag, socketId)
	if resultCode == 0 then
		return
	end

	local tipsCfg = lua_toast.configDict[resultCode]

	if not tipsCfg then
		logError("PreReciveLogicMsg:preReceiveMsg 没有为业务错误码：" .. resultCode .. " 配置提示语！！《P飘字表》- export_飘字表")

		return
	end

	GameFacade.showToast(resultCode)
end

function PreReciveLogicMsg:preReceiveSysMsg(resultCode, cmd, responseName, msg, downTag, socketId)
	if resultCode == 0 then
		return
	end

	LoginController.instance:_stopHeartBeat()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.StopLoading)
	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.ForbidLogin, MsgBoxEnum.BoxType.Yes, function()
		LoginController.instance:logout()
	end, nil, nil, nil, nil, nil, msg.reason)
end

PreReciveLogicMsg.instance = PreReciveLogicMsg.New()

return PreReciveLogicMsg
