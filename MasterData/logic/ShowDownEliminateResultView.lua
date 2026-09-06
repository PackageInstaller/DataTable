-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateResultView.lua

module("logic.extensions.showdown.view.ShowDownEliminateResultView", package.seeall)

local ShowDownEliminateResultView = class("ShowDownEliminateResultView", ViewComponent)

function ShowDownEliminateResultView:ctor()
	ShowDownEliminateResultView.super.ctor(self)
end

function ShowDownEliminateResultView:unbindEvents()
	ShowDownEliminateResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ShowDownEliminateResultView:bindEvents()
	ShowDownEliminateResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ShowDownEliminateResultView:buildUI()
	ShowDownEliminateResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._winShow = self:getGo("winShow")
	self._loseShow = self:getGo("loseShow")
	self._txtResult = self:getTxt("txtResult")
	self._txtScore = self:getTxt("txtScore")
	self._teammateConList = {}

	for i = 1, 5 do
		local con = {}

		con.go = self:getGo("teammates/teammate_" .. i)
		con.headicon = goutil.findChild(con.go, "headicon")
		con.txtName = goutil.findChildTextComponent(con.go, "txtName")
		self._teammateConList[i] = con
	end

	self._winShow = self:getGo("winShow")
	self._loseShow = self:getGo("loseShow")
end

function ShowDownEliminateResultView:onExit()
	ShowDownEliminateResultView.super.onExit(self)
	removetimer(self._onCountDown, self)

	for i, con in ipairs(self._teammateConList) do
		HeadItemController.instance:resetHeadCell(con.headicon)
	end

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end
end

function ShowDownEliminateResultView:onEnter()
	ShowDownEliminateResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._teamViewMo = params[2]
	self._result = params[3] or {}
	self._activityType = ShowDownController.instance:getActivityType()
	self._score = self._result.score or 0
	self._winCount = self._result.winCount or 0
	self._loseCount = self._result.loseCount or 0
	self._isWin = self._winCount > self._loseCount

	GameUtil.SetActive(self._btnClose, false)

	self._timer = checknumber(ShowDownConfig.instance:getCommonValue(self._activityId, "eliminateAutoCloseTime")) + 1

	self:_onCountDown()
	settimer(1, self._onCountDown, self)
	self:_updateUI()

	local effParent = self.mainGO
	local pathName = self._isWin and "20240430/leitaisai/fx_ui_leitasai_shengli" or "20240430/leitaisai/fx_ui_leitasai_shibai"

	UIEffectManager.instance:stopEffect(self._eff)

	if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._eff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function ShowDownEliminateResultView:_updateUI()
	goutil.setActive(self._winShow, self._isWin)
	goutil.setActive(self._loseShow, not self._isWin)

	self._txtScore.text = string.format("+%s", self._score)
	self._txtResult.text = string.format("<color=#60ee85>%s</color>胜<color=#eb4642>%s</color>负", self._winCount, self._loseCount)

	local headInfoList = self._teamViewMo:getTeamMemberViewMo():getHeadInfoList()
	local memberCount = #headInfoList

	for idx = 1, 5 do
		local con = self._teammateConList[idx]
		local headInfo

		if idx <= memberCount then
			headInfo = headInfoList[idx]
		end

		if headInfo then
			con.txtName.text = headInfo.userName

			HeadItemController.instance:setMyHeadCell(con.headicon)
		else
			con.txtName.text = ""

			HeadItemController.instance:resetHeadCell(con.headicon)
		end
	end
end

function ShowDownEliminateResultView:_onCountDown()
	self._timer = self._timer - 1

	if self._timer <= 0 then
		removetimer(self._onCountDown, self)
		GameUtil.SetActive(self._btnClose, true)
	end
end

return ShowDownEliminateResultView
