-- chunkname: @modules/logic/dungeon/controller/RoleStoryController.lua

module("modules.logic.dungeon.controller.RoleStoryController", package.seeall)

local RoleStoryController = class("RoleStoryController", BaseController)

function RoleStoryController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self._onFuncOpen, self)
end

function RoleStoryController:onInit()
	return
end

function RoleStoryController:onInitFinish()
	return
end

function RoleStoryController:_onFuncOpen(newIds)
	if tabletool.indexOf(newIds, OpenEnum.UnlockFunc.RoleStory) then
		HeroStoryRpc.instance:sendGetHeroStoryRequest()
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.NecrologistStory
		})
	end
end

function RoleStoryController:_onGetInfoFinish()
	NecrologistStoryRpc.instance:sendGetNecrologistStoryRequest()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.RoleStory) then
		HeroStoryRpc.instance:sendGetHeroStoryRequest()
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.NecrologistStory
		})
	end
end

function RoleStoryController:openRoleStoryDispatchMainView(param)
	if not RoleStoryModel.instance:checkActStoryOpen() then
		if ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchMainView) then
			ViewMgr.instance:closeView(ViewName.RoleStoryDispatchMainView)
		end

		GameFacade.showToast(ToastEnum.BattlePass)

		return false
	end

	HeroStoryRpc.instance:sendGetHeroStoryRequest(function()
		ViewMgr.instance:openView(ViewName.RoleStoryDispatchMainView, param)
	end)

	return true
end

function RoleStoryController:openRoleStoryActivityMainView(param)
	if not RoleStoryModel.instance:checkActStoryOpen() then
		if ViewMgr.instance:isOpen(ViewName.RoleStoryActivityMainView) then
			ViewMgr.instance:closeView(ViewName.RoleStoryActivityMainView)
		end

		GameFacade.showToast(ToastEnum.BattlePass)

		return false
	end

	HeroStoryRpc.instance:sendGetHeroStoryRequest(function()
		ViewMgr.instance:openView(ViewName.RoleStoryActivityMainView, param)
	end)

	return true
end

function RoleStoryController:enterRoleStoryChapter(storyId)
	if not storyId or storyId == 0 then
		return
	end

	RoleStoryModel.instance:setCurStoryId(storyId)

	local cfg = RoleStoryConfig.instance:getStoryById(storyId)
	local param = {}

	param.chapterId = cfg.chapterId

	DungeonController.instance:openDungeonChapterView(param)
end

function RoleStoryController:openDispatchView(storyId)
	if not storyId or storyId == 0 then
		return
	end

	local param = {}

	param.storyId = storyId

	ViewMgr.instance:openView(ViewName.RoleStoryDispatchView, param)
end

function RoleStoryController:openReviewView()
	local storyId = RoleStoryModel.instance:getCurStoryId()

	if not storyId or storyId == 0 then
		return
	end

	local param = {}

	param.storyId = storyId

	ViewMgr.instance:openView(ViewName.RoleStoryReviewView, param)
end

RoleStoryController.instance = RoleStoryController.New()

return RoleStoryController
