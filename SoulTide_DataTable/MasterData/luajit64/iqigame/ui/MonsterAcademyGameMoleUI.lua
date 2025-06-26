-- chunkname: @IQIGame\\UI\\MonsterAcademyGameMoleUI.lua

local WhacAMoleGameController = require("IQIGame.UI.MonsterAcademyGame.WhacAMoleGameController")
local MonsterAcademyGameTimerElement = require("IQIGame.UI.MonsterAcademyGame.MonsterAcademyGameTimerElement")
local MonsterAcademyGameResultElement = require("IQIGame.UI.MonsterAcademyGame.MonsterAcademyGameResultElement")
local MonsterAcademyGameMoleUI = {
	callbackData = {
		targetScore = 0,
		success = false,
		score = 0
	}
}

MonsterAcademyGameMoleUI = Base:Extend("MonsterAcademyGameMoleUI", "IQIGame.Onigao.UI.MonsterAcademyGameMoleUI", MonsterAcademyGameMoleUI)

function MonsterAcademyGameMoleUI:OnInit()
	self.monsterAcademyGameTimerElement = MonsterAcademyGameTimerElement.New(self.TimeRoot, MonsterAcademyGameMoleUIApi)
	self.monsterAcademyGameResultElement = MonsterAcademyGameResultElement.New(self.ResultView, MonsterAcademyGameMoleUIApi)
	self.scoreText1 = self.goScoreText1.gameObject:GetComponent("Text")
	self.scoreText2 = self.goScoreText2.gameObject:GetComponent("Text")
	self.goScoreTitleText:GetComponent("Text").text = MonsterAcademyGameMoleUIApi:GetString("GetScoreTitleText")
	self.ExitBtnText:GetComponent("UnityEngine.UI.Text").text = MonsterAcademyGameMoleUIApi:GetString("GetExitButtonText")
	self.StartBtnText:GetComponent("UnityEngine.UI.Text").text = MonsterAcademyGameMoleUIApi:GetString("GetStartButtonText")

	function self.DelegateOnClickgoBtnStart()
		self:OnClickgoBtnStart()
	end

	function self.DelegateOnClickgoBtnClose()
		self:__OnCloseButtonClickedHandler()
	end

	function self.DelegateOnClickBtnBack()
		self:__OnBackButtonClickHandler()
	end
end

function MonsterAcademyGameMoleUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyGameMoleUI:GetOpenPreloadAssetPaths(userData)
	self.gameResultCallback = userData.callback
	self.gameConfig = CfgGalgameMonsterQTETable[userData.gameId]

	return nil
end

function MonsterAcademyGameMoleUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyGameMoleUI:GetBGM(userData)
	return self.gameConfig.BGM
end

function MonsterAcademyGameMoleUI:OnOpen(userData)
	self.whacAMoleGameController = WhacAMoleGameController.New(self.goClickView)

	self.monsterAcademyGameTimerElement:SetTotalTime(self.gameConfig.time, function()
		self:__OnGameFailed()
	end)
	self.monsterAcademyGameResultElement:ResetShow()
	self.goBtnStart.gameObject:SetActive(true)

	self.scoreText2.text = MonsterAcademyGameMoleUIApi:GetString("GetScoreText", self.whacAMoleGameController.TotalScore)
	self.scoreText1.text = MonsterAcademyGameMoleUIApi:GetString("GetTargetScoreText", self.gameConfig.SucScore)
end

function MonsterAcademyGameMoleUI:OnClose(userData)
	if self.whacAMoleGameController ~= nil then
		self.whacAMoleGameController:OnDestroy()

		self.whacAMoleGameController = nil
	end

	self.gameResultCallback(self.callbackData)
end

function MonsterAcademyGameMoleUI:OnAddListeners()
	self.goBtnStart:GetComponent("Button").onClick:AddListener(self.DelegateOnClickgoBtnStart)
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickgoBtnClose)
	self.goBtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
end

function MonsterAcademyGameMoleUI:OnRemoveListeners()
	self.goBtnStart:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickgoBtnStart)
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickgoBtnClose)
	self.goBtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
end

function MonsterAcademyGameMoleUI:OnPause()
	return
end

function MonsterAcademyGameMoleUI:OnResume()
	return
end

function MonsterAcademyGameMoleUI:OnCover()
	return
end

function MonsterAcademyGameMoleUI:OnReveal()
	return
end

function MonsterAcademyGameMoleUI:OnRefocus(userData)
	return
end

function MonsterAcademyGameMoleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.whacAMoleGameController == nil then
		return
	end

	self.scoreText2.text = MonsterAcademyGameMoleUIApi:GetString("GetScoreText", self.whacAMoleGameController.TotalScore)
end

function MonsterAcademyGameMoleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyGameMoleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyGameMoleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyGameMoleUI:OnDestroy()
	self.monsterAcademyGameTimerElement:OnDestroy()

	self.monsterAcademyGameTimerElement = nil

	self.monsterAcademyGameResultElement:OnDestroy()

	self.monsterAcademyGameResultElement = nil
end

function MonsterAcademyGameMoleUI:OnClickgoBtnStart()
	self.goBtnStart.gameObject:SetActive(false)
	self.whacAMoleGameController:StartGame(self.gameConfig, function()
		self:__OnGameSuccess()
	end)
	self.monsterAcademyGameTimerElement:StartTime()
end

function MonsterAcademyGameMoleUI:__OnCloseButtonClickedHandler()
	UIModule.Close(Constant.UIControllerName.MonsterAcademyGameMoleUI)
end

function MonsterAcademyGameMoleUI:__OnBackButtonClickHandler()
	self:__OnGameFailed()
end

function MonsterAcademyGameMoleUI:__EndGame()
	self.whacAMoleGameController:StopGame()
	self.monsterAcademyGameTimerElement:StopTime()
end

function MonsterAcademyGameMoleUI:__OnGameSuccess()
	self:__EndGame()
	self.monsterAcademyGameResultElement:ShowScore(self.gameConfig.SucScore, self.whacAMoleGameController.TotalScore)
	self.monsterAcademyGameResultElement:ShowSuccess()

	self.callbackData = {
		success = true,
		targetScore = self.gameConfig.SucScore,
		score = self.whacAMoleGameController.TotalScore
	}
end

function MonsterAcademyGameMoleUI:__OnGameFailed()
	self:__EndGame()
	self.monsterAcademyGameResultElement:ShowScore(self.gameConfig.SucScore, self.whacAMoleGameController.TotalScore)
	self.monsterAcademyGameResultElement:ShowFail()

	self.callbackData = {
		success = false,
		targetScore = self.gameConfig.SucScore,
		score = self.whacAMoleGameController.TotalScore
	}
end

return MonsterAcademyGameMoleUI
