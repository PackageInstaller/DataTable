-- chunkname: @modules/logic/season/controller/Activity104Event.lua

module("modules.logic.season.controller.Activity104Event", package.seeall)

local Activity104Event = _M

Activity104Event.GetAct104Info = 1001
Activity104Event.GetAct104ItemChange = 1002
Activity104Event.GetAct104BattleFinish = 1003
Activity104Event.StartAct104BattleReply = 1004
Activity104Event.RefreshRetail = 1005
Activity104Event.OptionalEquip = 1006
Activity104Event.SwitchSnapshotSubId = 1007
Activity104Event.SwitchSpecialEpisode = 1008
Activity104Event.ChangeCameraSize = 1009
Activity104Event.SelectRetail = 1010
Activity104Event.SelectSelfChoiceCard = 1011
Activity104Event.OnUpdateSeasonTask = 2002
Activity104Event.OnSeasonTaskReward = 2003
Activity104Event.OnComposeDataChanged = 3001
Activity104Event.OnComposeSuccess = 3002
Activity104Event.OnBookUpdateNotify = 3101
Activity104Event.OnBookChangeSelectNotify = 3102
Activity104Event.OnPlayerPrefNewUpdate = 3103
Activity104Event.OnCoverItemClick = 3104
Activity104Event.EnterSeasonMainView = 9001

return Activity104Event
