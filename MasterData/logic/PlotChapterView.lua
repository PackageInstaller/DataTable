-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/PlotChapterView.lua

module("logic.extensions.plotcopy.view.PlotChapterView", package.seeall)

local PlotChapterView = class("PlotChapterView", ChapterViewBase)

function PlotChapterView:onEnter()
	PlotChapterView.super.onEnter(self)
	self:_recordNewChapter()
end

function PlotChapterView:onExit()
	PlotChapterView.super.onExit(self)

	local chapterId = self._chapterId

	UIStateManager.instance:updateParms(ViewName.PlotChapterView, {
		chapterId
	})
end

function PlotChapterView:_recordNewChapter()
	local name = RoleModel.instance:getUserId() .. CopyConst.isNewChatper .. self._chapterId
	local num = UnityEngine.PlayerPrefs.GetInt(name)
	local isNew = num == 0

	if isNew then
		UnityEngine.PlayerPrefs.SetInt(name, 1)
	end
end

function PlotChapterView:_getChapterType()
	return GameEnum.Chapter.Plot
end

return PlotChapterView
