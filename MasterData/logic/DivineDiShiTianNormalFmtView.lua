-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/view/DivineDiShiTianNormalFmtView.lua

module("logic.extensions.divinedishitianclg.view.DivineDiShiTianNormalFmtView", package.seeall)

local DivineDiShiTianNormalFmtView = class("DivineDiShiTianNormalFmtView", ViewComponent)

function DivineDiShiTianNormalFmtView:ctor()
	DivineDiShiTianNormalFmtView.super.ctor(self)
end

function DivineDiShiTianNormalFmtView:buildUI()
	DivineDiShiTianNormalFmtView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._btnRefresh = self:getBtn("moveNode/btnRefresh")
	self._infoCell = self:getGo("infoCell")

	goutil.setActive(self._infoCell, false)

	self._jobAttrInfo = self:getGo("moveNode/jobAttrInfo")
	self._jobAttrInfo2 = self:getGo("jobAttrInfo2")
	self._clsInfoList1 = {}
	self._clsInfoList2 = {}

	for i = 1, 9 do
		local go1 = goutil.cloneAndSetParent(self._infoCell, self._jobAttrInfo.transform, "infoCell" .. i)
		local go2 = goutil.cloneAndSetParent(self._infoCell, self._jobAttrInfo2.transform, "infoCell" .. i)

		goutil.setActive(go1, true)
		goutil.setActive(go2, true)

		local cls1 = GameUtil.AddLuaOnce(go1, DDSTNormalFmtCell)
		local cls2 = GameUtil.AddLuaOnce(go2, DDSTNormalFmtCell)

		table.insert(self._clsInfoList1, cls1)
		table.insert(self._clsInfoList2, cls2)
	end

	self._testRecordPos = self._jobAttrInfo:GetComponent(ComponentType.TestRecordPos)
	self._testRecordPos2 = self._jobAttrInfo2:GetComponent(ComponentType.TestRecordPos)

	self._testRecordPos:LoadPlan(0)
	self._testRecordPos2:LoadPlan(0)
end

function DivineDiShiTianNormalFmtView:bindEvents()
	DivineDiShiTianNormalFmtView.super.bindEvents(self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnArrow:AddClickListener(self._onClickArrow, self)
	self._btnRefresh:AddClickListener(self._onClickRefresh, self)
end

function DivineDiShiTianNormalFmtView:unbindEvents()
	DivineDiShiTianNormalFmtView.super.unbindEvents(self)
	self._btnHide:RemoveClickListener()
	self._btnArrow:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
end

function DivineDiShiTianNormalFmtView:onEnter()
	DivineDiShiTianNormalFmtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineDiShiTianClgRefreshLimitRes, self._onRefreshLimitRes, self)

	self._customFmtMo = self:getFirstParam()
	self._activityId = self._customFmtMo:getActivityId()
	self._index = self._customFmtMo:getIndexId()
	self._isPopupState = true
	self._cfgActivity = DivineDiShiTianClgConfig.instance:getActivityCfg(self._activityId)
	self._maxRefreshTimes = self._cfgActivity.refreshTimes
	self._refreshCost = self._cfgActivity.refreshCost

	printInfo("test DivineDiShiTianNormalFmtView 活动id = ", self._activityId)
	goutil.setActive(self._btnHide.gameObject, true)
	Framework.TransformUtil.SetAnchoredPos(self._moveNode.transform, -200, 80)
	Framework.TransformUtil.SetLocalRotation(self._arrowRectTrans.transform, 0, 0, 0)
	self:_updateJobAttrInfo()
end

function DivineDiShiTianNormalFmtView:onExit()
	DivineDiShiTianNormalFmtView.super.onExit(self)
end

function DivineDiShiTianNormalFmtView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-200, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	end
end

function DivineDiShiTianNormalFmtView:_onClickArrow()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-200, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	else
		self._isPopupState = true

		goutil.setActive(self._btnHide.gameObject, true)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(400, 80, 0), Vector3.New(-200, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 180), Vector3.New(0, 0, 0), 0.2)
	end
end

function DivineDiShiTianNormalFmtView:_onClickRefresh()
	local curRefreshTimes = DivineDiShiTianClgModel.instance:getTodayRefreshTimes(self._activityId)

	if curRefreshTimes >= self._maxRefreshTimes then
		FloatWordMgr.instance:show("无刷新次数")

		return
	end

	local matType, id, num = MaterialMgr.getMatParams(self._refreshCost)
	local leftTimes = self._maxRefreshTimes - curRefreshTimes
	local content = string.format("消耗<color=#%s>%d钻石</color>刷新己阵全部站位的上阵要求？\n每日重置最多%d次，今日剩余%d次（该挑战内所有敌阵共享重置次数）", ColorConst.Red, num, self._maxRefreshTimes, leftTimes)

	TipsFacade.instance:openPopupCostMatViewNew(matType, id, num, content, function()
		DivineDiShiTianClgAgent.instance:sendPM_DivineDiShiTianClgRefreshLimitReq(self._activityId, self._index)
	end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function DivineDiShiTianNormalFmtView:_onRefreshLimitRes()
	self:_updateJobAttrInfo()
	FastFormation.instance:clean()
end

function DivineDiShiTianNormalFmtView:_updateJobAttrInfo()
	for posId, v in ipairs(self._clsInfoList1) do
		local info = DivineDiShiTianClgModel.instance:getPosLimitInfo(self._activityId, self._index, posId)

		v:init(info.raceTypeId, info.jobId)
	end

	for posId, v in ipairs(self._clsInfoList2) do
		local info = DivineDiShiTianClgModel.instance:getPosLimitInfo(self._activityId, self._index, posId)

		v:init(info.raceTypeId, info.jobId)
	end
end

return DivineDiShiTianNormalFmtView
