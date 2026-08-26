-- chunkname: @modules/logic/partygame/view/carddrop/CardDropGameController.lua

module("modules.logic.partygame.view.carddrop.CardDropGameController", package.seeall)

local CardDropGameController = class("CardDropGameController")

CardDropGameController.EditMode = false

function CardDropGameController:init()
	if self.inited then
		return
	end

	self.inited = true

	PartyGameCSDefine.CardDropInterfaceCs.SetSpineGoLoadedCallback(self.createEntity, self)

	local curGame = PartyGameController.instance:getCurPartyGame()

	self.mainUid = curGame:getMainPlayerUid()
	self.maxSelectedCount = PartyGameCSDefine.CardDropInterfaceCs.GetMaxSelectedCount()
	self.selectedCardIndexList = {}
	self.entityDict = {}
end

function CardDropGameController:clear()
	self.inited = false
	self.selectedCardIndexList = nil

	tabletool.clear(self.entityDict)

	self.entityDict = nil
end

function CardDropGameController:addSelectCount(index)
	local len = #self.selectedCardIndexList

	if len >= self.maxSelectedCount then
		return false
	end

	if tabletool.indexOf(self.selectedCardIndexList, index) then
		return false
	end

	table.insert(self.selectedCardIndexList, index)
	self:dispatchEvent(CardDropGameEvent.OnSelectedCardChange)
end

function CardDropGameController:removeSelectedIndex(index)
	for i, value in ipairs(self.selectedCardIndexList) do
		if value == index then
			table.remove(self.selectedCardIndexList, i)
			self:dispatchEvent(CardDropGameEvent.OnSelectedCardChange)

			return true
		end
	end
end

function CardDropGameController:getIndexSelectedIndex(index)
	for i, value in ipairs(self.selectedCardIndexList) do
		if value == index then
			return i
		end
	end
end

function CardDropGameController:getSelectedCount()
	return #self.selectedCardIndexList
end

function CardDropGameController:commitSelectedCard()
	if self:isCommited() then
		return
	end

	for index, selectedIndex in ipairs(self.selectedCardIndexList) do
		PartyGameCSDefine.CardDropInterfaceCs.CreateNumberCommand(index, selectedIndex)
	end
end

function CardDropGameController:isCommited()
	return PartyGameCSDefine.CardDropInterfaceCs.CheckPlayerIsCommited(self.mainUid)
end

function CardDropGameController:createEntity(uid, spineGo)
	if not self.entityDict then
		return
	end

	local entity = CardDropEntity.New()

	entity:init(uid, spineGo)

	uid = tostring(uid)
	self.entityDict[uid] = entity
end

function CardDropGameController:getEntity(uid)
	if not self.entityDict then
		return
	end

	uid = tostring(uid)

	return self.entityDict[uid]
end

function CardDropGameController:getEntityDict()
	return self.entityDict
end

function CardDropGameController:getTitleText()
	local time = self:getCardDropTime()

	return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partygame_carddrop_all_title"), time)
end

function CardDropGameController:setGuideTime(guideTime)
	self.guideTime = guideTime
end

function CardDropGameController:getCardDropTime()
	local curGame = PartyGameController.instance:getCurPartyGame()

	if curGame and curGame:getIsLocal() and not curGame:getIsTrial() then
		return self.guideTime or 1
	end

	local playerList = PartyGameModel.instance:getCurGamePlayerList()
	local len = #playerList

	return len == 8 and 1 or len == 4 and 2 or 3
end

CardDropGameController.instance = CardDropGameController.New()

LuaEventSystem.addEventMechanism(CardDropGameController.instance)

return CardDropGameController
