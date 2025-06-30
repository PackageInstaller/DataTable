-- chunkname: @IQIGame\\UI\\PassCheckUI.lua

local PassCheckUI = Base:Extend("PassCheckUI", "IQIGame.Onigao.UI.PassCheckUI", {
	rewardCellPool = {}
})
local RewardCell = require("IQIGame.UI.PassCheck.RewardCell")
local SpecialRewardCell = require("IQIGame.UI.PassCheck.SpecialRewardCell")

function PassCheckUI:OnInit()
	self:Initialize()
end

function PassCheckUI:GetPreloadAssetPaths()
	return nil
end

function PassCheckUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PassCheckUI:IsManualShowOnOpen(userData)
	return false
end

function PassCheckUI:GetBGM(userData)
	return nil
end

function PassCheckUI:OnOpen(userData)
	self:Refresh(userData)
end

function PassCheckUI:OnClose(userData)
	self:OnHide()
end

function PassCheckUI:OnPause()
	return
end

function PassCheckUI:OnResume()
	return
end

function PassCheckUI:OnCover()
	return
end

function PassCheckUI:OnReveal()
	return
end

function PassCheckUI:OnRefocus(userData)
	return
end

function PassCheckUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PassCheckUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PassCheckUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PassCheckUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PassCheckUI:Initialize()
	self.moneyCellBuilder = MoneyCellsBuilder.New(self.goMoneyParent)
	self.specialCell = SpecialRewardCell.New(self.goSpecialCell)
	self.imgBg = self.goBg:GetComponent("Image")
	self.tfPassName = self.goPassName:GetComponent("Text")
	self.tfPassTime = self.goPassTime:GetComponent("Text")
	self.tfLv = self.goLv:GetComponent("Text")
	self.tfExp = self.goExp:GetComponent("Text")
	self.imgBar = self.goBar:GetComponent("Image")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnRule = self.goBtnRule:GetComponent("Button")
	self.btnReward = self.goBtnReward:GetComponent("Button")
	self.btnBuyPass = self.goBtnBuyPass:GetComponent("Button")
	self.btnBuyLv = self.goBtnBuyLv:GetComponent("Button")
	self.btnEasyGet = self.goBtnEasyGet:GetComponent("Button")

	function self.onClickBtnBuyLvDelegate()
		self:OnClickBtnBuyLv()
	end

	function self.onClickBtnBuyPassDelegate()
		self:OnClickBtnBuyPass()
	end

	function self.onClickBtnRewardDelegate()
		self:OnClickBtnReward()
	end

	function self.onClickBtnRuleDelegate()
		self:OnClickBtnRule()
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnEasyGetDelegate()
		self:OnClickBtnEasyGet()
	end

	function self.onGetRewardSuccessDelegate()
		self:OnGetRewardSuccess()
	end

	function self.onPassUpdateDelegate()
		self:OnPassUpdate()
	end

	self.rewardList = self.goRewardList:GetComponent("ScrollAreaList")

	function self.rewardList.onSelectedCell(cell)
		self:OnSelectedRewardCell(cell)
	end

	function self.rewardList.onRenderCell(cell)
		self:OnRenderRewardCell(cell)
	end

	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = PassCheckUIApi:GetString("title")
	self.goExpDesc:GetComponent("Text").text = PassCheckUIApi:GetString("passExpDesc")
	self.goBtnReward.transform:Find("Text"):GetComponent("Text").text = PassCheckUIApi:GetString("btnRewardTxt")
	self.goBtnBuyPass.transform:Find("Text"):GetComponent("Text").text = PassCheckUIApi:GetString("btnBuyPassTxt")
	self.goBtnEasyGet.transform:Find("Text"):GetComponent("Text").text = PassCheckUIApi:GetString("btnEasyGetTxt")
	self.goBtnBuyLv.transform:Find("Text"):GetComponent("Text").text = PassCheckUIApi:GetString("btnBuyLvTxt")
	self.goBaseTitle:GetComponent("Text").text = PassCheckUIApi:GetString("baseTitle")
	self.goSuperTitle:GetComponent("Text").text = PassCheckUIApi:GetString("superTitle")
	self.goSuperStateDesc:GetComponent("Text").text = PassCheckUIApi:GetString("superStateDesc")
end

function PassCheckUI:Refresh(userData)
	self.cfgBattlePassData = CfgBattlePassTable[PassCheckModule.id]
	self.hasRefreshList = false

	self.goEffect:SetActive(false)

	self.lastLv = PassCheckModule.lv

	self:RefreshMisc()
	self:RefreshRewardList()
	self:RefreshSpecialReward()

	self.hasRefreshList = true

	PassCheckModule.ReqGetLastSeasonRewards()
end

function PassCheckUI:OnHide()
	for i, v in pairs(self.rewardCellPool) do
		v:OnHide()
	end

	self.specialCell:OnHide()
end

function PassCheckUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.moneyCellBuilder:Dispose()

	for i, v in pairs(self.rewardCellPool) do
		v:OnDestroy()
	end

	self.specialCell:OnDestroy()
end

function PassCheckUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnRule.onClick:AddListener(self.onClickBtnRuleDelegate)
	self.btnReward.onClick:AddListener(self.onClickBtnRewardDelegate)
	self.btnBuyPass.onClick:AddListener(self.onClickBtnBuyPassDelegate)
	self.btnBuyLv.onClick:AddListener(self.onClickBtnBuyLvDelegate)
	self.btnEasyGet.onClick:AddListener(self.onClickBtnEasyGetDelegate)
	EventDispatcher.AddEventListener(EventID.BattlePassGetRewardSuccess, self.onGetRewardSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.BattlePassUpdate, self.onPassUpdateDelegate)
	self.specialCell:OnAddListener()
end

function PassCheckUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnRule.onClick:RemoveListener(self.onClickBtnRuleDelegate)
	self.btnReward.onClick:RemoveListener(self.onClickBtnRewardDelegate)
	self.btnBuyPass.onClick:RemoveListener(self.onClickBtnBuyPassDelegate)
	self.btnBuyLv.onClick:RemoveListener(self.onClickBtnBuyLvDelegate)
	self.btnEasyGet.onClick:RemoveListener(self.onClickBtnEasyGetDelegate)
	EventDispatcher.RemoveEventListener(EventID.BattlePassGetRewardSuccess, self.onGetRewardSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.BattlePassUpdate, self.onPassUpdateDelegate)
	self.specialCell:OnRemoveListener()
end

function PassCheckUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function PassCheckUI:OnClickBtnEasyGet()
	local ret = {}

	for i, v in pairs(self.rewardListDatum) do
		if PassCheckModule.CheckLvExistRewardCanGet(v) then
			ret[#ret + 1] = v.Id
		end
	end

	if #ret > 0 then
		PassCheckModule.ReqGetReward(ret)
	end
end

function PassCheckUI:OnClickBtnBuyLv()
	UIModule.Open(Constant.UIControllerName.BuyPassCheckLevelUI, Constant.UILayer.UI, self.cfgBattlePassData.SeasonLvPrice)
end

function PassCheckUI:OnClickBtnRule()
	UIModule.Open(Constant.UIControllerName.PassCheckFunctionInfoUI, Constant.UILayer.UI)
end

function PassCheckUI:OnClickBtnReward()
	UIModule.Open(Constant.UIControllerName.PassCheckRewardListUI, Constant.UILayer.UI)
end

function PassCheckUI:OnClickBtnBuyPass()
	UIModule.Open(Constant.UIControllerName.PassCheckDealNewUI, Constant.UILayer.UI, self.cfgBattlePassData)
end

function PassCheckUI:OnRenderRewardCell(grid)
	local luaIndex = grid.index + 1
	local insID = grid.gameObject:GetInstanceID()
	local rewardCell = self.rewardCellPool[insID]
	local cfgRewardData = self.rewardListDatum[luaIndex]

	if rewardCell == nil then
		rewardCell = RewardCell.New(grid.gameObject)
		self.rewardCellPool[insID] = rewardCell
	end

	rewardCell:Refresh(cfgRewardData)

	if self.hasRefreshList then
		self:RefreshSpecialReward()
	end
end

function PassCheckUI:OnSelectedRewardCell(grid)
	local luaIndex = grid.index + 1
	local cfgRewardData = self.rewardListDatum[luaIndex]

	if PassCheckModule.CheckLvExistRewardCanGet(cfgRewardData) then
		PassCheckModule.ReqGetReward({
			cfgRewardData.Id
		})
	end
end

function PassCheckUI:OnGetRewardSuccess()
	self.rewardList:RenderCellsDynamic(#self.rewardListDatum)
end

function PassCheckUI:OnPassUpdate()
	self:RefreshMisc()
	self.rewardList:RenderCellsDynamic(#self.rewardListDatum)
	self.specialCell:ReRefresh()
end

function PassCheckUI:RefreshMisc()
	self.moneyCellBuilder:RefreshView({
		Constant.ItemID.TREASURE,
		Constant.ItemID.ID_PAYPOINT_SHOW
	})

	self.tfPassName.text = PassCheckUIApi:GetString("passName", self.cfgBattlePassData.Name)
	self.tfPassTime.text = PassCheckUIApi:GetString("passTime", getDateTimeMText(PassCheckModule.openTime), getDateTimeMText(PassCheckModule.endTime))
	self.tfLv.text = PassCheckUIApi:GetString("passLv", PassCheckModule.lv)

	if self.lastLv ~= PassCheckModule.lv then
		self.goEffect:SetActive(false)
		self.goEffect:SetActive(true)
	end

	self.lastLv = PassCheckModule.lv

	local needExp = 0
	local curExp = 0

	if not PassCheckModule.CheckReachMaxLv() then
		needExp = PassCheckModule.GetNextCfgRewardData().LvUpNeedExp
		curExp = PassCheckModule.exp
	end

	self.tfExp.text = PassCheckUIApi:GetString("passExp", curExp, needExp, PassCheckModule.CheckReachMaxLv())

	if needExp == 0 then
		self.imgBar.fillAmount = 0
	else
		self.imgBar.fillAmount = curExp / needExp
	end

	self.goBtnBuyPass:SetActive(not PassCheckModule.CheckGotSuperPass())
	self.goSignSuperLock:SetActive(not PassCheckModule.CheckGotSuperPass())
	self.goBtnEasyGet:SetActive(PassCheckModule.CheckExistRewardCanGet())
	self.goBtnBuyLv:SetActive(not PassCheckModule.CheckReachMaxLv())
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgBattlePassData.BGImage), self.imgBg)
end

function PassCheckUI:RefreshRewardList()
	self.rewardListDatum = PassCheckModule.GetSortCfgRewardDatum()
	self.specialCfg2AreaDic = {}

	local startIndex = 1

	for i, v in ipairs(self.rewardListDatum) do
		if v.IsSpecial then
			local endIndex = i + 3

			self.specialCfg2AreaDic[v] = {
				startIndex,
				endIndex
			}
			startIndex = endIndex + 1
		end
	end

	self.rewardList.startIndex = PassCheckModule.lv - 1

	self.rewardList:Refresh(#self.rewardListDatum)
end

function PassCheckUI:RefreshSpecialReward()
	local checkIndex = self.rewardList.PositivePageIndex + 1

	for i, v in pairs(self.specialCfg2AreaDic) do
		if checkIndex >= v[1] and checkIndex <= v[2] then
			self.specialCell:Refresh(i)

			break
		end
	end
end

return PassCheckUI
