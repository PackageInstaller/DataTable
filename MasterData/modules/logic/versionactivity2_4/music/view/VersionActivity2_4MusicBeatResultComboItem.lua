-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicBeatResultComboItem.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatResultComboItem", package.seeall)

local VersionActivity2_4MusicBeatResultComboItem = class("VersionActivity2_4MusicBeatResultComboItem", ListScrollCellExtend)

function VersionActivity2_4MusicBeatResultComboItem:onInitView()
	self._gostate1 = gohelper.findChild(self.viewGO, "image_state/#go_state1")
	self._gostate2 = gohelper.findChild(self.viewGO, "image_state/#go_state2")
	self._gostate3 = gohelper.findChild(self.viewGO, "image_state/#go_state3")
	self._txtcombonum = gohelper.findChildText(self.viewGO, "#txt_combonum")
	self._txtscorenum = gohelper.findChildText(self.viewGO, "#txt_scorenum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicBeatResultComboItem:addEvents()
	return
end

function VersionActivity2_4MusicBeatResultComboItem:removeEvents()
	return
end

function VersionActivity2_4MusicBeatResultComboItem:_editableInitView()
	for i = 1, 3 do
		gohelper.setActive(self["_gostate" .. i], false)
	end
end

function VersionActivity2_4MusicBeatResultComboItem:_editableAddEvents()
	return
end

function VersionActivity2_4MusicBeatResultComboItem:_editableRemoveEvents()
	return
end

function VersionActivity2_4MusicBeatResultComboItem:onUpdateMO(index, count, score)
	gohelper.setActive(self["_gostate" .. index], true)

	self._txtcombonum.text = VersionActivity2_4MusicEnum.times_sign .. count
	self._txtscorenum.text = score
end

function VersionActivity2_4MusicBeatResultComboItem:onSelect(isSelect)
	return
end

function VersionActivity2_4MusicBeatResultComboItem:onDestroyView()
	return
end

return VersionActivity2_4MusicBeatResultComboItem
