-- chunkname: @modules/logic/necrologiststory/view/item/V3A5NecrologistStoryLongPressItem.lua

module("modules.logic.necrologiststory.view.item.V3A5NecrologistStoryLongPressItem", package.seeall)

local V3A5NecrologistStoryLongPressItem = class("V3A5NecrologistStoryLongPressItem", NecrologistStoryControlItem)

function V3A5NecrologistStoryLongPressItem:onInit()
	self.anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	self.goClick = gohelper.findChild(self.viewGO, "root/go_click/click")
	self.goNormal = gohelper.findChild(self.viewGO, "root/go_click/normal")
	self.goFinished = gohelper.findChild(self.viewGO, "root/go_click/finished")
end

function V3A5NecrologistStoryLongPressItem:onAddEvent()
	self.btnLongPress = SLFramework.UGUI.UIClickListener.Get(self.goClick)

	self.btnLongPress:AddClickDownListener(self._onLongClickDown, self)
	self.btnLongPress:AddClickUpListener(self._onLongClickUp, self)
	self.animEventWrap:AddEventListener("finish", self.setDone, self)
end

function V3A5NecrologistStoryLongPressItem:onRemoveEvent()
	self.btnLongPress:RemoveClickDownListener()
	self.btnLongPress:RemoveClickUpListener()
	self.animEventWrap:RemoveAllEventListener()
end

function V3A5NecrologistStoryLongPressItem:_onLongClickDown()
	if self:isDone() then
		return
	end

	self.anim:Play("finish")

	self.anim.speed = 1

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_bfz_yishi_antenna_loop)
end

function V3A5NecrologistStoryLongPressItem:_onLongClickUp()
	if self:isDone() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_bfz_yishi_antenna_loop)

	self.anim.speed = 0
end

function V3A5NecrologistStoryLongPressItem:setDone()
	if self:isDone() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_bfz_yishi_antenna_loop)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_bfz_yishi_antenna_straighten)

	self._isFinish = true

	gohelper.setActive(self.goClick, false)
	self:onPlayFinish()
end

function V3A5NecrologistStoryLongPressItem:onPlayStory()
	self._isFinish = false

	gohelper.setActive(self.goClick, true)
	self:refreshState()
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnV3A5LongPress)
end

function V3A5NecrologistStoryLongPressItem:refreshState()
	local isDone = self:isDone()

	if isDone then
		self.anim:Play("finish")
	else
		self.anim:Play("open")
	end
end

function V3A5NecrologistStoryLongPressItem:isDone()
	return self._isFinish
end

function V3A5NecrologistStoryLongPressItem:caleHeight()
	return 400
end

function V3A5NecrologistStoryLongPressItem:onDestroy()
	return
end

function V3A5NecrologistStoryLongPressItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/v3a5_necrologiststoryitem.prefab"
end

return V3A5NecrologistStoryLongPressItem
