-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryLocationItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryLocationItem", package.seeall)

local NecrologistStoryLocationItem = class("NecrologistStoryLocationItem", NecrologistStoryBaseItem)

function NecrologistStoryLocationItem:onInit()
	self.txtContent = gohelper.findChildTextMesh(self.viewGO, "content/txtContent")
end

function NecrologistStoryLocationItem:onPlayStory(isSkip)
	local storyConfig = self:getStoryConfig()
	local desc, hasLink = NecrologistStoryHelper.getDescByConfig(storyConfig)
	local mo = NecrologistStoryModel.instance:getCurStoryMO()

	mo:setPlace(desc)

	self.txtContent.raycastTarget = hasLink
	self.txtContent.text = desc

	self:onTextFinish()

	if not isSkip then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_poltsfx_landmark)
	end
end

function NecrologistStoryLocationItem:onTextFinish()
	self:onPlayFinish()
end

function NecrologistStoryLocationItem:isDone()
	return true
end

function NecrologistStoryLocationItem:justDone()
	return
end

function NecrologistStoryLocationItem:caleHeight()
	return 60
end

function NecrologistStoryLocationItem:getTextStr()
	return self.txtContent.text
end

function NecrologistStoryLocationItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/necrologiststorylocationitem.prefab"
end

return NecrologistStoryLocationItem
