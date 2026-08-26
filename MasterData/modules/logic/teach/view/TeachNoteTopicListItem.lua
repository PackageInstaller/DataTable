-- chunkname: @modules/logic/teach/view/TeachNoteTopicListItem.lua

module("modules.logic.teach.view.TeachNoteTopicListItem", package.seeall)

local TeachNoteTopicListItem = class("TeachNoteTopicListItem", LuaCompBase)

function TeachNoteTopicListItem:init(go, id, index, showReward, allFinshState)
	self.go = go
	self.id = id
	self.index = index
	self._showReward = showReward
	self._allFinishState = allFinshState
	self._goSelected = gohelper.findChild(go, "go_selected")
	self._imagebg = gohelper.findChildImage(go, "image_bg")
	self._txtSelectCn = gohelper.findChildText(go, "go_selected/txt_itemcn2")
	self._goSelectFinish = gohelper.findChild(go, "go_selected/go_finish2")
	self._txtSelectEn = gohelper.findChildText(go, "go_selected/txt_itemen2")
	self._goUnselected = gohelper.findChild(go, "go_unselected")
	self._txtUnselectCn = gohelper.findChildText(go, "go_unselected/txt_itemcn1")
	self._goUnselectFinish = gohelper.findChild(go, "go_unselected/go_finish1")
	self._txtUnselectEn = gohelper.findChildText(go, "go_unselected/txt_itemen1")
	self._goLocked = gohelper.findChild(go, "go_locked")
	self._goReddot = gohelper.findChild(go, "redpoint")
	self._itemClick = gohelper.getClickWithAudio(go)

	self:addEvents()
	self:_refreshItem()
end

function TeachNoteTopicListItem:addEvents()
	self._itemClick:AddClickListener(self._onItemClick, self)
	TeachNoteController.instance:registerCallback(TeachNoteEvent.ClickTopicItem, self._refreshItem, self)
end

function TeachNoteTopicListItem:removeEvents()
	self._itemClick:RemoveClickListener()
	TeachNoteController.instance:unregisterCallback(TeachNoteEvent.ClickTopicItem, self._refreshItem, self)
end

function TeachNoteTopicListItem:_onItemClick()
	local id = TeachNoteModel.instance:getTeachNoticeTopicId()

	if self.id == id then
		return
	end

	if not TeachNoteModel.instance:isTopicUnlock(self.id) then
		GameFacade.showToast(ToastEnum.TeachNoteTopic)
		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_no_requirement)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_activity_switch)
	TeachNoteModel.instance:setTeachNoticeTopicId(self.id, 0)
	TeachNoteController.instance:dispatchEvent(TeachNoteEvent.ClickTopicItem, self.id)
end

function TeachNoteTopicListItem:_refreshItem()
	local isItemUnlock = TeachNoteModel.instance:isTopicUnlock(self.id)

	if isItemUnlock then
		local id = TeachNoteModel.instance:getTeachNoticeTopicId()

		if self._showReward then
			id = 0
		end

		if id == self.id then
			if not ("bg_jiaoxuebiji_biaoqian_" .. self.index .. "_ovr") then
				local bgName = "bg_jiaoxuebiji_biaoqian_" .. self.index

				UISpriteSetMgr.instance:setTeachNoteSprite(self._imagebg, bgName)
				gohelper.setActive(self._goSelected, id == self.id)
				gohelper.setActive(self._goUnselected, id ~= self.id)
				gohelper.setActive(self._goLocked, false)
				gohelper.setActive(self._goSelectFinish, self._allFinishState)
				gohelper.setActive(self._goUnselectFinish, self._allFinishState)

				local chapterId = TeachNoteConfig.instance:getInstructionTopicCO(self.id).chapterId
				local name = DungeonConfig.instance:getChapterCO(chapterId).name

				self._txtSelectCn.text = name
				self._txtUnselectCn.text = name
			end
		end
	else
		gohelper.setActive(self._goSelected, false)
		gohelper.setActive(self._goUnselected, false)
		gohelper.setActive(self._goLocked, true)
		UISpriteSetMgr.instance:setTeachNoteSprite(self._imagebg, "bg_jiaoxuebiji_biaoqian_" .. self.index .. "_dis")
	end

	gohelper.setActive(self._goReddot, TeachNoteModel.instance:isTopicNew(self.id))
end

function TeachNoteTopicListItem:onDestroyView()
	self:removeEvents()
	gohelper.destroy(self.go)
end

return TeachNoteTopicListItem
