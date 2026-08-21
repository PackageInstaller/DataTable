-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PlotRewind\\HandBookShowAVGDlg.lua

local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local strClassName = "HandBookShowAVGDlg"
local ChapterEndPanel = require("UI/AVG/ChapterEndPanel")
local ChapterPosterPanel = require("UI/AVG/ChapterPosterPanel")
local HandBookShowAVGDlg = Class(strClassName, UIControls.Window)

function HandBookShowAVGDlg:ctor()
	self.panelMountPath = "BgPanel/"
end

function HandBookShowAVGDlg:showChapterEnd(chapterEndId)
	self.chapterEndChild = ChapterEndPanel(self, self.panelMountPath, "System/AVG/AVGChapterEndPanel")

	self.chapterEndChild:showChapterEnd(chapterEndId, Slot(self._stopChapterEnd, self))
	self.chapterEndChild:setVisible(true)
end

function HandBookShowAVGDlg:showChapterPoster(posterPath, hdPosterPath)
	self.chapterPosterChild = ChapterPosterPanel(self, self.panelMountPath, "System/AVG/AVGChapterEnd02Panel")

	self.chapterPosterChild:showChapterPoster(posterPath, hdPosterPath, Slot(self._stopChapterPoster, self))
	self.chapterPosterChild:setVisible(true)
end

function HandBookShowAVGDlg:_stopChapterPoster()
	return
end

function HandBookShowAVGDlg:_stopChapterEnd()
	return
end

return HandBookShowAVGDlg
