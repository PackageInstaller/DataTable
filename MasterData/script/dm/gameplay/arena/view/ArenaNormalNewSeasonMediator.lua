-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/view/ArenaNormalNewSeasonMediator.lua

ArenaNormalNewSeasonMediator = class("ArenaNormalNewSeasonMediator", DmPopupViewMediator, _M)

ArenaNormalNewSeasonMediator:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")

function ArenaNormalNewSeasonMediator:initialize()
	super.initialize(self)
end

function ArenaNormalNewSeasonMediator:dispose()
	super.dispose(self)
end

function ArenaNormalNewSeasonMediator:onRegister()
	super.onRegister(self)
	self:setViewUI()
end

function ArenaNormalNewSeasonMediator:setViewUI()
	self._main = self:getView():getChildByFullName("main")
	self._seasonLayout2 = self._main:getChildByFullName("seasonLayout2")
	self._seasonLayout1 = self._main:getChildByFullName("seasonLayout1")

	self._seasonLayout2:setVisible(false)
	self._seasonLayout1:setVisible(true)

	local timeLayout = self._seasonLayout1:getChildByFullName("timeLayout")
	local seasonTime = timeLayout:getChildByFullName("seasonTime")
	local buffName = self._seasonLayout2:getChildByFullName("buffName")
	local buffInfo = self._seasonLayout2:getChildByFullName("buffInfo")

	buffInfo:setString("")

	local seasonTitle = self._seasonLayout2:getChildByFullName("seasonTitle")
	local buffImg1 = self._seasonLayout2:getChildByFullName("buffImg1")
	local buffImg2 = buffImg1:getChildByFullName("buffImg2")
	local startTime, endTime = self._arenaSystem:getSeasonTime()

	seasonTime:setString(startTime .. "-" .. endTime)

	local seasonSkillData = self._arenaSystem:getCurSeasonSkillData()
	local arenaSeasonData = self._arenaSystem:getCurSeasonData()

	buffName:setString("")
	seasonTitle:setString(Strings:get(arenaSeasonData.SeasonTitle))
	buffImg2:loadTexture("asset/skillIcon/" .. seasonSkillData.Icon .. ".png", ccui.TextureResType.localType)

	local richText = ccui.RichText:createWithXML("", {})

	richText:setAnchorPoint(buffInfo:getAnchorPoint())
	richText:setPosition(cc.p(buffInfo:getPosition()))
	richText:addTo(buffInfo:getParent())

	local text = Strings:get(seasonSkillData.Desc, {
		fontSize = 20,
		fontName = TTF_FONT_FZYH_M
	})

	richText:setString(text)

	local animNode = self._seasonLayout1:getChildByFullName("animNode")
	local anim = cc.MovieClip:create("xinsaijikaiqi_xinsaijikaiqi")

	anim:addTo(animNode):posite(0, 0)

	local childs = anim:getChildren()
	local nodeToActionMap = {}

	nodeToActionMap[timeLayout] = anim:getChildByFullName("dongzuo")

	local startFunc2, stopFunc2 = CommonUtils.bindNodeToActionNode(nodeToActionMap, animNode, false)

	startFunc2()
	anim:addCallbackAtFrame(11, function()
		stopFunc2()
	end)
	anim:addCallbackAtFrame(55, function()
		anim:stop()
	end)

	local function callFunc2(sender, eventType)
		self:close()
	end

	mapButtonHandlerClick(nil, self._seasonLayout2, {
		func = callFunc2
	})

	local function callFunc1(sender, eventType)
		self:showSeasonLayout2()
	end

	mapButtonHandlerClick(nil, self._seasonLayout1, {
		func = callFunc1
	})
end

function ArenaNormalNewSeasonMediator:showSeasonLayout2()
	self._seasonLayout1:setVisible(false)
	self._seasonLayout2:setVisible(true)

	local animNode = self._seasonLayout2:getChildByFullName("animNode")
	local anim = cc.MovieClip:create("huodetishi_huodetishi")
	local blackBg = anim:getChildByFullName("blackBg")

	for i = 1, 39 do
		anim:addCallbackAtFrame(i, function()
			blackBg:setVisible(false)
		end)
	end

	anim:addTo(animNode):posite(0, 0)
	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)
	self._arenaSystem:setCurSeasonForIsShowView()
end
