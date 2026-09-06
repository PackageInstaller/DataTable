-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/role/facade/RoleFacade.lua

module("logic.extensions.role.facade.RoleFacade", package.seeall)

local RoleFacade = class("RoleFacade", BaseFacade)

function RoleFacade:startSyncTime()
	RoleController.instance:startSyncTime()
	ClockMgr.instance:setRefreshTime(5)
	ClockMgr.instance:startTick()
end

function RoleFacade:stopSyncTime()
	RoleController.instance:stopSyncTime()
	ClockMgr.instance:stopTick()
end

function RoleFacade:getVipType()
	return 0
end

function RoleFacade:loadMsgBoxInfo()
	RoleController.instance:getMsgBoxInfoReq()
end

RoleFacade.instance = RoleFacade.New()

return RoleFacade
