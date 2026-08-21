-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionBranch.lua

module("logic.extensions.story.core.logic.sections.SectionBranch", package.seeall)

local M = class("SectionBranch", StorySectionBase)

function M.CreateSectionItemStruct()
	local st = {}

	st.nextGroupId = -1
	st.radioContext = ""
	st.isError = false
	st.attrUnLockType = 0
	st.attrUnlockValue = 0
	st.influence = 0

	return st
end

function M:_OnInitCtor()
	self.m_radioType = StoryConstDef.EStoryRadioType.None
	self.m_questionFlag = 0
	self.m_brachItems = nil
end

function M:ReleaseData()
	self.m_brachItems = nil
end

function M:OnSectionEnableInternal()
	self.m_brachItems = {}

	self:UpdateBranchItems(self.config)
	StoryDispatcher:dispatchEvent(StoryNotifyName.UIBranchEnter, self.m_radioType, self.m_questionFlag, self.m_brachItems)
end

function M:OnSectionDisableInternal()
	self:ReleaseData()
	StoryDispatcher:dispatchEvent(StoryNotifyName.UIBranchExit)
end

function M:UpdateBranchItems(node)
	self.m_radioType = node:GetArgValueEnum(StoryArgKeyConst.RadioType)
	self.m_questionFlag = node:GetArgValueUInt(StoryArgKeyConst.RadionQuestionFlag)

	local shot = self.parent.parent
	local graphAsset = self.storyBlackBoard:GraphAsset()

	for _, item in ipairs(shot.shotEdges) do
		local element = M.CreateSectionItemStruct()

		element.nextGroupId = item.targetNodeGuid
		element.isError = false
		element.radioContext = item:GetArgValue(StoryArgKeyConst.DialogRadioContent)
		element.attrUnLockType = item:GetArgValueEnum(StoryArgKeyConst.DialogRadioLockType)
		element.attrUnlockValue = item:GetArgValueUInt(StoryArgKeyConst.DialogRadioLockValue)
		element.influence = item:GetArgValueEnum(StoryArgKeyConst.DialogRadioInfluence)

		local targetContainer = graphAsset:FindContainerByGUID(item.targetNodeGuid)

		if not targetContainer then
			element.radioContext = element.radioContext .. "-Err【找不到分支ID】" .. item.targetNodeGuid
		end

		table.insert(self.m_brachItems, element)
	end
end

return M
