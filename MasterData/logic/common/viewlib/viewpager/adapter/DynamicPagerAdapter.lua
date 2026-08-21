-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/viewpager/adapter/DynamicPagerAdapter.lua

module("logic.common.viewlib.viewpager.adapter.DynamicPagerAdapter", package.seeall)

local M = class("DynamicPagerAdapter", PagerAdapter)

function M:ctor()
	M.super.ctor(self)

	self._urls = {}
	self._viewClasses = {}
	self._params = {}
end

function M:onCreate()
	self._views = {}
end

function M:onDestroy()
	for _, view in pairs(self._views) do
		view:destroy()
	end

	self._views = nil
	self._urls = nil
	self._viewClasses = nil
	self._params = nil
end

function M:registerView(url, viewClass, ...)
	table.insert(self._urls, url)
	table.insert(self._viewClasses, viewClass)
	table.insert(self._params, {
		...
	})
end

function M:replaceViewClass(index, viewClass)
	if index <= #self._viewClasses then
		self._viewClasses[index] = viewClass
	end
end

function M:createView(index, ...)
	local view = self._views[index]
	local param = {
		...
	}
	local param = table.nums(param) > 0 and param or self._params[index]

	if not view then
		local url = self._urls[index]
		local viewClass = self._viewClasses[index]

		view = viewClass.New()

		view:setParams(unpack(param))
		view:setViewPager(self._viewPager)
		view:active(url)

		self._views[index] = view
	else
		goutil.setActive(view.mainGO, true)
		view:setParams(unpack(param))
		view:active()
	end

	return view
end

function M:getView(index)
	return self._views[index]
end

function M:destroyView(view, index)
	goutil.setActive(view.mainGO, false)
	view:inactive()
end

return M
