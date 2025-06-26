-- chunkname: @IQIGame\\UI\\LunaMazeSettlementUI.lua

local LunaMazeSettlementUI = {
	SuitItems = {}
}

LunaMazeSettlementUI = Base:Extend("LunaMazeSettlementUI", "IQIGame.Onigao.UI.LunaMazeSettlementUI", LunaMazeSettlementUI)

require("IQIGame.UIExternalApi.LunaMazeSettlementUIApi")

local EndlessMazeRuneSuitItem = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneSuitItem")

function LunaMazeSettlementUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	for i = 1, 6 do
		local item = EndlessMazeRuneSuitItem.New(UnityEngine.Object.Instantiate(self.RuneSuitItemPrefab))

		item.View.transform:SetParent(self.RuneSuitGrid.transform, false)

		self.SuitItems[i] = item
	end

	local titleText1, titleText2 = LunaMazeSettlementUIApi:GetString("TitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
	UGUIUtil.SetText(self.ScoreLabel, LunaMazeSettlementUIApi:GetString("ScoreLabel"))
	UGUIUtil.SetText(self.DangerLabel, LunaMazeSettlementUIApi:GetString("DangerLabel"))
	UGUIUtil.SetTextInChildren(self.CloseBtn, LunaMazeSettlementUIApi:GetString("CloseBtnText"))
end

function LunaMazeSettlementUI:GetPreloadAssetPaths()
	return nil
end

function LunaMazeSettlementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LunaMazeSettlementUI:IsManualShowOnOpen(userData)
	return false
end

function LunaMazeSettlementUI:GetBGM(userData)
	return nil
end

function LunaMazeSettlementUI:OnOpen(userData)
	self:Reset()
	self.MainPanel:SetActive(true)
	self:UpdateView()
end

function LunaMazeSettlementUI:OnClose(userData)
	ModuleTimerUtil.Stop(Constant.UIControllerName.LunaMazeSettlementUI)
end

function LunaMazeSettlementUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function LunaMazeSettlementUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function LunaMazeSettlementUI:OnPause()
	return
end

function LunaMazeSettlementUI:OnResume()
	return
end

function LunaMazeSettlementUI:OnCover()
	return
end

function LunaMazeSettlementUI:OnReveal()
	return
end

function LunaMazeSettlementUI:OnRefocus(userData)
	return
end

function LunaMazeSettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LunaMazeSettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LunaMazeSettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LunaMazeSettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LunaMazeSettlementUI:OnDestroy()
	for i = 1, #self.SuitItems do
		local item = self.SuitItems[i]

		item:Dispose()
	end
end

function LunaMazeSettlementUI:Reset()
	self.MainPanel:SetActive(false)
	self.Step2Node:SetActive(false)
	self.CloseBtn:SetActive(false)
end

function LunaMazeSettlementUI:UpdateView()
	local totalTime = 2
	local duration = 0.1
	local updateTime = math.ceil(totalTime / duration)
	local scoreValue = MazeDataModule.SettlementData.Score

	if scoreValue == nil then
		scoreValue = 0
	end

	local dangerValue = LunaMazeSettlementUIApi:GetString("DangerValue", MazeDataModule.PlayerInfo.MonsterGrade, MazeDataModule.PlayerInfo.AbyssPowerId, MazeDataModule.ChapterType)
	local deltaScorePerUpdate = scoreValue / updateTime
	local deltaDangerPerUpdate = dangerValue / updateTime

	if scoreValue > 0 or dangerValue > 0 then
		local score = 0
		local danger = 0
		local timer

		timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.LunaMazeSettlementUI, function()
			score = score + deltaScorePerUpdate

			if score > scoreValue then
				score = scoreValue
			end

			UGUIUtil.SetText(self.ScoreText, math.floor(score))

			danger = danger + deltaDangerPerUpdate

			if danger > dangerValue then
				danger = dangerValue
			end

			UGUIUtil.SetText(self.DangerText, math.floor(danger))

			if timer.loop == 1 then
				UGUIUtil.SetText(self.ScoreText, scoreValue)
				UGUIUtil.SetText(self.DangerText, dangerValue)
				self:ShowStep2()
			end
		end, duration, updateTime)

		timer:Start()
	else
		UGUIUtil.SetText(self.ScoreText, scoreValue)
		UGUIUtil.SetText(self.DangerText, dangerValue)
		self:ShowStep2()
	end

	local cidList, numList = MazeModule.GetEndlessMazeRuneSuitData()
	local legendCidList = MazeModule.GetEndlessMazeLegendRuneSuitData(cidList, numList)
	local normalSuitStartIndex = 1

	if #legendCidList > 0 then
		local item = self.SuitItems[1]

		item:SetData(2, nil, #legendCidList)

		normalSuitStartIndex = 2
	end

	for i = normalSuitStartIndex, #self.SuitItems do
		local item = self.SuitItems[i]

		item:SetData(1, cidList[i], numList[i])
	end
end

function LunaMazeSettlementUI:ShowStep2()
	self.Step2Node:SetActive(true)
	self.CloseBtn:SetActive(true)
end

function LunaMazeSettlementUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
	MazeModule.ExitMaze()
end

return LunaMazeSettlementUI
