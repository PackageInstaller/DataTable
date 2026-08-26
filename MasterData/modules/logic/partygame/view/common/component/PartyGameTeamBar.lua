-- chunkname: @modules/logic/partygame/view/common/component/PartyGameTeamBar.lua

module("modules.logic.partygame.view.common.component.PartyGameTeamBar", package.seeall)

local PartyGameTeamBar = class("PartyGameTeamBar", PartyGameCompBase)

function PartyGameTeamBar:onInit()
	self._txtbulenum = gohelper.findChildText(self.viewGO, "blue/#txt_bule_num")
	self._txtrednum = gohelper.findChildText(self.viewGO, "red/#txt_red_num")

	gohelper.setActive(self.viewGO, self.curGame:isTeamType())
end

function PartyGameTeamBar:onViewUpdate(logicFrame)
	if self.curGame:isTeamType() then
		self._txtrednum.text = self.curGame:getPlayerTeamScore(PartyGameEnum.GamePlayerTeamType.Red)
		self._txtbulenum.text = self.curGame:getPlayerTeamScore(PartyGameEnum.GamePlayerTeamType.Blue)
	end
end

return PartyGameTeamBar
