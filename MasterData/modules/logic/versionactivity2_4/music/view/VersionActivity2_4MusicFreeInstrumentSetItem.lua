-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeInstrumentSetItem.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeInstrumentSetItem", package.seeall)

local VersionActivity2_4MusicFreeInstrumentSetItem = class("VersionActivity2_4MusicFreeInstrumentSetItem", ListScrollCellExtend)

function VersionActivity2_4MusicFreeInstrumentSetItem:onInitView()
	self._btnroot = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_root")
	self._goselect = gohelper.findChild(self.viewGO, "#btn_root/#go_select")
	self._gounselect = gohelper.findChild(self.viewGO, "#btn_root/#go_unselect")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#btn_root/#image_icon")
	self._imageselectframe = gohelper.findChildImage(self.viewGO, "#btn_root/#image_selectframe")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_root/#btn_click")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicFreeInstrumentSetItem:addEvents()
	self._btnroot:AddClickListener(self._btnrootOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function VersionActivity2_4MusicFreeInstrumentSetItem:removeEvents()
	self._btnroot:RemoveClickListener()
	self._btnclick:RemoveClickListener()
end

function VersionActivity2_4MusicFreeInstrumentSetItem:_btnclickOnClick()
	if self._showIndex then
		self._parentView:removeInstrument(self._mo.id)

		return
	end

	self._parentView:addInstrument(self._mo.id)
end

function VersionActivity2_4MusicFreeInstrumentSetItem:_btnrootOnClick()
	return
end

function VersionActivity2_4MusicFreeInstrumentSetItem:_editableInitView()
	return
end

function VersionActivity2_4MusicFreeInstrumentSetItem:_editableAddEvents()
	return
end

function VersionActivity2_4MusicFreeInstrumentSetItem:_editableRemoveEvents()
	return
end

function VersionActivity2_4MusicFreeInstrumentSetItem:onUpdateMO(mo, parent)
	self._mo = mo
	self._parentView = parent
	self._txtname.text = self._mo.name

	self:updateIndex()
	UISpriteSetMgr.instance:setMusicSprite(self._imageicon, "v2a4_bakaluoer_freeinstrument_icon_t_" .. mo.icon)
end

function VersionActivity2_4MusicFreeInstrumentSetItem:updateIndex()
	local index = tabletool.indexOf(self._parentView._indexList, self._mo.id)

	self._showIndex = index ~= nil

	gohelper.setActive(self._imageselectframe, self._showIndex)
	gohelper.setActive(self._goselect, self._showIndex)
	gohelper.setActive(self._gounselect, not self._showIndex)

	if self._showIndex then
		UISpriteSetMgr.instance:setMusicSprite(self._imageselectframe, "v2a4_bakaluoer_freeinstrument_set_num" .. index)
	end

	local color = self._imageicon.color

	color.a = self._showIndex and 1 or 0.35
	self._imageicon.color = color
	self._txtname.color = GameUtil.parseColor(self._showIndex and "#ebf0f4" or "#728698")
end

function VersionActivity2_4MusicFreeInstrumentSetItem:onSelect(isSelect)
	return
end

function VersionActivity2_4MusicFreeInstrumentSetItem:onDestroyView()
	return
end

return VersionActivity2_4MusicFreeInstrumentSetItem
