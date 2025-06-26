-- chunkname: @IQIGame\\UI\\DialogReviewUI.lua

local DialogReviewUI = Base:Extend("DialogReviewUI", "IQIGame.Onigao.UI.DialogReviewUI", {
	ReadyToScrollToBottom = false
})
local DialogReviewCell = require("IQIGame.UI.DialogReview.DialogReviewCell")

function DialogReviewUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.ScrollAreaList = self.DialogItemGrid:GetComponent("ScrollAreaListDialog")

	function self.ScrollAreaList.onRenderCell(cell)
		self:OnRenderDialogItemCell(cell)
	end

	UGUIUtil.SetText(self.TitleText, DialogReviewUIApi:GetString("TitleText"))
end

function DialogReviewUI:GetPreloadAssetPaths()
	return nil
end

function DialogReviewUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DialogReviewUI:OnOpen(userData)
	self.OnCloseCallback = userData.onClose

	self:UpdateView(userData.records)
end

function DialogReviewUI:OnClose(userData)
	if self.OnCloseCallback ~= nil then
		self.OnCloseCallback()
	end
end

function DialogReviewUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function DialogReviewUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function DialogReviewUI:OnPause()
	return
end

function DialogReviewUI:OnResume()
	return
end

function DialogReviewUI:OnCover()
	return
end

function DialogReviewUI:OnReveal()
	return
end

function DialogReviewUI:OnRefocus(userData)
	return
end

function DialogReviewUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.ReadyToScrollToBottom then
		self.ScrollAreaList:LayoutFromBottom()

		self.ReadyToScrollToBottom = false
	end
end

function DialogReviewUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DialogReviewUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DialogReviewUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DialogReviewUI:OnDestroy()
	DialogReviewCell.DisposeIn(self)
end

function DialogReviewUI:UpdateView(dialogCids)
	self.DialogCids = dialogCids

	self.ScrollAreaList:Refresh(#dialogCids)

	self.ReadyToScrollToBottom = true
end

function DialogReviewUI:OnRenderDialogItemCell(cell)
	local dialogReviewCell = DialogReviewCell.PackageOrReuseView(self, cell.gameObject)

	dialogReviewCell:SetData(self.DialogCids[cell.index + 1])
end

function DialogReviewUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.DialogReviewUI)
end

return DialogReviewUI
