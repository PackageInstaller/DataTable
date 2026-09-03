-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroSoulDimondUpTipMediator.lua

HeroSoulDimondUpTipMediator = class("HeroSoulDimondUpTipMediator", DmPopupViewMediator, _M)

HeroSoulDimondUpTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.left_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickMin"
	},
	["main.right_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAdd"
	},
	["main.maxbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickMax"
	},
	["main.upbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickUp"
	}
}

function HeroSoulDimondUpTipMediator:initialize()
	super.initialize(self)
end

function HeroSoulDimondUpTipMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function HeroSoulDimondUpTipMediator:onRemove()
	super.onRemove(self)
end

function HeroSoulDimondUpTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function HeroSoulDimondUpTipMediator:enterWithData(data)
	self:initData(data)
	self:initNodes()
	self:refreshData()
	self:refreshView(data)
	self:refreshView()
end

function HeroSoulDimondUpTipMediator:initData(data)
	self._player = self._developSystem:getPlayer()
	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._heroId = data.heroId
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._soulList = self._heroData:getHeroSoulList():getSoulArray()
	self._soulData = self._soulList[data.index]
end

function HeroSoulDimondUpTipMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")

	local bgNode = self._mainPanel:getChildByFullName("tipnode")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("HeroSoul_UI10"),
		bgSize = {
			width = 698,
			height = 518
		}
	})

	self._costNode = self._mainPanel:getChildByFullName("costnode")
	self._minusBtn = self._mainPanel:getChildByFullName("left_btn")
	self._addbtn = self._mainPanel:getChildByFullName("right_btn")
	self._maxBtn = self._mainPanel:getChildByFullName("max_btn")

	local costIcon = IconFactory:createPic({
		id = CurrencyIdKind.kDiamond
	})

	costIcon:addTo(self._costNode)

	self._levelLabel = self._mainPanel:getChildByFullName("levellabel")
end

function HeroSoulDimondUpTipMediator:refreshData()
	self._minCount = 1
	self._curCount = 1
	self._maxCount = self._soulData:getUpgradeLevel() - self._soulData:getLevel()
	self._maxCount = math.max(self._maxCount, self._curCount)
end

function HeroSoulDimondUpTipMediator:refreshView(data)
	local targetLevel = self._soulData:getLevel() + self._curCount

	self._levelLabel:setString(targetLevel)
	self._minusBtn:setEnabled(self._curCount > 1)
	self._addbtn:setEnabled(self._curCount < self._soulData:getUpgradeLevel())
	self:refreshCostView()

	if not self._nameControl then
		self._nameControl = ccui.RichText:createWithXML("", {})

		self._nameControl:ignoreContentAdaptWithSize(true)
		self._nameControl:setAnchorPoint(cc.p(0.5, 0.5))
		self._nameControl:setPosition(cc.p(564, 380))
		self._mainPanel:addChild(self._nameControl, 999)
	end

	self._nameControl:setString(Strings:get("HeroSoul_UI4", {
		fontName = TTF_FONT_FZYH_R,
		name = self._soulData:getName(),
		level = self._soulData:getLevel()
	}))
end

function HeroSoulDimondUpTipMediator:getAddExp()
	local exp = -self._soulData:getExp()

	for i = 1, self._curCount do
		local curLevel = self._soulData:getLevel() + i - 1
		local nextExp = self._soulData:getNextLevelDiaCost(curLevel)

		exp = exp + nextExp
	end

	return exp
end

function HeroSoulDimondUpTipMediator:refreshCostView()
	local costNum = self:getAddExp()

	self._costNum = costNum

	local costLabel = self._costNode:getChildByFullName("numlabel")

	costLabel:setString(costNum)

	local isEngouh = costNum <= self._bagSystem:getDiamond()

	costLabel:setColor(GameStyle:getColor(isEngouh == true and 1 or 7))
end

function HeroSoulDimondUpTipMediator:onClickBack(sender, eventType)
	self:close()
end

function HeroSoulDimondUpTipMediator:onClickUp(sender, eventType)
	if not self._bagSystem:checkCostEnough(CurrencyIdKind.kDiamond, self._costNum, {
		type = "tip"
	}) then
		return
	end

	local targetLevel = self._soulData:getLevel() + self._curCount

	self._heroSystem:requestSoulUpByDiamond(self._heroId, self._soulData:getId(), targetLevel, function()
		self:close()
	end)
end

function HeroSoulDimondUpTipMediator:onClickMin(sender, eventType)
	if self._curCount <= 1 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Strenghten_Text73")
		}))

		return
	end

	self._curCount = self._curCount - 1

	self:refreshView()
end

function HeroSoulDimondUpTipMediator:onClickAdd(sender, eventType)
	if self._curCount >= self._maxCount then
		return
	end

	self._curCount = self._curCount + 1

	self:refreshView()
end

function HeroSoulDimondUpTipMediator:onClickMax(sender, eventType)
	self._curCount = self._maxCount

	self:refreshView()
end
