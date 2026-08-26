-- chunkname: @modules/logic/versionactivity1_3/chess/view/Activity1_3ChessMapScene.lua

module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapScene", package.seeall)

local Activity1_3ChessMapScene = class("Activity1_3ChessMapScene", BaseView)
local ChapterId2NodeIdDic = {
	[Activity1_3ChessEnum.Chapter.One] = {
		1,
		2,
		3,
		4
	},
	[Activity1_3ChessEnum.Chapter.Two] = {
		5,
		6,
		7,
		8
	}
}
local NodeElementInMapPath = {
	{
		"Obj-Plant/all/diffuse/zjm01_jy"
	},
	{
		"Obj-Plant/all/diffuse/zjm01_shu"
	},
	{
		"Obj-Plant/all/diffuse/zjm01_lang",
		"Obj-Plant/all/diffuse/zjm01_yang"
	},
	{
		"Obj-Plant/all/diffuse/zjm01_lsm"
	},
	{
		"Obj-Plant/all/diffuse/zjm02_jjc"
	},
	{
		"Obj-Plant/all/diffuse/zjm02_mj",
		"Obj-Plant/all/diffuse/zjm02_ml_die"
	},
	{
		"Obj-Plant/all/diffuse/zjm02_sp01",
		"Obj-Plant/all/diffuse/zjm02_sp02",
		"Obj-Plant/all/diffuse/zjm02_sp03"
	},
	{
		"Obj-Plant/all/diffuse/zjm02_bb",
		"Obj-Plant/all/diffuse/zjm02_jj",
		"Obj-Plant/all/diffuse/zjm02_mm"
	}
}

function Activity1_3ChessMapScene:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity1_3ChessMapScene:addEvents()
	self.addEventCb(self, Activity1_3ChessController.instance, Activity1_3ChessEvent.MapSceneActvie, self.setSceneActive, self)
end

function Activity1_3ChessMapScene:removeEvents()
	return
end

function Activity1_3ChessMapScene:onUpdateParam()
	return
end

function Activity1_3ChessMapScene:onOpen()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.onScreenResize, self)
end

function Activity1_3ChessMapScene:setSceneActive(isActive)
	if self._sceneRoot then
		gohelper.setActive(self._sceneRoot, isActive)
	end
end

function Activity1_3ChessMapScene:onClose()
	return
end

function Activity1_3ChessMapScene:_editableInitView()
	self._pageIds = {
		Activity1_3ChessEnum.Chapter.One,
		Activity1_3ChessEnum.Chapter.Two
	}
	self._chapterSceneUdtbDict = {}
	self._chapterInactList = {}

	self:onScreenResize()

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("Activity1_3ChessMap")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function Activity1_3ChessMapScene:onScreenResize()
	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale(true)

	camera.orthographic = true
	camera.orthographicSize = 7.5 * scale
end

function Activity1_3ChessMapScene:resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = 5
	camera.orthographic = false
end

function Activity1_3ChessMapScene:switchStage(stage)
	if not Activity1_3ChessEnum.MapSceneResPath[stage] then
		return
	end

	if self._chapterSceneUdtbDict then
		self:_createChapterScene(stage)

		for _, tb in pairs(self._chapterSceneUdtbDict) do
			gohelper.setActive(tb.go, tb.chaperId == stage)
		end
	end
end

function Activity1_3ChessMapScene:_createChapterScene(chaperId)
	if self._chapterSceneUdtbDict and not self._chapterSceneUdtbDict[chaperId] then
		local go = self:getResInst(Activity1_3ChessEnum.MapSceneResPath[chaperId], self._sceneRoot)

		transformhelper.setLocalPos(go.transform, 0, 0, 0)

		local chapterData = self:getUserDataTb_()

		chapterData.go = go
		chapterData.chaperId = chaperId
		chapterData.nodeElementDic = {}
		chapterData.animator = gohelper.onceAddComponent(go, typeof(UnityEngine.Animator))
		self._chapterSceneUdtbDict[chaperId] = chapterData

		self:_initChapterSceneElement(chaperId)
	end
end

function Activity1_3ChessMapScene:_initChapterSceneElement(chaperId)
	local chapterData = self._chapterSceneUdtbDict[chaperId]
	local nodeIds = ChapterId2NodeIdDic[chaperId]

	for _, nodeId in ipairs(nodeIds) do
		local nodeElementPaths = NodeElementInMapPath[nodeId]

		for _, elementPath in ipairs(nodeElementPaths) do
			local elementGo = gohelper.findChild(chapterData.go, elementPath)

			if elementGo then
				chapterData.nodeElementDic[nodeId] = chapterData.nodeElementDic[nodeId] or {}

				local nodeElements = chapterData.nodeElementDic[nodeId]

				nodeElements[#nodeElements + 1] = elementGo

				gohelper.setActive(elementGo, false)
			end
		end
	end

	self:_refreshChaperSceneElement(chaperId)
end

function Activity1_3ChessMapScene:_refreshChaperSceneElement(chaperId, forceActive)
	local chapterData = self._chapterSceneUdtbDict[chaperId]
	local nodeElementDic = chapterData and chapterData.nodeElementDic

	if not nodeElementDic then
		return
	end

	for nodeId, nodeElements in pairs(nodeElementDic) do
		local episodeData = Activity122Model.instance:getEpisodeData(nodeId)

		for _, nodeElementGo in ipairs(nodeElements) do
			gohelper.setActive(nodeElementGo, (forceActive ~= nil or nil) and forceActive)
		end
	end
end

function Activity1_3ChessMapScene:onSetVisible(visible)
	if visible then
		self:_refreshChaperSceneElement(Activity1_3ChessEnum.Chapter.One)
		self:_refreshChaperSceneElement(Activity1_3ChessEnum.Chapter.Two)
	else
		self:_refreshChaperSceneElement(Activity1_3ChessEnum.Chapter.One, false)
		self:_refreshChaperSceneElement(Activity1_3ChessEnum.Chapter.Two, false)
	end
end

function Activity1_3ChessMapScene:playSceneEnterAni(chaperId)
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)

	local chapterData = self._chapterSceneUdtbDict[chaperId]

	if chapterData and chapterData.animator then
		chapterData.animator:Play("open")
	end

	TaskDispatcher.runDelay(self.playSceneEnterAniEnd, self, 0.6)
end

function Activity1_3ChessMapScene:playSceneEnterAniEnd()
	UIBlockMgr.instance:endBlock(Activity1_3ChessEnum.UIBlockKey)
end

function Activity1_3ChessMapScene:onDestroyView()
	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end

	if self._chapterSceneUdtbDict then
		self._chapterSceneUdtbDict = nil
	end
end

return Activity1_3ChessMapScene
