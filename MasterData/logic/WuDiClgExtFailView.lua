-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/view/WuDiClgExtFailView.lua

module("logic.extensions.wudiclg.view.WuDiClgExtFailView", package.seeall)

local WuDiClgExtFailView = class("WuDiClgExtFailView", ViewComponent)

function WuDiClgExtFailView:buildUI()
	WuDiClgExtFailView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtAttackCount = goutil.findChildTextComponent(self.mainGO, "txtAttackCount")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
end

function WuDiClgExtFailView:bindEvents()
	WuDiClgExtFailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function WuDiClgExtFailView:unbindEvents()
	WuDiClgExtFailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function WuDiClgExtFailView:onEnter()
	WuDiClgExtFailView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local msg = params[1]

	if msg == nil then
		self:_onClickBtnClose()

		return
	end

	local activityId = msg.activityId
	local stageId = msg.stageId
	local curFightGroupAttackCount = msg.curFightGroupAttackCount
	local stageData = WuDiClgConfig.instance:getWdcExtStageData(activityId, stageId)
	local needGroupAttackCount = stageData.groupAttackCount

	self._txtAttackCount.text = string.format("<color=#eb4624>%s/%s</color>", curFightGroupAttackCount, needGroupAttackCount)
end

function WuDiClgExtFailView:onExit()
	WuDiClgExtFailView.super.onExit(self)
end

function WuDiClgExtFailView:_onClickBtnClose()
	BattleController.instance:endBattle()
end

function WuDiClgExtFailView:_onClickBtnSure()
	BattleController.instance:endBattle()
end

return WuDiClgExtFailView
