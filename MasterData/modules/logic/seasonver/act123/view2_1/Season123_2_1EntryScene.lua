-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1EntryScene.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1EntryScene", package.seeall)

local Season123_2_1EntryScene = class("Season123_2_1EntryScene", BaseView)

function Season123_2_1EntryScene:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_1EntryScene:addEvents()
	return
end

function Season123_2_1EntryScene:removeEvents()
	return
end

function Season123_2_1EntryScene:_editableInitView()
	self._cameraHelper = Season123_2_1EntryCamera.New()

	self._cameraHelper:init()

	self._loadHelper = Season123_2_1EntryLoadScene.New()

	self._loadHelper:init()

	self._sceneRoot = self._loadHelper:createSceneRoot()
	self._sceneRootTrs = self._sceneRoot.transform

	self._loadHelper:loadRes(self.onSceneResLoaded, self)
end

function Season123_2_1EntryScene:onDestroyView()
	if self._loadHelper then
		self._loadHelper:disposeSceneRoot()
		self._loadHelper:dispose()

		self._sceneRoot = nil
		self._loadHelper = nil
	end

	if self._cameraHelper then
		self._cameraHelper:dispose()

		self._cameraHelper = nil
	end

	if self._dragHelper then
		self._dragHelper:dispose()

		self._dragHelper = nil
	end
end

function Season123_2_1EntryScene:onOpen()
	self.addEventCb(self, Season123Controller.instance, Season123Event.LocateToStage, self.handleLocateToStage, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.SetRetailScene, self.handleSetRetailScene, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.SwitchRetailPrefab, self.handleSwitchRetailScene, self)
	self.addEventCb(self, Season123EntryController.instance, Season123Event.EntrySceneFocusPos, self.handleFocusPos, self)
	self.addEventCb(self, Season123EntryController.instance, Season123Event.ReleaseFocusPos, self.handleReleaseFocusPos, self)
	self.addEventCb(self, Season123EntryController.instance, Season123Event.RetailObjLoaded, self.handleRetailObjLoaded, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.EnterEpiosdeList, self.enterEpiosdeList, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.EnterRetailView, self.playCloseAnim, self)
	self:refreshStage(true)
end

function Season123_2_1EntryScene:onClose()
	return
end

function Season123_2_1EntryScene:onSceneResLoaded(sceneGo)
	self._sceneBgGo = sceneGo
	self._sceneAnim = self._sceneBgGo:GetComponent(typeof(UnityEngine.Animator))

	transformhelper.setLocalPos(self._sceneBgGo.transform, SeasonEntryEnum.DefaultScenePosX, SeasonEntryEnum.DefaultScenePosY, SeasonEntryEnum.DefaultScenePosZ)
	Season123EntryController.instance:dispatchEvent(Season123Event.EntrySceneLoaded)

	self._dragHelper = Season123_2_1EntryDrag.New()

	self._dragHelper:init(self._gofullscreen, self._sceneBgGo.transform)
	self._dragHelper:initBound()
	self._dragHelper:setDragEnabled(false)
	self:refreshRetailStatus()
end

function Season123_2_1EntryScene:handleLocateToStage(param)
	if not self._sceneBgGo then
		return
	end

	local actId = param.actId
	local stageId = param.stageId
	local stageCO = Season123Config.instance:getStageCo(actId, stageId)

	if stageCO then
		Season123EntryController.instance:goToStage(stageId)
		self:refreshStage()
	end
end

function Season123_2_1EntryScene:refreshStage(isOpen)
	if not self._loadHelper then
		return
	end

	local stage = Season123EntryModel.instance:getCurrentStage()

	if not stage then
		return
	end

	self._loadHelper:showStageRes(stage, isOpen)
end

function Season123_2_1EntryScene:refreshRetail(retailId)
	if not self._loadHelper or not self._sceneBgGo or not self._retailId then
		return
	end

	self._loadHelper:showRetailRes(self._retailSceneId)
end

function Season123_2_1EntryScene:refreshRetailStatus()
	if not self._loadHelper or not self._sceneBgGo then
		return
	end

	gohelper.setActive(self._sceneBgGo, self._isRetailVisible)

	if self._isRetailVisible then
		self._loadHelper:hideAllStage()
		self:refreshRetail()
	else
		self._loadHelper:hideAllRetail()
		self:refreshStage()
	end
end

function Season123_2_1EntryScene:handleFocusPos(posX, posY)
	if not self._sceneBgGo then
		return
	end

	logNormal("focus to pos " .. tostring(posX) .. "," .. tostring(posY))

	local pos = self._dragHelper:getTempPos()

	pos.x, pos.y = posX, posY

	self._dragHelper:setDragEnabled(false)
	self._dragHelper:setScenePosTween(pos, SeasonEntryEnum.FocusTweenTime)
end

function Season123_2_1EntryScene:handleReleaseFocusPos()
	self._cameraHelper:tweenToScale(1, SeasonEntryEnum.FocusTweenTime)
end

function Season123_2_1EntryScene:handleSetRetailScene(isVisible)
	self._isRetailVisible = isVisible

	self:refreshRetailStatus()
end

function Season123_2_1EntryScene:handleSwitchRetailScene(retailId)
	self._retailId = retailId
	self._retailSceneId = Season123Model.instance.retailSceneId
	self._retailFocusId = nil

	self:refreshRetail()
	self:tryFocusOnRetailObj()
end

function Season123_2_1EntryScene:handleRetailObjLoaded(loadIndex)
	if self._retailId and self._retailFocusId == nil then
		local index, _ = Season123EntryModel.getRandomRetailRes(self._retailSceneId)

		if index == loadIndex then
			self:tryFocusOnRetailObj()
		end
	end
end

function Season123_2_1EntryScene:tryFocusOnRetailObj()
	if self._retailId and self._retailFocusId == nil then
		local index, _ = Season123EntryModel.getRandomRetailRes(self._retailSceneId)
		local posX, posY = self._loadHelper:getRetailPosByIndex(index)

		if posX and posY then
			self._retailFocusId = self._retailId

			self:handleFocusPos(posX, posY)
		end
	end
end

function Season123_2_1EntryScene:enterEpiosdeList(isEnter)
	local stage = Season123EntryModel.instance:getCurrentStage()

	if not stage then
		return
	end

	self._loadHelper:tweenStage(stage, isEnter)

	if not isEnter then
		self._loadHelper:playAnim(stage, Activity123Enum.StageSceneAnim.Idle)
	end
end

function Season123_2_1EntryScene:playCloseAnim()
	local stage = Season123EntryModel.instance:getCurrentStage()

	self._loadHelper:playAnim(stage, Activity123Enum.StageSceneAnim.Close)
end

return Season123_2_1EntryScene
