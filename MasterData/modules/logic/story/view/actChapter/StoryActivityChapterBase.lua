-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterBase.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterBase", package.seeall)

local StoryActivityChapterBase = class("StoryActivityChapterBase", UserDataDispose)

function StoryActivityChapterBase:ctor(parentGo)
	self:__onInit()

	self.rootGO = gohelper.create2d(parentGo, "chapter")

	local rectTr = self.rootGO.transform

	rectTr.anchorMin = RectTransformDefine.Anchor.LeftBottom
	rectTr.anchorMax = RectTransformDefine.Anchor.RightUp
	rectTr.sizeDelta = RectTransformDefine.Anchor.LeftBottom

	self:onCtor()
end

function StoryActivityChapterBase:loadPrefab()
	if not self.assetPath then
		return
	end

	self._resLoader = self._resLoader or PrefabInstantiate.Create(self.rootGO)

	self._resLoader:startLoad(self.assetPath, self.onLoaded, self)
end

function StoryActivityChapterBase:onLoaded()
	self.viewGO = self._resLoader:getInstGO()

	self:onInitView()
	self:onUpdateView()
end

function StoryActivityChapterBase:setData(co)
	self.data = co

	if not self.viewGO then
		self:loadPrefab()

		return
	end

	gohelper.setActive(self.rootGO, true)
	self:onUpdateView()
end

function StoryActivityChapterBase:hide()
	gohelper.setActive(self.rootGO, false)
	self:onHide()
end

function StoryActivityChapterBase:onCtor()
	return
end

function StoryActivityChapterBase:onInitView()
	return
end

function StoryActivityChapterBase:onUpdateView()
	return
end

function StoryActivityChapterBase:onHide()
	return
end

function StoryActivityChapterBase:onDestory()
	if self._resloader then
		self._resloader:dispose()

		self._resloader = nil
	end

	if self.rootGO then
		gohelper.destroy(self.rootGO)

		self.rootGO = nil
	end

	self:__onDispose()
end

return StoryActivityChapterBase
