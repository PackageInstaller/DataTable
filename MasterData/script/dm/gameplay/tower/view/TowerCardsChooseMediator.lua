-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerCardsChooseMediator.lua

TowerCardsChooseMediator = class("TowerCardsChooseMediator", DmAreaViewMediator, _M)

TowerCardsChooseMediator:has("_towerSystem", {
	is = "rw"
}):injectWith("TowerSystem")

local kBtnHandlers = {
	["main.team_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onTeamClick"
	},
	["main.list_panel.card_1"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onCardClick"
	},
	["main.list_panel.card_2"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onCardClick"
	},
	["main.list_panel.card_3"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onCardClick"
	},
	["main.info_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onCardsRuleClick"
	},
	["main.list_panel.card_1.seek.btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onCardDetailClick"
	},
	["main.list_panel.card_2.seek.btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onCardDetailClick"
	},
	["main.list_panel.card_3.seek.btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onCardDetailClick"
	}
}
local kRoleRarityAnim = {
	[12] = {
		"r_choukajieguokapai",
		0.6,
		"img_chouka_new_r.png"
	},
	[13] = {
		"sr_choukajieguokapai",
		0.66,
		"img_chouka_new_sr.png"
	},
	[14] = {
		"ssr_choukajieguokapai",
		0.78,
		"img_chouka_new_ssr.png"
	},
	[15] = {
		"sp_choukajieguokapai",
		0.741,
		"img_chouka_new_sp.png"
	}
}
local kRoleRarityNameBg = {
	[12] = "asset/heroRect/heroRarity/img_chouka_front_r.png",
	[15] = "asset/heroRect/heroRarity/img_chouka_front_sp.png",
	[13] = "asset/heroRect/heroRarity/img_chouka_front_sr.png",
	[14] = "asset/heroRect/heroRarity/img_chouka_front_ssr.png"
}

function TowerCardsChooseMediator:initialize()
	super.initialize(self)
end

function TowerCardsChooseMediator:dispose()
	super.dispose(self)
end

function TowerCardsChooseMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function TowerCardsChooseMediator:enterWithData(data)
	self:initData(data)
	self:initNode()
	self:setupTopInfo()
	self:initContent()
	self:setupCards(#self._chooseHeros)
	self:setupCardChooseNum()
end

function TowerCardsChooseMediator:initData(data)
	self._cards = data.cards
	self._cardsNum = 0

	for _, v in pairs(self._cards) do
		self._cardsNum = self._cardsNum + 1
	end

	self._chooseHeros = {}
	self._curChooseIndex = 0
end

function TowerCardsChooseMediator:initNode()
	self._main = self:getView():getChildByFullName("main")
	self._cardNum = self._main:getChildByFullName("num_node.num")

	GameStyle:setCommonOutlineEffect(self:getView():getChildByFullName("main.title.name"))
end

function TowerCardsChooseMediator:setupTopInfo()
	local topInfoNode = self._main:getChildByName("top_info")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		title = self._towerSystem:getCurTowerName(),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	local num = string.len(self._towerSystem:getCurTowerName())

	self._main:getChildByName("info_btn"):setPositionX(80 * num / 3)
end

function TowerCardsChooseMediator:initContent()
	self._buffListView = {}
	self._buffListView[1] = self._main:getChildByFullName("list_panel.card_1.baseNode")
	self._buffListView[2] = self._main:getChildByFullName("list_panel.card_2.baseNode")
	self._buffListView[3] = self._main:getChildByFullName("list_panel.card_3.baseNode")

	local teamName = self._main:getChildByFullName("team_btn.name")
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(211, 220, 252, 255)
		}
	}

	teamName:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	teamName:enableOutline(cc.c4b(28, 18, 38, 153), 1)
end

function TowerCardsChooseMediator:setupCards()
	if self._curChooseIndex >= self._cardsNum then
		return
	end

	local cards = self._cards[tostring(self._curChooseIndex)]
	local index = 1

	for k, v in pairs(cards) do
		self:setupCardById(self._buffListView[index], v:getId())

		index = index + 1
	end
end

function TowerCardsChooseMediator:setupCardById(node, cardId)
	local heroConfig = ConfigReader:getRecordById("HeroBase", cardId)
	local rarityAnimName = kRoleRarityAnim[heroConfig.Rareity][1]

	node:getChildByFullName("bg"):removeAllChildren()

	local anim = cc.MovieClip:create(rarityAnimName)

	anim:addTo(node:getChildByFullName("bg")):center(node:getChildByFullName("bg"):getContentSize()):offset(-3, 88)

	local nameBg = node:getChildByFullName("nameBg")

	nameBg:loadTexture(kRoleRarityNameBg[heroConfig.Rareity])

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", cardId)
	local roleAnim = anim:getChildByFullName("roleAnim")
	local roleNode = roleAnim:getChildByFullName("roleNode")
	local realImage = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe7_1",
		id = roleModel
	})

	realImage:addTo(roleNode)

	local name = node:getChildByFullName("name")

	name:setString(Strings:get(heroConfig.Name))

	local rarityNode = node:getChildByFullName("rarity")

	rarityNode:loadTexture(GameStyle:getHeroRarityImage(heroConfig.Rareity), 1)
	rarityNode:ignoreContentAdaptWithSize(true)

	local occupationNode = node:getChildByFullName("occupation")
	local occupationName, occupationImg = GameStyle:getHeroOccupation(heroConfig.Type)

	occupationNode:loadTexture(occupationImg)
	node:getChildByFullName("cost_node.cost"):setString(tostring(heroConfig.Cost))
	node:getChildByFullName("has"):setVisible(self._towerSystem:hasHero(cardId))
end

function TowerCardsChooseMediator:setupCardChooseNum()
	self._cardNum:setString(Strings:get("Tower_Surplus_Choice") .. "    " .. tostring(self._cardsNum - #self._chooseHeros) .. "/" .. tostring(self._cardsNum))
end

local CardsNodeTag = {
	"384",
	"391",
	"398"
}

function TowerCardsChooseMediator:onCardClick(sender)
	local tag = sender:getTag()

	for i = 1, #CardsNodeTag do
		if CardsNodeTag[i] == tostring(tag) then
			local card = self._cards[tostring(self._curChooseIndex)][i]

			self:onCardChoose(card:getId())
		end
	end
end

local CardsDetailNodeTag = {
	"4452",
	"4453",
	"4454"
}

function TowerCardsChooseMediator:onCardDetailClick(sender)
	local tag = sender:getTag()

	for i = 1, #CardsDetailNodeTag do
		if CardsDetailNodeTag[i] == tostring(tag) then
			local card = self._cards[tostring(self._curChooseIndex)][i]

			self._towerSystem:showHeroDetailsViewWithData(card)
		end
	end
end

function TowerCardsChooseMediator:onTeamClick()
	self._towerSystem:showTowerTeamBattleView()
end

function TowerCardsChooseMediator:leaveWithData()
	self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, {
		viewName = "TowerMainView"
	}))
end

function TowerCardsChooseMediator:onClickBack()
	self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, {
		viewName = "TowerMainView"
	}))
end

function TowerCardsChooseMediator:onCardChoose(cardId)
	table.insert(self._chooseHeros, cardId)

	self._curChooseIndex = #self._chooseHeros

	self:setupCards()
	self:setupCardChooseNum()

	if self._cardsNum == #self._chooseHeros then
		local towerId = self._towerSystem:getCurTowerId()

		self._towerSystem:requestSelectPointCard(towerId, self._chooseHeros, function()
			self._towerSystem:showTowerPointView(towerId)
		end)
	end
end

function TowerCardsChooseMediator:onCardsRuleClick()
	local cardKey = "Tower_1_RuleText"
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", cardKey, "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule,
		ruleReplaceInfo = {
			time = TimeUtil:getSystemResetDate()
		}
	}))
end
