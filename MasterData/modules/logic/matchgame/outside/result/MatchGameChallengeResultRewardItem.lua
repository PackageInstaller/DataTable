-- chunkname: @modules/logic/matchgame/outside/result/MatchGameChallengeResultRewardItem.lua

module("modules.logic.matchgame.outside.result.MatchGameChallengeResultRewardItem", package.seeall)

local MatchGameChallengeResultRewardItem = class("MatchGameChallengeResultRewardItem", LuaCompBase)

function MatchGameChallengeResultRewardItem:init(go)
	self.go = go
	self._goIcon = gohelper.findChild(go, "go_icon")
	self._iconItem = IconMgr.instance:getCommonPropItemIcon(self._goIcon)
end

function MatchGameChallengeResultRewardItem:onUpdateMO(rewardParams, index)
	self._rewardParams = rewardParams
	self._index = index

	self._iconItem:setMOValue(rewardParams[1], rewardParams[2], rewardParams[3])
	self._iconItem:setCountFontSize(46)
end

return MatchGameChallengeResultRewardItem
