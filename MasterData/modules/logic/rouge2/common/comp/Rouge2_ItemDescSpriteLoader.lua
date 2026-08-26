-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_ItemDescSpriteLoader.lua

module("modules.logic.rouge2.common.comp.Rouge2_ItemDescSpriteLoader", package.seeall)

local Rouge2_ItemDescSpriteLoader = class("Rouge2_ItemDescSpriteLoader", LuaCompBase)

function Rouge2_ItemDescSpriteLoader.Get(txtComp, assetUrl)
	return MonoHelper.addNoUpdateLuaComOnceToGo(txtComp.gameObject, Rouge2_ItemDescSpriteLoader, assetUrl)
end

function Rouge2_ItemDescSpriteLoader:ctor(assetUrl)
	self._assetUrl = assetUrl or Rouge2_Enum.ResPath.ItemDescSprite

	if GameResMgr.IsFromEditorDir then
		self._abUrl = self._assetUrl or Rouge2_Enum.ResPath.ItemDescSpriteAb
	end
end

function Rouge2_ItemDescSpriteLoader:init(go)
	self.go = go
	self._txtContentList = self.go:GetComponentsInChildren(gohelper.Type_TextMesh, true)

	if self._txtContentList then
		self._txtContentNum = self._txtContentList.Length or 0
	end

	if self._txtContentNum <= 0 then
		return
	end

	self:loadSpriteRes()
end

function Rouge2_ItemDescSpriteLoader:loadSpriteRes()
	if not self._loader then
		self._loader = MultiAbLoader.New()

		self._loader:addPath(self._abUrl)
		self._loader:startLoad(self._onLoadResDone, self)
	end
end

function Rouge2_ItemDescSpriteLoader:_onLoadResDone(loader)
	local assetItem = loader:getAssetItem(self._abUrl)

	self._spriteAsset = assetItem and assetItem:GetResource(self._assetUrl)

	self:setAllTxtSpriteAsset()
end

function Rouge2_ItemDescSpriteLoader:setAllTxtSpriteAsset()
	for i = 0, self._txtContentNum - 1 do
		local txtComp = self._txtContentList[i]

		txtComp.spriteAsset = self._spriteAsset
	end
end

function Rouge2_ItemDescSpriteLoader:onDestroy()
	self._spriteAsset = nil

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return Rouge2_ItemDescSpriteLoader
