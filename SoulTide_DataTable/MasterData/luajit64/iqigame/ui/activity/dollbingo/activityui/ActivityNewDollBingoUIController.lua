-- chunkname: @IQIGame\\UI\\Activity\\DollBingo\\ActivityUI\\ActivityNewDollBingoUIController.lua

local ActivityNewDollBingoUIController = {
	index2BingoCellDic = {},
	index2BingoNumCellDic = {}
}
local BingoCell = require("IQIGame.UI.Activity.DollBingo.BingoCell")
local BingoNumCell = require("IQIGame.UI.Activity.DollBingo.BingoNumCell")

function ActivityNewDollBingoUIController.New(uiController)
	local obj = Clone(ActivityNewDollBingoUIController)

	obj:__Init(uiController)

	return obj
end

function ActivityNewDollBingoUIController:__Init(uiController)
	self.UIController = uiController
end

function ActivityNewDollBingoUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function ActivityNewDollBingoUIController:OnInit()
	self:Initialize()
end

function ActivityNewDollBingoUIController:GetPreloadAssetPaths()
	return nil
end

function ActivityNewDollBingoUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActivityNewDollBingoUIController:IsManualShowOnOpen(userData)
	return false
end

function ActivityNewDollBingoUIController:GetBGM(userData)
	return nil
end

function ActivityNewDollBingoUIController:OnOpen(userData)
	self:Refresh(userData)
end

function ActivityNewDollBingoUIController:OnClose(userData)
	self:OnHide()
end

function ActivityNewDollBingoUIController:OnAddListeners()
	return
end

function ActivityNewDollBingoUIController:OnRemoveListeners()
	return
end

function ActivityNewDollBingoUIController:OnPause()
	return
end

function ActivityNewDollBingoUIController:OnResume()
	return
end

function ActivityNewDollBingoUIController:OnCover()
	return
end

function ActivityNewDollBingoUIController:OnReveal()
	return
end

function ActivityNewDollBingoUIController:OnRefocus(userData)
	return
end

function ActivityNewDollBingoUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.enableCircleEffect then
		self.circleEffectTimer = self.circleEffectTimer + elapseSeconds

		if self.enableCircleEffect_state1 then
			if self.circleEffectTimer >= self.intervalCircleEffect_temp then
				self:PlayCircleNumCellEffect()

				self.circleEffectTimer = 0
				self.intervalCircleEffect_temp = math.lerp(self.intervalCircleEffect_temp, self.INTERVAL_CIRCLE_EFFECT_STATE_2, 0.5)

				if self.intervalCircleEffect_temp <= self.INTERVAL_CIRCLE_EFFECT_STATE_2 + self.INTERVAL_CIRCLE_EFFECT_STATE_2 * 0.001 then
					self.circleEffectTimer = 0
					self.intervalCircleEffect_temp = self.INTERVAL_CIRCLE_EFFECT_STATE_2
					self.enableCircleEffect_state1 = false
					self.enableCircleEffect_state2 = true
				end
			end
		elseif self.enableCircleEffect_state2 then
			self.circleEffectTimer_state2 = self.circleEffectTimer_state2 + elapseSeconds

			if self.circleEffectTimer >= self.intervalCircleEffect_temp then
				self:PlayCircleNumCellEffect()

				self.circleEffectTimer = 0

				if self.circleEffectTimer_state2 >= self.CIRCLE_EFFECT_STATE_2_DURATION then
					self.circleEffectTimer = 0
					self.enableCircleEffect_state2 = false
					self.enableCircleEffect_state3 = true
				end
			end
		elseif self.enableCircleEffect_state3 then
			if self.circleEffectTimer >= self.intervalCircleEffect_temp then
				self.intervalCircleEffect_temp = math.lerp(self.intervalCircleEffect_temp, self.INTERVAL_CIRCLE_EFFECT_STATE_1, 0.5)

				self:PlayCircleNumCellEffect()

				self.circleEffectTimer = 0

				if self.curLightIndex == self.targetLightIndex then
					self.enableCircleEffect_state3 = false
					self.enableCircleEffect_state4 = true
					self.circleEffectTimer = 0

					self:OnCircleEffectState3Over()
				end
			end
		elseif self.enableCircleEffect_state4 and self.circleEffectTimer >= self.CIRCLE_EFFECT_STATE_4_DURATION then
			self.enableCircleEffect_state4 = false

			self:StopCircleEffectTimer()
			self:OnCircleEffectState4Over()
		end
	end

	if self.enableTenEffect_stat_1 then
		self.tenEffectTimer_state_1 = self.tenEffectTimer_state_1 + elapseSeconds

		for i, v in pairs(self.index2BingoNumCellDic) do
			v:OnUpdate(elapseSeconds)
		end

		if self.tenEffectTimer_state_1 >= self.TEN_EFFECT_STATE_1_DURATION then
			self:StopTenEffectState1Timer()
			self:OnTenEffectState1Over()
		end
	end

	if self.enableTenEffect_stat_2 then
		self.tenEffectTimer_state_2 = self.tenEffectTimer_state_2 + elapseSeconds

		if self.tenEffectTimer_state_2 >= self.TEN_EFFECT_STATE_2_DURATION then
			self:StopTenEffectState2Timer()
			self:OnTenEffectState2Over()
		end
	end

	if self.enableAllActiveEffect then
		self.allActiveEffectTimer = self.allActiveEffectTimer + elapseSeconds

		if self.allActiveEffectTimer >= self.ALL_ACTIVE_EFFECT_DURATION then
			self:StopAllActiveEffectTimer()
			self:OnAllActiveEffectOver()
		end
	end
end

function ActivityNewDollBingoUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActivityNewDollBingoUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivityNewDollBingoUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivityNewDollBingoUIController:Initialize()
	self.moneyCellBuilder = MoneyCellsBuilder.New(self.goMoneyParent)
	self.tfRoundNum = self.goRoundNum:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnOne = self.goBtnOne:GetComponent("Button")
	self.btnTen = self.goBtnTen:GetComponent("Button")
	self.btnReward = self.goBtnReward:GetComponent("Button")
	self.btnRecord = self.goBtnRecord:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnOneDelegate()
		self:OnClickBtnOne()
	end

	function self.onClickBtnTenDelegate()
		self:OnClickBtnTen()
	end

	function self.onClickBtnRewardDelegate()
		self:OnClickBtnReward()
	end

	function self.onClickBtnRecordDelegate()
		self:OnClickBtnRecord()
	end

	function self.onBingoLotterySuccessDelegate()
		self:OnLotterySuccess()
	end

	function self.onUpdateOperationsDelegate()
		self:OnUpdateOperations()
	end

	for i = 1, 9 do
		local go = self.goBingoCellRoot.transform:Find("Mould_0" .. i).gameObject

		self.index2BingoCellDic[i] = BingoCell.New(go, i)
	end

	for i = 1, 8 do
		local go = self.goNumCellRoot.transform:Find("Item_" .. i).gameObject

		self.index2BingoNumCellDic[i] = BingoNumCell.New(go, i)
	end

	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("title")
	self.goBtnOne.transform:Find("Text"):GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("btnOneTxt")
	self.goBtnTen.transform:Find("Text"):GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("btnTenTxt")
	self.goBtnReward.transform:Find("Text_01"):GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("btnRewardTxt")
	self.goBtnRecord.transform:Find("Text_01"):GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("btnRecordTxt")
	self.goBtnRecord.transform:Find("Text_02"):GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("btnRecordEngTxt")
	self.goBtnReward.transform:Find("Text_02"):GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("btnRewardEngTxt")
	self.goBingoTitle:GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("bingoTitle")
	self.goBingoTitleEng:GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("bingoTitleEng")
	self.INTERVAL_CIRCLE_EFFECT_STATE_1 = ActivityNewDollBingoUIApi:GetString("circleEffectState1_IntervalTime")
	self.INTERVAL_CIRCLE_EFFECT_STATE_2 = ActivityNewDollBingoUIApi:GetString("circleEffectState2_IntervalTime")
	self.CIRCLE_EFFECT_STATE_2_DURATION = ActivityNewDollBingoUIApi:GetString("circleEffectState2_Duration")
	self.CIRCLE_EFFECT_STATE_4_DURATION = ActivityNewDollBingoUIApi:GetString("circleEffectState4_Duration")
	self.TEN_EFFECT_STATE_1_DURATION = ActivityNewDollBingoUIApi:GetString("tenEffectState1_Duration")
	self.TEN_EFFECT_STATE_2_DURATION = ActivityNewDollBingoUIApi:GetString("tenEffectState2_Duration")
	self.ALL_ACTIVE_EFFECT_DURATION = ActivityNewDollBingoUIApi:GetString("allActiveEffectDuration")
end

function ActivityNewDollBingoUIController:Refresh(userData)
	self.eventID = userData
	self.bingoData = DollBingoModule.GetBingoData(self.eventID)
	self.enableMouse = true

	self:StopTimer()
	self:RefreshMisc()
	self:RefreshSudoku()
end

function ActivityNewDollBingoUIController:OnHide()
	for i, v in pairs(self.index2BingoCellDic) do
		v:OnHide()
	end

	for i, v in pairs(self.index2BingoNumCellDic) do
		v:OnHide()
	end

	self:StopTimer()
end

function ActivityNewDollBingoUIController:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnRecord.onClick:AddListener(self.onClickBtnRecordDelegate)
	self.btnReward.onClick:AddListener(self.onClickBtnRewardDelegate)
	self.btnOne.onClick:AddListener(self.onClickBtnOneDelegate)
	self.btnTen.onClick:AddListener(self.onClickBtnTenDelegate)
	EventDispatcher.AddEventListener(EventID.BingoLotterySuccess, self.onBingoLotterySuccessDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.onUpdateOperationsDelegate)
end

function ActivityNewDollBingoUIController:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnRecord.onClick:RemoveListener(self.onClickBtnRecordDelegate)
	self.btnReward.onClick:RemoveListener(self.onClickBtnRewardDelegate)
	self.btnOne.onClick:RemoveListener(self.onClickBtnOneDelegate)
	self.btnTen.onClick:RemoveListener(self.onClickBtnTenDelegate)
	EventDispatcher.RemoveEventListener(EventID.BingoLotterySuccess, self.onBingoLotterySuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.onUpdateOperationsDelegate)
end

function ActivityNewDollBingoUIController:OnClickBtnClose()
	if not self.enableMouse then
		return
	end

	UIModule.CloseSelf(self)
end

function ActivityNewDollBingoUIController:OnClickBtnOne()
	if not self.enableMouse then
		return
	end

	DollBingoModule.ReqLottery(self.eventID, 1)
end

function ActivityNewDollBingoUIController:OnClickBtnTen()
	if not self.enableMouse then
		return
	end

	DollBingoModule.ReqLottery(self.eventID, 2)
end

function ActivityNewDollBingoUIController:OnClickBtnReward()
	if not self.enableMouse then
		return
	end

	UIModule.Open(Constant.UIControllerName.ActivityNewDollBingoRewardUI, Constant.UILayer.UI, self.bingoData)
end

function ActivityNewDollBingoUIController:OnClickBtnRecord()
	if not self.enableMouse then
		return
	end

	UIModule.Open(Constant.UIControllerName.ActivityNewDollBingoHistoryUI, Constant.UILayer.UI, self.eventID)
end

function ActivityNewDollBingoUIController:OnUpdateOperations()
	if not ActiveOperationEventModule.CheckIsOpen(self.eventID) then
		NoticeModule.ShowNoticeNoCallback(21057005)
		UIModule.Close(Constant.UIControllerName.ActivityNewDollBingoRewardUI)
		UIModule.Close(Constant.UIControllerName.ActivityNewDollBingoHistoryUI)
		UIModule.CloseSelf(self)
	end
end

function ActivityNewDollBingoUIController:OnLotterySuccess()
	self.enableMouse = false

	if DollBingoModule.lastLotteryType == 2 then
		self:StartTenEffectState1Timer()
		GameEntry.Sound:PlaySound(10255, Constant.SoundGroup.UI)
	else
		GameEntry.Sound:PlaySound(10254, Constant.SoundGroup.UI)
		self:StartCircleEffectTimer()
	end
end

function ActivityNewDollBingoUIController:OnCircleEffectState3Over()
	self:RefreshBingoNumCells()
	self:ShowRewards()

	for i, v in pairs(DollBingoModule.lastNumCids) do
		local index = CfgNewCharacterBingoNumTable[v].Num
		local targetCell = self.index2BingoCellDic[index]

		targetCell:Refresh(true, self.bingoData.cfgNewActivityData, self.bingoData.cfgBingoNumDatum[index])
	end

	self:PlayTargetBingoCellsAnim()
end

function ActivityNewDollBingoUIController:OnCircleEffectState4Over()
	self:StopNumCellEffect(self.curLightIndex)

	if self:CheckIsAllActive() then
		self:RefreshBingoNumCells()
		self:StartAllActiveEffectTimer()
	else
		self:RefreshSudoku()

		self.enableMouse = true
	end
end

function ActivityNewDollBingoUIController:OnTenEffectState1Over()
	self:StartTenEffectState2Timer()
	self:RefreshBingoNumCells(DollBingoModule.lastNumCids)

	if self:CheckIsAllActive() then
		self:RefreshBingoCellsAllActive()
	else
		self:RefreshBingoCells()
	end

	self:PlayTargetBingoCellsAnim()
end

function ActivityNewDollBingoUIController:OnTenEffectState2Over()
	if self:CheckIsAllActive() then
		self:StartAllActiveEffectTimer()
	else
		self:RefreshSudoku()

		self.enableMouse = true
	end

	self:RefreshBingoNumCells()
	self:ShowRewards()
end

function ActivityNewDollBingoUIController:OnAllActiveEffectOver()
	self:RefreshSudoku()

	self.enableMouse = true
end

function ActivityNewDollBingoUIController:RefreshMisc()
	self.moneyCellBuilder:RefreshView({
		self.bingoData.cfgNewActivityData.CardID
	})
end

function ActivityNewDollBingoUIController:RefreshSudoku()
	self.lastRoundNum = self.bingoData.roundNum
	self.isBingoShowing = false
	self.tfRoundNum.text = ActivityNewDollBingoUIApi:GetString("roundNum", self.bingoData.roundNum)

	self:RefreshBingoCells()
	self:RefreshBingoNumCells()

	self.goTips:GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("goTips", self.bingoData.remainCount)
end

function ActivityNewDollBingoUIController:RefreshBingoCells()
	for i, v in pairs(self.index2BingoCellDic) do
		local state = self.bingoData.gridStates[i]

		v:Refresh(state, self.bingoData.cfgNewActivityData, self.bingoData.cfgBingoNumDatum[i])
	end
end

function ActivityNewDollBingoUIController:PlayTargetBingoCellsAnim()
	local indexList = {}

	for i, v in pairs(DollBingoModule.lastNumCids) do
		local index = CfgNewCharacterBingoNumTable[v].Num

		self.index2BingoCellDic[index]:PlayAnim()
	end
end

function ActivityNewDollBingoUIController:RefreshBingoCellsAllActive()
	for i, v in pairs(self.index2BingoCellDic) do
		v:Refresh(true, self.bingoData.cfgNewActivityData, self.bingoData.cfgBingoNumDatum[i])
	end
end

function ActivityNewDollBingoUIController:RefreshBingoNumCells(numList)
	local index2NumDic = {}

	if numList ~= nil then
		for i, v in pairs(numList) do
			if index2NumDic[v] == nil then
				index2NumDic[v] = 1
			else
				index2NumDic[v] = index2NumDic[v] + 1
			end
		end
	end

	for i, v in ipairs(self.index2BingoNumCellDic) do
		v:Refresh(index2NumDic[self.bingoData.cfgBingoNumDatum[i].Id], self.bingoData.cfgBingoNumDatum[i])
	end
end

function ActivityNewDollBingoUIController:ShowRewards()
	for i, v in pairs(DollBingoModule.lastShowList) do
		NoticeModule.ShowFloatGetItem(v.cid, v.num)
	end
end

function ActivityNewDollBingoUIController:StartCircleEffectTimer()
	self.enableCircleEffect = true
	self.enableCircleEffect_state1 = true
	self.circleEffectTimer_state2 = 0
	self.circleEffectTimer = 0
	self.intervalCircleEffect_temp = self.INTERVAL_CIRCLE_EFFECT_STATE_1
	self.curLightIndex = math.random(1, 8)
	self.targetLightIndex = CfgNewCharacterBingoNumTable[DollBingoModule.lastNumCids[1]].Num
	self.circleEffectCid = 9001220 + math.random(1, 5)

	self:PlayCircleNumCellEffect()
end

function ActivityNewDollBingoUIController:StopCircleEffectTimer()
	self.enableCircleEffect = false
end

function ActivityNewDollBingoUIController:PlayCircleNumCellEffect()
	self.curLightIndex = self.curLightIndex + 1

	if self.curLightIndex > 8 then
		self.curLightIndex = 1
	end

	self:PlayNumCellEffect(self.curLightIndex, self.circleEffectCid)

	local preIndex = self.curLightIndex - 1

	if preIndex == 0 then
		preIndex = 8
	end

	self:StopNumCellEffect(preIndex)
end

function ActivityNewDollBingoUIController:PlayNumCellEffect(index, effectCid)
	self.index2BingoNumCellDic[index]:PlayCircleEffect(effectCid)
end

function ActivityNewDollBingoUIController:StopNumCellEffect(index)
	self.index2BingoNumCellDic[index]:StopCircleEffect()
end

function ActivityNewDollBingoUIController:StartTenEffectState1Timer()
	self.tenEffectTimer_state_1 = 0
	self.enableTenEffect_stat_1 = true

	for i, v in pairs(self.index2BingoNumCellDic) do
		v:StartEffectTimer()
	end
end

function ActivityNewDollBingoUIController:StopTenEffectState1Timer()
	self.enableTenEffect_stat_1 = false

	for i, v in pairs(self.index2BingoNumCellDic) do
		v:StopEffectTimer()
	end
end

function ActivityNewDollBingoUIController:StartTenEffectState2Timer()
	self.tenEffectTimer_state_2 = 0
	self.enableTenEffect_stat_2 = true
end

function ActivityNewDollBingoUIController:StopTenEffectState2Timer()
	self.enableTenEffect_stat_2 = false

	for i, v in pairs(self.index2BingoNumCellDic) do
		v:StopTenEffect()
	end
end

function ActivityNewDollBingoUIController:StartAllActiveEffectTimer()
	self:PlayAllActiveEffect()

	self.allActiveEffectTimer = 0
	self.enableAllActiveEffect = true

	GameEntry.Sound:PlaySound(10256, Constant.SoundGroup.UI)
end

function ActivityNewDollBingoUIController:StopAllActiveEffectTimer()
	self.enableAllActiveEffect = false

	self:StopAllActiveEffect()
end

function ActivityNewDollBingoUIController:PlayAllActiveEffect()
	self.goEffectAllActive:SetActive(false)
	self.goEffectAllActive:SetActive(true)
end

function ActivityNewDollBingoUIController:StopAllActiveEffect()
	self.goEffectAllActive:SetActive(false)
end

function ActivityNewDollBingoUIController:StopTimer()
	self:StopCircleEffectTimer()
	self:StopTenEffectState1Timer()
	self:StopTenEffectState2Timer()
	self:StopAllActiveEffectTimer()
end

function ActivityNewDollBingoUIController:CheckIsAllActive()
	return self.bingoData.roundNum > self.lastRoundNum
end

function ActivityNewDollBingoUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.moneyCellBuilder:Dispose()

	for i, v in pairs(self.index2BingoCellDic) do
		v:OnDestroy()
	end

	for i, v in pairs(self.index2BingoNumCellDic) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

return ActivityNewDollBingoUIController
