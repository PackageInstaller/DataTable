-- chunkname: @modules/logic/partygame/view/whichmore/item/WhichMoreAnswerCardItem.lua

module("modules.logic.partygame.view.whichmore.item.WhichMoreAnswerCardItem", package.seeall)

local WhichMoreAnswerCardItem = class("WhichMoreAnswerCardItem", SimpleListItem)

function WhichMoreAnswerCardItem:onInit()
	self.imgCard = gohelper.findChildSingleImage(self.viewGO, "imgCard")
	self.imgCard2 = gohelper.findChildImage(self.viewGO, "imgCard")
	self.otherHead = gohelper.findChild(self.viewGO, "otherHead")
	self.select = gohelper.findChild(self.viewGO, "select")

	gohelper.setActive(self.select, false)

	self.WhichMoreGameInterface = PartyGameCSDefine.WhichMoreGameInterface
end

function WhichMoreAnswerCardItem:onItemShow(data)
	self.id = data.id
	self.resId = data.resId
	self.onClickFunc = data.onClickFunc
	self.context = data.context
	self.WhichMorePlayerHead = data.WhichMorePlayerHead

	local cfg = lua_partygame_whichmore_pictures.configDict[self.resId]

	self.imgCard:LoadImage(cfg.resource)
end

function WhichMoreAnswerCardItem:onSelectChange(isSelect)
	gohelper.setActive(self.select, isSelect)
end

function WhichMoreAnswerCardItem:frameTick(isShowAnswer)
	self.isShowAnswer = isShowAnswer

	local isRoundSettle = self.WhichMoreGameInterface.IsRoundSettle()

	if self.headList == nil then
		local scrollParam = SimpleListParam.New()

		scrollParam.cellClass = WhichMorePlayerHead
		self.headList = GameFacade.createSimpleListComp(self.otherHead, scrollParam, self.WhichMorePlayerHead, self.viewContainer)
	end

	local ownMo = PartyGameModel.instance:getMainPlayerMo()
	local isSelectSelf = false
	local datas = {}

	if self.isShowAnswer then
		local array = self.WhichMoreGameInterface.GetAnswerSelectPlayers(self.itemIndex)

		for i = 0, array.Length - 1 do
			local playerIndex = array[i]

			if playerIndex > 0 then
				local mo = PartyGameModel.instance:getPlayerMoByIndex(playerIndex)

				table.insert(datas, {
					isAutoShowArrow = true,
					uid = mo.uid
				})

				if playerIndex == ownMo.index then
					isSelectSelf = true
				end
			end
		end
	end

	self.headList:setData(datas)
	gohelper.setActive(self.select, not isRoundSettle and isSelectSelf)

	local alpha = 1

	if isRoundSettle then
		local correctAnswerId = PartyGameHelper.instance:getSingleComponentData("PartyGame.Runtime.Games.WhichMore.Component.WhichMoreCardProcessComponent", "correctAnswerId")

		if self.id ~= correctAnswerId then
			alpha = 0.5
		end
	end

	ZProj.UGUIHelper.SetColorAlpha(self.imgCard2, alpha)
end

return WhichMoreAnswerCardItem
