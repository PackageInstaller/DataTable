-- chunkname: @IQIGame\\UI\\NewMemoryUI.lua

local NewMemoryUI = Base:Extend("NewMemoryUI", "IQIGame.Onigao.UI.NewMemoryUI", {
	maxPos = 0,
	minPox = 0,
	moneyID = {},
	storyList = {}
})
local MemoryNewStoryScrollItem = require("IQIGame.UI.Memory.MemoryNewStoryScrollItem")
local MemoryNewStoryEffectLine = require("IQIGame.UI.Memory.MemoryNewStoryEffectLine")
local MemoryNewAlertView = require("IQIGame.UI.Memory.MemoryNewAlertView")

require("IQIGame.UI.Memory.MemoryMoneyCell")

function NewMemoryUI:OnInit()
	self.memoryAlertView = MemoryNewAlertView.New(self.AlertPanel)

	self.memoryAlertView:CloseUI()

	self.TextName:GetComponent("Text").text = NewMemoryUIApi:GetString("MemoryTitle")
	self.btnBack = self.btn_Back:GetComponent("Button")

	function self.delegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.delegateOnMemoryLockReady()
		self:OnMemoryStoryUnlock()
	end

	function self.delegateOpenMemoryChildPanel(newStoryInfo)
		self:OpenNewMemoryChildPanel(newStoryInfo)
	end

	self.minPox = self.UIController.gameObject.transform.sizeDelta.x - self.ScrollContent.transform.sizeDelta.x
	self.maxPos = 0
end

function NewMemoryUI:GetPreloadAssetPaths()
	return nil
end

function NewMemoryUI:GetOpenPreloadAssetPaths(userData)
	self.effectLinePaths = {}

	local pathList = {}

	self.storyList = MemoryNewModule.arrMemoryStoryInfoList

	for i = 1, #self.storyList do
		local memoryStoryInfo = self.storyList[i]

		if memoryStoryInfo.cfgSoulNewStory.Line1Resources ~= nil and memoryStoryInfo.cfgSoulNewStory.Line1Resources ~= "" then
			table.insert(pathList, UIGlobalApi.GetPrefabRoot(memoryStoryInfo.cfgSoulNewStory.Line1Resources))

			self.effectLinePaths[memoryStoryInfo.cfgSoulNewStory.Id .. "_line1"] = UIGlobalApi.GetPrefabRoot(memoryStoryInfo.cfgSoulNewStory.Line1Resources)
		end

		if memoryStoryInfo.cfgSoulNewStory.Line2Resources ~= nil and memoryStoryInfo.cfgSoulNewStory.Line2Resources ~= "" then
			table.insert(pathList, UIGlobalApi.GetPrefabRoot(memoryStoryInfo.cfgSoulNewStory.Line2Resources))

			self.effectLinePaths[memoryStoryInfo.cfgSoulNewStory.Id .. "_line2"] = UIGlobalApi.GetPrefabRoot(memoryStoryInfo.cfgSoulNewStory.Line2Resources)
		end
	end

	self.smallEffectPath = UIGlobalApi.GetPrefabRoot("/ART_Prefabs/Effect/FX_UI/FX_UI_NewMemoryUIMould01.prefab")

	table.insert(pathList, self.smallEffectPath)

	self.bigEffectPath = UIGlobalApi.GetPrefabRoot("/ART_Prefabs/Effect/FX_UI/FX_UI_NewMemoryUIMould02.prefab")

	table.insert(pathList, self.bigEffectPath)

	return pathList
end

function NewMemoryUI:OnOpen(userData)
	self.soulCid = userData[1]

	self:ShowMoneyItem()
	self:CreateElements()
	self:SetScrollContentPos()
end

function NewMemoryUI:OnClose(userData)
	self.memoryAlertView:CloseUI()

	if self.timerLine1 ~= nil then
		self.timerLine1:Stop()

		self.timerLine1 = nil
	end

	if self.timerEffect ~= nil then
		self.timerEffect:Stop()

		self.timerEffect = nil
	end

	if self.timerLine2 ~= nil then
		self.timerLine2:Stop()

		self.timerLine2 = nil
	end

	if self.timerShowLock ~= nil then
		self.timerShowLock:Stop()

		self.timerShowLock = nil
	end

	for i, v in pairs(self.effectLines) do
		v:Dispose()
	end

	self.effectLines = nil

	for i, v in pairs(self.storyScrollItems) do
		v:DisPose()
	end

	self.storyScrollItems = nil

	for i, v in pairs(self.effectItems) do
		UnityEngine.Object.DestroyImmediate(v)
	end

	self.effectItems = nil

	EventDispatcher.Dispatch(EventID.MemoryUICloseEvent)
end

function NewMemoryUI:OnAddListeners()
	self.btnBack.onClick:AddListener(self.delegateOnClickBtnBack)
	EventDispatcher.AddEventListener(EventID.MemoryStoryChapterDataRefreshEvent, self.delegateOnMemoryLockReady)
	EventDispatcher.AddEventListener(EventID.OpenNewMemoryChildPanel, self.delegateOpenMemoryChildPanel)
end

function NewMemoryUI:OnRemoveListeners()
	self.btnBack.onClick:RemoveListener(self.delegateOnClickBtnBack)
	EventDispatcher.RemoveEventListener(EventID.MemoryStoryChapterDataRefreshEvent, self.delegateOnMemoryLockReady)
	EventDispatcher.RemoveEventListener(EventID.OpenNewMemoryChildPanel, self.delegateOpenMemoryChildPanel)
end

function NewMemoryUI:OnPause()
	return
end

function NewMemoryUI:OnResume()
	return
end

function NewMemoryUI:OnCover()
	return
end

function NewMemoryUI:OnReveal()
	return
end

function NewMemoryUI:OnRefocus(userData)
	return
end

function NewMemoryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.isShowEffect == true and UIModule.HasUI(Constant.UIControllerName.MemorySettlement) == false and UIModule.HasUI(Constant.UIControllerName.NewMemoryWindownUI) == false then
		self.isShowEffect = false

		self:ShowEffect(self.newStoryInfo)
	end
end

function NewMemoryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function NewMemoryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function NewMemoryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function NewMemoryUI:OnDestroy()
	self.memoryAlertView:Dispose()

	if self.moneyItems ~= nil then
		for i, v in pairs(self.moneyItems) do
			v:Dispose()
			UnityEngine.Object.DestroyImmediate(v.ViewGo)
		end

		self.moneyItems = nil
	end
end

function NewMemoryUI:ShowMoneyItem()
	if self.moneyItems then
		for i, v in pairs(self.moneyItems) do
			v:Dispose()
		end
	end

	self.moneyItems = {}

	local transform = self.ItemGrid.transform

	for i = 1, transform.childCount - 1 do
		local obj = transform:GetChild(1).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	self.moneyID = CfgSoulTable[self.soulCid].NewStoryItemId

	local moneyGrid_Mould = self.ItemGrid.transform:GetChild(0).gameObject

	moneyGrid_Mould:SetActive(false)

	for i, v in pairs(self.moneyID) do
		local itemObj = UnityEngine.Object.Instantiate(moneyGrid_Mould)

		itemObj.transform:SetParent(transform, false)
		itemObj:SetActive(true)

		local moneyCell = MemoryMoneyCell.New(itemObj, v)

		table.insert(self.moneyItems, moneyCell)
	end
end

function NewMemoryUI:CreateElements()
	MemoryNewModule.isCurrentOpen = false
	self.storyList = MemoryNewModule.arrMemoryStoryInfoList

	table.sort(self.storyList, NewMemoryUI.SortEvent)

	self.newStoryInfo = nil
	self.effectLines = {}
	self.storyScrollItems = {}
	self.effectItems = {}

	local num = MemoryNewModule.GetUnlockMemoryStoryNum()
	local isOpen = false

	for i = 1, #self.storyList do
		isOpen = i <= num

		local memoryStoryInfo = self.storyList[i]
		local itemObj, itemEffectObj, pathObj

		if memoryStoryInfo.cfgSoulNewStory.Type == 1 then
			itemObj = UnityEngine.Object.Instantiate(self.Mould1)
			pathObj = self.UIController:GetPreloadedAsset(self.smallEffectPath)
			itemEffectObj = UnityEngine.Object.Instantiate(pathObj)
		else
			itemObj = UnityEngine.Object.Instantiate(self.Mould2)
			pathObj = self.UIController:GetPreloadedAsset(self.bigEffectPath)
			itemEffectObj = UnityEngine.Object.Instantiate(pathObj)
		end

		itemObj:SetActive(true)
		itemObj.transform:SetParent(self.Panel.transform, false)

		itemObj.transform.anchoredPosition = Vector2.New(memoryStoryInfo.cfgSoulNewStory.ButtonPosition[1], memoryStoryInfo.cfgSoulNewStory.ButtonPosition[2])

		local scrollItem = MemoryNewStoryScrollItem:__New(itemObj)

		scrollItem:RefreshUI(memoryStoryInfo)

		function scrollItem.clickCallBack(data, isLock)
			self:ClickNewStoryItem(data, isLock)
		end

		self.storyScrollItems[memoryStoryInfo.cfgSoulNewStory.Id] = scrollItem

		itemEffectObj:SetActive(false)
		itemEffectObj.transform:SetParent(self.Effect.transform, false)

		itemEffectObj.transform.localPosition = Vector3.New(memoryStoryInfo.cfgSoulNewStory.ButtonPosition[1], memoryStoryInfo.cfgSoulNewStory.ButtonPosition[2] + 16, memoryStoryInfo.cfgSoulNewStory.ButtonPosition[3])
		self.effectItems[memoryStoryInfo.cfgSoulNewStory.Id] = itemEffectObj

		if memoryStoryInfo.cfgSoulNewStory.Line1Resources ~= nil and memoryStoryInfo.cfgSoulNewStory.Line1Resources ~= "" then
			local path1Obj = self.UIController:GetPreloadedAsset(self.effectLinePaths[memoryStoryInfo.cfgSoulNewStory.Id .. "_line1"])
			local obj1 = UnityEngine.Object.Instantiate(path1Obj)

			obj1.name = memoryStoryInfo.cfgSoulNewStory.Id .. "_line1"

			local effectLine1 = MemoryNewStoryEffectLine.New(obj1, self.Effect.transform, memoryStoryInfo.cfgSoulNewStory.Line1Location)

			self.effectLines[memoryStoryInfo.cfgSoulNewStory.Id .. "_line1"] = effectLine1

			if isOpen then
				effectLine1:ShowState(2)
			else
				effectLine1:ShowState(1)
			end
		end

		if memoryStoryInfo.cfgSoulNewStory.Line2Resources ~= nil and memoryStoryInfo.cfgSoulNewStory.Line2Resources ~= "" then
			local path2Obj = self.UIController:GetPreloadedAsset(self.effectLinePaths[memoryStoryInfo.cfgSoulNewStory.Id .. "_line2"])
			local obj2 = UnityEngine.Object.Instantiate(path2Obj)

			obj2.name = memoryStoryInfo.cfgSoulNewStory.Id .. "_line2"

			local effectLine2 = MemoryNewStoryEffectLine.New(obj2, self.Effect.transform, memoryStoryInfo.cfgSoulNewStory.Line2Location)

			self.effectLines[memoryStoryInfo.cfgSoulNewStory.Id .. "_line2"] = effectLine2

			if isOpen then
				effectLine2:ShowState(2)
			else
				effectLine2:ShowState(1)
			end
		end

		if isOpen then
			self.newStoryInfo = memoryStoryInfo
		end
	end

	self.lock1:SetActive(false)
	self.lock2:SetActive(true)

	self.lock1.transform.localPosition = Vector3.New(self.newStoryInfo.cfgSoulNewStory.LockLocation[1], self.newStoryInfo.cfgSoulNewStory.LockLocation[2], self.newStoryInfo.cfgSoulNewStory.LockLocation[3])
	self.lock2.transform.localPosition = Vector3.New(self.newStoryInfo.cfgSoulNewStory.LockLocation[1], self.newStoryInfo.cfgSoulNewStory.LockLocation[2], self.newStoryInfo.cfgSoulNewStory.LockLocation[3])

	self:SetScrollContentPos()
end

function NewMemoryUI:OnClickBtnBack()
	UIModule.Close(Constant.UIControllerName.NewMemoryUI)
end

function NewMemoryUI:OnMemoryStoryUnlock()
	self:UpdateView()
end

function NewMemoryUI.SortEvent(tb1, tb2)
	return tb1.cfgSoulNewStory.Id < tb2.cfgSoulNewStory.Id
end

function NewMemoryUI:UpdateView()
	self.storyList = MemoryNewModule.arrMemoryStoryInfoList

	table.sort(self.storyList, NewMemoryUI.SortEvent)

	local newOpenInfo
	local num = MemoryNewModule.GetUnlockMemoryStoryNum()
	local isOpen = false

	for i = 1, #self.storyList do
		isOpen = i <= num

		local memoryStoryInfo = self.storyList[i]

		if isOpen then
			newOpenInfo = memoryStoryInfo
		end

		self.storyScrollItems[memoryStoryInfo.cfgSoulNewStory.Id]:RefreshUI(memoryStoryInfo)
	end

	self.isShowEffect = false

	if self.newStoryInfo.cfgSoulNewStory.Id ~= newOpenInfo.cfgSoulNewStory.Id then
		self.newStoryInfo = newOpenInfo
		self.isShowEffect = true
	end
end

function NewMemoryUI:SetScrollContentPos()
	local itemPos = self.storyScrollItems[self.newStoryInfo.cfgSoulNewStory.Id].goView.transform.position
	local canvas = self.UIController.gameObject:GetComponent("Canvas")
	local pos = inverseTransformPoint(canvas, itemPos)
	local anPox = self.ScrollContent.transform.anchoredPosition.x

	anPox = anPox - pos.x

	if anPox < self.minPox then
		anPox = self.minPox
	end

	if anPox > self.maxPos then
		anPox = self.maxPos
	end

	local tween = TweenPosition.Begin(self.ScrollContent.transform.gameObject, 1, Vector2(anPox, 0))

	tween:SetOnFinished(function()
		UnityEngine.GameObject.DestroyImmediate(tween)
	end)
end

function NewMemoryUI:ShowEffect(data)
	if data then
		self.lock1:SetActive(false)
		self.lock1:SetActive(true)
		self.lock2:SetActive(false)

		if self.timerLine1 ~= nil then
			self.timerLine1:Stop()

			self.timerLine1 = nil
		end

		self.timerLine1 = Timer.New(function()
			self:SetScrollContentPos()

			local effectLint1 = self.effectLines[data.cfgSoulNewStory.Id .. "_line1"]

			if effectLint1 then
				effectLint1:ShowState(3)
			end

			self.lock1:SetActive(false)
			self.lock2:SetActive(false)

			self.lock1.transform.localPosition = Vector3.New(data.cfgSoulNewStory.LockLocation[1], data.cfgSoulNewStory.LockLocation[2], data.cfgSoulNewStory.LockLocation[3])
			self.lock2.transform.localPosition = Vector3.New(data.cfgSoulNewStory.LockLocation[1], data.cfgSoulNewStory.LockLocation[2], data.cfgSoulNewStory.LockLocation[3])
		end, 0.5)

		self.timerLine1:Start()

		if self.timerEffect ~= nil then
			self.timerEffect:Stop()

			self.timerEffect = nil
		end

		MemoryNewModule.isCurrentOpen = false
		self.timerEffect = Timer.New(function()
			for i, v in pairs(self.effectItems) do
				v:SetActive(false)
			end

			self.effectItems[data.cfgSoulNewStory.Id]:SetActive(true)
			self.storyScrollItems[data.cfgSoulNewStory.Id]:RefreshUI(data)
		end, 1.5)

		self.timerEffect:Start()

		if self.timerLine2 ~= nil then
			self.timerLine2:Stop()

			self.timerLine2 = nil
		end

		self.timerLine2 = Timer.New(function()
			local effectLint2 = self.effectLines[data.cfgSoulNewStory.Id .. "_line2"]

			if effectLint2 then
				effectLint2:ShowState(3)
			end
		end, 2)

		self.timerLine2:Start()

		if self.timerShowLock ~= nil then
			self.timerShowLock:Stop()

			self.timerShowLock = nil
		end

		self.timerShowLock = Timer.New(function()
			self.lock2:SetActive(true)
		end, 3)

		self.timerShowLock:Start()
	end
end

function NewMemoryUI:ClickNewStoryItem(data, isLock)
	self.memoryAlertView:OpenUI()
	self.memoryAlertView:UpdateView(data, isLock)
end

function NewMemoryUI:OpenNewMemoryChildPanel(newStoryInfo)
	UIModule.Open(Constant.UIControllerName.NewMemoryWindownUI, Constant.UILayer.UI, newStoryInfo)
end

return NewMemoryUI
