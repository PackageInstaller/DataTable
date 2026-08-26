-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/define/MiniPartyEvent.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.define.MiniPartyEvent", package.seeall)

local MiniPartyEvent = _M

MiniPartyEvent.OnInfoChange = GameUtil.getUniqueTb()
MiniPartyEvent.OnInviteSend = GameUtil.getUniqueTb()
MiniPartyEvent.InviteFriendAgreeBack = GameUtil.getUniqueTb()
MiniPartyEvent.TaskTypeSelectChanged = GameUtil.getUniqueTb()
MiniPartyEvent.InviteTypeSelectChanged = GameUtil.getUniqueTb()
MiniPartyEvent.ShowTaskAnim = GameUtil.getUniqueTb()
MiniPartyEvent.GetAllTaskReward = GameUtil.getUniqueTb()

return MiniPartyEvent
