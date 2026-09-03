-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeHeroBoxMediator.lua

MazeHeroBoxMediator = class("MazeHeroBoxMediator", DmPopupViewMediator, _M)

MazeHeroBoxMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	exitbtn = "onClickExit"
}

function MazeHeroBoxMediator:initialize()
	super.initialize(self)
end

function MazeHeroBoxMediator:dispose()
	super.dispose(self)
end

function MazeHeroBoxMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MazeHeroBoxMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_HERO_BOX_UPDATE_SUC, self, self.refeshViews)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_HERO_BOX_OPTION_SUC, self, self.refeshSelect)
end

function MazeHeroBoxMediator:dispose()
	super.dispose(self)
end

function MazeHeroBoxMediator:enterWithData(data)
	self._model = data._model
	self._index = data._index
	self._heroBoxList = self._model:isCanRefesh() and self._model:getFirstHero() or self._model:getHeroList()
	self._selectTreasureId = ""

	self:initData()
	self:updateViews()
end

function MazeHeroBoxMediator:initData()
	return
end

function MazeHeroBoxMediator:updateViews()
	local cell = self:getView():getChildByFullName("cellclone")

	self._initPos = cc.p(self:getView():getChildByFullName("heropospanel.heropos"):getPosition())

	local num = 0

	for k, v in pairs(self._heroBoxList) do
		num = num + 1
	end

	if num == 2 then
		self._initPos = cc.p(self:getView():getChildByFullName("heropospanel.heropos_2"):getPosition())
	elseif num == 1 then
		self._initPos = cc.p(self:getView():getChildByFullName("heropospanel.heropos_1"):getPosition())
	end

	local count = 0

	for k, v in pairs(self._heroBoxList) do
		local cellview = cell:clone()

		cellview:getChildByFullName("select"):setVisible(not self._model:isRefeshType())
		cellview:getChildByFullName("selects"):setVisible(self._model:isRefeshType())
		cellview:getChildByFullName("refeshs"):setVisible(self._model:isCanRefesh())
		cellview:getChildByFullName("heroname"):setString(self._model:getNameByHeroId(v.id))
		cellview:getChildByFullName("lv"):setString(self._model:getLvByHeroId(v.subId))
		cellview:getChildByFullName("rarity"):loadTexture(GameStyle:getHeroRarityImage(ConfigReader:getDataByNameIdAndKey("HeroBase", v.id, "Rareity")), 1)
		cellview:getChildByFullName("rarity"):ignoreContentAdaptWithSize(true)

		local node = cellview:getChildByFullName("Panel_10")

		node:removeAllChildren()

		local aninnode = self._mazeSystem:createOneMasterAni(v.id, false, true)

		aninnode:setGray(false)
		aninnode:setPosition(0, 0)
		aninnode:setScale(0.7)
		node:addChild(aninnode)
		cellview:setPosition(self._initPos.x + count * (cellview:getContentSize().width + 20), self._initPos.y)

		if self._model:isRefeshType() and not self._model:isCanRefesh() then
			cellview:getChildByFullName("selects"):setPosition(cc.p(cellview:getChildByFullName("select"):getPosition()))
		end

		count = count + 1

		cellview:getChildByFullName("select"):addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickSelectHero(v.id)
			end
		end)

		local butbtn = cellview:getChildByFullName("selects")

		butbtn:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickUpdateSelectHero(v.id)
			end
		end)

		local refeshbtn = cellview:getChildByFullName("refeshs")

		refeshbtn:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickrefeshHero(v.id)
			end
		end)

		if self._model:isRefeshType() then
			self:getView():getChildByFullName("heropanel"):removeAllChildren()
		end

		self:getView():getChildByFullName("heropanel"):addChild(cellview)
		cellview:setTag(count)
	end
end

function MazeHeroBoxMediator:refeshSelect(response)
	self:showHeroGetAni(response)
	self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
end

function MazeHeroBoxMediator:showHeroGetAni(response)
	local heroselect = self:getView():getChildByFullName("heropanel")

	heroselect:setVisible(false)

	local animNode = self:getView():getChildByFullName("sucpanel")

	animNode:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:close()
		end
	end)
	animNode:setVisible(true)

	local anim = cc.MovieClip:create("zonghe_gongxihuode")

	anim:setPlaySpeed(1.5)
	anim:addTo(animNode, 1)
	anim:setPosition(animNode:getContentSize().width * 0.5, animNode:getContentSize().height * 0.5)
	anim:addCallbackAtFrame(60, function()
		anim:stop()
		anim:gotoAndPlay(45)
	end)
	anim:addCallbackAtFrame(10, function()
		local title = anim:getChildByName("title")
		local titleNode = title:getChildByName("node")
		local image = cc.Sprite:create(ASSET_LANG_COMMON .. "rewordText.png")

		image:addTo(titleNode)
		title:addCallbackAtFrame(12, function()
			title:stop()
		end)
	end)
	anim:addCallbackAtFrame(21, function()
		self:showHero(response)
	end)

	self._anim = anim
end

function MazeHeroBoxMediator:showHero(response)
	local ani = self._mazeSystem:createOneMasterAni(self._selectTreasureId, true, true)

	ani:setGray(false)
	ani:setScale(0.7)

	local animNode = self:getView():getChildByFullName("sucpanel.Node_5")
	local name = self:getView():getChildByFullName("sucpanel.name")
	local lv = self:getView():getChildByFullName("sucpanel.lv")

	lv:setVisible(false)
	name:setString(self._model:getNameByHeroId(self._selectTreasureId))
	name:changeParent(self._anim)
	ani:setPosition(ani:getPositionX(), ani:getPositionY() - 30)
	name:setPosition(ani:getPositionX(), ani:getPositionY() - 50)
	name:setVisible(true)
	self._anim:addChild(ani)
end

function MazeHeroBoxMediator:refeshViews(response)
	local heropanel = self:getView():getChildByFullName("heropanel")

	for k, v in pairs(heropanel:getChildren()) do
		v:getChildByFullName("selects"):setVisible(false)
		v:getChildByFullName("refeshs"):setVisible(false)
		v:getChildByFullName("select"):setVisible(true)
		v:getChildByFullName("heroname"):setVisible(false)
		v:getChildByFullName("lv"):setVisible(false)
		v:getChildByFullName("Panel_10"):removeAllChildren()
	end

	self._model:setCanRefesh(false)

	self._heroBoxList = self._model:getFirstHero()

	self:updateViews()
end

function MazeHeroBoxMediator:checkHaveHero(heroid)
	local team = self._mazeSystem:getMazeTeam()

	for k, v in pairs(team._heroes) do
		if v.id == heroid then
			return false, v.uuid
		end
	end

	return false
end

function MazeHeroBoxMediator:onClickSelectHero(buyid)
	local have, uuid = self:checkHaveHero(buyid)

	if have then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("MAZE_HAVE_HERO")
		}))

		return
	end

	self._selectTreasureId = buyid

	if self._mazeSystem:checkTeamHeroLimit() then
		self._mazeSystem:enterTeamView({
			replace = true,
			buyId = buyid,
			index = self._index,
			eventName = EVT_MAZE_HERO_BOX_OPTION_SUC
		})

		return
	end

	local data = {
		removeId = "",
		buyId = buyid
	}
	local cjson = require("cjson.safe")
	local paramsData = cjson.encode(data)

	self._mazeSystem:setOptionEventName(EVT_MAZE_HERO_BOX_OPTION_SUC)
	self._mazeSystem:requestMazestStartOption(self._index, paramsData)
end

function MazeHeroBoxMediator:onClickUpdateSelectHero(buyid)
	local have, uuid = self:checkHaveHero(buyid)

	if have then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("MAZE_HAVE_HERO")
		}))

		return
	end

	self._selectTreasureId = buyid

	if self._mazeSystem:checkTeamHeroLimit() then
		self._mazeSystem:enterTeamView({
			optype = "buy",
			replace = true,
			buyId = buyid,
			index = self._index,
			eventName = EVT_MAZE_HERO_BOX_OPTION_SUC
		})

		return
	end

	local data = {
		removeId = "",
		type = "buy"
	}
	local cjson = require("cjson.safe")
	local paramsData = cjson.encode(data)

	self._mazeSystem:setOptionEventName(EVT_MAZE_HERO_BOX_OPTION_SUC)
	self._mazeSystem:requestMazestStartOption(self._index, paramsData)
end

function MazeHeroBoxMediator:onClickrefeshHero(refeshid)
	local data = {
		removeId = "",
		type = "refresh"
	}
	local cjson = require("cjson.safe")
	local paramsData = cjson.encode(data)

	self._selectTreasureId = buyid

	self._mazeSystem:setOptionEventName(EVT_MAZE_HERO_BOX_UPDATE_SUC)
	self._mazeSystem:requestMazestStartOption(self._index, paramsData)
end

function MazeHeroBoxMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:close()
	end
end
