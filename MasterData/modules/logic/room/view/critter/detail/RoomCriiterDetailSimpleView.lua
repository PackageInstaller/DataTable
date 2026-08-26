-- chunkname: @modules/logic/room/view/critter/detail/RoomCriiterDetailSimpleView.lua

module("modules.logic.room.view.critter.detail.RoomCriiterDetailSimpleView", package.seeall)

local RoomCriiterDetailSimpleView = class("RoomCriiterDetailSimpleView", RoomCritterDetailView)

function RoomCriiterDetailSimpleView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagecard = gohelper.findChildSingleImage(self.viewGO, "#simage_card")
	self._imagesort = gohelper.findChildImage(self.viewGO, "#image_sort")
	self._txtsort = gohelper.findChildText(self.viewGO, "#image_sort/#txt_sort")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._gocrittericon = gohelper.findChild(self.viewGO, "critter/#go_crittericon")
	self._txttag1 = gohelper.findChildText(self.viewGO, "tag/#txt_tag1")
	self._txttag2 = gohelper.findChildText(self.viewGO, "tag/#txt_tag2")
	self._scrolldes = gohelper.findChildScrollRect(self.viewGO, "#scroll_des")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#scroll_des/viewport/content/#txt_Desc")
	self._scrollbase = gohelper.findChildScrollRect(self.viewGO, "base/#scroll_base")
	self._gobaseitem = gohelper.findChild(self.viewGO, "base/#scroll_base/viewport/content/#go_baseitem")
	self._scrollskill = gohelper.findChildScrollRect(self.viewGO, "skill/#scroll_skill")
	self._goskillItem = gohelper.findChild(self.viewGO, "skill/#scroll_skill/viewport/content/#go_skillItem")
	self._txtskillname = gohelper.findChildText(self.viewGO, "skill/#scroll_skill/viewport/content/#go_skillItem/title/#txt_skillname")
	self._imageicon = gohelper.findChildImage(self.viewGO, "skill/#scroll_skill/viewport/content/#go_skillItem/title/#txt_skillname/#image_icon")
	self._txtskilldec = gohelper.findChildText(self.viewGO, "skill/#scroll_skill/viewport/content/#go_skillItem/#txt_skilldec")
	self._gostar = gohelper.findChild(self.viewGO, "starList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCriiterDetailSimpleView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomCriiterDetailSimpleView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function RoomCriiterDetailSimpleView:_btncloseOnClick()
	self:closeThis()
end

function RoomCriiterDetailSimpleView:_editableInitView()
	RoomCriiterDetailSimpleView.super._editableInitView(self)
end

function RoomCriiterDetailSimpleView:onOpen()
	self._critterMo = self.viewParam.critterMo

	gohelper.setActive(self._gobaseitem.gameObject, false)
	gohelper.setActive(self._goskillItem.gameObject, false)
	self:showInfo()
	self:setCritterIcon()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_ka2)
end

function RoomCriiterDetailSimpleView:onDestroyView()
	if self._simagecard then
		self._simagecard:UnLoadImage()
	end
end

function RoomCriiterDetailSimpleView:getAttrRatioColor()
	return "#222222", "#222222"
end

function RoomCriiterDetailSimpleView:setCritterIcon()
	self._critterIcon = self._critterIcon or IconMgr.instance:getCommonCritterIcon(self._gocrittericon)

	self._critterIcon:onUpdateMO(self._critterMo, true)
	self._critterIcon:hideMood()

	local rare = self._critterMo:getDefineCfg().rare

	if self._simagecard then
		local rareCo = CritterConfig.instance:getCritterRareCfg(rare)
		local iconPath = ResUrl.getRoomCritterIcon(rareCo.cardRes)

		self._simagecard:LoadImage(iconPath)
	end
end

function RoomCriiterDetailSimpleView:refrshCritterSpine()
	return
end

return RoomCriiterDetailSimpleView
