-- chunkname: @modules/logic/versionactivity3_6/yami/controller/V3a6YaMiController.lua

module("modules.logic.versionactivity3_6.yami.controller.V3a6YaMiController", package.seeall)

local V3a6YaMiController = class("V3a6YaMiController", BaseController)

function V3a6YaMiController:onInit()
	return
end

function V3a6YaMiController:reInit()
	self:onExit()
end

function V3a6YaMiController:onInitFinish()
	return
end

function V3a6YaMiController:addConstEvents()
	return
end

function V3a6YaMiController:openMainView(isReturn)
	self._inGaming = true
	self._scene = self._scene or V3a6YaMiScene.New()

	self._scene:onEnterScene(isReturn)

	if isReturn then
		self:_reallyOpenMainView()
	else
		V3a6YaMiRpc.instance:sendGetAct231InfoRequest(self._reallyOpenMainView, self)
	end
end

function V3a6YaMiController:onExit()
	self._inGaming = false

	if self._scene then
		self._scene:onExitScene()

		self._scene = nil
	end
end

function V3a6YaMiController:getScene()
	return self._scene
end

function V3a6YaMiController:getFloatMgr()
	if not self._scene then
		return
	end

	return self._scene.floatMgr
end

function V3a6YaMiController:_reallyOpenMainView()
	ViewMgr.instance:openView(ViewName.V3a6YaMiMainView)
end

function V3a6YaMiController:openTaskView()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Act231
	}, function()
		ViewMgr.instance:openView(ViewName.V3a6YaMiTaskView)
	end)
end

function V3a6YaMiController:openProductHandbookView(param)
	ViewMgr.instance:openView(ViewName.V3a6YaMiProductHandbookView, param)
end

function V3a6YaMiController:openHeroHandbookView(param)
	ViewMgr.instance:openView(ViewName.V3a6YaMiHeroHandbookView, param)
end

function V3a6YaMiController:onEnterNextView()
	local status = V3a6YaMiModel.instance:getCurGameStatus()

	if status == V3a6YaMiEnum.GameStatus.Init then
		self:openProductView()

		return
	end

	if status == V3a6YaMiEnum.GameStatus.SelectedMaterial then
		self:openSelectHeroView()

		return
	end

	self:openConfirmSelectionView()
end

function V3a6YaMiController:openProductView(param)
	ViewMgr.instance:openView(ViewName.V3a6YaMiProductView, param)
end

function V3a6YaMiController:openSelectHeroView(param)
	ViewMgr.instance:openView(ViewName.V3a6YaMiSelectHeroView, param)
end

function V3a6YaMiController:openCutHeroView(param)
	ViewMgr.instance:openView(ViewName.V3a6YaMiCutHeroView, param)
end

function V3a6YaMiController:openSelectHeroHandbookView(param)
	ViewMgr.instance:openView(ViewName.V3a6YaMiSelectHeroHandbookView, param)
end

function V3a6YaMiController:openConfirmSelectionView(param)
	ViewMgr.instance:openView(ViewName.V3a6YaMiConfirmSelectionView, param)
end

function V3a6YaMiController:enterResearch()
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onEnterPerform)
	V3a6YaMiRpc.instance:sendAct231StartResearchRequest(self.openPerformView, self)
end

function V3a6YaMiController:onContinueResearch()
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onEnterPerform)

	local status = V3a6YaMiModel.instance:getResearchStatus()
	local isPause = status == V3a6YaMiEnum.ResearchStatus.Pause

	if isPause then
		V3a6YaMiRpc.instance:sendAct231ContinueResearchRequest(self.openPerformView, self)
	else
		self:openPerformView()
	end
end

function V3a6YaMiController:openPerformView()
	ViewMgr.instance:openView(ViewName.V3a6YaMiPerformView)
end

function V3a6YaMiController:openSkillView(param)
	ViewMgr.instance:openView(ViewName.V3a6YaMiSkillView, param)
end

function V3a6YaMiController:openV3a6YaMiEvaluationView(param)
	ViewMgr.instance:openView(ViewName.V3a6YaMiEvaluationView, param)
end

V3a6YaMiController.instance = V3a6YaMiController.New()

return V3a6YaMiController
