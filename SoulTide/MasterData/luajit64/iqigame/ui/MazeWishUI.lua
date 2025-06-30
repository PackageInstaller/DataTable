-- chunkname: @IQIGame\\UI\\MazeWishUI.lua

local MazeWishUI = Base:Extend("MazeWishUI", "IQIGame.Onigao.UI.MazeWishUI", {
	SelectedWishCid = 0
})

require("IQIGame.UIExternalApi.MazeWishUIApi")

local MazeWishCell = require("IQIGame.UI.MazeWish.MazeWishCell")

function MazeWishUI:OnInit()
	function self.DelegateOnSelectWish(wishCid)
		self:OnSelectWish(wishCid)
	end

	function self.DelegateOnConfirm()
		self:OnConfirm()
	end

	self.WishCells = {}

	local mazeWishCellGO

	for i = 1, 4 do
		mazeWishCellGO = UnityEngine.Object.Instantiate(self.WishCellPrefab)

		mazeWishCellGO.transform:SetParent(self.WishCellGrid.transform, false)
		table.insert(self.WishCells, MazeWishCell.New(mazeWishCellGO))
	end

	UGUIUtil.SetText(self.TitleText, MazeWishUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, MazeWishUIApi:GetString("ConfirmBtnText"))
end

function MazeWishUI:GetPreloadAssetPaths()
	return nil
end

function MazeWishUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeWishUI:OnOpen(userData)
	self:UpdateView(userData)
end

function MazeWishUI:OnClose(userData)
	return
end

function MazeWishUI:OnPause()
	return
end

function MazeWishUI:OnResume()
	return
end

function MazeWishUI:OnCover()
	return
end

function MazeWishUI:OnReveal()
	return
end

function MazeWishUI:OnRefocus(userData)
	return
end

function MazeWishUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeWishUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeWishUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeWishUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeWishUI:OnDestroy()
	for i = 1, #self.WishCells do
		self.WishCells[i]:Dispose()
	end

	self.WishCells = nil
end

function MazeWishUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnConfirm)
	EventDispatcher.AddEventListener(EventID.MazeSelectWish, self.DelegateOnSelectWish)
end

function MazeWishUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnConfirm)
	EventDispatcher.RemoveEventListener(EventID.MazeSelectWish, self.DelegateOnSelectWish)
end

function MazeWishUI:OnSelectWish(wishCid)
	self.SelectedWishCid = wishCid

	self:UpdateCanConfirm()
end

function MazeWishUI:UpdateView(wishCids)
	for i = 1, #self.WishCells do
		local wishCell = self.WishCells[i]

		wishCell:SetData(wishCids[i])
	end

	self.SelectedWishCid = 0

	self:UpdateCanConfirm()
end

function MazeWishUI:UpdateCanConfirm()
	self.ConfirmBtn:GetComponent("Button").interactable = self.SelectedWishCid ~= 0
end

function MazeWishUI:OnConfirm()
	UIModule.Close(Constant.UIControllerName.MazeWishUI)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_CHOOSE_WISH, {
		WishCid = self.SelectedWishCid
	})
end

return MazeWishUI
