-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/story/StoryViewOption.lua

module("logic.extensions.story.view.story.StoryViewOption", package.seeall)

local StoryViewOption = class("StoryViewOption", StoryViewComponent)

function StoryViewOption:_buildUI()
	StoryViewOption.super._buildUI(self)

	self._layout = goutil.findChild(self.mainGO, "Layout")

	self.mainGO:SetActive(false)
end

function StoryViewOption:onEnter()
	StoryViewOption.super.onEnter(self)
	self.mainGO:SetActive(false)
end

function StoryViewOption:startStory(currStory)
	self._optionStory = currStory
	self._currStory = currStory
	self._hasHandled = nil

	self:_showOption()
end

function StoryViewOption:endStory()
	return
end

function StoryViewOption:onExit()
	StoryViewOption.super.onExit(self)
	self:_clearOptionListeners()

	self._optionStory = nil
	self._currStory = nil
	self._hasHandled = nil
end

function StoryViewOption:_clearOptionListeners()
	local nodeCnt = self._layout.transform.childCount

	for i = 1, nodeCnt do
		local go = self._layout.transform:GetChild(i - 1).gameObject
		local btn = Framework.ButtonAdapter.GetFrom(go, "Image")

		if btn then
			btn:RemoveClickListener()
		end
	end
end

function StoryViewOption:_showOption()
	self._layout.gameObject:SetActive(true)

	local options = self._optionStory.options
	local cnt = #options
	local nodeCnt = self._layout.transform.childCount

	while nodeCnt < cnt do
		local go = self._layout.transform:GetChild(0).gameObject
		local goClone = goutil.cloneAndSetParent(go, self._layout.transform)

		Framework.TransformUtil.SetLocalScale(goClone.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(goClone.transform, 0, 0, 0)

		nodeCnt = nodeCnt + 1
	end

	local num = 1

	for i = 1, cnt do
		local go = self._layout.transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		self:_fillOption(go, options[i])

		num = num + 1
	end

	for i = num, nodeCnt do
		local go = self._layout.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end
end

function StoryViewOption:_fillOption(go, option)
	local text = goutil.findChild(go, "Image/Text"):GetComponent("Text")
	local btn = Framework.ButtonAdapter.GetFrom(go, "Image")

	text.text = option.text

	btn:AddClickListener(function(self)
		self:_handleOption(option)
	end, self)
end

function StoryViewOption:_handleOption(option)
	if self._view:isLoadingRes() then
		return
	end

	if self._hasHandled then
		return
	end

	self._hasHandled = true

	self:finishStory(option.op, option.opParams)
end

return StoryViewOption
