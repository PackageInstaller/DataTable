-- chunkname: @modules/logic/versionactivity2_5/challenge/define/Act183Event.lua

module("modules.logic.versionactivity2_5.challenge.define.Act183Event", package.seeall)

local Act183Event = _M
local _uid = 1

local function E(name)
	assert(Act183Event[name] == nil, "[Act183Event] error redefined Act183Event." .. name)

	Act183Event[name] = _uid
	_uid = _uid + 1
end

E("OnClickEpisode")
E("OnUpdateGroupInfo")
E("OnUpdateRepressInfo")
E("OnUpdateBadgeNum")
E("OnClickSwitchGroup")
E("OnCreateHeroItemDone")
E("RefreshMedalReddot")
E("OnInitDungeonDone")
E("ClickToGetReward")
E("OnGroupAllTaskFinished")
E("OnUpdateSelectBadgeNum")
E("OnUpdateBadgeDetailVisible")
E("EpisodeStartPlayFinishAnim")
E("FightBossIfSubUnfinish")
E("OnPlayEffectDoneIfSubUnfinish")

return Act183Event
