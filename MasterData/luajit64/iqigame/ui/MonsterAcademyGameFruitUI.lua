-- chunkname: @IQIGame\\UI\\MonsterAcademyGameFruitUI.lua

local FruitGameController = require("IQIGame.UI.MonsterAcademyGame.FruitGameController")
local MonsterAcademyGameTimerElement = require("IQIGame.UI.MonsterAcademyGame.MonsterAcademyGameTimerElement")
local MonsterAcademyGameResultElement = require("IQIGame.UI.MonsterAcademyGame.MonsterAcademyGameResultElement")
local MonsterAcademyGameSourceDisplayElement = require("IQIGame.UI.MonsterAcademyGame.MonsterAcademyGameSourceDisplayElement")
local MonsterAcademyGameFruitUI = {
	scoreDisplayPool = {},
	callbackData = {
		targetScore = 0,
		success = false,
		score = 0
	}
}

MonsterAcademyGameFruitUI = Base:Extend("MonsterAcademyGameFruitUI", "IQIGame.Onigao.UI.MonsterAcademyGameFruitUI", MonsterAcademyGameFruitUI)

function MonsterAcademyGameFruitUI:OnInit()
	self:__InitScoreDisplayElement(10)

	self.monsterAcademyGameTimerElement = MonsterAcademyGameTimerElement.New(self.TimeRoot, MonsterAcademyGameFruitUIApi)
	self.monsterAcademyGameResultElement = MonsterAcademyGameResultElement.New(self.ResultView, MonsterAcademyGameFruitUIApi)
	self.scoreText1 = self.goScoreText1.gameObject:GetComponent("Text")
	self.scoreText2 = self.goScoreText2.gameObject:GetComponent("Text")
	self.goScoreTitleText.gameObject:GetComponent("Text").text = MonsterAcademyGameFruitUIApi:GetString("GetScoreTitleText")
	self.ExitBtnText:GetComponent("UnityEngine.UI.Text").text = MonsterAcademyGameFruitUIApi:GetString("GetExitButtonText")
	self.StartBtnText:GetComponent("UnityEngine.UI.Text").text = MonsterAcademyGameFruitUIApi:GetString("GetStartButtonText")

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickStartBtn()
		self:OnClickStartBtn()
	end

	function self.DelegateOnClickBackBtn()
		self:OnClickBackButton()
	end
end

function MonsterAcademyGameFruitUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyGameFruitUI:GetOpenPreloadAssetPaths(userData)
	self.gameResultCallback = userData.callback
	self.gameConfig = CfgGalgameMonsterPickTable[userData.gameId]

	return nil
end

function MonsterAcademyGameFruitUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyGameFruitUI:GetBGM(userData)
	return self.gameConfig.BGM
end

function MonsterAcademyGameFruitUI:OnOpen(userData)
	self.gameController = FruitGameController.New(self.goGameRoot)

	self.gameController:InitGame(self.gameConfig, function(score, position)
		self:__OnScoreUpdate(score, position)
	end, function()
		self:__OnGameSuccess()
	end)
	self.monsterAcademyGameTimerElement:SetTotalTime(self.gameConfig.time, function()
		self:__OnGameFailed()
	end)
	self.monsterAcademyGameResultElement:ResetShow()
	self.StartBtn.gameObject:SetActive(true)

	self.scoreText2.text = MonsterAcademyGameFruitUIApi:GetString("GetScoreText", self.gameController.TotalScore)
	self.scoreText1.text = MonsterAcademyGameFruitUIApi:GetString("GetTargetScoreText", self.gameConfig.SucScore)
end

function MonsterAcademyGameFruitUI:OnClose(userData)
	if self.gameController ~= nil then
		self.gameController:OnDestroy()

		self.gameController = nil
	end

	self.gameResultCallback(self.callbackData)
end

function MonsterAcademyGameFruitUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.StartBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStartBtn)
	self.Button_Back:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBackBtn)
end

function MonsterAcademyGameFruitUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.StartBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStartBtn)
	self.Button_Back:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBackBtn)
end

function MonsterAcademyGameFruitUI:OnPause()
	return
end

function MonsterAcademyGameFruitUI:OnResume()
	return
end

function MonsterAcademyGameFruitUI:OnCover()
	return
end

function MonsterAcademyGameFruitUI:OnReveal()
	return
end

function MonsterAcademyGameFruitUI:OnRefocus(userData)
	return
end

function MonsterAcademyGameFruitUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.gameController == nil then
		return
	end

	if not self.gameController.IsGaming then
		-- block empty
	end

	self.gameController:OnUpdate(elapseSeconds, realElapseSeconds)

	self.scoreText2.text = MonsterAcademyGameFruitUIApi:GetString("GetScoreText", self.gameController.TotalScore)
end

function MonsterAcademyGameFruitUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyGameFruitUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyGameFruitUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyGameFruitUI:OnDestroy()
	self.monsterAcademyGameTimerElement:OnDestroy()

	self.monsterAcademyGameTimerElement = nil

	self.monsterAcademyGameResultElement:OnDestroy()

	self.monsterAcademyGameResultElement = nil

	for index, elem in pairs(self.scoreDisplayPool) do
		elem:OnDestroy()
	end

	self.scoreDisplayPool = nil
end

function MonsterAcademyGameFruitUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.MonsterAcademyGameFruitUI)
end

function MonsterAcademyGameFruitUI:OnClickStartBtn()
	self.StartBtn.gameObject:SetActive(false)
	self:__StartGame()
end

function MonsterAcademyGameFruitUI:OnClickBackButton()
	self:__OnGameFailed()
end

function MonsterAcademyGameFruitUI:__InitScoreDisplayElement(initCount)
	self.ScoreTemplate.gameObject:SetActive(false)

	for i = 1, initCount do
		local socreDisplayItemGo = UnityEngine.GameObject.Instantiate(self.ScoreTemplate, self.ScoreTemplate.gameObject.transform.parent, true)
		local elem = MonsterAcademyGameSourceDisplayElement.New(socreDisplayItemGo)

		table.insert(self.scoreDisplayPool, elem)
	end
end

function MonsterAcademyGameFruitUI:__GetFreeScoreDisplayItem()
	for index, item in pairs(self.scoreDisplayPool) do
		if not item.ViewRoot.gameObject.activeSelf then
			return item
		end
	end

	return nil
end

function MonsterAcademyGameFruitUI:__StartGame()
	self.monsterAcademyGameTimerElement:StartTime()
	self.gameController:StartGame()
end

function MonsterAcademyGameFruitUI:__EndGame()
	self.gameController:EndGame()
	self.monsterAcademyGameTimerElement:StopTime()
end

function MonsterAcademyGameFruitUI:__OnGameSuccess()
	self:__EndGame()
	self.monsterAcademyGameResultElement:ShowScore(self.gameConfig.SucScore, self.gameController.TotalScore)
	self.monsterAcademyGameResultElement:ShowSuccess()

	self.callbackData = {
		success = true,
		targetScore = self.gameConfig.SucScore,
		score = self.gameController.TotalScore
	}
end

function MonsterAcademyGameFruitUI:__OnScoreUpdate(score, position)
	local item = self:__GetFreeScoreDisplayItem()

	if item == nil then
		return
	end

	item:OnShowScore(score, position)
end

function MonsterAcademyGameFruitUI:__OnGameFailed()
	self:__EndGame()
	self.monsterAcademyGameResultElement:ShowScore(self.gameConfig.SucScore, self.gameController.TotalScore)
	self.monsterAcademyGameResultElement:ShowFail()

	self.callbackData = {
		success = false,
		targetScore = self.gameConfig.SucScore,
		score = self.gameController.TotalScore
	}
end

return MonsterAcademyGameFruitUI
