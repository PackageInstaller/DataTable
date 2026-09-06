-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShanNormalResultView.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShanNormalResultView", package.seeall)

local DivineTianShanNormalResultView = class("DivineTianShanNormalResultView", ViewComponent)

function DivineTianShanNormalResultView:ctor()
	DivineTianShanNormalResultView.super.ctor(self)
end

function DivineTianShanNormalResultView:unbindEvents()
	DivineTianShanNormalResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineTianShanNormalResultView:bindEvents()
	DivineTianShanNormalResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickClose, self)
end

function DivineTianShanNormalResultView:buildUI()
	DivineTianShanNormalResultView.super.buildUI(self)

	self._txtLeftHp = self:getTxt("totalDamage/Text")
	self._txtDamage = self:getTxt("curDamage/Text")
	self._btnSure = self:getGo("btnSure")
	self._txtTips = self:getGo("txtTips")
end

function DivineTianShanNormalResultView:onExit()
	DivineTianShanNormalResultView.super.onExit(self)
end

function DivineTianShanNormalResultView:onEnter()
	DivineTianShanNormalResultView.super.onEnter(self)

	local info = self:getFirstParam()

	if not info then
		self:_onClickClose()

		return
	end

	local activityId = checknumber(info.activityId)
	local stageId = checknumber(info.stageId)
	local leftHp = checknumber(info.leftHp)
	local curDamage = checknumber(info.curDamage)

	self._stageInfoMap = DivineTianShanClgModel.instance:getNormalStageMap(activityId)

	local stageInfo = self._stageInfoMap[stageId]

	if info.isPractice then
		goutil.setActive(self._txtTips, true)
	else
		goutil.setActive(self._txtTips, false)
	end

	self._txtDamage.text = string.format("%s(%s%%)", curDamage, Mathf.Ceil(curDamage / checknumber(stageInfo.totalDamage) * 100))
	self._txtLeftHp.text = string.format("%s(%s%%)", leftHp, Mathf.Ceil(leftHp / checknumber(stageInfo.totalDamage) * 100))
end

function DivineTianShanNormalResultView:_onClickClose()
	self:close()
	BattleController.instance:endBattle()
end

return DivineTianShanNormalResultView
