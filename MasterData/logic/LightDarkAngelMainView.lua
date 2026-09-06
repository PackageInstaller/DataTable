-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teshamu/view/LightDarkAngelMainView.lua

module("logic.extensions.teshamu.view.LightDarkAngelMainView", package.seeall)

local LightDarkAngelMainView = class("LightDarkAngelMainView", TeShaMuMainView)

function LightDarkAngelMainView:buildUI()
	LightDarkAngelMainView.super.buildUI(self)

	self._buffRoot = self:getGo("buffRoot")
	self._btnExchange = self:getGo("btnExchange")
end

function LightDarkAngelMainView:bindEvents()
	LightDarkAngelMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickExchange, self)
end

function LightDarkAngelMainView:unbindEvents()
	LightDarkAngelMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnExchange)
end

function LightDarkAngelMainView:onEnter()
	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._challengeCfg = TeShaMuChallengeConfig.instance:getChallengeCfg(self._activityId)
	self._raceId = self._challengeCfg.raceId

	self:_petInfo()

	local objList = {
		{
			showAdd = false,
			id = self._challengeCfg.coin
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
	SignInBuffController.instance:addCommonSignInBuffView(self._buffRoot, self._viewPresentor, self._activityId)
end

function LightDarkAngelMainView:_sendGetInfoReq()
	TeShaMuChallengeController.instance:sendPM_TeshamuGetInfoReq(self._activityId)
end

function LightDarkAngelMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.LightDarkAngelChallengeView, self._activityId)
end

function LightDarkAngelMainView:_onClickExchange()
	GotoMgr.gotoByString(self._challengeCfg.jump_exchange)
end

function LightDarkAngelMainView:_onClickTip()
	TipsFacade.instance:openRulesView("LightDarkBigskyshitmainview_rule")
end

return LightDarkAngelMainView
