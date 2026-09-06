-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattlematchView.lua

module("logic.extensions.glorybattle.view.GlorybattlematchView", package.seeall)

local GlorybattlematchView = class("GlorybattlematchView", ViewComponent)

function GlorybattlematchView:ctor()
	GlorybattlematchView.super.ctor(self)
end

function GlorybattlematchView:unbindEvents()
	GlorybattlematchView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
end

function GlorybattlematchView:bindEvents()
	GlorybattlematchView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function GlorybattlematchView:buildUI()
	GlorybattlematchView.super.buildUI(self)

	self._txtTime = self:getTxt("txtTime")
	self._btnCancel = self:getBtn("btnCancel")
	self._effectGo = self:getGo("effect")
end

function GlorybattlematchView:onExit()
	GlorybattlematchView.super.onExit(self)
	removetimer(self._tickTime, self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function GlorybattlematchView:onEnter()
	GlorybattlematchView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GloryBattleMatchFightRes, self._onGloryBattleMatchFightRes, self)

	self._activityId = self:getFirstParam()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("匹配失败")
		self:_onClickbtnCancel()

		return
	end

	self._isReq = false
	self._baseTime = ServerTime.now()
	self._targetTime = self._baseTime + math.random(3, 5)

	settimer(1, self._tickTime, self, true)
	self:_tickTime()
	self:_setEffect()
end

function GlorybattlematchView:_onClickbtnCancel()
	if self._isReq then
		GloryBattleAgent.instance:sendPM_GloryBattleCancelMatchReq(self._activityId)
	end

	self:close()
end

function GlorybattlematchView:_tickTime()
	local time = ServerTime.now() - self._baseTime

	self._txtTime.text = string.format("匹配中：%ss", time)

	self:_checkActOver()
end

function GlorybattlematchView:_checkActOver()
	if self._targetTime < ServerTime.now() and not self._isReq then
		self._isReq = true

		GloryBattleAgent.instance:sendPM_GloryBattleMatchFightReq(self._activityId)
	end
end

function GlorybattlematchView:_setEffect()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_pipeizhong.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function GlorybattlematchView:_onGloryBattleMatchFightRes(status)
	if status ~= 0 then
		self._isReq = false

		FloatWordMgr.instance:show("匹配失败")
	else
		GlorybattleController.instance:enterMission(self._activityId)
	end

	self:close()
end

return GlorybattlematchView
