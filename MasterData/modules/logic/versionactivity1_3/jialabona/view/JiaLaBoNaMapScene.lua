-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaMapScene.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapScene", package.seeall)

local JiaLaBoNaMapScene = class("JiaLaBoNaMapScene", BaseView)

function JiaLaBoNaMapScene:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function JiaLaBoNaMapScene:addEvents()
	return
end

function JiaLaBoNaMapScene:removeEvents()
	return
end

function JiaLaBoNaMapScene:onUpdateParam()
	return
end

function JiaLaBoNaMapScene:onOpen()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.onScreenResize, self)
	self.addEventCb(self, JiaLaBoNaController.instance, JiaLaBoNaEvent.MapSceneActvie, self._onMapSceneActivie, self)
end

function JiaLaBoNaMapScene:setSceneActive(isActive)
	if self._sceneRoot then
		gohelper.setActive(self._sceneRoot, isActive)
	end
end

function JiaLaBoNaMapScene:onClose()
	self:resetCamera()
end

function JiaLaBoNaMapScene:_onMapSceneActivie(isActive)
	self:setSceneActive(isActive)
end

function JiaLaBoNaMapScene:onScreenResize()
	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale(true)

	camera.orthographic = true
	camera.orthographicSize = 7.5 * scale
end

function JiaLaBoNaMapScene:resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = 5
	camera.orthographic = false
end

function JiaLaBoNaMapScene:switchPage(chapterId)
	if not JiaLaBoNaEnum.MapSceneRes[chapterId] then
		return
	end

	if self._chapterSceneUdtbDict then
		self._curChaperId = chapterId

		self:_createChapterScene(chapterId)

		for _, tb in pairs(self._chapterSceneUdtbDict) do
			gohelper.setActive(tb.go, tb.chapterId == chapterId)
		end

		self:refreshInteract()
	end
end

function JiaLaBoNaMapScene:playSceneAnim(animName)
	if not string.nilorempty(animName) then
		local tb = self._chapterSceneUdtbDict[self._curChaperId]

		if tb and tb.animator then
			tb.animator:Play(animName)
		end
	end
end

function JiaLaBoNaMapScene:_createChapterScene(chapterId)
	if self._chapterSceneUdtbDict and not self._chapterSceneUdtbDict[chapterId] then
		local go = self:getResInst(JiaLaBoNaEnum.MapSceneRes[chapterId], self._sceneRoot)

		transformhelper.setLocalPos(go.transform, 0, 0, 0)

		local tb = self:getUserDataTb_()

		tb.go = go
		tb.chapterId = chapterId
		tb.animator = go:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
		self._chapterSceneUdtbDict[chapterId] = tb

		self:_findInactGo(go, chapterId)
	end
end

function JiaLaBoNaMapScene:_findInactGo(sceneGO, chapterId)
	local actId = VersionActivity1_3Enum.ActivityId.Act306
	local episodeCfgList = Activity120Config.instance:getEpisodeList(actId)

	for _, episodeCfg in ipairs(episodeCfgList) do
		if episodeCfg.chapterId == chapterId and not string.nilorempty(episodeCfg.inactPaths) then
			local pathList = string.split(episodeCfg.inactPaths, "|") or {}
			local tbList = self:getUserDataTb_()

			self._chapterInactsTbDict[episodeCfg.id] = tbList

			for index, path in ipairs(pathList) do
				local isNilPath = string.nilorempty(path)
				local tempGO = not isNilPath and gohelper.findChild(sceneGO, path)

				if not gohelper.isNil(tempGO) then
					local tbGo = self:getUserDataTb_()

					tbGo.go = tempGO
					tbGo.animator = tempGO:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)

					table.insert(tbList, tbGo)
				elseif not isNilPath then
					logError(string.format("export_尘埃与星的边界活动关卡 activityId：%s id:% inactPaths:%s下标错误", actId, episodeCfg.id, index))
				end
			end
		end
	end
end

function JiaLaBoNaMapScene:refreshInteract(animEpisodeId)
	local actId = VersionActivity1_3Enum.ActivityId.Act306
	local episodeCfgList = Activity120Config.instance:getEpisodeList(actId)

	for _, episodeCfg in ipairs(episodeCfgList) do
		self:_refreshInteractById(episodeCfg.id, episodeCfg.id == animEpisodeId)
	end
end

function JiaLaBoNaMapScene:_refreshInteractById(episodeId, isPlayAnim)
	local goInacts = self._chapterInactsTbDict[episodeId]

	if goInacts and #goInacts > 0 then
		local isClear = Activity120Model.instance:isEpisodeClear(episodeId)

		for index, tbGo in ipairs(goInacts) do
			gohelper.setActive(tbGo.go, isClear)

			if isPlayAnim and tbGo.animator then
				tbGo.animator:Play("open", 0, 0)
			end
		end
	end
end

function JiaLaBoNaMapScene:_editableInitView()
	self._pageIds = {
		JiaLaBoNaEnum.Chapter.One,
		JiaLaBoNaEnum.Chapter.Two
	}
	self._chapterSceneUdtbDict = {}
	self._chapterInactsTbDict = {}

	self:onScreenResize()

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("JiaLaBoNaMap")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function JiaLaBoNaMapScene:onDestroyView()
	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end

	if self._chapterSceneUdtbDict then
		self._chapterSceneUdtbDict = nil
	end
end

return JiaLaBoNaMapScene
