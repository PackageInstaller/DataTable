-- chunkname: @modules/logic/survival/view/shelter/SurvivalDecreeVoteUIItem.lua

module("modules.logic.survival.view.shelter.SurvivalDecreeVoteUIItem", package.seeall)

local SurvivalDecreeVoteUIItem = class("SurvivalDecreeVoteUIItem", LuaCompBase)

function SurvivalDecreeVoteUIItem:ctor(entityGO)
	self.entityGO = entityGO
end

function SurvivalDecreeVoteUIItem:init(go)
	self.go = go
	self.trans = go.transform

	transformhelper.setLocalPos(self.trans, 9999, 9999, 0)
	self:initFollower()
end

function SurvivalDecreeVoteUIItem:onStart()
	self.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function SurvivalDecreeVoteUIItem:initFollower()
	if self._uiFollower then
		return
	end

	if gohelper.isNil(self.entityGO) then
		return
	end

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	gohelper.setActive(self._goarrow, false)

	self._uiFollower = gohelper.onceAddComponent(self.go, typeof(ZProj.UIFollower))

	self._uiFollower:Set(mainCamera, uiCamera, plane, self.entityGO.transform, 0, 0.5, 0, 0, 0)
	self._uiFollower:SetEnable(true)
end

function SurvivalDecreeVoteUIItem:dispose()
	gohelper.destroy(self.go)
end

return SurvivalDecreeVoteUIItem
