-- chunkname: @IQIGame\\UI\\EquipComposeShowUI.lua

local EquipComposeShowUI = Base:Extend("EquipComposeShowUI", "IQIGame.Onigao.UI.EquipComposeShowUI", {})

function EquipComposeShowUI:OnInit()
	self:Initialize()
end

function EquipComposeShowUI:GetPreloadAssetPaths()
	return nil
end

function EquipComposeShowUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EquipComposeShowUI:OnOpen(userData)
	self:Refresh(userData)
end

function EquipComposeShowUI:OnClose(userData)
	self:OnHide()
end

function EquipComposeShowUI:OnPause()
	return
end

function EquipComposeShowUI:OnResume()
	return
end

function EquipComposeShowUI:OnCover()
	return
end

function EquipComposeShowUI:OnReveal()
	return
end

function EquipComposeShowUI:OnRefocus(userData)
	return
end

function EquipComposeShowUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.startTimer then
		self.timer = self.timer + elapseSeconds

		if self.timer >= self.duration then
			self:StopTimer()
			self:RefreshDetail(false)
		end
	end
end

function EquipComposeShowUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipComposeShowUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipComposeShowUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipComposeShowUI:Initialize()
	self.equipCell = EquipCell.New(self.goSlot)
	self.equipCell.enableClick = false
	self.tfClipNum = self.goClipNum:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.goClipDesc:GetComponent("Text").text = EquipComposeShowUIApi:GetString("goClipDesc")
	self.goBtnClose.transform:Find("Sort/Text_01"):GetComponent("Text").text = EquipComposeShowUIApi:GetString("goBtnClose")
	self.duration = EquipComposeShowUIApi:GetString("duration")
end

function EquipComposeShowUI:Refresh(userData)
	self.itemData = userData[1]
	self.count = userData[2]

	self:RefreshDetail(true)
	self:PlayEffect()
end

function EquipComposeShowUI:OnHide()
	self:StopTimer()
end

function EquipComposeShowUI:OnDestroy()
	self.equipCell:OnDestroy()
end

function EquipComposeShowUI:RefreshDetail(lock)
	self.equipCell:Refresh(self.itemData)
	self.equipCell:SetGray(lock)
	self.goClipDesc.transform.parent.gameObject:SetActive(not lock)
	self.goBtnClose:SetActive(not lock)

	self.tfClipNum.text = EquipComposeShowUIApi:GetString("goClipNum", self.count)
end

function EquipComposeShowUI:StartTimer()
	self.startTimer = true
	self.timer = 0
end

function EquipComposeShowUI:StopTimer()
	self.startTimer = false

	self:StopEffect()
end

function EquipComposeShowUI:PlayEffect()
	self:StopEffect()
	self:StartTimer()

	self.curEffectId = GameEntry.Effect:PlayUIMountPointEffect(9001120, 50000, 0, self.UIController.gameObject, 0)
end

function EquipComposeShowUI:StopEffect()
	if self.curEffectId ~= nil then
		GameEntry.Effect:StopEffect(self.curEffectId)

		self.curEffectId = nil
	end
end

function EquipComposeShowUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function EquipComposeShowUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function EquipComposeShowUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.EquipComposeShowUI)
end

return EquipComposeShowUI
