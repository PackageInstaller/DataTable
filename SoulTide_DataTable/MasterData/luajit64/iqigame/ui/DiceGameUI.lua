-- chunkname: @IQIGame\\UI\\DiceGameUI.lua

local DiceGameUI = {
	TOP_RE_DICE_NUM = 3,
	ShowStartTime = 0,
	DiceComplete = false,
	RandomDelayInterval = 0.15,
	RandomDelays = {},
	Dices = {},
	DiceResults = {},
	ChangedDice = {}
}

DiceGameUI = Base:Extend("DiceGameUI", "IQIGame.Onigao.UI.DiceGameUI", DiceGameUI)

local DiceGameDiceController = require("IQIGame.UI.DiceGame.DiceGameDiceController")
local DiceGameIntroduction = require("IQIGame.UI.DiceGame.DiceGameIntroduction")

function DiceGameUI:OnInit()
	function self.DelegateOnTapGesture(gesture)
		self:OnTapGesture(gesture)
	end

	function self.DelegateOnClickStartBtn()
		self:OnClickStartBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickReDiceBtn()
		self:OnClickReDiceBtn()
	end

	function self.DelegateOnClickConfirmResultBtn()
		self:OnClickConfirmResultBtn()
	end

	for i = 1, 5 do
		local diceNode = self.DiceArea.transform:Find("Dice" .. i).gameObject
		local diceGo = UnityEngine.Object.Instantiate(self.DicePrefab)
		local diceController = DiceGameDiceController.New(diceGo)

		diceGo.transform:SetParent(diceNode.transform, false)
		table.insert(self.Dices, diceController)
	end

	self.IntroductionController = DiceGameIntroduction.New(self.Introduction)

	UGUIUtil.SetTextInChildren(self.StartBtn, DiceGameUIApi:GetString("StartBtnText"))
	UGUIUtil.SetTextInChildren(self.ReDiceBtn, DiceGameUIApi:GetString("ReDiceBtnText"))
	UGUIUtil.SetTextInChildren(self.ConfirmResultBtn, DiceGameUIApi:GetString("ConfirmResultBtnText"))
end

function DiceGameUI:GetPreloadAssetPaths()
	return nil
end

function DiceGameUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DiceGameUI:IsManualShowOnOpen(userData)
	return false
end

function DiceGameUI:GetBGM(userData)
	return nil
end

function DiceGameUI:OnOpen(userData)
	self:UpdateView(userData.judgeCid)
end

function DiceGameUI:OnClose(userData)
	if self.ShowResultTimer ~= nil then
		self.ShowResultTimer:Stop()

		self.ShowResultTimer = nil
	end
end

function DiceGameUI:OnAddListeners()
	self.IntroductionController:AddListeners()

	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated + self.DelegateOnTapGesture

	self.StartBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStartBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ReDiceBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReDiceBtn)
	self.ConfirmResultBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmResultBtn)
end

function DiceGameUI:OnRemoveListeners()
	self.IntroductionController:RemoveListeners()

	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated - self.DelegateOnTapGesture

	self.StartBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStartBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ReDiceBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReDiceBtn)
	self.ConfirmResultBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmResultBtn)
end

function DiceGameUI:OnPause()
	return
end

function DiceGameUI:OnResume()
	return
end

function DiceGameUI:OnCover()
	return
end

function DiceGameUI:OnReveal()
	return
end

function DiceGameUI:OnRefocus(userData)
	return
end

function DiceGameUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.ShowStartTime > 0 then
		local elapsedTime = UnityEngine.Time.realtimeSinceStartup - self.ShowStartTime

		for i = 1, #self.Dices do
			if self.ChangedDice[i] and elapsedTime >= self.RandomDelays[i] then
				local dice = self.Dices[i]

				dice:Play(self.DiceResults[i])

				self.ChangedDice[i] = false
			end
		end

		local activeNum = 0

		for i = 1, #self.ChangedDice do
			if not self.ChangedDice[i] then
				activeNum = activeNum + 1
			end
		end

		if activeNum >= #self.Dices then
			self.ShowStartTime = 0
			self.ShowResultTimer = Timer.New(function()
				self.ShowResultTimer = nil

				self:ShowConfirmPanel()
			end, 2)

			self.ShowResultTimer:Start()
		end
	end
end

function DiceGameUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	for i = 1, #self.Dices do
		local dice = self.Dices[i]

		dice:SetSortingOrder(uiGroupDepth * 1000 + depthInUIGroup * 10 + 1)
	end
end

function DiceGameUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DiceGameUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DiceGameUI:OnDestroy()
	self.IntroductionController:Dispose()

	for i = 1, #self.Dices do
		local diceController = self.Dices[i]

		diceController:Dispose()
	end
end

function DiceGameUI:UpdateView(judgeCid)
	self.CfgMazeJudgeData = CfgMazeJudgeTable[judgeCid]
	self.ReDiceCount = self.CfgMazeJudgeData.ReDiceCount

	local target = self.CfgMazeJudgeData.TargetPoints

	self.TargetPoints = target

	self:Reset()
	self.IntroductionController:SetData(self.CfgMazeJudgeData)
end

function DiceGameUI:Reset()
	self.StartBtn:SetActive(true)
	self.ConfirmView:SetActive(false)
	self.ResultView:SetActive(false)
	self.ReDiceCountText:SetActive(false)
	self.DiceArea:SetActive(false)
end

function DiceGameUI:OnClickStartBtn()
	self.DiceComplete = false

	self.StartBtn:SetActive(false)
	self.DiceArea:SetActive(true)
	self:Dice()
end

function DiceGameUI:Dice(changeIndexes)
	local diceResults, changeDice = self:CalcRandomDiceResult(self.DiceResults, changeIndexes)

	self.DiceResults = diceResults

	for i = 1, #self.Dices do
		local dice = self.Dices[i]

		dice:SetSelect(false)
	end

	if changeIndexes == nil then
		for i = 1, #self.Dices do
			local dice = self.Dices[i]

			dice:SetPoint(self.DiceResults[i])
		end

		UIUtil.PlayDefaultAnim(self.DiceArea)

		self.ShowResultTimer = Timer.New(function()
			self.ShowResultTimer = nil

			self:ShowConfirmPanel()
		end, 1.5)

		self.ShowResultTimer:Start()

		return
	end

	self.ChangedDice = changeDice

	local changedDiceDelays = {}
	local index = 1

	for i = 1, #self.DiceResults do
		if self.ChangedDice[i] then
			table.insert(changedDiceDelays, index * self.RandomDelayInterval)

			index = index + 1
		end
	end

	table.shuffle(changedDiceDelays)

	index = 1

	for i = 1, #self.DiceResults do
		if self.ChangedDice[i] then
			self.RandomDelays[i] = changedDiceDelays[index]
			index = index + 1
		else
			self.RandomDelays[i] = 0
		end
	end

	self.ShowStartTime = UnityEngine.Time.realtimeSinceStartup

	GameEntry.Sound:PlaySound(10511, Constant.SoundGroup.UI)
end

function DiceGameUI:CalcRandomDiceResult(currentDiceResults, changeIndexes)
	local diceResults = currentDiceResults
	local changeDice = {}

	for i = 1, #self.Dices do
		if changeIndexes == nil or table.indexOf(changeIndexes, i) ~= -1 then
			diceResults[i] = math.random(1, 6)
			changeDice[i] = true
		else
			changeDice[i] = false
		end
	end

	return diceResults, changeDice
end

function DiceGameUI:OnTapGesture(gesture)
	if not self.DiceComplete or self.ReDiceCount == 0 then
		return
	end

	if gesture.State ~= DigitalRubyShared.GestureRecognizerState.Ended then
		return
	end

	local canvas = self.UIController:GetComponent("Canvas")
	local hits = LuaCodeInterface.RaycastAll(canvas.worldCamera:ScreenToWorldPoint(Vector3(gesture.FocusX, gesture.FocusY, 0)), Vector2.zero)

	for i = 0, hits.Length - 1 do
		local hit = hits[i]

		if hit.collider ~= nil then
			local found = false

			for j = 1, #self.Dices do
				if self.Dices[j].View == hit.collider.gameObject then
					self:TapDice(j)

					found = true

					break
				end
			end

			if found then
				break
			end
		end
	end
end

function DiceGameUI:TapDice(index)
	local selectNum = 0

	for i = 1, #self.Dices do
		local dice = self.Dices[i]

		selectNum = selectNum + (dice.IsSelect and 1 or 0)
	end

	local chooseDice = self.Dices[index]

	if not chooseDice.IsSelect and selectNum >= DiceGameUI.TOP_RE_DICE_NUM then
		return
	end

	chooseDice:SetSelect(not chooseDice.IsSelect)

	selectNum = selectNum + (chooseDice.IsSelect and 1 or -1)
	self.ReDiceBtn:GetComponent("Button").interactable = selectNum > 0

	UGUIUtil.SetText(self.ReDiceCountText, DiceGameUIApi:GetString("ReDiceCountText", selectNum, DiceGameUI.TOP_RE_DICE_NUM))
end

function DiceGameUI:ShowConfirmPanel()
	self.DiceComplete = true

	self.ConfirmView:SetActive(true)
	self.ReDiceBtn:SetActive(self.ReDiceCount > 0)
	self.ReDiceCountText:SetActive(self.ReDiceCount > 0)

	if self.ReDiceCount > 0 then
		self.ReDiceBtn:GetComponent("Button").interactable = false

		UGUIUtil.SetText(self.ReDiceCountText, DiceGameUIApi:GetString("ReDiceCountText", 0, DiceGameUI.TOP_RE_DICE_NUM))
	end
end

function DiceGameUI:OnClickReDiceBtn()
	local reDiceIndexes = {}

	for i = 1, #self.Dices do
		local dice = self.Dices[i]

		if dice.IsSelect then
			table.insert(reDiceIndexes, i)
		end
	end

	if #reDiceIndexes == 0 then
		return
	end

	self.DiceComplete = false

	self.ConfirmView:SetActive(false)
	self.ReDiceCountText:SetActive(false)
	self:Dice(reDiceIndexes)

	self.ReDiceCount = self.ReDiceCount - 1
end

function DiceGameUI:OnClickConfirmResultBtn()
	self.ConfirmView:SetActive(false)
	self.ResultView:SetActive(true)

	self.IsWinning = self:CalcGameResult()

	self.SuccessView:SetActive(self.IsWinning)
	self.FailView:SetActive(not self.IsWinning)

	for i = 1, #self.Dices do
		local dice = self.Dices[i]

		dice:SetSelect(false)
	end
end

function DiceGameUI:CalcGameResult()
	local cfgFormatOrder = DiceGameUIApi:GetString("ResultOrder")
	local resultDataList, resultFormat = self:AnalysisPoints(self.DiceResults)
	local resultFormatIndex = table.indexOf(cfgFormatOrder, resultFormat)
	local targetDataList, targetFormat = self:AnalysisPoints(self.TargetPoints)
	local targetFormatIndex = table.indexOf(cfgFormatOrder, targetFormat)

	if resultFormatIndex == -1 or targetFormatIndex == -1 then
		logError("计算出的格式序列是-1")

		return false
	end

	if resultFormatIndex ~= targetFormatIndex then
		return resultFormatIndex < targetFormatIndex
	end

	local isBigger = false

	for i = 1, #resultDataList do
		local resultData = resultDataList[i]
		local targetData = targetDataList[i]

		if resultData.num ~= targetData.num then
			isBigger = resultData.num > targetData.num

			break
		end
	end

	return isBigger
end

function DiceGameUI:AnalysisPoints(points)
	local numCounts = {}

	for i = 1, #points do
		local point = points[i]

		numCounts[point] = numCounts[point] or 0
		numCounts[point] = numCounts[point] + 1
	end

	local dataList = {}

	for num, count in pairs(numCounts) do
		table.insert(dataList, {
			num = num,
			count = count
		})
	end

	table.sort(dataList, function(data1, data2)
		local count1 = numCounts[data1.num]
		local count2 = numCounts[data2.num]

		if count1 == count2 then
			return data1.num > data2.num
		end

		return data1.count > data2.count
	end)

	if #dataList == 5 then
		local isStraight = true

		for i = 1, #dataList - 1 do
			local biggerData = dataList[i]
			local smallerData = dataList[i + 1]

			if biggerData.num - smallerData.num ~= 1 then
				isStraight = false

				break
			end
		end

		if isStraight then
			return dataList, "STRAIGHT"
		end
	end

	local formatOrder = {
		"A",
		"B",
		"C",
		"D",
		"E"
	}
	local dataFormat = ""

	for i = 1, #dataList do
		local data = dataList[i]

		for j = 1, data.count do
			dataFormat = dataFormat .. formatOrder[i]
		end
	end

	return dataList, dataFormat
end

function DiceGameUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_END_JUDGE, {
		Success = self.IsWinning
	})

	self.IsWinning = nil
end

return DiceGameUI
