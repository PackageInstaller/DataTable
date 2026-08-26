-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicBeatResultEvaluateItem.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatResultEvaluateItem", package.seeall)

local VersionActivity2_4MusicBeatResultEvaluateItem = class("VersionActivity2_4MusicBeatResultEvaluateItem", ListScrollCellExtend)

function VersionActivity2_4MusicBeatResultEvaluateItem:onInitView()
	self._gostate1 = gohelper.findChild(self.viewGO, "image_state/#go_state1")
	self._gostate2 = gohelper.findChild(self.viewGO, "image_state/#go_state2")
	self._gostate3 = gohelper.findChild(self.viewGO, "image_state/#go_state3")
	self._gostate4 = gohelper.findChild(self.viewGO, "image_state/#go_state4")
	self._txtcombonum = gohelper.findChildText(self.viewGO, "#txt_combonum")
	self._txtscorenum = gohelper.findChildText(self.viewGO, "#txt_scorenum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicBeatResultEvaluateItem:addEvents()
	return
end

function VersionActivity2_4MusicBeatResultEvaluateItem:removeEvents()
	return
end

function VersionActivity2_4MusicBeatResultEvaluateItem:_editableInitView()
	for i = 1, 4 do
		gohelper.setActive(self["_gostate" .. i], false)
	end
end

function VersionActivity2_4MusicBeatResultEvaluateItem:_editableAddEvents()
	return
end

function VersionActivity2_4MusicBeatResultEvaluateItem:_editableRemoveEvents()
	return
end

function VersionActivity2_4MusicBeatResultEvaluateItem:onUpdateMO(grade, count)
	gohelper.setActive(self["_gostate" .. grade], true)

	self._txtcombonum.text = VersionActivity2_4MusicEnum.times_sign .. count
	self._txtscorenum.text = "+" .. VersionActivity2_4MusicBeatModel.instance:getGradeScore(grade) * count
end

function VersionActivity2_4MusicBeatResultEvaluateItem:onSelect(isSelect)
	return
end

function VersionActivity2_4MusicBeatResultEvaluateItem:onDestroyView()
	return
end

return VersionActivity2_4MusicBeatResultEvaluateItem
