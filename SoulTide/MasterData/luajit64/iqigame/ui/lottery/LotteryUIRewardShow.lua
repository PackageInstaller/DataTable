-- chunkname: @IQIGame\\UI\\Lottery\\LotteryUIRewardShow.lua

local m = {
	OpeningDetailPanel = false,
	OpenAllStartTime = 0,
	LotteryShowCid = 0,
	OPEN_BOX_DURATION = 0.2,
	LotteryCid = 0,
	IsSimulateDraw = false,
	ShowBoxComplete = false,
	SingleBoxes = {},
	MultipleBoxes = {},
	ResultNodes = {},
	ItemResults = {},
	SoulResults = {},
	ResultBgEffectPlayIds = {}
}
local BoxController = require("IQIGame.UI.Lottery.LotteryUIRewardShowBoxController")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local LotteryResultItemCell = require("IQIGame.UI.Lottery.LotteryResultItemCell")
local LotteryResultSoulCell = require("IQIGame.UI.Lottery.LotteryResultSoulCell")
local LotteryPanelName = require("IQIGame.UI.Lottery.LotteryPanelName")

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnTapGesture(gesture)
		self:OnTapGesture(gesture)
	end

	function self.DelegateOnClickQuitBtn()
		self:OnClickQuitBtn()
	end

	function self.DelegateOnClickOpenAllBtn()
		self:OnClickOpenAllBtn()
	end

	function self.DelegateOnClickContinueBtn()
		self:OnClickContinueBtn()
	end

	for i = 1, self.SingleNode.transform.childCount do
		local flyNode = self.SingleNode.transform:Find("Mould_" .. i)
		local boxController = BoxController.New(flyNode.gameObject)

		self.SingleBoxes[i] = boxController
	end

	for i = 1, self.MultipleNode.transform.childCount do
		local flyNode = self.MultipleNode.transform:Find("Mould_" .. i)
		local boxController = BoxController.New(flyNode.gameObject)

		self.MultipleBoxes[i] = boxController
	end

	for i = 1, 10 do
		self.ResultNodes[i] = self.ResultPanel.transform:Find("Mould_" .. i)
	end

	local mainCanvas = self.Host.UIController:GetComponent("Canvas")

	self.ItemResultPool = UIObjectPool.New(5, function()
		local cell = LotteryResultItemCell.New(UnityEngine.Object.Instantiate(self.ItemPrefab), mainCanvas)

		return cell
	end, function(cell)
		local cellView = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(cellView)
	end)
	self.SoulResultPool = UIObjectPool.New(5, function()
		local cell = LotteryResultSoulCell.New(UnityEngine.Object.Instantiate(self.SoulPrefab), mainCanvas)

		return cell
	end, function(cell)
		local cellView = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(cellView)
	end)

	UGUIUtil.SetTextInChildren(self.QuitBtn, LotteryUIApi:GetString("RewardShowQuitBtnText"))
	UGUIUtil.SetTextInChildren(self.ContinueBtn, LotteryUIApi:GetString("RewardShowContinueBtnText"))
	UGUIUtil.SetText(self.BaseRewardLabelText, LotteryUIApi:GetString("BaseRewardLabelText"))
end

function m:OnAddListeners()
	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated + self.DelegateOnTapGesture

	self.QuitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickQuitBtn)
	self.OpenAllBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickOpenAllBtn)
	self.ContinueBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickContinueBtn)
end

function m:OnRemoveListeners()
	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated - self.DelegateOnTapGesture

	self.QuitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickQuitBtn)
	self.OpenAllBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickOpenAllBtn)
	self.ContinueBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickContinueBtn)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.OpenAllStartTime ~= 0 and UnityEngine.Time.time - self.OpenAllStartTime > m.OPEN_BOX_DURATION and not self.OpeningDetailPanel then
		if self.OpenBoxDataQueue.Size > 0 then
			self.OpenAllStartTime = UnityEngine.Time.time

			local data = self.OpenBoxDataQueue:Dequeue()

			if not self:OpenBox(data.targetBox, data.index) then
				self.OpenAllStartTime = UnityEngine.Time.time - m.OPEN_BOX_DURATION
			end
		else
			self.OpenAllStartTime = 0
		end
	end
end

function m:OnRootUIClose()
	self:Clear()
end

function m:Show(userData)
	self.View:SetActive(true)
	self:RefreshOrder()

	self.BaseReward = userData.base
	self.RewardList = userData.list
	self.LotteryShowCid = userData.lotteryShowCid
	self.LotteryCid = userData.lotteryCid
	self.SoulMap = {}

	local soulCidRecord = {}

	for i = 1, #self.RewardList do
		local itemShowPOD = self.RewardList[i]
		local cfgItemData = CfgItemTable[itemShowPOD.cid]
		local isSoulItem, soulCid = ItemModule.IsSoulItem(cfgItemData)

		if isSoulItem then
			local soulData = SoulModule.GetSoulData(soulCid)
			local alreadyGot = soulCidRecord[soulCid] ~= nil or soulData ~= nil and soulData.isUnlock

			soulCidRecord[soulCid] = soulCid
			self.SoulMap[i] = {
				soulCid = soulCid,
				alreadyGot = alreadyGot
			}
		end
	end

	self.IsSimulateDraw = userData.isSimulateDraw
	self.SimulateDrawCallback = userData.simulateDrawCallback

	local showOpenAllBtn = not self.IsSimulateDraw and not userData.isSkip

	self.OpenAllBtn:SetActive(showOpenAllBtn)

	if showOpenAllBtn then
		UGUIUtil.SetTextInChildren(self.OpenAllBtn, LotteryUIApi:GetString("RewardShowOpenAllBtnText", #self.RewardList == 1))
	end

	local hasBaseReward = self.BaseReward ~= nil and #self.BaseReward == 1

	self.BaseRewardIcon:SetActive(hasBaseReward)
	self.BaseRewardNumText:SetActive(hasBaseReward)

	if self.BaseReward ~= nil and #self.BaseReward >= 1 then
		if #self.BaseReward > 1 then
			logError("不支持固定奖励种类 > 1。")

			return
		end

		local baseItemShowPOD = self.BaseReward[1]
		local cfgItemData = CfgItemTable[baseItemShowPOD.cid]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.BaseRewardIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.BaseRewardNumText, LotteryUIApi:GetString("BaseRewardNumText", baseItemShowPOD.num))
	end

	local lotteryShowPOD = LotteryModule.GetLotteryShowPOD(self.LotteryShowCid)
	local cfgLotteryShowData = CfgLotteryShowTable[self.LotteryShowCid]

	self.ContinueBtn:SetActive(cfgLotteryShowData.Limit == 0 or lotteryShowPOD.drawCount < cfgLotteryShowData.Limit)
	self:Clear()

	if userData.isSkip then
		self:OpenBoxesDirectly()
	else
		self:FlyBoxes()
	end
end

function m:RefreshOrder()
	local canvas = self.View:GetComponentInParent(typeof(UnityEngine.Canvas))

	for i = 1, #self.SingleBoxes do
		local box = self.SingleBoxes[i]

		box:SetOrder(canvas.sortingOrder)
	end

	for i = 1, #self.MultipleBoxes do
		local box = self.MultipleBoxes[i]

		box:SetOrder(canvas.sortingOrder)
	end
end

function m:OpenBoxesDirectly()
	if #self.RewardList == 1 then
		self.SingleNode:SetActive(true)

		local index = math.random(1, 3)
		local box = self.SingleBoxes[index]
		local itemShowPOD = self.RewardList[1]
		local cfgItemData = CfgItemTable[itemShowPOD.cid]

		box:SetData(cfgItemData)
		self:OpenBox(box, 1, true)
	else
		self.MultipleNode:SetActive(true)

		for i = 1, #self.RewardList do
			local box = self.MultipleBoxes[i]
			local itemShowPOD = self.RewardList[i]
			local cfgItemData = CfgItemTable[itemShowPOD.cid]

			box:SetData(cfgItemData)
			self:OpenBox(box, i, true)
		end
	end

	self:OnFlyComplete()
	self.StepBoxBtnPanel:SetActive(false)
end

function m:FlyBoxes()
	local delayTime = Constant.Lottery.UIBoxFlyDuration
	local singleDelay = 0.1

	if #self.RewardList == 1 then
		self.SingleNode:SetActive(true)

		local index = math.random(1, 3)
		local box = self.SingleBoxes[index]
		local itemShowPOD = self.RewardList[1]
		local cfgItemData = CfgItemTable[itemShowPOD.cid]

		box:PlayEffect(cfgItemData)
	else
		self.MultipleNode:SetActive(true)

		for i = 1, #self.RewardList do
			local box = self.MultipleBoxes[i]
			local itemShowPOD = self.RewardList[i]
			local cfgItemData = CfgItemTable[itemShowPOD.cid]

			if i == 1 then
				box:PlayEffect(cfgItemData)
			else
				local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.LotteryUI, function()
					box:PlayEffect(cfgItemData)
				end, (i - 1) * singleDelay)

				timer:Start()
			end
		end

		delayTime = delayTime + (#self.RewardList - 1) * singleDelay
	end

	local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.LotteryUI, function()
		self:OnFlyComplete()
	end, delayTime)

	timer:Start()
end

function m:OnFlyComplete()
	self.ShowBoxComplete = true

	self.StepBoxBtnPanel:SetActive(true)

	if self.SimulateDrawCallback ~= nil then
		self.SimulateDrawCallback()

		self.SimulateDrawCallback = nil
	end
end

function m:Clear()
	self.ShowBoxComplete = false
	self.OpenAllStartTime = 0

	for i = 1, #self.ResultBgEffectPlayIds do
		local effectPlayId = self.ResultBgEffectPlayIds[i]

		GameEntry.Effect:StopEffect(effectPlayId)
	end

	self.ResultBgEffectPlayIds = {}

	self.SingleNode:SetActive(false)
	self.MultipleNode:SetActive(false)
	self.StepBoxBtnPanel:SetActive(false)
	self.StepResultBtnPanel:SetActive(false)

	for i = 1, #self.SingleBoxes do
		local box = self.SingleBoxes[i]

		box:Clear()
	end

	for i = 1, #self.MultipleBoxes do
		local box = self.MultipleBoxes[i]

		box:Clear()
	end

	self:ClearResults()
end

function m:ClearResults(isDestroy)
	for i = 1, #self.ItemResults do
		local cell = self.ItemResults[i]

		if not isDestroy then
			cell.View.transform:SetParent(self.Host.UIController.transform, false)
		end

		cell.View:SetActive(false)
		self.ItemResultPool:Release(cell)
	end

	self.ItemResults = {}

	for i = 1, #self.SoulResults do
		local cell = self.SoulResults[i]

		if not isDestroy then
			cell.View.transform:SetParent(self.Host.UIController.transform, false)
		end

		cell.View:SetActive(false)
		self.SoulResultPool:Release(cell)
	end

	self.SoulResults = {}
end

function m:Hide()
	self:Clear()
	self.View:SetActive(false)
end

function m:OnTapGesture(gesture)
	if not self.ShowBoxComplete then
		return
	end

	if self.IsSimulateDraw then
		return
	end

	if gesture.State ~= DigitalRubyShared.GestureRecognizerState.Ended then
		return
	end

	local canvas = self.Host.UIController:GetComponent("Canvas")
	local hits = LuaCodeInterface.RaycastAll(canvas.worldCamera:ScreenToWorldPoint(Vector3(gesture.FocusX, gesture.FocusY, 0)), Vector2.zero)
	local foundTargetBox = false
	local hits_DebugStr = ""

	for i = 0, hits.Length - 1 do
		local hit = hits[i]

		hits_DebugStr = hits_DebugStr .. hit.collider.gameObject.transform:GetTransformPath() .. "\n"

		if hit.collider ~= nil then
			local targetBox
			local index = 0
			local boxes

			if #self.RewardList == 1 then
				boxes = self.SingleBoxes
			else
				boxes = self.MultipleBoxes
			end

			for j = 1, #boxes do
				local box = boxes[j]

				if box.BoxEffectNode == hit.collider.gameObject then
					targetBox = box
					index = j

					break
				end
			end

			if targetBox ~= nil then
				foundTargetBox = true

				if #self.RewardList == 1 then
					index = 1
				end

				self:ClickBox(targetBox, index)

				break
			end
		end
	end

	if hits.Length > 0 and not foundTargetBox then
		warning("祈愿错误：在列表里找不到点击的那个碰撞盒。点击的碰撞盒路径：\n" .. hits_DebugStr)
	end
end

function m:ClickBox(targetBox, index)
	if self.OpenAllStartTime ~= 0 then
		return
	end

	self:OpenBox(targetBox, index)
end

function m:OpenBox(targetBox, index, isSkip)
	if targetBox:IsOpened() then
		return false
	end

	targetBox:Open(function()
		self:ShowReward(index, isSkip)

		if isSkip then
			self:CheckOpenFinished()
		else
			local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.LotteryUI, function()
				self:CheckOpenFinished()
			end, m.OPEN_BOX_DURATION)

			timer:Start()
		end
	end)

	return true
end

function m:ShowReward(index, isSkip)
	local itemShowPOD = self.RewardList[index]
	local cfgItemData = CfgItemTable[itemShowPOD.cid]
	local soulCid, isNew, cell, openPanelName
	local data = self.SoulMap[index]

	if data ~= nil then
		soulCid = data.soulCid
		isNew = not data.alreadyGot
		cell = self.SoulResultPool:Obtain()

		cell.View:SetActive(true)
		cell:SetData(soulCid, isNew)
		table.insert(self.SoulResults, cell)

		if not isSkip then
			openPanelName = LotteryPanelName.SoulShow
		end

		LotteryModule.ShowOneSoulComplete()
	else
		isNew = itemShowPOD.tag == 1

		if cfgItemData.Type == Constant.ItemType.Item or cfgItemData.Type == Constant.ItemType.Equip then
			cell = self.ItemResultPool:Obtain()

			cell.View:SetActive(true)
			cell:SetData(cfgItemData, itemShowPOD.num, isNew)
			table.insert(self.ItemResults, cell)

			if not isSkip and cfgItemData.Type == Constant.ItemType.Equip and (isNew or cfgItemData.Quality > 3) then
				openPanelName = LotteryPanelName.EquipShow
			end
		else
			logError("道具既不是灵魂也不是灵魂碎片也不是装备：" .. cfgItemData.Id)
		end
	end

	local resultNode

	if #self.RewardList == 1 then
		resultNode = self.SingleResultNode
	else
		resultNode = self.ResultNodes[index]
	end

	cell.View.transform:SetParent(resultNode.transform, false)

	cell.View.transform.anchoredPosition = Vector2.zero

	local canvas = resultNode:GetComponentInParent(typeof(UnityEngine.Canvas))

	table.insert(self.ResultBgEffectPlayIds, GameEntry.Effect:PlayUIEffect(LotteryUIApi:GetString("ResultItemBgEffect", cfgItemData.Quality), resultNode.transform.position, canvas.sortingOrder - 1))

	self.OpeningDetailPanel = openPanelName ~= nil

	if openPanelName ~= nil then
		self.Host:ShowPanel(openPanelName, {
			cfgItemData = cfgItemData,
			soulCid = soulCid,
			isNew = isNew,
			onClose = function()
				self.OpeningDetailPanel = false

				if self.OpenBoxDataQueue ~= nil and self.OpenBoxDataQueue.Size > 0 then
					self.OpenAllStartTime = UnityEngine.Time.time
				end
			end
		})
	end
end

function m:CheckOpenFinished()
	local openedNum = 0
	local boxes

	if #self.RewardList == 1 then
		boxes = self.SingleBoxes
	else
		boxes = self.MultipleBoxes
	end

	for i = 1, #boxes do
		local box = boxes[i]

		if box:IsOpened() then
			openedNum = openedNum + 1
		end
	end

	if openedNum == #self.RewardList then
		self.StepBoxBtnPanel:SetActive(false)
		self.StepResultBtnPanel:SetActive(true)

		self.OpenAllStartTime = 0

		LotteryModule.DrawComplete()
	end
end

function m:OnClickQuitBtn()
	self.Host:ShowPanel(LotteryPanelName.MainUI, nil, true)
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseLotteryRewardShowUI")
end

function m:OnClickOpenAllBtn()
	self.StepBoxBtnPanel:SetActive(false)

	self.OpenAllStartTime = UnityEngine.Time.time - m.OPEN_BOX_DURATION
	self.OpenBoxDataQueue = Queue.New()

	if #self.RewardList == 1 then
		for i = 1, #self.SingleBoxes do
			local box = self.SingleBoxes[i]

			if box.CfgItemData ~= nil then
				self.OpenBoxDataQueue:Enqueue({
					index = 1,
					targetBox = box
				})

				break
			end
		end
	else
		for i = 1, #self.MultipleBoxes do
			local box = self.MultipleBoxes[i]

			if box.CfgItemData ~= nil then
				self.OpenBoxDataQueue:Enqueue({
					targetBox = box,
					index = i
				})
			else
				logError("开启多个箱子时出错，箱子CfgItemData==nil。 Box: " .. tableToString(box))
			end
		end
	end
end

function m:OnClickContinueBtn()
	LotteryModule.Draw(CfgLotteryShowTable[self.LotteryShowCid], CfgLotteryTable[self.LotteryCid])
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.SingleBoxes do
		local box = self.SingleBoxes[i]

		box:Dispose()
	end

	for i = 1, #self.MultipleBoxes do
		local box = self.MultipleBoxes[i]

		box:Dispose()
	end

	self:ClearResults(true)
	self.ItemResultPool:Dispose()
	self.SoulResultPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
