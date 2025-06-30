-- chunkname: @IQIGame\\UI\\RoleBreachSucessUI.lua

local RoleBreachSucessUI = Base:Extend("RoleBreachSucessUI", "IQIGame.Onigao.UI.RoleBreachSucessUI", {})
local roleBreachAttrView = require("IQIGame.UI.RoleDevelopment.RoleBreach.RoleBreachAttrView")
local roleBreachResultView = require("IQIGame.UI.RoleDevelopment.RoleBreach.RoleBreachResultView")

function RoleBreachSucessUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateCloseBtnClick()
		self:OnCloseBtnClick()
	end

	self.RoleBreachAttrView = roleBreachAttrView.New(self.RoleBreachAttrPanel)
	self.RoleBreachResultView = roleBreachResultView.New(self.RoleBreachResultView)
	self.playableCom = self.View:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
end

function RoleBreachSucessUI:GetPreloadAssetPaths()
	return nil
end

function RoleBreachSucessUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RoleBreachSucessUI:IsManualShowOnOpen(userData)
	return false
end

function RoleBreachSucessUI:GetBGM(userData)
	return nil
end

function RoleBreachSucessUI:OnOpen(cacheHeroData)
	LuaUtility.SetGameObjectShow(self.Com_ReturnBtn, false)

	self.cacheHeroData = cacheHeroData
	self.heroData = WarlockModule.WarlockDataDic[cacheHeroData.cid]

	self:SetViewShow()
end

function RoleBreachSucessUI:OnClose(userData)
	CVModule.StopCV()
end

function RoleBreachSucessUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtnClick)
end

function RoleBreachSucessUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtnClick)
end

function RoleBreachSucessUI:OnPause()
	return
end

function RoleBreachSucessUI:OnResume()
	return
end

function RoleBreachSucessUI:OnCover()
	return
end

function RoleBreachSucessUI:OnReveal()
	return
end

function RoleBreachSucessUI:OnRefocus(userData)
	return
end

function RoleBreachSucessUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RoleBreachSucessUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RoleBreachSucessUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RoleBreachSucessUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RoleBreachSucessUI:OnDestroy()
	self.RoleBreachAttrView:Dispose()
	self.RoleBreachResultView:Dispose()
	AssetUtil.UnloadAsset(self)
end

function RoleBreachSucessUI:SetViewShow()
	self.RoleBreachResultView:SetData(self.heroData)
	self.RoleBreachAttrView:SetData(self.cacheHeroData)
	self.playableCom:Play()
	CoroutineUtility.StartCoroutine(function()
		CoroutineUtility.Yield(CustomWaitForSeconds(self.playableCom.duration))
		LuaUtility.SetGameObjectShow(self.Com_ReturnBtn, true)
	end)
end

function RoleBreachSucessUI:OnCloseBtnClick()
	if UIModule.HasUI(Constant.UIControllerName.RoleBreachUI) then
		UIModule.Close(Constant.UIControllerName.RoleBreachUI)
	end

	UIModule.CloseSelf(self)
end

return RoleBreachSucessUI
