-- chunkname: @modules/logic/matchgame/defines/MatchGameEvent.lua

module("modules.logic.matchgame.defines.MatchGameEvent", package.seeall)

local MatchGameEvent = _M
local _get = GameUtil.getUniqueTb()

MatchGameEvent.PlaySwitchMapAnim = _get()
MatchGameEvent.OnClickSelectMap = _get()
MatchGameEvent.OnClickSelectEpisode = _get()
MatchGameEvent.OnUpdateCharacter = _get()
MatchGameEvent.OnUpdateTalentInfo = _get()
MatchGameEvent.OnUpdateBonusInfo = _get()
MatchGameEvent.OnUpdateItemInfo = _get()
MatchGameEvent.OnUpdateEpisodeInfo = _get()
MatchGameEvent.OnSwapHeroError = _get()
MatchGameEvent.OnSwitchTeam = _get()
MatchGameEvent.OnSaveTeamSuccess = _get()
MatchGameEvent.OnSelectionChanged = _get()
MatchGameEvent.OnGuideOpenCharacterView = _get()

return MatchGameEvent
