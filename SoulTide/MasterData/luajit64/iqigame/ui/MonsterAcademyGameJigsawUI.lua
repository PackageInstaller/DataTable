-- chunkname: @IQIGame\\UI\\MonsterAcademyGameJigsawUI.lua

local JigsawGameController = require("IQIGame.UI.MonsterAcademyGame.JigsawGameController")
local MonsterAcademyGameTimerElement = require("IQIGame.UI.MonsterAcademyGame.MonsterAcademyGameTimerElement")
local MonsterAcademyGameResultElement = require("IQIGame.UI.MonsterAcademyGame.MonsterAcademyGameResultElement")
local MonsterAcademyGameJigsawUI = {
	callbackData = {
		totalTime = 0,
		success = false,
		lastTime = 0
	}
}

MonsterAcademyGameJigsawUI = Base:Extend("MonsterAcademyGameJigsawUI", "IQIGame.Onigao.UI.MonsterAcademyGameJigsawUI", MonsterAcademyGameJigsawUI)

function MonsterAcademyGameJigsawUI:OnInit()
	self.monsterAcademyGameTimerElement = MonsterAcademyGameTimerElement.New(self.TimeRoot, MonsterAcademyGameJigsawUIApi)
	self.monsterAcademyGameResultElement = MonsterAcademyGameResultElement.New(self.ResultView, MonsterAcademyGameJigsawUIApi)
	self.TipsText:GetComponent("UnityEngine.UI.Text").text = MonsterAcademyGameJigsawUIApi:GetString("GetMoveErrorTips")
	self.ExitBtnText:GetComponent("UnityEngine.UI.Text").text = MonsterAcademyGameJigsawUIApi:GetString("GetExitButtonText")
	self.StartBtnText:GetComponent("UnityEngine.UI.Text").text = MonsterAcademyGameJigsawUIApi:GetString("GetStartButtonText")

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickStartBtn()
		self:OnClickStartBtn()
	end

	function self.DelegateOnClickPauseBtn()
		self:OnClickPauseBtn()
	end

	function self.DelegateOnClickGiveUpBtn()
		self:OnClickGiveUpBtn()
	end
end

function MonsterAcademyGameJigsawUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyGameJigsawUI:GetOpenPreloadAssetPaths(userData)
	self.gameConfig = CfgGalgameMonsterJigsawTable[userData.gameId]
	self.gameResultCallback = userData.callback

	local paths = {}

	table.insert(paths, UIGlobalApi.GetImagePath(self.gameConfig.ImageBg))

	return paths
end

function MonsterAcademyGameJigsawUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyGameJigsawUI:GetBGM(userData)
	return self.gameConfig.BGM
end

function MonsterAcademyGameJigsawUI:__ResetUI()
	self.Squares_6.gameObject:SetActive(false)
	self.Squares_9.gameObject:SetActive(false)
	self.Squares_16.gameObject:SetActive(false)
	self.TipsRoot.gameObject:SetActive(false)
	self.monsterAcademyGameResultElement:ResetShow()
	self.StartBtn.gameObject:SetActive(true)
end

function MonsterAcademyGameJigsawUI:OnOpen(userData)
	self:__ResetUI()
	self.monsterAcademyGameTimerElement:SetTotalTime(self.gameConfig.time, function()
		self:__OnGameFailed()
	end)

	local asset = self.UIController:GetPreloadedAsset(UIGlobalApi.GetImagePath(self.gameConfig.ImageBg))
	local img = UnityEngine.Object.Instantiate(asset)
	local ratioW = 1
	local ratioH = 1

	if self.gameConfig.Grade[1] == 3 and self.gameConfig.Grade[2] == 2 then
		self.jigsawGameController = JigsawGameController.New(self.Squares_6, 3, 2)
		ratioW = 536 / img.texture.width
		ratioH = 352 / img.texture.height
	elseif self.gameConfig.Grade[1] == 3 and self.gameConfig.Grade[2] == 3 then
		self.jigsawGameController = JigsawGameController.New(self.Squares_9, 3, 3)
		ratioW = 481 / img.texture.width
		ratioH = 487 / img.texture.height
	elseif self.gameConfig.Grade[1] == 4 and self.gameConfig.Grade[2] == 4 then
		self.jigsawGameController = JigsawGameController.New(self.Squares_16, 4, 4)
		ratioW = 527 / img.texture.width
		ratioH = 526 / img.texture.height
	else
		logError("找不到游戏难度配置：" .. tostring(self.gameConfig.Grade[1]) .. "|" .. tostring(self.gameConfig.Grade[2]))

		self.jigsawGameController = JigsawGameController.New(self.Squares_16, 4, 4)
	end

	function self.jigsawGameController.GameSuccessEvent()
		self:__OnGameSuccess()
	end

	function self.jigsawGameController.ShowNoticeEvent(msg)
		self:ShowTips()
	end

	local srcTexture = self.SrcImage:GetComponent("UnityEngine.UI.RawImage")

	srcTexture.texture = img.texture
	srcTexture.uvRect = UnityEngine.Rect(0, 0, ratioW, ratioH)

	self.SrcImage.gameObject:SetActive(true)
	self.jigsawGameController:SetData(img.texture, ratioW, ratioH)
end

function MonsterAcademyGameJigsawUI:OnClose(userData)
	self.jigsawGameController:OnDestroy()

	self.jigsawGameController = nil

	self.gameResultCallback(self.callbackData)
end

function MonsterAcademyGameJigsawUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.StartBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStartBtn)
	self.PauseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPauseBtn)
	self.GiveUpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGiveUpBtn)
end

function MonsterAcademyGameJigsawUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.StartBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStartBtn)
	self.PauseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPauseBtn)
	self.GiveUpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGiveUpBtn)
end

function MonsterAcademyGameJigsawUI:OnPause()
	return
end

function MonsterAcademyGameJigsawUI:OnResume()
	return
end

function MonsterAcademyGameJigsawUI:OnCover()
	return
end

function MonsterAcademyGameJigsawUI:OnReveal()
	return
end

function MonsterAcademyGameJigsawUI:OnRefocus(userData)
	return
end

function MonsterAcademyGameJigsawUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyGameJigsawUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyGameJigsawUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyGameJigsawUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyGameJigsawUI:OnDestroy()
	self.monsterAcademyGameTimerElement:OnDestroy()

	self.monsterAcademyGameTimerElement = nil

	self.monsterAcademyGameResultElement:OnDestroy()

	self.monsterAcademyGameResultElement = nil
end

function MonsterAcademyGameJigsawUI:ShowTips()
	if self.TipsRoot.gameObject.activeSelf then
		return
	end

	self.TipsRoot.gameObject.transform.localScale = Vector3.one

	self.TipsRoot.gameObject:SetActive(true)
	Timer.New(function()
		LuaCodeInterface.TweenScale(self.TipsRoot.gameObject, 0.15, Vector3.one, Vector3.zero, function(go)
			self.TipsRoot.gameObject:SetActive(false)
		end)
	end, 1):Start()
end

function MonsterAcademyGameJigsawUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.MonsterAcademyGameJigsawUI)
end

function MonsterAcademyGameJigsawUI:OnClickStartBtn()
	self.StartBtn.gameObject:SetActive(false)
	self:__StartGame()
end

function MonsterAcademyGameJigsawUI:OnClickGiveUpBtn()
	self:__OnGameFailed()
end

function MonsterAcademyGameJigsawUI:OnClickPauseBtn()
	local pause = self.SrcImage.gameObject.activeSelf

	self.SrcImage.gameObject:SetActive(not pause)

	self.monsterAcademyGameTimerElement.IsPaused = not pause
end

function MonsterAcademyGameJigsawUI:__StartGame()
	self.SrcImage.gameObject:SetActive(false)
	self.monsterAcademyGameTimerElement:StartTime()
	self.jigsawGameController:StartGame()
end

function MonsterAcademyGameJigsawUI:__EndGame()
	self.jigsawGameController:EndGame()
	self.monsterAcademyGameTimerElement:StopTime()
end

function MonsterAcademyGameJigsawUI:__OnGameSuccess()
	self:__EndGame()
	self.monsterAcademyGameResultElement:ShowSuccess()

	self.callbackData = {
		success = true,
		totalTime = self.monsterAcademyGameTimerElement.totalTime,
		lastTime = self.monsterAcademyGameTimerElement.lastTime
	}
end

function MonsterAcademyGameJigsawUI:__OnGameFailed()
	self:__EndGame()
	self.monsterAcademyGameResultElement:ShowFail()

	self.callbackData = {
		success = false,
		totalTime = self.monsterAcademyGameTimerElement.totalTime,
		lastTime = self.monsterAcademyGameTimerElement.lastTime
	}
end

return MonsterAcademyGameJigsawUI
