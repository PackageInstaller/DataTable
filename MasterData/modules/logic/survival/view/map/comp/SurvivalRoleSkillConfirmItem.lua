-- chunkname: @modules/logic/survival/view/map/comp/SurvivalRoleSkillConfirmItem.lua

module("modules.logic.survival.view.map.comp.SurvivalRoleSkillConfirmItem", package.seeall)

local SurvivalRoleSkillConfirmItem = class("SurvivalRoleSkillConfirmItem", LuaCompBase)

function SurvivalRoleSkillConfirmItem:init(go)
	self.go = go
	self.trans = go.transform

	transformhelper.setLocalPos(self.trans, 9999, 9999, 0)

	self._click = gohelper.findChildButtonWithAudio(go, "#image_bubble")
end

function SurvivalRoleSkillConfirmItem:addEventListeners()
	self._click:AddClickListener(self._onClickIcon, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnSelectRoleSkillHexPoint, self._onSelectRoleSkillHexPoint, self)
end

function SurvivalRoleSkillConfirmItem:removeEventListeners()
	self._click:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnSelectRoleSkillHexPoint, self._onSelectRoleSkillHexPoint, self)
end

function SurvivalRoleSkillConfirmItem:_onClickIcon()
	if self._clickCallback then
		self._clickCallback(self._clickCallbackObj)
	end
end

function SurvivalRoleSkillConfirmItem:onStart()
	self.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false

	self:setFollowTrans()
end

function SurvivalRoleSkillConfirmItem:setFollowTrans(trans)
	if not trans then
		if self._uiFollower then
			self._uiFollower:SetEnable(false)
		end

		gohelper.setActive(self.go, false)

		return
	end

	gohelper.setActive(self.go, true)

	self._uiFollower = self._uiFollower or gohelper.onceAddComponent(self.go, typeof(ZProj.UIFollower))

	self._uiFollower:SetEnable(true)

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower:Set(mainCamera, uiCamera, plane, trans, 0, -0.5, 0, 0, 0)
end

function SurvivalRoleSkillConfirmItem:_onSelectRoleSkillHexPoint(hexPoint, clickCallback, clickCallbackObj)
	local trans

	if hexPoint then
		self:setFollowPos(hexPoint)

		trans = self._followGO.transform
	end

	self:setFollowTrans(trans)

	self._clickCallback = clickCallback
	self._clickCallbackObj = clickCallbackObj
end

function SurvivalRoleSkillConfirmItem:setFollowPos(hexPoint)
	if gohelper.isNil(self._followGO) then
		local scene = SurvivalMapHelper.instance:getScene()
		local rootGO = scene:getSceneContainerGO()

		self._followGO = gohelper.findChild(rootGO, "followerGO")

		if gohelper.isNil(self._followGO) then
			self._followGO = gohelper.create3d(rootGO, "followerGO")
		end
	end

	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(hexPoint.q, hexPoint.r)

	transformhelper.setLocalPos(self._followGO.transform, x, y, z)
end

function SurvivalRoleSkillConfirmItem:dispose()
	gohelper.destroy(self.go)
end

return SurvivalRoleSkillConfirmItem
