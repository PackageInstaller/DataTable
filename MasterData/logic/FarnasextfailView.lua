-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasextfailView.lua

module("logic.extensions.farnas.view.FarnasextfailView", package.seeall)

local FarnasextfailView = class("FarnasextfailView", ViewComponent)

function FarnasextfailView:buildUI()
	FarnasextfailView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtAttackCount = goutil.findChildTextComponent(self.mainGO, "txtAttackCount")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
end

function FarnasextfailView:bindEvents()
	FarnasextfailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function FarnasextfailView:unbindEvents()
	FarnasextfailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function FarnasextfailView:onEnter()
	FarnasextfailView.super.onEnter(self)

	local msg = FarnasModel.instance:getExtFightResultRes()

	if msg == nil then
		self:_onClickBtnSure()

		return
	end

	local activityId = msg.activityId
	local stageId = msg.stageId
	local curCount = msg.dodgeCount
	local stageData = FarnasConfig.instance:getExtStageCfg(activityId, stageId)
	local needCount = stageData.dodgeCount

	self._txtAttackCount.text = string.format("我方精灵闪避总次数<color=#eb4624>(%s/%s)</color>", curCount, needCount)
end

function FarnasextfailView:onExit()
	FarnasextfailView.super.onExit(self)
end

function FarnasextfailView:_onClickBtnSure()
	BattleController.instance:endBattle()
end

return FarnasextfailView
