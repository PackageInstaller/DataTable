-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/view/JigsawcollectunlockView.lua

module("logic.extensions.jigsawcollect.view.JigsawcollectunlockView", package.seeall)

local JigsawcollectunlockView = class("JigsawcollectunlockView", ViewComponent)

function JigsawcollectunlockView:ctor()
	JigsawcollectunlockView.super.ctor(self)
end

function JigsawcollectunlockView:buildUI()
	JigsawcollectunlockView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._roleConGo = self:getGo("roleCon")
end

function JigsawcollectunlockView:bindEvents()
	JigsawcollectunlockView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function JigsawcollectunlockView:unbindEvents()
	JigsawcollectunlockView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function JigsawcollectunlockView:destroyUI()
	JigsawcollectunlockView.super.destroyUI(self)
end

function JigsawcollectunlockView:onEnter()
	JigsawcollectunlockView.super.onEnter(self)

	local cfg = self:getFirstParam()

	self._txtDesc.text = cfg.content
	self._txtTitle.text = cfg.title

	self:_setRole()
end

function JigsawcollectunlockView:onEnterFinished()
	JigsawcollectunlockView.super.onEnterFinished(self)
end

function JigsawcollectunlockView:onExit()
	JigsawcollectunlockView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._roleObj)
end

function JigsawcollectunlockView:onExitFinished()
	JigsawcollectunlockView.super.onExitFinished(self)
end

function JigsawcollectunlockView:_onClickbtnSure()
	self:close()
	GlobalDispatcher:dispatch(JigsawcollectController.PlayCloseColorEggViewEffect)

	local num = JigsawcollectModel.instance:getTotalChipNum()
	local actId = JigsawcollectModel.instance:getActId()
	local cfg = JigsawcollectConfig.instance:getJigsawCfg(actId)
	local planCfgs = JigsawcollectConfig.instance:getPiecePlanCfgs(cfg.piecePlan)

	if num >= #planCfgs then
		GlobalDispatcher:dispatch(JigsawcollectController.PlayGetLastChipEffect, true)
	end
end

function JigsawcollectunlockView:_setRole()
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, 10140, self._roleConGo, 0.4, nil, false)
end

return JigsawcollectunlockView
