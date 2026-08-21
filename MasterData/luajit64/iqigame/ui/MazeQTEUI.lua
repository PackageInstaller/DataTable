-- chunkname: @IQIGame\\UI\\MazeQTEUI.lua

local MazeQTEUI = Base:Extend("MazeQTEUI", "IQIGame.Onigao.UI.MazeQTEUI", {
	interval = 0.1,
	cellPool = {},
	toShowDatum = {}
})
local QTECell = require("IQIGame.UI.MazeQTE.QTECell")

function MazeQTEUI:OnInit()
	self:Initialize()
end

function MazeQTEUI:GetPreloadAssetPaths()
	return nil
end

function MazeQTEUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeQTEUI:IsManualShowOnOpen(userData)
	return false
end

function MazeQTEUI:GetBGM(userData)
	return nil
end

function MazeQTEUI:OnOpen(userData)
	self:Refresh(userData)
end

function MazeQTEUI:OnClose(userData)
	self:OnHide()
end

function MazeQTEUI:OnPause()
	return
end

function MazeQTEUI:OnResume()
	return
end

function MazeQTEUI:OnCover()
	return
end

function MazeQTEUI:OnReveal()
	return
end

function MazeQTEUI:OnRefocus(userData)
	return
end

function MazeQTEUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeQTEUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeQTEUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeQTEUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeQTEUI:Initialize()
	self.btnStart = self.goBtnStart:GetComponent("Button")
	self.tfTitle = self.goTitle:GetComponent("Text")
	self.tfTitle2 = self.goTitle2:GetComponent("Text")
	self.tfDesc = self.goDesc:GetComponent("Text")
	self.canvas = self.UIController.gameObject:GetComponent("Canvas")

	self.goCell:SetActive(false)

	self.tfCountDown = self.goCountDown:GetComponent("Text")
	self.timer = Timer.New(function()
		self:OnTimer()
	end, self.interval, -1)
	self.countDownTimer = Timer.New(function()
		self:OnCountDownTimer()
	end, 0.1, -1)

	function self.onClickBtnStartDelegate()
		self:OnClickBtnStart()
	end

	function self.onConfirmDelegate(userData)
		self:OnConfirm(userData)
	end

	self.effectTimer = Timer.New(function()
		self:OnTimerEffect()
	end, MazeQTEUIApi:GetString("clickEffectSuccessTime"), 1)
	self.effectFailureTime = MazeQTEUIApi:GetString("effectFailureTime")
	self.effectSuccessTime = MazeQTEUIApi:GetString("effectSuccessTime")
	self.goCountDownDesc:GetComponent("Text").text = MazeQTEUIApi:GetString("countDownDesc")
	self.goGo:GetComponent("Text").text = MazeQTEUIApi:GetString("GoDesc")
end

function MazeQTEUI:Refresh(userData)
	self.cfgMazeQTEData = CfgMazeQTETable[userData[1]]
	self.buttonCount = userData[2]
	self.retryCount = userData[3]
	self.changeTimeType = userData[4]
	self.changeTimeValue = userData[5]
	self.tryCount = userData[6]

	if self.tryCount == nil then
		self.tryCount = 0
	end

	self:CloseCountDownView()
	self:CloseClickView()
	self:OpenStartView()
end

function MazeQTEUI:OnHide()
	self:StopTimer()
	self:StopTimerEffect()
	self:StopEffectFailure()
	self:StopEffectSuccess()
	self:StopCountDownTimer()

	for i, v in pairs(self.cellPool) do
		v:OnHide()
	end
end

function MazeQTEUI:OnDestroy()
	for i, v in pairs(self.cellPool) do
		v:OnDestroy()
	end
end

function MazeQTEUI:OnAddListeners()
	self.btnStart.onClick:AddListener(self.onClickBtnStartDelegate)
end

function MazeQTEUI:OnRemoveListeners()
	self.btnStart.onClick:RemoveListener(self.onClickBtnStartDelegate)
end

function MazeQTEUI:OnClickBtnStart()
	self:CloseStartView()
	self:OpenCountDownView()
end

function MazeQTEUI:OnTimer()
	self.timeCounter = self.timeCounter + self.interval

	if self.timerType == 1 then
		for i, v in pairs(self.toShowDatum) do
			if self.timeCounter >= v.delay then
				local index = v.index
				local posIndex = v.posIndex
				local cell = self:GetCell(index)

				cell:SetParent(self.goArea.transform:Find("Pos_" .. posIndex))
				cell:Refresh(index, posIndex, self.cfgMazeQTEData)
				table.remove(self.toShowDatum, i)
			end
		end

		if #self.toShowDatum == 0 then
			self:StopTimer()
		end
	elseif self.timerType == 2 then
		if self.timeCounter >= self.effectSuccessTime then
			self:StopTimer()

			self.tryCount = self.tryCount + 1

			MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_QTE, {
				IsSuceess = true,
				PlayCount = self.tryCount
			})
			UIModule.CloseSelf(self)
		end
	elseif self.timerType == 3 and self.timeCounter >= self.effectFailureTime then
		self:StopTimer()
		UIModule.CloseSelf(self)

		if self.retryCount > 0 then
			self.tryCount = self.tryCount + 1

			NoticeModule.ShowNotice(85000000, self.onConfirmDelegate, nil, {
				self.cfgMazeQTEData.Id,
				self.buttonCount,
				self.retryCount - 1,
				self.changeTimeType,
				self.changeTimeValue,
				self.tryCount
			})
		else
			MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_QTE, {
				PlayCount = 1,
				IsSuceess = false
			})
		end
	end
end

function MazeQTEUI:OnQTECellClickSuccess()
	local QTESuccess = true

	for i, v in pairs(self.cellPool) do
		if v:CheckIsWorking() and v.curStatus ~= v.status.Success then
			QTESuccess = false

			break
		end
	end

	if QTESuccess then
		self:StartTimerEffect()
	end
end

function MazeQTEUI:OnQTECellClickFailure()
	self.isQTEFailure = true

	self:StopTimer()

	for i, v in pairs(self.cellPool) do
		v:OnQTEFailure()
	end

	if self.isQTEFailure then
		self:StartTimerEffect()
	end
end

function MazeQTEUI:OnTimerEffect()
	if self.isQTEFailure then
		self:PlayEffectFailure()
	else
		self:PlayEffectSuccess()
	end
end

function MazeQTEUI:OnConfirm(userData)
	UIModule.Open(Constant.UIControllerName.MazeQTEUI, Constant.UILayer.UI, userData)
end

function MazeQTEUI:OnCountDownTimer()
	self.counterDownCounter = self.counterDownCounter + 0.1

	if self.counterDownCounter >= 1 then
		self.counterDownCounter = 0

		if self.countDown > 1 then
			self.countDown = self.countDown - 1
			self.tfCountDown.text = MazeQTEUIApi:GetString("countDownTime", self.countDown)
		elseif self.countDown == 1 then
			self.countDown = self.countDown - 1

			self.goCountDown:SetActive(false)
			self.goCountDownDesc:SetActive(false)
			self.goGo:SetActive(true)
		end
	end

	if self.countDown == 0 and self.counterDownCounter >= 0.5 then
		self:CloseCountDownView()
		self:OpenClickView()
	end
end

function MazeQTEUI:OpenCountDownView()
	self.goCountDownView:SetActive(true)
	self.goCountDown:SetActive(true)
	self.goCountDownDesc:SetActive(true)
	self.goGo:SetActive(false)
	self:StartCountDownTimer()
end

function MazeQTEUI:CloseCountDownView()
	self.goCountDownView:SetActive(false)
	self:StopCountDownTimer()
end

function MazeQTEUI:StartCountDownTimer()
	self:StopCountDownTimer()
	self.countDownTimer:Start()

	self.countDown = 4
	self.counterDownCounter = 1

	self:OnCountDownTimer()
end

function MazeQTEUI:StopCountDownTimer()
	self.countDownTimer:Stop()
end

function MazeQTEUI:OpenStartView()
	self.goStartView:SetActive(true)

	self.tfTitle.text = MazeQTEUIApi:GetString("goTitle", self.cfgMazeQTEData.TitleBefore)
	self.tfDesc.text = MazeQTEUIApi:GetString("goDesc", self.cfgMazeQTEData.Describe)
end

function MazeQTEUI:CloseStartView()
	self.goStartView:SetActive(false)
end

function MazeQTEUI:OpenClickView()
	self.goClickView:SetActive(true)
	self.effectQTESuccess:SetActive(false)
	self.effectQTEFailed:SetActive(false)

	self.isQTEFailure = false
	self.tfTitle2.text = MazeQTEUIApi:GetString("goTitle2", self.cfgMazeQTEData.TitleAfter)

	self:RefreshCells()
end

function MazeQTEUI:CloseClickView()
	self.goClickView:SetActive(false)
end

function MazeQTEUI:RefreshCells()
	local qtNumList = self:GetQtNumList()

	self.toShowDatum = {}

	for i, v in ipairs(qtNumList) do
		self.toShowDatum[#self.toShowDatum + 1] = {
			index = i,
			posIndex = v,
			delay = self.cfgMazeQTEData.ButtonDelay[i]
		}
	end

	self:StartTimer(1)
end

function MazeQTEUI:GetQtNumList()
	local qtNumList = {}
	local nums = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8
	}

	for i = 1, self.buttonCount do
		local index = math.random(1, #nums)

		qtNumList[#qtNumList + 1] = nums[index]

		table.remove(nums, index)
	end

	return qtNumList
end

function MazeQTEUI:GetRowAndColumn(rowAndColumn, invalidRowAndColumnDic, qtNum)
	local randomRow = math.random(1, rowAndColumn[1])
	local randomColumn = math.random(1, rowAndColumn[2])

	for m, n in pairs(invalidRowAndColumnDic[qtNum]) do
		if n[1] == randomRow and n[2] == randomColumn then
			return self:GetRowAndColumn(rowAndColumn, invalidRowAndColumnDic, qtNum)
		end
	end

	return randomRow, randomColumn
end

function MazeQTEUI:GetCell(index)
	local cell = self.cellPool[index]

	if cell == nil then
		local go = UnityEngine.Object.Instantiate(self.goCell)

		cell = QTECell.New(go, self)
		self.cellPool[index] = cell
	end

	cell:SetActive(true)

	return cell
end

function MazeQTEUI:CheckClickSuccessOnSort(cell)
	if cell.index == 1 then
		return true
	else
		local preIndex = cell.index - 1

		for i, v in pairs(self.cellPool) do
			if v.index == preIndex and v.curStatus == v.status.Success then
				return true
			end
		end

		return false
	end
end

function MazeQTEUI:StartTimer(timerType)
	self.timerType = timerType

	self.timer:Start()

	self.timeCounter = 0
end

function MazeQTEUI:StopTimer()
	self.timer:Stop()

	if self.timerType == 2 then
		self:StopEffectSuccess()
	elseif self.timerType == 3 then
		self:StopEffectFailure()
	end
end

function MazeQTEUI:StartTimerEffect(isSuccess)
	self:StopTimerEffect()

	if isSuccess then
		self.effectTimer:Reset(function()
			self:OnTimerEffect()
		end, MazeQTEUIApi:GetString("clickEffectSuccessTime"), 1)
	else
		self.effectTimer:Reset(function()
			self:OnTimerEffect()
		end, MazeQTEUIApi:GetString("clickEffectFailureTime"), 1)
	end

	self.effectTimer:Start()
end

function MazeQTEUI:StopTimerEffect()
	self.effectTimer:Stop()
end

function MazeQTEUI:PlayEffectSuccess()
	self:StopEffectSuccess()
	self.effectQTESuccess:SetActive(true)
	self:StartTimer(2)
end

function MazeQTEUI:StopEffectSuccess()
	self.effectQTESuccess:SetActive(false)
end

function MazeQTEUI:PlayEffectFailure()
	self:StopEffectFailure()
	self.effectQTEFailed:SetActive(true)
	self:StartTimer(3)
end

function MazeQTEUI:StopEffectFailure()
	self.effectQTEFailed:SetActive(false)
end

return MazeQTEUI
