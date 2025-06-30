-- chunkname: @IQIGame\\UI\\Activity\\MagicWaxMuseum\\MagicWaxMuseumView.lua

local m = {
	EntityId = 0,
	isSet = false,
	bossLevelCellPool = {},
	WordTipCells = {},
	magicWaxMuseumGroupList = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MagicWaxMuseumBossLevelCell = require("IQIGame.UI.Activity.MagicWaxMuseum.MagicWaxMuseumBossLevelCell")
local MagicWaxMuseumWordCell = require("IQIGame.UI.Activity.MagicWaxMuseum.MagicWaxMuseumWordCell")

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

	local sortComponents = self.Spine:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = self.root.UIController.gameObject:GetComponent("Canvas")
	end

	local sortComponentsButton = self.Button:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))

	for i = 0, sortComponentsButton.Length - 1 do
		sortComponentsButton[i].UIRootCanvas = self.root.UIController.gameObject:GetComponent("Canvas")
	end

	UGUIUtil.SetText(self.TextBtnIntroduction, ActivityUIApi:GetString("TextBtnIntroduction"))
	UGUIUtil.SetText(self.TextTodayWords, ActivityUIApi:GetString("TextTodayWords"))
	UGUIUtil.SetText(self.TextDes, ActivityUIApi:GetString("TextDes"))
	UGUIUtil.SetText(self.TextBtnEnter, ActivityUIApi:GetString("TextBtnEnter"))

	self.scrollListPage = self.ScrollPage:GetComponent("ScrollAreaListPage")

	function self.scrollListPage.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollListPage.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.delegateBtnIntroduction()
		self:OnBtnIntroduction()
	end

	function self.delegateBtnEnter()
		self:OnBtnEnter()
	end

	function self.delegateUpdateOperations()
		self:UpDateView()
	end

	self.WordModule:SetActive(false)

	self.WordTipPool = UIObjectPool.New(4, function()
		local cell = MagicWaxMuseumWordCell.New(UnityEngine.Object.Instantiate(self.WordModule))

		return cell
	end, function(cell)
		cell:Dispose()

		local v = cell.View

		UnityEngine.Object.Destroy(v)
	end)
end

function m.GetPreloadAssetPaths()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

function m:AddListener()
	self.BtnIntroduction:GetComponent("Button").onClick:AddListener(self.delegateBtnIntroduction)
	self.BtnEnter:GetComponent("Button").onClick:AddListener(self.delegateBtnEnter)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:RemoveListener()
	self.BtnIntroduction:GetComponent("Button").onClick:RemoveListener(self.delegateBtnIntroduction)
	self.BtnEnter:GetComponent("Button").onClick:RemoveListener(self.delegateBtnEnter)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:UpDateView()
	if ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

		if self.eventPOD then
			self.cfgMagicWaxMuseumGlobal = CfgMagicWaxMuseumGlobalTable[self.eventPOD.dataCfgId]
			self.magicWaxMuseumGroupList = {}

			local bossIds = ActiveMagicWaxMuseumModule.GetMagicWaxMuseumBossList(self.operateEventID)

			for i, v in pairs(bossIds) do
				local tab = CfgMagicWaxMuseumListTable[v]

				table.insert(self.magicWaxMuseumGroupList, tab)
			end

			table.sort(self.magicWaxMuseumGroupList, function(a, b)
				return a.BossLevel < b.BossLevel
			end)

			local startIndex = 1

			for i = 1, #self.magicWaxMuseumGroupList do
				local cfg = self.magicWaxMuseumGroupList[i]
				local killed = ActiveMagicWaxMuseumModule.GetMagicWaxMuseumBossKillState(self.operateEventID, cfg.Id)

				if not killed then
					startIndex = i

					break
				end
			end

			self.scrollListPage.startIndex = startIndex - 1

			self.scrollListPage:Refresh(#self.magicWaxMuseumGroupList)
			UGUIUtil.SetText(self.TextOpenTime, ActivityUIApi:GetString("TextOpenTime", getCustomDateTimeText(self.eventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(self.eventPOD.endTime, "MonthToMinuteFormat")))
			self.Spine:SetActive(not ActiveMagicWaxMuseumModule.isFight)
		end
	end
end

function m:OnRenderCell(cell)
	local cfgData = self.magicWaxMuseumGroupList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local bossLevelCell = self.bossLevelCellPool[instanceID]

	if bossLevelCell == nil then
		bossLevelCell = MagicWaxMuseumBossLevelCell.New(cell.gameObject)
		self.bossLevelCellPool[instanceID] = bossLevelCell
	end

	bossLevelCell:SetData(cfgData, self.operateEventID)
	bossLevelCell:SetSelect(false)
end

function m:OnPageReachedMain(page)
	self.currentTabIndex = page.index + 1

	self:ShowSelect()
end

function m:ShowSelect()
	local selectCfg = self.magicWaxMuseumGroupList[self.currentTabIndex]

	for i, v in pairs(self.bossLevelCellPool) do
		if v.cfgMagicWaxMuseumListData.Id == selectCfg.Id then
			self.selectBoss = selectCfg

			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end

	if self.selectBoss then
		for i, v in pairs(self.WordTipCells) do
			v.View.transform:SetParent(self.root.UIController.transform, false)
			v.View:SetActive(false)
			self.WordTipPool:Release(v)
		end

		self.WordTipCells = {}

		for i = 1, #self.selectBoss.AffixList do
			local id = self.selectBoss.AffixList[i]
			local cfgData = CfgSkillSpecialEffectExplainTable[id]
			local cell = self.WordTipPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.WordBox.transform, false)
			cell:SetData(cfgData)
			table.insert(self.WordTipCells, cell)
		end

		self:ShowMonster(self.selectBoss.MonsterSpine)
	end
end

function m:ShowMonster(elementEntityCid)
	if self.lastMonsterSpine ~= elementEntityCid then
		self.lastMonsterSpine = elementEntityCid

		self:HideEntity()

		self.EntityId = GameEntry.Entity:GenerateEntityID()

		GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.Spine.transform, Vector3.zero)
	end
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
		self.lastMonsterSpine = nil
	end
end

function m:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(self.selectBoss.ShowUiSize, self.selectBoss.ShowUiSize, self.selectBoss.ShowUiSize)
		args.Entity.gameObject.transform.localPosition = Vector3(self.selectBoss.ShowUiPosition[1], self.selectBoss.ShowUiPosition[2], self.selectBoss.ShowUiPosition[3])

		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")
	end
end

function m:OnBtnIntroduction()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.cfgMagicWaxMuseumGlobal.Desc)
end

function m:OnBtnEnter()
	UIModule.Open(Constant.UIControllerName.TimeLimitedBossUI, Constant.UILayer.UI, {
		self.magicWaxMuseumGroupList,
		self.currentTabIndex,
		self.operateEventID
	})
end

function m:Open()
	self.lastMonsterSpine = nil

	self:AddListener()
	self.View:SetActive(true)
	self:UpDateView()
	ActiveMagicWaxMuseumModule.SaveOpenMagicWaxMuseumPrefs(self.operateEventID)
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	self:HideEntity()
	self:RemoveListener()
end

function m:OnDestroy()
	for i, v in pairs(self.bossLevelCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.WordTipCells) do
		self.WordTipPool:Release(v)
	end

	self.WordTipCells = {}

	self.WordTipPool:Dispose()
	self:HideEntity()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
