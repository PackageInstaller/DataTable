-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/view/YishiChallengeFmtView.lua

module("logic.extensions.yishichallenge.view.YishiChallengeFmtView", package.seeall)

local YishiChallengeFmtView = class("YishiChallengeFmtView", ViewComponent)

function YishiChallengeFmtView:ctor()
	YishiChallengeFmtView.super.ctor(self)
end

function YishiChallengeFmtView:unbindEvents()
	YishiChallengeFmtView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
end

function YishiChallengeFmtView:bindEvents()
	YishiChallengeFmtView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function YishiChallengeFmtView:onExit()
	YishiChallengeFmtView.super.onExit(self)
end

function YishiChallengeFmtView:buildUI()
	YishiChallengeFmtView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._fmtCol = self:getGo("fmtCol")
	self._checkerBoardFmtList = {}

	for i = 1, 9 do
		local list = {}

		list.go = self:getGo("fmtCol/fmtCell/fmtCol/fmtView/cell_" .. i)
		list.icon = goutil.findChild(list.go, "icon"):GetComponent("UIImageSpriteChange")
		list.mask = goutil.findChild(list.go, "mask")

		table.insert(self._checkerBoardFmtList, list)
	end
end

function YishiChallengeFmtView:onEnter()
	YishiChallengeFmtView.super.onEnter(self)

	self._params = self:getFirstParam()
	self._challengeId, self._stage = self._params:getParams()
	self._chanllengeCfg = YishiChallengeConfig.instance:getChallengeCfgById(self._challengeId)

	self:_refreshList()
end

function YishiChallengeFmtView:_refreshList()
	local cfg = self._chanllengeCfg[self._stage]
	local chessboard = cfg.chessboard

	for i, v in ipairs(self._checkerBoardFmtList) do
		goutil.setActive(v.icon.gameObject, true)

		if checknumber(chessboard[i]) > 0 then
			v.icon:SetState(chessboard[i] - 1)
		else
			goutil.setActive(v.icon.gameObject, false)
		end
	end
end

function YishiChallengeFmtView:_onClickTip()
	if GameUtil.GetActive(self._fmtCol) then
		goutil.setActive(self._fmtCol, false)
	else
		goutil.setActive(self._fmtCol, true)
	end
end

return YishiChallengeFmtView
