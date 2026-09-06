-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarAreaEnergyRankView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarAreaEnergyRankView", package.seeall)

local GodStatuesWarAreaEnergyRankView = class("GodStatuesWarAreaEnergyRankView", ViewComponent)

function GodStatuesWarAreaEnergyRankView:buildUI()
	GodStatuesWarAreaEnergyRankView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtTitle = goutil.findChild(self.mainGO, "txtTitle")
	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
end

function GodStatuesWarAreaEnergyRankView:bindEvents()
	GodStatuesWarAreaEnergyRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GodStatuesWarAreaEnergyRankView:unbindEvents()
	GodStatuesWarAreaEnergyRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GodStatuesWarAreaEnergyRankView:onEnter()
	GodStatuesWarAreaEnergyRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local isInTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d )", self._seasonId))
		self:close()

		return
	end

	self:showTabAt(self._contentCol, ViewName.GodStatuesWarTabChildRankAreaEnergyView, self._seasonId)
end

function GodStatuesWarAreaEnergyRankView:onExit()
	GodStatuesWarAreaEnergyRankView.super.onExit(self)
	self:showTabAt(self._contentCol, "")
end

return GodStatuesWarAreaEnergyRankView
