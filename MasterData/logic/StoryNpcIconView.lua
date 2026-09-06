-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryNpcIconView.lua

module("logic.extensions.story.view.StoryNpcIconView", package.seeall)

local StoryNpcIconView = class("StoryNpcIconView")

function StoryNpcIconView:ctor(direction, npcIconNode)
	self._direction = direction
	self._npcIconNode = npcIconNode

	if self._npcIconNode then
		self._npcIconImg = goutil.findChild(self._npcIconNode, "icon"):GetComponent(typeof(Framework.ImageBigBG))
	end
end

function StoryNpcIconView:onEnter()
	if self._npcIconNode then
		self._npcIconNode:SetActive(false)
	end

	self._resLoader = MultiResLoader.New()
end

function StoryNpcIconView:onExit()
	self._currStory = nil

	if self._npcIconImg then
		self._npcIconImg:ClearImage()
	end

	GameUtil.unloadMultiResLoaderResource(self._resLoader)

	self._npcIconPath = nil
	self._isLoadingNpcIcon = nil
	self._resLoader = nil
end

function StoryNpcIconView:setStory(story)
	self._currStory = story
	self._dispearOver = self._currStory.disappear_over

	self:_showNpcIcon()
end

function StoryNpcIconView:onNotCurrShowing()
	self:hideObject()
end

function StoryNpcIconView:isDisappear_over()
	return self._dispearOver
end

function StoryNpcIconView:isLoadingRes()
	return self._isLoadingNpcIcon
end

function StoryNpcIconView:hideObject()
	if self._npcIconNode and self._npcIconNode.activeSelf then
		self._npcIconNode:SetActive(false)
	end
end

function StoryNpcIconView:_showNpcIcon()
	if not self._npcIconNode then
		return
	end

	if string.nilorempty(self._currStory.npcIcon) then
		self._npcIconNode:SetActive(false)

		self._isLoadingNpcIcon = nil

		return
	end

	self._npcIconNode:SetActive(true)

	if self._npcIconPath ~= self._currStory.npcIcon then
		self._npcIconPath = self._currStory.npcIcon

		if not string.find(self._npcIconPath, ".png") then
			self._npcIconPath = self._npcIconPath .. ".png"
		end

		self._isLoadingNpcIcon = true

		self._npcIconImg:ClearImage()
		uGuiUtil.setSpriteToImage(self._npcIconImg, uGuiUtil.SpriteType.BigBg, StoryConst.StoryPath_NpcIconImgBg .. self._npcIconPath, function(width, height)
			self:_onNpcIconLoadedFinish()
		end)
	elseif not self._isLoadingNpcIcon then
		self:_onNpcIconLoadedFinish()
	end
end

function StoryNpcIconView:_onNpcIconLoadedFinish()
	self._isLoadingNpcIcon = nil
end

return StoryNpcIconView
