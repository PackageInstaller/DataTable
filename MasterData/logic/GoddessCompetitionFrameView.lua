-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionFrameView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionFrameView", package.seeall)

local GoddessCompetitionFrameView = class("GoddessCompetitionFrameView", EventTaskTabFrameView)

function GoddessCompetitionFrameView:ctor()
	GoddessCompetitionFrameView.super.ctor(self)
end

function GoddessCompetitionFrameView:unbindEvents()
	GoddessCompetitionFrameView.super.unbindEvents(self)
end

function GoddessCompetitionFrameView:bindEvents()
	GoddessCompetitionFrameView.super.bindEvents(self)
end

function GoddessCompetitionFrameView:buildUI()
	GoddessCompetitionFrameView.super.buildUI(self)

	self._con = self:getGo("con")
end

function GoddessCompetitionFrameView:onExit()
	GoddessCompetitionFrameView.super.onExit(self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function GoddessCompetitionFrameView:onEnter()
	GoddessCompetitionFrameView.super.onEnter(self)

	local skinId = 11036
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[3] then
		local x, y, scale = checknumber(modelCfg[1]), checknumber(modelCfg[2]), 1

		self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, modelCfg[3], nil, true, x, y)
	end
end

function GoddessCompetitionFrameView:setActId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = GoddessCompetitionController.instance:getActivityId()
	end

	if self._activityId <= 0 then
		printError("活动id错误")
		self:close()

		return
	end
end

return GoddessCompetitionFrameView
