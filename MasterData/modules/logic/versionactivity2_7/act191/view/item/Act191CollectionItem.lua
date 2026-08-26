-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191CollectionItem.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191CollectionItem", package.seeall)

local Act191CollectionItem = class("Act191CollectionItem", LuaCompBase)

function Act191CollectionItem:init(go)
	self.go = go
	self.transform = go.transform
	self.imageRare = gohelper.findChildImage(go, "image_Rare")
	self.simageIcon = gohelper.findChildSingleImage(go, "simage_Icon")
	self.goSelect = gohelper.findChild(go, "go_Select")
	self.goNew = gohelper.findChild(go, "go_New")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")
	self.isSelect = false
	self.sibling = gohelper.getSibling(self.go)
	self.dragging = false
	self.anim = go:GetComponent(gohelper.Type_Animator)
end

function Act191CollectionItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self._onItemClick, self)
end

function Act191CollectionItem:_onItemClick()
	if self.dragging then
		return
	end

	Activity191Controller.instance:dispatchEvent(Activity191Event.ClickCollectionItem, self.itemInfo.uid, self.itemInfo.itemId)
end

function Act191CollectionItem:setData(info)
	self.itemInfo = info

	local config = Activity191Config.instance:getCollectionCo(info.itemId)

	UISpriteSetMgr.instance:setAct174Sprite(self.imageRare, "act174_propitembg_" .. config.rare)
	self.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(config.icon))
end

function Act191CollectionItem:setSelect(bool)
	self.isSelect = bool

	gohelper.setActive(self.goSelect, bool)
end

function Act191CollectionItem:setActive(bool)
	gohelper.setActive(self.go, bool)
end

function Act191CollectionItem:setDrag(bool)
	self.dragging = bool
end

function Act191CollectionItem:playAnim(animName, direct)
	if direct then
		self.anim:Play(animName, 0, 1)
	else
		self.anim:Play(animName, 0, 0)
	end
end

return Act191CollectionItem
