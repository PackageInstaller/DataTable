-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/viewpager/PagerAdapter.lua

module("logic.common.viewlib.viewpager.PagerAdapter", package.seeall)

local M = class("PagerAdapter")

function M:ctor()
	self._viewPager = false
end

function M:internal_build()
	self:onCreate()
end

function M:internal_destroy()
	self:onDestroy()

	self._viewPager = false
end

function M:setViewPager(viewPager)
	self._viewPager = viewPager
end

function M:onCreate()
	return
end

function M:onDestroy()
	return
end

function M:createView(index, ...)
	return
end

function M:destroyView(view, index)
	return
end

return M
