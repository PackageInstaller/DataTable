-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/EliteChapterView.lua

module("logic.extensions.plotcopy.view.EliteChapterView", package.seeall)

local EliteChapterView = class("EliteChapterView", ChapterViewBase)

function EliteChapterView:onEnter()
	EliteChapterView.super.onEnter(self)
	self:_recordNewChapter()
end

function EliteChapterView:onExit()
	EliteChapterView.super.onExit(self)

	local chapterId = self._chapterId

	UIStateManager.instance:updateParms(ViewName.EliteChapterView, chapterId)
end

function EliteChapterView:_recordNewChapter()
	local name = RoleModel.instance:getUserId() .. CopyConst.isNewChatper .. self._chapterId
	local num = UnityEngine.PlayerPrefs.GetInt(name)
	local isNew = num == 0

	if isNew then
		UnityEngine.PlayerPrefs.SetInt(name, 1)
	end
end

function EliteChapterView:_getChapterType()
	return GameEnum.Chapter.Elite
end

return EliteChapterView
