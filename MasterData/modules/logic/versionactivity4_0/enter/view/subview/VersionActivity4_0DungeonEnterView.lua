-- chunkname: @modules/logic/versionactivity4_0/enter/view/subview/VersionActivity4_0DungeonEnterView.lua

module("modules.logic.versionactivity4_0.enter.view.subview.VersionActivity4_0DungeonEnterView", package.seeall)

local VersionActivity4_0DungeonEnterView = class("VersionActivity4_0DungeonEnterView", VersionActivityMainFixedDungeonEnterView)

function VersionActivity4_0DungeonEnterView:addEvents()
	VersionActivity4_0DungeonEnterView.super.addEvents(self)
	CollegeController.instance:registerCallback(CollegeEvent.UpdateMilestoneInfo, self.refreshPaperCount, self)
	CollegeController.instance:registerCallback(CollegeEvent.FirstSaveClientData, self.refreshPaperCount, self)
end

function VersionActivity4_0DungeonEnterView:removeEvents()
	VersionActivity4_0DungeonEnterView.super.removeEvents(self)
	CollegeController.instance:unregisterCallback(CollegeEvent.UpdateMilestoneInfo, self.refreshPaperCount, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.FirstSaveClientData, self.refreshPaperCount, self)
end

function VersionActivity4_0DungeonEnterView:_editableInitView()
	VersionActivity4_0DungeonEnterView.super._editableInitView(self)
	RedDotController.instance:addRedDot(self._goboardreddot, RedDotEnum.DotNode.CollegeMain)
end

function VersionActivity4_0DungeonEnterView:_updateBg()
	return
end

function VersionActivity4_0DungeonEnterView:_btnboardOnClick()
	CollegeController.instance:enterCollegeCity()
end

function VersionActivity4_0DungeonEnterView:refreshPaperCount()
	local sceneMo = CollegeModel.instance:getSceneMo()

	if not sceneMo then
		logError("版本页开的时候，指挥部没数据？？？")

		return
	end

	local list = lua_college_reward.configList

	self._txtpapernum.text = string.format("%d/%d", (not sceneMo.prop.clientDataMo:isEntered() or nil) and 0, list[#list].score)
end

return VersionActivity4_0DungeonEnterView
