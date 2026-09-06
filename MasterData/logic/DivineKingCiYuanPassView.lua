-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingciyuan/view/DivineKingCiYuanPassView.lua

module("logic.extensions.divinekingciyuan.view.DivineKingCiYuanPassView", package.seeall)

local DivineKingCiYuanPassView = class("DivineKingCiYuanPassView", ViewComponent)

function DivineKingCiYuanPassView:ctor()
	DivineKingCiYuanPassView.super.ctor(self)
end

function DivineKingCiYuanPassView:unbindEvents()
	DivineKingCiYuanPassView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btn)
end

function DivineKingCiYuanPassView:bindEvents()
	DivineKingCiYuanPassView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btn, self._onClickBtn, self)
end

function DivineKingCiYuanPassView:buildUI()
	DivineKingCiYuanPassView.super.buildUI(self)

	self._btn = self:getBtn("btn")
end

function DivineKingCiYuanPassView:onExit()
	DivineKingCiYuanPassView.super.onExit(self)
end

function DivineKingCiYuanPassView:onEnter()
	DivineKingCiYuanPassView.super.onEnter(self)

	local activityId = self:getFirstParam()
	local fightInfo = DivineKingCiYuanModel.instance:getFightInfo(activityId)

	if fightInfo and fightInfo.changeSetId then
		self._changeSetId = fightInfo.changeSetId
	end
end

function DivineKingCiYuanPassView:_onClickBtn()
	if self._changeSetId then
		MaterialController.instance:showChangeSetInTemp(self._changeSetId)
	end

	self:close()
end

return DivineKingCiYuanPassView
