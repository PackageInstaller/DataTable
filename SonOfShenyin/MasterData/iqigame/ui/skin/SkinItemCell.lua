-- chunkname: @IQIGame\\UI\\Skin\\SkinItemCell.lua

local SkinItemCell = {}

function SkinItemCell.New(view, selectCallBack)
	local obj = Clone(SkinItemCell)

	obj:Init(view, selectCallBack)

	return obj
end

function SkinItemCell:Init(view, selectCallBack)
	self.View = view
	self.selectCallBack = selectCallBack

	LuaCodeInterface.BindOutlet(self.View, self)
	self:initProperties()
	self:AddListeners()
end

function SkinItemCell:initProperties()
	self.uGUIEnhanceItem = self.View:GetComponent("UGUIEnhanceItem")
	self.SkinImgComponent = self.SkinImg:GetComponent("Image")

	function self.DelegateSelectCallBack(isCenter)
		self:OnSelectCallBack(isCenter)
	end
end

function SkinItemCell:DisposeProperties()
	self.uGUIEnhanceItem = nil
	self.SkinImgComponent = nil
	self.DelegateSelectCallBack = nil
end

function SkinItemCell:AddListeners()
	if self.uGUIEnhanceItem ~= nil then
		self.uGUIEnhanceItem.SelectCallBack = self.DelegateSelectCallBack
	end
end

function SkinItemCell:RemoveListeners()
	if self.uGUIEnhanceItem ~= nil then
		self.uGUIEnhanceItem.SelectCallBack = nil
	end
end

function SkinItemCell:SetVisible(isVisible)
	LuaUtility.SetGameObjectShow(self.View, isVisible)
end

function SkinItemCell:Refresh(index, skinPOD)
	self.Index = index
	self.skinPOD = skinPOD

	local path = SkinApi:GetSkinUIScrollViewShowImgBySkinCid(skinPOD.skinCid)

	AssetUtil.LoadImage(self, path, self.SkinImgComponent)

	local skinConfig = SkinModule.GetSkinConfigBySkinCid(skinPOD.skinCid)

	if skinConfig ~= nil then
		UGUIUtil.SetText(self.SkinName, skinConfig.SkinName)
	end
end

function SkinItemCell:OnSelectCallBack(isCenter)
	LuaUtility.SetGameObjectShow(self.SelectImg, isCenter)
	LuaUtility.SetGameObjectShow(self.UnselectBottomImg, not isCenter)
	LuaUtility.SetGameObjectShow(self.selectBottomImg, isCenter)
	LuaUtility.SetGameObjectShow(self.SkinName, isCenter)

	if self.unSelectMaskObj ~= nil then
		LuaUtility.SetGameObjectShow(self.unSelectMaskObj, not isCenter)
	end

	if isCenter and self.selectCallBack ~= nil then
		self.selectCallBack(self.Index)
	end
end

function SkinItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	self:DisposeProperties()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return SkinItemCell
