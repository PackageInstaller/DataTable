-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LioncultureFormationGameView.lua

module("logic.extensions.lionculture.view.LioncultureFormationGameView", package.seeall)

local LioncultureFormationGameView = class("LioncultureFormationGameView", ViewComponent)
local routeList = {
	5,
	4,
	3,
	2,
	1,
	4,
	2,
	5,
	3,
	1
}
local lastRouteList = {
	1,
	5,
	4,
	3,
	2,
	1,
	4,
	2,
	5,
	3
}

function LioncultureFormationGameView:ctor()
	LioncultureFormationGameView.super.ctor(self)
end

function LioncultureFormationGameView:buildUI()
	LioncultureFormationGameView.super.buildUI(self)

	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnEnterChallenge = self:getBtn("tips/btnChallenge")
	self._tipsGo = self:getGo("tips")
	self._nodeRole = self:getGo("formationCol/role")
	self._player = LionculturePlayer.New(self._nodeRole)
	self._formationList = {}

	for i = 1, 5 do
		local list = {}

		list.idx = i
		list.go = self:getGo("formationCol/formation_" .. i)
		list.btn = self:getBtn("formationCol/formation_" .. i)
		list.txtName = goutil.findChildTextComponent(list.go, "txtName")
		list.route = goutil.findChild(list.go, "route")
		list.route1 = goutil.findChild(list.go, "route1")

		table.insert(self._formationList, list)
	end
end

function LioncultureFormationGameView:unbindEvents()
	LioncultureFormationGameView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnEnterChallenge:RemoveClickListener()

	for i, v in ipairs(self._formationList) do
		v.btn:RemoveClickListener()
	end
end

function LioncultureFormationGameView:bindEvents()
	LioncultureFormationGameView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._close, self)
	self._btnEnterChallenge:AddClickListener(self._onClickBtnEnterChallenge, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule3")
	end, self)

	for i, v in ipairs(self._formationList) do
		v.btn:AddClickListener(function()
			if self._turnPageFlag then
				return
			end

			if v.idx == routeList[self._curPos] then
				self._lastPos = self._curPos
				self._curPos = self._curPos + 1

				self._player:movetoGrid(v.go, true)

				self._turnPageFlag = true
			else
				FloatWordMgr.instance:show("你选错啦，再想想应该怎么走吧~")
			end
		end, self)
	end
end

function LioncultureFormationGameView:onEnter()
	LioncultureFormationGameView.super.onEnter(self)
	self._player:onEnter()
	self._player:loadSpine(LioncultureModel.instance:getPlayerSpineRes())
	self._player:addListener(self._onPlayerMoveToGrid, self)
	self._player:setScale(0.3)
	self:_init()

	self.typeConfig = LioncultureConfig.instance:getGameData(LioncultureModel.instance.activityId, 4)

	if not GameUtil.getUserData(ViewName.LioncultureshapeView) then
		UIStateManager.instance:push(ViewName.LionculturetipView, self.typeConfig.desc)
		UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule3")
		GameUtil.saveUserData(ViewName.LioncultureshapeView, true)
	end

	GlobalDispatcher:addListener(GlobalNotify.LionCultureGetInfoRes, self._btnEnterChallengeState, self)

	self._turnPageFlag = false
end

function LioncultureFormationGameView:onExit()
	LioncultureFormationGameView.super.onExit(self)
	self._player:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.LionCultureGetInfoRes, self._btnEnterChallengeState, self)
end

function LioncultureFormationGameView:_onPlayerMoveToGrid()
	if self._curPos - 1 == #routeList then
		LioncultureController.instance:sendPM_WakingLionGameEndGameReq(self._gameId, 1)
	end

	local cell = self._formationList[lastRouteList[self._lastPos]]

	if cell then
		goutil.setActive(cell.route1, cell.route.activeSelf)

		if not cell.route.activeSelf then
			goutil.setActive(cell.route, true)
		end
	end

	self._turnPageFlag = false
end

function LioncultureFormationGameView:_close()
	self:close()
end

function LioncultureFormationGameView:_init()
	self._curPos = 1
	self._lastPos = 1

	self._player:movetoGrid(self._formationList[self._curPos].go, false)

	self._activityId = LioncultureController.instance:getActivityId()
	self._gameId = self:getFirstParam()

	for i, v in ipairs(self._formationList) do
		goutil.setActive(v.route, false)
		goutil.setActive(v.route1, false)
	end

	goutil.setActive(self._tipsGo, LioncultureModel.instance.gameLevels[self._gameId] == 1)
end

function LioncultureFormationGameView:_onClickBtnEnterChallenge()
	LioncultureController.instance:enterBattleAsCorPr(self._activityId, self._gameId)
end

function LioncultureFormationGameView:_btnEnterChallengeState()
	goutil.setActive(self._tipsGo, true)
end

return LioncultureFormationGameView
