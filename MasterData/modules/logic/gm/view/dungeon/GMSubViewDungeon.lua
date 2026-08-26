-- chunkname: @modules/logic/gm/view/dungeon/GMSubViewDungeon.lua

module("modules.logic.gm.view.dungeon.GMSubViewDungeon", package.seeall)

local GMSubViewDungeon = class("GMSubViewDungeon", GMSubViewBase)

function GMSubViewDungeon:ctor()
	self.tabName = "副本"
end

function GMSubViewDungeon:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewDungeon:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewDungeon:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)

	self.lineIndex = 1

	self:addTitleSplitLine("元件复看")
	self:addLabel(self:getLineGroup(), "章节id")

	self._chapterInput = self.addInputText(self, self:getLineGroup(), "", "章节ID", self._inputChapterId, self, {
		w = 300
	})

	local chapterName = self:_getChapterName()

	self._chapterNameTxt = self:addLabel(self:getLineGroup(), chapterName, {
		w = 500,
		c = "#FF5C00"
	})

	self.addButton(self, self:getLineGroup(), "打开复看界面", self._openRecheckView, self)
end

function GMSubViewDungeon:_inputChapterId()
	self._chapterNameTxt.text = self:_getChapterName()
end

function GMSubViewDungeon:_getChapterId()
	local chapterId = self._chapterInput:GetText()

	if string.nilorempty(chapterId) then
		return
	end

	chapterId = tonumber(chapterId)

	return chapterId
end

function GMSubViewDungeon:_getChapterName()
	local chapterId = self:_getChapterId()
	local chapterCo = chapterId and lua_chapter.configDict[chapterId]

	if chapterCo then
		return chapterCo.name
	end

	return ""
end

function GMSubViewDungeon:_openRecheckView()
	local chapterId = self:_getChapterId()

	if not chapterId then
		return
	end

	DungeonController.instance:openRecheckElementView(chapterId, true, true)
end

return GMSubViewDungeon
