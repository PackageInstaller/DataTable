-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeTreasureShopMediator.lua

MazeTreasureShopMediator = class("MazeTreasureShopMediator", DmPopupViewMediator, _M)

MazeTreasureShopMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	exitbtn = "onClickExit"
}

function MazeTreasureShopMediator:initialize()
	super.initialize(self)
end

function MazeTreasureShopMediator:dispose()
	super.dispose(self)
end

function MazeTreasureShopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MazeTreasureShopMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_TREASURE_BUY_SUC, self, self.updateViews)
end

function MazeTreasureShopMediator:dispose()
	super.dispose(self)
end

function MazeTreasureShopMediator:enterWithData(data)
	self._model = data._model
	self._index = data._index
	self._treasures = self._model:getItems()
	self._buyTreasureId = ""

	self:initData()
	self:initViews()
end

function MazeTreasureShopMediator:initData(data)
	return
end

function MazeTreasureShopMediator:initViews()
	self._sucTitle = self:getView():getChildByFullName("buysuctitle")
	self._buyTitle = self:getView():getChildByFullName("Text_1")
	self._heroPanel = self:getView():getChildByFullName("heropanel")
	self._treasurePanel = self:getView():getChildByFullName("sucpanel")
	self._sucName = self:getView():getChildByFullName("sucpanel.name")
	self._treasureImg = self:getView():getChildByFullName("sucpanel.Image_9")
	self._sucLv = self:getView():getChildByFullName("sucpanel.lv")

	self._sucTitle:setVisible(false)
	self._sucName:setVisible(false)
	self._sucLv:setVisible(false)
	self:getView():getChildByFullName("heropanel"):removeAllChildren(false)

	local cell = self:getView():getChildByFullName("cellclone")

	self._initPos = cc.p(self:getView():getChildByFullName("heropospanel.heropos"):getPosition())

	local num = 0

	for k, v in pairs(self._treasures) do
		num = num + 1
	end

	if num == 2 then
		self._initPos = cc.p(self:getView():getChildByFullName("heropospanel.heropos_2"):getPosition())
	elseif num == 1 then
		self._initPos = cc.p(self:getView():getChildByFullName("heropospanel.heropos_1"):getPosition())
	end

	local count = 0

	for k, v in pairs(self._treasures) do
		local cellview = cell:clone()

		cellview:setPosition(self._initPos.x + count * (cellview:getContentSize().width + 10), self._initPos.y)

		local configdata = ConfigReader:getRecordById("PansLabItem", v.id)

		cellview:getChildByFullName("name"):setString(Strings:find(configdata.Name))
		cellview:getChildByFullName("icon"):loadTexture("asset/mazeicon/" .. configdata.Icon .. ".png")
		cellview:getChildByFullName("select.btnname"):setString(v.value)
		cellview:getChildByFullName("select"):addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				self:onClickBuyTreasure(k, v.id)
			end
		end)

		local desc = self:getDesc(configdata)
		local descNode = cellview:getChildByFullName("desc")
		local oldtext = descNode:getChildByTag(666)

		descNode:setContentSize(212, 36)

		if oldtext then
			oldtext:removeFromParent(false)
		end

		if string.find(desc, "+") then
			local descs = string.split(desc, "+")
			local text = ccui.Text:create("+" .. descs[2], TTF_FONT_FZY3JW, 16)

			text:setColor(cc.c3b(170, 240, 20))
			text:setAnchorPoint(cc.p(0, 0))
			text:enableOutline(cc.c4b(35, 15, 5, 76.5), 2)
			descNode:setString(descs[1])

			local startPos = cc.p(descNode:getAutoRenderSize())
			local areasize = descNode:getTextAreaSize()

			descNode:setContentSize(descNode:getStringLength() * 18, math.ceil(descNode:getStringLength() / 13) * 19)
			text:setTag(666)
			text:setPosition(descNode:getStringLength() * 17, -2)
			descNode:addChild(text)
		else
			descNode:setString(self:getDesc(configdata))
		end

		count = count + 1

		cellview:getChildByFullName("use"):setVisible(configdata.IsUse == 1)
		self:getView():getChildByFullName("heropanel"):addChild(cellview)
	end
end

function MazeTreasureShopMediator:updateViews()
	self._sucTitle:setVisible(true)
	self._buyTitle:setVisible(false)
	self._heroPanel:setVisible(false)
	self._sucName:setVisible(true)

	local configdata = ConfigReader:getRecordById("PansLabItem", self._buyconfigId)

	self._sucName:setString(Strings:find(configdata.Name))
	self._treasureImg:loadTexture("asset/mazeicon/" .. configdata.Icon .. ".png")
	self._sucLv:setVisible(true)
	self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
	print("剩余页签数量--->", self._mazeSystem:getChapter():getOptionsCount())
end

function MazeTreasureShopMediator:onClickBuyTreasure(buyid, configid)
	local data = {
		buyId = buyid
	}
	local cjson = require("cjson.safe")
	local paramsData = cjson.encode(data)

	self._buyTreasureId = buyid
	self._buyconfigId = configid

	self._mazeSystem:setOptionEventName(EVT_MAZE_TREASURE_BUY_SUC)
	self._mazeSystem:requestMazestStartOption(self._index, paramsData)
end

function MazeTreasureShopMediator:getDesc(_config)
	local effectId = _config.SkillAttrEffect
	local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", _config.SkillAttrEffect)
	local level = 1

	if not effectConfig then
		return "no desc config"
	end

	local effectDesc = effectConfig.EffectDesc
	local descValue = Strings:get(effectDesc)
	local factorMap = ConfigReader:getRecordById("SkillAttrEffect", effectId)
	local t = TextTemplate:new(descValue)
	local funcMap = {
		linear = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1] + (level - 1) * value[2]
		end,
		fixed = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1]
		end,
		custom = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[level]
		end
	}

	return (t:stringify(factorMap, funcMap))
end

function MazeTreasureShopMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:close()
	end
end
