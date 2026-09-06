-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvNormalEventPrizeView.lua

module("logic.extensions.domainadventure.view.DomAdvNormalEventPrizeView", package.seeall)

local DomAdvNormalEventPrizeView = class("DomAdvNormalEventPrizeView", ViewComponent)

function DomAdvNormalEventPrizeView:buildUI()
	DomAdvNormalEventPrizeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")

	local scrView = goutil.findChild(self.mainGO, "descCol/scrView")
	local scrCell = goutil.findChild(self.mainGO, "descCol/scrCell")

	self._itemScrollercell = goutil.findChild(self.mainGO, "descCol/itemScrCell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._descScrollList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))
end

function DomAdvNormalEventPrizeView:bindEvents()
	DomAdvNormalEventPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DomAdvNormalEventPrizeView:unbindEvents()
	DomAdvNormalEventPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DomAdvNormalEventPrizeView:onEnter()
	DomAdvNormalEventPrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._blockId = checknumber(params[2])
	self._eventId = DomainAdventureConfig.instance:getEventId(self._activityId, self._blockId)
	self._eventType = DomainAdventureConfig.instance:getEventType(self._activityId, self._blockId)

	local eventData = DomainAdventureController.instance:getEventData(self._activityId, self._eventType, self._eventId)

	if eventData then
		if not eventData.prizePlanId then
			local prizePlanId = 0
			local prizeCfg = DomainAdventureConfig.instance:getValuePrizeCfg(prizePlanId)

			self._descScrollList:reloadData(prizeCfg or {})
		end
	end
end

function DomAdvNormalEventPrizeView:onExit()
	DomAdvNormalEventPrizeView.super.onExit(self)
	self._descScrollList:dispose()
end

function DomAdvNormalEventPrizeView:_updateDescCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")
	local value = data.value

	txtValue.text = value >= 10000 and string.format("%s万", value / 10000) or value

	if itemScrView and self._itemScrollercell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrView, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end
end

function DomAdvNormalEventPrizeView:_clearDescCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function DomAdvNormalEventPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function DomAdvNormalEventPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return DomAdvNormalEventPrizeView
