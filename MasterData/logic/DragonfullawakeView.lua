-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/DragonfullawakeView.lua

module("logic.extensions.sevendays.view.DragonfullawakeView", package.seeall)

local DragonfullawakeView = class("DragonfullawakeView", ExcellentClassView)

function DragonfullawakeView:buildUI()
	DragonfullawakeView.super.buildUI(self)

	self.reserveBtn = self:getBtn("btnReserve")
	self._rulesName = "huanjinshenlonClass"
end

function DragonfullawakeView:onEnter()
	self.curActId = 106001
	self.petId = 10324

	DragonfullawakeView.super.onEnter(self)
	self.reserveBtn:AddClickListener(function()
		UIStateManager.instance:popByName(ViewName.bonus)
		GotoMgr.gotoByString("zz_npc#10011017")
	end, self)
end

return DragonfullawakeView
