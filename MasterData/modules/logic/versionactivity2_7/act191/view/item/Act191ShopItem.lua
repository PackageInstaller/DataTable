-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191ShopItem.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191ShopItem", package.seeall)

local Act191ShopItem = class("Act191ShopItem", LuaCompBase)

function Act191ShopItem:ctor(_shopView)
	self.shopView = _shopView
end

function Act191ShopItem:init(go)
	self.go = go
	self.anim = go:GetComponent(gohelper.Type_Animator)
	self.type1 = gohelper.findChild(go, "type1")
	self.type2 = gohelper.findChild(go, "type2")
	self.type3 = gohelper.findChild(go, "type3")
	self.txtCost = gohelper.findChildText(go, "cost/txt_Cost")
	self.goSoldOut = gohelper.findChild(go, "go_SellOut")
	self.goMax = gohelper.findChild(go, "go_Max")
	self.goUp = gohelper.findChild(go, "go_Up")
	self.goSelect = gohelper.findChild(go, "go_Select")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")
	self.headItemList = {}

	local param = {
		noClick = true,
		noFetter = true
	}

	for i = 1, 4 do
		if i == 1 then
			if not self.type1 then
				local typeGo = self.type2
				local searchIndex = i == 1 and i or i - 1
				local roleGo = gohelper.findChild(typeGo, "role" .. searchIndex)
				local headGo = self.shopView:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, roleGo)

				self.headItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(headGo, Act191HeroHeadItem, param)
			end
		end
	end

	self.simageCollection = gohelper.findChildSingleImage(go, "type3/collectionicon")
	self.goTag1 = gohelper.findChild(go, "type3/go_Tag1")
	self.txtTag1 = gohelper.findChildText(go, "type3/go_Tag1/txt_Tag1")
	self.goTag2 = gohelper.findChild(go, "type3/go_Tag2")
	self.txtTag2 = gohelper.findChildText(go, "type3/go_Tag2/txt_Tag2")
	self.goFetter = gohelper.findChild(go, "fetter/go_Fetter")
	self.fetterItemList = {}
	self.highLightGoList = self:getUserDataTb_()

	for i = 1, 3 do
		local fetterGo = gohelper.cloneInPlace(self.goFetter)
		local fetterItem = MonoHelper.addNoUpdateLuaComOnceToGo(fetterGo, Act191FetterIconItem)

		fetterItem:setExtraParam({
			fromView = "Act191ShopView"
		})

		self.fetterItemList[i] = fetterItem
		self.highLightGoList[i] = gohelper.findChild(fetterGo, "go_select")
	end
end

function Act191ShopItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClick, self)
end

function Act191ShopItem:setIndex(index)
	self.index = index
end

function Act191ShopItem:setData(shopPos, soldOut)
	self.maxMark = false
	self.expMark = false

	for i = 1, 3 do
		gohelper.setActive(self["type" .. i], false)
	end

	local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	self.bestTag = gameInfo:getBestFetterTag()
	self.soldOut = soldOut
	self.cost = shopPos.cost
	self.heroList = shopPos.heroList
	self.itemList = shopPos.itemList
	self.heroCnt = #self.heroList
	self.itemCnt = #self.itemList
	self.isHeroShop = self.heroCnt > 0

	if self.isHeroShop then
		if self.heroCnt == 1 then
			local id = self.heroList[1]

			self.headItemList[1]:setData(nil, id)

			if not self.soldOut then
				local heroId = self.headItemList[1].config.roleId
				local heroInfo = gameInfo:getHeroInfoInWarehouse(heroId, true)

				if heroInfo then
					self.maxMark = heroInfo.star == Activity191Enum.CharacterMaxStar
					self.expMark = heroInfo.star ~= Activity191Enum.CharacterMaxStar
				end
			end

			self:refreshFetter(self.headItemList[1].config)
			gohelper.setActive(self.type1, true)
		else
			self.headItemList[2]:setData(nil, self.heroList[1])
			self.headItemList[3]:setData(nil, self.heroList[2])
			self.headItemList[4]:setData(nil, self.heroList[3])
			self:refreshFetter(self.headItemList[2].config)
			gohelper.setActive(self.type2, true)
		end
	else
		local config = Activity191Config.instance:getCollectionCo(self.itemList[1])

		if config then
			self.simageCollection:LoadImage(ResUrl.getRougeSingleBgCollection(config.icon))
			gohelper.setActive(self.type3, true)

			if string.nilorempty(config.label) then
				gohelper.setActive(self.goTag1, false)
				gohelper.setActive(self.goTag2, false)
			else
				local labelList = string.split(config.label, "#")

				for i = 1, 2 do
					local str = labelList[i]

					self["txtTag" .. i].text = str

					gohelper.setActive(self["goTag" .. i], str)
				end
			end

			self:refreshFetter(config)
		end
	end

	if gameInfo.coin < self.cost then
		SLFramework.UGUI.GuiHelper.SetColor(self.txtCost, "#be4343")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self.txtCost, "#211f1f")
	end

	self.txtCost.text = self.cost

	gohelper.setActive(self.goMax, self.maxMark)
	gohelper.setActive(self.goUp, self.expMark)
	gohelper.setActive(self.goSoldOut, self.soldOut)
	gohelper.setActive(self.go, true)
end

function Act191ShopItem:refreshFetter(config)
	if string.nilorempty(config.tag) then
		for i = 1, 3 do
			gohelper.setActive(self.fetterItemList[i].go, false)
		end

		return
	end

	local tagArr = string.split(config.tag, "#")

	for i = 1, 3 do
		if tagArr[i] then
			self.fetterItemList[i]:setData(tagArr[i])

			if not self.soldOut and self.bestTag and self.bestTag == tagArr[i] then
				gohelper.setActive(self.highLightGoList[i], true)
			else
				gohelper.setActive(self.highLightGoList[i], false)
			end
		end

		gohelper.setActive(self.fetterItemList[i].go, i <= #tagArr)
	end
end

function Act191ShopItem:onClick()
	if self.soldOut then
		return
	end

	local var_7_0 = {
		showBuy = true,
		index = self.index,
		cost = self.cost
	}

	if self.expMark then
		var_7_0.toastId = ToastEnum.Act191LevelUp or ToastEnum.Act191BuyTip
	end

	local param = var_7_0

	if self.isHeroShop then
		param.heroList = self.heroList

		Activity191Controller.instance:openHeroTipView(param)
	else
		param.itemId = self.itemList[1]

		Activity191Controller.instance:openCollectionTipView(param)
	end

	local shopType = self.isHeroShop and "hero" or "other"

	Act191StatController.instance:statButtonClick("Act191ShopView", string.format("shopItem_%s_%s", shopType, self.index))
end

function Act191ShopItem:playFreshAnim()
	self.anim:Play("fresh", 0, 0)
end

return Act191ShopItem
