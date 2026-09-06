-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/JumpFloorEndlessView.lua

module("logic.extensions.jumpfloor.view.JumpFloorEndlessView", package.seeall)

local JumpFloorEndlessView = class("JumpFloorEndlessView", ViewComponent)

function JumpFloorEndlessView:ctor()
	JumpFloorEndlessView.super.ctor(self)
end

function JumpFloorEndlessView:buildUI()
	JumpFloorEndlessView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnStart = self:getBtn("btnStart")
	self._btnRank = self:getBtn("btnRank")
	self._con = self:getGo("con")
	self._effect = self:getGo("effect")
end

function JumpFloorEndlessView:bindEvents()
	JumpFloorEndlessView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
end

function JumpFloorEndlessView:unbindEvents()
	JumpFloorEndlessView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnRank:RemoveClickListener()
end

function JumpFloorEndlessView:onEnter()
	JumpFloorEndlessView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self:_showRoleModel()
	self:_loadEffect()
end

function JumpFloorEndlessView:onExit()
	JumpFloorEndlessView.super.onExit(self)
	self:_resetRoleModel()
	self:_clearEffect()
end

function JumpFloorEndlessView:_onClickStart()
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(JumpFloorModel.instance:getActivityType(), self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	JumpFloorController.instance:openEndlessGame(self._activityId)
end

function JumpFloorEndlessView:_onClickRank()
	UIStateManager.instance:push(ViewName.JumpFloorRankView, self._activityId)
end

function JumpFloorEndlessView:_showRoleModel()
	local curFaceId = 12017
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function JumpFloorEndlessView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function JumpFloorEndlessView:_loadEffect()
	self:_clearEffect()

	local path = "20230120/kaizhuangqiwu/fx_ui_kzqw_fw.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._effect.transform, 0, 0, true, false)

	uiEffect:setParent(self._effect.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._bgEffect = uiEffect
end

function JumpFloorEndlessView:_clearEffect()
	if self._bgEffect then
		UIEffectManager.instance:stopEffect(self._bgEffect)

		self._bgEffect = nil
	end
end

return JumpFloorEndlessView
