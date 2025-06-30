-- chunkname: @IQIGame\\UI\\BattleDetailsPanel.lua

local UITabList = require("IQIGame/UI/Common/UITabList")
local BattleDetailElement = require("IQIGame/UI/BattleDetails/BattleDetailElement")
local BattleHelperElement = require("IQIGame/UI/BattleDetails/BattleHelperElement")
local BattleDetailsPanel = {}

BattleDetailsPanel = Base:Extend("BattleDetailsPanel", "IQIGame.Onigao.UI.BattleDetailsPanel", BattleDetailsPanel)

function BattleDetailsPanel:OnInit()
	self.detailElement = BattleDetailElement.New(self.detailRoot)
	self.helperElement = BattleHelperElement.New(self.helperRoot)
	self.tabList = UITabList.Create()

	self.tabList:AddTableItem(self.detailToggle, nil, function(_isOn, _view)
		if _isOn then
			self.detailElement:Show()
		else
			self.detailElement:Hide()
		end
	end)

	function self.__delegateOnCloseBtnClick()
		UIModule.Close(Constant.UIControllerName.BattleDetailsPanel)
	end
end

function BattleDetailsPanel:GetPreloadAssetPaths()
	return nil
end

function BattleDetailsPanel:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BattleDetailsPanel:IsManualShowOnOpen(userData)
	return false
end

function BattleDetailsPanel:GetBGM(userData)
	return nil
end

function BattleDetailsPanel:OnOpen(userData)
	self.tabList:ChangeSelectIndex(1)
end

function BattleDetailsPanel:OnClose(userData)
	return
end

function BattleDetailsPanel:OnAddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)
end

function BattleDetailsPanel:OnRemoveListeners()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)
end

function BattleDetailsPanel:OnPause()
	return
end

function BattleDetailsPanel:OnResume()
	return
end

function BattleDetailsPanel:OnCover()
	return
end

function BattleDetailsPanel:OnReveal()
	return
end

function BattleDetailsPanel:OnRefocus(userData)
	return
end

function BattleDetailsPanel:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BattleDetailsPanel:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleDetailsPanel:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleDetailsPanel:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleDetailsPanel:OnDestroy()
	self.helperElement:Dispose()
	self.detailElement:Dispose()
end

return BattleDetailsPanel
