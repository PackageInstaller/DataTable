-- chunkname: @IQIGame\\UI\\AmusementParkGameAnswerUI.lua

local AmusementParkGameAnswerUI = {
	answerGameOptionCells = {}
}

AmusementParkGameAnswerUI = Base:Extend("AmusementParkGameAnswerUI", "IQIGame.Onigao.UI.AmusementParkGameAnswerUI", AmusementParkGameAnswerUI)

require("IQIGame.UIExternalApi.AmusementParkGameAnswerUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkAnswerGameResultView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkAnswerGame.AmusementParkAnswerGameResultView")
local AmusementParkAnswerGameOptionCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkAnswerGame.AmusementParkAnswerGameOptionCell")

function AmusementParkGameAnswerUI:OnInit()
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

	self.OptionBtnPrefab:SetActive(false)

	self.answerGameOptionCellPool = UIObjectPool.New(6, function()
		local cell = AmusementParkAnswerGameOptionCell.New(UnityEngine.Object.Instantiate(self.OptionBtnPrefab))

		function cell.selectCallBack(cell)
			self:OnSelect(cell)
		end

		return cell
	end, function(cell)
		cell:Dispose()
	end)
	self.AmusementParkAnswerGameResultView = AmusementParkAnswerGameResultView.New(self.ResultView)

	self.AmusementParkAnswerGameResultView:Close()

	self.timer = Timer.New(function()
		self:ShowCD()
	end, 1, -1)
end

function AmusementParkGameAnswerUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkGameAnswerUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkGameAnswerUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkGameAnswerUI:GetBGM(userData)
	return nil
end

function AmusementParkGameAnswerUI:OnOpen(userData)
	self:UpdateView()
end

function AmusementParkGameAnswerUI:OnClose(userData)
	if self.timer then
		self.timer:Stop()
	end
end

function AmusementParkGameAnswerUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.BtnSubmit:GetComponent("Button").onClick:AddListener(self.DelegateBtnSubmit)
	self.BtnNext:GetComponent("Button").onClick:AddListener(self.DelegateBtnNext)
	EventDispatcher.AddEventListener(EventID.APUpdateAnswerGameEvent, self.UpdateAnswerGame)
end

function AmusementParkGameAnswerUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.BtnSubmit:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSubmit)
	self.BtnNext:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnNext)
	EventDispatcher.RemoveEventListener(EventID.APUpdateAnswerGameEvent, self.UpdateAnswerGame)
end

function AmusementParkGameAnswerUI:OnPause()
	return
end

function AmusementParkGameAnswerUI:OnResume()
	return
end

function AmusementParkGameAnswerUI:OnCover()
	return
end

function AmusementParkGameAnswerUI:OnReveal()
	return
end

function AmusementParkGameAnswerUI:OnRefocus(userData)
	return
end

function AmusementParkGameAnswerUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkGameAnswerUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkGameAnswerUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkGameAnswerUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkGameAnswerUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.AmusementParkAnswerGameResultView:Dispose()

	self.AmusementParkAnswerGameResultView = nil

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

function AmusementParkGameAnswerUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function AmusementParkGameAnswerUI:OnUpdateAnswerGame()
	self:UpdateView()
end

function AmusementParkGameAnswerUI:UpdateView()
	self.selectOption = nil
	self.answerQuestionData = AmusementParkAnswerGameModule.answerQuestionData

	local maxNum = #AmusementParkAnswerGameModule.cfgAnswerControlData.QuestionBank
	local rightNum = AmusementParkAnswerGameModule.rightCount
	local isFinish = maxNum <= rightNum

	if isFinish then
		self.ContentView:SetActive(false)
		self.AmusementParkAnswerGameResultView:Open()
	else
		self.ContentView:SetActive(true)
		self.AmusementParkAnswerGameResultView:Close()
		UGUIUtil.SetText(self.TextQuestion, self.answerQuestionData:GetCfgData().Problem)
		UGUIUtil.SetText(self.TextSchedule, AmusementParkGameAnswerUIApi:GetString("TextSchedule", rightNum, maxNum, rightNum))
		self.BtnNext:SetActive(self.answerQuestionData.isComplete)
		self.BtnSubmit:SetActive(not self.answerQuestionData.isComplete and self.answerQuestionData:IsUnlock())
		self.TextLock:SetActive(not self.answerQuestionData.isComplete and not self.answerQuestionData:IsUnlock())

		local needID = self.answerQuestionData:GetCfgData().UnlockBuildingLevel[1]
		local name = CfgAmusementParkBuildingTable[needID].Name
		local needLv = self.answerQuestionData:GetCfgData().UnlockBuildingLevel[2]

		UGUIUtil.SetText(self.TextLock, AmusementParkGameAnswerUIApi:GetString("TextLock", name, needLv))

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

		local cd = AmusementParkAnswerGameModule.GetCoolDownTime()

		self.timer:Stop()
		self.TimeView:SetActive(cd > 0)

		if cd > 0 then
			self.timer:Start()
			self:ShowCD()
			UGUIUtil.SetText(self.TextTime, cd)
		end
	end
end

function AmusementParkGameAnswerUI:ShowCD()
	local cd = AmusementParkAnswerGameModule.GetCoolDownTime()

	self.TimeView:SetActive(cd > 0)

	if cd >= 0 then
		UGUIUtil.SetText(self.TextTime, cd)
	else
		self.timer:Stop()
		UGUIUtil.SetText(self.TextTime, "")
	end
end

function AmusementParkGameAnswerUI:OnSelect(cell)
	if self.answerQuestionData.isComplete or not self.answerQuestionData:IsUnlock() then
		return
	end

	for i, v in pairs(self.answerGameOptionCells) do
		v:SetSelect(v.optionData.id == cell.optionData.id)
	end

	self.selectOption = cell.optionData
end

function AmusementParkGameAnswerUI:OnBtnSubmit()
	if self.selectOption == nil then
		return
	end

	if AmusementParkAnswerGameModule.GetCoolDownTime() > 0 then
		return
	end

	if not self.answerQuestionData:IsUnlock() then
		return
	end

	AmusementParkAnswerGameModule.Answer(self.selectOption)
end

function AmusementParkGameAnswerUI:OnBtnNext()
	AmusementParkAnswerGameModule.AnswerInfo(function()
		self:UpdateView()
	end)
end

return AmusementParkGameAnswerUI
