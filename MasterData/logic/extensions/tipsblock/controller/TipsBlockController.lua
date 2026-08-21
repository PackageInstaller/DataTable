-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tipsblock/controller/TipsBlockController.lua

module("logic.extensions.tipsblock.controller.TipsBlockController", package.seeall)

local M = class("TipsBlockController", BaseController)

function M:ctor()
	M.super.ctor(self)

	self._blockMarkSignal = SignalAmount.New()
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:onReset()
	self:setBlockMark(nil)
	self._blockMarkSignal:clear()
end

function M:setBlockMark(mark, enable)
	if enable then
		self._blockMarkSignal:addUnique(mark or TipsBlockUtil.BlockMark.Default)
	else
		self._blockMarkSignal:remove(mark or TipsBlockUtil.BlockMark.Default)
	end
end

function M:getBlockMarkStr()
	return self._blockMarkSignal:toString()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.TIPS_BLOCK_CONTROL, self._handleTipsBlockControl, self)
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseEvent, self)
		GlobalDispatcher:addEventListener(EventType.GUIDE_FINISH_STEP, self._handleGuideFinishStep, self)
		GlobalDispatcher:addEventListener(EventType.SCENE_FLOW_ENTER_FINISH, self._handleSceneFlowEnterFinish, self)
		StoryDispatcher:addEventListener(StoryNotifyName.StoryExit, self.onFinishStory, self)
	else
		GlobalDispatcher:removeEventListener(EventType.TIPS_BLOCK_CONTROL, self._handleTipsBlockControl, self)
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseEvent, self)
		GlobalDispatcher:removeEventListener(EventType.GUIDE_FINISH_STEP, self._handleGuideFinishStep, self)
		GlobalDispatcher:removeEventListener(EventType.SCENE_FLOW_ENTER_FINISH, self._handleSceneFlowEnterFinish, self)
		StoryDispatcher:removeEventListener(StoryNotifyName.StoryExit, self.onFinishStory, self)
	end
end

function M:_handleTipsBlockControl(e, active, markName)
	if active then
		if string.nilorempty(markName) then
			if enableLog then
				TipsBlockUtil.print("请正确传入markName", true)
			end

			markName = "Undefine"
		end

		self:setBlockMark(markName)
	else
		self:setBlockMark(nil)
		self:popUpView()
	end
end

function M:_handleViewCloseEvent(e, viewName, opTyp)
	self:popUpView()
end

function M:_handleGuideFinishStep()
	self:popUpView()
end

function M:_handleSceneFlowEnterFinish()
	self:popUpView()
end

function M:onFinishStory(evt, storyId)
	self:popUpView()
end

function M:getOpeningView()
	return self._openingView
end

function M:setOpeingView(view)
	self._openingView = view
end

function M:canOpen(viewName)
	local canOpen = true

	if not string.nilorempty(self:getOpeningView()) and not ViewMgr.instance:isOpen(self:getOpeningView()) then
		self:setOpeingView(nil)
	end

	if self._blockMarkSignal:isActive() then
		if enableLog then
			TipsBlockUtil.print(string.format("block view[%s] by blockMark:%s", viewName, self:getBlockMarkStr()))
		end

		canOpen = false
	elseif not string.nilorempty(self:getOpeningView()) then
		if enableLog then
			TipsBlockUtil.print(string.format("block view[%s] by has openingView:%s", viewName, self:getOpeningView()))
		end

		canOpen = false
	elseif not TipsBlockUtil.canOpen(viewName) then
		if enableLog then
			TipsBlockUtil.print(string.format("block view[%s] by TipsBlockUtil.canOpen", viewName))
		end

		canOpen = false
	end

	return canOpen
end

function M:openView(viewName, ...)
	if enableLog then
		TipsBlockUtil.print(string.format("open :%s", viewName), true)
	end

	TipsBlockModel.instance:addToBlockLst(viewName, ...)
	self:popUpView()
end

function M:cancelOpenView(viewName, onlyFirst)
	TipsBlockModel.instance:removeFromBlockLst(viewName, onlyFirst)
end

function M:popUpView()
	local viewName = TipsBlockModel.instance:getTopViewName()

	if viewName and self:canOpen(viewName) then
		self:setOpeingView(viewName)

		local data = TipsBlockModel.instance:popView()

		ViewMgr.instance:open(data.viewName, unpack(data.params))
	end
end

M.instance = M.New()

return M
