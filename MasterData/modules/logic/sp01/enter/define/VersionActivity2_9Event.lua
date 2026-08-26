-- chunkname: @modules/logic/sp01/enter/define/VersionActivity2_9Event.lua

module("modules.logic.sp01.enter.define.VersionActivity2_9Event", package.seeall)

local VersionActivity2_9Event = _M
local _getId = GameUtil.getEventId

VersionActivity2_9Event.UnlockNextHalf = _getId()
VersionActivity2_9Event.SwitchGroup = _getId()
VersionActivity2_9Event.OnSelectEpisodeItem = _getId()
VersionActivity2_9Event.OnScrollEpisodeList = _getId()
VersionActivity2_9Event.OnUpdateEpisodeNodePos = _getId()
VersionActivity2_9Event.FocusEpisodeNode = _getId()
VersionActivity2_9Event.OnOneWorkLoadDone = _getId()
VersionActivity2_9Event.OnAllWorkLoadDone = _getId()
VersionActivity2_9Event.OnEpisodeListVisible = _getId()
VersionActivity2_9Event.OnTweenEpisodeListVisible = _getId()
VersionActivity2_9Event.OnEpisodeListVisibleDone = _getId()
VersionActivity2_9Event.OnNewElementsFocusDone = _getId()
VersionActivity2_9Event.StopBgm = _getId()
VersionActivity2_9Event.ManualSwitchBgm = _getId()

return VersionActivity2_9Event
