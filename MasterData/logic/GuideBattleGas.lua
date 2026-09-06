-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideBattleGas.lua

module("logic.extensions.guide.view.GuideBattleGas", package.seeall)

local GuideBattleGas = class("GuideBattleGas", GuideTipsView)

function GuideBattleGas:ctor()
	GuideBattleGas.super.ctor(self)
end

function GuideBattleGas:buildUI()
	GuideBattleGas.super.buildUI(self)

	self._camera = self:getGo("Camera"):GetComponent("Camera")

	CameraRectSetter.CalcRect(self._camera)
end

function GuideBattleGas:onEnterFinished()
	GuideBattleGas.super.onEnterFinished(self)
	self:_showGuide()
end

function GuideBattleGas:_showGuide()
	GuideBattleGas.super._showGuide(self)

	local transform
	local units = SceneMgr.instance:getCurScene().unitFactory:getAllUnit()
	local branch = GuideModel.instance:getCurrGuideBranch()
	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCam = mainCamera:getCamera()

	self:_adjustCameraParams(mainCam)
	self._camera.gameObject:SetActive(true)

	local node = self._nodes[2]

	self.mc = goutil.findChild(node, "mc")
	self.mcTime = goutil.findChild(node, "mcTime")
	self._CountTime = goutil.findChildTextComponent(self.mcTime, "CountTime")

	GameUtil.SetActive(self.mc, true)
	GameUtil.SetActive(self.mcTime, false)
	removetimer(self._onCountTime, self)

	if self._currGuide:autoFinishTime() and self._currGuide:autoFinishTime() > 1 then
		GameUtil.SetActive(self.mcTime, true)

		self._count = self._currGuide:autoFinishTime()
		self._CountTime.text = self._count .. lang("tip_second")

		settimer(1, self._onCountTime, self)
	end

	Framework.TransformUtil.SetLocalPos(node.transform, -350, -20, 0)
end

function GuideBattleGas:_onCountTime()
	self._count = self._count - 1
	self._count = math.max(self._count, 0)

	if self._CountTime then
		self._CountTime.text = self._count .. lang("tip_second")
	end

	if self._count <= 0 then
		removetimer(self._onCountTime, self)
		GameUtil.SetActive(self.mcTime, false)
	end
end

function GuideBattleGas:_setViewText(idx)
	GuideBattleGas.super._setViewText(self, idx)

	local branch = GuideModel.instance:getCurrGuideBranch()
	local pos = GameUtil.getPos(branch._branchParam:getMountPoint(GameEnum.MountPointType.Head))
	local cnt = #self._nodes

	for i = 1, cnt do
		if idx == i then
			local node = self._nodes[i]

			GameUtil.setWorldTo2DCameraPos(node, pos)
		end
	end
end

function GuideBattleGas:_adjustCameraParams(mainCam)
	local posX, posY, posZ = Framework.TransformUtil.GetPos(mainCam.transform, nil, nil, nil)
	local rotX, rotY, rotZ = Framework.TransformUtil.GetLocalRotation(mainCam.transform, nil, nil, nil)

	Framework.TransformUtil.SetLocalRotation(self._camera.transform, rotX, rotY, rotZ)
	Framework.TransformUtil.SetPos(self._camera.transform, posX, posY, posZ)

	self._camera.orthographic = mainCam.orthographic
	self._camera.farClipPlane = mainCam.farClipPlane
	self._camera.orthographicSize = mainCam.orthographicSize
end

function GuideBattleGas:_adjustUnit(transform)
	self._saveTransform = transform
	self._saveUnitLayer = transform.gameObject.layer

	Framework.GameObjectUtil.SetLayerRecursively(transform.gameObject, LayerMask.NameToLayer("UI"))
end

function GuideBattleGas:onExit()
	GuideBattleGas.super.onExit(self)
	removetimer(self._onCountTime, self)
end

function GuideBattleGas:onExitFinished()
	GuideBattleGas.super.onExitFinished(self)
	removetimer(self._onCountTime, self)
	GameUtil.SetActive(self.mc, false)
	GameUtil.SetActive(self.mcTime, false)

	if self._saveTransform and self._saveUnitLayer then
		Framework.GameObjectUtil.SetLayerRecursively(self._saveTransform.gameObject, LayerMask.NameToLayer("Unit"))
	end

	self._saveUnitLayer = nil
	self._saveTransform = nil
end

return GuideBattleGas
