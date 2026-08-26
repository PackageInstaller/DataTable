-- chunkname: @modules/logic/rouge/view/RougeCollectionInitialCollectionTipsTagItem.lua

module("modules.logic.rouge.view.RougeCollectionInitialCollectionTipsTagItem", package.seeall)

local RougeCollectionInitialCollectionTipsTagItem = class("RougeCollectionInitialCollectionTipsTagItem", RougeSimpleItemBase)

function RougeCollectionInitialCollectionTipsTagItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionInitialCollectionTipsTagItem:addEvents()
	return
end

function RougeCollectionInitialCollectionTipsTagItem:removeEvents()
	return
end

function RougeCollectionInitialCollectionTipsTagItem:ctor(ctorParam)
	RougeSimpleItemBase.ctor(self, ctorParam)
end

function RougeCollectionInitialCollectionTipsTagItem:_editableInitView()
	RougeSimpleItemBase._editableInitView(self)

	self._txt = gohelper.findChildText(self.viewGO, "")
	self._img = gohelper.findChildImage(self.viewGO, "image_tagicon")
end

function RougeCollectionInitialCollectionTipsTagItem:setData(tagId)
	local rougeTagCO = lua_rouge_tag.configDict[tagId]

	self._txt.text = rougeTagCO.name

	UISpriteSetMgr.instance:setRougeSprite(self._img, rougeTagCO.iconUrl)
end

return RougeCollectionInitialCollectionTipsTagItem
