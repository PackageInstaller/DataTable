-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamHouse/view/DreamHouseDetailMediator.lua

DreamHouseDetailMediator = class("DreamHouseDetailMediator", DmAreaViewMediator, _M)

DreamHouseDetailMediator:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamHouseSystem")
DreamHouseDetailMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
DreamHouseDetailMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	["main.resetBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickResetBtn"
	},
	["main.pointDetail.topInfo.funcBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickGuide"
	},
	["main.infoBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickInfoBtn"
	}
}
local kPartyIcon = {
	BSNCT = "asset/heroRect/heroForm/sl_businiao.png",
	MNJH = "asset/heroRect/heroForm/sl_smzs.png",
	DWH = "asset/heroRect/heroForm/sl_dongwenhui.png",
	XD = "asset/heroRect/heroForm/sl_seed.png",
	UNKNOWN = "asset/heroRect/heroForm/sl_unknown.png",
	WNSXJ = "asset/heroRect/heroForm/sl_weinasi.png",
	SSZS = "asset/heroRect/heroForm/sl_shimengzhishe.png"
}
local kJobIcon = {
	Aoe = "asset/heroRect/heroOccupation/zy_fashi.png",
	Attack = "asset/heroRect/heroOccupation/zy_gongxi.png",
	Support = "asset/heroRect/heroOccupation/zy_fuzhu.png",
	Curse = "asset/heroRect/heroOccupation/zy_zhoushu.png",
	Defense = "asset/heroRect/heroOccupation/zy_shouhu.png",
	Summon = "asset/heroRect/heroOccupation/zy_zhaohuan.png",
	Cure = "asset/heroRect/heroOccupation/zy_zhiyu.png"
}
local kPointBtnPos = {
	{
		123.15,
		91.99
	},
	{
		35.91,
		90.8
	},
	{
		70.1,
		35
	}
}
local kPointTitleOutlineColor = {
	cc.c4b(0, 0, 0, 255),
	cc.c4b(61, 6, 161, 255),
	(cc.c4b(184, 41, 48, 255))
}

function DreamHouseDetailMediator:initialize()
	super.initialize(self)
end

function DreamHouseDetailMediator:dispose()
	super.dispose(self)
end

function DreamHouseDetailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_POINT_REWARD_REFRESH, self, self.refreshBox)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_POINT_REFRESH_NEXT, self, self.refreshNext)
end

function DreamHouseDetailMediator:enterWithData(data)
	self:initData(data)
	self:initWidget()
	self:setupTopView()

	if self._fromBattle then
		if not self._curPointIndex then
			local curIdx = self._mapData:getOpenPointIdx()

			self:refreshMapData(curIdx)
			self:setupBattleList()
			self:refreshBattleInfo()
			self:refreshPointInfo()
			self:initAnim()
		end
	end
end

function DreamHouseDetailMediator:initData(data)
	self._mapId = data.mapId
	self._mapData = self._dreamSystem:getMapById(self._mapId)
	self._pointIds = ConfigReader:getDataByNameIdAndKey("DreamHouseMap", self._mapId, "PointId")
	self._fromBattle = not not data.fromBattle

	if self._fromBattle then
		for i = 1, #self._pointIds do
			if self._pointIds[i] == data.pointId then
				self._curPointIndex = i
			end
		end
	end
end

function DreamHouseDetailMediator:refreshMapData(idx)
	self._curPointIndex = idx
	self._pointId = self._pointIds[self._curPointIndex]
	self._pointData = self._mapData:getPointById(self._pointId)
	self._battleIds = self._pointData:getBattleIds()
	self._battleId, self._curIndex = self._pointData:getLastBattleId()
end

function DreamHouseDetailMediator:initWidget()
	self._main = self:getView():getChildByName("main")
	self._battleList = self._main:getChildByName("pointList")
	self._battleCell = self:getView():getChildByName("pointCell")

	self._battleCell:setVisible(false)

	self._pointDetail = self._main:getChildByName("pointDetail")
	self._rewardCell = self:getView():getChildByName("rewardCell")
	self._enterBtnView = self._main:getChildByName("enterBtnView")

	self._main:getChildByFullName("mask"):setVisible(false)
	self._enterBtnView:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:onClickTeamBtn()
		end
	end)

	self._attrCell = self:getView():getChildByName("attrCell")
	self._attrInfoView = self:getView():getChildByName("fightInfoPanel")

	self._attrInfoView:setVisible(false)
	self._attrInfoView:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._attrInfoView:setVisible(false)
		end
	end)
	self._pointDetail:getChildByFullName("topInfo.fightBtn"):addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._attrInfoView:setVisible(true)
		end
	end)

	self._attrFightCell = self._attrInfoView:getChildByFullName("infoCell")

	self._attrFightCell:setVisible(false)

	self._attrList = self._attrInfoView:getChildByFullName("view.infoList")

	self._attrList:setScrollBarEnabled(false)

	self._pointBtns = {}
	self._pointBtns[1] = self._main:getChildByFullName("bottomView.point_1")
	self._pointBtns[2] = self._main:getChildByFullName("bottomView.point_2")
	self._pointBtns[3] = self._main:getChildByFullName("bottomView.point_3")

	local starReward1 = self._main:getChildByFullName("bottomView.starReward_1")
	local starReward2 = self._main:getChildByFullName("bottomView.starReward_2")
	local starReward3 = self._main:getChildByFullName("bottomView.starReward_3")

	self._starReward1 = starReward1
	self._starReward2 = starReward2
	self._starReward3 = starReward3
	self._xian = self._main:getChildByFullName("bottomView.xian")
	self._starBarDi = self._main:getChildByFullName("bottomView.starBarDi")

	starReward1:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._dreamSystem:enterDreamHouseStarReward(self._mapId, self._pointId, 1)
		end
	end)
	starReward2:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._dreamSystem:enterDreamHouseStarReward(self._mapId, self._pointId, 2)
		end
	end)
	starReward3:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._dreamSystem:enterDreamHouseStarReward(self._mapId, self._pointId, 3)
		end
	end)

	self._bgAnim = self._main:getChildByFullName("animNode")
	self._bottomBgAnim = self._main:getChildByFullName("bottomView.animNode")

	for i = 1, 3 do
		local btnView = self._pointBtns[i]

		btnView:setTag(i)
		btnView:addTouchEventListener(function(sender, eventType)
			self:onClickPoint(sender, eventType)
		end)
	end

	local ruleData = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", self._battleId, "SpecialRuleShow")
	local ruleBtn = self._main:getChildByFullName("pointDetail.topInfo.funcBtn")

	ruleBtn:setVisible(ruleData and #ruleData > 0)
end

function DreamHouseDetailMediator:initAnim()
	self._bgAnim:removeAllChildren()

	local enterBtn = self._main:getChildByFullName("enterBtnView")

	enterBtn:removeAllChildren()

	local mc = cc.MovieClip:create("xiangqingxunhuan_zhuxianguanka_UIjiaohudongxiao")

	mc:addCallbackAtFrame(30, function()
		mc:stop()
	end)
	mc:stop()
	mc:addTo(enterBtn):center(enterBtn:getContentSize())
	mc:setScale(0.8)
	mc:setLocalZOrder(100)

	local mainMc = cc.MovieClip:create("eff_ruchang_bumengguanStage")

	mainMc:setPosition(cc.p(568, 320))
	mainMc:addTo(self._bgAnim):offset(0, 0)

	local topInfoNode = self:getView():getChildByFullName("main.topinfo")
	local initX, initY = topInfoNode:getPosition()

	topInfoNode:setOpacity(0)
	topInfoNode:setPositionY(initY + 50)
	mainMc:addCallbackAtFrame(1, function(cid, mc)
		local fadeIn = cc.FadeIn:create(0.15)
		local moveTo = cc.MoveTo:create(0.15, cc.p(initX, initY))
		local spawn = cc.Spawn:create(fadeIn, moveTo)

		topInfoNode:runAction(spawn)
	end)

	local pointInfo = self:getView():getChildByFullName("main.pointInfo")

	pointInfo:setOpacity(0)
	pointInfo:setScale(1.2)

	local resetBtn = self:getView():getChildByFullName("main.resetBtn")

	resetBtn:setOpacity(0)
	resetBtn:setScale(1.2)
	mainMc:addCallbackAtFrame(4, function(cid, mc)
		local fadeIn = cc.FadeIn:create(0.15)
		local scaleTo = cc.ScaleTo:create(0.15, 1)
		local spawn = cc.Spawn:create(fadeIn, scaleTo)
		local spawn2 = spawn:clone()

		pointInfo:runAction(spawn)
		resetBtn:runAction(spawn2)
	end)

	local totalStar1 = self._pointData:getPointConfig().StarNum[1]
	local totalStar2 = self._pointData:getPointConfig().StarNum[2]
	local totalStar3 = self._pointData:getPointConfig().StarNum[3]

	self._starBarDi:setPositionX(-40)
	self._starReward1:setPositionX(211)
	self._starReward2:setPositionX(370)
	self._starReward3:setPositionX(520.5)
	self._xian:setPositionX(-133)

	local barDi = mainMc:getChildByFullName("rewards.barDi")
	local reward1 = mainMc:getChildByFullName("rewards.reward1")
	local reward2 = mainMc:getChildByFullName("rewards.reward2")
	local nodeToActionMap = {}

	nodeToActionMap[self._starBarDi] = barDi
	nodeToActionMap[self._starReward1] = reward1
	nodeToActionMap[self._starReward2] = reward2
	nodeToActionMap[self._starReward3] = mainMc:getChildByFullName("rewards.reward3")
	nodeToActionMap[self._xian] = mainMc:getChildByFullName("xian")

	local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, self._bgAnim)

	startFunc()

	local progressBar = self._main:getChildByFullName("bottomView.starBar")

	progressBar:setOpacity(0)
	self._pointBtns[1]:setPositionX(self._pointBtns[1]:getPositionX() - 160)
	self._pointBtns[2]:setPositionX(self._pointBtns[2]:getPositionX() - 160)
	self._pointBtns[3]:setPositionX(self._pointBtns[3]:getPositionX() - 160)
	self._pointBtns[1]:setOpacity(20)
	self._pointBtns[2]:setOpacity(20)
	self._pointBtns[3]:setOpacity(20)
	self._pointBtns[1]:setScale(0.8)
	self._pointBtns[2]:setScale(0.8)
	self._pointBtns[3]:setScale(0.8)
	self._pointBtns[1]:setVisible(false)
	self._pointBtns[2]:setVisible(false)
	self._pointBtns[3]:setVisible(false)
	mainMc:addCallbackAtFrame(4, function(cid, mc)
		for i = 1, 3 do
			self._pointBtns[i]:setVisible(true)

			local fadeIn = cc.FadeIn:create(0.2)
			local moveBy = cc.MoveBy:create(0.2, cc.p(160, 0))
			local scaleNum = 1

			if i == self._curPointIndex then
				scaleNum = 1.4
			end

			local scaleTo = cc.ScaleTo:create(0.2, scaleNum + 0.1)
			local spawn = cc.Spawn:create(fadeIn, moveBy, scaleTo)
			local scaleTo = cc.ScaleTo:create(0.1, scaleNum)

			self._pointBtns[i]:runAction(cc.Sequence:create(spawn, scaleTo))
		end
	end)
	mainMc:addCallbackAtFrame(10, function(cid, mc)
		progressBar:runAction(cc.FadeIn:create(0.15))
	end)
	mainMc:addCallbackAtFrame(25, function(cid, mc)
		mc:stop()
		stopFunc()
		self:checkPassViewShow()
	end)
end

function DreamHouseDetailMediator:setupTopView()
	local topInfoNode = self:getView():getChildByFullName("main.topinfo")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("DreamHouseUnlockParm")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		stopAnim = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("DreamHouse_Main_UI04")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
	self._main:getChildByName("infoBtn"):setPositionX(self._topInfoWidget:getTitleWidth() + 25)
end

function DreamHouseDetailMediator:setupBattleList()
	self._battleList:removeAllChildren()
	self._battleList:setScrollBarEnabled(false)

	for i = 1, #self._battleIds do
		local cell = self._battleCell:clone()

		cell:setVisible(true)
		self:setupBattleCell(cell, i)
		self._battleList:pushBackCustomItem(cell)
	end

	self._battleList:jumpToPercentVertical(self._curIndex / #self._battleIds * 100)
end

function DreamHouseDetailMediator:setupBattleCell(cell, idx)
	cell:setTag(idx)

	local di = cell:getChildByName("cellDi")

	di:loadTexture(self._pointData:getBattleDiSrc(), ccui.TextureResType.plistType)

	local battleId = self._battleIds[idx]
	local nameLab = cell:getChildByName("pointName")

	nameLab:setString(self._pointData:getBattleNameById(battleId))
	nameLab:enableOutline(kPointTitleOutlineColor[self._curPointIndex], 1)

	local headIcon = cell:getChildByFullName("head")

	headIcon:removeAllChildren()

	local masterId = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", battleId, "EnemyMaster")
	local roleId = ConfigReader:getDataByNameIdAndKey("EnemyMaster", masterId, "HeroShow")
	local model = IconFactory:getRoleModelByKey("HeroBase", roleId)
	local heroImg = IconFactory:createRoleIconSpriteNew({
		id = model
	})

	heroImg:setScale(0.36)
	heroImg:addTo(headIcon):center(headIcon:getContentSize()):offset(0, -3)

	local cellSelect = cell:getChildByName("cellSelect")

	cellSelect:setVisible(idx == self._curIndex)
	cell:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			local idx = tonumber(sender:getTag())

			if self._curIndex == idx then
				return
			end

			self._curIndex = idx

			for i = 1, #self._battleIds do
				local batCell = self._battleList:getChildByTag(i)

				batCell:getChildByName("cellSelect"):setVisible(i == self._curIndex)
			end

			self:refreshBattleInfo()
		end
	end)
	cell:getChildByName("star_1"):setVisible(false)
	cell:getChildByName("star_2"):setVisible(false)
	cell:getChildByName("star_3"):setVisible(false)

	local stars = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", battleId, "Star")
	local battleStarData = self._pointData:getPoints()[battleId]
	local starData = {}

	if battleStarData then
		starData = battleStarData.stars
	end

	if #stars == 1 then
		local star = cell:getChildByName("star_2")

		star:setVisible(true)
		star:getChildByFullName("on"):setVisible(false)

		for _, v in pairs(starData) do
			if v == 1 then
				star:getChildByFullName("on"):setVisible(true)
			end
		end
	else
		for i = 1, #stars do
			local star = cell:getChildByName("star_" .. i)

			star:setVisible(true)
			star:getChildByFullName("on"):setVisible(false)

			for _, v in pairs(starData) do
				if v == i then
					star:getChildByFullName("on"):setVisible(true)
				end
			end
		end
	end

	local lockImg = cell:getChildByFullName("mask")

	lockImg:setVisible(battleStarData == nil)
	cell:setOpacity(20)
	cell:setVisible(false)

	local function showCell()
		cell:setVisible(true)
	end

	local delay = cc.DelayTime:create(0.1 * idx)
	local fadeIn = cc.FadeIn:create(0.2)
	local moveBy = cc.MoveBy:create(0.2, cc.p(0, 25))
	local spawn = cc.Spawn:create(fadeIn, moveBy)
	local moveBy2 = cc.MoveBy:create(0.05, cc.p(0, -25))

	cell:runAction(cc.Sequence:create(delay, cc.CallFunc:create(showCell), spawn, moveBy2))
end

function DreamHouseDetailMediator:refreshBattleInfo()
	local battleId = self._battleIds[self._curIndex]
	local delayTime = 0
	local di = self._pointDetail:getChildByFullName("pointDi")

	di:loadTexture(self._pointData:getInfoDiSrc(), ccui.TextureResType.plistType)
	di:setOpacity(20)
	di:setScale(0.8)

	local fadeIn = cc.FadeIn:create(0.15)
	local scaleTo = cc.ScaleTo:create(0.15, 1.1)
	local spawn = cc.Spawn:create(fadeIn, scaleTo)
	local scaleTo2 = cc.ScaleTo:create(0.1, 1)

	di:stopAllActions()
	di:runAction(cc.Sequence:create(spawn, scaleTo2))

	local nameLab = self._pointDetail:getChildByFullName("topInfo.pointName")

	nameLab:setString(self._pointData:getPointName() .. "-" .. self._pointData:getBattleNameById(battleId))
	nameLab:enableOutline(kPointTitleOutlineColor[self._curPointIndex], 1)
	self._pointDetail:getChildByFullName("bottomInfo.Text_132"):enableOutline(kPointTitleOutlineColor[self._curPointIndex], 1)
	self._pointDetail:getChildByFullName("bottomInfo.Text_133"):enableOutline(kPointTitleOutlineColor[self._curPointIndex], 1)

	local battleDescStr = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", battleId, "BattleDes")
	local battleDescLab = self._pointDetail:getChildByFullName("topInfo.passDesc")

	battleDescLab:setString(Strings:get(battleDescStr))

	local fightLab = self._pointDetail:getChildByFullName("topInfo.fightNum.num")
	local fightNum = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", battleId, "RecommendStrength")

	fightLab:setString(tostring(fightNum))

	local fightNeed = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", battleId, "Need")

	self._attrList:removeAllChildren()

	for key, value in pairs(fightNeed) do
		local titleStr = ""
		local attrCell = self._attrFightCell:clone()

		attrCell:setVisible(true)
		attrCell:getChildByFullName("star"):setVisible(false)

		if key == "heroLevel" then
			titleStr = Strings:get("DreamHouse_Second_UI5")
		elseif key == "heroStar" then
			titleStr = Strings:get("DreamHouse_Second_UI6")

			attrCell:getChildByFullName("star"):setVisible(true)
		elseif key == "leadStage" then
			titleStr = Strings:get("DreamHouse_Second_UI8")
		elseif key == "equipLevel" then
			titleStr = Strings:get("DreamHouse_Second_UI7")
		end

		local titleLab = attrCell:getChildByFullName("titleLab")

		titleLab:setString(titleStr)

		local numLab = attrCell:getChildByFullName("numLab")

		numLab:setString(tostring(value))
		self._attrList:pushBackCustomItem(attrCell)
	end

	delayTime = delayTime + 0.05

	local topInfo = self._pointDetail:getChildByFullName("topInfo")

	topInfo:setVisible(false)
	topInfo:setOpacity(20)
	topInfo:setPositionX(40)

	local delay = cc.DelayTime:create(delayTime)
	local callfunc = cc.CallFunc:create(function()
		topInfo:setVisible(true)
	end)
	local fadeIn = cc.FadeIn:create(0.1)
	local moveBy = cc.MoveBy:create(0.1, cc.p(-50, 0))
	local spawn = cc.Spawn:create(fadeIn, moveBy)
	local moveBy2 = cc.MoveBy:create(0.05, cc.p(10, 0))

	topInfo:stopAllActions()
	topInfo:runAction(cc.Sequence:create(delay, callfunc, spawn, moveBy2))
	self._pointDetail:getChildByName("attr_1"):setVisible(false)
	self._pointDetail:getChildByName("attr_2"):setVisible(false)
	self._pointDetail:getChildByName("attr_3"):setVisible(false)

	local stars = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", battleId, "Star")
	local battleStarData = self._pointData:getPoints()[battleId]
	local starData = {}

	if battleStarData then
		starData = battleStarData.stars
	end

	if #stars == 1 then
		delayTime = delayTime + 0.05

		local starView = self._pointDetail:getChildByName("attr_2")

		starView:setVisible(true)
		starView:getChildByFullName("desc"):setString(self._dreamSystem:getPointStarDesc(stars[1]))
		starView:getChildByFullName("star.on"):setVisible(false)

		for _, v in pairs(starData) do
			if v == 1 then
				starView:getChildByFullName("star.on"):setVisible(true)
			end
		end

		starView:setVisible(false)
		starView:setOpacity(20)
		starView:setPositionX(270)

		local delay = cc.DelayTime:create(delayTime)
		local callfunc = cc.CallFunc:create(function()
			starView:setVisible(true)
		end)
		local fadeIn = cc.FadeIn:create(0.1)
		local moveBy = cc.MoveBy:create(0.1, cc.p(-30, 0))
		local spawn = cc.Spawn:create(fadeIn, moveBy)
		local moveBy2 = cc.MoveBy:create(0.05, cc.p(5, 0))

		starView:stopAllActions()
		starView:runAction(cc.Sequence:create(delay, callfunc, spawn, moveBy2))
	else
		for i = 1, #stars do
			delayTime = delayTime + 0.1 * i

			local starView = self._pointDetail:getChildByName("attr_" .. i)

			starView:setVisible(true)
			starView:getChildByFullName("star.on"):setVisible(false)

			for _, v in pairs(starData) do
				if v == i then
					starView:getChildByFullName("star.on"):setVisible(true)
				end
			end

			starView:getChildByFullName("desc"):setString(self._dreamSystem:getPointStarDesc(stars[i]))
			starView:setPositionX(starView:getPositionX() + 25)
			starView:setVisible(false)
			starView:setOpacity(20)
			starView:setPositionX(270)
			starView:stopAllActions()

			local delay = cc.DelayTime:create(delayTime)
			local callfunc = cc.CallFunc:create(function()
				starView:setVisible(true)
			end)
			local fadeIn = cc.FadeIn:create(0.1)
			local moveBy = cc.MoveBy:create(0.1, cc.p(-30, 0))
			local spawn = cc.Spawn:create(fadeIn, moveBy)
			local moveBy2 = cc.MoveBy:create(0.05, cc.p(5, 0))

			starView:runAction(cc.Sequence:create(delay, callfunc, spawn, moveBy2))
		end
	end

	local arrList = self._pointDetail:getChildByFullName("bottomInfo.attrAddList")

	arrList:removeAllChildren()
	arrList:setScrollBarEnabled(false)

	local titleArray = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroPartyName", "content")
	local campCond = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", battleId, "Camp")

	if campCond == nil then
		campCond = {}
	end

	for i = 1, #campCond do
		local key = campCond[i]
		local cell = self._attrCell:clone()
		local icon = cell:getChildByFullName("icon")
		local preStr = Strings:get("DreamHouse_TeamLimit_UI01", {
			team = Strings:get(titleArray[key])
		})

		icon:loadTexture(kPartyIcon[key])
		icon:setScale(0.7)

		local attackText = cell:getChildByFullName("desc")

		attackText:setString(preStr)
		arrList:pushBackCustomItem(cell)
	end

	local buffAdd = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", battleId, "BuffEffect")

	for k, v in pairs(buffAdd) do
		for key, value in pairs(v) do
			local cell = self._attrCell:clone()
			local skillId = value[1]
			local effectConfig = ConfigReader:getRecordById("Skill", skillId)

			if effectConfig then
				local icon = cell:getChildByFullName("icon")
				local iconSrc = ""
				local preStr = ""

				if k == "camp" then
					iconSrc = kPartyIcon[key]
					preStr = Strings:get(titleArray[key]) .. Strings:get("DreamHouse_Main_UI33")

					icon:loadTexture(kPartyIcon[key])
				elseif k == "profession" then
					iconSrc = kJobIcon[key]
					preStr = Strings:get(titleArray[key]) .. Strings:get("DreamHouse_Main_UI34")

					icon:loadTexture(kJobIcon[key])
				elseif k == "hero" then
					icon:removeAllChildren()

					iconSrc = "zb_bg_tx_1.png"

					local heroInfo = {
						id = IconFactory:getRoleModelByKey("HeroBase", key)
					}

					preStr = Strings:get(ConfigReader:getDataByNameIdAndKey("HeroBase", key, "Name"))

					local headImgName = IconFactory:createRoleIconSpriteNew(heroInfo)

					headImgName:setScale(0.2)

					headImgName = IconFactory:addStencilForIcon(headImgName, 2, cc.size(31, 31))

					headImgName:addTo(icon):center(icon:getContentSize())
					icon:loadTexture(iconSrc, ccui.TextureResType.plistType)
				end

				icon:setScale(0.7)

				local attackText = cell:getChildByFullName("desc")

				attackText:setString(preStr .. Strings:get(effectConfig.Desc_short))
				arrList:pushBackCustomItem(cell)
			end
		end
	end

	local rewardList = self._pointDetail:getChildByFullName("bottomInfo.rewardList")

	rewardList:removeAllChildren()
	rewardList:setScrollBarEnabled(false)

	local rewardId = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", battleId, "BattleReward")
	local rewards = RewardSystem:getRewardsById(rewardId)

	for i = 1, #rewards do
		local cell = self._rewardCell:clone()
		local rewardPanel = cell:getChildByFullName("icon")
		local icon = IconFactory:createRewardIcon(rewards[i], {
			showAmount = true,
			notShowQulity = false,
			isWidget = true
		})

		icon:setScaleNotCascade(0.5)
		icon:addTo(rewardPanel):center(rewardPanel:getContentSize()):offset(0, 0)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
			needDelay = true
		})
		rewardList:pushBackCustomItem(cell)

		local passBattles = self._pointData:getPassPoint()

		cell:getChildByFullName("mask"):setVisible(false)

		for _, v in pairs(passBattles) do
			if v == battleId then
				cell:getChildByFullName("mask"):setVisible(true)
			end
		end
	end

	delayTime = delayTime + 0.05

	local bottomInfo = self._pointDetail:getChildByName("bottomInfo")

	bottomInfo:setVisible(false)
	bottomInfo:setOpacity(20)
	bottomInfo:setPositionX(45)
	bottomInfo:stopAllActions()

	local delay = cc.DelayTime:create(delayTime)
	local callfunc = cc.CallFunc:create(function()
		bottomInfo:setVisible(true)
	end)
	local fadeIn = cc.FadeIn:create(0.1)
	local moveBy = cc.MoveBy:create(0.1, cc.p(-50, 0))
	local spawn = cc.Spawn:create(fadeIn, moveBy)
	local moveBy2 = cc.MoveBy:create(0.05, cc.p(5, 0))

	bottomInfo:runAction(cc.Sequence:create(delay, callfunc, spawn, moveBy2))

	delayTime = delayTime + 0.05

	self._enterBtnView:setGray(battleStarData == nil)
	self._enterBtnView:setOpacity(0)
	self._enterBtnView:setScale(0.4)
	self._enterBtnView:setVisible(false)
	self._enterBtnView:stopAllActions()

	local fadeIn = cc.FadeIn:create(0.1)
	local scaleTo = cc.ScaleTo:create(0.1, 1)
	local spawn = cc.Spawn:create(fadeIn, scaleTo)
	local delay = cc.DelayTime:create(delayTime)
	local callfunc = cc.CallFunc:create(function()
		self._enterBtnView:setVisible(not self._pointData:isCurrentPerfectPass())
	end)

	self._enterBtnView:runAction(cc.Sequence:create(delay, callfunc, spawn))
end

function DreamHouseDetailMediator:refreshPointInfo(runAction)
	local pattr = {
		0,
		24,
		60,
		100
	}
	local pattr2 = {
		24,
		36,
		40
	}
	local partIdx = 1

	for i = 1, 3 do
		local btnView = self._pointBtns[i]
		local pointBtn = btnView:getChildByFullName("Button")
		local pointName = btnView:getChildByFullName("Button.Text")
		local tmpPointId = self._pointIds[i]
		local tmpPointData = self._mapData:getPointById(tmpPointId)

		pointName:setString(tmpPointData:getPointName())
		btnView:setGray(not tmpPointData:getIsUnLock())

		local redpoint = btnView:getChildByFullName("redPoint")

		redpoint:setVisible(tmpPointData:isHasRedPoint())

		if self._pointData:getTotalStar() > self._pointData:getPointConfig().StarNum[i] then
			partIdx = i + 1
		end
	end

	local totalStar = self._pointData:getTotalStar()
	local starNum = self._pointData:getPointConfig().StarNum[partIdx - 1]
	local starNum

	if partIdx == 1 then
		starNum = 0
	end

	local curLeaveStar = (totalStar - starNum) / (self._pointData:getPointConfig().StarNum[partIdx] - starNum) * pattr2[partIdx]
	local percentNum = curLeaveStar + pattr[partIdx]
	local progressBar = self._main:getChildByFullName("bottomView.starBar")

	progressBar:setPercent(percentNum)

	local star1Num = self._main:getChildByFullName("bottomView.starReward_1.num")

	star1Num:setString(tostring(self._pointData:getPointConfig().StarNum[1]))

	local star2Num = self._main:getChildByFullName("bottomView.starReward_2.num")

	star2Num:setString(tostring(self._pointData:getPointConfig().StarNum[2]))

	local star3Num = self._main:getChildByFullName("bottomView.starReward_3.num")

	star3Num:setString(tostring(self._pointData:getPointConfig().StarNum[3]))

	local star1Red = self._main:getChildByFullName("bottomView.starReward_1.redpoint")

	star1Red:setVisible(self._pointData:getTotalStar() >= self._pointData:getPointConfig().StarNum[1] and not self._pointData:isBosRewarded(self._pointData:getPointConfig().StarNum[1]))

	local star2Red = self._main:getChildByFullName("bottomView.starReward_2.redpoint")

	star2Red:setVisible(self._pointData:getTotalStar() >= self._pointData:getPointConfig().StarNum[2] and not self._pointData:isBosRewarded(self._pointData:getPointConfig().StarNum[2]))

	local star3Red = self._main:getChildByFullName("bottomView.starReward_3.redpoint")

	star3Red:setVisible(self._pointData:getTotalStar() >= self._pointData:getPointConfig().StarNum[3] and not self._pointData:isBosRewarded(self._pointData:getPointConfig().StarNum[3]))

	local star1Mask = self._main:getChildByFullName("bottomView.starReward_1.mash")

	star1Mask:setVisible(self._pointData:isBosRewarded(self._pointData:getPointConfig().StarNum[1]))

	local star2Mask = self._main:getChildByFullName("bottomView.starReward_2.mash")

	star2Mask:setVisible(self._pointData:isBosRewarded(self._pointData:getPointConfig().StarNum[2]))

	local star3Mask = self._main:getChildByFullName("bottomView.starReward_3.mash")

	star3Mask:setVisible(self._pointData:isBosRewarded(self._pointData:getPointConfig().StarNum[3]))

	local item1 = self._main:getChildByFullName("bottomView.starReward_1.icon")

	item1:removeAllChildren()

	local rewardId1 = self._pointData:getPointConfig().StarReward[1]
	local rewardData1 = RewardSystem:getRewardsById(rewardId1)
	local icon = IconFactory:createRewardIcon(rewardData1[1], {
		showAmount = false,
		notShowQulity = true,
		isWidget = true
	})

	icon:setScaleNotCascade(0.6)
	icon:setLocalZOrder(999)
	icon:addTo(item1):center(item1:getContentSize()):offset(0, 0)

	local item2 = self._main:getChildByFullName("bottomView.starReward_2.icon")

	item2:removeAllChildren()

	local rewardId2 = self._pointData:getPointConfig().StarReward[2]
	local rewardData2 = RewardSystem:getRewardsById(rewardId2)
	local icon = IconFactory:createRewardIcon(rewardData2[1], {
		showAmount = false,
		notShowQulity = true,
		isWidget = true
	})

	icon:setScaleNotCascade(0.6)
	icon:setLocalZOrder(999)
	icon:addTo(item2):center(item2:getContentSize()):offset(0, 0)

	local item3 = self._main:getChildByFullName("bottomView.starReward_3.icon")

	item3:removeAllChildren()

	local rewardId3 = self._pointData:getPointConfig().StarReward[3]
	local rewardData3 = RewardSystem:getRewardsById(rewardId3)
	local icon = IconFactory:createRewardIcon(rewardData3[1], {
		showAmount = false,
		notShowQulity = true,
		isWidget = true
	})

	icon:setScaleNotCascade(0.6)
	icon:setLocalZOrder(999)
	icon:addTo(item3):center(item3:getContentSize()):offset(0, 0)

	if runAction then
		self._main:getChildByFullName("mask"):setVisible(true)
		self._bottomBgAnim:removeAllChildren()

		local animName = "eff_ZZmeng_zhuanhuan_bumengguanStage"
		local mainMc = cc.MovieClip:create(animName)

		mainMc:setPosition(cc.p(0, 0))
		mainMc:addTo(self._bottomBgAnim):offset(0, 0)

		local barDi = mainMc:getChildByFullName("barDi")
		local reward1 = mainMc:getChildByFullName("box1")
		local reward2 = mainMc:getChildByFullName("box2")
		local nodeToActionMap = {}

		nodeToActionMap[self._starBarDi] = barDi
		nodeToActionMap[self._starReward1] = reward1
		nodeToActionMap[self._starReward2] = reward2
		nodeToActionMap[self._starReward3] = mainMc:getChildByFullName("box3")
		nodeToActionMap[self._xian] = mainMc:getChildByFullName("xian")

		local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, self._bgAnim)

		startFunc()

		local progressBar = self._main:getChildByFullName("bottomView.starBar")

		progressBar:setOpacity(0)
		mainMc:addCallbackAtFrame(1, function(cid, mc)
			for i = 1, 3 do
				local moveIdx = (self._curPointIndex + i - 1) % 3

				if moveIdx == 0 then
					moveIdx = 3
				end

				local scaleNum = 1

				if self._curPointIndex == moveIdx then
					scaleNum = 1.5
				end

				local moveTo = cc.MoveTo:create(0.3, cc.p(kPointBtnPos[i][1], kPointBtnPos[i][2]))
				local scaleTo = cc.ScaleTo:create(0.3, scaleNum + 0.1)
				local spawn = cc.Spawn:create(moveTo, scaleTo)
				local easeInOut = cc.EaseInOut:create(spawn, 1)
				local scaleTo2 = cc.ScaleTo:create(0.1, scaleNum - 0.1)
				local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)

				self._pointBtns[moveIdx]:runAction(cc.Sequence:create(easeInOut, easeInOut1))
				self._pointBtns[moveIdx]:getChildByFullName("choooseKuang"):setVisible(self._curPointIndex == moveIdx)
			end
		end)
		mainMc:addCallbackAtFrame(15, function(cid, mc)
			progressBar:runAction(cc.FadeIn:create(0.15))
		end)
		mainMc:addEndCallback(function(cid, mc)
			self._starBarDi:setScale(1)
			self._main:getChildByFullName("mask"):setVisible(false)
			mc:stop()
		end)
	else
		for i = 1, 3 do
			local moveIdx = (self._curPointIndex + i - 1) % 3

			if moveIdx == 0 then
				moveIdx = 3
			end

			self._pointBtns[moveIdx]:setPosition(cc.p(kPointBtnPos[i][1], kPointBtnPos[i][2]))

			if self._curPointIndex == moveIdx then
				self._pointBtns[moveIdx]:setScale(1.5)
				self._pointBtns[moveIdx]:getChildByFullName("choooseKuang"):setVisible(true)
			else
				self._pointBtns[moveIdx]:setScale(1)
				self._pointBtns[moveIdx]:getChildByFullName("choooseKuang"):setVisible(false)
			end
		end
	end
end

function DreamHouseDetailMediator:refreshBox()
	self:refreshPointInfo()
end

function DreamHouseDetailMediator:refreshNext(event)
	local data = event:getData()
	local idx = 1

	for i = 1, #self._pointIds do
		if data.pointId == self._pointIds[i] then
			idx = i
		end
	end

	self:refreshMapData(idx)
	self:setupBattleList()
	self:refreshPointInfo()
	self:refreshBattleInfo()
end

function DreamHouseDetailMediator:checkPassViewShow()
	if self._pointData:isPass() then
		if self._pointData:isPerfectPass() then
			local key = self._mapId .. "@@" .. self._pointId .. "PerfectPass"

			if self:isSaved(key) then
				return
			end

			self._dreamSystem:enterDreamHousePass(self._mapId, self._pointId, key)

			return
		end

		local key = self._mapId .. "@@" .. self._pointId .. "Pass"

		if self:isSaved(self._mapId .. "@@" .. self._pointId .. "Pass") then
			return
		end

		self._dreamSystem:enterDreamHousePass(self._mapId, self._pointId, key)
	end
end

function DreamHouseDetailMediator:isSaved(pointId)
	if type(pointId) ~= "string" then
		return
	end

	local customDataSystem = self:getInjector():getInstance("CustomDataSystem")

	return customDataSystem:getValue(PrefixType.kGlobal, pointId, false)
end

function DreamHouseDetailMediator:onClickPoint(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local tag = sender:getTag()
		local pointIdx = tonumber(tag)

		if pointIdx == self._curPointIndex then
			return
		end

		local tmpId = self._pointIds[pointIdx]
		local tmpData = self._mapData:getPointById(tmpId)
		local upPointId = tmpData:getPointConfig().BeforePoint

		if tmpData:getIsUnLock() == false then
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("DreamHouse_Main_UI25", {
					name1 = tmpData:getPointName(),
					name2 = (upPointId and upPointId ~= "" or nil) and self._mapData:getPointById(upPointId):getPointName()
				})
			}))

			return
		end

		self:refreshMapData(pointIdx)
		self:setupBattleList()
		self:refreshPointInfo(true)
		self:refreshBattleInfo()
	end
end

function DreamHouseDetailMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function DreamHouseDetailMediator:onClickResetBtn()
	if self._pointData:isCurrentPerfectPass() then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("DreamHouse_Second_UI17")
		}))

		return
	end

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			outSelf._dreamSystem:resetDreamHouse(outSelf._mapId, outSelf._pointId, function(response)
				outSelf:refreshMapData(outSelf._curPointIndex)
				outSelf:setupBattleList()
				outSelf:refreshBattleInfo()
				outSelf:dispatch(Event:new(EVT_HOUSE_MAIN_REFRESH, {
					mapId = outSelf._mapId
				}))
			end)
		elseif data.response == "cancel" then
			-- block empty
		elseif data.response == "close" then
			-- block empty
		end
	end

	local mapName = Strings:get(ConfigReader:getDataByNameIdAndKey("DreamHouseMap", self._mapId, "Name"))
	local pointName = Strings:get(ConfigReader:getDataByNameIdAndKey("DreamHousePoint", self._pointId, "Name"))
	local data = {
		isRich = true,
		title = Strings:get("DreamHouse_Second_UI14"),
		content = Strings:get("DreamHouse_Second_UI13", {
			name = mapName,
			level = pointName,
			fontName = TTF_FONT_FZYH_M
		}),
		sureBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function DreamHouseDetailMediator:onClickGuide(sender, eventType)
	local config = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", self._battleId, "SpecialRuleShow")
	local view = self:getInjector():getInstance("StagePracticeSpecialRuleView")
	local tab = config
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		ruleList = tab
	})

	self:dispatch(event)
end

function DreamHouseDetailMediator:onClickInfoBtn()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "DreamHouse_Rule", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule
	}))
end

function DreamHouseDetailMediator:onClickTeamBtn()
	local battleId = self._battleIds[self._curIndex]
	local battleStarData = self._pointData:getPoints()[battleId]

	if battleStarData then
		if self._pointData:isCurrentPerfectPass() then
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("Perfect Pass!")
			}))

			return
		end

		self._dreamSystem:enterDreamHouseTeam(self._mapId, self._pointId, battleId)
	else
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = Strings:get("DreamHouse_Main_UI24")
		}))

		return
	end
end
