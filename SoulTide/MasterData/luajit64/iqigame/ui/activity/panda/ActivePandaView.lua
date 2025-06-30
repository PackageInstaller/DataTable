-- chunkname: @IQIGame\\UI\\Activity\\Panda\\ActivePandaView.lua

local m = {
	EntityId = 0,
	currentScore = 0,
	rewardBoxCells = {},
	rewardCfgDataTab = {},
	pandaSpineCfgActions = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local PandaRewardBoxCell = require("IQIGame.UI.Activity.Panda.PandaRewardBoxCell")

function m.New(view, root, operateEventID)
	local obj = Clone(m)

	obj:Init(view, root, operateEventID)

	return obj
end

function m:Init(view, root, operateEventID)
	self.View = view
	self.root = root
	self.operateEventID = operateEventID

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.BtnFeedLabel, ActivityUIApi:GetString("PandaBtnFeedLabel"))
	UGUIUtil.SetText(self.NeedFeed, ActivityUIApi:GetString("PandaNeed"))
	UGUIUtil.SetText(self.BtnWash, ActivityUIApi:GetString("PandaNeed"))
	UGUIUtil.SetText(self.NeedInteract, ActivityUIApi:GetString("PandaNeed"))
	UGUIUtil.SetText(self.BtnWashLabel, ActivityUIApi:GetString("PandaBtnWashLabel"))
	UGUIUtil.SetText(self.BtnInteractLabel, ActivityUIApi:GetString("PandaBtnInteract"))
	UGUIUtil.SetText(self.BtnExploreLabel, ActivityUIApi:GetString("PandaBtnExploreLabel"))
	UGUIUtil.SetText(self.FavorTitle, ActivityUIApi:GetString("PandaFavorTitle"))
	UGUIUtil.SetText(self.BtnShopLabel, ActivityUIApi:GetString("PandaBtnShopLabel"))
	UGUIUtil.SetText(self.TextMaxTip, ActivityUIApi:GetString("PandaTextMaxTip"))

	function self.delegateUpdateOperations()
		self:OnUpdateOperations()
	end

	function self.delegateBtnFeed()
		self:OnBtnFeed()
	end

	function self.delegateBtnWash()
		self:OnBtnWash()
	end

	function self.delegateBtnInteract()
		self:OnBtnInteract()
	end

	function self.delegateBtnShop()
		self:OnBtnShop()
	end

	function self.delegateBtnExplore()
		self:OnBtnExplore()
	end

	function self.delegateUpdateItem()
		self:RefreshSpendItem()
	end

	function self.delegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.delegateFavorIncreaseTxtTween()
		self:OnFinishTxtFavorTween()
	end

	function self.delegateUpdatePandaActionEvent()
		self:OnUpdatePandaActionEvent()
	end

	self.goProgressCell:SetActive(false)

	self.rewardBoxCellPool = UIObjectPool.New(5, function()
		return PandaRewardBoxCell.New(UnityEngine.Object.Instantiate(self.goProgressCell), self.root)
	end, function(cell)
		cell:Dispose()
	end)

	UIUtil.InitSortedComponents(self.root.UIController:GetComponent("Canvas"), self.View)

	self.tweenAlpha = self.UpGrade:GetComponent("TweenAlpha")
end

function m.GetPreloadAssetPaths()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

function m:AddListener()
	self.BtnFeed:GetComponent("Button").onClick:AddListener(self.delegateBtnFeed)
	self.BtnWash:GetComponent("Button").onClick:AddListener(self.delegateBtnWash)
	self.BtnInteract:GetComponent("Button").onClick:AddListener(self.delegateBtnInteract)
	self.BtnShop:GetComponent("Button").onClick:AddListener(self.delegateBtnShop)
	self.BtnExplore:GetComponent("Button").onClick:AddListener(self.delegateBtnExplore)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.delegateUpdateItem)
	EventDispatcher.AddEventListener(EventID.UpdatePandaActionEvent, self.delegateUpdatePandaActionEvent)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function m:RemoveListener()
	self.BtnFeed:GetComponent("Button").onClick:RemoveListener(self.delegateBtnFeed)
	self.BtnWash:GetComponent("Button").onClick:RemoveListener(self.delegateBtnWash)
	self.BtnInteract:GetComponent("Button").onClick:RemoveListener(self.delegateBtnInteract)
	self.BtnShop:GetComponent("Button").onClick:RemoveListener(self.delegateBtnShop)
	self.BtnExplore:GetComponent("Button").onClick:RemoveListener(self.delegateBtnExplore)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.delegateUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.UpdatePandaActionEvent, self.delegateUpdatePandaActionEvent)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function m:OnUpdateOperations()
	self:UpDateView()
end

function m:OnUpdatePandaActionEvent()
	self:UpDateView()
end

function m:ShowUpGrade(addFavor)
	self.UpGrade:SetActive(true)
	UGUIUtil.SetText(self.TextUpGrade, ActivityUIApi:GetString("PandaTextUpGrade", addFavor))
	self.tweenAlpha:ResetToBeginning()

	self.tweenAlpha.enabled = true

	self.tweenAlpha:SetOnFinished(self.delegateFavorIncreaseTxtTween)
end

function m:OnFinishTxtFavorTween()
	self.tweenAlpha:RemoveOnFinished(self.delegateFavorIncreaseTxtTween)

	self.tweenAlpha.enabled = false

	self.UpGrade:SetActive(false)
end

function m:OnBtnFeed()
	if self.cfgPandaActivityGlobalData then
		local spendID = self.cfgPandaActivityGlobalData.FeedingNeeds[1]
		local needNum = self.cfgPandaActivityGlobalData.FeedingNeeds[2]
		local have = WarehouseModule.GetItemNumByCfgID(spendID)

		if have < needNum then
			NoticeModule.ShowNotice(21052002)

			return
		end

		ActivePandaModule.Action(1, function(actionType, addFavor)
			local cfgAction = self:GetActionByName("eat")

			self:PlayAnimation(cfgAction)
			self:ShowUpGrade(addFavor)
			self:UpDateView()
		end)
	end
end

function m:OnBtnWash()
	if self.cfgPandaActivityGlobalData then
		local spendID = self.cfgPandaActivityGlobalData.BathingNeeds[1]
		local needNum = self.cfgPandaActivityGlobalData.BathingNeeds[2]
		local have = WarehouseModule.GetItemNumByCfgID(spendID)

		if have < needNum then
			NoticeModule.ShowNotice(21052002)

			return
		end

		ActivePandaModule.Action(2, function(actionType, addFavor)
			local cfgAction = self:GetActionByName("wash")

			self:PlayAnimation(cfgAction)
			self:ShowUpGrade(addFavor)
			self:UpDateView()
		end)
	end
end

function m:OnBtnInteract()
	if self.cfgPandaActivityGlobalData then
		local spendID = self.cfgPandaActivityGlobalData.PlayNeeds[1]
		local needNum = self.cfgPandaActivityGlobalData.PlayNeeds[2]
		local have = WarehouseModule.GetItemNumByCfgID(spendID)

		if have < needNum then
			NoticeModule.ShowNotice(21052002)

			return
		end

		ActivePandaModule.Action(3, function(actionType, addFavor)
			local tab = {}

			for i = 1, 3 do
				local cfgAction = self:GetActionByName("homeInsert0" .. i)

				if cfgAction then
					table.insert(tab, cfgAction)
				end
			end

			local randomIndex = math.random(1, #tab)
			local randomAction = tab[randomIndex]

			self:PlayAnimation(randomAction)
			self:ShowUpGrade(addFavor)
			self:UpDateView()
		end)
	end
end

function m:OnBtnShop()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.Panda)
end

function m:OnBtnExplore()
	ActivePandaModule.EnterBambooForest(self.cfgPandaActivityGlobalData.Id, self.operateEventID)
end

function m:UpDateView()
	self.pandaSpineCfgActions = {}

	if ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

		if self.eventPOD then
			local pandaDataPOD = ActivePandaModule.GetPandaPOD(self.operateEventID)

			if pandaDataPOD then
				self.currentScore = pandaDataPOD.maxFavorNum
			end

			self.cfgPandaActivityGlobalData = CfgPandaActivityGlobalTable[self.eventPOD.dataCfgId]
			self.rewardCfgDataTab = {}

			for i, v in pairsCfg(CfgPandaGiftListTable) do
				if v.Team == self.eventPOD.dataCfgId then
					table.insert(self.rewardCfgDataTab, v)
				end
			end

			table.sort(self.rewardCfgDataTab, function(a, b)
				return a.FavorNum < b.FavorNum
			end)

			for i, v in pairsCfg(CfgPandaActionListTable) do
				if v.PandaSpine == self.cfgPandaActivityGlobalData.PandaSpine then
					table.insert(self.pandaSpineCfgActions, v)
				end
			end

			self:ShowPanda(self.cfgPandaActivityGlobalData.PandaSpine)
			UGUIUtil.SetText(self.FavorValue, self.currentScore)
			UGUIUtil.SetText(self.OpenTime, ActivityUIApi:GetString("PandaOpenTime", getCustomDateTimeText(self.eventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(self.eventPOD.endTime, "MonthToMinuteFormat")))

			for i, v in pairs(self.rewardBoxCells) do
				v.View.transform:SetParent(self.root.UIController.transform, false)
				v.View:SetActive(false)
				self.rewardBoxCellPool:Release(v)
			end

			self.rewardBoxCells = {}

			local maxScore = 0

			for i = 1, #self.rewardCfgDataTab do
				local cell = self.rewardBoxCellPool:Obtain()

				cell.View:SetActive(true)
				cell.View.transform:SetParent(self.RewardBox.transform, false)
				cell:SetData(self.operateEventID, i, self.rewardCfgDataTab[i])
				table.insert(self.rewardBoxCells, cell)

				if maxScore < cell.cfgGiftData.FavorNum then
					maxScore = cell.cfgGiftData.FavorNum
				end
			end

			local per = self.currentScore / maxScore

			self.goBarProgress:GetComponent("Image").fillAmount = per

			self:RefreshSpendItem()
			self.TextMaxTip:SetActive(maxScore <= self.currentScore)
		end
	end
end

function m:RefreshSpendItem()
	if self.cfgPandaActivityGlobalData then
		local id, num

		if #self.cfgPandaActivityGlobalData.FeedingNeeds > 0 then
			id = self.cfgPandaActivityGlobalData.FeedingNeeds[1]
			num = self.cfgPandaActivityGlobalData.FeedingNeeds[2]

			UGUIUtil.SetText(self.NeedFeedValue, ActivityUIApi:GetString("PandaNeedValue", CfgItemTable[id].Name, num))
		else
			UGUIUtil.SetText(self.NeedFeedValue, "")
		end

		if #self.cfgPandaActivityGlobalData.BathingNeeds > 0 then
			id = self.cfgPandaActivityGlobalData.BathingNeeds[1]
			num = self.cfgPandaActivityGlobalData.BathingNeeds[2]

			UGUIUtil.SetText(self.NeedWashValue, ActivityUIApi:GetString("PandaNeedValue", CfgItemTable[id].Name, num))
		else
			UGUIUtil.SetText(self.NeedWashValue, "")
		end

		if #self.cfgPandaActivityGlobalData.PlayNeeds > 0 then
			id = self.cfgPandaActivityGlobalData.PlayNeeds[1]
			num = self.cfgPandaActivityGlobalData.PlayNeeds[2]

			UGUIUtil.SetText(self.NeedInteractValue, ActivityUIApi:GetString("PandaNeedValue", CfgItemTable[id].Name, num))
		else
			UGUIUtil.SetText(self.NeedInteractValue, "")
		end
	end
end

function m:ShowPanda(elementEntityCid)
	if self.lastPandaSpine ~= elementEntityCid then
		self.lastPandaSpine = elementEntityCid

		self:HideEntity()

		self.EntityId = GameEntry.Entity:GenerateEntityID()

		GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.PandaPoint.transform, Vector3.zero)
	elseif self.animation then
		local newSize = self:GetCurrentScore()

		if newSize ~= self.lastSize then
			self.lastSize = newSize
			self.animation.gameObject.transform.parent.localScale = Vector3(self.lastSize.Size, self.lastSize.Size, self.lastSize.Size)
		end
	end
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
		self.lastPandaSpine = nil
		self.animation = nil
	end
end

function m:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		self.lastSize = self:GetCurrentScore()
		args.Entity.gameObject.transform.localScale = Vector3(self.lastSize.Size, self.lastSize.Size, self.lastSize.Size)
		self.animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if self.animation ~= nil then
			local cfgData = self:GetRandomAction()

			self:PlayAnimation(cfgData)
		end

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")

		local SpineRenderer = args.Entity.gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer))

		SpineRenderer.sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Default")
	end
end

function m:PlayAnimation(cfgPandaAction)
	if self.animation and cfgPandaAction then
		if self.delayTime then
			self.delayTime:Stop()

			self.delayTime = nil
		end

		self.delayTime = Timer.New(function()
			local cfgData = self:GetRandomAction()

			self:PlayAnimation(cfgData)
		end, cfgPandaAction.CountDown)

		self.delayTime:Start()
		self.animation.state:SetAnimation(0, cfgPandaAction.PandaAction, true)
	end
end

function m:GetRandomAction()
	local weightCfgData = {}
	local totalWeight = 0

	for i, v in pairs(self.pandaSpineCfgActions) do
		if v.AutoAction then
			weightCfgData[#weightCfgData + 1] = v
			totalWeight = totalWeight + v.Weight
		end
	end

	local compareWeight = math.random(1, totalWeight)
	local curTotal = 0

	for i, v in pairs(weightCfgData) do
		curTotal = curTotal + v.Weight

		if compareWeight <= curTotal then
			return v
		end
	end

	return weightCfgData[1]
end

function m:GetActionByName(actionName)
	for i, v in pairs(self.pandaSpineCfgActions) do
		if v.PandaAction == actionName then
			return v
		end
	end

	return nil
end

function m:GetCurrentScore()
	local score = self.currentScore

	for i = 1, #self.rewardCfgDataTab do
		local data = self.rewardCfgDataTab[i]

		if score <= data.FavorNum then
			return data
		end
	end

	return self.rewardCfgDataTab[#self.rewardCfgDataTab]
end

function m:Open()
	self.UpGrade:SetActive(false)
	self:AddListener()
	self.View:SetActive(true)
	self:UpDateView()

	ActivePandaModule.currentOperateEventID = self.operateEventID

	EventDispatcher.Dispatch(EventID.StopBGM)

	self.playSound = GameEntry.Sound:PlaySound(416, Constant.SoundGroup.UI)
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	self:HideEntity()

	self.lastPandaSpine = nil
	self.animation = nil

	self:RemoveListener()

	if self.playSound > 0 then
		GameEntry.Sound:StopSound(self.playSound)

		self.playSound = 0
	end

	EventDispatcher.Dispatch(EventID.RestoreBGM)
end

function m:OnDestroy()
	for i, v in pairs(self.rewardBoxCells) do
		self.rewardBoxCellPool:Release(v)
	end

	self.rewardBoxCells = {}

	self.rewardBoxCellPool:Dispose()
	self:HideEntity()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
