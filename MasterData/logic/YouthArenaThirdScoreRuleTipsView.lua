-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdScoreRuleTipsView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdScoreRuleTipsView", package.seeall)

local YouthArenaThirdScoreRuleTipsView = class("YouthArenaThirdScoreRuleTipsView", ViewComponent)
local BATTLE_MODE_TEXT = {
	[YouthArenaThirdEnum.BattleMode.One] = "1v1模式",
	[YouthArenaThirdEnum.BattleMode.Three] = "3v3模式"
}

function YouthArenaThirdScoreRuleTipsView:ctor()
	YouthArenaThirdScoreRuleTipsView.super.ctor(self)
end

function YouthArenaThirdScoreRuleTipsView:buildUI()
	YouthArenaThirdScoreRuleTipsView.super.buildUI(self)

	self._txtMode = self:getTxt("mode/txt")
	self._txtDesc = self:getTxt("txtDesc")
	self._btnSure = self:getGo("btnSure")
end

function YouthArenaThirdScoreRuleTipsView:bindEvents()
	YouthArenaThirdScoreRuleTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function YouthArenaThirdScoreRuleTipsView:unbindEvents()
	YouthArenaThirdScoreRuleTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function YouthArenaThirdScoreRuleTipsView:onEnter()
	YouthArenaThirdScoreRuleTipsView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])
	local roundId = checknumber(params[2])
	local mode = checknumber(params[3])

	if mode ~= YouthArenaThirdEnum.BattleMode.Three then
		mode = YouthArenaThirdEnum.BattleMode.One
	end

	local roundData = YouthArenaThirdConfig.instance:getRoundData(activityId, roundId)
	local scoreRule = mode == YouthArenaThirdEnum.BattleMode.Three and "scoreRule3v3" or "scoreRule1v1"

	self._txtMode.text = BATTLE_MODE_TEXT[mode]

	if roundData then
		self._txtDesc.text = roundData[scoreRule] or ""
	end
end

return YouthArenaThirdScoreRuleTipsView
