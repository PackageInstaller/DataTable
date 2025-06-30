-- chunkname: @IQIGame\\UI\\Settlement_MazeBattleUI.lua

local Settlement_MazeBattleUI = {}

Settlement_MazeBattleUI = Base:Extend("Settlement_MazeBattleUI", "IQIGame.Onigao.UI.Settlement_MazeBattleUI", Settlement_MazeBattleUI)

local SettlementRewardViewClass = require("IQIGame/UI/SettlementUI/settlementRewardView")

function Settlement_MazeBattleUI:OnInit()
	self:InitComponent()
	self:InitDelegate()
end

function Settlement_MazeBattleUI:InitComponent()
	self.rewardView = SettlementRewardViewClass.New(self.settlementRewardView, self)
end

function Settlement_MazeBattleUI:OnOpen(userData)
	Time.timeScale = 1
	self.settlementData = userData

	if self.settlementData.fightOverPOD.fightResult == Constant.FightResult.ATTACKER_WIN then
		self:ShowWinPreview()
	else
		self:ShowFailedPreview()
	end
end

function Settlement_MazeBattleUI:OnClose(userData)
	return
end

function Settlement_MazeBattleUI:InitDelegate()
	function self.delegateOnClickButtonClose()
		UIModule.CloseSelf(self)

		if self.settlementData.closeCallBack then
			self.settlementData.closeCallBack()

			self.settlementData.closeCallBack = nil
		end
	end
end

function Settlement_MazeBattleUI:OnAddListeners()
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
end

function Settlement_MazeBattleUI:OnRemoveListeners()
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
end

function Settlement_MazeBattleUI:GetPreloadAssetPaths()
	return nil
end

function Settlement_MazeBattleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function Settlement_MazeBattleUI:IsManualShowOnOpen(userData)
	return false
end

function Settlement_MazeBattleUI:GetBGM(userData)
	return nil
end

function Settlement_MazeBattleUI:OnPause()
	return
end

function Settlement_MazeBattleUI:OnResume()
	return
end

function Settlement_MazeBattleUI:OnCover()
	return
end

function Settlement_MazeBattleUI:OnReveal()
	return
end

function Settlement_MazeBattleUI:OnRefocus(userData)
	return
end

function Settlement_MazeBattleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function Settlement_MazeBattleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function Settlement_MazeBattleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function Settlement_MazeBattleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function Settlement_MazeBattleUI:ShowWinPreview()
	LuaUtility.SetGameObjectShow(self.buttonClose, false)
	LuaUtility.SetGameObjectShow(self.successPreviewRoot, true)
	LuaUtility.SetGameObjectShow(self.failedPreviewRoot, false)
	LuaUtility.SetGameObjectShow(self.successRoot, false)
	self:StopCoWin()

	self.coWin = coroutine.start(function()
		coroutine.wait(1.5)
		self:RefreshWin()
		LuaUtility.SetGameObjectShow(self.successRoot, true)
	end)
end

function Settlement_MazeBattleUI:ShowFailedPreview()
	LuaUtility.SetGameObjectShow(self.failedPreviewRoot, true)
	LuaUtility.SetGameObjectShow(self.successPreviewRoot, false)
	LuaUtility.SetGameObjectShow(self.successRoot, false)
	LuaUtility.SetGameObjectShow(self.buttonClose, false)
	self:RefreshFailed()
end

function Settlement_MazeBattleUI:RefreshWin()
	LuaUtility.SetGameObjectShow(self.buttonClose, true)

	local itemShowList, upExp = ItemModule.ExcludeExpItem_CountExp(self.settlementData.fightOverPOD.awards)

	itemShowList = ItemModule.ItemShowListSort(itemShowList)

	self.rewardView:Refresh(itemShowList)
	CVModule.PlayFightOverCVWithAttackUnit(Constant.CVActionType.FightSuccess, self.settlementData.fightOverPOD.units)
end

function Settlement_MazeBattleUI:RefreshFailed()
	LuaUtility.SetGameObjectShow(self.buttonClose, true)
	CVModule.PlayFightOverCVWithAttackUnit(Constant.CVActionType.FightFailed, self.settlementData.fightOverPOD.units)
end

function Settlement_MazeBattleUI:StopCoWin()
	if self.coWin then
		coroutine.stop(self.coWin)

		self.coWin = nil
	end
end

function Settlement_MazeBattleUI:StopCoFailed()
	if self.coFailed then
		coroutine.stop(self.coFailed)

		self.coFailed = nil
	end
end

function Settlement_MazeBattleUI:OnDestroy()
	self:StopCoWin()
	self:StopCoFailed()
	self.rewardView:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

return Settlement_MazeBattleUI
