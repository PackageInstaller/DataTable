-- chunkname: @IQIGame\\UI\\MazeWish\\MazeWishCell.lua

local m = {
	MazeWishCid = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(view, self)

	function self.DelegateOnSelected(value)
		self:OnSelected(value)
	end

	self.Toggle = self.View:GetComponent("Toggle")

	self.Toggle.onValueChanged:AddListener(self.DelegateOnSelected)
end

function m:SetData(wishCid)
	self.MazeWishCid = wishCid

	self.View:SetActive(wishCid ~= nil)

	if wishCid == nil then
		return
	end

	local cfgMazeWishData = CfgMazeWishTable[wishCid]

	self.NormalBg:SetActive(cfgMazeWishData.RareType == 1)
	self.RareBg:SetActive(cfgMazeWishData.RareType ~= 1)

	self.TitleText:GetComponent("Text").text = cfgMazeWishData.Title
	self.DescText:GetComponent("Text").text = cfgMazeWishData.Describe

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgMazeWishData.Icon), self.Icon:GetComponent("Image"))

	self.Toggle.isOn = false
end

function m:OnSelected(value)
	if value then
		EventDispatcher.Dispatch(EventID.MazeSelectWish, self.MazeWishCid)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self.Toggle.onValueChanged:RemoveListener(self.DelegateOnSelected)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Toggle = nil
end

return m
