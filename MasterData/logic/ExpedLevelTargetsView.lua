-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpedLevelTargetsView.lua

module("logic.extensions.expedition.view.ExpedLevelTargetsView", package.seeall)

local ExpedLevelTargetsView = class("ExpedLevelTargetsView", TableViewComponent)

function ExpedLevelTargetsView:ctor()
	self._curViewDatas = {}
end

function ExpedLevelTargetsView:buildUI()
	self._tableview = self:getGo("gridMapView/targets/targetsView/View/layout/item"):GetComponent("UITableviewForLua")
	self._tableCell = self:getGo("gridMapView/targets/itemTarget")
	self._taskItemDesc = self:getGo("gridMapView/targets/itemTarget/bg/TxtC_Desc"):GetComponent(goutil.Type_UIText)

	self._tableCell:SetActive(false)

	self._targetsView = self:getGo("gridMapView/targets/targetsView")
	self._btnHideTarget = self:getBtn("gridMapView/targets/btnHideTarget")
	self._targetFadeNode = self:getGo("gridMapView/targets/targetsView/View")

	self._btnHideTarget:IngoreGlobalClickListener(true)
	self:registCallbacks()
end

function ExpedLevelTargetsView:bindEvents()
	ExpedLevelTargetsView.super.bindEvents(self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)
	self._btnHideTarget:AddClickListener(self._onClickHideTargets, self)
end

function ExpedLevelTargetsView:unbindEvents()
	self._btnHideTarget:RemoveClickListener()
	ExpedLevelTargetsView.super.unbindEvents(self)
end

function ExpedLevelTargetsView:onEnter()
	return
end

function ExpedLevelTargetsView:onExit()
	self._curViewDatas = nil

	self._tableview:Travel(self._clearTableview, self)
	ExpedLevelTargetsView.super.onExit(self)
end

function ExpedLevelTargetsView:_onClickHideTargets()
	self._isTargetsHided = not self._isTargetsHided

	if self._isTargetsHided then
		local x, y, z = Framework.TransformUtil.GetLocalPos(self._targetsView.transform, 0, 0, 0)

		self._targetsView.transform:DOLocalMoveX(x - 245, 0.3, false)
		self._btnHideTarget.transform:DOLocalRotate(Vector3.New(0, 0, 180), 0.3, DG.Tweening.RotateMode.Fast)

		local tween = UnityTweens.UITweenFadeTo.StartTween(self._targetFadeNode, 0, 0.3, UnityTweens.EaseType.easeOutSine)

		tween:AddListener(function()
			self._targetFadeNode:SetActive(false)
		end, nil)
	else
		local x, y, z = Framework.TransformUtil.GetLocalPos(self._targetsView.transform, 0, 0, 0)

		self._targetsView.transform:DOLocalMoveX(x + 245, 0.3, false)
		self._btnHideTarget.transform:DOLocalRotate(Vector3.New(0, 0, 0), 0.1, DG.Tweening.RotateMode.Fast)

		local tween = UnityTweens.UITweenFadeTo.StartTween(self._targetFadeNode, 1, 0.3, UnityTweens.EaseType.easeOutSine)

		tween:RemoveListener()
		self._targetFadeNode:SetActive(true)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SpreadButton, not self._isTargetsHided)
end

function ExpedLevelTargetsView:_clearTableview(cell)
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "bg"):RemoveClickListener()
end

function ExpedLevelTargetsView:_numInView()
	return #self._curViewDatas
end

function ExpedLevelTargetsView:_cellSize(view, idx)
	return 272, 79
end

function ExpedLevelTargetsView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_fillTarget(cell, data)

	return cell
end

function ExpedLevelTargetsView:_fillTarget(cell, data)
	local evtId = data.eventId
	local count = data.count
	local desc
	local bg = goutil.findChild(cell.gameObject, "bg")
	local descText = goutil.findChild(bg, "TxtC_Desc"):GetComponent(goutil.Type_UIText)

	if evtId == -1 then
		desc = "已经通关，通过传送点离开，继续下一关"
	else
		local cnt = ExpeditionTilingModel.instance:getFinishedTargetCount(evtId)
		local evtCfg = ExpeditionConfig.instance:getEventCfg(evtId)

		if string.find(evtCfg.targetDesc, "%%d") then
			desc = string.format(evtCfg.targetDesc, count)
			desc = desc .. "(" .. math.min(cnt, count) .. "/" .. count .. ")"
		else
			desc = evtCfg.targetDesc
		end
	end

	Framework.ButtonAdapter.Get(bg):RemoveClickListener()
	Framework.ButtonAdapter.Get(bg):AddClickListener(function()
		if evtId == -1 then
			ExpeditionController.instance:getToTransmitPoint()

			return
		end

		TaskController.instance:foreceClearState()
		ExpeditionController.instance:getToLevelTarget(data)
	end)

	descText.text = desc
end

function ExpedLevelTargetsView:updateTargets()
	if not ExpeditionTilingModel.instance:isInTilingMapScene() then
		return
	end

	self._curViewDatas = {}

	local mapData = ExpeditionTilingModel.instance:getTilingMapInfos()
	local currEvtId, count = ExpeditionTilingModel.instance:getCurEventId()
	local dataCfg = {
		eventId = currEvtId,
		count = count
	}

	table.insert(self._curViewDatas, dataCfg)
	self._tableview:ReloadData()
end

return ExpedLevelTargetsView
