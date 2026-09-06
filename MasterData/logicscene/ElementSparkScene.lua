-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/ElementSparkScene.lua

module("logicscene.scene.impl.ElementSparkScene", package.seeall)

local ElementSparkScene = class("ElementSparkScene", CityScene)

function ElementSparkScene:_initComponents()
	self:_addComponent("stage", ElementSparkSceneStage)
	self:_addComponent("camera", ElementSparkCamera)
	self:_addComponent("joystick", SceneCompDisableJoystickListener)
	self:_addComponent("resCache", SceneResObjectCache)
	self:_addComponent("unitFactory", ElementSparkUnitFactory)
	self:_addComponent("elements", ElementSparkElemsMgr)
	self:_addComponent("picker", ElementSparkPicker)
	self:_addComponent("bgm", BattleSceneBgmMgr)
end

function ElementSparkScene:getSceneType()
	return SceneType.ElementSpark
end

function ElementSparkScene:onEnter(sceneId, bornX, bornZ)
	ElementSparkScene.super.onEnter(self, sceneId, bornX, bornZ)
	self.bgm:preInitBgmId()
end

function ElementSparkScene:lateEnterFinished()
	ElementSparkScene.super.lateEnterFinished(self)

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer.syncPos:disable(true)
		mainPlayer:setVisible(false)
	end

	self.joystick:setEnable(false)

	local HUDRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	goutil.addComponentOnce(HUDRoot, typeof(UnityEngine.UI.GraphicRaycaster))
end

function ElementSparkScene:onExitFinished()
	ElementSparkScene.super.onExitFinished(self)

	local HUDRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)
	local comp = HUDRoot:GetComponent(typeof(UnityEngine.UI.GraphicRaycaster))

	if comp then
		goutil.destroy(comp)
	end
end

function ElementSparkScene:update(deltaTime)
	self.camera:update(deltaTime)
end

function ElementSparkScene:lateUpdate()
	return
end

function ElementSparkScene:visibleMainPlayer(visible)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:setVisible(false)
	end
end

function ElementSparkScene:visibleObjects(visible)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:setVisible(false)
	end

	if self.walkEff then
		self.walkEff:setVisible(false)
	end

	self._otherPlayerVisible = visible
end

function ElementSparkScene:_onNpcModel(npcId)
	return
end

function ElementSparkScene:_onNpcVisible(npcId, go, visible)
	return
end

function ElementSparkScene:_onNpcCreate(npcId, pos, ofs, paths, moveSpeed, reverse, nameOfs, scale)
	return
end

function ElementSparkScene:_onNpcDestroy(npcId, quality)
	return
end

function ElementSparkScene:getDefaultView()
	return ViewName.ElementSparkMainView
end

function ElementSparkScene:_openViewOnEnter(...)
	ViewMgr.instance:open(ViewName.VirtualJoystick)

	local root = UIStateManager.instance:getRoot()

	UIStateManager.instance:push(root)
	UIJumper.instance:resumeStack()
	ViewMgr.instance:open(ViewName.HorseLanternView)
	ViewMgr.instance:open(ViewName.ItemFly)
	ViewMgr.instance:setPermanent(ViewName.HorseLanternView, true)
	ViewMgr.instance:setPermanent(ViewName.ItemFly, true)
	ViewMgr.instance:setPermanent(ViewName.VirtualJoystick, true)
	GMController.instance:showGM(true)
end

return ElementSparkScene
