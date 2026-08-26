-- chunkname: @modules/logic/necrologiststory/view/control/NecrologistStoryControlMgrComp.lua

module("modules.logic.necrologiststory.view.control.NecrologistStoryControlMgrComp", package.seeall)

local NecrologistStoryControlMgrComp = class("NecrologistStoryControlMgrComp", LuaCompBase)

function NecrologistStoryControlMgrComp:ctor(storyView)
	self.storyView = storyView
end

function NecrologistStoryControlMgrComp:init(go)
	self.go = go
	self.controlList = {}
	self.type2Cls = {
		[NecrologistStoryEnum.StoryControlType.StoryPic] = NecrologistStoryControlStoryPic,
		[NecrologistStoryEnum.StoryControlType.Bgm] = NecrologistStoryControlBgm,
		[NecrologistStoryEnum.StoryControlType.Audio] = NecrologistStoryControlAudio,
		[NecrologistStoryEnum.StoryControlType.Effect] = NecrologistStoryControlWeather,
		[NecrologistStoryEnum.StoryControlType.StopAudio] = NecrologistStoryControlStopAudio,
		[NecrologistStoryEnum.StoryControlType.ChangeVolume] = NecrologistStoryControlChangeVolume
	}
	self.type2ClsItem = {
		[NecrologistStoryEnum.StoryControlType.ShowPic] = NecrologistStoryShowPictureItem,
		[NecrologistStoryEnum.StoryControlType.ClickPic] = NecrologistStoryClickPictureItem,
		[NecrologistStoryEnum.StoryControlType.DragPic] = NecrologistStoryDragPictureItem,
		[NecrologistStoryEnum.StoryControlType.ErasePic] = NecrologistStoryErasePictureItem,
		[NecrologistStoryEnum.StoryControlType.Magic] = NecrologistStoryMagicItem,
		[NecrologistStoryEnum.StoryControlType.SlidePic] = NecrologistStorySliderPictureItem
	}
end

function NecrologistStoryControlMgrComp:playControl(storyConfig, isSkip, fromItem)
	local storyId = storyConfig.id
	local control = storyConfig.addControl
	local isEmpty = string.nilorempty(control)

	if isEmpty then
		if not fromItem then
			self.storyView:runNextStep(isSkip)
		end

		return
	end

	local controlAttr = string.splitToNumber(control, "|")
	local controlParams = string.split(storyConfig.controlParam, "|")
	local controlDelays = string.splitToNumber(storyConfig.controlDelay, "|")

	for i, controlType in ipairs(controlAttr) do
		self:setControlParam(controlType, storyId, controlParams[i], controlDelays[i], isSkip, fromItem)
	end

	local list = self.controlList[storyId]

	if list then
		for _, item in ipairs(list) do
			item:playControl()
		end
	end
end

function NecrologistStoryControlMgrComp:setControlParam(controlType, storyId, controlParam, controlDelay, isSkip, fromItem)
	local itemCls = self.type2ClsItem[controlType]

	if not self.type2Cls[controlType] then
		local controlCls = NecrologistStoryControlMgrItem
		local mgrItem = controlCls.New(self, itemCls)

		self:addControl(storyId, mgrItem)
		mgrItem:setParam(controlParam, controlDelay, isSkip, fromItem)
	end
end

function NecrologistStoryControlMgrComp:addControl(storyId, mgrItem)
	local list = self.controlList[storyId]

	if not list then
		list = {}
		self.controlList[storyId] = list
	end

	mgrItem:setStoryId(storyId)
	table.insert(list, mgrItem)
end

function NecrologistStoryControlMgrComp:createControlItem(cls, storyId, controlParam, finishCallback, finishCallbackObj)
	self.storyView:createControlItemAsync(cls, storyId, controlParam, finishCallback, finishCallbackObj)
end

function NecrologistStoryControlMgrComp:onItemFinish(mgrItem)
	if mgrItem.fromItem then
		return
	end

	local isAllFinish = self:isControlFinish(mgrItem.storyId)

	if isAllFinish then
		self.storyView:runNextStep(mgrItem.isSkip)
	end
end

function NecrologistStoryControlMgrComp:isControlFinish(storyId)
	local list = self.controlList[storyId]

	if not list then
		return true
	end

	for _, control in ipairs(list) do
		if not control:isFinish() then
			return false
		end
	end

	return true
end

function NecrologistStoryControlMgrComp:clearControlList()
	for _, list in pairs(self.controlList) do
		for _, control in ipairs(list) do
			control:onDestory()
		end
	end
end

function NecrologistStoryControlMgrComp:onDestroy()
	self:clearControlList()
end

return NecrologistStoryControlMgrComp
