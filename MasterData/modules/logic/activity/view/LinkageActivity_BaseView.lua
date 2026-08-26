-- chunkname: @modules/logic/activity/view/LinkageActivity_BaseView.lua

module("modules.logic.activity.view.LinkageActivity_BaseView", package.seeall)

local LinkageActivity_BaseView = class("LinkageActivity_BaseView", Activity101SignViewBase)

function LinkageActivity_BaseView:ctor(...)
	LinkageActivity_BaseView.super.ctor(self, ...)

	self._pageItemList = {}
	self._curPageIndex = false
end

function LinkageActivity_BaseView:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_pageItemList")
	Activity101SignViewBase._internal_onDestroy(self)
end

function LinkageActivity_BaseView:addEvents()
	LinkageActivity_BaseView.super.addEvents(self)
end

function LinkageActivity_BaseView:removeEvents()
	LinkageActivity_BaseView.super.removeEvents(self)
end

function LinkageActivity_BaseView:selectedPage(index)
	if self._curPageIndex == index then
		return
	end

	local lastIndex = self._curPageIndex

	self._curPageIndex = index

	self:onSelectedPage(index, lastIndex)
end

function LinkageActivity_BaseView:getPage(index)
	return self._pageItemList[index]
end

function LinkageActivity_BaseView:addPage(index, go, clsDefine)
	local item = clsDefine.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)
	table.insert(self._pageItemList, item)

	return item
end

function LinkageActivity_BaseView:getLinkageActivityCO()
	return ActivityType101Config.instance:getLinkageActivityCO(self:actId())
end

function LinkageActivity_BaseView:onStart()
	assert(false, "please override this function")
end

function LinkageActivity_BaseView:onSelectedPage(index, lastIndex)
	local curItem = self:getPage(index)
	local lastItem

	if lastIndex then
		lastItem = self:getPage(lastIndex)

		lastItem:setActive(false)
	end

	curItem:setActive(true)

	for _, item in ipairs(self._pageItemList) do
		item:onPostSelectedPage(curItem, lastItem)
	end
end

function LinkageActivity_BaseView:onRefresh()
	for _, item in ipairs(self._pageItemList) do
		item:onUpdateMO()
	end
end

return LinkageActivity_BaseView
