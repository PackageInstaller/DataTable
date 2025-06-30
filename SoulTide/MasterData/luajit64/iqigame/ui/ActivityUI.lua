-- chunkname: @IQIGame\\UI\\ActivityUI.lua

local ActivityUI = Base:Extend("ActivityUI", "IQIGame.Onigao.UI.ActivityUI", {
	id2Views = {},
	showedViewIds = {},
	openOperationEvent = {}
})
local ActivityFoodView = require("IQIGame.UI.Activity.Food.ActivityFoodView")
local ActivityTurnView = require("IQIGame.UI.Activity.Turn.ActivityTurnView")
local MoonLoginView = require("IQIGame.UI.Activity.Moon.MoonLogin.MoonLoginView")
local MoonTipView = require("IQIGame.UI.Activity.Moon.MoonTipView")
local NationalDayView = require("IQIGame.UI.Activity.NationalDay.NationalDayView")
local ActiveGroupBuyView = require("IQIGame.UI.Activity.GroupBuy.ActiveGroupBuyView")
local ActivityPicturePuzzleView = require("IQIGame.UI.Activity.PicturePuzzle.ActivityPicturePuzzleView")
local MagicWaxMuseumView = require("IQIGame.UI.Activity.MagicWaxMuseum.MagicWaxMuseumView")
local ActiveNewCharacterView = require("IQIGame.UI.Activity.NewCharacter.ActiveNewCharacterView")
local ActivityGachaPoolView = require("IQIGame.UI.Activity.GachaPool.ActivityGachaPoolView")
local ActivitySignView = require("IQIGame.UI.Activity.Sign.ActivitySignView")
local PaidChallengeView = require("IQIGame.UI.Activity.PaidChallenge.PaidChallengeView")
local InvasionView = require("IQIGame.UI.Activity.DoubleFight.InvasionView")
local SpaceTreasureView = require("IQIGame.UI.Activity.SpaceTreasure.SpaceTreasureView")
local FurnitureGashaponView = require("IQIGame.UI.Activity.FurnitureGashapon.FurnitureGashaponView")
local ActiveLuckyTurnTableView = require("IQIGame.UI.Activity.LuckyTurnTable.ActiveLuckyTurnTableView")
local ActivePandaView = require("IQIGame.UI.Activity.Panda.ActivePandaView")
local ActiveVoteView = require("IQIGame.UI.Activity.Vote.ActiveVoteView")
local ReplacementPassView = require("IQIGame.UI.Activity.ReplacementPass.ReplacementPassView")
local ActiveNewYearGiftView = require("IQIGame.UI.Activity.NewYearGift.ActiveNewYearGiftView")
local ActivityPureExhibitionView = require("IQIGame.UI.Activity.PureExhibition.ActivityPureExhibitionView")
local DropExchangeView = require("IQIGame.UI.Activity.DropExchange.DropExchangeView")
local LimitedTurnView = require("IQIGame.UI.Activity.LimitedTurn.LimitedTurnView")
local ActivityFreeRewardView = require("IQIGame.UI.Activity.FreeReward.ActivityFreeRewardView")
local CupVotingView = require("IQIGame.UI.Activity.CupVoting.CupVotingView")

function ActivityUI:OnInit()
	self:Initialize()
end

function ActivityUI:GetOpenPreloadAssetPaths(userData)
	return self:GetPreloadPathOnOpen()
end

function ActivityUI:GetPreloadAssetPaths()
	local paths = {}

	table.addAll(paths, ActivityFoodView.GetPreloadAssetPaths())

	return paths
end

function ActivityUI:OnOpen(userData)
	self:Refresh(userData)
end

function ActivityUI:OnClose(userData)
	self:OnHide()
end

function ActivityUI:OnPause()
	return
end

function ActivityUI:OnResume()
	return
end

function ActivityUI:OnCover()
	return
end

function ActivityUI:OnReveal()
	return
end

function ActivityUI:OnRefocus(userData)
	return
end

function ActivityUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.curViewId ~= nil and self.id2Views[self.curViewId].Update ~= nil then
		self.id2Views[self.curViewId]:Update(elapseSeconds, realElapseSeconds)
	end

	if self.moonDateState ~= 3 then
		self.duration = self.duration + elapseSeconds

		if self.duration > 1 then
			self.duration = 0

			if self.moonDateState == 1 then
				self.moonDateState = ActiveModule.GetMoonDateState()

				if self.moonDateState == 2 then
					self:RefreshTabsDynamic()
				end
			elseif self.moonDateState == 2 then
				self.moonDateState = ActiveModule.GetMoonDateState()

				if self.moonDateState == 3 then
					self:RefreshTabsDynamic()
				end
			end
		end
	end

	if self.nationalDayDateState ~= 3 then
		self.nationalDayDuration = self.nationalDayDuration + elapseSeconds

		if self.nationalDayDuration > 1 then
			self.nationalDayDuration = 0

			if self.nationalDayDateState == 1 then
				self.nationalDayDateState = ActiveModule.GetNationalDayDateState()

				if self.nationalDayDateState == 2 then
					self:RefreshTabsDynamic()
				end
			elseif self.nationalDayDateState == 2 then
				self.nationalDayDateState = ActiveModule.GetNationalDayDateState()

				if self.nationalDayDateState == 3 then
					self:RefreshTabsDynamic()
				end
			end
		end
	end
end

function ActivityUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActivityUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivityUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivityUI:GetPreloadPathOnOpen()
	local ret = {}
	local openOperationEvent = ActiveOperationEventModule.GetOpenOperationEvent()

	for i = 1, #openOperationEvent do
		local id = openOperationEvent[i]
		local tab = CfgOperateEventsControlTable[id]

		if tab.Type == Constant.Activity_Operation_Type.Activity_NewCharacter then
			local eventPOD = ActiveOperationEventModule.GetActiveOperationData(id)

			if eventPOD then
				local cfgNewCharacterActivity = CfgNewCharacterActivityTable[eventPOD.dataCfgId]
				local cfgNpcActionData = NPCActionModule.GetAction(cfgNewCharacterActivity.NPCAction, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.Standby, getDateTimeTable(PlayerModule.GetServerTime()).hour)

				table.insert(ret, UIGlobalApi.GetPrefabRoot(cfgNpcActionData.NPC))
			end
		end
	end

	return ret
end

function ActivityUI:Initialize()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.moneyCellBuilder = MoneyCellsBuilder.New(self.goMoneyParent)
	self.energyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.scrollTab = self.goScrollTab:GetComponent("ScrollAreaList")

	function self.scrollTab.onSelectedCell(cell)
		self:OnSelectedTab(cell)
	end

	function self.scrollTab.onRenderCell(cell)
		self:OnRenderTab(cell)
	end

	function self.DelegateOnUpdateDailySupply()
		self:OnUpdateDailySupply()
	end

	function self.onUpdateTurnDelegate()
		self:OnUpdateTurn()
	end

	function self.onTaskUpdateDelegate(id)
		self:OnTaskUpdate(id)
	end

	function self.onTaskCommitResponseDelegate(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end

	function self.delegateUpdateOperations()
		self:RefreshTabsDynamic()
	end

	function self.onUpdateItemDelegate()
		self:OnUpdateItem()
	end

	function self.onUpdateMagicWaxMuseumRedPointDelegate()
		self:OnUpdateMagicWaxMuseumRedPoint()
	end

	function self.onUpdateDoubleFightRedPointDelegate()
		self:OnUpdateDoubleFightRedPoint()
	end

	function self.delegateUpdateLuckyTurnRedPoint()
		self:OnUpdateLuckyTurnRedPoint()
	end

	function self.delegateUpdateMall()
		self:OnUpdateMall()
	end

	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = ActivityUIApi:GetString("goTitle")
end

function ActivityUI:Refresh(userData)
	self.defaultViewId = userData
	self.curViewId = nil
	self.duration = 0
	self.nationalDayDuration = 0
	self.hasClose = false

	self:RefreshTabs()
end

function ActivityUI:Reset()
	self:Refresh()
end

function ActivityUI:OnHide()
	for i, v in pairs(self.id2Views) do
		v:OnHide()
	end

	self.hasClose = true
end

function ActivityUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.moneyCellBuilder:Dispose()
	self.energyCell:Dispose()

	for i, v in pairs(self.id2Views) do
		v:OnDestroy()
	end
end

function ActivityUI:RefreshMoney()
	local isBuyGroup = false
	local isNewCharacter = false
	local isFurnitureLottery = false
	local isLuckyTurnTable = self.curViewId == Constant.Activity_ID.LuckyTurntable
	local isPanda = false
	local isVote = false
	local isDropExchange = false
	local isLimitedTurn = false
	local isFreeReward = false
	local isCupVoting = false

	if table.indexOf(self.openOperationEvent, self.curViewId) ~= -1 then
		local tab = CfgOperateEventsControlTable[self.curViewId]

		if tab.Type == Constant.Activity_Operation_Type.Activity_GroupBuy then
			isBuyGroup = true
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_NewCharacter then
			isNewCharacter = true
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_FurnitureGashapon then
			isFurnitureLottery = true
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_Panda then
			isPanda = true
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_Vote then
			isVote = true
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_DropExchange then
			isDropExchange = true
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_Limited_Turn then
			isLimitedTurn = true
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_Free_Reward then
			isFreeReward = true
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_Cup_Voting then
			isCupVoting = true
		end
	end

	self.EnergyCom:SetActive(true)

	self.EnergyCom.transform.parent.anchoredPosition = Vector2.New(-15, self.EnergyCom.transform.parent.anchoredPosition.y)

	if isBuyGroup then
		self.moneyCellBuilder:RefreshView({
			Constant.ItemID.MONEY,
			Constant.ItemID.TREASURE,
			Constant.ItemID.ID_PAYPOINT_SHOW
		})
	elseif isNewCharacter then
		local cfgNewCharacterData = CfgNewCharacterActivityTable[ActiveOperationEventModule.GetEventDataPOD(self.curViewId).dataCfgId]
		local costID = cfgNewCharacterData.CardID

		self.moneyCellBuilder:RefreshView({
			costID
		})
	elseif isFurnitureLottery then
		local cfgFurLotteryData = CfgFurnitureActivityLotteryGlobalTable[ActiveOperationEventModule.GetEventDataPOD(self.curViewId).dataCfgId]
		local costCids = {}

		costCids[1] = cfgFurLotteryData.Cost1[1]

		if cfgFurLotteryData.Cost10[1] ~= costCids[1] then
			costCids[2] = cfgFurLotteryData.Cost10[1]
		end

		table.insert(costCids, 1, Constant.ItemID.TREASURE)
		table.insert(costCids, 1, Constant.ItemID.MONEY)
		self.moneyCellBuilder:RefreshView(costCids)
		self.EnergyCom:SetActive(false)

		self.EnergyCom.transform.parent.anchoredPosition = Vector2.New(214, self.EnergyCom.transform.parent.anchoredPosition.y)
	elseif isLuckyTurnTable then
		self.moneyCellBuilder:RefreshView({
			Constant.ItemID.MONEY,
			Constant.ItemID.TREASURE,
			ActiveLuckyTurnTableModule.LUCKY_TURNTABLE_MONEY
		})
		self.EnergyCom:SetActive(false)

		self.EnergyCom.transform.parent.anchoredPosition = Vector2.New(214, self.EnergyCom.transform.parent.anchoredPosition.y)
	elseif isPanda then
		local costCids = ActivePandaModule.GetCostCidTab(self.curViewId)

		self.moneyCellBuilder:RefreshView(costCids)
		self.EnergyCom:SetActive(false)

		self.EnergyCom.transform.parent.anchoredPosition = Vector2.New(214, self.EnergyCom.transform.parent.anchoredPosition.y)
	elseif isVote then
		self.moneyCellBuilder:RefreshView({
			Constant.ItemID.PANDA_VOTE
		})
		self.EnergyCom:SetActive(false)

		self.EnergyCom.transform.parent.anchoredPosition = Vector2.New(214, self.EnergyCom.transform.parent.anchoredPosition.y)
	elseif isDropExchange then
		local cfgDropExchangeGlobData = CfgDropExchangeActivitiesGlobalTable[ActiveOperationEventModule.GetActiveOperationData(self.curViewId).dataCfgId]
		local costCids = {}

		for i = 1, #cfgDropExchangeGlobData.GetItem, 2 do
			local itemID = cfgDropExchangeGlobData.GetItem[i]

			if itemID > 0 then
				table.insert(costCids, itemID)
			end
		end

		self.moneyCellBuilder:RefreshView(costCids)
		self.EnergyCom:SetActive(false)

		self.EnergyCom.transform.parent.anchoredPosition = Vector2.New(214, self.EnergyCom.transform.parent.anchoredPosition.y)
	elseif isLimitedTurn then
		local haveNum, needNum, needItem = ActiveLimitedTurnModule.GetCostItemNum(self.curViewId)

		self.moneyCellBuilder:RefreshView({
			needItem
		})
		self.EnergyCom:SetActive(false)

		self.EnergyCom.transform.parent.anchoredPosition = Vector2.New(214, self.EnergyCom.transform.parent.anchoredPosition.y)
	elseif isFreeReward then
		self.moneyCellBuilder:RefreshView({})
		self.EnergyCom:SetActive(false)
	elseif isCupVoting then
		self.moneyCellBuilder:RefreshView({})
		self.EnergyCom:SetActive(false)
	else
		self.moneyCellBuilder:RefreshView({
			Constant.ItemID.MONEY,
			Constant.ItemID.TREASURE
		})
	end
end

function ActivityUI:RefreshTabs()
	self:RefreshTabListDatum()

	local startIndex = 1

	if self.defaultViewId ~= nil then
		for i, v in ipairs(self.showedViewIds) do
			if v == self.defaultViewId then
				startIndex = i

				break
			end
		end
	end

	self.scrollTab.defaultSelectedToggle = startIndex - 1

	self.scrollTab:Refresh(#self.showedViewIds)
end

function ActivityUI:RefreshTabsDynamic()
	self:RefreshTabListDatum()

	local startIndex = 1

	for i, v in ipairs(self.showedViewIds) do
		if self.curViewId == v then
			startIndex = i

			break
		end
	end

	self.scrollTab.defaultSelectedToggle = startIndex - 1

	self.scrollTab:RenderCellsDynamic(#self.showedViewIds)
end

function ActivityUI:RefreshTabListDatum()
	self.showedViewIds = {}

	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.ACTIVITY_FOOD) then
		self.showedViewIds[#self.showedViewIds + 1] = Constant.Activity_ID.Food
	end

	self.moonDateState = ActiveModule.GetMoonDateState()

	if self.moonDateState == 2 then
		self.showedViewIds[#self.showedViewIds + 1] = Constant.Activity_ID.MoonLogin
		self.showedViewIds[#self.showedViewIds + 1] = Constant.Activity_ID.MoonTip
	end

	self.nationalDayDateState = ActiveModule.GetNationalDayDateState()

	if self.nationalDayDateState == 2 then
		self.showedViewIds[#self.showedViewIds + 1] = Constant.Activity_ID.NationalDay
	end

	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.ACTIVITY_LUCKY_TURN) then
		self.showedViewIds[#self.showedViewIds + 1] = Constant.Activity_ID.LuckyTurntable
	end

	if #ReplacementPassModule.GetDataList() > 0 then
		self.showedViewIds[#self.showedViewIds + 1] = Constant.Activity_ID.ReplacementPass
	end

	self.openOperationEvent = ActiveOperationEventModule.GetOpenOperationEvent()

	if #self.openOperationEvent then
		for i = 1, #self.openOperationEvent do
			local eventID = self.openOperationEvent[i]

			if CfgOperateEventsControlTable[eventID].Type ~= Constant.Activity_Operation_Type.Activity_WelcomeNew then
				self.showedViewIds[#self.showedViewIds + 1] = eventID
			end
		end
	end
end

function ActivityUI:ShowTabView(viewId)
	if self.curViewId == viewId then
		return
	end

	if self.id2Views[viewId] == nil then
		self:AddNewView(viewId)

		return
	end

	self.curViewId = viewId

	for i, v in pairs(self.id2Views) do
		if i == viewId then
			v:Open()
			self:RefreshMoney()
		else
			v:Close()
		end
	end
end

function ActivityUI:AddNewView(viewId)
	local goView

	if viewId == Constant.Activity_ID.Food then
		goView = self.goFoodView
	elseif viewId == Constant.Activity_ID.Turn then
		self:LoadView(viewId)
	elseif viewId == Constant.Activity_ID.MoonLogin then
		self:LoadView(viewId)
	elseif viewId == Constant.Activity_ID.NationalDay then
		self:LoadView(viewId)
	elseif viewId == Constant.Activity_ID.MoonTip then
		self:LoadView(viewId)
	elseif viewId == Constant.Activity_ID.LuckyTurntable then
		self:LoadView(viewId)
	elseif viewId == Constant.Activity_ID.ReplacementPass then
		self:LoadView(viewId)
	elseif table.indexOf(self.openOperationEvent, viewId) ~= -1 then
		self:LoadView(viewId)
	end

	if goView ~= nil then
		self:CreateView(viewId, goView)
	end
end

function ActivityUI:CreateView(viewId, goView)
	if viewId == Constant.Activity_ID.Food then
		self.id2Views[Constant.Activity_ID.Food] = ActivityFoodView.New(self.goFoodView, self.UIController)
	elseif viewId == Constant.Activity_ID.NationalDay then
		self.id2Views[Constant.Activity_ID.NationalDay] = NationalDayView.New(goView)
	elseif viewId == Constant.Activity_ID.MoonLogin then
		self.id2Views[Constant.Activity_ID.MoonLogin] = MoonLoginView.New(goView)
	elseif viewId == Constant.Activity_ID.MoonTip then
		self.id2Views[Constant.Activity_ID.MoonTip] = MoonTipView.New(goView)
	elseif viewId == Constant.Activity_ID.LuckyTurntable then
		self.id2Views[Constant.Activity_ID.LuckyTurntable] = ActiveLuckyTurnTableView.New(goView, self)
	elseif viewId == Constant.Activity_ID.ReplacementPass then
		self.id2Views[Constant.Activity_ID.ReplacementPass] = ReplacementPassView.New(goView, self)
	elseif table.indexOf(self.openOperationEvent, viewId) ~= -1 then
		local eventsControlData = CfgOperateEventsControlTable[viewId]

		if eventsControlData.Type == Constant.Activity_Operation_Type.Activity_GroupBuy then
			self.id2Views[viewId] = ActiveGroupBuyView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_PicturePuzzle then
			self.id2Views[viewId] = ActivityPicturePuzzleView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_MagicWaxMuseum then
			self.id2Views[viewId] = MagicWaxMuseumView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_NewCharacter then
			self.id2Views[viewId] = ActiveNewCharacterView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Sign then
			self.id2Views[viewId] = ActivitySignView.New(goView, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Paid_Challenge then
			self.id2Views[viewId] = PaidChallengeView.New(goView, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_FurnitureGashapon then
			self.id2Views[viewId] = FurnitureGashaponView.New(goView, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_GachaPool then
			self.id2Views[viewId] = ActivityGachaPoolView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_AlienInvasion then
			self.id2Views[viewId] = InvasionView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_SpaceTreasure then
			self.id2Views[viewId] = SpaceTreasureView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Panda then
			self.id2Views[viewId] = ActivePandaView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Vote then
			self.id2Views[viewId] = ActiveVoteView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_NewYear_Gift then
			self.id2Views[viewId] = ActiveNewYearGiftView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_PureExhibition then
			self.id2Views[viewId] = ActivityPureExhibitionView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_DropExchange then
			self.id2Views[viewId] = DropExchangeView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Turn then
			self.id2Views[viewId] = ActivityTurnView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Limited_Turn then
			self.id2Views[viewId] = LimitedTurnView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Free_Reward then
			self.id2Views[viewId] = ActivityFreeRewardView.New(goView, self, viewId)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Cup_Voting then
			self.id2Views[viewId] = CupVotingView.New(goView, self, viewId)
		end
	end

	self:ShowTabView(viewId)
end

function ActivityUI:LoadView(viewID)
	local path = self:GetViewPath(viewID)

	AssetUtil.LoadAsset(self, path, self.OnLoadViewSuccess, nil, viewID)
end

function ActivityUI:GetViewPath(viewID)
	local path = ActivityUIApi:GetString("viewPath", viewID)

	if table.indexOf(self.openOperationEvent, viewID) ~= -1 then
		local eventsControlData = CfgOperateEventsControlTable[viewID]
		local eventPOD = ActiveOperationEventModule.GetActiveOperationData(viewID)

		if eventsControlData.Type == Constant.Activity_Operation_Type.Activity_GroupBuy then
			local cfgGroupBuyGlobal = CfgGroupBuyGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgGroupBuyGlobal.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_PicturePuzzle then
			local cfgPuzzlesGlobal = CfgPuzzlesGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgPuzzlesGlobal.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_MagicWaxMuseum then
			local cfgPuzzlesGlobal = CfgMagicWaxMuseumGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgPuzzlesGlobal.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_NewCharacter then
			local cfgNewCharacterActivity = CfgNewCharacterActivityTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgNewCharacterActivity.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Sign then
			local cfgEventSignInGlobalData = CfgEventSignInGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgEventSignInGlobalData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Paid_Challenge then
			local cfgPaidChallengeGlobalData = CfgPaidChallengeGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgPaidChallengeGlobalData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_FurnitureGashapon then
			local cfgFurnitureData = CfgFurnitureActivityLotteryGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgFurnitureData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_GachaPool then
			local cfgGachaPoolGlobalData = CfgGachaPoolGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgGachaPoolGlobalData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_AlienInvasion then
			local cfgDoubleFightGlobalData = CfgDoubleFightGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgDoubleFightGlobalData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_SpaceTreasure then
			local cfgSpaceTreasureGlobalData = CfgSpaceTreasureGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgSpaceTreasureGlobalData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Panda then
			local cfgPandaActivityGlobalData = CfgPandaActivityGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgPandaActivityGlobalData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Vote then
			local cfgVoteGlobalData = CfgVoteGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgVoteGlobalData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_NewYear_Gift then
			local cfgNewYearGiftGlobalData = CfgTreasureHuntGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgNewYearGiftGlobalData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_PureExhibition then
			local cfgGlobalData = CfgPureExhibitionActivitiesGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgGlobalData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_DropExchange then
			local cfgDropExchangeGlobalData = CfgDropExchangeActivitiesGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgDropExchangeGlobalData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Turn then
			local cfgTurnGlobalData = CfgActiveTurntableGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgTurnGlobalData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Limited_Turn then
			local cfgLimitedTurntableGlobalData = CfgLimitedTurntableGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgLimitedTurntableGlobalData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Free_Reward then
			local cfgTreasureQuestGlobalData = CfgTreasureQuestGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgTreasureQuestGlobalData.BackGround)
		elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Cup_Voting then
			local cfgCupMatchVoteGlobalData = CfgCupMatchVoteGlobalTable[eventPOD.dataCfgId]

			path = UIGlobalApi.GetPrefabRoot(cfgCupMatchVoteGlobalData.BackGround)
		end
	end

	return path
end

function ActivityUI:CheckRedPoint(viewID)
	if viewID == Constant.Activity_ID.Food then
		return PlayerModule.HasFreeDailySupply()
	elseif viewID == Constant.Activity_ID.MoonLogin then
		return ActiveModule.CheckRedPointOnMoon()
	elseif viewID == Constant.Activity_ID.NationalDay then
		return ActiveModule.CheckRedPointOnNationalDay()
	elseif viewID == Constant.Activity_ID.Turn then
		return ActivityTurnModule.CheckRedPoint()
	elseif viewID == Constant.Activity_ID.LuckyTurntable then
		return ActiveLuckyTurnTableModule.CheckLuckyTurnTableRedPoint()
	elseif viewID == Constant.Activity_ID.ReplacementPass then
		return ReplacementPassModule.CheckReplacementPassRedPoint()
	elseif table.indexOf(self.openOperationEvent, viewID) ~= -1 then
		local tab = CfgOperateEventsControlTable[viewID]

		if tab.Type == Constant.Activity_Operation_Type.Activity_PicturePuzzle then
			return ActivePicturePuzzleModule.CheckRedPoint(viewID)
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_NewCharacter then
			return ActiveNewCharacterModule.CheckNewCharacterRedPoint(viewID)
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_MagicWaxMuseum then
			return ActiveMagicWaxMuseumModule.CheckMagicWaxMuseumRedPoint(viewID)
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_Sign then
			return ActivitySignModule.CheckRedPoint(viewID)
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_Paid_Challenge then
			return PaidChallengeModule.CheckRedPoint(viewID)
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_FurnitureGashapon then
			return FurnitureGashaponModule.CheckRedPoint(viewID)
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_SpaceTreasure then
			return ActiveSpaceTreasureModule.CheckSpaceTreasureRedPoint(viewID)
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_AlienInvasion then
			return ActiveDoubleFightModule.CheckDoubleFightRedPoint(viewID)
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_Panda then
			return ActivePandaModule.CheckPandaRedPoint(viewID)
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_Vote then
			return ActiveVoteModule.CheckVoteRedPoint(viewID)
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_NewYear_Gift then
			return ActiveNewYearGiftModule.CheckNewYearGiftRedPoint(viewID)
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_GachaPool then
			return ActiveGachaModule.ShowRedPoint()
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_Turn then
			return ActivityTurnModule.CheckRedPoint(viewID)
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_Limited_Turn then
			return ActiveLimitedTurnModule.CheckLimitedTurnRedPoint(viewID)
		elseif tab.Type == Constant.Activity_Operation_Type.Activity_Cup_Voting then
			return ActiveCupVotingModule.CheckCupVotingRedPoint(viewID)
		end
	end

	return false
end

function ActivityUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.UpdateDailySupply, self.DelegateOnUpdateDailySupply)
	EventDispatcher.AddEventListener(EventID.TurnResultEvent, self.onUpdateTurnDelegate)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.onUpdateItemDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateMagicWaxMuseumRedPoint, self.onUpdateMagicWaxMuseumRedPointDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateDoubleFightRedPoint, self.onUpdateDoubleFightRedPointDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateLuckyTurnRedPoint, self.delegateUpdateLuckyTurnRedPoint)
	EventDispatcher.AddEventListener(EventID.UpdateMall, self.delegateUpdateMall)
end

function ActivityUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailySupply, self.DelegateOnUpdateDailySupply)
	EventDispatcher.RemoveEventListener(EventID.TurnResultEvent, self.onUpdateTurnDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.onUpdateItemDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateMagicWaxMuseumRedPoint, self.onUpdateMagicWaxMuseumRedPointDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateDoubleFightRedPoint, self.onUpdateDoubleFightRedPointDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateLuckyTurnRedPoint, self.delegateUpdateLuckyTurnRedPoint)
	EventDispatcher.RemoveEventListener(EventID.UpdateMall, self.delegateUpdateMall)
end

function ActivityUI:OnUpdateMall()
	self:RefreshTabsDynamic()
end

function ActivityUI:OnUpdateDailySupply()
	self.scrollTab:RenderCells()
end

function ActivityUI:OnUpdateTurn()
	self.scrollTab:RenderCells()
end

function ActivityUI:OnTaskUpdate(id)
	self.scrollTab:RenderCells()

	if self.curViewId ~= nil and self.id2Views[self.curViewId].OnTaskUpdate ~= nil then
		self.id2Views[self.curViewId]:OnTaskUpdate(id)
	end
end

function ActivityUI:OnUpdateItem()
	self.scrollTab:RenderCells()

	if self.id2Views[self.curViewId].OnItemUpdate ~= nil then
		self.id2Views[self.curViewId]:OnItemUpdate()
	end
end

function ActivityUI:OnUpdateMagicWaxMuseumRedPoint()
	self.scrollTab:RenderCells()

	if self.id2Views[self.curViewId].OnItemUpdate ~= nil then
		self.id2Views[self.curViewId]:OnItemUpdate()
	end
end

function ActivityUI:OnUpdateDoubleFightRedPoint()
	self.scrollTab:RenderCells()

	if self.id2Views[self.curViewId].OnItemUpdate ~= nil then
		self.id2Views[self.curViewId]:OnItemUpdate()
	end
end

function ActivityUI:OnUpdateLuckyTurnRedPoint()
	self.scrollTab:RenderCells()

	if self.id2Views[self.curViewId].OnItemUpdate ~= nil then
		self.id2Views[self.curViewId]:OnItemUpdate()
	end
end

function ActivityUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function ActivityUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.ActivityUI)
end

function ActivityUI:OnRenderTab(cell)
	local luaIndex = cell.index + 1
	local viewId = self.showedViewIds[luaIndex]
	local goRedPoint = cell.transform:Find("goDown/Tag").gameObject
	local goRedPoint2 = cell.transform:Find("goUp/Tag").gameObject
	local tfName = cell.transform:Find("goDown/Text_01"):GetComponent("Text")
	local tfName2 = cell.transform:Find("goUp/Text_01"):GetComponent("Text")
	local tfEngName = cell.transform:Find("goDown/Text_02"):GetComponent("Text")
	local tfEngName2 = cell.transform:Find("goUp/Text_02"):GetComponent("Text")

	if table.indexOf(self.openOperationEvent, viewId) ~= -1 then
		local name = ""
		local eventsControlData = CfgOperateEventsControlTable[viewId]
		local eventPOD = ActiveOperationEventModule.GetActiveOperationData(viewId)

		if eventPOD then
			if eventsControlData.Type == Constant.Activity_Operation_Type.Activity_GroupBuy then
				local cfgGroupBuyGlobal = CfgGroupBuyGlobalTable[eventPOD.dataCfgId]

				name = cfgGroupBuyGlobal.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_PicturePuzzle then
				local cfgPuzzlesGlobal = CfgPuzzlesGlobalTable[eventPOD.dataCfgId]

				name = cfgPuzzlesGlobal.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_MagicWaxMuseum then
				local CfgMagicWaxMuseumGlobal = CfgMagicWaxMuseumGlobalTable[eventPOD.dataCfgId]

				name = CfgMagicWaxMuseumGlobal.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_NewCharacter then
				local cfgNewCharacterActivity = CfgNewCharacterActivityTable[eventPOD.dataCfgId]

				name = cfgNewCharacterActivity.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Sign then
				local cfgEventSignInGlobalData = CfgEventSignInGlobalTable[eventPOD.dataCfgId]

				name = cfgEventSignInGlobalData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Paid_Challenge then
				local cfgPaidChallengeGlobalData = CfgPaidChallengeGlobalTable[eventPOD.dataCfgId]

				name = cfgPaidChallengeGlobalData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_FurnitureGashapon then
				local cfgFurnitureData = CfgFurnitureActivityLotteryGlobalTable[eventPOD.dataCfgId]

				name = cfgFurnitureData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_GachaPool then
				local cfgGachaPoolGlobalData = CfgGachaPoolGlobalTable[eventPOD.dataCfgId]

				name = cfgGachaPoolGlobalData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_AlienInvasion then
				local cfgDoubleFightGlobalData = CfgDoubleFightGlobalTable[eventPOD.dataCfgId]

				name = cfgDoubleFightGlobalData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_SpaceTreasure then
				local cfgSpaceTreasureGlobalData = CfgSpaceTreasureGlobalTable[eventPOD.dataCfgId]

				name = cfgSpaceTreasureGlobalData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Panda then
				local cfgPandaActivityGlobalData = CfgPandaActivityGlobalTable[eventPOD.dataCfgId]

				name = cfgPandaActivityGlobalData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Vote then
				local cfgVoteGlobalData = CfgVoteGlobalTable[eventPOD.dataCfgId]

				name = cfgVoteGlobalData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_NewYear_Gift then
				local cfgNewYearGiftGlobalData = CfgTreasureHuntGlobalTable[eventPOD.dataCfgId]

				name = cfgNewYearGiftGlobalData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_PureExhibition then
				local cfgGlobalData = CfgPureExhibitionActivitiesGlobalTable[eventPOD.dataCfgId]

				name = cfgGlobalData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_DropExchange then
				local cfgDropExchangeGlobalData = CfgDropExchangeActivitiesGlobalTable[eventPOD.dataCfgId]

				name = cfgDropExchangeGlobalData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Turn then
				local cfgTurnGlobalData = CfgActiveTurntableGlobalTable[eventPOD.dataCfgId]

				name = cfgTurnGlobalData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Limited_Turn then
				local cfgLimitedTurntableGlobalData = CfgLimitedTurntableGlobalTable[eventPOD.dataCfgId]

				name = cfgLimitedTurntableGlobalData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Free_Reward then
				local cfgTreasureQuestGlobalData = CfgTreasureQuestGlobalTable[eventPOD.dataCfgId]

				name = cfgTreasureQuestGlobalData.Name
			elseif eventsControlData.Type == Constant.Activity_Operation_Type.Activity_Cup_Voting then
				local cfgCupMatchVoteGlobalData = CfgCupMatchVoteGlobalTable[eventPOD.dataCfgId]

				name = cfgCupMatchVoteGlobalData.Name
			end
		end

		tfName2.text = name
		tfName.text = name
	else
		tfName.text = ActivityUIApi:GetString("tabBtn", viewId)
		tfName2.text = tfName.text
	end

	tfEngName.text = ActivityUIApi:GetString("tabEngBtn", viewId)
	tfEngName2.text = tfEngName.text

	local showRedPoint = self:CheckRedPoint(viewId)

	goRedPoint:SetActive(showRedPoint)
	goRedPoint2:SetActive(showRedPoint)
end

function ActivityUI:OnSelectedTab(cell)
	local luaIndex = cell.index + 1
	local viewId = self.showedViewIds[luaIndex]

	self:ShowTabView(viewId)
end

function ActivityUI:OnLoadViewSuccess(assetName, asset, duration, userData)
	if self.hasClose then
		return
	end

	local viewID = userData
	local goView = UnityEngine.Object.Instantiate(asset)

	goView.transform:SetParent(self.viewRoot.transform, false)
	self:CreateView(viewID, goView)
end

return ActivityUI
