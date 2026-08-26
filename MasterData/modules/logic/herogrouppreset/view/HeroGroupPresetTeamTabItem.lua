-- chunkname: @modules/logic/herogrouppreset/view/HeroGroupPresetTeamTabItem.lua

module("modules.logic.herogrouppreset.view.HeroGroupPresetTeamTabItem", package.seeall)

local HeroGroupPresetTeamTabItem = class("HeroGroupPresetTeamTabItem", ListScrollCellExtend)

function HeroGroupPresetTeamTabItem:onInitView()
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._gounselectedbg = gohelper.findChild(self.viewGO, "#go_info/#go_unselectedbg")
	self._txtunselectedname = gohelper.findChildText(self.viewGO, "#go_info/#go_unselectedbg/#txt_unselectedname")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_info/#go_unselectedbg/#image_icon")
	self._gobeselectedbg = gohelper.findChild(self.viewGO, "#go_info/#go_beselectedbg")
	self._txtbeselectedname = gohelper.findChildText(self.viewGO, "#go_info/#go_beselectedbg/#txt_beselectedname")
	self._imageicon2 = gohelper.findChildImage(self.viewGO, "#go_info/#go_beselectedbg/#image_icon2")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupPresetTeamTabItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function HeroGroupPresetTeamTabItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function HeroGroupPresetTeamTabItem:_btnclickOnClick()
	HeroGroupPresetTabListModel.instance:setSelectedCell(self._index, true)
end

function HeroGroupPresetTeamTabItem:_editableInitView()
	self._animator = self.viewGO:GetComponent("Animator")
end

function HeroGroupPresetTeamTabItem:getAnimator()
	return self._animator
end

function HeroGroupPresetTeamTabItem:_editableAddEvents()
	return
end

function HeroGroupPresetTeamTabItem:_editableRemoveEvents()
	return
end

function HeroGroupPresetTeamTabItem:onUpdateMO(mo)
	self._mo = mo
	self._txtbeselectedname.text = self._mo.name
	self._txtunselectedname.text = self._mo.name
end

function HeroGroupPresetTeamTabItem:onSelect(isSelect)
	gohelper.setActive(self._gobeselectedbg, isSelect)
	gohelper.setActive(self._gounselectedbg, not isSelect)
end

function HeroGroupPresetTeamTabItem:onDestroyView()
	return
end

return HeroGroupPresetTeamTabItem
