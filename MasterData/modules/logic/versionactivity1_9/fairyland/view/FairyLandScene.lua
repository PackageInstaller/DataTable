-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/FairyLandScene.lua

module("modules.logic.versionactivity1_9.fairyland.view.FairyLandScene", package.seeall)

local FairyLandScene = class("FairyLandScene", BaseView)

function FairyLandScene:onInitView()
	self.seasonCameraLocalPos = Vector3(0, 0, -3.9)
	self.seasonCameraOrthographicSize = 5
	self.focusCameraOrthographicSize = 2
	self.focusTime = 0.45
	self.cancelFocusTime = 0.45
	self.goRoot = gohelper.findChild(self.viewGO, "main/#go_Root")
	self.rootTrs = self.goRoot.transform
	self.stopUpdatePos = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FairyLandScene:addEvents()
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.SetSceneUpdatePos, self.onSetSceneUpdatePos, self)
end

function FairyLandScene:removeEvents()
	return
end

function FairyLandScene:_editableInitView()
	self._camera = CameraMgr.instance:getMainCamera()

	self:_initSceneRootNode()
end

function FairyLandScene:initCamera()
	transformhelper.setLocalPos(self._camera.transform, 0, 0, -10)

	self._camera.orthographic = true
	self._camera.orthographicSize = 6.5
end

function FairyLandScene:_initSceneRootNode()
	local mainTrans = self._camera.transform.parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("FairyLandScene")

	local _, y, _ = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
	self:setSceneVisible(self.isVisible or true)
end

function FairyLandScene:_loadScene()
	if self._sceneGo then
		return
	end

	local setting = self.viewContainer:getSetting()
	local scenePath = setting.otherRes.scene

	self._sceneGo = self.viewContainer:getResInst(scenePath, self._sceneRoot)
	self._rootGo = gohelper.findChild(self._sceneGo, "root")

	local bgGround = gohelper.findChild(self._sceneGo, "root/BackGround")

	self._bgRoot = bgGround.transform
	self._bgGo = gohelper.findChild(self._sceneGo, "root/BackGround/m_s08_hddt_background")

	local meshRenderer = self._bgGo:GetComponent(typeof(UnityEngine.MeshRenderer))
	local bounds = meshRenderer.bounds
	local size = bounds:GetSize()

	self.bgX = size.x
	self.bgY = size.y

	gohelper.setActive(self._bgGo, false)
	self:_loadSceneFinish()
end

function FairyLandScene:_loadSceneFinish()
	LateUpdateBeat:Add(self._forceUpdatePos, self)
	self:updateNineBg()
	MainCameraMgr.instance:addView(ViewName.FairyLandView, self.autoInitMainViewCamera, nil, self)

	local pos = FairyLandModel.instance:caleCurStairPos()

	FairyLandModel.instance:setPos(pos)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.SceneLoadFinish)
end

function FairyLandScene:autoInitMainViewCamera()
	self:initCamera()
end

function FairyLandScene:onSetSceneUpdatePos(value)
	self.stopUpdatePos = value
end

function FairyLandScene:onOpen()
	self:_loadScene()
end

function FairyLandScene:_forceUpdatePos()
	if self.stopUpdatePos then
		return
	end

	self:updateBgRootPos()
end

function FairyLandScene:updateBgRootPos()
	local screenPos = recthelper.uiPosToScreenPos(self.rootTrs)

	if self.lastScreenPosX and math.abs(self.lastScreenPosX - screenPos.x) < 0.1 then
		return
	end

	self.lastScreenPosX = screenPos.x

	local x, y = recthelper.screenPosToWorldPos3(screenPos, nil, self._rootGo.transform.position)

	x = x % self.bgX
	y = y % self.bgY

	transformhelper.setLocalPos(self._bgRoot, x - 2, y, 0)
end

function FairyLandScene:updateNineBg()
	self.bgList = self.bgList or {}

	for i = 0, 8 do
		self:setBgPos(i)
	end
end

function FairyLandScene:caleBgPos(index)
	local x = index % 3
	local y = math.floor(index / 3)
	local bgX = (x - 1) * self.bgX
	local bgY = (y - 1) * self.bgY

	return bgX, bgY
end

function FairyLandScene:setBgPos(index)
	local posX, posY = self:caleBgPos(index)
	local bg = self:getBg(index)

	transformhelper.setLocalPosXY(bg, posX, posY)
end

function FairyLandScene:getBg(index)
	local bg = self.bgList[index]

	if not bg then
		local go = gohelper.clone(self._bgGo, self._bgRoot.gameObject, tostring(index))

		gohelper.setActive(go, true)

		bg = go.transform
		self.bgList[index] = go.transform
	end

	return bg
end

function FairyLandScene:onClose()
	LateUpdateBeat:Remove(self._forceUpdatePos, self)
end

function FairyLandScene:setSceneVisible(isVisible)
	if isVisible == self.isVisible then
		return
	end

	self.isVisible = isVisible

	gohelper.setActive(self._sceneRoot, isVisible and true or false)
end

function FairyLandScene:onDestroyView()
	gohelper.destroy(self._sceneRoot)

	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end
end

return FairyLandScene
