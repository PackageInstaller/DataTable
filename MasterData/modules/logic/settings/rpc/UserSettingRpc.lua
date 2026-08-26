-- chunkname: @modules/logic/settings/rpc/UserSettingRpc.lua

module("modules.logic.settings.rpc.UserSettingRpc", package.seeall)

local UserSettingRpc = class("UserSettingRpc", BaseRpc)

function UserSettingRpc:sendGetSettingInfosRequest(callback, callbackObj)
	local req = UserSettingModule_pb.GetSettingInfosRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function UserSettingRpc:onReceiveGetSettingInfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	SettingsModel.instance:setPushState(msg.infos)
end

function UserSettingRpc:sendUpdateSettingInfoRequest(type, state)
	local req = UserSettingModule_pb.UpdateSettingInfoRequest()

	req.type = type
	req.param = state

	return self:sendMsg(req)
end

function UserSettingRpc:onReceiveUpdateSettingInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	SettingsModel.instance:updatePushState(msg.type, msg.param)
	SettingsController.instance:dispatchEvent(SettingsEvent.OnChangePushType)
end

UserSettingRpc.instance = UserSettingRpc.New()

return UserSettingRpc
