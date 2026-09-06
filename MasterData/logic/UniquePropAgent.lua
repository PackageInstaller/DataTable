-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlestartanim/agent/UniquePropAgent.lua

module("logic.extensions.battlestartanim.agent.UniquePropAgent", package.seeall)

local UniquePropAgent = class("UniquePropAgent", BaseAgent)

function UniquePropAgent:sendPM_LoadAllUniquePropsReq()
	local req = UniquePropExtension_pb.PM_LoadAllUniquePropsReq()

	self:sendMsg(req)
end

function UniquePropAgent:handlePM_LoadAllUniquePropsRes(status, msg)
	if status == 0 then
		BattleStartAnimModel.instance:onLoadAllUniquePropsRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LoadAllUniquePropsRes)
	end
end

function UniquePropAgent:sendPM_UseUniquePropReq(type, id)
	local req = UniquePropExtension_pb.PM_UseUniquePropReq()

	req.type = type
	req.id = id

	self:sendMsg(req)
end

function UniquePropAgent:handlePM_UseUniquePropRes(status, msg)
	if status == 0 then
		local id = msg.id

		BattleStartAnimModel.instance:onUseUniquePropRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.UseUniquePropRes)

		if msg.type == MatType.NameFrame then
			GlobalDispatcher:dispatch(GlobalNotify.UpdateNameFrame)
		elseif msg.type == MatType.PlayerMessageSkin then
			GlobalDispatcher:dispatch(GlobalNotify.UpdateExterior, id)
		end
	end
end

function UniquePropAgent:handlePM_notifyUniquePropChangeRes(status, msg)
	if status == 0 then
		BattleStartAnimModel.instance:onNotifyUniquePropChangeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyUniquePropChangeRes)
	end
end

function UniquePropAgent:sendPM_GetOtherUniquePropsReq(type, targetUserId)
	local req = UniquePropExtension_pb.PM_GetOtherUniquePropsReq()

	req.type = type
	req.targetUserId = targetUserId

	self:sendMsg(req)
end

function UniquePropAgent:handlePM_GetOtherUniquePropsRes(status, msg)
	if status == 0 then
		BattleStartAnimModel.instance:onGetOtherUniquePropsRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GetOtherUniquePropsRes)
	end
end

function UniquePropAgent:sendPM_UniquePropsSetTopReq(type, id, setTop)
	local req = UniquePropExtension_pb.PM_UniquePropsSetTopReq()

	req.type = type
	req.id = id
	req.setTop = setTop

	self:sendMsg(req)
end

function UniquePropAgent:handlePM_UniquePropsSetTopRes(status, msg)
	if status == 0 then
		BattleStartAnimModel.instance:onUpdateSetTop(msg)
		GlobalDispatcher:dispatch(GlobalNotify.UpdateUniquePropSetTop)
	end
end

UniquePropAgent.instance = UniquePropAgent.New()

return UniquePropAgent
