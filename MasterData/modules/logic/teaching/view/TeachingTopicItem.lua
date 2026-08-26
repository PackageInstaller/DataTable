-- chunkname: @modules/logic/teaching/view/TeachingTopicItem.lua

module("modules.logic.teaching.view.TeachingTopicItem", package.seeall)

local TeachingTopicItem = class("TeachingTopicItem", ListScrollCellExtend)

function TeachingTopicItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function TeachingTopicItem:addEvents()
	return
end

function TeachingTopicItem:removeEvents()
	return
end

function TeachingTopicItem:_editableInitView()
	self._goSelect = gohelper.findChild(self.viewGO, "go_selected")
	self._goUnSelect = gohelper.findChild(self.viewGO, "go_unselected")
	self._goLocked = gohelper.findChild(self.viewGO, "go_locked")
	self._txtItemName2 = gohelper.findChildText(self.viewGO, "go_selected/txt_itemcn2")
	self._txtItemName1 = gohelper.findChildText(self.viewGO, "go_unselected/txt_itemcn1")
	self._goFinish1 = gohelper.findChild(self.viewGO, "go_unselected/go_finish1")
	self._gofinish2 = gohelper.findChild(self.viewGO, "go_selected/go_finish2")
	self._imagebg = gohelper.findChildImage(self.viewGO, "image_bg")
	self._itemClick = gohelper.getClickWithAudio(self.viewGO)
	self._goReddot = gohelper.findChild(self.viewGO, "redpoint")
	self._goNewdot = gohelper.findChild(self.viewGO, "newPoint")

	gohelper.setActive(self.viewGO, true)
	gohelper.setActive(self._goLocked, false)
end

function TeachingTopicItem:_editableAddEvents()
	self._itemClick:AddClickListener(self._onItemClick, self)
end

function TeachingTopicItem:_editableRemoveEvents()
	self._itemClick:RemoveClickListener()
end

function TeachingTopicItem:_onItemClick()
	local id = TeachingModel.instance:getSelectTeachingId()

	if self._teachingId == -1 or self._teachingId == id then
		return
	end

	TeachingModel.instance:setSelectTeachingId(self._teachingId)
	AudioMgr.instance:trigger(AudioEnum3_7.Teaching.play_ui_click_teaching)
end

function TeachingTopicItem:refreshItem(teachingId, index)
	self._teachingId = teachingId
	self._index = index

	if self._teachingId ~= -1 then
		local teachingCO = TeachingConfig.instance:getTeachingConfig(teachingId)

		self._txtItemName1.text = teachingCO.name
		self._txtItemName2.text = teachingCO.name

		local isFinish = TeachingModel.instance:getTeachingStatusByTeachingId(teachingId)

		gohelper.setActive(self._gofinish2, isFinish >= TeachingEnum.TeachingStatus.FinishNotReward)
		gohelper.setActive(self._goFinish1, isFinish >= TeachingEnum.TeachingStatus.FinishNotReward)
		gohelper.setActive(self._goNewdot, TeachingModel.instance:needShowNew(teachingId))
		gohelper.setActive(self._goReddot, isFinish == TeachingEnum.TeachingStatus.FinishNotReward)
	else
		self._txtItemName1.text = luaLang("TeachingTopicItem_Default")
		self._txtItemName2.text = luaLang("TeachingTopicItem_Default")

		gohelper.setActive(self._goUnSelect, true)
		gohelper.setActive(self._goSelect, false)
		gohelper.setActive(self._gofinish2, false)
		gohelper.setActive(self._goFinish1, false)
		gohelper.setActive(self._goNewdot, false)
		gohelper.setActive(self._goReddot, false)
		UISpriteSetMgr.instance:setTeachNoteSprite(self._imagebg, "bg_jiaoxuebiji_biaoqian_1_dis")
	end
end

function TeachingTopicItem:refreshState()
	if self._teachingId ~= -1 then
		local isFinish = TeachingModel.instance:getTeachingStatusByTeachingId(self._teachingId)

		gohelper.setActive(self._gofinish2, isFinish >= TeachingEnum.TeachingStatus.FinishNotReward)
		gohelper.setActive(self._goFinish1, isFinish >= TeachingEnum.TeachingStatus.FinishNotReward)
		gohelper.setActive(self._goNewdot, TeachingModel.instance:needShowNew(self._teachingId))
		gohelper.setActive(self._goReddot, isFinish == TeachingEnum.TeachingStatus.FinishNotReward)
	end
end

function TeachingTopicItem:setSelect(selectTeachingId)
	if self._teachingId == -1 then
		return
	end

	local isSelect = selectTeachingId == self._teachingId

	gohelper.setActive(self._goSelect, isSelect)
	gohelper.setActive(self._goUnSelect, not isSelect)

	if isSelect then
		if not ("bg_jiaoxuebiji_biaoqian_" .. self._index .. "_ovr") then
			local bgName = "bg_jiaoxuebiji_biaoqian_" .. self._index

			UISpriteSetMgr.instance:setTeachNoteSprite(self._imagebg, bgName)
		end
	end
end

function TeachingTopicItem:onDestroyView()
	return
end

return TeachingTopicItem
