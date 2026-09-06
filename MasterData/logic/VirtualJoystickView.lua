-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/joystick/view/VirtualJoystickView.lua

module("logic.extensions.joystick.view.VirtualJoystickView", package.seeall)

local VirtualJoystickView = class("VirtualJoystickView", ViewComponent)

function VirtualJoystickView:ctor()
	VirtualJoystickView.super.ctor(self)

	self._virtualjoystick = nil
	self._virtualCtrl = nil
	self._bgGo = nil
	self._isSmallJoystickModel = false
	self._isForbidSceneHint = false
	self._isJoystickDown = false
end

function VirtualJoystickView:buildUI()
	self._virtualCtrl = goutil.addComponentOnce(self.mainGO, typeof(ClickToShowJoystick))
	self._virtualCtrl.layerMask = Framework.LayerUtil.GetLayerMask(SceneLayer.FindWay, SceneLayer.Unit, SceneLayer.InteractiveObject)
	self._virtualCtrl.maxDistance = 1000

	local bgGo = goutil.findChild(self.mainGO, "joystickArea/joystickbackground")

	self._imgBg = bgGo:GetComponent(goutil.Type_UIImage)
	self._imgCenter = goutil.findChildImageComponent(bgGo, "joystickImage")
	self._bgGo = bgGo
	self._virtualjoystick = goutil.addComponentOnce(bgGo, typeof(VirtualJoystick))
	VirtualJoystickModel.instance.virtualjyostick = self._virtualjoystick

	VirtualJoystickModel.instance:setJoystickCtrl(self._virtualCtrl)
	VirtualJoystickModel.instance:setJoystickView(self)
	self:setSmallJoystickModel(false)
end

function VirtualJoystickView:bindEvents()
	self._virtualCtrl:AddSceneHitListener(self._onSceneHit, self)
	self._virtualjoystick:AddDownListener(self._onJoystickDown, self)
	self._virtualjoystick:AddUpListener(self._onJoystickUp, self)
	GlobalDispatcher:addListener(GlobalNotify.ForbidSceneHint, self._forbidSceneHint, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationPause, self._onApplicationPause, self)
	GlobalDispatcher:addListener(GlobalNotify.SceneAwake, self._onSceneAwake, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onViewOpen, self)
	GlobalDispatcher:addListener(GlobalNotify.TeamMountStatusChanged, self._handleChangeTeamMountStatus, self)
end

function VirtualJoystickView:unbindEvents()
	GlobalDispatcher:removeListener(GlobalNotify.ForbidSceneHint, self._forbidSceneHint, self)
	GlobalDispatcher:removeListener(GlobalNotify.ApplicationPause, self._onApplicationPause, self)
	GlobalDispatcher:removeListener(GlobalNotify.SceneAwake, self._onSceneAwake, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpen, self._onViewOpen, self)
	GlobalDispatcher:removeListener(GlobalNotify.TeamMountStatusChanged, self._handleChangeTeamMountStatus, self)
	self._virtualjoystick:RemoveDownListener()
	self._virtualjoystick:RemoveUpListener()
	self._virtualCtrl:RemoveSceneHitListener()
end

function VirtualJoystickView:onEnter()
	self:_handleChangeTeamMountStatus()
end

function VirtualJoystickView:onExit()
	if self._isJoystickDown then
		self._virtualCtrl:StopJoystickMove()
	end
end

function VirtualJoystickView:setViewRoot(rootType)
	local root = ViewMgr.instance:getRoot(rootType)

	goutil.addChildToParent(self.mainGO, root)
end

function VirtualJoystickView:setEnable(enable)
	self.mainGO:SetActive(enable)

	if not enable and self._isJoystickDown then
		self._virtualCtrl:StopJoystickMove()
	end
end

function VirtualJoystickView:setSmallJoystickModel(isSmallJoystickModel)
	self._isSmallJoystickModel = isSmallJoystickModel

	if isSmallJoystickModel then
		self._bgGo:SetActive(true)
		self:_setJoystickActive(false)

		local size = Vector2.New(350, 350)

		self._virtualCtrl:SetJoystickArea(size.x, size.y, 100, 100)
		self._virtualCtrl:SetMainActiveArea(0, 0)
		self._virtualCtrl:SetFixed(true)
	else
		local uiRoot = ViewMgr.instance:getUIRoot()
		local rectTransform = uiRoot.transform
		local width = rectTransform.rect.width
		local height = rectTransform.rect.height

		self._bgGo:SetActive(false)
		self:_setJoystickActive(true)
		self._virtualCtrl:SetJoystickArea(width, height, 0, 0)
		self._virtualCtrl:SetMainActiveArea(width, height)
		self._virtualCtrl:SetFixed(false)
	end
end

function VirtualJoystickView:_onApplicationPause()
	if self._isJoystickDown then
		self._virtualCtrl:StopJoystickMove()
	end
end

function VirtualJoystickView:_onSceneAwake()
	if self._virtualCtrl then
		local cameraMode = CameraMgr.instance:getCameraMode()
		local camera = CameraMgr.instance:getMainCamera()

		self._virtualCtrl:SetMainCamera((cameraMode > 1 or nil) and CameraMgr.instance:getUnitCamera())
	end
end

function VirtualJoystickView:_forbidSceneHint(state)
	self._isForbidSceneHint = state
end

function VirtualJoystickView:_onSceneHit(collider, hitPoint)
	if self._isForbidSceneHint == true then
		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.SceneHit, collider, hitPoint)
end

function VirtualJoystickView:_onJoystickDown()
	self._isJoystickDown = true

	self:_setJoystickActive(true)
	GlobalDispatcher:dispatch(GlobalNotify.JoystickDown)
end

function VirtualJoystickView:_onJoystickUp()
	if self._isJoystickDown then
		self._isJoystickDown = false

		self._virtualCtrl:StopJoystickMove()

		if self._isSmallJoystickModel then
			self:_setJoystickActive(false)
			self._bgGo:SetActive(true)
		end

		GlobalDispatcher:dispatch(GlobalNotify.JoystickUp)
	end
end

function VirtualJoystickView:_setJoystickActive(isActive)
	if isActive then
		-- block empty
	end
end

function VirtualJoystickView:_onViewOpen(view)
	local root = view:attachToWhichRoot()

	if root ~= ViewRootType.Notify and root ~= ViewRootType.NotifyTop then
		self:_onJoystickUp()
	end
end

function VirtualJoystickView:isSmallJoystickModel()
	return self._isSmallJoystickModel
end

function VirtualJoystickView:_handleChangeTeamMountStatus()
	self:setEnable(not MountModel.instance:isTeamMountMember())
end

return VirtualJoystickView
