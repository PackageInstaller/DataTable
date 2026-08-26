-- chunkname: @modules/logic/sp01/odyssey/controller/OdysseyController.lua

module("modules.logic.sp01.odyssey.controller.OdysseyController", package.seeall)

local OdysseyController = class("OdysseyController", BaseController)

function OdysseyController:onInit()
	return
end

function OdysseyController:reInit()
	return
end

function OdysseyController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self.onDailyRefresh, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self.onUpdateTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self.onSetTaskList, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, self.setAddOuterItemData, self)
end

function OdysseyController:onDailyRefresh()
	local isActOpen = ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.Dungeon2)

	if not isActOpen then
		return
	end

	OdysseyRpc.instance:sendOdysseyGetInfoRequest(function()
		OdysseyController.instance:dispatchEvent(OdysseyEvent.DailyRefresh)
	end, self)
end

function OdysseyController:onUpdateTaskList(msg)
	local isChange = OdysseyTaskModel.instance:updateTaskInfo(msg.taskInfo)

	if isChange then
		OdysseyTaskModel.instance:refreshList()
	end

	self:checkTaskReddotShow()
	self:dispatchEvent(OdysseyEvent.OdysseyTaskUpdated)
end

function OdysseyController:onSetTaskList()
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.OdysseyLevelReward,
		RedDotEnum.DotNode.OdysseyTask
	})
	OdysseyTaskModel.instance:setTaskInfoList()
	OdysseyTaskModel.instance:refreshList()
	self:checkTaskReddotShow()
	self:dispatchEvent(OdysseyEvent.OdysseyTaskUpdated)
end

function OdysseyController:checkTaskReddotShow()
	local hasLevelReawrdTaskCanGet = OdysseyTaskModel.instance:checkHasLevelReawrdTaskCanGet() and 1 or 0
	local hasNormalTaskCanGet = OdysseyTaskModel.instance:checkHasNormalTaskCanGet() and 1 or 0
	local redDotInfoList = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.OdysseyLevelReward,
			value = hasLevelReawrdTaskCanGet
		},
		{
			uid = 0,
			id = RedDotEnum.DotNode.OdysseyTask,
			value = hasNormalTaskCanGet
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(redDotInfoList, true)
end

function OdysseyController:showItemTipView(viewParam)
	ViewMgr.instance:openView(ViewName.OdysseyItemTipView, viewParam)
end

function OdysseyController:openTalentTreeView(viewParam)
	ViewMgr.instance:openView(ViewName.OdysseyTalentTreeView, viewParam)
end

function OdysseyController:openLibraryView(libraryType)
	AssassinController.instance:openAssassinLibraryView(VersionActivity2_9Enum.ActivityId.Dungeon2, libraryType or AssassinEnum.LibraryType.Hero)
end

function OdysseyController:openTaskView()
	OdysseyTaskModel.instance:setCurSelectTaskTypeAndGroupId(OdysseyEnum.TaskType.NormalTask, OdysseyEnum.TaskGroupType.Story)
	OdysseyTaskModel.instance:refreshList()
	ViewMgr.instance:openView(ViewName.OdysseyTaskView)
end

function OdysseyController:openHeroGroupView(viewParam)
	HeroGroupModel.instance:setReplayParam(nil)
	HeroSingleGroupModel.instance:setMaxHeroCount(OdysseyEnum.MaxHeroGroupCount)
	HeroGroupModel.instance:setParam(nil, nil, nil, nil, DungeonEnum.EpisodeType.Odyssey)

	if viewParam == nil then
		viewParam = {}
	end

	viewParam.heroGroupType = OdysseyEnum.HeroGroupType.Prepare

	ViewMgr.instance:openView(ViewName.OdysseyHeroGroupView, viewParam)
end

function OdysseyController:openEquipView(viewParam)
	ViewMgr.instance:openView(ViewName.OdysseyEquipView, viewParam)
end

function OdysseyController:openFightSuccView()
	local mo = OdysseyModel.instance:getFightResultInfo()

	if mo and mo:checkFightTypeIsMyth() then
		ViewMgr.instance:openView(ViewName.OdysseyMythSuccessView)
	else
		ViewMgr.instance:openView(ViewName.OdysseySuccessView)
	end
end

function OdysseyController:openBagView(viewParam)
	ViewMgr.instance:openView(ViewName.OdysseyBagView, viewParam)
end

function OdysseyController:openSuitTipsView(viewParam)
	ViewMgr.instance:openView(ViewName.OdysseySuitTipView, viewParam)
end

function OdysseyController:setAddOuterItemData(msg)
	OdysseyDungeonModel.instance:setCurFightEpisodeId(nil)
	OdysseyItemModel.instance:setAddOuterItem(msg.firstBonus or {})
end

OdysseyController.instance = OdysseyController.New()

return OdysseyController
