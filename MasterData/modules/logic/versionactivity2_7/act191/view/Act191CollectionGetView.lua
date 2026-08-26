-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CollectionGetView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CollectionGetView", package.seeall)

local Act191CollectionGetView = class("Act191CollectionGetView", BaseView)

function Act191CollectionGetView:onInitView()
	self._goOldItem = gohelper.findChild(self.viewGO, "result/collection_before/#go_OldItem")
	self._goNewItem = gohelper.findChild(self.viewGO, "result/collection_after/#go_NewItem")
	self._gotopleft = gohelper.findChild(self.viewGO, "result/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191CollectionGetView:onClickModalMask()
	if self.canExit then
		self:closeThis()
	end
end

function Act191CollectionGetView:onOpen()
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.ClickCollectionItem, self.onClickCollectionItem, self)

	local oldIdList = self.viewParam.oldIdList

	for _, id in ipairs(oldIdList) do
		local parent = gohelper.cloneInPlace(self._goOldItem)
		local cloneGo = self:getResInst(Activity191Enum.PrefabPath.CollectionItem, parent)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, Act191CollectionItem)

		item:setData({
			uid = 0,
			itemId = id
		})
	end

	gohelper.setActive(self._goOldItem, false)

	local newIdList = self.viewParam.newIdList

	for _, id in ipairs(newIdList) do
		local parent = gohelper.cloneInPlace(self._goNewItem)
		local cloneGo = self:getResInst(Activity191Enum.PrefabPath.CollectionItem, parent)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, Act191CollectionItem)

		item:setData({
			uid = 0,
			itemId = id
		})
	end

	gohelper.setActive(self._goNewItem, false)
	TaskDispatcher.runDelay(self.delaySet, self, 2)
end

function Act191CollectionGetView:delaySet()
	self.canExit = true
end

function Act191CollectionGetView:onClickCollectionItem(_, id)
	Activity191Controller.instance:openCollectionTipView({
		itemId = id
	})
end

function Act191CollectionGetView:onDestroyView()
	TaskDispatcher.cancelTask(self.delaySet, self)
end

return Act191CollectionGetView
