-- chunkname: @IQIGame\\UI\\SummerActivity\\SummerActivityStageUI_detailPanel.lua

local SummerActivityStageUI_detailPanel = {}
local multipleBtnDataName = "multipleStartBtn"
local multipleBtnStateName_enabled = "enabled"
local multipleBtnStateName_unEnabled = "unEnabled"

function SummerActivityStageUI_detailPanel.New(go, mainView)
	local o = Clone(SummerActivityStageUI_detailPanel)

	o:Initialize(go, mainView)

	return o
end

function SummerActivityStageUI_detailPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.ItemList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function SummerActivityStageUI_detailPanel:InitComponent()
	self.wrapContent = self.ItemScroll:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end
end

function SummerActivityStageUI_detailPanel:InitDelegate()
	function self.delegateOnClickCloseButton()
		self:Hide()
	end

	function self.DelegateOnEnterGameBtnClick()
		self:OnEnterGameBtnClick()
	end

	function self.delegateOnClickButtonRestart()
		self:OnClickButtonRestart()
	end

	function self.delegateOnClickMultipleStartBtn()
		self:OnClickMultipleStartBtn()
	end

	function self.DelegateOnGmBtnClick()
		self:OnGmBtnClick()
	end
end

function SummerActivityStageUI_detailPanel:AddListener()
	self.CloseButton:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseButton)
	self.StartButton:GetComponent("Button").onClick:AddListener(self.DelegateOnEnterGameBtnClick)
	self.ButtonRestart:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonRestart)
	self.multipleStartBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickMultipleStartBtn)
	self.GmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnGmBtnClick)
end

function SummerActivityStageUI_detailPanel:RemoveListener()
	self.CloseButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseButton)
	self.StartButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnEnterGameBtnClick)
	self.ButtonRestart:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonRestart)
	self.multipleStartBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickMultipleStartBtn)
	self.GmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnGmBtnClick)
end

function SummerActivityStageUI_detailPanel:OnGmBtnClick()
	if not IQIGame.Onigao.Game.Device.isMobile then
		local CChatPOD = {}

		CChatPOD.channel = 3
		CChatPOD.type = 1
		CChatPOD.target = ""
		CChatPOD.content = "/cmd finishDup 5 " .. self.cfgWorldMapItem.Id

		net_centerChat.sendChat(CChatPOD)
	end

	self:Hide()
end

function SummerActivityStageUI_detailPanel:OnClickMultipleStartBtn()
	if not self.enableMultipleFight then
		return
	end

	local playerPower = WarehouseModule.GetItemNumByCfgID(self.cfgWorldMapItem.PassCost[1])
	local maxFightCount, _ = math.modf(playerPower / self.cfgWorldMapItem.PassCost[2])

	if maxFightCount < 1 then
		NoticeModule.ShowNotice(20006)

		return
	end

	self.mainView.multipleFightPopupView:Show(self.chapterType, self.cfgWorldMapItem, nil)
end

function SummerActivityStageUI_detailPanel:OnClickButtonRestart()
	if WarehouseModule.GetPlayerStrengthNum() < self.NeedPower then
		NoticeModule.ShowNotice(20006)

		return
	end

	if self.cfgWorldMapItem.PlotID and self.cfgWorldMapItem.PlotID ~= 0 then
		local enterDupData = {}

		enterDupData.ChapterType = self.chapterType
		enterDupData.PassId = self.cfgWorldMapItem.Id

		GameChapterModule.EnterDupByChapterType(enterDupData)
		StoryModule.SetStoryRestartWhenNext()
	else
		local userData = {}

		userData.OpenType = 2
		userData.ChapterType = self.chapterType
		userData.StageId = self.cfgWorldMapItem.Id

		UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
	end

	self:Hide()
end

function SummerActivityStageUI_detailPanel:OnEnterGameBtnClick()
	if WarehouseModule.GetPlayerStrengthNum() < self.NeedPower then
		NoticeModule.ShowNotice(20006)

		return
	end

	if self.cfgWorldMapItem.PlotID and self.cfgWorldMapItem.PlotID ~= 0 then
		local enterDupData = {}

		enterDupData.ChapterType = self.chapterType
		enterDupData.PassId = self.cfgWorldMapItem.Id

		GameChapterModule.EnterDupByChapterType(enterDupData)
	else
		local userData = {}

		userData.OpenType = 2
		userData.ChapterType = self.chapterType
		userData.StageId = self.cfgWorldMapItem.Id

		UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
	end

	self:Hide()
end

function SummerActivityStageUI_detailPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function SummerActivityStageUI_detailPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function SummerActivityStageUI_detailPanel:OnRenderItem(cell)
	local rawItemData = self.ItemDatas[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.ItemList[instanceId]

	if itemCell == nil then
		itemCell = ItemCell.New(cell.gameObject)
		self.ItemList[instanceId] = itemCell
	end

	if rawItemData ~= nil then
		itemCell:SetItemByCid(rawItemData.itemID, rawItemData.num)
		itemCell:SetTag(rawItemData.tag)
		itemCell:SetItemNumShow(rawItemData.num)
	end
end

function SummerActivityStageUI_detailPanel:Refresh(Data, chapterType)
	self.worldMapItemId = Data
	self.chapterType = chapterType
	self.cfgWorldMapItem = CfgUtil.GetCfgWorldMapItemDataWithID(self.worldMapItemId)

	if not self.cfgWorldMapItem then
		return
	end

	LuaUtility.SetText(self.StageNameText, self.cfgWorldMapItem.Name)
	LuaUtility.SetText(self.StageDescriptionText, self.cfgWorldMapItem.Desc)
	LuaUtility.SetText(self.levelTipsNumText, self.cfgWorldMapItem.RecommendLevel)
	LuaUtility.SetText(self.stageTypeText, ChapterStageMapUIApi:GetStageTypeText(self.cfgWorldMapItem.IsFight))

	local stageCost = self.cfgWorldMapItem.PassCost[2] or 0
	local enterCost = self.cfgWorldMapItem.EnterCost[2] or 0

	self.NeedPower = stageCost + enterCost

	LuaUtility.SetText(self.CostText, tostring(-self.NeedPower))

	local itemID = self.cfgWorldMapItem.PassCost[1] or self.cfgWorldMapItem.EnterCost[1]

	if itemID then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[itemID].SmallIcon), self.CostIconImage:GetComponent(typeof(UnityEngine.UI.Image)))
	end

	AssetUtil.LoadImage(self, ChapterStageMapUIApi:GetStageDetailsTypeImage(self.cfgWorldMapItem.IsFight), self.stageTypeImg:GetComponent(typeof(UnityEngine.UI.Image)))
	AssetUtil.LoadImage(self, ChapterStageMapUIApi:GetMarkImagePath(self.cfgWorldMapItem.IconPath), self.stageSignImg:GetComponent("Image"))

	self.ItemDatas = {}

	local dropItems = StoryChapterModule.GetDropItems(self.cfgWorldMapItem.Id)

	for _, dropItem in pairs(dropItems) do
		local data = CfgUtil.GetDropAwardListWithID(dropItem.dropID)
		local len = #data

		for i = 1, len do
			table.insert(self.ItemDatas, data[i])
		end
	end

	self.wrapContent:Refresh(#self.ItemDatas)
	LuaUtility.SetGameObjectShow(self.StartGamePanel, not (self.cfgWorldMapItem.PlotID > 0) or not StoryChapterModule.GetStageIsCompleteWithID(self.cfgWorldMapItem.Id))
	LuaUtility.SetGameObjectShow(self.ButtonRestart, self.cfgWorldMapItem.PlotID > 0 and not StoryChapterModule.GetStageIsCompleteWithID(self.cfgWorldMapItem.Id))
	LuaUtility.SetGameObjectShow(self.multipleStartBtn, self.cfgWorldMapItem.PlotID == 0)

	self.enableMultipleFight = ConditionModule.Check(self.cfgWorldMapItem.ContinuousCondition)

	if self.enableMultipleFight then
		LuaUtility.SetStateController(self.gameObject, multipleBtnDataName, multipleBtnStateName_enabled)
	else
		LuaUtility.SetStateController(self.gameObject, multipleBtnDataName, multipleBtnStateName_unEnabled)
	end

	LuaUtility.SetGameObjectShow(self.challengeLimitRoot, false)

	if self.cfgWorldMapItem.ChallengeCount > 0 then
		LuaUtility.SetGameObjectShow(self.challengeLimitRoot, true)
		LuaUtility.SetText(self.textChallengeNum, string.format(CfgUtil.GetCfgTipsTextWithID(113001), math.max(0, self.cfgWorldMapItem.ChallengeCount - StoryChapterModule.GetStageChallengeCount(self.cfgWorldMapItem.Id))))
	end

	local funcList = {}

	funcList[Constant.UnlockType.FUNC_GM_TOOL] = self.GmBtn

	UnlockFunctionModule.FuncSwitchHandler(funcList)
end

function SummerActivityStageUI_detailPanel:OnDestroy()
	self:RemoveListener()

	for _, v in pairs(self.ItemList) do
		v:Dispose()
	end

	self.ItemList = {}

	AssetUtil.UnloadAsset(self)

	self.wrapContent.onRenderCell = nil
	self.wrapContent = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return SummerActivityStageUI_detailPanel
