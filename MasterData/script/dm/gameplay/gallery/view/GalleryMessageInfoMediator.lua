-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryMessageInfoMediator.lua

GalleryMessageInfoMediator = class("GalleryMessageInfoMediator", DmAreaViewMediator, _M)

GalleryMessageInfoMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryMessageInfoMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kBtnHandlers = {
	descBtn = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onClickShowTips"
	},
	PanelTouch_tip = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickHideTips"
	},
	["main.left.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["main.right.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	}
}

function GalleryMessageInfoMediator:initialize()
	super.initialize(self)
end

function GalleryMessageInfoMediator:dispose()
	self:closeProgrScheduler()

	self._isDisposed = true

	super.dispose(self)
end

function GalleryMessageInfoMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshBySync)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MESSAGE_LEVELUP_SUCC, self, self.refreshData)

	self._strengthenSucc = self:getView():getChildByName("strengthenSucc")

	self._strengthenSucc:setVisible(false)
end

function GalleryMessageInfoMediator:enterWithData(data)
	self._data = data

	self:setupTopInfoWidget()
	self:initWidgetInfo()
	self:initData(data)
	self:initTipsView()
	self:initBaseView()
	self:initHeroView()
	self:initInfoView()
	self:refreshStarUpCostPanel()
	self:initCellHeight()
	self:initTableView()
	self:refreshArrowState()
end

function GalleryMessageInfoMediator:initTipsView()
	self._tipsPanel = self:getView():getChildByName("tipsPanel")

	self._tipsPanel:setVisible(false)

	self._tipsTouchPanel = self:getView():getChildByName("PanelTouch_tip")

	self._tipsTouchPanel:setVisible(false)

	local tips = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Info_RuleText", "content")

	tips = tips[1].Desc

	local space = 18

	if getCurrentLanguage() ~= GameLanguageType.CN then
		space = 13

		self._tipsPanel:setContentSize(cc.size(400, 230))
	end

	local panelSize = self._tipsPanel:getContentSize()

	for i = 1, #tips do
		local str = Strings:get(tips[i])
		local text = ccui.Text:create(str, TTF_FONT_FZYH_M, 18)

		text:setLineSpacing(space)
		text:getVirtualRenderer():setMaxLineWidth(380)
		text:addTo(self._tipsPanel):setTag(i)
		text:setAnchorPoint(cc.p(0, 1))

		local prewText = self._tipsPanel:getChildByTag(i - 1)

		if prewText then
			local topPosY = prewText:getPositionY() - prewText:getContentSize().height

			text:setPosition(cc.p(10, topPosY - space))
		else
			text:setPosition(cc.p(10, panelSize.height - 15))
		end
	end
end

function GalleryMessageInfoMediator:initWidgetInfo()
	self._bg = self:getView():getChildByFullName("bg")
	self._main = self:getView():getChildByFullName("main")
	self._title = self._main:getChildByFullName("text")
	self._roleNode = self._main:getChildByFullName("roleNode")
	self._tableViewPanel = self._main:getChildByFullName("panel")
	self._descBg = self._main:getChildByFullName("descBg")
	self._cellClone = self._main:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	self._leftBtn = self._main:getChildByFullName("left")
	self._rightBtn = self._main:getChildByFullName("right")

	CommonUtils.runActionEffect(self._leftBtn:getChildByFullName("leftBtn"), "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true)
	CommonUtils.runActionEffect(self._rightBtn:getChildByFullName("rightBtn"), "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true)

	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(110, 110, 110, 255)
		}
	}

	self._strengthenWidget = self:bindWidget("main.btnPanel.levelUpBtn", TwoLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickStrengthen, self)
		}
	})

	self._strengthenWidget:setVisible(false)

	self._maxLevel = self._main:getChildByFullName("maxLevel")

	self._maxLevel:setVisible(false)
end

function GalleryMessageInfoMediator:onClickStrengthen(sender, eventType)
	if self._realEnough then
		self._gallerySystem:requestMessageLevelUp(self._legendData:getId(), function()
			return
		end)
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Info_UI12")
		}))
	end
end

function GalleryMessageInfoMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local currencyInfoWidget = systemKeeper:getResourceBannerIds("HerosLegend")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Info_UI07")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	local descBtn = self:getView():getChildByFullName("descBtn")

	descBtn:setPositionX(self._topInfoWidget:getTitleWidth() + 10)
end

function GalleryMessageInfoMediator:initData(data)
	self._legendId = data.id
	self._legendDatas = data.ids or {}
	self._curIdIndex = 1
	self._curPageIndex = nil
	self._canChange = true

	for i = 1, #self._legendDatas do
		if self._legendId == self._legendDatas[i]:getId() then
			self._curIdIndex = i

			break
		end
	end

	self._legendData = self._gallerySystem:getMessageById(self._legendId)
	self._showList = self._legendData:getSkillAttrList()
	self._bgPath = self._legendData:getBigPic()
	self._cellLabels = {}
	self._costPanel = self._main:getChildByFullName("costPanel")
	self._addAnimData = {}
	self._addAnimData.oldArr = {}
	self._addAnimData.newArr = {}
	self._addAnimData.curArr = {}
end

function GalleryMessageInfoMediator:refreshData(arrow)
	if next(self._legendDatas) then
		self._legendData = self._legendDatas[self._curIdIndex]
	end

	self._data.id = self._heroId
	self._legendId = self._legendDatas[self._curIdIndex]:getId()
	self._legendData = self._gallerySystem:getMessageById(self._legendId)
	self._bgPath = self._legendData:getBigPic()
	self._showList = self._legendData:getSkillAttrList()

	self:initBaseView()
	self:initHeroView()
	self:initInfoView()
	self:initCellHeight()
	self:initTableView()
	self:refreshStarUpCostPanel()
	self:refreshAttr(arrow)

	if arrow ~= true then
		AudioEngine:getInstance():playRoleEffect("Se_Alert_Equip_Powerup", false)
		self._strengthenSucc:setVisible(true)
		performWithDelay(self:getView(), function()
			if DisposableObject:isDisposed(self) then
				return
			end

			self._strengthenSucc:setVisible(false)
		end, 1)
	end
end

function GalleryMessageInfoMediator:refreshAttr(arrow)
	local normalSkill = self._legendData:getNormalSkill()
	local skillConfig = ConfigReader:getRecordById("SkillAttrEffect", normalSkill)
	local kAttrType = skillConfig.AttrType

	for i = 1, #kAttrType do
		local attrPanel = self._descBg:getChildByFullName("des_" .. i)
		local level = self._legendData:getLevel()

		if kAttrType[i] then
			local attrType = kAttrType[i]
			local attrName = AttributeCategory:getAttName(attrType)
			local attrNum = SkillAttribute:getAddNumByConfig(skillConfig, i, level)
			local attrText = attrPanel:getChildByFullName("text")

			if self._addAnimData.oldArr[i] == nil then
				if arrow ~= true then
					self._addAnimData.oldArr[i] = SkillAttribute:getAddNumByConfig(skillConfig, i, level - 1)
					self._addAnimData.curArr[i] = SkillAttribute:getAddNumByConfig(skillConfig, i, level - 1)
					self._addAnimData.newArr[i] = SkillAttribute:getAddNumByConfig(skillConfig, i, level)

					if self:checkAndDoLabelAnim(attrType) then
						self:createProgrScheduler()
					else
						self:createProgrScheduler()
						attrText:setString(attrNum)
					end
				else
					self._addAnimData.oldArr[i] = SkillAttribute:getAddNumByConfig(skillConfig, i, level)
					self._addAnimData.curArr[i] = SkillAttribute:getAddNumByConfig(skillConfig, i, level)

					attrText:setString(attrNum)
				end
			else
				self._addAnimData.newArr[i] = SkillAttribute:getAddNumByConfig(skillConfig, i, level)

				if self:checkAndDoLabelAnim(attrType) then
					self:createProgrScheduler()
				else
					self:createProgrScheduler()
					attrText:setString(attrNum)
				end
			end
		end
	end
end

local progrSleepTime = 0.02

function GalleryMessageInfoMediator:createProgrScheduler(sender)
	if self._isDisposed then
		return
	end

	self:closeProgrScheduler()

	if self._progrScheduler == nil then
		self._progrScheduler = LuaScheduler:getInstance():schedule(function()
			self:progrNormalShow(false, sender)
		end, progrSleepTime, false)
	end
end

function GalleryMessageInfoMediator:closeProgrScheduler()
	if self._isDisposed then
		return
	end

	if self._progrScheduler then
		LuaScheduler:getInstance():unschedule(self._progrScheduler)

		self._progrScheduler = nil
	end
end

function GalleryMessageInfoMediator:progrNormalShow(closeCheck, sender)
	if self._isDisposed then
		return
	end

	local stopAll = true
	local normalSkill = self._legendData:getNormalSkill()
	local skillConfig = ConfigReader:getRecordById("SkillAttrEffect", normalSkill)
	local kAttrType = skillConfig.AttrType

	for i = 1, #kAttrType do
		if self._addAnimData.newArr[i] and self:checkStopLabelAnim(i) == false then
			stopAll = false

			local addEatNum = 1
			local addNum = self._addAnimData.newArr[i] - self._addAnimData.oldArr[i]

			if addNum > 5 then
				addEatNum = 2

				if addNum > 20 then
					addEatNum = 6
				end
			end

			self._addAnimData.curArr[i] = self._addAnimData.curArr[i] + addEatNum

			if self._addAnimData.curArr[i] > self._addAnimData.newArr[i] then
				self._addAnimData.curArr[i] = self._addAnimData.newArr[i]
			end

			self:refreshProgrView(i, false)
		end
	end

	if stopAll then
		self:closeProgrScheduler()
	end
end

function GalleryMessageInfoMediator:refreshProgrView(index, toAll)
	local nowExp = tostring(self._addAnimData.curArr[index])
	local attrPanel = self._descBg:getChildByFullName("des_" .. index)

	if attrPanel then
		local attrText = attrPanel:getChildByFullName("text")

		if attrText then
			attrText:setString((toAll or nil) and tostring(self._addAnimData.newArr[index]))
		end
	end
end

function GalleryMessageInfoMediator:setProgrViewToAll()
	self:closeProgrScheduler()

	local normalSkill = self._legendData:getNormalSkill()
	local skillConfig = ConfigReader:getRecordById("SkillAttrEffect", normalSkill)
	local kAttrType = skillConfig.AttrType

	for i = 1, #kAttrType do
		if self._addAnimData.newArr[i] then
			self._addAnimData.oldArr[i] = self._addAnimData.newArr[i]
			self._addAnimData.curArr[i] = self._addAnimData.newArr[i]

			self:refreshProgrView(i, true)
			dump(self._addAnimData.curArr[i], "self._addAnimData.curArr[i")
		end
	end
end

function GalleryMessageInfoMediator:checkAndDoLabelAnim(attrType)
	local result = true
	local normalSkill = self._legendData:getNormalSkill()
	local skillConfig = ConfigReader:getRecordById("SkillAttrEffect", normalSkill)
	local kAttrType = skillConfig.AttrType

	for i = 1, #kAttrType do
		if #self._addAnimData.oldArr <= 0 then
			result = false
		end

		if #self._addAnimData.newArr <= 0 then
			result = false
		end

		if self._addAnimData.newArr[i] ~= nil and self._addAnimData.newArr[i] ~= 0 and self._addAnimData.oldArr[i] == self._addAnimData.newArr[i] then
			result = false
		end
	end

	return (AttributeCategory:getAttNameAttend(attrType) ~= "" or nil) and false
end

function GalleryMessageInfoMediator:checkStopLabelAnim(index)
	local result = true

	if self._addAnimData.newArr[index] then
		if self._addAnimData.curArr[index] < self._addAnimData.newArr[index] then
			result = false
		else
			self._addAnimData.oldArr[index] = self._addAnimData.newArr[index]
			self._addAnimData.curArr[index] = self._addAnimData.newArr[index]
		end
	end

	return result
end

function GalleryMessageInfoMediator:initBaseView()
	self._title:setString(self._legendData:getLevel())
	self._main:getChildByFullName("textName"):setString(self._legendData:getName())
end

function GalleryMessageInfoMediator:initHeroView()
	local path = self._legendData:getSmallPic()
	local portrait = ccui.ImageView:create(path)

	portrait:addTo(self._roleNode)
	portrait:setPosition(cc.p(280, 280))
	portrait:setTouchEnabled(true)
	portrait:addTouchEventListener(function(sender, eventType)
		self:onClickPortrait(sender, eventType)
	end)
end

function GalleryMessageInfoMediator:onClickPortrait(sender, eventType)
	if eventType ~= ccui.TouchEventType.ended then
		return
	end

	local winSize = cc.Director:getInstance():getWinSize()
	local fullScreenLayer = ccui.Layout:create()

	fullScreenLayer:setContentSize(winSize)
	fullScreenLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	fullScreenLayer:setBackGroundColorOpacity(180)
	fullScreenLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	fullScreenLayer:setTouchEnabled(true)
	fullScreenLayer:setLocalZOrder(1000)

	local curScene = cc.Director:getInstance():getRunningScene()

	curScene:addChild(fullScreenLayer)

	local path = self._legendData:getBigPic()
	local fullImg = ccui.ImageView:create(path)

	if fullImg and fullImg:getContentSize().width > 0 then
		fullImg:setPosition(cc.p(winSize.width / 2, winSize.height / 2))
		fullImg:setTouchEnabled(false)

		local imgSize = fullImg:getContentSize()
		local scale = math.min(winSize.width / imgSize.width, winSize.height / imgSize.height)

		fullImg:setScale(scale)
		fullScreenLayer:addChild(fullImg)
	end

	fullScreenLayer:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			sender:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
				sender:removeFromParent()
			end)))
		end
	end)
end

function GalleryMessageInfoMediator:initInfoView()
	local normalSkill = self._legendData:getNormalSkill()
	local cosmetic = self._legendData:getCosmetic()
	local skillConfig = ConfigReader:getRecordById("SkillAttrEffect", normalSkill)
	local kAttrType = skillConfig.AttrType
	local maxLevel = self._legendData:getMaxLevel()
	local skillPicCurrent = self._descBg:getChildByName("skillPicCurrent")

	skillPicCurrent:removeAllChildren()

	local curSPSkillId = self._legendData:getCurSPSkillId()

	for i = 1, #kAttrType do
		local node = self._descBg:getChildByFullName("des_" .. i)
		local image = node:getChildByFullName("image")
		local name = node:getChildByFullName("name")
		local text = node:getChildByFullName("text")
		local extandText = node:getChildByFullName("extandText")

		name:setString(getAttrNameByType(kAttrType[i]))
		image:loadTexture(AttrTypeImage[kAttrType[i]], 1)
		GameStyle:setCommonOutlineEffect(name, 219.29999999999998)
		text:enableOutline(cc.c4b(68, 42, 25, 147.89999999999998), 1)

		local level = self._legendData:getLevel()
		local attrNum = SkillAttribute:getAddNumByConfig(skillConfig, i, level)

		text:setString(attrNum)

		local addNumData = skillConfig.Value[i][2]

		if level < maxLevel then
			extandText:setString("+" .. addNumData)
		end
	end

	for i = 4, #kAttrType + 1, -1 do
		local node = self._descBg:getChildByFullName("des_" .. i)

		node:setVisible(false)
	end

	skillPicCurrent:setVisible(true)

	if cosmetic == 1 then
		local isLock = false

		if curSPSkillId == "" then
			curSPSkillId = self._legendData:getSpecialSkill()[1]
			isLock = true
		end

		local spSkillConfig = ConfigReader:getRecordById("Skill", curSPSkillId)
		local newSkillNode = IconFactory:createHeroSkillIcon({
			id = curSPSkillId,
			isLock = isLock
		}, {
			hideLevel = true
		})

		newSkillNode:addTo(skillPicCurrent):center(skillPicCurrent:getContentSize())
		newSkillNode:setScale(0.5)
		skillPicCurrent:setTouchEnabled(true)
		skillPicCurrent:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickSkill(spSkillConfig)
			end
		end)
	else
		local multiSkillIds = self._legendData:getSpecialSkill()
		local unlockSkills = self._legendData:getCurSkillIds()
		local iconScale = 0.5
		local iconSpacing = 4
		local containerSize = skillPicCurrent:getContentSize()
		local iconCount = #multiSkillIds
		local singleIconWidth = 90
		local totalIconWidth = iconCount * singleIconWidth + (iconCount - 1) * iconSpacing
		local startX = (containerSize.width - totalIconWidth) / 2
		local startY = containerSize.height / 2

		for i, skillId in ipairs(multiSkillIds) do
			local skillConfig = ConfigReader:getRecordById("Skill", skillId)
			local skillIcon = IconFactory:createHeroSkillIcon({
				id = skillId,
				isLock = (tonumber(i) <= #unlockSkills or nil) and false
			}, {
				hideLevel = true
			})
			local iconX = startX + (i - 1) * (singleIconWidth + iconSpacing) + singleIconWidth / 2 - (i - 1) * 45

			skillIcon:setPosition(iconX, startY)
			skillIcon:setScale(iconScale)
			skillIcon:addTo(skillPicCurrent)

			local listener = cc.EventListenerTouchOneByOne:create()

			listener:setSwallowTouches(true)
			listener:registerScriptHandler(function(touch, event)
				local target = event:getCurrentTarget()
				local locationInNode = target:convertToNodeSpace(touch:getLocation())
				local s = target:getContentSize()
				local rect = cc.rect(0, 0, s.width, s.height)

				if cc.rectContainsPoint(rect, locationInNode) then
					local skillShowType = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Master_SkillShowType", "content")

					skillConfig.skillType = skillShowType[i]

					self:onClickSkill(skillConfig, true)

					return true
				end

				return false
			end, cc.Handler.EVENT_TOUCH_BEGAN)

			local eventDispatcher = skillIcon:getEventDispatcher()

			eventDispatcher:addEventListenerWithSceneGraphPriority(listener, skillIcon)
		end

		skillPicCurrent:setTouchEnabled(false)
	end
end

function GalleryMessageInfoMediator:refreshStarUpCostPanel()
	if self._legendData:isMaxLevel() then
		self._maxLevel:setVisible(true)
	end

	self._strengthenWidget:setVisible(true)

	local cost, costIds = self._legendData:getCost()
	local index = 1

	self._realEnough = true

	for i = 1, #costIds do
		local itemId = costIds[i]
		local number = cost[itemId]
		local iconpanel = self._main:getChildByFullName("costNode" .. index .. ".iconpanel")

		self._main:getChildByFullName("costNode" .. index):setVisible(true)
		iconpanel:removeAllChildren()

		local needDebrisNum = number
		local hasDebrisNum = self._developSystem:getBagSystem():getItemCount(itemId)

		self._debrisEngouh = needDebrisNum <= hasDebrisNum

		local icon = IconFactory:createIcon({
			id = itemId
		}, {
			showAmount = false
		})

		icon:setScale(0.46)
		icon:addTo(iconpanel):center(iconpanel:getContentSize())

		local colorNum1 = self._debrisEngouh and 1 or 7

		enoughImg = self._main:getChildByFullName("costNode" .. index .. ".enoughImg")

		enoughImg:setVisible(self._debrisEngouh)

		local costPanel = self._main:getChildByFullName("costNode" .. index .. ".costPanel")

		costPanel:setVisible(true)

		local cost = costPanel:getChildByFullName("cost")
		local costLimit = costPanel:getChildByFullName("costLimit")

		cost:setString(hasDebrisNum)
		costLimit:setString("/" .. needDebrisNum)
		costLimit:setPositionX(cost:getContentSize().width)
		costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width, 40))
		cost:setTextColor(GameStyle:getColor(colorNum1))
		costLimit:setTextColor(GameStyle:getColor(colorNum1))

		addImg = self._main:getChildByFullName("costNode" .. index .. ".addImg")

		local param = {
			isNeed = true,
			hasWipeTip = true,
			itemId = itemId,
			hasNum = hasDebrisNum,
			needNum = needDebrisNum
		}
		local touchPanel = addImg:getChildByFullName("touchPanel")

		touchPanel:setVisible(true)
		touchPanel:setTouchEnabled(true)
		touchPanel:addClickEventListener(function()
			self:onClickItem(param)
		end)
		addImg:setVisible(not self._debrisEngouh)
		iconpanel:setGray(not self._debrisEngouh)

		index = index + 1
		self._realEnough = self._realEnough and self._debrisEngouh
	end
end

function GalleryMessageInfoMediator:onClickItem(param)
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param))
end

function GalleryMessageInfoMediator:initCellHeight()
	local maxLevel = self._legendData:getMaxLevel()
	local index = 1

	for level = 5, maxLevel, 5 do
		local addHeight = 0
		local skillId = self._showList[level]
		local skillConfig = ConfigReader:getRecordById("SkillAttrEffect", skillId)
		local special = false
		local descs

		if skillConfig then
			descs = Strings:get(skillConfig.EffectDesc)
		else
			local tmpSkillId = self._showList[level - 5]
			local tmp = ConfigReader:getRecordById("SkillAttrEffect", tmpSkillId)

			skillConfig = ConfigReader:getRecordById("Skill", skillId)
			descs = Strings:get(tmp.EffectDesc) .. Strings:get("Info_UI20") .. Strings:get(skillConfig.Name)
			special = true
		end

		self._cellLabels[index] = {}

		local attr = self._cellClone:getChildByFullName("attr")

		if descs ~= "" then
			local label = attr:clone()

			label:getVirtualRenderer():setDimensions(316, 0)
			label:setString(descs)
			label:addTo(self:getView())
			label:setVisible(false)

			addHeight = addHeight + label:getContentSize().height
			self._cellLabels[index].label = label
		end

		addHeight = addHeight - attr:getContentSize().height

		if addHeight < 0 then
			addHeight = 0
		end

		local skillNode = self._cellClone:getChildByFullName("skillPic")

		skillNode:setVisible(false)

		if special then
			local label = skillNode:clone()
			local path = "asset/skillIcon/" .. skillConfig.Icon .. ".png"

			label:loadTexture(path)
			label:addTo(self:getView())
			label:setTouchEnabled(true)

			local skill = HeroSkill:new(skillId)

			skill._level = 1
			skill._enable = true
			self._cellLabels[index].labelSkill = label
		end

		self._cellLabels[index].addHeight = addHeight
		index = index + 1
	end

	self._count = index - 1
end

function GalleryMessageInfoMediator:onClickSkill(skill, isMaster)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	if not self._skillWidget then
		self._skillWidget = self:autoManageObject(self:getInjector():injectInto(SkillDescWidget:new(SkillDescWidget:createWidgetNode(), {
			skill = skill,
			mediator = self
		})))

		self._skillWidget:getView():addTo(self:getView())
		self._skillWidget:getView():setPosition(cc.p(700, 150))
	end

	self._skillWidget:refreshMessageInfo(skill, isMaster)
	self._skillWidget:show()
end

function GalleryMessageInfoMediator:createTeamCell(cell, index)
	cell:removeAllChildren()

	local panel = self._cellClone:clone()

	panel:addTo(cell):posite(0, 0)
	panel:setVisible(true)
	panel:setAnchorPoint(0, 0)
	panel:setPosition(10, 0)
	panel:setTouchEnabled(false)
	panel:setSwallowTouches(false)

	local attr = panel:getChildByFullName("attr")
	local skillNode = panel:getChildByFullName("skillPic")

	skillNode:removeAllChildren()
	attr:setString("")
	attr:removeAllChildren()

	local level = self._legendData:getLevel()
	local opacity = level >= index * 5 and 255 or 102

	attr:setOpacity(opacity)

	local di = panel:getChildByFullName("diImage")

	if level >= index * 5 then
		di:loadTexture("bg_dengjidi_lv.png", ccui.TextureResType.plistType)
	end

	local levelDi = panel:getChildByFullName("level")

	levelDi:setString(Strings:get("Info_UI05", {
		level = index * 5
	}))

	local posY = attr:getContentSize().height
	local descLabel = self._cellLabels[index].label

	if descLabel then
		local label = descLabel:clone()

		label:setVisible(true)
		label:addTo(attr):posite(0, posY)
	end

	local skillLabel = self._cellLabels[index].labelSkill

	if skillLabel then
		skillNode:setVisible(true)

		local label = skillLabel:clone()

		label:setVisible(true)
		label:addTo(skillNode):posite(20, 22)
	end
end

function GalleryMessageInfoMediator:initTableView()
	self._tableViewPanel:removeAllChildren()

	local width, height = self._tableViewPanel:getContentSize().width, self._cellClone:getContentSize().height

	local function scrollViewDidScroll(view)
		if DisposableObject:isDisposed(self) then
			return
		end

		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		return width, height
	end

	local function numberOfCellsInTableView(table)
		return self._count
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createTeamCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(self._tableViewPanel:getContentSize())

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._tableViewPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()
end

function GalleryMessageInfoMediator:onClickHeroIcon(id)
	local view = self:getInjector():getInstance("HeroShowNotOwnView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		showType = 3,
		id = id
	}))
end

function GalleryMessageInfoMediator:onClickLeft()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	self._curIdIndex = self._curIdIndex - 1

	if self._curIdIndex <= 1 then
		self._curIdIndex = 1
	end

	self._addAnimData = {}
	self._addAnimData.oldArr = {}
	self._addAnimData.newArr = {}
	self._addAnimData.curArr = {}

	self:refreshData(true)
	self:refreshArrowState()
end

function GalleryMessageInfoMediator:onClickRight()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	self._curIdIndex = self._curIdIndex + 1

	if self._curIdIndex >= #self._legendDatas then
		self._curIdIndex = #self._legendDatas
	end

	self._addAnimData = {}
	self._addAnimData.oldArr = {}
	self._addAnimData.newArr = {}
	self._addAnimData.curArr = {}

	self:refreshData(true)
	self:refreshArrowState()
end

function GalleryMessageInfoMediator:refreshArrowState()
	self._leftBtn:setVisible(self._curIdIndex ~= 1 and #self._legendDatas > 0)
	self._rightBtn:setVisible(self._curIdIndex ~= #self._legendDatas and #self._legendDatas > 0)
end

function GalleryMessageInfoMediator:updateData()
	self._legendData = self._gallerySystem:getMessageById(self._legendId)
	self._showList = self._legendData:getSkillAttrList()
end

function GalleryMessageInfoMediator:updateView()
	self:initHeroView()
	self:initInfoView()
	self._tableView:stopScroll()
	self._tableView:reloadData()
end

function GalleryMessageInfoMediator:refreshBySync()
	self:updateData()
	self:updateView()
end

function GalleryMessageInfoMediator:onClickShowTips(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._tipsPanel:setVisible(true)
		self._tipsTouchPanel:setVisible(true)
	end
end

function GalleryMessageInfoMediator:onClickHideTips(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._tipsPanel:setVisible(false)
		self._tipsTouchPanel:setVisible(false)
	end
end

function GalleryMessageInfoMediator:onClickBack()
	self:dismiss()
end
