-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleactions/view/RoleActionsView.lua

module("logic.extensions.roleactions.view.RoleActionsView", package.seeall)

local RoleActionsView = class("RoleActionsView", ViewComponent)

function RoleActionsView:onEnter()
	RoleActionsView.super.onEnter(self)

	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	GlobalDispatcher:addListener(GlobalNotify.PlayRoleAction, self._onPlayRoleAction, self)

	if self._mainPlayer then
		self._mainPlayer.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
		self:_onPlayRoleAction(self:getFirstParam())
	end
end

function RoleActionsView:onExit()
	RoleActionsView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PlayRoleAction, self._onPlayRoleAction, self)
	self:_resumeStatus()
end

function RoleActionsView:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self:_resumeStatus()
	self:close()
end

function RoleActionsView:_resumeStatus()
	if self._mainPlayer then
		SceneMainPlayer.instance:updateVariablesView()
		self._mainPlayer.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
		self._mainPlayer:unfrozenMove()

		self._mainPlayer = nil
	end
end

function RoleActionsView:_onPlayRoleAction(actionName)
	if self._mainPlayer then
		self._mainPlayer:stopAllActions()
		TaskController.instance:stopAction()
		self._mainPlayer.spine:play(actionName)
	end
end

return RoleActionsView
