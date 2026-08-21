-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/viewpager/adapter/StaticPagerAdapter.lua

module("logic.common.viewlib.viewpager.adapter.StaticPagerAdapter", package.seeall)

local M = class("StaticPagerAdapter", PagerAdapter)

function M:ctor(registry)
	self._registry = registry

	M.super.ctor(self)
end

function M:onCreate()
	self._views = {}
end

function M:onDestroy()
	for _, view in ipairs(self._views) do
		view:destroy()
	end

	self._views = nil
	self._registry = nil
end

function M:setElementsRegistry(registry)
	self._registry = registry
end

function M:addFragmentView(view)
	view:setViewPager(self._viewPager)
	view:internal_buildUI(self._registry)
	table.insert(self._views, view)
	goutil.setActive(view.mainGO, false)
end

function M:createView(index, ...)
	local view = self._views[index]

	goutil.setActive(view.mainGO, true)
	view:setParams(...)
	view:onEnter()

	return view
end

function M:getView(index)
	return self._views[index]
end

function M:destroyView(view, index)
	goutil.setActive(view.mainGO, false)
	view:onExit()
end

return M
