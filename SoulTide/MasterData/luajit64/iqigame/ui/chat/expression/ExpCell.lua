-- chunkname: @IQIGame\\UI\\Chat\\Expression\\ExpCell.lua

local ExpCell = {}

function ExpCell.New(view)
	local obj = Clone(ExpCell)

	obj:Init(view)

	return obj
end

function ExpCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.imgIcon = self.goIcon:GetComponent("Image")

	function self.onLoadSuccessDelegate(assetName, asset, duration, userData)
		self:OnLoadSuccess(assetName, asset, duration, userData)
	end
end

function ExpCell:Refresh(cfgEmoData)
	self.cfgEmoData = cfgEmoData

	local path = UIGlobalApi.GetImagePath(self.cfgEmoData.Emoticons .. "0" .. self.cfgEmoData.startIndex .. ".png")

	AssetUtil.LoadImage(self, path, self.imgIcon, self.onLoadSuccessDelegate)
end

function ExpCell:OnHide()
	return
end

function ExpCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function ExpCell:OnLoadSuccess(assetName, asset, duration, userData)
	local comp = self.goIcon:GetComponent("FrameSequenceComponent")

	comp.relativePath = self.cfgEmoData.Emoticons
	comp.startNumber = self.cfgEmoData.startIndex
	comp.imageCount = self.cfgEmoData.totalNum

	comp:Play()
end

return ExpCell
