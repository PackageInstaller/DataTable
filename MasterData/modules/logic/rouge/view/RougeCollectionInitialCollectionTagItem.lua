-- chunkname: @modules/logic/rouge/view/RougeCollectionInitialCollectionTagItem.lua

module("modules.logic.rouge.view.RougeCollectionInitialCollectionTagItem", package.seeall)

local RougeCollectionInitialCollectionTagItem = class("RougeCollectionInitialCollectionTagItem", RougeSimpleItemBase)

function RougeCollectionInitialCollectionTagItem:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionInitialCollectionTagItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeCollectionInitialCollectionTagItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RougeCollectionInitialCollectionTagItem:ctor(ctorParam)
	RougeSimpleItemBase.ctor(self, ctorParam)
end

function RougeCollectionInitialCollectionTagItem:_btnclickOnClick()
	local p = self:parent()

	p:setActiveTips(true)
end

function RougeCollectionInitialCollectionTagItem:_editableInitView()
	RougeSimpleItemBase._editableInitView(self)

	self._imageTagFrame = gohelper.findChildImage(self.viewGO, "image_tagframe")
	self._imageTagIcon = gohelper.findChildImage(self.viewGO, "image_tagicon")

	UISpriteSetMgr.instance:setRougeSprite(self._imageTagFrame, "rouge_collection_tagframe_1")
end

function RougeCollectionInitialCollectionTagItem:setData(tagId)
	local rougeTagCO = lua_rouge_tag.configDict[tagId]

	UISpriteSetMgr.instance:setRougeSprite(self._imageTagIcon, rougeTagCO.iconUrl)
end

return RougeCollectionInitialCollectionTagItem
