-- chunkname: @modules/logic/partygame/view/carddrop/edit/CardDropEditGameView.lua

module("modules.logic.partygame.view.carddrop.edit.CardDropEditGameView", package.seeall)

local CardDropEditGameView = class("CardDropEditGameView", BaseView)

function CardDropEditGameView:onInitView()
	self.timelineInput = gohelper.findChildTextMeshInputField(self.viewGO, "root/top/timeline_input")
	self.sideDrop = gohelper.findChildDropdown(self.viewGO, "root/top/side_drop")
	self.playBtn = gohelper.findChildButton(self.viewGO, "root/top/play_btn")

	self.addClickCb(self, self.playBtn, self.onClickPlayBtn, self)

	self.interface = PartyGameCSDefine.CardDropInterfaceCs
end

function CardDropEditGameView:onClickPlayBtn()
	local timelineName = self.timelineInput:GetText()

	if string.nilorempty(timelineName) then
		return
	end

	local attackSide = self.sideDrop:GetValue()
	local uid = attackSide == 0 and self.interface.GetMyPlayerUid() or self.interface.GetEnemyPlayerUid()

	CardDropTimelineController.instance:playTimeline(uid, timelineName)
end

function CardDropEditGameView:onOpen()
	local entityDict = CardDropGameController.instance:getEntityDict()

	if entityDict then
		for _, entity in pairs(entityDict) do
			entity:show()
		end
	end
end

return CardDropEditGameView
