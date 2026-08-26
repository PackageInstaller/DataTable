-- chunkname: @modules/logic/partygame/view/common/component/PartyGameStartUI.lua

module("modules.logic.partygame.view.common.component.PartyGameStartUI", package.seeall)

local PartyGameStartUI = class("PartyGameStartUI", PartyGameCompBase)

function PartyGameStartUI:onInit()
	self._gocountdown = gohelper.findChild(self.viewGO, "#go_countdown")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_countdown/#txt_num")
	self._gostart = gohelper.findChild(self.viewGO, "#go_start")

	gohelper.setActive(self._gocountdown, false)
end

function PartyGameStartUI:onViewUpdate(logicFrame)
	if logicFrame == nil then
		return
	end

	local needShowCountDown = logicFrame > 0 and logicFrame < 60
	local needShowStart = logicFrame > 60 and logicFrame < 80

	if self._gostart.activeSelf ~= needShowStart then
		gohelper.setActive(self._gostart, needShowStart)

		if needShowStart then
			AudioMgr.instance:trigger(AudioEnum3_4.PartyGame.gamestart)
			PartyGameController.instance:dispatchEvent(PartyGameEvent.ShowStartTip)
		end
	end

	if self._gocountdown.activeSelf ~= needShowCountDown then
		gohelper.setActive(self._gocountdown, needShowCountDown)

		if needShowCountDown then
			AudioMgr.instance:trigger(AudioEnum3_4.PartyGame.countdown)
		end
	end
end

function PartyGameStartUI:setCountDownValue(value)
	return
end

return PartyGameStartUI
