-- chunkname: @modules/logic/sp02/enter/define/VersionActivity3_10Event.lua

module("modules.logic.sp02.enter.define.VersionActivity3_10Event", package.seeall)

local VersionActivity3_10Event = _M
local _getId = GameUtil.getEventId

VersionActivity3_10Event.UnlockNextHalf = _getId()
VersionActivity3_10Event.SwitchGroup = _getId()
VersionActivity3_10Event.OnSelectEpisodeItem = _getId()
VersionActivity3_10Event.OnScrollEpisodeList = _getId()
VersionActivity3_10Event.FocusEpisodeNode = _getId()
VersionActivity3_10Event.OnEpisodeListVisible = _getId()
VersionActivity3_10Event.OnTweenEpisodeListVisible = _getId()
VersionActivity3_10Event.OnEpisodeListVisibleDone = _getId()
VersionActivity3_10Event.OnNewElementsFocusDone = _getId()
VersionActivity3_10Event.StopBgm = _getId()
VersionActivity3_10Event.ManualSwitchBgm = _getId()

return VersionActivity3_10Event
