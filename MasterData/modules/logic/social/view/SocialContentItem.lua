-- chunkname: @modules/logic/social/view/SocialContentItem.lua

module("modules.logic.social.view.SocialContentItem", package.seeall)

local SocialContentItem = class("SocialContentItem", ListScrollCellExtend)

function SocialContentItem:onInitView()
	self._gonode = gohelper.findChild(self.viewGO, "node")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialContentItem:addEvents()
	return
end

function SocialContentItem:removeEvents()
	return
end

SocialContentItem.Type2Name = {
	[SocialEnum.Type.Recommend] = "socialsearchitem2",
	[SocialEnum.Type.Search] = "socialsearchitem2",
	[SocialEnum.Type.Request] = "socialsearchitem2"
}
SocialContentItem.Type2Comp = {
	[SocialEnum.Type.Recommend] = SocialSearchItem2,
	[SocialEnum.Type.Search] = SocialSearchItem2,
	[SocialEnum.Type.Request] = SocialRequestItem2
}

function SocialContentItem:onUpdateMO(mo)
	self.mo = mo
	self.type = mo.type
	self.skinId = mo and mo.bg

	if self.lastskinId and self.lastskinId == self.skinId then
		self._viewCls:onUpdateMO(self.mo)
	end

	if not self.lastskinId or self.lastskinId ~= self.skinId then
		local pathname = SocialContentItem.Type2Name[self.type]

		if not string.nilorempty(self.skinId) and self.skinId ~= 0 then
			pathname = pathname .. "_" .. self.skinId
		end

		self._skinPath = string.format("ui/viewres/social/%s.prefab", pathname)

		self:_disposeBg()

		self._loader = MultiAbLoader.New()

		self._loader:addPath(self._skinPath)
		self._loader:startLoad(self._onLoadFinish, self)
	end
end

function SocialContentItem:_disposeBg()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._viewCls then
		self._viewCls:onCloseInternal()
	end

	if self._oldViewGo then
		gohelper.destroy(self._oldViewGo)

		self._oldViewGo = nil
	end
end

function SocialContentItem:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(self._skinPath)
	local viewPrefab = assetItem:GetResource(self._skinPath)

	self.lastskinId = self.skinId
	self._viewGo = gohelper.clone(viewPrefab, self._gonode)
	self._oldViewGo = self._oldViewGo or self._viewGo
	self._viewCls = MonoHelper.addNoUpdateLuaComOnceToGo(self._viewGo, SocialContentItem.Type2Comp[self.type])

	self._viewCls:onInitView(self._viewGo, self)
	self._viewCls:onUpdateMO(self.mo)
end

function SocialContentItem:getResInst(resPath, parentGO, name)
	return self._view:getResInst(resPath, parentGO, name)
end

function SocialContentItem:onDestroy()
	self:_disposeBg()
end

return SocialContentItem
