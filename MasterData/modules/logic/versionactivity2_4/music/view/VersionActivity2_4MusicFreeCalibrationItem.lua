-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeCalibrationItem.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeCalibrationItem", package.seeall)

local VersionActivity2_4MusicFreeCalibrationItem = class("VersionActivity2_4MusicFreeCalibrationItem", ListScrollCellExtend)

function VersionActivity2_4MusicFreeCalibrationItem:onInitView()
	self._btnnote = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_note")
	self._imageopen = gohelper.findChild(self.viewGO, "#btn_note/#image_open")
	self._imageicon1 = gohelper.findChildImage(self.viewGO, "#btn_note/#image_open/#image_icon1")
	self._txtname1 = gohelper.findChildText(self.viewGO, "#btn_note/#image_open/#txt_name1")
	self._imageclose = gohelper.findChildImage(self.viewGO, "#btn_note/#image_close")
	self._imageicon2 = gohelper.findChildImage(self.viewGO, "#btn_note/#image_close/#image_icon2")
	self._txtname2 = gohelper.findChildText(self.viewGO, "#btn_note/#image_close/#txt_name2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicFreeCalibrationItem:addEvents()
	self._btnnote:AddClickListener(self._btnnoteOnClick, self)
end

function VersionActivity2_4MusicFreeCalibrationItem:removeEvents()
	self._btnnote:RemoveClickListener()
end

function VersionActivity2_4MusicFreeCalibrationItem:_btnnoteOnClick()
	self._isOpen = not self._isOpen

	self:_updateStatus()
end

function VersionActivity2_4MusicFreeCalibrationItem:_editableInitView()
	return
end

function VersionActivity2_4MusicFreeCalibrationItem:_editableAddEvents()
	return
end

function VersionActivity2_4MusicFreeCalibrationItem:_editableRemoveEvents()
	return
end

function VersionActivity2_4MusicFreeCalibrationItem:onUpdateMO(id)
	self._id = id
	self._isOpen = VersionActivity2_4MusicFreeModel.instance:getAccompany(id) == VersionActivity2_4MusicEnum.AccompanyStatus.Open

	local name = self:_getName()

	self._txtname1.text = name
	self._txtname2.text = name

	local icon = VersionActivity2_4MusicFreeModel.instance:getAccompanyIcon(id)

	UISpriteSetMgr.instance:setMusicSprite(self._imageicon1, icon)
	UISpriteSetMgr.instance:setMusicSprite(self._imageicon2, icon)
	self:_updateStatus()
end

function VersionActivity2_4MusicFreeCalibrationItem:_updateStatus()
	gohelper.setActive(self._imageopen, self._isOpen)
	gohelper.setActive(self._imageclose, not self._isOpen)

	if self._isOpen then
		if not VersionActivity2_4MusicEnum.AccompanyStatus.Open then
			local value = VersionActivity2_4MusicEnum.AccompanyStatus.Close

			VersionActivity2_4MusicFreeModel.instance:setAccompany(self._id, value)
			AudioMgr.instance:setRTPCValue(VersionActivity2_4MusicEnum.AccompanyTypeName[self._id], value)
		end
	end
end

function VersionActivity2_4MusicFreeCalibrationItem:_getName()
	return luaLang("MusicAccompany" .. self._id)
end

function VersionActivity2_4MusicFreeCalibrationItem:onSelect(isSelect)
	return
end

function VersionActivity2_4MusicFreeCalibrationItem:onDestroyView()
	return
end

return VersionActivity2_4MusicFreeCalibrationItem
