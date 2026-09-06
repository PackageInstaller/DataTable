-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originwelfare/view/OriginWelfareMainView.lua

module("logic.extensions.originwelfare.view.OriginWelfareMainView", package.seeall)

local OriginWelfareMainView = class("OriginWelfareMainView", ViewComponent)

function OriginWelfareMainView:ctor()
	OriginWelfareMainView.super.ctor(self)
end

function OriginWelfareMainView:unbindEvents()
	OriginWelfareMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnLight)
end

function OriginWelfareMainView:bindEvents()
	OriginWelfareMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnLight, self._onClickBtnLight, self)
end

function OriginWelfareMainView:buildUI()
	OriginWelfareMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnLight = self:getGo("btnLight")
	self._redPoint = self:getGo("btnLight/redPoint")
	self._eff = self:getGo("eff")
end

function OriginWelfareMainView:onExit()
	OriginWelfareMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPoint)
end

function OriginWelfareMainView:onEnter()
	OriginWelfareMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginWelfareInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginWelfareLightUpRes, self._onLightUpRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 538001
	end

	self._actCfg = OriginWelfareConfig.instance:getActCfg(self._activityId)
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._redPoint, self._actCfg.redPointId)
	OriginWelfareController.instance:sendPM_OriginWelfareInfoReq(self._activityId)
end

function OriginWelfareMainView:_onUpdate()
	self._info = OriginWelfareModel.instance:getInfo(self._activityId)

	if self._info and self._info.hasLightUp then
		UIStateManager.instance:popByName(ViewName.OriginWelfareMainView)
		GotoMgr.gotoByString(self._actCfg.jumpToHud)
	end
end

function OriginWelfareMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function OriginWelfareMainView:_onClickBtnLight()
	self:playViewEffectUniGo("20241220/zhongyanzhizhan/fx_ui_bianbai.prefab", self._eff, self.mainGO.transform, false, function()
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._actCfg.storyId, StoryModel.StoryType.SCCopy)
		OriginWelfareController.instance:sendPM_OriginWelfareLightUpReq(self._activityId)
	end, nil)
end

function OriginWelfareMainView:_onLightUpRes()
	UIStateManager.instance:popByName(ViewName.OriginWelfareMainView)
	GotoMgr.gotoByString(self._actCfg.jumpToHud)
end

return OriginWelfareMainView
