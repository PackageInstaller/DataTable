-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeartBuffItem.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeartBuffItem", package.seeall)

local WeekWalk_2HeartBuffItem = class("WeekWalk_2HeartBuffItem", ListScrollCellExtend)

function WeekWalk_2HeartBuffItem:onInitView()
	self._goSelect = gohelper.findChild(self.viewGO, "#go_Select")
	self._imageBuffIcon = gohelper.findChildImage(self.viewGO, "#image_BuffIcon")
	self._goEquiped = gohelper.findChild(self.viewGO, "#go_Equiped")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2HeartBuffItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function WeekWalk_2HeartBuffItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function WeekWalk_2HeartBuffItem:_btnclickOnClick()
	if self._isSelected then
		return
	end

	self._view:selectCell(self._index, true)
end

function WeekWalk_2HeartBuffItem:_editableInitView()
	gohelper.setActive(self._goEquiped, false)
end

function WeekWalk_2HeartBuffItem:_editableAddEvents()
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSetupReply, self._onBuffSetupReply, self)
end

function WeekWalk_2HeartBuffItem:_editableRemoveEvents()
	return
end

function WeekWalk_2HeartBuffItem:_onBuffSetupReply()
	self:_checkEquiped()
end

function WeekWalk_2HeartBuffItem:onUpdateMO(mo)
	self._config = mo

	self:_checkEquiped()
	UISpriteSetMgr.instance:setWeekWalkSprite(self._imageBuffIcon, self._config.icon)

	local prevBattleSkillId = WeekWalk_2BuffListModel.instance.prevBattleSkillId

	ZProj.UGUIHelper.SetGrayscale(self._imageBuffIcon.gameObject, prevBattleSkillId == self._config.id)
end

function WeekWalk_2HeartBuffItem:onSelect(isSelect)
	self._isSelected = isSelect

	gohelper.setActive(self._goSelect, self._isSelected)

	if self._isSelected then
		WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnBuffSelectedChange, self._config)
	end
end

function WeekWalk_2HeartBuffItem:_checkEquiped()
	if not WeekWalk_2BuffListModel.instance.isBattle then
		return
	end

	local selectedSkillId = WeekWalk_2BuffListModel.getCurHeroGroupSkillId()

	gohelper.setActive(self._goEquiped, selectedSkillId == self._config.id)
end

function WeekWalk_2HeartBuffItem:onDestroyView()
	return
end

return WeekWalk_2HeartBuffItem
