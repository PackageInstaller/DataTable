-- chunkname: @IQIGame\\UI\\InvasionScoreTipsUI.lua

local InvasionScoreTipsUI = {
	scoreTipCellTab = {}
}

InvasionScoreTipsUI = Base:Extend("InvasionScoreTipsUI", "IQIGame.Onigao.UI.InvasionScoreTipsUI", InvasionScoreTipsUI)

local InvasionScoreTipCell = require("IQIGame.UI.Activity.DoubleFight.InvasionScoreTipCell")
local ActiveDoubleFightScoreUIData = require("IQIGame.Module.ActiveDoubleFight.ActiveDoubleFightScoreUIData")

function InvasionScoreTipsUI:OnInit()
	UGUIUtil.SetText(self.TextScoreTitle, InvasionScoreTipsUIApi:GetString("TextScoreTitle"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	self.scoreTipCellTab = {}

	for i = 1, 2 do
		local cell = InvasionScoreTipCell.New(self["Bar" .. i])

		self.scoreTipCellTab[i] = cell
	end
end

function InvasionScoreTipsUI:GetPreloadAssetPaths()
	return nil
end

function InvasionScoreTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function InvasionScoreTipsUI:IsManualShowOnOpen(userData)
	return false
end

function InvasionScoreTipsUI:GetBGM(userData)
	return nil
end

function InvasionScoreTipsUI:OnOpen(userData)
	self.doubleFightRecordPOD = userData[1]
	self.fightListCfgId = userData[2]
	self.index = userData[3]

	self.ImgUp:SetActive(false)
	self:UpdateView()
end

function InvasionScoreTipsUI:OnClose(userData)
	return
end

function InvasionScoreTipsUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function InvasionScoreTipsUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function InvasionScoreTipsUI:OnPause()
	return
end

function InvasionScoreTipsUI:OnResume()
	return
end

function InvasionScoreTipsUI:OnCover()
	return
end

function InvasionScoreTipsUI:OnReveal()
	return
end

function InvasionScoreTipsUI:OnRefocus(userData)
	return
end

function InvasionScoreTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function InvasionScoreTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function InvasionScoreTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function InvasionScoreTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function InvasionScoreTipsUI:OnDestroy()
	for i, v in pairs(self.scoreTipCellTab) do
		v:Dispose()
	end
end

function InvasionScoreTipsUI:UpdateView()
	if self.doubleFightRecordPOD then
		local cfgFightList = CfgDoubleFightListTable[self.fightListCfgId]
		local currentScore = self.doubleFightRecordPOD.hurtScore + self.doubleFightRecordPOD.roundScore

		UGUIUtil.SetText(self.TextScore, currentScore)

		local showDataTab = {}

		showDataTab[1] = ActiveDoubleFightScoreUIData.New(1, self.doubleFightRecordPOD.hurtPercentage, cfgFightList.HPScore[self.index][1], self.doubleFightRecordPOD.hurtScore)
		showDataTab[2] = ActiveDoubleFightScoreUIData.New(2, self.doubleFightRecordPOD.round, cfgFightList.RoundScore[self.index][1], self.doubleFightRecordPOD.roundScore)

		for i, v in pairs(self.scoreTipCellTab) do
			local showData = showDataTab[i]

			v:SetData(showData)
		end
	end
end

function InvasionScoreTipsUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.InvasionScoreTipsUI)
end

return InvasionScoreTipsUI
