-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/view/HelpDragonMomMainView.lua

module("logic.extensions.helpdragonmom.view.HelpDragonMomMainView", package.seeall)

local HelpDragonMomMainView = class("HelpDragonMomMainView", ViewComponent)

function HelpDragonMomMainView:ctor()
	HelpDragonMomMainView.super.ctor(self)
end

function HelpDragonMomMainView:buildUI()
	HelpDragonMomMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnInject = self:getBtn("pageBtns/btnInject")
	self._btnCollect = self:getBtn("pageBtns/btnCollect")
	self._imgBtnInject = self:getGo("pageBtns/btnInject/img"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgBtnCollect = self:getGo("pageBtns/btnCollect/img"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtTime = self:getTxt("time/txtTime")
	self._subTab = self:getGo("subTab")
	self._injectRedPoint = self:getGo("pageBtns/btnInject/redPoint")
	self._collectRedPoint = self:getGo("pageBtns/btnCollect/redPoint")

	goutil.setActive(self._injectRedPoint, false)
	goutil.setActive(self._collectRedPoint, false)
end

function HelpDragonMomMainView:bindEvents()
	HelpDragonMomMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnInject:AddClickListener(self._onClickInject, self)
	self._btnCollect:AddClickListener(self._onClickCollect, self)
end

function HelpDragonMomMainView:unbindEvents()
	HelpDragonMomMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnInject:RemoveClickListener()
	self._btnCollect:RemoveClickListener()
end

function HelpDragonMomMainView:onEnter()
	HelpDragonMomMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HelpDragonMomGetInfoRes, self._onHelpDragonMomGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.HelpDragonMomWorldAwardRes, self._onHelpDragonMomWorldAwardRes, self)
	GlobalDispatcher:addListener(GlobalNotify.HelpDragonMomChallengeRes, self._onHelpDragonMomChallengeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.HelpDragonMomSelfAwardRes, self._onHelpDragonMomSelfAwardRes, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateCollectRedPoint, self)

	self._curPage = 1
	self._activityId = HelpDragonMomModel.instance:getTaskActivityId()

	self:_initActivityTimeText()
	self:_changeTab(self._curPage)
	HelpDragonMomAgent.instance:sendPM_HelpDragonMomGetInfoReq(HelpDragonMomModel.instance:getActivityId())
	self:_updateInjectRedPoint()
	self:_updateCollectRedPoint()
end

function HelpDragonMomMainView:onExit()
	HelpDragonMomMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HelpDragonMomGetInfoRes, self._onHelpDragonMomGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.HelpDragonMomWorldAwardRes, self._onHelpDragonMomWorldAwardRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.HelpDragonMomChallengeRes, self._onHelpDragonMomChallengeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.HelpDragonMomSelfAwardRes, self._onHelpDragonMomSelfAwardRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateCollectRedPoint, self)
	self:_removeBgEffect()
end

function HelpDragonMomMainView:_onClickClose()
	self:close()
end

function HelpDragonMomMainView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "helpdragonmomrule")
end

function HelpDragonMomMainView:_onClickInject()
	if self._curPage == 0 then
		return
	end

	self:_changeTab(0)
end

function HelpDragonMomMainView:_onClickCollect()
	if self._curPage == 1 then
		return
	end

	self:_changeTab(1)
end

function HelpDragonMomMainView:_initActivityTimeText()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Summary, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function HelpDragonMomMainView:_changeTab(pageIndex)
	HelpDragonMomModel.instance:setPageIndex(pageIndex)

	self._curPage = pageIndex

	if self._curPage == 0 then
		self._imgBtnInject:SetState(1)
		self._imgBtnCollect:SetState(0)
		self:showTabAt(self._subTab, ViewName.HelpDragonMomInjectView)
		self:_playBgEffect()
	else
		self._imgBtnInject:SetState(0)
		self._imgBtnCollect:SetState(1)
		self:showTabAt(self._subTab, ViewName.ActivitySmallSummaryOneView)
		self:_removeBgEffect()
	end
end

function HelpDragonMomMainView:_playBgEffect()
	self:_removeBgEffect()

	local path = "20220602/zhengjiulongyanmq/fx_ui_zjlymqjiemian.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._subTab.transform, 0, 0, true, false)

	uiEffect:setParent(self._subTab.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._uiEffect = uiEffect
end

function HelpDragonMomMainView:_removeBgEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function HelpDragonMomMainView:_updateInjectRedPoint()
	local isWorldCanGet = HelpDragonMomModel.instance:isAnyWorldRewardCanGet()
	local isPlayerCanGet = HelpDragonMomModel.instance:isAnyPlayerRewardCanGet()

	goutil.setActive(self._injectRedPoint, isWorldCanGet or isPlayerCanGet)
end

function HelpDragonMomMainView:_updateCollectRedPoint()
	goutil.setActive(self._collectRedPoint, false)

	local cfgTaskItems = OperationSummaryConfig.instance:getTaskItemsCfg(self._activityId)

	for i, v in pairs(cfgTaskItems) do
		if not string.nilorempty(v.redpointId) then
			local list = string.split(v.redpointId, "#")

			for m, n in ipairs(list) do
				local isShow = RedPointModel.instance:isActive(checknumber(n))

				if isShow then
					goutil.setActive(self._collectRedPoint, true)

					return
				end
			end
		end
	end
end

function HelpDragonMomMainView:_onHelpDragonMomGetInfoRes()
	self:_updateInjectRedPoint()
end

function HelpDragonMomMainView:_onHelpDragonMomWorldAwardRes()
	self:_updateInjectRedPoint()
end

function HelpDragonMomMainView:_onHelpDragonMomChallengeRes()
	self:_updateInjectRedPoint()
end

function HelpDragonMomMainView:_onHelpDragonMomSelfAwardRes()
	self:_updateInjectRedPoint()
end

return HelpDragonMomMainView
