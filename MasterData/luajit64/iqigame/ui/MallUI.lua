-- chunkname: @IQIGame\\UI\\MallUI.lua

local MallUI = Base:Extend("MallUI", "IQIGame.Onigao.UI.MallUI", {
	rewardViewOpening = false,
	cellOnePool = {},
	cellTwoPool = {},
	rechargeCellPool = {},
	rewardCellPool = {},
	gashaponCellPool = {},
	tabTopDatum = {},
	tabLeftDatum = {},
	goodDatum = {},
	rechargeTaskDataList = {},
	id2NpcGroupIdDic = {},
	id2NpcPathDic = {},
	recommendCfgMallTypes = {}
})
local MallCellOne = require("IQIGame.UI.Mall.MallCellOne")
local MallCellTwo = require("IQIGame.UI.Mall.MallCellTwo")
local MallGashaponCell = require("IQIGame.UI.Mall.MallGashaponCell")
local MallRechargeCell = require("IQIGame.UI.Mall.MallRechargeCell")
local MallRewardCell = require("IQIGame.UI.Mall.MallRewardCell")
local MallMonthCardView = require("IQIGame.UI.Mall.MallMonthCardView")
local MallRecommendView = require("IQIGame.UI.Mall.MallRecommendView")
local NPCActionView = require("IQIGame.UI.NPCAction.NPCActionView")

function MallUI:OnInit()
	self:Initialize()
end

function MallUI:GetPreloadAssetPaths()
	return {
		MallUIApi:GetString("MonthCardPrefabPath", Constant.ItemSubType.EffectDiamondMonthCard)
	}
end

function MallUI:GetOpenPreloadAssetPaths(userData)
	local ret = {}

	self.userData = userData
	self.rewardViewOpening = false
	self.entranceType = userData[1]

	local defaultTabTopType = userData[2]

	self.defaultTableLeftID = userData[3]

	if userData[4] ~= nil then
		self.jumpCfgGoodsData = CfgMallTable[userData[4]]
	else
		self.jumpCfgGoodsData = nil
	end

	self.id2NpcGroupIdDic = {}
	self.id2NpcPathDic = {}
	self.tabTopDatum = {}

	local tempTypeDic = {}

	for i, v in pairsCfg(CfgMallTypeTable) do
		if v.FunctionButton == self.entranceType then
			if tempTypeDic[v.Type] == nil and #self:GetTabLeftDatum(v.Type) ~= 0 then
				self.tabTopDatum[#self.tabTopDatum + 1] = v.Type
				tempTypeDic[v.Type] = v.Type
			end

			if v.npcGroupId ~= 0 then
				self.id2NpcGroupIdDic[v.Id] = v.npcGroupId

				local cfgActionData = NPCActionModule.GetAction(v.npcGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)

				self.id2NpcPathDic[v.Id] = UIGlobalApi.GetPrefabRoot(cfgActionData.NPC)
				ret[#ret + 1] = UIGlobalApi.GetPrefabRoot(cfgActionData.NPC)
			end
		end
	end

	table.sort(self.tabTopDatum, function(a, b)
		return a < b
	end)

	local type2IndexDic = {}

	for i, v in ipairs(self.tabTopDatum) do
		type2IndexDic[v] = i
	end

	if defaultTabTopType == nil then
		self.defaultTabTopIndex = 1
	else
		self.defaultTabTopIndex = type2IndexDic[defaultTabTopType]
	end

	return ret
end

function MallUI:OnOpen(userData)
	self:Refresh(userData)
end

function MallUI:OnClose(userData)
	self:OnHide()
end

function MallUI:OnPause()
	return
end

function MallUI:OnResume()
	return
end

function MallUI:OnCover()
	return
end

function MallUI:OnReveal()
	return
end

function MallUI:OnRefocus(userData)
	return
end

function MallUI:OnUpdate(elapseSeconds, realElapseSeconds)
	for i, v in pairs(self.cellTwoPool) do
		v:OnUpdate(elapseSeconds, realElapseSeconds)
	end

	for i, v in pairs(self.cellOnePool) do
		v:OnUpdate(elapseSeconds, realElapseSeconds)
	end

	for i, v in pairs(self.gashaponCellPool) do
		v:OnUpdate(elapseSeconds, realElapseSeconds)
	end

	if self.npcView ~= nil then
		self.npcView:Update(elapseSeconds, realElapseSeconds)
	end

	if self.monthCardView ~= nil then
		self.monthCardView:OnUpdate(elapseSeconds, realElapseSeconds)
	end

	if self.needEnableLeftTabTimer and self.tabLeftList ~= nil and self.curCfgMallType ~= nil then
		self.leftTabTimer = self.leftTabTimer + realElapseSeconds

		if self.leftTabTimer >= 1 then
			self.leftTabTimer = 0

			if self.resetTab then
				self:CheckToRefreshTab(true)
			else
				self.tabLeftList:RenderCells()
			end
		end
	end
end

function MallUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MallUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MallUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MallUI:Initialize()
	self.moneyCellBuilder = MoneyCellsBuilder.New(self.goMoneyParent)
	self.npcView = NPCActionView.New(self.goNpcView)
	self.monthCardView = MallMonthCardView.New(self.goMonthCardView, self.UIController)
	self.recommendView = MallRecommendView.New(self.goRecommendView, self)
	self.tabTopList = self.goTabTopList:GetComponent("ScrollAreaList")

	function self.tabTopList.onRenderCell(cell)
		self:OnRenderTabTop(cell)
	end

	function self.tabTopList.onSelectedCell(cell)
		self:OnSelectTabTop(cell)
	end

	self.tabLeftList = self.goTabLeftList:GetComponent("ScrollAreaList")

	function self.tabLeftList.onRenderCell(cell)
		self:OnRenderTabLeft(cell)
	end

	function self.tabLeftList.onSelectedCell(cell)
		self:OnSelectTabLeft(cell)
	end

	self.shortList = self.goShortList:GetComponent("ScrollAreaList")

	function self.shortList.onRenderCell(cell)
		self:OnRenderItemCellOne(cell)
	end

	function self.shortList.onSelectedCell(cell)
		self:OnSelectItemCellOne(cell)
	end

	self.shortNpcList = self.goShortNpcList:GetComponent("ScrollAreaList")

	function self.shortNpcList.onRenderCell(cell)
		self:OnRenderItemCellOne(cell)
	end

	function self.shortNpcList.onSelectedCell(cell)
		self:OnSelectItemCellOne(cell)
	end

	self.longList = self.goLongList:GetComponent("ScrollAreaList")

	function self.longList.onRenderCell(cell)
		self:OnRenderItemCellTwo(cell)
	end

	function self.longList.onSelectedCell(cell)
		self:OnSelectItemCellTwo(cell)
	end

	self.gashaponList = self.goGashaponList:GetComponent("ScrollAreaList")

	function self.gashaponList.onRenderCell(cell)
		self:OnRenderGashapon(cell)
	end

	function self.gashaponList.onSelectedCell(cell)
		self:OnSelectGashapon(cell)
	end

	self.longNpcList = self.goLongNpcList:GetComponent("ScrollAreaList")

	function self.longNpcList.onRenderCell(cell)
		self:OnRenderItemCellTwo(cell)
	end

	function self.longNpcList.onSelectedCell(cell)
		self:OnSelectItemCellTwo(cell)
	end

	self.rechargeList = self.goRechargeList:GetComponent("ScrollAreaList")

	function self.rechargeList.onRenderCell(cell)
		self:OnRenderRechargeCell(cell)
	end

	function self.rechargeList.onSelectedCell(cell)
		self:OnSelectRechargeCell(cell)
	end

	self.rewardList = self.goRewardList:GetComponent("ScrollAreaList")

	function self.rewardList.onRenderCell(cell)
		self:OnRenderRewardCell(cell)
	end

	function self.rewardList.onSelectedCell(cell)
		self:OnSelectRewardCell(cell)
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnCloseNpc = self.goBtnCloseNpc:GetComponent("Button")
	self.btnRecharge = self.goBtnRecharge:GetComponent("Button")
	self.btnReward = self.goBtnReward:GetComponent("Button")
	self.btnGashDetail = self.goBtnGashDetail:GetComponent("Button")

	function self.onClickBtnGashDetailDelegate()
		self:OnClickBtnGashDetail()
	end

	function self.onClickBtnRewardDelegate()
		self:OnClickBtnReward()
	end

	function self.onClickBtnRechargeDelegate()
		self:OnClickBtnRecharge()
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onBuyGoodsSuccessDelegate(id)
		self:OnBuyGoodsSuccess(id)
	end

	function self.onUpdateMallDelegate()
		self:OnUpdateMall()
	end

	function self.onExchangeSuccessDelegate()
		self:OnExchangeSuccess()
	end

	function self.onTaskUpdateDelegate(cid)
		self:OnTaskUpdate(cid)
	end

	function self.onPayOverDelegate(code)
		self:OnPayOver(code)
	end

	function self.onNotifyPayInfoDelegate()
		self:OnNotifyPayInfo()
	end

	function self.onNotifyMonthCardDelegate()
		self:OnNotifyMonthCard()
	end

	function self.onJumpToOpenedUIDelegate(userData)
		self:OnJumpToOpenedUI(userData)
	end

	function self.onTaskCommitResponseDelegate(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end

	self.goBtnReward.transform:Find("Text"):GetComponent("Text").text = MallUIApi:GetString("btnRewardTxt")
	self.goBtnRecharge.transform:Find("Text"):GetComponent("Text").text = MallUIApi:GetString("btnRechargeTxt")
	self.goBtnGashDetail.transform:Find("Text"):GetComponent("Text").text = MallUIApi:GetString("btnGashTxt")
	self.goRechargeDesc:GetComponent("Text").text = MallUIApi:GetString("rechargeDesc")

	for i, v in pairsCfg(CfgMallTable) do
		if v.MallLinkageMallGoods ~= 0 then
			self.recommendCfgMallTypes[#self.recommendCfgMallTypes + 1] = CfgMallTypeTable[v.MallType]
		end
	end
end

function MallUI:Refresh(userData)
	self:RefreshMisc()
	self:RefreshTabTopBlock()
	self:RefreshBtnVisible()
	self:RefreshBtnRechargeRedPoint()
end

function MallUI:OnHide()
	for i, v in pairs(self.cellOnePool) do
		v:OnHide()
	end

	for i, v in pairs(self.cellTwoPool) do
		v:OnHide()
	end

	for i, v in pairs(self.gashaponCellPool) do
		v:OnHide()
	end

	for i, v in pairs(self.rechargeCellPool) do
		v:OnHide()
	end

	for i, v in pairs(self.rewardCellPool) do
		v:OnHide()
	end

	self.npcView:OnHide()
	self.monthCardView:OnHide()
	self.recommendView:OnHide()
end

function MallUI:OnDestroy()
	self.npcView:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.moneyCellBuilder:Dispose()

	for i, v in pairs(self.cellOnePool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.cellTwoPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.gashaponCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.rechargeCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.rewardCellPool) do
		v:OnDestroy()
	end

	self.monthCardView:OnDestroy()
	self.recommendView:OnDestroy()
end

function MallUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnCloseNpc.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnReward.onClick:AddListener(self.onClickBtnRewardDelegate)
	self.btnRecharge.onClick:AddListener(self.onClickBtnRechargeDelegate)
	self.btnGashDetail.onClick:AddListener(self.onClickBtnGashDetailDelegate)
	EventDispatcher.AddEventListener(EventID.BuyGoodsSuccess, self.onBuyGoodsSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateMall, self.onUpdateMallDelegate)
	EventDispatcher.AddEventListener(EventID.BatchExchangeSuccess, self.onExchangeSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.AddEventListener(EventID.PayOver, self.onPayOverDelegate)
	EventDispatcher.AddEventListener(EventID.NotifyPayInfo, self.onNotifyPayInfoDelegate)
	EventDispatcher.AddEventListener(EventID.NotifyMonthCard, self.onNotifyMonthCardDelegate)
	EventDispatcher.AddEventListener(EventID.JumpToOpenedFunc, self.onJumpToOpenedUIDelegate)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
end

function MallUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnCloseNpc.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnReward.onClick:RemoveListener(self.onClickBtnRewardDelegate)
	self.btnRecharge.onClick:RemoveListener(self.onClickBtnRechargeDelegate)
	self.btnGashDetail.onClick:RemoveListener(self.onClickBtnGashDetailDelegate)
	EventDispatcher.RemoveEventListener(EventID.BuyGoodsSuccess, self.onBuyGoodsSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateMall, self.onUpdateMallDelegate)
	EventDispatcher.RemoveEventListener(EventID.BatchExchangeSuccess, self.onExchangeSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.RemoveEventListener(EventID.PayOver, self.onPayOverDelegate)
	EventDispatcher.RemoveEventListener(EventID.NotifyPayInfo, self.onNotifyPayInfoDelegate)
	EventDispatcher.RemoveEventListener(EventID.NotifyMonthCard, self.onNotifyMonthCardDelegate)
	EventDispatcher.RemoveEventListener(EventID.JumpToOpenedFunc, self.onJumpToOpenedUIDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
end

function MallUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function MallUI:OnClickBtnGashDetail()
	UIModule.Open(Constant.UIControllerName.GashaponRewardListUI, Constant.UILayer.UI)
end

function MallUI:OnClickBtnReward()
	self.goRewardList.transform.parent.gameObject:SetActive(true)
	self.goRechargeList.transform.parent.gameObject:SetActive(false)

	self.rewardViewOpening = true
	self.rechargeTaskDataList = MallModule.GetRechargeTaskDatum()
	self.progressIndex = 1

	for i, v in ipairs(self.rechargeTaskDataList) do
		if v.CurrentNum >= v.TargetNum then
			self.progressIndex = self.progressIndex + 1
		end
	end

	self.rewardList:Refresh(#self.rechargeTaskDataList)
end

function MallUI:OnClickBtnRecharge()
	self.goRewardList.transform.parent.gameObject:SetActive(false)
	self.goRechargeList.transform.parent.gameObject:SetActive(true)

	self.rewardViewOpening = false
end

function MallUI:OnBuyGoodsSuccess(id)
	self.goodDatum = self:GetTabLeftGoodsDatum(self.curCfgMallType)

	self:RefreshContentOnCurState()
	self:CheckToRefreshTab(false)
	self:ShowCv(Constant.NPCTriggerType.BuyOnMall, self.curCfgMallType.Id)
end

function MallUI:OnUpdateMall()
	self:RefreshContentOnCurState()
	self.tabTopList:RenderCells()
	self.tabLeftList:RenderCells()
end

function MallUI:OnExchangeSuccess()
	self:RefreshMoneyCells()
	self:RefreshContentOnCurState()
	self:RefreshBtnVisible()
end

function MallUI:OnTaskUpdate(cid)
	self:RefreshBtnRechargeRedPoint()
end

function MallUI:OnPayOver(code)
	return
end

function MallUI:OnNotifyPayInfo()
	self.goodDatum = self:GetTabLeftGoodsDatum(self.curCfgMallType)

	self:RefreshContentOnCurState()
	self:CheckToRefreshTab(false)
end

function MallUI:OnNotifyMonthCard()
	self:RefreshContentOnCurState()
	self:CheckToRefreshTab(false)
end

function MallUI:OnJumpToOpenedUI(userData)
	if userData[1] == Constant.UIControllerName.MallUI then
		UIModule.Close(Constant.UIControllerName.BuyPanelUI)
		self:GetOpenPreloadAssetPaths(userData[2])
		self:Refresh(userData[2])
	end
end

function MallUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end

	if self.rewardViewOpening then
		self.rechargeTaskDataList = MallModule.GetRechargeTaskDatum()

		self.rewardList:RenderCells()
	end
end

function MallUI:RefreshMisc()
	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = MallUIApi:GetString("goTitle", self.entranceType)
	self.goBtnCloseNpc.transform:Find("Text"):GetComponent("Text").text = MallUIApi:GetString("goTitle", self.entranceType)
end

function MallUI:CheckToRefreshTab(mastRefreshTabLeft)
	if self.curCfgMallType == nil then
		return
	end

	local tabLeftDatum = self:GetTabLeftDatum(self.curCfgMallType.Type)

	if #tabLeftDatum == 0 then
		self:GetOpenPreloadAssetPaths(self.userData)
		self:Refresh(self.userData)
	elseif mastRefreshTabLeft then
		self:RefreshTabLeftBlock(self.curCfgMallType.Type)
	end

	local curIsRecommend = false

	for i, v in pairsCfg(CfgMallTable) do
		if v.MallType == self.curCfgMallType.Id and v.MallLinkageMallGoods ~= 0 then
			curIsRecommend = true

			break
		end
	end

	if not curIsRecommend then
		for m, n in pairs(self.tabTopDatum) do
			if n == 1 then
				for i, v in pairs(self.recommendCfgMallTypes) do
					tabLeftDatum = self:GetTabLeftDatum(v.Type)

					if #tabLeftDatum == 0 then
						self:GetOpenPreloadAssetPaths(self.userData)
						self:Refresh(self.userData)

						break
					end
				end
			end
		end
	end
end

function MallUI:RefreshTabTopBlock()
	self.tabTopList.defaultSelectedToggle = self.defaultTabTopIndex - 1

	self.tabTopList:Refresh(#self.tabTopDatum)
	self.tabTopList.gameObject:SetActive(#self.tabTopDatum ~= 1 or self.tabTopDatum[1] ~= 0)
end

function MallUI:OnRenderTabTop(cell)
	local luaIndex = cell.index + 1
	local type = self.tabTopDatum[luaIndex]
	local icon = cell.transform:Find("goUp/Image_02"):GetComponent("Image")
	local helperComp = cell.gameObject:GetComponent("ToggleHelperComponent")
	local redPointDown = cell.transform:Find("goDown/Tag/RedPoint").gameObject
	local redPointUp = cell.transform:Find("goUp/Tag/RedPoint").gameObject
	local showRedPoint = MallModule.CheckExistRedPointOnTab(type)

	redPointDown:SetActive(showRedPoint)
	redPointUp:SetActive(showRedPoint)

	helperComp.text = MallUIApi:GetString("tabTopName", type, self.entranceType)

	AssetUtil.LoadImage(self, MallUIApi:GetString("tabTopIcon", type), icon)
end

function MallUI:OnSelectTabTop(cell)
	local luaIndex = cell.index + 1
	local type = self.tabTopDatum[luaIndex]

	self:RefreshTabLeftBlock(type)
end

function MallUI:RefreshTabLeftBlock(type)
	self:StopLeftTabTimer()

	self.tabLeftDatum = self:GetTabLeftDatum(type)

	local isShow = self:RefreshTabLeftListShow()
	local defaultIndex = 1

	if self.defaultTableLeftID ~= nil then
		for i, v in ipairs(self.tabLeftDatum) do
			if v.Id == self.defaultTableLeftID then
				defaultIndex = i

				break
			end
		end
	end

	self.tabLeftList.defaultSelectedToggle = defaultIndex - 1

	self.tabLeftList:Refresh(#self.tabLeftDatum)
	self:RefreshTabLeftListShow(isShow)
end

function MallUI:RefreshTabLeftListShow(isShow)
	local showLeftTab = #self.tabLeftDatum ~= 1

	if isShow == nil or isShow ~= showLeftTab then
		self.goTabLeftList:SetActive(showLeftTab)
		self.goLeftBg:SetActive(showLeftTab)
		self.goLeftBox:SetActive(showLeftTab)
	end
end

function MallUI:OnRenderTabLeft(cell)
	local luaIndex = cell.index + 1
	local cfgMallTypeData = self.tabLeftDatum[luaIndex]
	local tfDown = cell.transform:Find("goDown/Text_01"):GetComponent("Text")
	local tfUp = cell.transform:Find("goUp/Text_01"):GetComponent("Text")
	local redPointDown = cell.transform:Find("goDown/Tag/RedPoint").gameObject
	local redPointUp = cell.transform:Find("goUp/Tag/RedPoint").gameObject
	local tfResidueTime = cell.transform:Find("Text"):GetComponent("Text")
	local signTime = cell.transform:Find("Image_Icon").gameObject
	local showRedPoint = MallModule.CheckExistRedPointOnShop(cfgMallTypeData.Id)

	signTime:SetActive(cfgMallTypeData.TimeLimitType ~= 0)
	redPointDown:SetActive(showRedPoint)
	redPointUp:SetActive(showRedPoint)

	tfDown.text = MallUIApi:GetString("tabLeftName", cfgMallTypeData.TabName)
	tfUp.text = tfDown.text

	tfResidueTime.gameObject:SetActive(cfgMallTypeData.TimeLimitType ~= 0)

	if cfgMallTypeData.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
		local residueTime = math.max(0, cfgDateTimeToTimeStamp(cfgMallTypeData.TimeLimitEnd, PlayerModule.TimeZone) - self:GetServerTime())

		tfResidueTime.text = MallUIApi:GetString("tabResidueTime", residueTime)

		if residueTime == 0 then
			self.resetTab = true
		end
	end
end

function MallUI:OnSelectTabLeft(cell)
	local luaIndex = cell.index + 1
	local cfgMallType = self.tabLeftDatum[luaIndex]

	self.goodDatum = self:GetTabLeftGoodsDatum(cfgMallType)

	self:RefreshContent(cfgMallType)
	self:RefreshMoneyCells()
	self:JumpToRecommendGoods(cfgMallType)
end

function MallUI:RefreshContent(cfgMallType)
	self.curCfgMallType = cfgMallType

	local isShowNpc = cfgMallType.npcGroupId ~= 0
	local isShort = cfgMallType.ShowType == 1
	local isLong = cfgMallType.ShowType == 2
	local isRecharge = cfgMallType.ShowType == 3
	local isMonth = cfgMallType.ShowType == 4
	local isRecommend = cfgMallType.ShowType == 5
	local isGashapon = cfgMallType.ShowType == 6

	self.goViewNormal:SetActive(not isShowNpc)
	self.goViewNpc:SetActive(isShowNpc)
	self.goRechargeDesc:SetActive(false)

	if not isRecharge then
		self.rewardViewOpening = false
	end

	local startIndex = 0

	if self.jumpCfgGoodsData ~= nil then
		local realCfgMallId = self.jumpCfgGoodsData.Id

		if self.jumpCfgGoodsData.MallLinkageMallGoods ~= 0 then
			realCfgMallId = self.jumpCfgGoodsData.MallLinkageMallGoods
		end

		for i, v in ipairs(self.goodDatum) do
			if v.Id == realCfgMallId then
				startIndex = i - 1

				break
			end
		end
	end

	if isShowNpc then
		self.shortNpcList.gameObject:SetActive(isShort)
		self.longNpcList.gameObject:SetActive(isLong)

		if isShort then
			self.shortNpcList.startIndex = startIndex

			self.shortNpcList:Refresh(#self.goodDatum)
		elseif isLong then
			self.longNpcList.startIndex = startIndex

			self.longNpcList:Refresh(#self.goodDatum)
		end

		self:RefreshNpc()

		if isRecommend then
			self.recommendView:Open(self.goodDatum[1])
		else
			self.recommendView:Close()
		end
	else
		self.shortList.gameObject:SetActive(isShort)
		self.longList.gameObject:SetActive(isLong)
		self.gashaponList.gameObject:SetActive(isGashapon)
		self.goBtnGashDetail:SetActive(isGashapon)
		self.goRechargeDesc:SetActive(isRecharge)
		self.goRechargeList.transform.parent.gameObject:SetActive(isRecharge and not self.rewardViewOpening)
		self.goRewardList.transform.parent.gameObject:SetActive(isRecharge and self.rewardViewOpening)

		if isShort then
			self.shortList.startIndex = startIndex

			self.shortList:Refresh(#self.goodDatum)
		elseif isLong then
			self.longList.startIndex = startIndex

			self.longList:Refresh(#self.goodDatum)
		elseif isRecharge then
			self.rechargeList.startIndex = startIndex

			self.rechargeList:Refresh(#self.goodDatum)
		elseif isGashapon then
			self.gashaponList.startIndex = startIndex

			self.gashaponList:Refresh(#self.goodDatum)
		end

		if isMonth then
			self.monthCardView:Open(self.goodDatum)
		else
			self.monthCardView:Close()
		end
	end
end

function MallUI:RefreshContentOnCurState()
	local isShowNpc = self.curCfgMallType.npcGroupId ~= 0
	local isShort = self.curCfgMallType.ShowType == 1
	local isLong = self.curCfgMallType.ShowType == 2
	local isRecharge = self.curCfgMallType.ShowType == 3
	local isMonth = self.curCfgMallType.ShowType == 4
	local isRecommend = self.curCfgMallType.ShowType == 5
	local isGashapon = self.curCfgMallType.ShowType == 6

	if isShowNpc then
		if isShort then
			if self.shortNpcList.dataCount ~= #self.goodDatum then
				self.shortNpcList:RenderCellsDynamic(#self.goodDatum)
			else
				self.shortNpcList:RenderCells()
			end
		elseif isLong then
			if self.longNpcList.dataCount ~= #self.goodDatum then
				self.longNpcList:RenderCellsDynamic(#self.goodDatum)
			else
				self.longNpcList:RenderCells()
			end
		elseif isRecommend then
			self.recommendView:Open(self.goodDatum[1])
		end
	elseif isShort then
		if self.shortList.dataCount ~= #self.goodDatum then
			self.shortList:RenderCellsDynamic(#self.goodDatum)
		else
			self.shortList:RenderCells()
		end
	elseif isLong then
		if self.longList.dataCount ~= #self.goodDatum then
			self.longList:RenderCellsDynamic(#self.goodDatum)
		else
			self.longList:RenderCells()
		end
	elseif isGashapon then
		if self.gashaponList.dataCount ~= #self.goodDatum then
			self.gashaponList:RenderCellsDynamic(#self.goodDatum)
		else
			self.gashaponList:RenderCells()
		end
	elseif isRecharge then
		if self.rechargeList.dataCount ~= #self.goodDatum then
			self.rechargeList:RenderCellsDynamic(#self.goodDatum)
		else
			self.rechargeList:RenderCells()
		end
	elseif isMonth then
		self.monthCardView:Open(self.goodDatum)
	end
end

function MallUI:OnRenderItemCellOne(grid)
	local luaIndex = grid.index + 1
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.cellOnePool[insID]
	local cfgMallData = self.goodDatum[luaIndex]

	if cell == nil then
		cell = MallCellOne.New(grid.gameObject)
		self.cellOnePool[insID] = cell
	end

	cell:Refresh(cfgMallData)
end

function MallUI:OnSelectItemCellOne(grid)
	local luaIndex = grid.index + 1
	local cfgMallData = self.goodDatum[luaIndex]
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.cellOnePool[insID]

	if cell.isSellOut or not cell.isConditionOk then
		NoticeModule.ShowNoticeNoCallback(21040055)

		return
	end

	UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
		mallCid = cfgMallData.Id
	})
end

function MallUI:OnRenderItemCellTwo(grid)
	local luaIndex = grid.index + 1
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.cellTwoPool[insID]
	local cfgMallData = self.goodDatum[luaIndex]

	if cell == nil then
		cell = MallCellTwo.New(grid.gameObject)
		self.cellTwoPool[insID] = cell
	end

	cell:Refresh(cfgMallData)
end

function MallUI:OnSelectItemCellTwo(grid)
	local luaIndex = grid.index + 1
	local cfgMallData = self.goodDatum[luaIndex]
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.cellTwoPool[insID]

	if cell.isSellOut or not cell.isConditionOk then
		NoticeModule.ShowNoticeNoCallback(21040055)

		return
	end

	UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
		mallCid = cfgMallData.Id
	})
end

function MallUI:OnRenderRechargeCell(grid)
	local luaIndex = grid.index + 1
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.rechargeCellPool[insID]
	local cfgMallData = self.goodDatum[luaIndex]

	if cell == nil then
		cell = MallRechargeCell.New(grid.gameObject)
		self.rechargeCellPool[insID] = cell
	end

	cell:Refresh(cfgMallData)
end

function MallUI:OnSelectRechargeCell(grid)
	local luaIndex = grid.index + 1
	local cfgMallData = self.goodDatum[luaIndex]

	UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
		mallCid = cfgMallData.Id
	})
end

function MallUI:OnRenderRewardCell(grid)
	local luaIndex = grid.index + 1
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.rewardCellPool[insID]
	local taskData = self.rechargeTaskDataList[luaIndex]

	if cell == nil then
		cell = MallRewardCell.New(grid.gameObject)
		self.rewardCellPool[insID] = cell
	end

	cell:Refresh(taskData, luaIndex, self.progressIndex)
end

function MallUI:OnSelectRewardCell(grid)
	return
end

function MallUI:OnRenderGashapon(grid)
	local luaIndex = grid.index + 1
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.gashaponCellPool[insID]
	local cfgMallData = self.goodDatum[luaIndex]

	if cell == nil then
		cell = MallGashaponCell.New(grid.gameObject)
		self.gashaponCellPool[insID] = cell
	end

	cell:Refresh(cfgMallData)
end

function MallUI:OnSelectGashapon(grid)
	local luaIndex = grid.index + 1
	local cfgMallData = self.goodDatum[luaIndex]
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.gashaponCellPool[insID]

	if cell.isSellOut or not cell.isConditionOk then
		NoticeModule.ShowNoticeNoCallback(21040055)

		return
	end
end

function MallUI:RefreshNpc()
	local npcGroupId = self.id2NpcGroupIdDic[self.curCfgMallType.Id]
	local npcPath = self.id2NpcPathDic[self.curCfgMallType.Id]
	local cfgActionData = NPCActionModule.GetAction(npcGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.OpenUI, getDateTimeTable(self:GetServerTime()).hour)
	local pos = cfgActionData.Position
	local scale = cfgActionData.Scale
	local talkOffset = cfgActionData.TalkPosition
	local goNpcClone = UnityEngine.GameObject.Instantiate(self.UIController:GetPreloadedAsset(npcPath))

	self.npcView:Refresh(cfgActionData, goNpcClone, npcPath, self.goNpcRoot.transform, pos, scale, talkOffset)
end

function MallUI:ShowCv(triggerType, paramStr)
	local curNpcGroupId = self.id2NpcGroupIdDic[self.curCfgMallType.Id]
	local cfgActionData = NPCActionModule.GetAction(curNpcGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, triggerType, paramStr)

	if cfgActionData == nil then
		return
	end

	self.npcView:ShowCV(cfgActionData.CVid)
end

function MallUI:RefreshMoneyCells()
	local tempDic = {}
	local ids = {}

	for i, v in pairs(self.goodDatum) do
		local tempIds = {}

		if v.SellType == Constant.Mall_SellType.Item then
			tempIds[#tempIds + 1] = v.Price[1]
		elseif v.SellType == Constant.Mall_SellType.PayPoint then
			tempIds[#tempIds + 1] = Constant.ItemID.ID_PAYPOINT_SHOW
		elseif v.SellType == Constant.Mall_SellType.RMB then
			tempIds[#tempIds + 1] = Constant.ItemID.ID_PAYPOINT_SHOW
		end

		for m, n in pairs(v.Item) do
			if n == Constant.ItemID.MONEY or n == Constant.ItemID.TREASURE or n == Constant.ItemID.ID_PAYPOINT_SHOW then
				tempIds[#tempIds + 1] = n
			end
		end

		for m, n in pairs(tempIds) do
			if tempDic[n] == nil then
				ids[#ids + 1] = n
			end

			tempDic[n] = n
		end
	end

	table.sort(ids, function(a, b)
		return a == nil or b == nil or a < b
	end)
	self.moneyCellBuilder:RefreshView(ids)
end

function MallUI:RefreshBtnVisible()
	return
end

function MallUI:JumpToRecommendGoods(cfgMallType)
	if self.jumpCfgGoodsData == nil then
		return
	end

	if not self.jumpCfgGoodsData.AutoBuyPanel then
		return
	end

	local realCfgMallId = self.jumpCfgGoodsData.Id

	if self.jumpCfgGoodsData.MallLinkageMallGoods ~= 0 then
		realCfgMallId = self.jumpCfgGoodsData.MallLinkageMallGoods
	end

	local datum = self:GetTabLeftGoodsDatum(cfgMallType)
	local existTarget = false

	for i, v in pairs(datum) do
		if v.Id == realCfgMallId then
			existTarget = true

			break
		end
	end

	if existTarget then
		UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
			mallCid = realCfgMallId
		})
	else
		NoticeModule.ShowNoticeNoCallback(21040055)
	end

	self.jumpCfgGoodsData = nil
end

function MallUI:GetTabLeftDatum(mallType)
	local tabLeftDatum = {}

	for i, v in pairsCfg(CfgMallTypeTable) do
		if v.FunctionButton == self.entranceType and v.Type == mallType then
			local isValid = true

			if v.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
				if self:GetServerTime() < cfgDateTimeToTimeStamp(v.TimeLimitOpen, PlayerModule.TimeZone) or self:GetServerTime() > cfgDateTimeToTimeStamp(v.TimeLimitEnd, PlayerModule.TimeZone) then
					isValid = false
				else
					self:StartLeftTabTimer()
				end
			end

			if isValid and #self:GetTabLeftGoodsDatum(v) == 0 then
				isValid = false
			end

			if isValid then
				tabLeftDatum[#tabLeftDatum + 1] = v
			end
		end
	end

	table.sort(tabLeftDatum, function(a, b)
		return a.Tab < b.Tab
	end)

	return tabLeftDatum
end

function MallUI:GetTabLeftGoodsDatum(cfgMallType)
	local goodDatum = {}
	local getMallGroup = {}

	for i, v in pairsCfg(CfgMallTable) do
		if v.MallType == cfgMallType.Id then
			local isValid = true
			local realCfgData = v

			if cfgMallType.RefreshType > 0 and v.RandomGroup > 0 then
				if table.indexOf(getMallGroup, v.RandomGroup) == -1 then
					table.insert(getMallGroup, v.RandomGroup)

					local mallID = MallModule.GetGuildRandomMall(v.RandomGroup)

					if mallID then
						realCfgData = CfgMallTable[mallID]
					else
						isValid = false

						if GameEntry.Base.DevMode then
							log("公会商城随机商品组没有商品..RefreshType = " .. cfgMallType.RefreshType .. " 随机商品组 RandomGroup = " .. v.RandomGroup)
						end
					end
				else
					isValid = false
				end
			end

			if isValid and v.ShowConditionId ~= 0 and not ConditionModule.Check(v.ShowConditionId) then
				isValid = false
			end

			if v.MallLinkageMallGoods ~= 0 then
				v = CfgMallTable[v.MallLinkageMallGoods]
			end

			if isValid and v.LimitType == Constant.Mall_LimitType.Life and MallModule.GetResidueBuyTimes(v.Id) == 0 then
				isValid = false
			end

			if isValid and v.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
				if cfgDateTimeToTimeStamp(v.TimeLimitOpen, PlayerModule.TimeZone) > self:GetServerTime() then
					isValid = false
				end

				if cfgDateTimeToTimeStamp(v.TimeLimitEnd, PlayerModule.TimeZone) < self:GetServerTime() then
					isValid = false
				end
			end

			if isValid and v.TimeLimitType == Constant.MallTimeLimitType.LIMIT_SELL_TIME then
				local startSell = MallModule.GetMallIsStartSell(v.Id)

				if not startSell then
					isValid = false
				end

				local count = MallModule.GetResidueBuyTimes(v.Id)

				if count <= 0 then
					isValid = false
				end
			end

			isValid = isValid and MallModule.CheckIsRightChannel(v)

			if isValid then
				goodDatum[#goodDatum + 1] = realCfgData
			end
		end
	end

	table.sort(goodDatum, function(a, b)
		return a.Sort < b.Sort
	end)

	return goodDatum
end

function MallUI:GetServerTime()
	return math.floor(PlayerModule.GetServerTime())
end

function MallUI:StartLeftTabTimer()
	self.needEnableLeftTabTimer = true
	self.leftTabTimer = 0
	self.resetTab = false
end

function MallUI:StopLeftTabTimer()
	self.needEnableLeftTabTimer = false
	self.leftTabTimer = 0
end

function MallUI:RefreshBtnRechargeRedPoint(isOnOpen)
	if not isOnOpen then
		self.tabTopList:RenderCells()
		self.tabLeftList:RenderCells()
	end

	self.goBtnRewardRedPoint:SetActive(MallModule.IsShowRechargeTaskRedPoint())
end

return MallUI
