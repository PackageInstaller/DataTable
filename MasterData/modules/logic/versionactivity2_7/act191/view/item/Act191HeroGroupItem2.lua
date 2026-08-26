-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191HeroGroupItem2.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroGroupItem2", package.seeall)

local Act191HeroGroupItem2 = class("Act191HeroGroupItem2", LuaCompBase)

function Act191HeroGroupItem2:init(go)
	self.go = go
	self.goEmpty = gohelper.findChild(go, "go_Empty")
	self.goCollection = gohelper.findChild(go, "go_Collection")
	self.imageRare = gohelper.findChildImage(go, "go_Collection/image_Rare")
	self.simageIcon = gohelper.findChildSingleImage(go, "go_Collection/simage_Icon")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")
	self.dragging = false
end

function Act191HeroGroupItem2:addEventListeners()
	if self.btnClick then
		self.addClickCb(self, self.btnClick, self.onClick, self)
	end
end

function Act191HeroGroupItem2:setData(itemUid)
	self.itemUid = itemUid

	if itemUid and itemUid ~= 0 then
		local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
		local itemInfo = gameInfo:getItemInfoInWarehouse(itemUid)

		self.itemId = itemInfo.itemId

		local config = Activity191Config.instance:getCollectionCo(itemInfo.itemId)

		UISpriteSetMgr.instance:setAct174Sprite(self.imageRare, "act174_propitembg_" .. config.rare)
		self.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(config.icon))
		gohelper.setActive(self.goCollection, true)
		gohelper.setActive(self.goEmpty, false)
	else
		self.itemId = 0

		gohelper.setActive(self.goCollection, false)
		gohelper.setActive(self.goEmpty, true)
	end
end

function Act191HeroGroupItem2:setIndex(index)
	self._index = index
end

function Act191HeroGroupItem2:onClick()
	if self.dragging then
		return
	end

	if self.callback then
		self.callback(self.callbackObj, self.itemId)

		return
	end

	local param = {}

	param.index = self._index

	ViewMgr.instance:openView(ViewName.Act191CollectionView, param)

	if self.param then
		Act191StatController.instance:statButtonClick(self.param.fromView, string.format("itemClick_%s_%s_%s", self.param.type, self._index, self.itemId))
	end
end

function Act191HeroGroupItem2:setExtraParam(param)
	self.param = param
end

function Act191HeroGroupItem2:setOverrideClick(callback, callbackObj)
	self.callback = callback
	self.callbackObj = callbackObj
end

function Act191HeroGroupItem2:setDrag(bool)
	self.dragging = bool
end

return Act191HeroGroupItem2
