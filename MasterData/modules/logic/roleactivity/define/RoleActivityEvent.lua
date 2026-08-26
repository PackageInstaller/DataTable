-- chunkname: @modules/logic/roleactivity/define/RoleActivityEvent.lua

module("modules.logic.roleactivity.define.RoleActivityEvent", package.seeall)

local RoleActivityEvent = _M

RoleActivityEvent.OneClickClaimReward = 1
RoleActivityEvent.StoryItemClick = 2
RoleActivityEvent.FightItemClick = 3
RoleActivityEvent.TabSwitch = 4

return RoleActivityEvent
