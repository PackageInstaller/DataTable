-- chunkname: @IQIGame\\UI\\RestaurantGameAnswerUI.lua

local RestaurantGameAnswerUI = {
	answerGameOptionCells = {}
}

RestaurantGameAnswerUI = Base:Extend("RestaurantGameAnswerUI", "IQIGame.Onigao.UI.RestaurantGameAnswerUI", RestaurantGameAnswerUI)

require("IQIGame.UIExternalApi.RestaurantGameAnswerUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AnswerGameResultView = require("IQIGame.UI.ExploreHall.RestaurantOperation.AnswerGame.AnswerGameResultView")
local AnswerGameOptionCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.AnswerGame.AnswerGameOptionCell")

function RestaurantGameAnswerUI:OnInit()
	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.UpdateAnswerGame()
		self:OnUpdateAnswerGame()
	end

	function self.DelegateBtnSubmit()
		self:OnBtnSubmit()
	end

	function self.DelegateBtnNext()
		self:OnBtnNext()
	end

	function self.DelegateUpdateDailySupply()
		self:OnUpdateDailySupply()
	end

	self.OptionBtnPrefab:SetActive(false)

	self.answerGameOptionCellPool = UIObjectPool.New(6, function()
		local cell = AnswerGameOptionCell.New(UnityEngine.Object.Instantiate(self.OptionBtnPrefab))

		function cell.selectCallBack(cell)
			self:OnSelect(cell)
		end

		return cell
	end, function(cell)
		cell:Dispose()
	end)
	self.answerGameResultView = AnswerGameResultView.New(self.ResultView)

	self.answerGameResultView:Close()

	self.timer = Timer.New(function()
		self:ShowCD()
	end, 1, -1)
end

function RestaurantGameAnswerUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantGameAnswerUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantGameAnswerUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantGameAnswerUI:GetBGM(userData)
	return nil
end

function RestaurantGameAnswerUI:OnOpen(userData)
	self:UpdateView()
end

function RestaurantGameAnswerUI:OnClose(userData)
	if self.timer then
		self.timer:Stop()
	end
end

function RestaurantGameAnswerUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.BtnSubmit:GetComponent("Button").onClick:AddListener(self.DelegateBtnSubmit)
	self.BtnNext:GetComponent("Button").onClick:AddListener(self.DelegateBtnNext)
	EventDispatcher.AddEventListener(EventID.ROUpdateAnswerGameEvent, self.UpdateAnswerGame)
	EventDispatcher.AddEventListener(EventID.UpdateDailySupply, self.DelegateUpdateDailySupply)
end

function RestaurantGameAnswerUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.BtnSubmit:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSubmit)
	self.BtnNext:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnNext)
	EventDispatcher.RemoveEventListener(EventID.ROUpdateAnswerGameEvent, self.UpdateAnswerGame)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailySupply, self.DelegateUpdateDailySupply)
end

function RestaurantGameAnswerUI:OnPause()
	return
end

function RestaurantGameAnswerUI:OnResume()
	return
end

function RestaurantGameAnswerUI:OnCover()
	return
end

function RestaurantGameAnswerUI:OnReveal()
	return
end

function RestaurantGameAnswerUI:OnRefocus(userData)
	return
end

function RestaurantGameAnswerUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantGameAnswerUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantGameAnswerUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantGameAnswerUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantGameAnswerUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.answerGameResultView:Dispose()

	self.answerGameResultView = nil

	for i, v in pairs(self.answerGameOptionCells) do
		self.answerGameOptionCellPool:Release(v)
	end

	self.answerGameOptionCells = {}

	self.answerGameOptionCellPool:Dispose()

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil
end

function RestaurantGameAnswerUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function RestaurantGameAnswerUI:OnUpdateAnswerGame()
	self:UpdateView()
end

function RestaurantGameAnswerUI:UpdateView()
	self.selectOption = nil
	self.answerQuestionData = ROAnswerGameModule.answerQuestionData

	local maxNum = ROAnswerGameModule.cfgAnswerControlData.Num
	local isFinish = maxNum <= self.answerQuestionData.questionPOD.number and self.answerQuestionData.questionPOD.state > 0

	if isFinish then
		self.ContentView:SetActive(false)
		self.answerGameResultView:Open()
	else
		self.ContentView:SetActive(true)
		self.answerGameResultView:Close()
		UGUIUtil.SetText(self.TextQuestion, self.answerQuestionData:GetCfgData().Problem)
		UGUIUtil.SetText(self.TextSchedule, RestaurantGameAnswerUIApi:GetString("TextSchedule", self.answerQuestionData.questionPOD.number, maxNum, self.answerQuestionData.questionPOD.rightNumber))
		self.BtnNext:SetActive(self.answerQuestionData.questionPOD.state > 0)
		self.BtnSubmit:SetActive(self.answerQuestionData.questionPOD.state == 0)

		for i, v in pairs(self.answerGameOptionCells) do
			v.View.transform:SetParent(self.UIController.transform, false)
			v.View:SetActive(false)
			self.answerGameOptionCellPool:Release(v)
		end

		self.answerGameOptionCells = {}

		local options = self.answerQuestionData.options

		for i = 1, #options do
			local data = options[i]
			local cell = self.answerGameOptionCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.GridSlot.transform, false)
			cell:SetData(data)
			table.insert(self.answerGameOptionCells, cell)
		end

		local cd = math.floor(self.answerQuestionData.questionPOD.date / 1000 + ROAnswerGameModule.cfgAnswerControlData.Countdown - PlayerModule.GetServerTime())

		self.timer:Stop()

		if cd > 0 and self.answerQuestionData.questionPOD.state == 0 then
			self.timer:Start()
			self:ShowCD()
		else
			cd = 0
		end

		UGUIUtil.SetText(self.TextTime, cd)
	end
end

function RestaurantGameAnswerUI:ShowCD()
	local cd = math.floor(self.answerQuestionData.questionPOD.date / 1000 + ROAnswerGameModule.cfgAnswerControlData.Countdown - PlayerModule.GetServerTime())

	if cd >= 0 then
		UGUIUtil.SetText(self.TextTime, cd)
	else
		self.timer:Stop()
		log("时间到。。。")
		ROAnswerGameModule.Answer(self.selectOption)
	end
end

function RestaurantGameAnswerUI:OnSelect(cell)
	if self.answerQuestionData.questionPOD.state > 0 then
		return
	end

	for i, v in pairs(self.answerGameOptionCells) do
		v:SetSelect(v.optionData.id == cell.optionData.id)
	end

	self.selectOption = cell.optionData
end

function RestaurantGameAnswerUI:OnUpdateDailySupply()
	ROAnswerGameModule.GetProblem(true, function()
		self:UpdateView()
	end)
end

function RestaurantGameAnswerUI:OnBtnSubmit()
	if self.selectOption == nil then
		return
	end

	ROAnswerGameModule.Answer(self.selectOption)

	if self.timer then
		self.timer:Stop()
	end
end

function RestaurantGameAnswerUI:OnBtnNext()
	if self.answerQuestionData.questionPOD.state == 0 then
		return
	end

	ROAnswerGameModule.GetProblem(true, function()
		self:UpdateView()
	end)
end

return RestaurantGameAnswerUI
