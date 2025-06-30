-- chunkname: @IQIGame\\UI\\PassCheckDealNewUI.lua

local PassCheckDealNewUI = {}

PassCheckDealNewUI = Base:Extend("PassCheckDealNewUI", "IQIGame.Onigao.UI.PassCheckDealNewUI", PassCheckDealNewUI)

require("IQIGame.UIExternalApi.PassCheckDealNewUIApi")

local PassCheckDealNewCell = require("IQIGame.UI.PassCheckDealNew.PassCheckDealNewCell")

function PassCheckDealNewUI:OnInit()
	function self.DelegateOnBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnBtnEquip()
		self:OnBtnEquip()
	end

	self.baseCell = PassCheckDealNewCell.New(self.goBaseCell, 1)
	self.superCell = PassCheckDealNewCell.New(self.goSuperCell, 2)

	UGUIUtil.SetText(self.goDesc, PassCheckDealNewUIApi:GetString("NewUIDesc"))
end

function PassCheckDealNewUI:GetPreloadAssetPaths()
	return nil
end

function PassCheckDealNewUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PassCheckDealNewUI:IsManualShowOnOpen(userData)
	return false
end

function PassCheckDealNewUI:GetBGM(userData)
	return nil
end

function PassCheckDealNewUI:OnOpen(userData)
	self.cfgBattlePassData = userData

	self:UpDateView()
end

function PassCheckDealNewUI:OnClose(userData)
	return
end

function PassCheckDealNewUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose)
	self.goBtnEquip:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnEquip)
end

function PassCheckDealNewUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose)
	self.goBtnEquip:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnEquip)
end

function PassCheckDealNewUI:OnPause()
	return
end

function PassCheckDealNewUI:OnResume()
	return
end

function PassCheckDealNewUI:OnCover()
	return
end

function PassCheckDealNewUI:OnReveal()
	return
end

function PassCheckDealNewUI:OnRefocus(userData)
	return
end

function PassCheckDealNewUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PassCheckDealNewUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PassCheckDealNewUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PassCheckDealNewUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PassCheckDealNewUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.baseCell:Dispose()
	self.superCell:Dispose()
end

function PassCheckDealNewUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function PassCheckDealNewUI:OnBtnEquip()
	if self.cfgBattlePassData.SoulPaintingId > 0 then
		local cfgItemData = CfgItemTable[self.cfgBattlePassData.SoulPaintingId]

		UIModule.Open(Constant.UIControllerName.EquipUI, Constant.UILayer.UI, {
			forShow = true,
			data = {
				cfgItemData
			}
		})
	end
end

function PassCheckDealNewUI:UpDateView()
	self.baseCell:SetData(self.cfgBattlePassData)
	self.superCell:SetData(self.cfgBattlePassData)

	if self.cfgBattlePassData.SoulPaintingId > 0 then
		local cfgItemData = CfgItemTable[self.cfgBattlePassData.SoulPaintingId]

		UGUIUtil.SetText(self.goEquipName, cfgItemData.Name)

		local path = UIGlobalApi.GetImagePath(self.cfgBattlePassData.SoulPaintingImage)

		AssetUtil.LoadImage(self, path, self.goEquipIcon:GetComponent("Image"))
	end
end

return PassCheckDealNewUI
