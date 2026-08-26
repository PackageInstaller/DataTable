-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/ArcadeController.lua

module("modules.logic.versionactivity3_3.arcade.controller.ArcadeController", package.seeall)

local ArcadeController = class("ArcadeController", BaseController)

function ArcadeController:onInit()
	self.actId = ArcadeModel.instance:getAct222Id()

	self:reInit()
end

function ArcadeController:onInitFinish()
	return
end

function ArcadeController:addConstEvents()
	return
end

function ArcadeController:reInit()
	self._inInteractiveId = nil
end

function ArcadeController:openHallView()
	if not ArcadeModel.instance:isAct222Open(true) then
		return
	end

	self._inInteractiveId = nil

	ArcadeOutSideRpc.instance:sendArcadeGetOutSideInfoRequest(self._reallyOpenHallView, self)
end

function ArcadeController:_reallyOpenHallView()
	ViewMgr.instance:openView(ViewName.ArcadeHallView)
end

function ArcadeController:openQuitTipView(isInSide)
	local param = {
		isInSide = isInSide
	}

	ViewMgr.instance:openView(ViewName.ArcadeQuitTipView, param)
end

function ArcadeController:openTipView(type, param)
	param = param or {}
	param.tipType = type

	ViewMgr.instance:openView(ViewName.ArcadeTipsView, param)
end

function ArcadeController:closeTipView()
	if ViewMgr.instance:isOpen(ViewName.ArcadeTipsView) then
		ViewMgr.instance:closeView(ViewName.ArcadeTipsView)
	end
end

function ArcadeController:openArcadeHandBookView(type, id)
	local param = {
		type = type,
		id = id
	}

	ArcadeHandBookModel.instance:openView(type, id)
	ViewMgr.instance:openView(ViewName.ArcadeHandBookView, param)
end

function ArcadeController:openDevelopView(defaultTabId)
	local param = {
		defaultTabId = defaultTabId or 1
	}

	ViewMgr.instance:openView(ViewName.ArcadeDevelopView, param)
end

function ArcadeController:openTaskView()
	ViewMgr.instance:openView(ViewName.ArcadeRewardView)
end

function ArcadeController:openLevel1View()
	self:_enterLevelView(1)
end

function ArcadeController:openLevel2View()
	self:_enterLevelView(2)
end

function ArcadeController:openLevel3View()
	self:_enterLevelView(3)
end

function ArcadeController:talkNPC()
	self:dispatchEvent(ArcadeEvent.NPCTalk, self._inInteractiveId)
end

function ArcadeController:_enterLevelView(level)
	if not ArcadeOutSizeModel.instance:isUnlockLevel(level) then
		local toast = ArcadeHallEnum.ArcadLevelLockToast[level]

		if toast then
			GameFacade.showToast(toast)
		end

		return
	end

	self:dispatchEvent(ArcadeEvent.OnBeginTransitionGame, level)
	self:closeTipView()
end

function ArcadeController:onExitHall(isImmediate)
	for _, param in pairs(ArcadeHallEnum.HallInteractiveParams) do
		local viewName = param.ViewName

		if ViewMgr.instance:isOpen(viewName) then
			ViewMgr.instance:closeView(viewName)
		end
	end

	self:dispatchEvent(ArcadeEvent.OnExitHallView, isImmediate)
end

function ArcadeController:getEnterInteractiveId()
	return self._inInteractiveId
end

function ArcadeController:enterInteractive(interactiveId)
	self._inInteractiveId = interactiveId

	local param = ArcadeHallEnum.HallInteractiveParams[interactiveId]

	if param and param.OpenFunc then
		param.OpenFunc(self)
	end
end

function ArcadeController:exitInteractive()
	if self._inInteractiveId then
		local param = ArcadeHallEnum.HallInteractiveParams[self._inInteractiveId]

		if param then
			local viewName = param.ViewName

			if ViewMgr.instance:isOpen(viewName) then
				ViewMgr.instance:closeView(viewName)
			end
		end
	end

	self._inInteractiveId = nil
end

ArcadeController.instance = ArcadeController.New()

return ArcadeController
