-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/viewpager/ViewPager.lua

module("logic.common.viewlib.viewpager.ViewPager", package.seeall)

local M = class("ViewPager")

function M:ctor(mainGO)
	self.mainGO = mainGO
	self._pageChangeHandler = Handler.New()
	self._viewPresentor = false
	self._adapter = false
	self._transformer = false
	self._activeIndex = false
	self._activeView = false
	self._lastIndex = false
	self._lastView = false
end

function M:onTransformInFinish()
	return
end

function M:onTransformOutFinish()
	self:_destroyLastView()
end

function M:destroy()
	self:_destroyLastView()
	self:_destroyActiveView()
	self:_destroyAdapter()
	self:_destroyTransformer()
	self._pageChangeHandler:clear()

	self._viewPresentor = false
	self._adapter = false
	self._transformer = false
	self.mainGO = false
end

function M:clear()
	self:_destroyLastView()
	self:_destroyActiveView()
end

function M:setPageChangeCallBack(func, handler)
	self._pageChangeHandler:setListener(func, handler)
end

function M:getPage()
	return self._activeIndex
end

function M:getLastPageIndex()
	return self._lastIndex
end

function M:setPage(index, ...)
	if self._activeIndex == index then
		if enableLog then
			print("ViewPager::target page is already active", index)
		end

		return
	end

	self._pageChangeHandler:call(index)
	self:_destroyLastView()
	self:_setActivePageView(index, ...)

	local viewName = self._viewPresentor and self._viewPresentor:getViewName() or ""

	GlobalDispatcher:dispatchEvent(EventType.VIEW_PAGE_CHAGNE_EVENT, viewName, index)
end

function M:setViewPresentor(viewPresentor)
	self._viewPresentor = viewPresentor
end

function M:setAdapter(adapter)
	self:_destroyAdapter()

	self._adapter = adapter

	self._adapter:setViewPager(self)
	self._adapter:internal_build()
end

function M:setTransformer(transformer)
	self:_destroyTransformer()

	self._transformer = transformer

	self._transformer:setViewPager(self)
	self._transformer:internal_build()
end

function M:getViewPresentor()
	return self._viewPresentor
end

function M:getAdapter()
	return self._adapter
end

function M:getTransformer()
	return self._transformer
end

function M:_destroyAdapter()
	if self._adapter then
		self._adapter:internal_destroy()

		self._adapter = false
	end
end

function M:_destroyTransformer()
	if self._transformer then
		self._transformer:internal_destroy()

		self._transformer = false
	end
end

function M:_destroyLastView()
	if self._lastView then
		self._adapter:destroyView(self._lastView, self._lastIndex)

		self._lastView = false
		self._lastIndex = false
	end
end

function M:_destroyActiveView()
	if self._activeView then
		self._adapter:destroyView(self._activeView, self._activeIndex)

		self._activeView = false
		self._activeIndex = false
	end
end

function M:_setActivePageView(index, ...)
	self._lastIndex = self._activeIndex
	self._lastView = self._activeView
	self._activeIndex = index
	self._activeView = self._adapter:createView(index, ...)

	goutil.addChildToParent(self._activeView.mainGO, self.mainGO)

	if self._transformer then
		if self._lastView then
			self._transformer:transfromOut(self._lastView)
		end

		self._transformer:transfromIn(self._activeView)
	else
		self:onTransformOutFinish()
		self:onTransformInFinish()
	end
end

return M
