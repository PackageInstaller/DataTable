-- chunkname: @modules/logic/partygame/view/snatcharea/SnatchAreaGamePlayerRankView.lua

module("modules.logic.partygame.view.snatcharea.SnatchAreaGamePlayerRankView", package.seeall)

local SnatchAreaGamePlayerRankView = class("SnatchAreaGamePlayerRankView", BaseView)

function SnatchAreaGamePlayerRankView:onInitView()
	self.goPlayerRank = gohelper.findChild(self.viewGO, "root/right/#go_playerlist_common")
	self.interface = PartyGameCSDefine.SnatchAreaInterfaceCs
end

function SnatchAreaGamePlayerRankView:addEvents()
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.LogicCalFinish, self.frameTick, self)
end

function SnatchAreaGamePlayerRankView:removeEvents()
	return
end

function SnatchAreaGamePlayerRankView:frameTick()
	if self.playerComp then
		self.playerComp:viewDataUpdate()
	end
end

function SnatchAreaGamePlayerRankView:onOpen()
	self:createPlayerRank()
end

function SnatchAreaGamePlayerRankView:createPlayerRank()
	local itemRes = self.viewContainer:getSetting().otherRes.playerInfo
	local go = self.viewContainer:getResInst(itemRes, self.goPlayerRank)

	self.playerComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PlayerInfoComp)

	self.playerComp:Init()
end

function SnatchAreaGamePlayerRankView:onDestroyView()
	return
end

return SnatchAreaGamePlayerRankView
