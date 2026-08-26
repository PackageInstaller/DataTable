-- chunkname: @modules/logic/necrologiststory/view/item/V3A2NecrologistStoryUseItem.lua

module("modules.logic.necrologiststory.view.item.V3A2NecrologistStoryUseItem", package.seeall)

local V3A2NecrologistStoryUseItem = class("V3A2NecrologistStoryUseItem", LuaCompBase)

function V3A2NecrologistStoryUseItem:init(go)
	self.viewGO = go
	self.transform = go.transform

	self:onInit()
end

function V3A2NecrologistStoryUseItem:onInit()
	self.animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self.scroll = gohelper.findChildComponent(self.viewGO, "content/#scroll_view", gohelper.Type_LimitedScrollRect)
	self.goItem = gohelper.findChild(self.viewGO, "content/#scroll_view/Viewport/Content/#go_item")

	gohelper.setActive(self.goItem, false)

	self.itemList = {}

	self:setSelectItem()
	self:setParent(self.scrollParent)
end

function V3A2NecrologistStoryUseItem:setParent(parent)
	self.scrollParent = parent

	if not self.scroll then
		return
	end

	self.scroll.parentGameObject = parent
end

function V3A2NecrologistStoryUseItem:setClickCallback(callback, callbackObj, clickParam)
	self.clickCallback = callback
	self.clickCallbackObj = callbackObj
	self.clickParam = clickParam
end

function V3A2NecrologistStoryUseItem:onClickItemTips(item)
	local config = item.config

	if not config then
		return
	end

	ViewMgr.instance:openView(ViewName.V3A2_RoleStoryItemTipsView, {
		config = config
	})
end

function V3A2NecrologistStoryUseItem:onClickItem(item)
	if self:isDone() then
		return
	end

	local config = item.config
	local gameBaseMO = NecrologistStoryModel.instance:getGameMO(NecrologistStoryEnum.RoleStoryId.V3A2)
	local isUnlock = gameBaseMO:isItemUnlock(config.id)

	if not isUnlock then
		GameFacade.showToast(ToastEnum.V3A2NecrologistStoryUseItemTips1)

		return
	end

	local isRight = item.config.id == self.checkItem

	if isRight then
		self:setSelectItem(item.config.id)
		self:refreshItemList()

		if self.clickCallback then
			self.clickCallback(self.clickCallbackObj, self.clickParam, self)
		end
	else
		GameFacade.showToast(ToastEnum.V3A2NecrologistStoryUseItemTips2)
	end
end

function V3A2NecrologistStoryUseItem:setSelectItem(itemId)
	self.selectItem = itemId
end

function V3A2NecrologistStoryUseItem:setCheckItem(checkItem)
	self.checkItem = checkItem
end

function V3A2NecrologistStoryUseItem:show(callback, callbackObj)
	self.openCallback = callback
	self.openCallbackObj = callbackObj

	gohelper.setActive(self.viewGO, true)
	self.animatorPlayer:Play("open", self.onOpenFinish, self)
	self:refreshItemList()
end

function V3A2NecrologistStoryUseItem:hide(callback, callbackObj)
	self.closeCallback = callback
	self.closeCallbackObj = callbackObj

	self.animatorPlayer:Play("close", self.onCloseFinish, self)
end

function V3A2NecrologistStoryUseItem:onOpenFinish()
	if self.openCallback then
		self.openCallback(self.openCallbackObj, self)
	end
end

function V3A2NecrologistStoryUseItem:onCloseFinish()
	gohelper.setActive(self.viewGO, false)

	if self.closeCallback then
		self.closeCallback(self.closeCallbackObj, self)
	end
end

function V3A2NecrologistStoryUseItem:refreshItemList()
	local list = NecrologistStoryV3A2Config.instance:getItemList()

	for i = 1, math.max(#list, #self.itemList) do
		local item = self:getItem(i)

		self:updateItem(item, list[i])
	end
end

function V3A2NecrologistStoryUseItem:updateItem(item, config)
	item.config = config

	if not config then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local hasSelect = self.selectItem ~= nil
	local isSelect = self.selectItem == config.id

	gohelper.setActive(item.goSelect, isSelect)

	item.txtName.text = config.name

	local gameBaseMO = NecrologistStoryModel.instance:getGameMO(NecrologistStoryEnum.RoleStoryId.V3A2)
	local isUnlock = gameBaseMO:isItemUnlock(config.id)
	local resPath = string.format("singlebg/dungeon/rolestory_singlebg/madierda/rolestory_madierda_pic%s_%s.png", config.image, isUnlock and 1 or 0)

	item.simagePic:LoadImage(resPath)

	item.btn.button.interactable = not hasSelect

	gohelper.setActive(item.goRaycast, not hasSelect)
	gohelper.setActive(item.goRecommend, self.checkItem == config.id and isUnlock)
	gohelper.setActive(item.goUnabled, self.checkItem ~= config.id or not isUnlock)
end

function V3A2NecrologistStoryUseItem:getItem(index)
	local item = self.itemList[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self.goItem, tostring(index))

		item.go = go
		item.goRaycast = gohelper.findChild(go, "raycast")
		item.goSelect = gohelper.findChild(go, "#go_select")
		item.simagePic = gohelper.findChildSingleImage(go, "#simage_pic")
		item.txtName = gohelper.findChildTextMesh(go, "name/#txt_name")
		item.btnTips = gohelper.findChildButtonWithAudio(go, "#btn_check")

		item.btnTips:AddClickListener(self.onClickItemTips, self, item)

		item.goRecommend = gohelper.findChild(go, "#go_recommend")
		item.goUnabled = gohelper.findChild(go, "#go_unable")
		item.btn = gohelper.findButtonWithAudio(go)

		item.btn:AddClickListener(self.onClickItem, self, item)

		self.itemList[index] = item
	end

	return item
end

function V3A2NecrologistStoryUseItem:isDone()
	return self.selectItem ~= nil
end

function V3A2NecrologistStoryUseItem:onDestroy()
	if self.itemList then
		for i, v in ipairs(self.itemList) do
			v.btn:RemoveClickListener()
			v.btnTips:RemoveClickListener()
		end
	end
end

function V3A2NecrologistStoryUseItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/necrologiststoryuseitem.prefab"
end

return V3A2NecrologistStoryUseItem
