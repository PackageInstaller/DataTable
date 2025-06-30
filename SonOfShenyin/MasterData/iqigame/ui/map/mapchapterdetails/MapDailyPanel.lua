-- chunkname: @IQIGame\\UI\\Map\\MapChapterDetails\\MapDailyPanel.lua

local m = {
	isPlayingAnim = false,
	ItemList = {},
	ConditionItems = {}
}
local mainLineConditionItemCell = require("IQIGame.UI.Map.ItemCell.MainLineConditionItemCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnCloseBtnClick()
		self:OnCloseBtnClick()
	end

	function self.DelegateOnEnterGameBtnClick()
		self:OnEnterGameBtnClick()
	end

	function self.DelegateOnStartStageLevel(plotStageDupPOD)
		return
	end

	function self.DelegateOnUnlockFunctionUpdateEvent()
		self:OnRefreshUnlockBtn()
	end

	function self.DelegateOnClickRewardDetalisBtn()
		self:OnClickRewardDetailsBtn()
	end

	function self.DelegateOnGmBtnClick()
		self:OnGmBtnClick()
	end

	self.wrapContent = self.ItemScroll:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	self:InitStaticText()
end

function m:InitStaticText()
	UGUIUtil.SetText(self.levelTipsTitle, ChapterStageMapUIApi:GetLevelTipsTitle())
	UGUIUtil.SetText(self.levelTipsNumText, ChapterStageMapUIApi:GetHeroTipsTitle())
	UGUIUtil.SetText(self.LvTitle, ChapterStageMapUIApi:GetLvText())
end

function m:AddListeners()
	self.CloseButton:GetComponent("Button").onClick:AddListener(self.DelegateOnCloseBtnClick)
	self.StartButton:GetComponent("Button").onClick:AddListener(self.DelegateOnEnterGameBtnClick)
	self.GmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnGmBtnClick)
	self.rewardDetailsBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRewardDetalisBtn)
	EventDispatcher.AddEventListener(EventID.StartStageLevel, self.DelegateOnStartStageLevel)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.DelegateOnUnlockFunctionUpdateEvent)
end

function m:RemoveListeners()
	self.CloseButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseBtnClick)
	self.StartButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnEnterGameBtnClick)
	self.GmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnGmBtnClick)
	self.rewardDetailsBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRewardDetalisBtn)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.DelegateOnUnlockFunctionUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.StartStageLevel, self.DelegateOnStartStageLevel)
end

function m:SetData(smallId)
	self.StageCfg = MapModule.GetDailyStageCfgBySmallId(smallId)

	if self.StageCfg == nil then
		self:Hide()

		return
	end

	self.StageCid = self.StageCfg.Id

	self:RefreshChapterInfo()
	self:Show()
end

function m:RefreshChapterInfo()
	UGUIUtil.SetText(self.StageNameText, self.StageCfg.Name)
	UGUIUtil.SetText(self.StageDescriptionText, self.StageCfg.Desc)
	UGUIUtil.SetText(self.levelTipsNumText, self.StageCfg.RecommendLevel)
	UGUIUtil.SetText(self.stageTypeText, ChapterStageMapUIApi:GetStageTypeText(self.StageCfg.IsFight))

	local stageCost = self.StageCfg.PassCost[2] or 0
	local enterCost = self.StageCfg.EnterCost[2] or 0

	self.NeedPower = stageCost + enterCost

	UGUIUtil.SetText(self.CostText, tostring(-self.NeedPower))

	local itemID = self.StageCfg.PassCost[1] or self.StageCfg.EnterCost[1]

	if itemID then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[itemID].SmallIcon), self.CostIconImage:GetComponent(typeof(UnityEngine.UI.Image)))
	end

	AssetUtil.LoadImage(self, ChapterStageMapUIApi:GetStageDetailsTypeImage(self.StageCfg.IsFight), self.stageTypeImg:GetComponent(typeof(UnityEngine.UI.Image)))
	AssetUtil.LoadImage(self, ChapterStageMapUIApi:GetMarkImagePath(self.StageCfg.IconPath), self.stageSignImg:GetComponent("Image"))

	self.ItemDatas = {}

	for _, v in pairs(self.StageCfg.FirstReward) do
		local dropLib = CfgDropLibTable[v]

		for index, itemID in pairs(dropLib.GiftItemIds) do
			table.insert(self.ItemDatas, {
				num = dropLib.GiftItemCount[index],
				tag = ItemCell.TagEnum.None,
				itemID = itemID
			})
		end
	end

	self.wrapContent:Refresh(#self.ItemDatas)
end

function m:GetRandomDropItem(dropId)
	local dropLib = CfgDropLibTable[dropId]
	local dandomIds = dropLib.RandomIds

	for index, itemID in pairs(dandomIds) do
		if dropLib.RandomType[index] == 1 then
			self:GetRandomDropItem(itemID)
		else
			table.insert(self.ItemDatas, {
				num = dropLib.RandomCount[index],
				tag = ItemCell.TagEnum.Random,
				itemID = itemID
			})
		end
	end
end

function m:OnEnterGameBtnClick()
	if WarehouseModule.GetPlayerStrengthNum() < self.NeedPower then
		NoticeModule.ShowNotice(20006)

		return
	end

	MapModule.EnterGame(Constant.MapStageType.Challenge, self.StageCfg.Id)
	self:Hide()
end

function m:OnStartStageLevel(plotStageDupPOD)
	self:Hide()
end

function m:OnRenderItem(cell)
	local rawItemData = self.ItemDatas[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.ItemList[instanceId]

	if itemCell == nil then
		itemCell = ItemCell.New(cell.gameObject)
		self.ItemList[instanceId] = itemCell
	end

	local itemData
	local tag = 0

	if rawItemData ~= nil then
		if rawItemData.itemID ~= Constant.ItemCid.NORMAL_MONEY then
			rawItemData.num = 0
		end

		itemData = ItemData.CreateByCIDAndNumber(rawItemData.itemID, rawItemData.num)
		tag = rawItemData.tag

		itemCell:SetItem(itemData)
		itemCell:SetTag(tag)

		if rawItemData.itemID == Constant.ItemCid.NORMAL_MONEY then
			itemCell:SetNum(rawItemData.num)
		end
	end
end

function m:UpdateEnterCondition()
	local conditionResults = ConditionModule.CheckMultiple(self.StageCfg.EnterConditionId)

	self.conditionReslut = ConditionModule.CheckMultipleAllIsPass(conditionResults)

	LuaUtility.SetGameObjectShow(self.ConditionParent, not self.conditionReslut)

	if self.conditionReslut then
		return
	end

	for k, v in pairs(self.ConditionItems) do
		v:Hide()
	end

	for i = 1, #self.StageCfg.EnterConditionId do
		local coditionItem = self.ConditionItems[i]

		if coditionItem == nil then
			local obj = UnityEngine.Object.Instantiate(self.conditionPrefab)

			obj.transform:SetParent(self.EnterConditionDetails.transform, false)

			self.ConditionItems[i] = mainLineConditionItemCell.New(obj)
			coditionItem = self.ConditionItems[i]
		end

		coditionItem:SetData(CfgConditionTable[self.StageCfg.EnterConditionId[i]].Name, conditionResults[i])
		coditionItem:Show()
	end
end

function m:OnCloseBtnClick()
	if self.isPlayingAnim then
		return
	end

	self.isPlayingAnim = true

	CoroutineUtility.StartCoroutine(function()
		UIUtil.PlayOrRewindDefaultAnim(self.View, true)
		CoroutineUtility.Yield(CustomWaitForSeconds(LuaUtility.GetAnimationLengthWithName(self.View, "MainChapterPanel")))
		self:Hide()
	end)
end

function m:Show()
	self.isPlayingAnim = false

	self:AddListeners()
	self:OnRefreshUnlockBtn()
	LuaUtility.SetGameObjectShow(self.View, true)
	UIUtil.PlayOrRewindDefaultAnim(self.View, false)
end

function m:OnRefreshUnlockBtn()
	local funcList = {}

	funcList[Constant.UnlockType.FUNC_GM_TOOL] = self.GmBtn

	UnlockFunctionModule.FuncSwitchHandler(funcList)
end

function m:OnClickRewardDetailsBtn()
	return
end

function m:OnGmBtnClick()
	if not IQIGame.Onigao.Game.Device.isMobile then
		local CChatPOD = {}

		CChatPOD.channel = 3
		CChatPOD.type = 1
		CChatPOD.target = ""
		CChatPOD.content = "/cmd finishDup 8 " .. self.StageCid

		net_centerChat.sendChat(CChatPOD)
	end

	self:Hide()
end

function m:Hide()
	self:RemoveListeners()
	LuaUtility.SetGameObjectShow(self.View, false)
	EventDispatcher.Dispatch(EventID.CloseChapterDetailEvent)
end

function m:Dispose()
	for k, v in pairs(self.ItemList) do
		v:Dispose()
	end

	for k, v in pairs(self.ConditionItems) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
