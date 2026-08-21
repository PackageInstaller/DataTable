-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryFullEfxRTViewComponent.lua

module("logic.extensions.story.view.StoryFullEfxRTViewComponent", package.seeall)

local M = class("StoryFullEfxRTViewComponent", ViewComponent)

function M:buildUI()
	self._goEfxRTPhoto = self:getGo("story_main_view_1377915572")
	self._efxRTPhoto = Astral.LuaComponentContainer.Add(self._goEfxRTPhoto, PhotoEffect)
end

function M:onEnter()
	StoryDispatcher:addEventListener(StoryNotifyName.UIFullEfxRTEvent, self._onUIFullEfxRt, self)
end

function M:onExit()
	StoryDispatcher:removeEventListener(StoryNotifyName.UIFullEfxRTEvent, self._onUIFullEfxRt, self)

	if self._efxRTPhoto then
		self._efxRTPhoto:clear()
	end

	self:_switchVisible(false)
end

function M:destroyUI()
	return
end

function M:_onUIFullEfxRt(_, isShow, data)
	if not isShow then
		self:_onCloseUIFullEfxRt()
	else
		if goutil.isNil(data.efxGameObj) then
			printWarn("Story Log: full effect in story ui is null")

			return
		end

		StoryFacde.instance:showAll(StoryConst.DefaultStateKey)
		self:_switchVisible(true)
		self._efxRTPhoto:showEffectWithObj(data.efxGameObj, PhotoCacheMgr.SIZE_FULL_WIDTH, PhotoCacheMgr.SIZE_FULL_HEIGHT)
		self._efxRTPhoto:setCameraOrthographic(5)
		self._efxRTPhoto:setCameraPosition(0, 0, -20)
	end
end

function M:_onCloseUIFullEfxRt()
	if self._efxRTPhoto then
		self._efxRTPhoto:clear()
	end

	self:_switchVisible(false)
end

function M:_switchVisible(bl)
	goutil.setActive(self._goEfxRTPhoto, bl)
end

return M
