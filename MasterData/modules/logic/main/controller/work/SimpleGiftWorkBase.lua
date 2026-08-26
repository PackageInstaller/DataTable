-- chunkname: @modules/logic/main/controller/work/SimpleGiftWorkBase.lua

module("modules.logic.main.controller.work.SimpleGiftWorkBase", package.seeall)

local SimpleGiftWorkBase = class("SimpleGiftWorkBase", BaseWork)
local startIndex = 0

local function _initViewNames(self)
	self._viewNames = self._viewNames or assert(self:onGetViewNames())
end

local function _initActIds(self)
	self._actIds = self._actIds or assert(self:onGetActIds())
end

local WorkContext = _G.class("SimpleGiftWorkBase_WorkContext")

function WorkContext:ctor()
	self.bAutoWorkNext = true
end

function SimpleGiftWorkBase:ctor(patFaceId)
	self._patFaceId = patFaceId
	self._patViewName = PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)
	self._patStoryId = PatFaceConfig.instance:getPatFaceStoryId(self._patFaceId)
end

function SimpleGiftWorkBase:onStart()
	_initViewNames(self)
	_initActIds(self)

	startIndex = 0

	if self:_isExistGuide() then
		self:_endBlock()
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self._work, self)
	else
		self:_work()
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function SimpleGiftWorkBase:_onOpenViewFinish(viewName)
	if viewName ~= self._viewName then
		return
	end

	self:_endBlock()
end

function SimpleGiftWorkBase:_onCloseViewFinish(viewName)
	if viewName ~= self._viewName then
		return
	end

	if ViewMgr.instance:isOpen(self._viewName) then
		return
	end

	self:_work()
end

function SimpleGiftWorkBase:clearWork()
	self:_endBlock()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._work, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)

	self._actId = nil
	self._viewName = nil
end

function SimpleGiftWorkBase:_pop()
	startIndex = startIndex + 1

	local viewName = self._viewNames[startIndex]
	local actId = self._actIds[startIndex]

	return actId, viewName
end

function SimpleGiftWorkBase:_work()
	self:_startBlock()

	self._actId, self._viewName = self:_pop()

	local actId = self._actId

	if not actId then
		self:onDone(true)

		return
	end

	local refWorkContext = WorkContext.New()

	self:onWork(refWorkContext)

	if refWorkContext.bAutoWorkNext then
		self:_work()
	end
end

function SimpleGiftWorkBase:_isExistGuide()
	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return true
	end

	if GuideController.instance:isGuiding() then
		return true
	end

	return false
end

function SimpleGiftWorkBase:_endBlock()
	if not self:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function SimpleGiftWorkBase:_startBlock()
	if self:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function SimpleGiftWorkBase:_isBlock()
	return not not UIBlockMgr.instance:isBlock()
end

function SimpleGiftWorkBase:onGetViewNames()
	assert(false, "please override this function, and return a table")
end

function SimpleGiftWorkBase:onGetActIds()
	assert(false, "please override this function, and return a table")
end

function SimpleGiftWorkBase:onWork(refWorkContext)
	assert(false, "please override this function")
end

return SimpleGiftWorkBase
