-- chunkname: @modules/logic/versionactivity3_1/dungeon/view/map/VersionActivity3_1DungeonMapChapterLayout.lua

module("modules.logic.versionactivity3_1.dungeon.view.map.VersionActivity3_1DungeonMapChapterLayout", package.seeall)

local VersionActivity3_1DungeonMapChapterLayout = class("VersionActivity3_1DungeonMapChapterLayout", VersionActivityFixedDungeonMapChapterLayout)
local RIGHT_OFFSET_X = 600
local CONST_DUNGEON_NORMAL_DELTA_X = 100

function VersionActivity3_1DungeonMapChapterLayout:_editableInitView()
	self._focusIndex = 0
	self._episodeItemDict = self:getUserDataTb_()
	self._episodeContainerItemList = self:getUserDataTb_()
	self.episodeItemPath = self.viewContainer:getSetting().otherRes[1]

	local vec = Vector2(0, 1)

	self.rectTransform.pivot = vec
	self.rectTransform.anchorMin = vec
	self.rectTransform.anchorMax = vec
	self.defaultY = self.activityDungeonMo:getLayoutOffsetY()

	recthelper.setAnchorY(self.rectTransform, self.defaultY)

	self._rawWidth = recthelper.getWidth(self.rectTransform)
	self._rawHeight = 500

	recthelper.setSize(self.contentTransform, self._rawWidth, self._rawHeight)
	recthelper.setAnchorY(self.contentTransform, 300)

	local uiRootTran = ViewMgr.instance:getUIRoot().transform
	local width = recthelper.getWidth(uiRootTran)

	self._offsetX = (width - RIGHT_OFFSET_X) / 2 + RIGHT_OFFSET_X
	self._constDungeonNormalPosX = width - self._offsetX
	self._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	self._constDungeonNormalDeltaX = CONST_DUNGEON_NORMAL_DELTA_X
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	if ViewMgr.instance:isOpening(VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion)) then
		self._timelineAnimation:Play("timeline_mask")
	end
end

return VersionActivity3_1DungeonMapChapterLayout
