-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130LevelScene.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130LevelScene", package.seeall)

local Activity130LevelScene = class("Activity130LevelScene", BaseView)

function Activity130LevelScene:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity130LevelScene:addEvents()
	return
end

function Activity130LevelScene:removeEvents()
	return
end

function Activity130LevelScene:onUpdateParam()
	return
end

function Activity130LevelScene:_editableInitView()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("ActivityRole37Map")

	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function Activity130LevelScene:onOpen()
	self:_addEvents()

	self._sceneGos = self:getUserDataTb_()

	MainCameraMgr.instance:addView(ViewName.Activity130LevelView, self._initCamera, nil, self)

	local path = self.viewContainer:getSetting().otherRes[3]
	local scene1Go = self:getResInst(path, self._sceneRoot)

	table.insert(self._sceneGos, scene1Go)
	gohelper.setActive(scene1Go, false)

	local path = self.viewContainer:getSetting().otherRes[4]
	local scene2Go = self:getResInst(path, self._sceneRoot)

	table.insert(self._sceneGos, scene2Go)
	gohelper.setActive(scene2Go, false)

	local episodeId = Activity130Model.instance:getMaxUnlockEpisode()

	if self.viewParam and self.viewParam.episodeId then
		episodeId = self.viewParam.episodeId
	end

	Activity130Model.instance:setCurEpisodeId(episodeId)

	local actId = VersionActivity1_4Enum.ActivityId.Role37

	if episodeId < 1 then
		if not Activity130Enum.lvSceneType.Light then
			local sceneType = Activity130Config.instance:getActivity130EpisodeCo(actId, episodeId).lvscene

			gohelper.setActive(self._sceneGos[sceneType], true)
			transformhelper.setLocalPos(self._sceneGos[sceneType].transform, 0, 0, 0)

			self._scene1Animator = self._sceneGos[1]:GetComponent(typeof(UnityEngine.Animator))

			self._scene1Animator:Play("open", 0, 0)

			self._scene2Animator = self._sceneGos[2]:GetComponent(typeof(UnityEngine.Animator))

			self._scene2Animator:Play("open", 0, 0)
		end
	end
end

function Activity130LevelScene:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale(true)

	camera.orthographic = true
	camera.orthographicSize = 7.4 * scale
end

function Activity130LevelScene:onClose()
	self:_removeEvents()
end

function Activity130LevelScene:_onSetSceneActive(isActive)
	if self._sceneRoot then
		local actId = VersionActivity1_4Enum.ActivityId.Role37
		local curEpisodeId = Activity130Model.instance:getCurEpisodeId()
		local sceneType = Activity130Config.instance:getActivity130EpisodeCo(actId, curEpisodeId).lvscene

		gohelper.setActive(self._sceneGos[2], sceneType == Activity130Enum.lvSceneType.Moon)
		gohelper.setActive(self._sceneRoot, isActive)
	end
end

function Activity130LevelScene:_onSetScenePos(posX)
	for _, sceneGo in pairs(self._sceneGos) do
		transformhelper.setPosXY(sceneGo.transform, posX, 0)
	end
end

function Activity130LevelScene:_onBackToLevelView()
	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local curEpisodeId = Activity130Model.instance:getCurEpisodeId()

	if curEpisodeId == 0 then
		return
	end

	local sceneType = Activity130Config.instance:getActivity130EpisodeCo(actId, curEpisodeId).lvscene

	gohelper.setActive(self._sceneGos[2], sceneType == Activity130Enum.lvSceneType.Moon)

	if self._sceneRoot then
		gohelper.setActive(self._sceneRoot, true)
		self._scene1Animator:Play("open", 0, 0)
		self._scene2Animator:Play("open", 0, 0)
	end
end

function Activity130LevelScene:changeLvScene(sceneType)
	gohelper.setActive(self._sceneGos[sceneType], true)

	local animator = self._sceneGos[2]:GetComponent(typeof(UnityEngine.Animator))

	if sceneType == Activity130Enum.lvSceneType.Light then
		animator:Play("tosun", 0, 0)
	else
		animator:Play("tohaunghun", 0, 0)
	end
end

function Activity130LevelScene:_addEvents()
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.ShowLevelScene, self._onSetSceneActive, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.BackToLevelView, self._onBackToLevelView, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.SetScenePos, self._onSetScenePos, self)
end

function Activity130LevelScene:_removeEvents()
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.ShowLevelScene, self._onSetSceneActive, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.BackToLevelView, self._onBackToLevelView, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.SetScenePos, self._onSetScenePos, self)
end

function Activity130LevelScene:onDestroyView()
	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

return Activity130LevelScene
