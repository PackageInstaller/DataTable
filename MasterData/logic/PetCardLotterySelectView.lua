-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcardlottery/view/PetCardLotterySelectView.lua

module("logic.extensions.petcardlottery.view.PetCardLotterySelectView", package.seeall)

local PetCardLotterySelectView = class("PetCardLotterySelectView", ViewComponent)

function PetCardLotterySelectView:ctor()
	PetCardLotterySelectView.super.ctor(self)
end

function PetCardLotterySelectView:unbindEvents()
	PetCardLotterySelectView.super.unbindEvents(self)

	for i = 1, self._petGroupCount do
		GameUtil.rmClickHandler(self._petGroupList[i].btnAdd)
	end

	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCanecel)
	GameUtil.rmClickHandler(self._btnRandom)
end

function PetCardLotterySelectView:bindEvents()
	PetCardLotterySelectView.super.bindEvents(self)

	for i = 1, #self._petGroupList do
		GameUtil.addClickHandler(self._petGroupList[i].btnAdd, GameUtil.handler(self._onClickPet, self, i))
	end

	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCanecel, self.close, self)
	GameUtil.addClickHandler(self._btnRandom, self._onClickRandom, self)
end

function PetCardLotterySelectView:buildUI()
	PetCardLotterySelectView.super.buildUI(self)

	self._petGroupList = {}

	for i = 1, 5 do
		local cell = {}

		cell.btnAdd = self:getBtn("petGroup/headCell_" .. i)
		cell.empty = self:getGo("petGroup/headCell_" .. i .. "/empty")
		cell.head = self:getGo("petGroup/headCell_" .. i .. "/head")
		cell.select = self:getGo("petGroup/headCell_" .. i .. "/select")

		table.insert(self._petGroupList, cell)
	end

	self._btnSure = self:getBtn("btnSure")
	self._btnCanecel = self:getBtn("btnCancel")
	self._btnRandom = self:getBtn("btnRandom")
	self._tableviewGo = self:getGo("tableview")
	self._tableviewScroll = self:getScrollRect("tableview")
	self._card = self:getGo("card")
	self._tableView = ScrollerList.create(self._tableviewGo, self._card, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PetCardLotterySelectView:onExit()
	PetCardLotterySelectView.super.onExit(self)
	self._tableView:dispose()

	self._selectedPetIds = {
		0,
		0,
		0,
		0,
		0
	}
	self._curSelectPetId = 1
	self._curSelectCardId = 0
end

function PetCardLotterySelectView:onEnter()
	PetCardLotterySelectView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.PetCardLottery)
	self._cardCfg = PetCardLotteryConfig.instance:getCardCfg(self._activityId)
	self._selectedPetIds = {
		0,
		0,
		0,
		0,
		0
	}
	self._curSelectPetId = 1
	self._curSelectCardId = 0
	self._isBreakAutoSelect = false
	self._petGroupCount = #self._petGroupList

	for i = 1, self._petGroupCount do
		GameUtil.SetActive(self._petGroupList[i].select, i == self._curSelectPetId)
		GameUtil.SetActive(self._petGroupList[i].head, false)
		GameUtil.SetActive(self._petGroupList[i].empty, true)
	end

	self._tableView:reloadData(self._cardCfg)

	self._tableviewScroll.scrollRect.horizontalNormalizedPosition = 0
end

function PetCardLotterySelectView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "con")
	local select = goutil.findChild(cell, "select")

	GameUtil.SetActive(select, false)
	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getEmojiUrl("2zhounian", data.icon))

	self._curSelectId = data.id

	for _, id in ipairs(self._selectedPetIds) do
		if data.id == id then
			GameUtil.SetActive(select, true)
		end
	end

	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCard, self, data.id))
end

function PetCardLotterySelectView:_clearCell(cell)
	local icon = goutil.findChild(cell, "con")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(cell)
end

function PetCardLotterySelectView:_onClickPet(i)
	self._isBreakAutoSelect = true

	self:_setPetId(i)
end

function PetCardLotterySelectView:_setPetId(i)
	if i == self._curSelectPetId then
		return
	end

	GameUtil.SetActive(self._petGroupList[self._curSelectPetId].select, false)
	GameUtil.SetActive(self._petGroupList[i].select, true)

	self._curSelectPetId = i
end

function PetCardLotterySelectView:_onClickCard(cardId)
	local petId = self._selectedPetIds[self._curSelectPetId]

	if self:_isSelectedId(cardId) and cardId ~= petId then
		FloatWordMgr.instance:show("已经选过这个了，选另一个吧~")

		return
	end

	self._curSelectCardId = cardId

	if petId == 0 or petId ~= cardId then
		self:_updatePetById(self._curSelectPetId, cardId)

		if self._curSelectPetId < 5 then
			if not self._isBreakAutoSelect then
				self:_setPetId(self._curSelectPetId + 1)
			end
		else
			self._isBreakAutoSelect = true
		end
	else
		self._selectedPetIds[self._curSelectPetId] = 0

		GameUtil.SetActive(self._petGroupList[self._curSelectPetId].head, false)
		GameUtil.SetActive(self._petGroupList[self._curSelectPetId].empty, true)
	end

	self._tableView:refresh()
end

function PetCardLotterySelectView:_isSelectedId(i)
	return TableUtil.isHad(self._selectedPetIds, i)
end

function PetCardLotterySelectView:_updatePetById(petId, cardId)
	self._selectedPetIds[petId] = cardId

	GameUtil.SetActive(self._petGroupList[petId].empty, false)
	uGuiUtil.setSpriteToImage(self._petGroupList[petId].head, uGuiUtil.SpriteType.BigBg, GameUrl.getEmojiUrl("2zhounian", self._cardCfg[cardId].icon))
	GameUtil.SetActive(self._petGroupList[petId].head, true)
end

function PetCardLotterySelectView:_onClickSure()
	if self:_isSelectedId(0) then
		FloatWordMgr.instance:show("精灵未全部选择哦")

		return
	end

	local content = langPara("text_pet_lottery_desc_1")

	local function okFunc()
		PetCardLotteryController.instance:sendPM_PetCardLotterySelectCardReq(self._activityId, self._selectedPetIds)
		self:close()
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), content, okFunc, nil, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
end

function PetCardLotterySelectView:_onClickRandom()
	self._isBreakAutoSelect = true

	math.randomseed(tostring(ServerTime.nowMs()):reverse():sub(1, math.random(1, 7)))

	local allCardIds = PetCardLotteryConfig.instance:getCardId(self._activityId)
	local cardCount = #allCardIds
	local randomPetIds = {}

	while #randomPetIds < 5 do
		local petId = allCardIds[math.random(1, cardCount)]

		if not TableUtil.isHad(randomPetIds, petId) then
			table.insert(randomPetIds, petId)
		end
	end

	self._selectedPetIds = randomPetIds

	self:_updatePetIds()
end

function PetCardLotterySelectView:_updatePetIds()
	for petId = 1, self._petGroupCount do
		self:_updatePetById(petId, self._selectedPetIds[petId])
	end

	self._tableView:refresh()
end

return PetCardLotterySelectView
