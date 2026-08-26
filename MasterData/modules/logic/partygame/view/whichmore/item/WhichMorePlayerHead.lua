-- chunkname: @modules/logic/partygame/view/whichmore/item/WhichMorePlayerHead.lua

module("modules.logic.partygame.view.whichmore.item.WhichMorePlayerHead", package.seeall)

local WhichMorePlayerHead = class("WhichMorePlayerHead", SimpleListItem)

function WhichMorePlayerHead:onInit()
	self.partygameplayerhead = gohelper.findChild(self.viewGO, "partygameplayerhead")
	self.partyGamePlayerHead = GameFacade.createLuaCompByGo(self.partygameplayerhead, PartyGamePlayerHead, nil, self.viewContainer)
end

function WhichMorePlayerHead:onItemShow(data)
	self.data = data

	self.partyGamePlayerHead:setData(data)
end

function WhichMorePlayerHead:setScoreAddAnim(isPlay, value)
	self.partyGamePlayerHead:setScoreAddAnim(isPlay, value)
end

return WhichMorePlayerHead
