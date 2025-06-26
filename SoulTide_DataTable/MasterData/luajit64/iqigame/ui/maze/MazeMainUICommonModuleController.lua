-- chunkname: @IQIGame\\UI\\Maze\\MazeMainUICommonModuleController.lua

local m = {
	BuffCells = {}
}
local MazeSoulHeadCell = require("IQIGame.UI.Maze.MazeSoulHeadCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local BuffCell = require("IQIGame.UI.Common.BuffCell")
local MazeTopRightNoticeController = require("IQIGame.UI.Maze.MazeTopRightNoticeController")
local MazeElementNoticeUI = require("IQIGame.UI.Maze.MazeElementNoticeUI")
local MazeSmallMapPanel = require("IQIGame.UI.Maze.MazeSmallMapPanel")
local ChatBar = require("IQIGame.UI.Chat.ChatBar")

function m.New(view, UIController, topBarChild, btnGroup, outsideBottom, getCustomDataFunc)
	local obj = Clone(m)

	obj:Init(view, UIController, topBarChild, btnGroup, outsideBottom, getCustomDataFunc)

	return obj
end

function m:Init(view, UIController, topBarChild, btnGroup, outsideBottom, getCustomDataFunc)
	self.View = view
	self.UIController = UIController
	self.GetCustomDataFunc = getCustomDataFunc

	LuaCodeInterface.BindOutlet(self.View, self)
	topBarChild.transform:SetParent(self.TopNode.transform, false)
	btnGroup.transform:SetParent(self.BtnNode.transform, false)

	if outsideBottom ~= nil then
		outsideBottom.transform:SetParent(self.OutsideBottomNode.transform, false)
	end

	function self.DelegateOnClickBigMapBtn()
		self:OnClickBigMapBtn()
	end

	function self.DelegateOnClickQuitBtn()
		self:OnClickQuitBtn()
	end

	function self.DelegateOnBuffChanged()
		self:OnBuffChanged()
	end

	function self.DelegateOnMazeMainUITweenShow()
		self:OnMazeMainUITweenShow()
	end

	function self.DelegateOnClickHeadCell(owner, cell)
		self:OnClickHeadCell(owner, cell)
	end

	function self.DelegateOnShowStartExploreNotice(isNotRestore)
		self:OnShowStartExploreNotice(isNotRestore)
	end

	function self.DelegateOnMazeCameraMove(cameraPosition, isNotMoveOrSet)
		self:OnMazeCameraMove(cameraPosition, isNotMoveOrSet)
	end

	function self.DelegateOnClickResetCameraBtn()
		self:OnClickResetCameraBtn()
	end

	function self.DelegateOnSoulDeadOrRevive()
		self:OnSoulDeadOrRevive()
	end

	function self.DelegateOnChangeHero()
		self:OnChangeHero()
	end

	function self.DelegateOnMazeStagePlay(isPlay)
		self:OnMazeStagePlay(isPlay)
	end

	function self.DelegateOnHeroStartMove()
		self:OnHeroStartMove()
	end

	function self.DelegateOnArriveAtManualTriggerServiceNode(nodeId, needConfirmElementIds)
		self:OnArriveAtManualTriggerServiceNode(nodeId, needConfirmElementIds)
	end

	function self.DelegateOnClickServiceTriggerNoticeBtn()
		self:OnClickServiceTriggerNoticeBtn()
	end

	function self.DelegateOnUpdateDoll(changedProps)
		self:OnUpdateDoll(changedProps)
	end

	self.SoulHeadCells = {}

	for i = 1, 5 do
		local go = UnityEngine.Object.Instantiate(self.SoulHeadPrefab)

		go.transform:SetParent(self.SoulGrid.transform, false)

		local cell = MazeSoulHeadCell.New(go)

		cell:SetClickHandler(self.DelegateOnClickHeadCell)
		table.insert(self.SoulHeadCells, cell)
	end

	self.BuffPool = UIObjectPool.New(10, function()
		return BuffCell.New(UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab("/Common/CommonBuffUI"))), self.BuffTipPos.transform)
	end, function(cell)
		local cellView = cell.goView

		cell:OnDestroy()
		UnityEngine.Object.Destroy(cellView)
	end)
	self.MazeTopRightNoticeController = MazeTopRightNoticeController.New(self.BuffEffectNoticePanel, self.UIController.gameObject)
	self.ElementNoticeController = MazeElementNoticeUI.New(self.ElementNotice)
	self.SmallMapController = MazeSmallMapPanel.New(self.Map, self.UIController)

	self.Map:SetActive(true)
	self.NoMapView:SetActive(false)

	self.TopTween = self.Top:GetComponent("UITweener")
	self.BottomTween = self.Bottom:GetComponent("UITweener")
	self.StartExplorePanelTweens = self.StartExplorePanel:GetComponents(typeof(UITweener))
	self.chatBar = ChatBar.New(self.goChatBar)

	UGUIUtil.SetTextInChildren(self.ServiceTriggerNoticeBtn, MazeMainUIApi:GetString("ServiceTriggerNoticeBtnText"))
end

function m.GetPreloadAssetPaths()
	local paths = {}

	table.insert(paths, UIGlobalApi.GetUIPrefab("/Common/CommonBuffUI"))

	local mapUIAssets = MazeMainUIApi:GetString("MapUIAssets")

	for i = 1, #mapUIAssets do
		table.insert(paths, mapUIAssets[i])
	end

	return paths
end

function m.GetOpenPreloadAssetPaths(userData)
	return nil
end

function m:OnInit()
	UGUIUtil.SetTextInChildren(self.QuitBtn, MazeMainUIApi:GetString("QuitBtnText"))
end

function m:OnOpen(userData)
	self:ResetShow()
	self:UpdateView()
end

function m:OnClose(userData)
	if self.ServiceTriggerNoticeTimer ~= nil then
		self.ServiceTriggerNoticeTimer:Stop()

		self.ServiceTriggerNoticeTimer = nil
	end

	self.NeedConfirmTriggerElementIds = nil
	self.TriggerServiceBtnRefNodeTrans = nil

	self.ServiceTriggerNoticeNode:SetActive(false)
	self.chatBar:OnHide()
end

function m:OnAddListeners()
	self.BigMapBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBigMapBtn)
	self.QuitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickQuitBtn)
	self.PlayerPointerResetBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickResetCameraBtn)
	self.ServiceTriggerNoticeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickServiceTriggerNoticeBtn)
	EventDispatcher.AddEventListener(EventID.MazeBuffChanged, self.DelegateOnBuffChanged)
	EventDispatcher.AddEventListener(EventID.MazeMainUITweenShow, self.DelegateOnMazeMainUITweenShow)
	EventDispatcher.AddEventListener(EventID.ShowStartExploreNotice, self.DelegateOnShowStartExploreNotice)
	EventDispatcher.AddEventListener(EventID.MazeCameraMove, self.DelegateOnMazeCameraMove)
	EventDispatcher.AddEventListener(EventID.MazeSoulDead, self.DelegateOnSoulDeadOrRevive)
	EventDispatcher.AddEventListener(EventID.MazeSoulRevive, self.DelegateOnSoulDeadOrRevive)
	EventDispatcher.AddEventListener(EventID.MazeChangeHero, self.DelegateOnChangeHero)
	EventDispatcher.AddEventListener(EventID.MazeStagePlay, self.DelegateOnMazeStagePlay)
	EventDispatcher.AddEventListener(EventID.MazeHeroStartMove, self.DelegateOnHeroStartMove)
	EventDispatcher.AddEventListener(EventID.MazeHeroCorrectPosition, self.DelegateOnHeroStartMove)
	EventDispatcher.AddEventListener(EventID.MazeArriveAtManualTriggerServiceNode, self.DelegateOnArriveAtManualTriggerServiceNode)
	EventDispatcher.AddEventListener(EventID.MazeUpdateDoll, self.DelegateOnUpdateDoll)
end

function m:OnRemoveListeners()
	self.BigMapBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBigMapBtn)
	self.QuitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickQuitBtn)
	self.PlayerPointerResetBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickResetCameraBtn)
	self.ServiceTriggerNoticeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickServiceTriggerNoticeBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeBuffChanged, self.DelegateOnBuffChanged)
	EventDispatcher.RemoveEventListener(EventID.MazeMainUITweenShow, self.DelegateOnMazeMainUITweenShow)
	EventDispatcher.RemoveEventListener(EventID.ShowStartExploreNotice, self.DelegateOnShowStartExploreNotice)
	EventDispatcher.RemoveEventListener(EventID.MazeCameraMove, self.DelegateOnMazeCameraMove)
	EventDispatcher.RemoveEventListener(EventID.MazeSoulDead, self.DelegateOnSoulDeadOrRevive)
	EventDispatcher.RemoveEventListener(EventID.MazeSoulRevive, self.DelegateOnSoulDeadOrRevive)
	EventDispatcher.RemoveEventListener(EventID.MazeChangeHero, self.DelegateOnChangeHero)
	EventDispatcher.RemoveEventListener(EventID.MazeStagePlay, self.DelegateOnMazeStagePlay)
	EventDispatcher.RemoveEventListener(EventID.MazeHeroStartMove, self.DelegateOnHeroStartMove)
	EventDispatcher.RemoveEventListener(EventID.MazeHeroCorrectPosition, self.DelegateOnHeroStartMove)
	EventDispatcher.RemoveEventListener(EventID.MazeArriveAtManualTriggerServiceNode, self.DelegateOnArriveAtManualTriggerServiceNode)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateDoll, self.DelegateOnUpdateDoll)
end

function m:OnPause()
	return
end

function m:OnResume()
	return
end

function m:OnCover()
	return
end

function m:OnReveal()
	return
end

function m:OnRefocus(userData)
	return
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	self.MazeTopRightNoticeController:Update(elapseSeconds, realElapseSeconds)
end

function m:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function m:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function m:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function m:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.SoulHeadCells do
		local mazeSoulHeadCell = self.SoulHeadCells[i]

		mazeSoulHeadCell:Dispose()
	end

	self.SoulHeadCells = nil

	self:ClearBuff(true)
	self.BuffPool:Dispose()
	self.MazeTopRightNoticeController:Dispose()
	self.ElementNoticeController:Dispose()
	self.SmallMapController:Dispose()
	self.chatBar:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:OnClickBigMapBtn()
	if MazeDataModule.PlayerInfo.MiniMapSwitch then
		self.SmallMapController:ShowBigMap()
	else
		NoticeModule.ShowNotice(50000000)
	end
end

function m:OnClickQuitBtn()
	MazeModule.CheckQuitMaze()
end

function m:UpdateView()
	self:UpdateSoulHeadCells()
	self:RefreshBuff()
	self.SmallMapController:OnShow()
	self.Map:SetActive(MazeDataModule.PlayerInfo.MiniMapSwitch)

	local isScrollMaze = MazeDataModule.IsScrollMaze()

	self.NoMapView:SetActive(not MazeDataModule.PlayerInfo.MiniMapSwitch and not isScrollMaze)
	self.BigMapBtn:SetActive(not isScrollMaze)
	self:UpdatePlayerPointerIcon()

	local customData = self.GetCustomDataFunc()

	UGUIUtil.SetText(self.StartPanelTitleText, customData.startTitle)
	self.StartPanelTipNode:SetActive(customData.startTip ~= "")

	if customData.startTip ~= "" then
		UGUIUtil.SetText(self.StartPanelTipText, customData.startTip)
	end

	if MazeModule.CanMainUITweenShow then
		self:TweenShow()
	end

	self:CheckMutuallyExclusiveShow()
	self.chatBar:Refresh()
end

function m:UpdateSoulHeadCells(changedProps)
	local dollDataList = MazeDataModule.GetActiveDollDataList()
	local soulAvatarData

	if MazeDataModule.PlayerInfo.TempHeroSoulCid ~= 0 then
		local firstAliveDollData = MazeDataModule.GetFirstAliveDoll()

		if firstAliveDollData ~= nil then
			local tempSoulAvatarData = MazeDataModule.GetSoulAvatarData()

			if tempSoulAvatarData.headIcon02 ~= nil and tempSoulAvatarData.headIcon02 ~= "" then
				soulAvatarData = tempSoulAvatarData
				dollDataList = {
					firstAliveDollData
				}
			end
		end
	end

	local posDollMap = {}

	for i = 1, #dollDataList do
		local mazeDollPOD = dollDataList[i]

		posDollMap[mazeDollPOD.formationPos] = mazeDollPOD
	end

	for i = 1, #self.SoulHeadCells do
		local mazeSoulHeadCell = self.SoulHeadCells[i]
		local dollData = posDollMap[i]
		local changeProp

		if dollData ~= nil and changedProps ~= nil then
			changeProp = changedProps[dollData.id]
		end

		mazeSoulHeadCell:SetData(dollData, soulAvatarData, changeProp)
	end
end

function m:UpdatePlayerPointerIcon()
	local soulAvatarData = MazeDataModule.GetSoulAvatarData()

	if soulAvatarData ~= nil and soulAvatarData.headIcon ~= nil and soulAvatarData.headIcon ~= "" then
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(soulAvatarData.headIcon), self.PlayerPointerIcon:GetComponent("Image"))
	end
end

function m:RefreshBuff()
	self:ClearBuff()

	for i = 1, #MazeDataModule.PlayerInfo.Buffs do
		local buffPOD = MazeDataModule.PlayerInfo.Buffs[i]
		local cfgBuffData = CfgBuffTable[buffPOD.CID]

		if cfgBuffData.IsVisible then
			local buffCell = self.BuffPool:Obtain()

			buffCell.goView:SetActive(true)
			buffCell.goView.transform:SetParent(self.BuffGrid.transform, false)
			buffCell:Refresh(CfgBuffTable[buffPOD.CID], true, 2, nil)
			buffCell:RefreshLayers(buffPOD.Stack)
			table.insert(self.BuffCells, buffCell)
		end
	end
end

function m:ClearBuff(isDestroy)
	for i = 1, #self.BuffCells do
		local buffCell = self.BuffCells[i]

		buffCell.goView:SetActive(false)

		if not isDestroy then
			buffCell.goView.transform:SetParent(self.UIController.transform, false)
		end

		self.BuffPool:Release(buffCell)
	end

	self.BuffCells = {}
end

function m:HideBuffByTag(tags)
	for i = 1, #self.BuffCells do
		local buffCell = self.BuffCells[i]

		if table.indexOf(tags, buffCell.cfgData.Tag) ~= -1 then
			buffCell:SetActive(false)
		end
	end
end

function m:ShowBuffByTag(tags)
	for i = 1, #self.BuffCells do
		local buffCell = self.BuffCells[i]

		if table.indexOf(tags, buffCell.cfgData.Tag) ~= -1 then
			buffCell:SetActive(true)
		end
	end
end

function m:OnBuffChanged()
	self:RefreshBuff()
end

function m:ResetShow()
	self.TopTween:ResetToBeginning()

	self.TopTween.enabled = true

	self.BottomTween:ResetToBeginning()

	self.BottomTween.enabled = true

	self.Top:SetActive(false)
	self.Bottom:SetActive(false)
	self:HideStartExplorePanel()
	self.ElementNoticeController:Hide()
end

function m:HideStartExplorePanel()
	for i = 0, self.StartExplorePanelTweens.Length - 1 do
		local tween = self.StartExplorePanelTweens[i]

		tween:ResetToBeginning()

		tween.enabled = true
	end

	self.StartExplorePanel:SetActive(false)
end

function m:OnMazeMainUITweenShow()
	self:TweenShow()
end

function m:TweenShow()
	self.Top:SetActive(true)
	self.Bottom:SetActive(true)
end

function m:SetActionBeforeStartNotice(func)
	self.ActionBeforeStart = func
end

function m:OnShowStartExploreNotice(isNotRestore)
	if isNotRestore then
		if self.ActionBeforeStart ~= nil then
			EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeMainUIBeforeStartExplore, true)
			self.ActionBeforeStart(function()
				local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
					self.StartExplorePanel:SetActive(true)
					EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeMainUIBeforeStartExplore, false)
				end, 0.3)

				timer:Start()
			end)
		else
			self.StartExplorePanel:SetActive(true)
		end
	end
end

function m:OnClickHeadCell(owner, cell)
	if self.CustomClickSoulHeadHandler ~= nil then
		self.CustomClickSoulHeadHandler(cell.DollData.id)

		return
	end

	UIModule.Open(Constant.UIControllerName.MazeTeamUI, Constant.UILayer.UI, {
		dollId = cell.DollData.id
	})
end

function m:OnMazeCameraMove(cameraPosition, isNotMoveOrSet)
	local screenRatio = 750 / UnityEngine.Screen.height
	local screenWidth = UnityEngine.Screen.width * screenRatio
	local screenHeight = 750
	local playerHalfHeight = 75
	local playerPointerRadius = 64
	local heroPos = MazeModule.MazeScene.Hero.gameObject.transform.position
	local screenPos = MazeModule.MazeScene.MainCamera:WorldToScreenPoint(heroPos) * screenRatio

	screenPos.y = screenPos.y + playerHalfHeight

	local maskHeight = MazeMainUIApi:GetString("MaskHeight")
	local minHeroX = 0
	local maxHeroX = screenWidth
	local minHeroY = 0
	local maxHeroY = screenHeight - maskHeight
	local outSideScreen = minHeroX > screenPos.x or maxHeroX < screenPos.x or minHeroY > screenPos.y or maxHeroY < screenPos.y

	self.PlayerPointer:SetActive(outSideScreen)

	if outSideScreen then
		local pointerX = screenPos.x
		local pointerY = screenPos.y
		local minPointerX = playerPointerRadius
		local maxPointerX = screenWidth - playerPointerRadius
		local minPointerY = playerPointerRadius
		local maxPointerY = screenHeight - (maskHeight + playerPointerRadius)

		if pointerX < minPointerX then
			pointerX = minPointerX
		elseif maxPointerX < pointerX then
			pointerX = maxPointerX
		end

		if pointerY < minPointerY then
			pointerY = minPointerY
		elseif maxPointerY < pointerY then
			pointerY = maxPointerY
		end

		local pointerPos = Vector2(pointerX, pointerY)

		self.PlayerPointer.transform.anchoredPosition = pointerPos

		local fromStartToEnd = Vector3(screenPos.x, screenPos.y, 0) - Vector3(pointerPos.x, pointerPos.y, 0)
		local rotation = Quaternion.LookRotation(fromStartToEnd, Vector3.right)

		self.PlayerPointer.transform:Find("Pointer").transform.rotation = rotation
	end

	if self.TriggerServiceBtnRefNodeTrans ~= nil then
		worldToScreenPoint(MazeModule.MazeScene.MainCamera, self.UIController:GetComponent("Canvas").worldCamera, self.TriggerServiceBtnRefNodeTrans, self.ServiceTriggerNoticeNode.transform)
	end
end

function m:OnClickResetCameraBtn()
	MazeModule.MazeScene:ResetCameraToHero()
end

function m:OnSoulDeadOrRevive()
	self:UpdatePlayerPointerIcon()
end

function m:OnChangeHero()
	self:UpdateSoulHeadCells()
	self:UpdatePlayerPointerIcon()
end

function m:OnMazeStagePlay(isPlay)
	self:CheckMutuallyExclusiveShow()
	self:ChangeServiceTriggerNoticeVisible(not isPlay)
end

function m:CheckMutuallyExclusiveShow()
	for i = 0, self.UIController.transform.childCount - 1 do
		local child = self.UIController.transform:GetChild(i)

		child.anchoredPosition = MazeModule.IsStageShow() and Vector2(-10000, 0) or Vector2.zero
	end

	if self.TriggerServiceBtnRefNodeTrans ~= nil then
		worldToScreenPoint(MazeModule.MazeScene.MainCamera, self.UIController:GetComponent("Canvas").worldCamera, self.TriggerServiceBtnRefNodeTrans, self.ServiceTriggerNoticeNode.transform)
	end
end

function m:OnHeroStartMove()
	if self.NeedConfirmTriggerElementIds == nil then
		return
	end

	self.NeedConfirmTriggerElementIds = nil

	UIUtil.PlayOrRewindDefaultAnim(self.ServiceTriggerNoticeBtn, true)

	self.ServiceTriggerNoticeTimer = Timer.New(function()
		self.ServiceTriggerNoticeTimer = nil

		self.ServiceTriggerNoticeNode:SetActive(false)

		self.TriggerServiceBtnRefNodeTrans = nil
	end, MazeMainUIApi:GetString("ServiceTriggerButtonDuration"))

	self.ServiceTriggerNoticeTimer:Start()
end

function m:ChangeServiceTriggerNoticeVisible(value)
	local graphics = self.ServiceTriggerNoticeNode:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true)

	for i = 0, graphics.Length - 1 do
		local graphic = graphics[i]

		graphic.enabled = value
	end
end

function m:OnArriveAtManualTriggerServiceNode(nodeId, needConfirmElementIds)
	local mazeNode = MazeModule.MazeScene:GetNode(nodeId)

	if mazeNode == nil then
		warning("找不到节点：" .. nodeId .. "，如果是流式加载迷宫，该节点可能还未加载出来，否则可能存在BUG，请通知程序检查。")

		return
	end

	if self.ServiceTriggerNoticeTimer ~= nil then
		self.ServiceTriggerNoticeTimer:Stop()

		self.ServiceTriggerNoticeTimer = nil
	end

	self.NeedConfirmTriggerElementIds = needConfirmElementIds

	self.ServiceTriggerNoticeNode:SetActive(true)

	self.TriggerServiceBtnRefNodeTrans = mazeNode.gameObject.transform

	worldToScreenPoint(MazeModule.MazeScene.MainCamera, self.UIController:GetComponent("Canvas").worldCamera, self.TriggerServiceBtnRefNodeTrans, self.ServiceTriggerNoticeNode.transform)
	UIUtil.PlayOrRewindDefaultAnim(self.ServiceTriggerNoticeBtn, false)
end

function m:OnClickServiceTriggerNoticeBtn()
	if MazeModule.MazeScene.MoveArriveOrderNotConfirmed then
		return
	end

	if self.NeedConfirmTriggerElementIds == nil then
		return
	end

	if self.ServiceTriggerNoticeTimer ~= nil then
		self.ServiceTriggerNoticeTimer:Stop()

		self.ServiceTriggerNoticeTimer = nil
	end

	self.ServiceTriggerNoticeNode:SetActive(false)

	for i = 1, #self.NeedConfirmTriggerElementIds do
		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_COLLISION_CHECK_TRIGGER, {
			Id = self.NeedConfirmTriggerElementIds[i]
		})
	end

	self.NeedConfirmTriggerElementIds = nil
	self.TriggerServiceBtnRefNodeTrans = nil
end

function m:SetCustomClickSoulHeadHandler(handler)
	self.CustomClickSoulHeadHandler = handler
end

function m:OnUpdateDoll(changedProps)
	self:UpdateSoulHeadCells(changedProps)
end

return m
