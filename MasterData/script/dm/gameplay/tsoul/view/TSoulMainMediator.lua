-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tsoul/view/TSoulMainMediator.lua

TSoulMainMediator = class("TSoulMainMediator", DmAreaViewMediator, _M)

TSoulMainMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

local Tsoul_Open = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_Open", "content")
local Suit_ImgDi = {
	"timesoul_img_tzk_lv.png",
	"timesoul_img_tzk_lv.png",
	"timesoul_img_tzk_lan.png",
	"timesoul_img_tzk_zi.png",
	"timesoul_img_tzk_cheng.png",
	"timesoul_img_tzk_hong.png"
}
local Hole_Suit_Anim_Name = {
	{
		lineName = "wenli_ljtl_xiangqiansanjiantaozhuang",
		gemName = "zh2_xiangqiansanjiantaozhuang",
		fadeName = "xq_l_xiangqiansanjiantaozhuang",
		gemOffset = {
			0,
			-2
		},
		fadeOffset = {
			-2,
			-2
		}
	},
	{
		lineName = "wenli_ljtm_xiangqiansanjiantaozhuang",
		gemName = "zh1_xiangqiansanjiantaozhuang",
		fadeName = "xq_m_xiangqiansanjiantaozhuang",
		gemOffset = {
			4,
			-2
		},
		fadeOffset = {
			2,
			0
		}
	},
	{
		lineName = "wenli_ljtr_xiangqiansanjiantaozhuang",
		gemName = "zh3_xiangqiansanjiantaozhuang",
		fadeName = "xq_r_xiangqiansanjiantaozhuang",
		gemOffset = {
			-2,
			-12
		},
		fadeOffset = {
			-4,
			-8
		}
	}
}
local tipPos = {
	142,
	360,
	600
}
local TSoulIconFile = "asset/items/"
local kBtnHandlers = {
	["main.Button_hecheng"] = "onClickHecheng",
	["main.btn_rule"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	}
}
local KLockTip = {
	[30] = "MasterEmblem_QualityName3",
	[20] = "MasterEmblem_QualityName2",
	[40] = "MasterEmblem_QualityName4",
	[50] = "MasterEmblem_QualityName5"
}
local KredPointPos = {
	{
		cc.p(54, 214),
		cc.p(52, 217),
		cc.p(54, 216)
	},
	{
		cc.p(90, 83),
		cc.p(107, 76),
		cc.p(128, 79)
	}
}
local kTSoul_Hole_State = {
	KLock = 3,
	KMounting = 1,
	KDemount = 2
}

function TSoulMainMediator:initialize()
	super.initialize(self)
end

function TSoulMainMediator:dispose()
	if self._tsoulView then
		self._tsoulView:dispose()

		self._tsoulView = nil
	end

	super.dispose(self)
end

function TSoulMainMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TSOUL_REFHRESH_SUCC, self, self.onTsoulRefreshView)

	self._developSystem = self:getInjector():getInstance("DevelopSystem")
	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()
	self._tSoulSystem = self._developSystem:getTSoulSystem()

	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByFullName("main")
	self._tsouNode = self:getView():getChildByFullName("touchPanel")

	self._tsouNode:setVisible(false)
	self:getView():getChildByFullName("touchPanel"):addClickEventListener(function()
		if self._tsouNode and self._tsouNode:isVisible() then
			self._tsouNode:setVisible(false)
		end
	end)

	local buttons = {}

	for i = 1, 2 do
		buttons[#buttons + 1] = self._main:getChildByFullName("Panel_bottom.Panel_tab" .. i)
	end

	local data = {
		buttons = buttons,
		buttonClick = self.tabClickBottomByIndex,
		delegate = self
	}
	local tabGroup = EasyTab:new(data)

	tabGroup:setCurrentSelectButtonByIndex(1)

	self._tabBottomGroup = tabGroup

	local var_3_0 = {
		mediator = self
	}

	var_3_0.mainNode = self:getView():getChildByFullName("touchPanel.tsoulTip")

	local infoViewData = var_3_0

	self._tsoulView = self._tSoulSystem:enterTSoulInfoView(infoViewData)

	local btn = self._tsoulView:getView():getChildByFullName("main.Panel_button.btn_change")

	self:bindWidget(btn, ThreeLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onChangeClicked, self)
		}
	})

	local btn = self._tsoulView:getView():getChildByFullName("main.Panel_button.btn_intensify")

	self:bindWidget(btn, ThreeLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onIntensifyClicked, self)
		}
	})

	local btn = self._tsoulView:getView():getChildByFullName("main.Panel_button.btn_demout")

	btn:addClickEventListener(function()
		self:onClickDemount()
	end)
end

function TSoulMainMediator:onTsoulRefreshView(event)
	local eventData = event:getData()

	if eventData and next(eventData) then
		local index = eventData.pos
		local cell = self._tsoulCells[index]
		local tSoulData = self._tSoulSystem:getTSoulByIndex(self._heroId, index)
		local node_startAnim = cell:getChildByFullName("node_startAnim")
		local panelIcon = cell:getChildByFullName("Panel_Icon")
		local cellAnim = cell:getChildByFullName("Node_anim")

		if tSoulData then
			cellAnim:removeAllChildren()
			panelIcon:removeAllChildren()
			node_startAnim:setVisible(true)

			local anim = cc.MovieClip:create(Hole_Suit_Anim_Name[index].fadeName)
			local offset = Hole_Suit_Anim_Name[index].fadeOffset

			anim:addTo(node_startAnim):posite(0 + offset[1], 0 + offset[2])
			anim:gotoAndPlay(1)
			anim:addEndCallback(function(cid, mc)
				mc:stop()
				anim:removeFromParent(true)

				local offset = Hole_Suit_Anim_Name[index].gemOffset
				local anim2 = cc.MovieClip:create(Hole_Suit_Anim_Name[index].gemName)

				for i = 1, 2 do
					local mcIcon = anim2:getChildByFullName("icon" .. i)
					local image = ccui.ImageView:create(tSoulData:getShowIcon())

					image:addTo(mcIcon)
				end

				anim2:addTo(node_startAnim):posite(-280 + offset[1], 200 + offset[2])
				anim2:gotoAndPlay(1)
				anim2:addCallbackAtFrame(20, function()
					self:runStartAction()
				end)
				anim2:addEndCallback(function(cid, mc)
					mc:stop()
					anim2:removeFromParent(true)
				end)
			end)
		end
	else
		self:runStartAction()
	end
end

function TSoulMainMediator:resumeWithData()
	self:refreshView()
end

function TSoulMainMediator:setupView(parentMedi, data)
	self._mediator = parentMedi

	self:refreshData(data.id)
	self:initNodes()

	self._tabBottomIndex = 1

	self:updateTabState()
end

function TSoulMainMediator:refreshData(heroId)
	self._heroId = heroId
	self._heroData = self._heroSystem:getHeroById(self._heroId)
end

function TSoulMainMediator:initNodes()
	self._panelBottom = self._main:getChildByFullName("Panel_bottom")
	self._tsoulCells = {}

	for i = 1, HeroTSoulType.KThree do
		local clone = self._main:getChildByFullName("Panel_item" .. i)

		self._tsoulCells[i] = clone

		local function callFunc(sender, eventType)
			self:onClicCell(sender, i)
		end

		mapButtonHandlerClick(nil, clone, {
			func = callFunc
		})
	end
end

function TSoulMainMediator:refreshView(heroId)
	self._rolePanel = self._panelBottom:getChildByFullName("Panel_role")

	local roleModel = self._heroData:getModel()
	local isAwaken = self._heroData:getAwakenStar() > 0
	local bossNode = self._rolePanel:getChildByFullName("Node_32")

	bossNode:removeAllChildren()

	local heroImg = RoleFactory:createHeroAnimation(roleModel, isAwaken and "stand1" or "stand")

	heroImg:setScale(0.75)
	bossNode:addChild(heroImg):posite(120, 50)

	local rarityIcon = self._rolePanel:getChildByFullName("rarityIcon")

	rarityIcon:ignoreContentAdaptWithSize(false)
	rarityIcon:loadTexture(GameStyle:getHeroRarityImage(self._heroData:getRarity()), 1)

	local nameLabel = self._rolePanel:getChildByFullName("text_name")
	local name = self._heroData:getName()

	nameLabel:setString(name)

	local combatNode = self._rolePanel:getChildByFullName("combatNode.combat")
	local label = combatNode:getChildByFullName("CombatLabel")

	if not label then
		local fntFile = "asset/font/heroLevel_font.fnt"

		label = ccui.TextBMFont:create("", fntFile)

		label:addTo(combatNode)
		label:setName("CombatLabel")
	end

	local combat = self._heroData:getSceneCombatByType(SceneCombatsType.kAll)

	label:setString(combat)
	self._tsouNode:setVisible(false)

	local quality = self._heroData:getQuality()

	self._redRet = self._tSoulSystem:getRedPointForRarity(self._heroId)

	local nodeAnim = self._main:getChildByFullName("node_anim")

	for i, cell in ipairs(self._tsoulCells) do
		local panelTitle = cell:getChildByFullName("Panel_title")
		local panelIcon = cell:getChildByFullName("Panel_Icon")
		local cellAnim = cell:getChildByFullName("Node_anim")
		local panelLock = cell:getChildByFullName("Panel_lock")

		panelTitle:setVisible(false)
		panelLock:setVisible(false)

		local redPoint = cell:getChildByFullName("retPoint")

		redPoint:setVisible(false)

		local textName = panelTitle:getChildByFullName("text_title")
		local textLv = panelTitle:getChildByFullName("text_lv")
		local isUnlock = quality >= Tsoul_Open[i]

		if isUnlock then
			local tSoulId = self._heroData:getTSoulIdByPos(i)

			if tSoulId then
				panelTitle:setVisible(true)

				cell.state = kTSoul_Hole_State.KMounting

				local tSoulData = self._tSoulSystem:getTSoulById(tSoulId)

				GameStyle:setQualityText(textName, tSoulData:getRarity())
				textName:setString(tSoulData:getName())
				textLv:setString(tSoulData:getLevel())

				if self._redRet[i] then
					redPoint:setPosition(KredPointPos[1][i])
					redPoint:setVisible(true)
				end
			else
				cell.state = kTSoul_Hole_State.KDemount

				if self._tSoulSystem:getRedPointForLevel(self._heroId, i) then
					redPoint:setPosition(KredPointPos[2][i])
					redPoint:setVisible(true)
				end
			end
		else
			cell.state = kTSoul_Hole_State.KLock

			panelLock:setVisible(true)

			local lockText = panelLock:getChildByName("text_title_0")
			local str = Strings:get(KLockTip[Tsoul_Open[i]])

			lockText:setString(Strings:get("TimeSoul_Main_UnlockTips", {
				Quality = str
			}))
		end

		local node_startAnim = cell:getChildByFullName("node_startAnim")
		local holeNode = node_startAnim:getChildByFullName("holeAnim")

		if not holeNode then
			local anim = cc.MovieClip:create(Hole_Suit_Anim_Name[i].fadeName)
			local offset = Hole_Suit_Anim_Name[i].fadeOffset

			anim:gotoAndStop(1)
			anim:addTo(node_startAnim):posite(offset[1], offset[2])
			anim:setName("holeAnim")

			holeNode = anim
		end

		holeNode:setVisible(cell.state ~= kTSoul_Hole_State.KMounting)
	end
end

function TSoulMainMediator:refreshBottom()
	local panelAttr = self._panelBottom:getChildByFullName("Panel_2")
	local panelSuit = self._panelBottom:getChildByFullName("Panel_1")

	panelAttr:setVisible(self._tabBottomIndex == 2)
	panelSuit:setVisible(self._tabBottomIndex == 1)

	local vis = true

	if self._tabBottomIndex == 2 then
		local listView = panelAttr:getChildByFullName("ListView")

		listView:setScrollBarEnabled(false)
		listView:removeAllChildren()

		local attrData = self._tSoulSystem:getAllAttrByHeroId(self._heroId)
		local attrs = getTSoulAttNumber(attrData)

		vis = next(attrs) == nil

		local knum = math.ceil(#attrs / 3)
		local attrClone = self._panelBottom:getChildByFullName("attrClone")
		local img = attrClone:getChildByFullName("image")
		local text = attrClone:getChildByFullName("text")

		for i = 1, knum do
			local clone = attrClone:clone()

			for j = 1, 3 do
				local attrNode = clone:getChildByFullName("Panel_" .. j)
				local index = (i - 1) * 3 + j

				if attrs[index] then
					local img = attrNode:getChildByFullName("image")
					local text = attrNode:getChildByFullName("text")

					img:loadTexture(attrs[index].icon, ccui.TextureResType.plistType)
					text:setString(attrs[index].attrName .. " :   " .. attrs[index].num)
				else
					attrNode:setVisible(false)
				end
			end

			listView:pushBackCustomItem(clone)
		end
	else
		local suitIds = self._tSoulSystem:getSuitIdsByHeroId(self._heroId)
		local data = self:getShowSuitInfo(suitIds)
		local item = panelSuit:getChildByFullName("Panel_suitClone")

		item:setVisible(next(data) ~= nil)

		vis = next(data) == nil

		if next(data) then
			local suitNum = table.nums(data) - 3
			local suitId = data.suitId
			local imgDi = item:getChildByFullName("Image_di")
			local imgIcon = item:getChildByFullName("Image_icon")

			imgIcon:ignoreContentAdaptWithSize(true)

			local suitConfig = self._tSoulSystem:getConfigSuitBySuitId(suitId)

			imgDi:loadTexture(Suit_ImgDi[suitConfig.SuitRareity], 1)
			imgIcon:loadTexture(TSoulIconFile .. suitConfig.SuitIcon .. ".png")
			imgIcon:setScale(0.5)

			for i = 1, 2 do
				local img = item:getChildByFullName("Image_" .. i)
				local text = item:getChildByFullName("text_des" .. i)
				local content = item:getChildByFullName("text_content" .. i)
				local num = i < 3 and i + 1

				img:loadTexture(num <= suitNum and "timesoul_img_tz_pressed.png" or "timesoul_img_tz_normal.png", 1)
				text:setTextColor(num <= suitNum and cc.c3b(255, 255, 255) or cc.c3b(162, 162, 162))

				local attrType = suitConfig.Suitattr[tonumber(i)] or suitConfig.Suitlevattr[1]
				local attrNum = suitConfig.Partattr[tonumber(i)] or suitConfig.Partlevattr[1]

				if AttributeCategory:getAttNameAttend(attrType) ~= "" then
					attrNum = attrNum * 100 .. "%"
				end

				content:setString("")
				content:removeAllChildren()
				content:setString(Strings:get("TimeSoul_Main_SuitUI_20", {
					attr = getAttrNameByType(attrType),
					num = attrNum
				}))
				content:setTextColor(num <= suitNum and cc.c3b(255, 255, 255) or cc.c3b(162, 162, 162))
			end

			local img = item:getChildByFullName("Image_" .. 3)
			local text = item:getChildByFullName("text_des" .. 3)
			local content = item:getChildByFullName("text_content" .. 3)
			local contentTitle = item:getChildByFullName("text_des3")
			local suitLevel, attrName = self._tSoulSystem:getMaxLevelBySuitId(suitId, data, self._heroId)

			img:loadTexture(suitLevel > 0 and "timesoul_img_tz_pressed.png" or "timesoul_img_tz_normal.png", 1)
			text:setTextColor(suitLevel > 0 and cc.c3b(255, 255, 255) or cc.c3b(162, 162, 162))

			local attrType = suitConfig.Suitlevattr[1]
			local attrNum = suitConfig[attrName][1]

			if AttributeCategory:getAttNameAttend(attrType) ~= "" then
				attrNum = attrNum * 100 .. "%"
			end

			content:setString("")
			content:removeAllChildren()
			content:setString(Strings:get("TimeSoul_Main_SuitUI_20", {
				attr = getAttrNameByType(attrType),
				num = attrNum
			}))
			content:setTextColor(suitLevel > 0 and cc.c3b(255, 255, 255) or cc.c3b(162, 162, 162))
			contentTitle:setString("")
			contentTitle:removeAllChildren()
			contentTitle:setString(Strings:get("TimeSoul_Main_Suit_5", {
				level = math.max(suitLevel, 15)
			}))
		end
	end

	local noTitle = self._panelBottom:getChildByFullName("text_conten")

	noTitle:setVisible(vis)
end

function TSoulMainMediator:getShowSuitInfo(suits)
	if not next(suits) then
		return suits
	end

	for i, v in ipairs(suits) do
		if table.nums(v.pos) > 1 then
			return v
		end
	end

	table.sort(suits, function(a, b)
		local atsoul = self._tSoulSystem:getTSoulByIndex(self._heroId, a.pos[1])
		local btsoul = self._tSoulSystem:getTSoulByIndex(self._heroId, b.pos[1])
		local asuit = atsoul:getSuitData()
		local bsuit = btsoul:getSuitData()

		if asuit.SuitRareity == bsuit.SuitRareity then
			if atsoul:getLevel() == btsoul:getLevel() then
				return asuit.Sort < bsuit.Sort
			else
				return atsoul:getLevel() > btsoul:getLevel()
			end
		else
			return asuit.SuitRareity > bsuit.SuitRareity
		end
	end)

	return suits[1]
end

function TSoulMainMediator:updateTabState()
	for i = 1, 2 do
		local name = "Panel_bottom.Panel_tab"
		local button = self._main:getChildByFullName(name .. i)
		local img = button:getChildByFullName("Image_170")
		local text = button:getChildByFullName("text_title_0")
		local nun = self._tabBottomIndex

		img:loadTexture(nun == i and "timesoul_btn_qh_pressed.png" or "timesoul_btn_qh_normal.png", ccui.TextureResType.plistType)
		text:setTextColor(nun == i and cc.c3b(33, 28, 36) or cc.c3b(255, 255, 255))
	end
end

function TSoulMainMediator:tabClickBottomByIndex(button, eventType, index)
	AudioEngine:getInstance():playEffect("Se_Click_Tab_2", false)

	self._tabBottomIndex = index

	self:updateTabState()
	self:refreshView()
	self:refreshBottom()
end

function TSoulMainMediator:onChangeClicked()
	self._tsouNode:setVisible(false)

	local param = {}

	param.pos = self._index
	param.heroId = self._heroId

	local listData = self._tSoulSystem:getTSoulListByPosition(param)

	if not next(listData) then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("TimeSoul_Main_SuitUI_16")
		}))

		return
	end

	local tSoulId = self._heroData:getTSoulIdByPos(self._index)
	local view = self:getInjector():getInstance("TSoulChangeView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		pos = self._index,
		heroId = self._heroId,
		chooseId = tSoulId
	}, nil))
end

function TSoulMainMediator:onIntensifyClicked()
	self._tsouNode:setVisible(false)

	local tSoulId = self._heroData:getTSoulIdByPos(self._index)
	local view = self:getInjector():getInstance("TSoulIntensifyView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		chooseId = tSoulId
	}, nil))
end

function TSoulMainMediator:onClickDemount()
	self._tsouNode:setVisible(false)

	if not self._index then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local tSoulId = self._heroData:getTSoulIdByPos(self._index)
	local param = {
		heroId = self._heroId,
		tsoulId = tSoulId
	}

	self._tSoulSystem:requestTSoulDemount(param)
end

function TSoulMainMediator:refreshAllView()
	self._tabBottomIndex = 1

	self._tabBottomGroup:setCurrentSelectButtonByIndex(1)
	self:updateTabState()
	self:refreshView()
	self:refreshBottom()
end

function TSoulMainMediator:onClicCell(sender, index)
	self._index = index

	if self._tsoulCells[index].state == kTSoul_Hole_State.KLock then
		local str = Strings:get(KLockTip[Tsoul_Open[index]])

		self:dispatch(ShowTipEvent({
			tip = Strings:get("TimeSoul_Main_UnlockTips", {
				Quality = str
			})
		}))
	elseif self._tsoulCells[index].state == kTSoul_Hole_State.KMounting then
		local tSoulId = self._heroData:getTSoulIdByPos(index)

		self._tsouNode:setVisible(true)
		self._tsouNode:getChildByFullName("tsoulTip"):setPositionX(tipPos[index])
		self._tsoulView:refreshTSoulInfo({
			heroId = self._heroId,
			chooseId = tSoulId,
			index = index
		})

		if self._redRet[index] then
			self._tsoulView:setChangeRedpoint()
		end
	else
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)
		self:onChangeClicked()
	end
end

function TSoulMainMediator:onClickSuit(sender, eventType, suitId)
	local view = self:getInjector():getInstance("TSoulSuitView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		chooseId = suitId
	}))
end

function TSoulMainMediator:onClickHecheng(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local view = self:getInjector():getInstance("TSoulCompoundView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			heroId = self._heroId
		}))
	end
end

function TSoulMainMediator:onClickRule()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_RuleText", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule
	}))
end

function TSoulMainMediator:runStartAction(isFadeIn)
	local suitIds = self._tSoulSystem:getSuitIdsByHeroId(self._heroId)
	local holeState = {
		0,
		0,
		0
	}

	for i, v in ipairs(suitIds) do
		if #v.pos == 1 then
			holeState[v.pos[1]] = 1
		elseif #v.pos == 2 then
			holeState[v.pos[1]] = 2
			holeState[v.pos[2]] = 2
		elseif #v.pos == 3 then
			holeState[v.pos[1]] = 3
			holeState[v.pos[2]] = 3
			holeState[v.pos[3]] = 3
		end
	end

	local nodeAnim = self._main:getChildByFullName("node_anim")

	nodeAnim:removeAllChildren()

	local isThree = holeState[1] == 3 and holeState[2] == 3 and holeState[3] == 3

	for i = 1, HeroTSoulType.KThree do
		local cell = self._tsoulCells[i]
		local cellAnim = cell:getChildByFullName("Node_anim")

		cellAnim:removeAllChildren()

		if isThree then
			local anim = cc.MovieClip:create("sjt_xiangqiansanjiantaozhuang")

			anim:addTo(nodeAnim):posite(-98, 6)
			anim:gotoAndPlay(1)
			anim:addCallbackAtFrame(90, function()
				anim:gotoAndPlay(10)
			end)
		else
			if holeState[i] == 2 then
				local offset = {
					{
						10,
						0
					},
					{
						2,
						6
					},
					{
						4,
						12
					}
				}
				local anim = cc.MovieClip:create(Hole_Suit_Anim_Name[i].lineName)

				anim:addTo(cellAnim):posite(offset[i][1], offset[i][2])
				anim:gotoAndPlay(1)
				anim:addCallbackAtFrame(90, function()
					anim:gotoAndPlay(10)
				end)
			end

			if holeState[i] == 0 then
				local node_startAnim = cell:getChildByFullName("node_startAnim")
				local holeNode = node_startAnim:getChildByFullName("holeAnim")

				holeNode:setVisible(true)
			end
		end

		local panelIcon = cell:getChildByFullName("Panel_Icon")

		panelIcon:removeAllChildren()
		panelIcon:setVisible(false)

		if cell.state == kTSoul_Hole_State.KMounting then
			local tSoulData = self._tSoulSystem:getTSoulByIndex(self._heroId, i)

			if tSoulData then
				local animName = "bzs_xiangqiansanjiantaozhuang"
				local image = ccui.ImageView:create(tSoulData:getShowIcon())

				panelIcon:setVisible(true)

				local anim = cc.MovieClip:create(animName)
				local offset = {
					{
						50,
						48
					},
					{
						50,
						48
					},
					{
						40,
						48
					}
				}

				anim:addTo(panelIcon):posite(offset[i][1], offset[i][2])

				if isFadeIn then
					anim:setOpacity(0)

					local fadeIn = cc.FadeIn:create(0.5)

					anim:runAction(fadeIn)
				end

				local mc_icon = anim:getChildByFullName("icon")

				image:addTo(mc_icon)
			end
		end
	end
end
