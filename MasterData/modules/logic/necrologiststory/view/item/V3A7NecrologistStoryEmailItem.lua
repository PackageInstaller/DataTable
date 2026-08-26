-- chunkname: @modules/logic/necrologiststory/view/item/V3A7NecrologistStoryEmailItem.lua

module("modules.logic.necrologiststory.view.item.V3A7NecrologistStoryEmailItem", package.seeall)

local V3A7NecrologistStoryEmailItem = class("V3A7NecrologistStoryEmailItem", NecrologistStoryControlItem)

function V3A7NecrologistStoryEmailItem:onInit()
	self._isClick = false
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._btnOpen = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_open")
	self._click = gohelper.getClick(self.viewGO)
end

function V3A7NecrologistStoryEmailItem:onAddEvent()
	self._btnOpen:AddClickListener(self._clickOpen, self)
	self._click:AddClickListener(self._clickOpen, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function V3A7NecrologistStoryEmailItem:onRemoveEvent()
	self._btnOpen:RemoveClickListener()
	self._click:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function V3A7NecrologistStoryEmailItem:_clickOpen()
	if self._isClick then
		return
	end

	self._isClick = true
	self._clickCount = self._clickCount + 1

	if self._anim then
		self._anim:Play("click")
	end

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_call_back_letter_expansion)
	TaskDispatcher.runDelay(self._openMail, self, 0.5)
end

function V3A7NecrologistStoryEmailItem:_openMail()
	TaskDispatcher.cancelTask(self._openMail, self)

	local storyConfig = self:getStoryConfig()

	ViewMgr.instance:openView(ViewName.NecrologistStoryTipView, {
		tagId = storyConfig.param
	})
end

function V3A7NecrologistStoryEmailItem:onCloseView(viewName)
	if viewName == ViewName.NecrologistStoryTipView then
		if self._anim then
			self._anim:Play("open", 0, 1)
		end

		self._isClick = false
		self._isFinish = true

		if self._clickCount <= 1 then
			self:onPlayFinish(true)
		end
	end
end

function V3A7NecrologistStoryEmailItem:onPlayStory()
	self._isFinish = false
	self._clickCount = 0

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnV3A7EmailItem)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_call_back_interface_entry_04)
end

function V3A7NecrologistStoryEmailItem:isDone()
	return self._isFinish
end

function V3A7NecrologistStoryEmailItem:caleHeight()
	return 400
end

function V3A7NecrologistStoryEmailItem:onDestroy()
	TaskDispatcher.cancelTask(self._openMail, self)
end

function V3A7NecrologistStoryEmailItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/v3a7_rolestoryinteractitem.prefab"
end

return V3A7NecrologistStoryEmailItem
