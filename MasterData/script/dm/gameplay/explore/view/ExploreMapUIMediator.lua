-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreMapUIMediator.lua

ExploreMapUIMediator = class("ExploreMapUIMediator", DmBaseUI)

ExploreMapUIMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ExploreMapUIMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
ExploreMapUIMediator:has("_customDataSystem", {
	is = "r"
}):injectWith("CustomDataSystem")

local kBtnHandlers = {
	["main.btnPanel.btnPanel.dpLogBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickLog"
	},
	["main.btnPanel.btnPanel.dpTipBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickDpTask"
	},
	["main.btnPanel.btnPanel.dpBagBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBag"
	},
	["main.btnPanel.btnPanel.dpZombiesBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickZombies"
	},
	["main.backBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBack"
	},
	["main.infoPanel.useItemBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAdd"
	},
	["main.btnPanel.btnPanel.taskBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickFinish"
	},
	["main.autoBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAuto"
	},
	["main.speed_panel.speed_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickSpeed"
	}
}
local kScaleNum = 10

function ExploreMapUIMediator:initialize(data)
	super.initialize(self, data)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ExploreMapUIMediator:refreshView(ignoreBuffRefresh)
	self._buffTipPanel:setVisible(false)
	self._tipPanel:setVisible(false)
	self:updateData()
	self:updateTask()
	self:updateTeam()
	self:updateTinyMap()
	self:refreshZombiesBtn()
	self:refreshAutoBtn()
	self:refreshSpeed()

	if not ignoreBuffRefresh then
		self:updateBuff()
	end
end

function ExploreMapUIMediator:refreshAutoBtn()
	local canAuto, tip = self._exploreSystem:canAuto(self._pointData)
	local color = not canAuto and cc.c3b(130, 130, 130) or cc.c3b(255, 255, 255)

	self._autoBtn:setColor(color)
end

function ExploreMapUIMediator:refreshSpeed()
	local speed = self._exploreSystem:canSpeed()

	self._speedLock:setVisible(not self._exploreSystem:getSpeedEffect())

	if not speed then
		self._speedLabel:setString(Strings:get("BattleSpeedUpWord_Normal_1"))
		self._speedLabel1:setString(Strings:get("BattleSpeedUpWord_Normal_2"))
		self._speedEffect:setVisible(false)
		self._speedLabel2:setString(Strings:get("BattleSpeedUpWord_Normal_1"))
	else
		self._speedLabel:setString(Strings:get("BattleSpeedUpWord_SpeedUp_1"))
		self._speedLabel1:setString(Strings:get("BattleSpeedUpWord_SpeedUp_2"))
		self._speedEffect:setVisible(true)
		self._speedLabel2:setString(Strings:get("BattleSpeedUpWord_SpeedUp_1"))
	end
end

function ExploreMapUIMediator:initView(pointId, parent)
	self._bagSystem = self._developSystem:getBagSystem()
	self._parentMediator = parent
	self._pointId = pointId
	self._useItem = self._exploreSystem:getCostItemMap()
	self._main = self:getView():getChildByName("main")
	self._autoBtn = self._main:getChildByFullName("autoBtn")
	self._tinyMapBtn = self._main:getChildByName("tinyMapBtn")
	self._scrollView = self._tinyMapBtn:getChildByFullName("node.scrollView")

	self._scrollView:setScrollBarEnabled(false)
	self._scrollView:setName("MapScrollView")

	self._infoPanel = self._main:getChildByName("infoPanel")
	self._teamPanel = self._infoPanel:getChildByName("teamPanel")
	self._taskPanel = self._infoPanel:getChildByName("taskPanel")
	self._tipPanel = self._taskPanel:getChildByFullName("progressMark.tipPanel")

	self._tipPanel:setVisible(false)

	self._btnPanel = self._main:getChildByFullName("btnPanel.btnPanel")
	self._finishBtn = self._btnPanel:getChildByFullName("taskBtn")

	local anim = cc.MovieClip:create("zidongxunhuan_xitonganniu")

	anim:addTo(self._finishBtn):offset(25, 25):setScale(1.1)
	anim:setName("AnimEffect")
	anim:setVisible(false)

	self._buffTipPanel = self._infoPanel:getChildByName("buffTipPanel")

	self._buffTipPanel:setVisible(false)

	self._buffClone = self._infoPanel:getChildByName("buffClone")

	self._buffClone:setVisible(false)

	self._hpMax = self._exploreSystem:getHpMax()
	self._speedPanel = self._main:getChildByName("speed_panel")

	self._speedPanel:setVisible(false)

	self._speedLabel = self._speedPanel:getChildByName("label1")
	self._speedLabel1 = self._speedPanel:getChildByName("label2")
	self._speedBtn = self._speedPanel:getChildByName("speed_btn")
	self._speedLock = self._speedPanel:getChildByName("lock")
	self._speedEffect = cc.MovieClip:create("zidongxunhuan_xitonganniu")

	self._speedEffect:addTo(self._speedPanel):offset(25, 28)

	local auto_enabledNode = self._autoBtn:getChildByFullName("label_node.auto_enabled")
	local autoLabelEn = self._autoBtn:getChildByFullName("autoLabelEn")

	auto_enabledNode:setVisible(true)
	autoLabelEn:setVisible(false)
	self._speedLabel:setVisible(true)
	self._speedLabel1:setVisible(true)

	self._speedLabel2 = self._speedPanel:getChildByName("label3")

	self._speedLabel2:setVisible(false)

	local language = getCurrentLanguage()

	if language ~= GameLanguageType.CN then
		auto_enabledNode:setVisible(false)
		autoLabelEn:setVisible(true)
		self._speedLabel:setVisible(false)
		self._speedLabel1:setVisible(false)
		self._speedLabel2:setVisible(true)
		self._speedLabel2:setFontSize(14)

		local doneMark = self._taskPanel:getChildByName("doneMark")
		local text = doneMark:getChildByName("text")

		doneMark:setContentSize(cc.size(text:getContentSize().width + 20, doneMark:getContentSize().height))
		text:setPositionX(doneMark:getContentSize().width - 10)
	end

	local clickImg = self._taskPanel:getChildByFullName("progressMark")

	clickImg:setTouchEnabled(true)
	clickImg:addTouchEventListener(function(sender, eventType)
		self:onClickTaskPro(sender, eventType)
	end)
	self._tinyMapBtn:setTouchEnabled(true)
	self._tinyMapBtn:addClickEventListener(function()
		self:onClickTiny()
	end)

	self._scrollViewSize = self._scrollView:getContentSize()

	local panel = self._tinyMapBtn:getChildByFullName("node")
	local scrollView = self._scrollView:clone()

	scrollView = IconFactory:addStencilForIcon(scrollView, 2, cc.size(126, 126))

	panel:removeAllChildren()
	scrollView:addTo(panel)
	scrollView:setAnchorPoint(cc.p(0.5, 0.5))
	scrollView:setPosition(cc.p(0, 0))

	self._scrollView = scrollView:getChildByName("MapScrollView")
	self._mapPanel = self._scrollView:getChildByName("mapPanel")

	self:updateData()
	self:updateBuff()
	self:updateTask()
	self:updateTeam()
	self:updateTinyMap()
	self:setEffect()
	self:refreshZombiesBtn()
	self:refreshAutoBtn()
	self:refreshSpeed()

	local battleAuto = self._exploreSystem:getAutoBattleStatus()

	if battleAuto then
		self:setAutoAnim()
	end
end

function ExploreMapUIMediator:updateData()
	self._pointData = self._exploreSystem:getMapPointObjById(self._pointId)
	self._taskData = self._pointData:getMainTask()
	self._maoObjPorData = self._pointData:getMapObjProgress()
	self._exploreData = self._developSystem:getPlayer():getExplore()
	self._currentMapInfo = self._exploreData:getPointMap()[self._exploreData:getCurPointId()]
	self._exploreObjects = self._currentMapInfo and self._currentMapInfo:getMapObjects() or nil
end

function ExploreMapUIMediator:updateBuff()
	local buffPanel = self._infoPanel:getChildByName("buffPanel")

	buffPanel:removeAllChildren()

	local gotBuff = {}
	local customKey = CustomDataKey.kExploreBuff
	local customData = self._customDataSystem:getValue(PrefixType.kGlobal, customKey)

	if customData and customData ~= "" then
		gotBuff = string.split(customData, "&")
	end

	local buffInfo = self._pointData:getBuff()
	local index = 0

	for i, v in pairs(buffInfo) do
		index = index + 1

		local panel = self._buffClone:clone()

		panel:setVisible(true)
		panel:addTo(buffPanel)
		panel:setPosition(cc.p(10 + 40 * (index % 10 - 1), 22))

		local anim = cc.MovieClip:create("dh_huodebuff")

		anim:addTo(panel):center(panel:getContentSize())
		anim:addEndCallback(function()
			anim:stop()
		end)
		anim:setScale(1.3)

		local iconPanel = anim:getChildByFullName("iconPanel")
		local icon = cc.Sprite:create("asset/skillIcon/" .. v.icon .. ".png")

		icon:setAnchorPoint(cc.p(0.5, 0.5))
		icon:setScale(0.24)
		icon:addTo(iconPanel)

		if not table.indexof(gotBuff, v.id) then
			anim:gotoAndPlay(0)

			gotBuff[#gotBuff + 1] = v.id
		else
			anim:gotoAndStop(30)
		end

		panel:setTouchEnabled(true)
		panel:addTouchEventListener(function(sender, eventType)
			self:onClickBuff(sender, eventType, v)
		end)
	end

	local customValue = ""

	for i = 1, #gotBuff do
		customValue = i == 1 and gotBuff[1] or customValue .. "&" .. gotBuff[i]
	end

	self._customDataSystem:setValue(PrefixType.kGlobal, customKey, customValue)
end

function ExploreMapUIMediator:updateTask()
	local desc = self._taskPanel:getChildByName("taskDesc")

	desc:setString("")
	desc:removeAllChildren()

	local guideMap = self._pointData:getCurrentGuide()
	local currentValue = guideMap.currentNum
	local targetValue = guideMap.targetNum
	local descStr = guideMap.desc
	local str = Strings:get("EXPLORE_UI75", {
		desc = descStr,
		currentValue = currentValue,
		targetValue = targetValue,
		fontName = TTF_FONT_FZYH_R
	})
	local descLabel = ccui.RichText:createWithXML(str, {})

	descLabel:renderContent(260, 0)
	descLabel:addTo(desc)
	descLabel:setAnchorPoint(cc.p(0, 0.5))
	descLabel:setPosition(cc.p(0, 25))

	local done = self._taskData:getStatus() ~= 0
	local doneMark = self._taskPanel:getChildByName("doneMark")

	doneMark:setVisible(done)

	local anim = self._finishBtn:getChildByFullName("AnimEffect")

	anim:setVisible(done)

	local totalPro = self._maoObjPorData[2]
	local progressNum = math.floor(totalPro[1] / totalPro[2] * 100)
	local progressMark = self._taskPanel:getChildByFullName("progressMark")

	if not progressMark:getChildByFullName("ProgressTimer") then
		local barImage = cc.Sprite:createWithSpriteFrameName("ts_bg_dp_3.png")
		local progrLoading = cc.ProgressTimer:create(barImage)

		progrLoading:setType(0)
		progrLoading:setReverseDirection(true)
		progrLoading:setAnchorPoint(cc.p(0.5, 0.5))
		progrLoading:setMidpoint(cc.p(0.5, 0.5))
		progrLoading:addTo(progressMark)
		progrLoading:setPosition(cc.p(30, 30.6))
		progrLoading:setName("ProgressTimer")
	end

	progressMark:getChildByFullName("ProgressTimer"):setPercentage(progressNum)

	local progress = progressMark:getChildByFullName("progress")

	progress:setString(progressNum .. "%")
end

function ExploreMapUIMediator:updateTeam()
	local teamList = self._pointData:getTeams()

	for i = 1, #teamList do
		local team = teamList[i]
		local teamPanel = self._teamPanel:getChildByFullName("team_" .. i)

		if teamPanel then
			teamPanel:setVisible(true)

			local curHp = team:getHp()
			local loadingBar = teamPanel:getChildByFullName("loadingBar")

			loadingBar:setPercent(curHp / self._hpMax * 100)

			local progress = teamPanel:getChildByFullName("progress")

			progress:setString(curHp .. "/" .. self._hpMax)

			local statusImg = teamPanel:getChildByFullName("statusImg")
			local status = self._exploreSystem:getHpBuff(curHp)

			if status == "" then
				statusImg:setVisible(false)
			else
				statusImg:setVisible(true)
				statusImg:loadTexture(status .. ".png", 1)
			end
		end
	end

	local useItemNum = self._infoPanel:getChildByFullName("useItemNum")
	local useItemBtn = self._infoPanel:getChildByFullName("useItemBtn")

	if not useItemBtn:getChildByFullName("UseIcon") then
		useItemBtn:removeAllChildren()

		local icon = IconFactory:createItemPic({
			id = self._useItem
		})

		icon:addTo(useItemBtn)
		icon:setPosition(cc.p(34.5, 39))
		icon:setName("UseIcon")
		icon:setScale(0.7)
	end

	local count = self._exploreSystem:getItemCount(self._useItem)

	useItemNum:setString(count)
end

function ExploreMapUIMediator:updateTinyData()
	local posX, posY = self._currentMapInfo:getX(), self._currentMapInfo:getY()

	self._mapPic = self._pointData:getMapPic()
	self._offset = {
		maxY = 0,
		maxX = 0,
		minY = 0,
		minX = 0
	}
	self._mapPicAction = self._pointData:getMapPicAction()

	local curPos = {
		x = posX,
		y = posY
	}

	for mapPic, value in pairs(self._mapPicAction) do
		local triggerRect = self._exploreSystem:getRectByGrid({
			x = 0,
			y = 0
		}, value)
		local inRect = self._exploreSystem:checkPointInTargetRectByGrid(curPos, triggerRect)

		if inRect then
			self._mapPic = mapPic
			self._offset = {
				minX = triggerRect.minX,
				minY = triggerRect.minY,
				maxX = triggerRect.maxX,
				maxY = triggerRect.maxY
			}

			break
		end
	end
end

function ExploreMapUIMediator:updateTinyMap()
	if not self._exploreObjects then
		return
	end

	self:updateTinyData()
	self._mapPanel:removeAllChildren()

	local bg = ccui.ImageView:create("asset/scene/" .. self._mapPic .. ".jpg")

	bg:addTo(self._mapPanel)
	bg:setAnchorPoint(cc.p(0, 0))
	bg:setScale(0.5)

	self._size = {
		width = bg:getContentSize().width * 0.5,
		height = bg:getContentSize().height * 0.5
	}

	self._scrollView:setInnerContainerSize(cc.size(self._size.width, self._size.height))

	local playerImg = ccui.ImageView:create("ts_bg_ditu_ziji.png", 1)

	playerImg:addTo(self._mapPanel)
	playerImg:setLocalZOrder(9999)
	playerImg:setName("PlayerImg")
	playerImg:setScale(0.5)

	for i, v in pairs(self._exploreObjects) do
		local imgPath = v:getConfigByKey("MapTipsPic")

		if imgPath and imgPath ~= "" then
			local icon = ccui.ImageView:create(imgPath .. ".png", 1)

			icon:addTo(self._mapPanel)
			icon:setAnchorPoint(cc.p(0.5, 0))

			local x = v:getX() * 10 / kScaleNum
			local y = v:getY() * 10 / kScaleNum

			icon:setPosition(cc.p(x, 960 - y))
			icon:setScale(0.5)
		end
	end

	bg:setPosition(cc.p(self._offset.minX, 960 - (self._offset.minY + self._size.height)))

	local positionY = 960 - (self._offset.minY + self._size.height)

	self._mapPanel:setPosition(cc.p(-self._offset.minX, -positionY))
	self:refreshTinyMap({
		x = self._currentMapInfo:getX(),
		y = self._currentMapInfo:getY()
	})
end

function ExploreMapUIMediator:refreshTinyMap(pos)
	if self._exploreObjects and self._scrollView and self._mapPanel:getChildByFullName("PlayerImg") then
		local posX, posY = pos.x * 10 / kScaleNum, 960 - pos.y * 10 / kScaleNum

		self._mapPanel:getChildByFullName("PlayerImg"):setPosition(cc.p(posX, posY))

		local positionY = 960 - (self._offset.minY + self._size.height)
		local showMidPoint = cc.p(self._scrollViewSize.width / 2, self._size.height - self._scrollViewSize.height / 2)

		self._scrollView:setInnerContainerPosition(cc.p(-((posX - self._offset.minX - showMidPoint.x > 0 or nil) and math.min(posX - self._offset.minX - showMidPoint.x, self._size.width - self._scrollViewSize.width)), (posY - positionY - showMidPoint.y < 0 or nil) and self._scrollViewSize.height - self._size.height + math.min(showMidPoint.y - posY + positionY, self._size.height - self._scrollViewSize.height)))
		self._parentMediator:dispatch(Event:new(EVT_EXPLORE_MOVE_SUCC, {
			pos = pos
		}))
	end
end

function ExploreMapUIMediator:setEffect()
	GameStyle:setCommonOutlineEffect(self._taskPanel:getChildByName("taskDesc"), 127)
	GameStyle:setCommonOutlineEffect(self._taskPanel:getChildByFullName("progressMark.progress"), 153)
	GameStyle:setCommonOutlineEffect(self._teamPanel:getChildByFullName("team_1.progress"), 153)
	GameStyle:setCommonOutlineEffect(self._teamPanel:getChildByFullName("team_2.progress"), 153)
	GameStyle:setCommonOutlineEffect(self._teamPanel:getChildByFullName("team_3.progress"), 153)

	local descPanel = self._main:getChildByName("descPanel")
	local bg = descPanel:getChildByName("image")
	local name = descPanel:getChildByName("name")

	name:setString(self._pointData:getName())

	local desc = descPanel:getChildByName("taskDesc")
	local taskSystem = self:getInjector():getInstance(TaskSystem)
	local config = taskSystem:getTaskDataById(self._pointData:getMapMainTask())

	if Strings:get(config.Desc) ~= "" then
		local var_17_0 = Strings:get(config.Desc)

		if not var_17_0 then
			var_17_0 = self._exploreSystem:getTaskDescByCondition(config.Condition)

			local descStr = var_17_0

			desc:setString(descStr)
			descPanel:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
				descPanel:setVisible(false)
			end)))

			if desc:getContentSize().width > 400 then
				desc:setTextAreaSize(cc.size(400, 0))
			end

			bg:setContentSize(cc.size(440, desc:getContentSize().height + 65))

			local tinyName = self._tinyMapBtn:getChildByFullName("name")

			tinyName:setString(self._pointData:getName())
		end
	end
end

function ExploreMapUIMediator:updateBuffDesc(info)
	local iconNode = self._buffTipPanel:getChildByName("iconNode")
	local Imagebg = self._buffTipPanel:getChildByName("Image_bg")

	iconNode:removeAllChildren()

	local icon = cc.Sprite:create("asset/skillIcon/" .. info.icon .. ".png")

	icon:setAnchorPoint(cc.p(0.5, 0.5))
	icon:setScale(0.46)
	icon:addTo(iconNode):center(iconNode:getContentSize())

	local name = self._buffTipPanel:getChildByName("name")

	name:setString(info.name)

	local desc = self._buffTipPanel:getChildByName("desc")

	desc:setString("")
	desc:removeAllChildren()

	local defaults = {}
	local label = ccui.RichText:createWithXML(info.desc, defaults)

	label:renderContent(260, 0)
	desc:addChild(label)
	label:setAnchorPoint(cc.p(0, 1))
	label:setPosition(cc.p(0, 90))
	Imagebg:setContentSize(cc.size(371.37, 145 + label:getContentSize().height - 90))
end

function ExploreMapUIMediator:updateTaskPro()
	local temp1 = "<font face='${fontName}' size='${fontSize}' color='#ffffff'>、</font>"

	temp1 = TextTemplate:new(temp1)
	temp1 = temp1:stringify({
		fontSize = 16,
		fontName = TTF_FONT_FZYH_R
	})

	local temp2 = "<font face='${fontName}' size='${fontSize}' color='#AAF014'>${num}</font>"
	local rewardNum = ""
	local mapGuideRewardNum = self._pointData:getMapGuideReward()
	local nums = {}

	for num, v in pairs(mapGuideRewardNum) do
		nums[#nums + 1] = num * 100
	end

	table.sort(nums, function(a, b)
		return a < b
	end)

	for i = 1, #nums do
		local num = nums[i]

		if rewardNum == "" then
			rewardNum = TextTemplate:new(temp2)
			rewardNum = rewardNum:stringify({
				fontSize = 16,
				num = num .. "%",
				fontName = TTF_FONT_FZYH_R
			})
		else
			local temp = TextTemplate:new(temp2)

			temp = temp:stringify({
				fontSize = 16,
				num = num .. "%",
				fontName = TTF_FONT_FZYH_R
			})
			rewardNum = rewardNum .. temp1 .. temp
		end
	end

	local itemsPro = self._maoObjPorData[1]
	local totalPro = self._maoObjPorData[2]
	local progressNum = math.floor(totalPro[1] / totalPro[2] * 100)
	local childTag = 12138
	local children = self._tipPanel:getChildren()

	for index = 1, #children do
		local child = children[index]

		if child:getTag() == childTag then
			child:removeFromParent()
		end
	end

	local image = self._tipPanel:getChildByFullName("image")
	local progress = self._tipPanel:getChildByFullName("progress")

	progress:setString(Strings:get("EXPLORE_UI53") .. progressNum .. "%")

	local extendHeight = 0

	if rewardNum ~= "" then
		rewardNum = Strings:get("MapExplore_MapGuideReward_Desc", {
			fontSize = 16,
			num = rewardNum,
			fontName = TTF_FONT_FZYH_R
		})

		progress:removeAllChildren()

		local logStr = ccui.RichText:createWithXML(rewardNum, {})

		logStr:renderContent(250, 0)
		logStr:setAnchorPoint(cc.p(0, 1))
		logStr:setPosition(cc.p(0, -5))
		logStr:addTo(progress)
		logStr:setName("RewardNum")

		extendHeight = logStr:getContentSize().height + 5
	end

	local posX = progress:getPositionX()
	local posY = progress:getPositionY() - 57 - extendHeight
	local index1 = 0
	local height = progress:getContentSize().height + extendHeight

	for i = 1, #itemsPro do
		local value = itemsPro[i]
		local str = Strings:get(value.id) .. "：" .. value.progress[1] .. "/" .. value.progress[2]
		local label = cc.Label:createWithTTF(str, TTF_FONT_FZYH_R, 18)

		label:setAnchorPoint(cc.p(0, 0.5))
		label:setTag(childTag)
		label:addTo(self._tipPanel)
		label:setPosition(cc.p(posX, posY - 32 * (i - 1) - 23 * (index1 - 1)))

		height = height + 32

		for index = 1, #value.items do
			local item = value.items[index]

			index1 = index1 + 1
			str = Strings:get(item.id) .. "（" .. item.currencyNum .. "/" .. item.targetNum .. "）"
			label = cc.Label:createWithTTF(str, TTF_FONT_FZYH_R, 16)

			label:setAnchorPoint(cc.p(0, 0.5))
			label:setTag(childTag)
			label:addTo(self._tipPanel)
			label:setPosition(cc.p(posX, posY - 23 * (index1 - 1) - 32 * (i - 1)))

			local color = item.currencyNum >= item.targetNum and cc.c3b(170, 240, 20) or cc.c3b(180, 170, 170)

			label:setColor(color)

			height = height + 23
		end
	end

	image:setContentSize(cc.size(278, height + 30))
end

function ExploreMapUIMediator:onClickFinish()
	local battleAuto = self._exploreSystem:getAutoBattleStatus()

	if battleAuto then
		self._exploreSystem:setAutoBattleStatus(not battleAuto)
		self._parentMediator:stopAutoPlay()
		self._autoBtn:removeChildByName("AnimEffect")
	end

	local view = self:getInjector():getInstance("ExploreVictoryView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		pointData = self._pointData,
		callback = function()
			if DisposableObject:isDisposed(self._parentMediator) then
				return
			end

			if battleAuto then
				self._exploreSystem:setAutoBattleStatus(battleAuto)
				self:setAutoAnim()
				self._parentMediator:autoPlay()
			end
		end
	}))
end

function ExploreMapUIMediator:onClickAdd()
	local view = self:getInjector():getInstance("ExploreAddPowerView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		id = self._pointId
	}))
end

function ExploreMapUIMediator:onClickLog()
	local params = {
		pointId = self._pointData:getId()
	}

	self._exploreSystem:requestGetPointComment(function(response)
		local view = self:getInjector():getInstance("ExploreLogView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			tabType = 1,
			pointData = self._pointData,
			serverdata = response.data
		}))
	end, params)
end

function ExploreMapUIMediator:onClickDpTask()
	local view = self:getInjector():getInstance("ExploreDPTaskView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		id = self._pointData:getMapType()
	}))
end

function ExploreMapUIMediator:onClickBag()
	local bagView = self:getInjector():getInstance("ExploreBagView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bagView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}))
end

function ExploreMapUIMediator:onClickZombies()
	local pointId = self._pointData:getId()
	local config = ConfigReader:getDataByNameIdAndKey("MapPoint", pointId, "MechanismInfo")

	self._exploreSystem:enterZombieView(pointId)
end

function ExploreMapUIMediator:refreshZombiesBtn()
	local pointId = self._pointData:getId()
	local config = ConfigReader:getDataByNameIdAndKey("MapPoint", pointId, "MechanismInfo")
	local btn = self._btnPanel:getChildByFullName("dpZombiesBtn")
	local image = btn:getChildByName("Image_255")

	image:loadTexture(config.icon .. ".png", ccui.TextureResType.plistType)

	local text = self._btnPanel:getChildByFullName("text_zombie")

	text:setString(Strings:get(config.translate))
	btn:setVisible(true)
	text:setVisible(true)
	self._btnPanel:setPositionX(0)

	local state = self._exploreSystem:getZombieOpenSta(pointId)

	if state == ExploreZombieState.kOpen then
		btn:setGray(false)
		image:setGray(false)
		btn:setEnabled(true)
	elseif state == ExploreZombieState.kClose then
		btn:setGray(true)
		image:setGray(true)
		btn:setEnabled(false)
	elseif state == ExploreZombieState.kHide then
		self._btnPanel:setPositionX(105)
		btn:setVisible(false)
		text:setVisible(false)
	end
end

function ExploreMapUIMediator:onClickAuto()
	if self._parentMediator._autoPlay then
		self._parentMediator:stopAutoPlay()
		self._parentMediator:showStopAutoTip()

		return
	end

	local canAuto, tip = self._exploreSystem:canAuto(self._pointData)

	if not canAuto then
		self:dispatch(ShowTipEvent({
			tip = tip
		}))

		return
	end

	local battleAuto = self._exploreSystem:getAutoBattleStatus()

	self._exploreSystem:setAutoBattleStatus(not battleAuto)

	battleAuto = self._exploreSystem:getAutoBattleStatus()

	if battleAuto then
		self:setAutoAnim()
		self._parentMediator:autoPlay()
	else
		self._parentMediator:stopAutoPlay()
		self._autoBtn:removeChildByName("AnimEffect")
	end
end

function ExploreMapUIMediator:onClickSpeed()
	local battleAuto = self._exploreSystem:getAutoBattleStatus()
	local canSweep = self._exploreSystem:getSpeedEffect()

	if not canSweep then
		local function func()
			local url = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MonthCard_Subscribe_ButtonUrl", "content")

			if url and url ~= "" then
				local context = self:getInjector():instantiate(URLContext)
				local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

				if not entry then
					self._parentMediator:dispatch(ShowTipEvent({
						tip = Strings:get("Function_Not_Open")
					}))
				else
					if battleAuto then
						self._exploreSystem:setAutoBattleStatus(not battleAuto)
						self._parentMediator:stopAutoPlay()
						self._autoBtn:removeChildByName("AnimEffect")
					end

					entry:response(context, params)
				end
			end
		end

		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				func()
			elseif data.response == "cancel" then
				-- block empty
			elseif data.response == "close" then
				-- block empty
			end
		end

		local data = {
			title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
			content = Strings:get("Scribe_AutoExplore_Opentips"),
			sureBtn = {},
			cancelBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self._parentMediator:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))

		return
	end

	local speedStatus = self._exploreSystem:getSpeedStatus()

	speedStatus = speedStatus == "1" and "0" or "1"

	self._exploreSystem:setCanSpeed(speedStatus)
	self:refreshSpeed()
	self._parentMediator:setMoveTimeForPerGrid()
end

function ExploreMapUIMediator:setAutoAnim()
	local anim = cc.MovieClip:create("zidongxunhuan_xitonganniu")

	anim:addTo(self._autoBtn):offset(26, 29)
	anim:setName("AnimEffect")
end

function ExploreMapUIMediator:resetAuto()
	self._exploreSystem:setAutoBattleStatus(false)
	self._autoBtn:removeChildByName("AnimEffect")
end

function ExploreMapUIMediator:leaveWithData()
	self:onClickBack()
end

function ExploreMapUIMediator:onClickBack()
	self._parentMediator:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
end

function ExploreMapUIMediator:onClickBuff(sender, eventType, info)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local targetPos = sender:getParent():convertToWorldSpace(cc.p(sender:getPosition()))
		local isContainPos = self._buffTipPanel:getParent():convertToNodeSpace(targetPos)

		self._buffTipPanel:setPosition(cc.p(isContainPos.x + 40, isContainPos.y + 20))
		self._buffTipPanel:setVisible(true)
		self:updateBuffDesc(info)
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self._buffTipPanel:setVisible(false)
	end
end

function ExploreMapUIMediator:onClickTaskPro(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._tipPanel:setVisible(true)
		self:updateTaskPro()
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self._tipPanel:setVisible(false)
	end
end

function ExploreMapUIMediator:onClickTiny()
	local view = self:getInjector():getInstance("ExploreTinyView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		id = self._pointData:getId()
	}))
end
