-- chunkname: @IQIGame\\UI\\GirlDatingListUI.lua

local GirlDatingListUI = Base:Extend("GirlDatingListUI", "IQIGame.Onigao.UI.GirlDatingListUI", {
	datingEventCells = {},
	occupyCells = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local DatingEventCell = require("IQIGame.UI.Dating.DatingEventCell")
local Live2DHarmoniousMask = require("IQIGame.UI.Common.Live2DHarmoniousMask")

function GirlDatingListUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, DatingUIApi:GetString("TextDatingListTitle"))

	self.l2dBuilder = self.Live2D:GetComponent("L2DBuilderMainCity")
	self.cvFrame = CvUIFrame.New(self.CvFrame.transform:GetChild(0).gameObject, Constant.UIControllerName.GirlDatingListUI)
	self.live2DHarmoniousMask = Live2DHarmoniousMask.New(self.Live2D)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.dgtOnShowMainL2D(soulCid)
		self:OnShowL2D(soulCid)
	end

	function self.dgtOnDressWearSuccess(dressCid)
		self:OnDressWearSuccess(dressCid)
	end

	function self.dgtOnDatingEnd()
		self:OnDatingEnd()
	end

	function self.delegateUpdatePeriodOfTime()
		self:UpdatePeriodOfTime()
	end

	function self.delegateUpdateGirlBGEvent(cid)
		self:OnUpdateGirlBG(cid)
	end

	function self.onPauseL2DDelegate()
		self:Pause()
	end

	function self.onCloseDialog()
		self:OnResumeL2D()
	end

	self.DatingEventMould:SetActive(false)
	self.OccupyingMould:SetActive(false)

	self.datingEventCellPool = UIObjectPool.New(10, function()
		local cellObj = UnityEngine.Object.Instantiate(self.DatingEventMould)

		return DatingEventCell:__New(cellObj)
	end, function(currentCell)
		currentCell:Dispose()
	end)
end

function GirlDatingListUI:GetPreloadAssetPaths()
	return nil
end

function GirlDatingListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GirlDatingListUI:OnOpen(userData)
	UIModule.BugFixL2dUIList[self.name] = self

	local soulId = userData

	self.soulData = SoulModule.GetSoulData(soulId)

	self:RefreshL2D()
	self:UpdateDatingList()
	self:LoadGirlBG(GirlBackGroundModule.currentUseBG)
end

function GirlDatingListUI:OnClose(userData)
	UIModule.BugFixL2dUIList[self.name] = nil

	self.cvFrame:Dispose()
	EventDispatcher.Dispatch(EventID.L2DResume)
end

function GirlDatingListUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	EventDispatcher.AddEventListener(EventID.SoulSelected, self.dgtOnShowMainL2D)
	EventDispatcher.AddEventListener(EventID.DressWearSuccess, self.dgtOnDressWearSuccess)
	EventDispatcher.AddEventListener(EventID.DatingEnd, self.dgtOnDatingEnd)
	EventDispatcher.AddEventListener(EventID.UpdatePeriodOfTime, self.delegateUpdatePeriodOfTime)
	EventDispatcher.AddEventListener(EventID.UpdateGirlBackgroundEvent, self.delegateUpdateGirlBGEvent)
	EventDispatcher.AddEventListener(EventID.CloseDialogUI, self.onCloseDialog)
	EventDispatcher.AddEventListener(EventID.L2DPause, self.onPauseL2DDelegate)
end

function GirlDatingListUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	EventDispatcher.RemoveEventListener(EventID.SoulSelected, self.dgtOnShowMainL2D)
	EventDispatcher.RemoveEventListener(EventID.DressWearSuccess, self.dgtOnDressWearSuccess)
	EventDispatcher.RemoveEventListener(EventID.DatingEnd, self.dgtOnDatingEnd)
	EventDispatcher.RemoveEventListener(EventID.UpdatePeriodOfTime, self.delegateUpdatePeriodOfTime)
	EventDispatcher.RemoveEventListener(EventID.UpdateGirlBackgroundEvent, self.delegateUpdateGirlBGEvent)
	EventDispatcher.RemoveEventListener(EventID.CloseDialogUI, self.onCloseDialog)
	EventDispatcher.RemoveEventListener(EventID.L2DPause, self.onPauseL2DDelegate)
end

function GirlDatingListUI:OnPause()
	return
end

function GirlDatingListUI:OnResume()
	return
end

function GirlDatingListUI:OnCover()
	return
end

function GirlDatingListUI:OnReveal()
	return
end

function GirlDatingListUI:OnRefocus(userData)
	return
end

function GirlDatingListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GirlDatingListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GirlDatingListUI:OnLoadSucceed(assetName, asset, duration, userData)
	local type = userData.type
	local bgCid = userData.bgCid

	if type == "LoadBG" then
		self.showBGCid = bgCid

		for i = 0, self.BGRoot.transform.childCount - 1 do
			local obj = self.BGRoot.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local bgObj = UnityEngine.Object.Instantiate(asset)

		bgObj.transform:SetParent(self.BGRoot.transform, false)

		local sortComponents = bgObj:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))
		local canvas = self.UIController:GetComponent("Canvas")

		for i = 0, sortComponents.Length - 1 do
			sortComponents[i].UIRootCanvas = canvas
		end
	end
end

function GirlDatingListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GirlDatingListUI:OnDestroy()
	self.cvFrame:OnDestroy()
	self.live2DHarmoniousMask:Dispose()

	for i, v in pairs(self.datingEventCells) do
		self.datingEventCellPool:Release(v)
	end

	self.datingEventCells = {}

	self.datingEventCellPool:Dispose()
	self:CleanOccupyCells()
	AssetUtil.UnloadAsset(self)
end

function GirlDatingListUI:OnShowL2D(soulCid)
	self:RefreshL2D()
end

function GirlDatingListUI:OnDressWearSuccess(dressCid)
	self:RefreshL2D()
end

function GirlDatingListUI:RefreshL2D()
	if self.soulData ~= nil then
		local cfgSoulResRow = self.soulData:GetCfgSoulRes2D()

		SoulModule.BuildL2D(self.l2dBuilder, self.soulData, self.soulData:GetCfgDress2D())
		self:SetL2DModelProperty(cfgSoulResRow)

		self.l2dBuilder.onShowCvUI = self.cvFrame.dgtOnShowCVUI
		self.l2dBuilder.onHideCvUI = self.cvFrame.dgtOnHideCVUI

		self.cvFrame:RefreshView(Vector3.New(cfgSoulResRow.DatingDialoguePosition[1], cfgSoulResRow.DatingDialoguePosition[2], cfgSoulResRow.DatingDialoguePosition[3]))
	end

	self.Live2D.transform.anchoredPosition3D = Vector3.zero
end

function GirlDatingListUI:SetL2DModelProperty(cfgSoulResRow)
	self.l2dBuilder:SetModelPositionInImage(cfgSoulResRow.Live2DDatingUIModelPosition[1], cfgSoulResRow.Live2DDatingUIModelPosition[2], cfgSoulResRow.Live2DDatingUIModelPosition[3])
end

function GirlDatingListUI:OnDatingEnd()
	if self.soulData then
		self:UpdateDatingList()
	end
end

function GirlDatingListUI:UpdateDatingList()
	self.datingEvents = DatingModule.GetDatingEventsByDatingTypeShow(self.soulData.soulCid)

	local index = 1

	if self.selectCell then
		index = self.selectCell.index
	end

	for i = 1, #self.datingEvents do
		local data = self.datingEvents[i]
		local state = DatingModule.GetEventSate(data)

		if state == 2 then
			index = i

			break
		end
	end

	self:CleanOccupyCells()

	for i = 1, 2 do
		local obj = UnityEngine.Object.Instantiate(self.OccupyingMould)

		obj.transform:SetParent(self.ContentList.transform, false)
		obj:SetActive(true)
		table.insert(self.occupyCells, obj)
	end

	for i, v in pairs(self.datingEventCells) do
		v.goView.transform:SetParent(self.UIController.gameObject.transform, false)
		v.goView:SetActive(false)
		self.datingEventCellPool:Release(v)
	end

	self.datingEventCells = {}

	for i = 1, #self.datingEvents do
		local eventData = self.datingEvents[i]
		local cell = self.datingEventCellPool:Obtain()

		cell:UpdateView(eventData, i)
		cell:SetSelect(i == index)

		if i == index then
			self.selectCell = cell
		end

		cell.goView.transform:SetParent(self.ContentList.transform, false)
		cell.goView:SetActive(true)

		function cell.clickCallBack(cel)
			self:OnClickCell(cel)
		end

		table.insert(self.datingEventCells, cell)
	end

	for i = 1, 2 do
		local obj = UnityEngine.Object.Instantiate(self.OccupyingMould)

		obj.transform:SetParent(self.ContentList.transform, false)
		table.insert(self.occupyCells, obj)
		obj:SetActive(true)
	end

	self:SetScrollContentPos()
end

function GirlDatingListUI:CleanOccupyCells()
	for i, v in pairs(self.occupyCells) do
		UnityEngine.Object.DestroyImmediate(v)
	end

	self.occupyCells = {}
end

function GirlDatingListUI:OnClickCell(cel)
	if self.selectCell and self.selectCell.index == cel.index then
		return
	end

	if self.selectCell then
		self.selectCell:SetSelect(false)
	end

	self.selectCell = cel

	self.selectCell:SetSelect(true)
	self:SetScrollContentPos()
end

function GirlDatingListUI:SetScrollContentPos()
	local anPoy = 78 * (self.selectCell.index - 2)
	local maxPoy = 78 * #self.datingEvents

	anPoy = maxPoy < anPoy and maxPoy or anPoy

	local tween = TweenPosition.Begin(self.ContentList.transform.gameObject, 0.5, Vector2(-100, anPoy))

	tween:SetOnFinished(function()
		UnityEngine.GameObject.DestroyImmediate(tween)
	end)
end

function GirlDatingListUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.GirlDatingListUI)
end

function GirlDatingListUI:UpdatePeriodOfTime()
	self:LoadGirlBG(GirlBackGroundModule.currentUseBG)
end

function GirlDatingListUI:OnUpdateGirlBG(cid)
	self:LoadGirlBG(cid)
end

function GirlDatingListUI:Pause()
	self.l2dBuilder:PauseL2D()
end

function GirlDatingListUI:OnResumeL2D()
	self.l2dBuilder:ResumeL2D()
end

function GirlDatingListUI:LoadGirlBG(cid)
	if self.showBGCid == cid then
		return
	end

	local path, bgm, environmentalSound = GirlBackGroundModule.GetBackGroundPath(cid)

	AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, self.OnLoadFailed, {
		type = "LoadBG",
		bgCid = cid
	})
end

return GirlDatingListUI
