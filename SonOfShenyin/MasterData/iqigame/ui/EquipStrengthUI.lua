-- chunkname: @IQIGame\\UI\\EquipStrengthUI.lua

local EquipStrengthUI = Base:Extend("EquipStrengthUI", "IQIGame.Onigao.UI.EquipStrengthUI", {})
local EquipIntensifyView = require("IQIGame.UI.Equip.MainView.EquipIntensifyView")
local EquipDescribeView = require("IQIGame.UI.Equip.MainView.EquipDescribeView")
local EquipSuccinctView = require("IQIGame/UI/Equip/MainView/EquipSuccinctView")
local UITabList = require("IQIGame.UI.Common.UITabList")

require("IQIGame.UIExternalApi.EquipStrengthUIApi")

function EquipStrengthUI:OnInit()
	function self.DelegateJumpToStrength()
		self:OnJumpToStrength()
	end

	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)
	self.equipImgParentAnimation = self.EquipImgParent:GetComponent("Animation")
	self.uiTabList = UITabList.Create()
	self.equipDescribeView = EquipDescribeView.New(self.EquipDescribeParent)

	self.uiTabList:AddTableItem(self.DetailTab, function()
		return self.equipDescribeView
	end, function(_isOn, _view)
		if not _isOn then
			_view:Hide()

			return
		end

		self.EquipImgParent.gameObject:SetActive(true)
		self.equipImgParentAnimation:Play("EquipImgParent_Strength")

		if self.equipData ~= nil then
			_view:OnOpen(self.equipData, self.isHideEquipButton)
		end
	end)

	self.equipIntensifyView = EquipIntensifyView.New(self.EquipIntensifyPanel)

	self.uiTabList:AddTableItem(self.StrengthTab, function()
		return self.equipIntensifyView
	end, function(_isOn, _view)
		if not _isOn then
			_view:OnClose()

			return
		end

		self.equipImgParentAnimation:Play("EquipImgParent_Strength")

		if self.equipData ~= nil then
			_view:OnOpen(self.equipData)
		end
	end)

	self.equipSuccinctView = EquipSuccinctView.New(self.EquipSuccinctParent)

	self.uiTabList:AddTableItem(self.SuccinctTab, function()
		return self.equipSuccinctView
	end, function(_isOn, _view)
		if not _isOn then
			_view:Hide()

			return
		end

		self.EquipImgParent.gameObject:SetActive(false)

		if self.equipData ~= nil then
			_view:Show(self.equipData, self.EquipImgParent)
		end
	end)

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function EquipStrengthUI:OnDestroy()
	self.moneyCell:Dispose()
	self.commonReturnBtn:Dispose()
	self.uiTabList:Dispose()
end

function EquipStrengthUI:OnOpen(userData)
	self.equipData = userData.equipData
	self.isHideEquipButton = userData.isHideEquipButton

	self.moneyCell:RefreshItem(Constant.TopMoneyType.DiySkillStrengthUI)
	self.commonReturnBtn:SetHomeBtnState(SceneTransferModule.GetCanBackHome())
	self.uiTabList:ChangeSelectIndex(2)
end

function EquipStrengthUI:OnClose(userData)
	self.equipIntensifyView:OnClose()
end

function EquipStrengthUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.JumpToStrengthEvent, self.DelegateJumpToStrength)
end

function EquipStrengthUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.JumpToStrengthEvent, self.DelegateJumpToStrength)
end

function EquipStrengthUI:OnPause()
	return
end

function EquipStrengthUI:OnResume()
	return
end

function EquipStrengthUI:OnCover()
	return
end

function EquipStrengthUI:OnReveal()
	return
end

function EquipStrengthUI:OnRefocus(userData)
	return
end

function EquipStrengthUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EquipStrengthUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipStrengthUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipStrengthUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipStrengthUI:GetPreloadAssetPaths()
	return nil
end

function EquipStrengthUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EquipStrengthUI:IsManualShowOnOpen(userData)
	return false
end

function EquipStrengthUI:GetBGM(userData)
	return nil
end

function EquipStrengthUI:OnJumpToStrength()
	self.uiTabList:ChangeSelectIndex(2)
end

return EquipStrengthUI
