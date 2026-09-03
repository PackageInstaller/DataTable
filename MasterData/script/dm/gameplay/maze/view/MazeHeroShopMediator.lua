-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeHeroShopMediator.lua

MazeHeroShopMediator = class("MazeHeroShopMediator", DmPopupViewMediator, _M)

MazeHeroShopMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	exitbtn = "onClickExit"
}

function MazeHeroShopMediator:initialize()
	super.initialize(self)
end

function MazeHeroShopMediator:dispose()
	super.dispose(self)
end

function MazeHeroShopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MazeHeroShopMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_HERO_SHOP_BUY_SUC, self, self.updateViews)
end

function MazeHeroShopMediator:dispose()
	super.dispose(self)
end

function MazeHeroShopMediator:enterWithData(data)
	self._model = data._model
	self._index = data._index
	self._heros = self._model:getHeroes()
	self._buyHeroId = ""

	self:initData()
	self:initViews()
end

function MazeHeroShopMediator:initData(data)
	return
end

function MazeHeroShopMediator:initViews()
	self._sucTitle = self:getView():getChildByFullName("buysuctitle")
	self._buyTitle = self:getView():getChildByFullName("Text_1")
	self._heroPanel = self:getView():getChildByFullName("heropanel")
	self._sucName = self:getView():getChildByFullName("sucpanel.name")
	self._sucLv = self:getView():getChildByFullName("sucpanel.lv")

	self._sucTitle:setVisible(false)
	self._sucName:setVisible(false)
	self._sucLv:setVisible(false)
	self:getView():getChildByFullName("heropanel"):removeAllChildren(false)

	local cell = self:getView():getChildByFullName("herocell")

	self._initPos = cc.p(self:getView():getChildByFullName("heropospanel.heropos"):getPosition())

	local num = 0

	for k, v in pairs(self._heros) do
		num = num + 1
	end

	if num == 2 then
		self._initPos = cc.p(self:getView():getChildByFullName("heropospanel.heropos_2"):getPosition())
	elseif num == 1 then
		self._initPos = cc.p(self:getView():getChildByFullName("heropospanel.heropos_1"):getPosition())
	end

	local count = 0

	for k, v in pairs(self._heros) do
		local cellview = cell:clone()
		local name = Strings:find(ConfigReader:getDataByNameIdAndKey("HeroBase", k, "Name"))

		cellview:getChildByFullName("heroname"):setString(name)
		cellview:getChildByFullName("select.btnname"):setString(v)
		cellview:setPosition(self._initPos.x + count * (cellview:getContentSize().width + 10), self._initPos.y)

		local node = cellview:getChildByFullName("Panel_10")
		local aninnode = self._mazeSystem:createOneMasterAni(k, false, true)

		aninnode:setGray(false)
		aninnode:setPosition(0, 0)
		aninnode:setScale(0.7)
		node:addChild(aninnode)

		local level = ConfigReader:getDataByNameIdAndKey("PansLabAttr", self._model._heroAttrId, "Level")

		cellview:getChildByFullName("lv"):setString("Lv." .. level)

		count = count + 1

		local rarity = cellview:getChildByFullName("rarity")

		rarity:loadTexture(GameStyle:getHeroRarityImage(ConfigReader:getDataByNameIdAndKey("HeroBase", k, "Rareity")), 1)
		rarity:ignoreContentAdaptWithSize(true)

		local butbtn = cellview:getChildByFullName("select")

		butbtn:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self._sucName:setString(name)
				self._sucLv:setString("Lv." .. level)
				self:onClickBuyHero(k, v)
			end
		end)
		self:getView():getChildByFullName("heropanel"):addChild(cellview)
	end
end

function MazeHeroShopMediator:updateViews()
	self._sucTitle:setVisible(true)
	self._buyTitle:setVisible(false)
	self._heroPanel:setVisible(false)
	self._sucName:setVisible(true)
	self._sucLv:setVisible(true)

	local node = self:getView():getChildByFullName("sucpanel.Node_5")
	local aninnode = self._mazeSystem:createOneMasterAni(self._buyHeroId, false, true)

	aninnode:setGray(false)
	aninnode:setPosition(0, 0)
	node:addChild(aninnode)
	self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
	print("剩余页签数量--->", self._mazeSystem:getChapter():getOptionsCount())
end

function MazeHeroShopMediator:onClickBuyHero(buyid, price)
	if self:checkMoney(price) then
		-- block empty
	else
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("MAZE_GOLD_NOT_ENOUGH")
		}))

		return
	end

	local data = {
		removeId = "",
		buyId = buyid
	}
	local cjson = require("cjson.safe")
	local paramsData = cjson.encode(data)

	self._buyHeroId = buyid

	if self._mazeSystem:checkTeamHeroLimit() then
		self._mazeSystem:enterTeamView({
			replace = true,
			buyId = buyid,
			index = self._index,
			eventName = EVT_MAZE_HERO_SHOP_BUY_SUC
		})
	else
		self._mazeSystem:setOptionEventName(EVT_MAZE_HERO_SHOP_BUY_SUC)
		self._mazeSystem:requestMazestStartOption(self._index, paramsData)
	end
end

function MazeHeroShopMediator:replaceHero(buyid, replaceid)
	return
end

function MazeHeroShopMediator:checkMoney(needmoney)
	local havemoney = self._mazeSystem._mazeChapter:getGold()

	return needmoney <= havemoney
end

function MazeHeroShopMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:close()
	end
end
