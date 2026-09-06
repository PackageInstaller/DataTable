-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlematchView.lua

module("logic.extensions.lotusbattle.view.LotusbattlematchView", package.seeall)

local LotusbattlematchView = class("LotusbattlematchView", ViewComponent)

function LotusbattlematchView:ctor()
	LotusbattlematchView.super.ctor(self)
end

function LotusbattlematchView:unbindEvents()
	LotusbattlematchView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
end

function LotusbattlematchView:bindEvents()
	LotusbattlematchView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function LotusbattlematchView:buildUI()
	LotusbattlematchView.super.buildUI(self)

	self._txtTime = self:getTxt("txtTime")
	self._btnCancel = self:getBtn("btnCancel")
	self._effectGo = self:getGo("effect")
end

function LotusbattlematchView:onExit()
	LotusbattlematchView.super.onExit(self)
	removetimer(self._setTimer, self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function LotusbattlematchView:onEnter()
	LotusbattlematchView.super.onEnter(self)

	self._activityId = LotusbattleModel.instance:getActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("匹配失败")
		self:_onClickbtnCancel()

		return
	end

	self._targetTickTime = ServerTime.now() + LotusbattleConfig.instance:getStageTime(self._activityId, "matchingTime")

	settimer(1, self._setTimer, self, true)

	self._timeCount = 0

	self:_setTimer()
	self:_setEffect()
end

function LotusbattlematchView:_onClickbtnCancel()
	LotusBattleFieldAgent.instance:sendPM_LBFCancelMatchReq(self._activityId)
	self:close()
end

function LotusbattlematchView:_setTimer()
	self._timeCount = self._timeCount + 1

	local min = math.floor(self._timeCount / 60)
	local sec = self._timeCount % 60

	self._txtTime.text = string.format("%02d:%02d", min, sec)

	self:_checkActOver()
end

function LotusbattlematchView:_checkActOver()
	if self._timeCount % 10 == 0 then
		if ServerTime.now() >= self._targetTickTime then
			FloatWordMgr.instance:show("匹配超时")
			self:_onClickbtnCancel()

			return
		end

		local isActActive = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.LotusBattle, self._activityId)

		if not isActActive then
			FloatWordMgr.instance:show("不在活动时间内")
			self:_onClickbtnCancel()

			return
		end

		local modelId = LotusbattleController.instance:getModelId(self._activityId)

		if modelId <= 0 then
			FloatWordMgr.instance:show("不在匹配开放时间内")
			self:_onClickbtnCancel()

			return
		end
	end
end

function LotusbattlematchView:_setEffect()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_pipeizhong.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

return LotusbattlematchView
