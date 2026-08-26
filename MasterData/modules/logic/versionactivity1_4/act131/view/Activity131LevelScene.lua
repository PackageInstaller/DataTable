-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131LevelScene.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131LevelScene", package.seeall)

local Activity131LevelScene = class("Activity131LevelScene", BaseView)

function Activity131LevelScene:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity131LevelScene:addEvents()
	return
end

function Activity131LevelScene:removeEvents()
	return
end

function Activity131LevelScene:onUpdateParam()
	return
end

function Activity131LevelScene:_editableInitView()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("ActivityRole6Map")

	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function Activity131LevelScene:onOpen()
	self:_addEvents()
	MainCameraMgr.instance:addView(ViewName.Activity131LevelView, self._initCamera, nil, self)

	local path = self.viewContainer:getSetting().otherRes[2]

	self._sceneGo = self:getResInst(path, self._sceneRoot)

	local episodeId = Activity131Model.instance:getMaxUnlockEpisode()

	Activity131Model.instance:setCurEpisodeId((self.viewParam and self.viewParam.episodeId or nil) and self.viewParam.episodeId)
	gohelper.setActive(self._sceneGo, true)
	transformhelper.setLocalPos(self._sceneGo.transform, 0, 0, 0)

	self._sceneAnimator = self._sceneGo:GetComponent(typeof(UnityEngine.Animator))

	self._sceneAnimator:Play("open", 0, 0)

	if self.viewParam and self.viewParam.exitFromBattle then
		self:_onSetSceneActive(false)
	end
end

function Activity131LevelScene:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale(true)

	camera.orthographic = true
	camera.orthographicSize = 7.4 * scale
end

function Activity131LevelScene:onClose()
	self:_removeEvents()
end

function Activity131LevelScene:_onSetSceneActive(isActive)
	if self._sceneRoot then
		gohelper.setActive(self._sceneRoot, isActive)
	end
end

function Activity131LevelScene:_onSetScenePos(posX)
	transformhelper.setPosXY(self._sceneRoot.transform, posX, 0)
end

function Activity131LevelScene:_onBackToLevelView()
	if self._sceneRoot then
		gohelper.setActive(self._sceneRoot, true)
		self._sceneAnimator:Play("open", 0, 0)
	end
end

function Activity131LevelScene:_addEvents()
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.ShowLevelScene, self._onSetSceneActive, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.BackToLevelView, self._onBackToLevelView, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.SetScenePos, self._onSetScenePos, self)
end

function Activity131LevelScene:_removeEvents()
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.ShowLevelScene, self._onSetSceneActive, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.BackToLevelView, self._onBackToLevelView, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.SetScenePos, self._onSetScenePos, self)
end

function Activity131LevelScene:onDestroyView()
	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

return Activity131LevelScene
