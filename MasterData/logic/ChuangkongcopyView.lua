-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongcopyView.lua

module("logic.extensions.scenariocopy.view.dreamteammutualhelp.ChuangkongcopyView", package.seeall)

local ChuangkongcopyView = class("ChuangkongcopyView", FatherDungeonView)

function ChuangkongcopyView:ctor()
	ChuangkongcopyView.super.ctor(self)
end

function ChuangkongcopyView:_getChapterMaxNum()
	return 2
end

function ChuangkongcopyView:_getStageMaxNum()
	return 5
end

function ChuangkongcopyView:_getIndexRange()
	return 8, 9
end

function ChuangkongcopyView:_getStageViewName()
	return ViewName.ChuangkongplotstageView
end

function ChuangkongcopyView:buildUI()
	ChuangkongcopyView.super.buildUI(self)
end

function ChuangkongcopyView:getRollbackView()
	return ViewName.ChuangkongunionView
end

function ChuangkongcopyView:onExit()
	ChuangkongcopyView.super.onExit(self)
end

ChuangkongcopyView.CHAPTER_KEY = "chuangkongcopyview_key"

function ChuangkongcopyView:_setSelectChapter(index)
	ChuangkongcopyView.super._setSelectChapter(self, index)

	for i, v in ipairs(self._chapters) do
		self:setActiveIngoreNil(v.btnChapter.gameObject, i ~= self._curSelectChapterIndex)
	end
end

function ChuangkongcopyView:onEnter()
	self.isRollback = false

	ChuangkongcopyView.super.onEnter(self)
	self:rollbackChapterIndex()
end

function ChuangkongcopyView:_onStageUpdate()
	ChuangkongcopyView.super._onStageUpdate(self)
	self:rollbackChapterIndex()
end

function ChuangkongcopyView:rollbackChapterIndex()
	if self.isRollback then
		return
	end

	if not ScenariocopyModel.instance:getHasGetInfo() then
		return
	end

	self.isRollback = true

	GameUtil.getUserData(ChuangkongcopyView.CHAPTER_KEY, function(value)
		local lastSelectChapter = checknumber(value)

		if lastSelectChapter > 0 then
			self:_setSelectChapter(lastSelectChapter)
		end
	end)
end

return ChuangkongcopyView
