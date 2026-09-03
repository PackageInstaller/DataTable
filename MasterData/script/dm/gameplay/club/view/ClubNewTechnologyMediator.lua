-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubNewTechnologyMediator.lua

ClubNewTechnologyMediator = class("ClubNewTechnologyMediator", DmAreaViewMediator)

ClubNewTechnologyMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
ClubNewTechnologyMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	["main.bottomnode.Panel_totaldonation.btn"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onClickTotalPanel"
	}
}

function ClubNewTechnologyMediator:initialize()
	super.initialize(self)
end

function ClubNewTechnologyMediator:dispose()
	super.dispose(self)
end

function ClubNewTechnologyMediator:userInject()
	return
end

function ClubNewTechnologyMediator:onRegister()
	super.onRegister(self)

	self._view = self:getView()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function ClubNewTechnologyMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_FORCEDLEVEL, self, self.onForcedLevel)
end

function ClubNewTechnologyMediator:enterWithData(data)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBDONATE_SUCC, self, self.updateView)

	self._tableViewCache = {}
	self._technologys = self._clubSystem:getTechnologyListOj()
	self._technologyList = self._technologys:getList()

	self:initeNode()
	self:setupTopInfoWidget()
	self:createHeroPanel()
	self:createTableView()
	self:refreshView()
end

function ClubNewTechnologyMediator:initeNode()
	self._mainPanel = self._view:getChildByFullName("main")
	self._listPanel = self._mainPanel:getChildByFullName("listPanel")
	self._bottomNode = self._mainPanel:getChildByName("bottomnode")
	self._pointCellPanel = self._view:getChildByName("cellPanel")

	self._pointCellPanel:setVisible(false)

	self._bubble = self._view:getChildByName("Panel_bubble")

	self._bubble:setVisible(false)
	self._bubble:setSwallowTouches(false)
	self._bubble:addClickEventListener(function()
		self._bubble:setVisible(false)
	end)
end

function ClubNewTechnologyMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(999)

	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Club_System")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		hasAnim = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("ClubNew_UI_25")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ClubNewTechnologyMediator:createHeroPanel()
	local modelIdData = ConfigReader:getRecordById("ConfigValue", "Club_ScientificHero")
	local heroPanel = self._mainPanel:getChildByName("heroPanel")
	local modelSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = (modelIdData or nil) and ConfigReader:getRecordById("ConfigValue", "Club_ScientificHero").content
	})

	modelSprite:setScale(1.2)
	modelSprite:setPosition(cc.p(300, 150))
	heroPanel:addChild(modelSprite)
end

function ClubNewTechnologyMediator:refreshView()
	local todayDonation = self._clubSystem:getClubInfoOj():getTodayDonation()
	local donationLimit = self._clubSystem:getDonateLimit()
	local totalPanel = self._bottomNode:getChildByName("Panel_totaldonation")
	local totalNum = totalPanel:getChildByFullName("progbackimg.Text_pro")
	local donationNum = math.min(todayDonation, donationLimit)

	totalNum:setString(donationNum .. "/" .. donationLimit)

	local loadingbar = totalPanel:getChildByFullName("progbackimg.loadingbar")

	loadingbar:setPercent(donationNum / donationLimit * 100)

	local todayNum = self._bottomNode:getChildByName("todaynum")
	local curCount = self._clubSystem:getClub():getCurDonateCount()

	todayNum:setString(curCount .. "/" .. self._clubSystem:getMaxDonateCount())
end

function ClubNewTechnologyMediator:createCell(cell, idx, viewType)
	local technology = self._technologyList[viewType]
	local techPoints = technology:getTechPoints()
	local pointData = techPoints[idx]

	if pointData then
		local bgPanel_1 = cell:getChildByName("bgPanel_1")
		local bgPanel_2 = cell:getChildByName("bgPanel_2")

		if idx == 1 then
			bgPanel_2:setVisible(false)
		end

		local lineGradiantVec = {
			{
				ratio = 0.7,
				color = cc.c4b(255, 255, 255, 255)
			},
			{
				ratio = 1,
				color = cc.c4b(3, 1, 4, 255)
			}
		}
		local nameLabel = cell:getChildByName("titleText")

		nameLabel:setString(pointData:getName())

		local lineGradiantVec3 = {
			{
				ratio = 0.7,
				color = cc.c4b(255, 255, 255, 255)
			},
			{
				ratio = 1,
				color = cc.c4b(129, 118, 113, 255)
			}
		}
		local levelLabel = cell:getChildByName("level")
		local progressBar = cell:getChildByName("progbackimg")
		local progrLoading = progressBar:getChildByFullName("loadingbar")
		local proLabel = progressBar:getChildByName("Text_pro")

		proLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec3, {
			x = 0,
			y = -1
		}))

		local curEffectPanel = cell:getChildByName("Panel_desc")
		local limit_max = cell:getChildByName("limit_max")
		local limitPanel = cell:getChildByName("limitPanel")

		limitPanel:setVisible(false)

		local donateBtn = cell:getChildByName("Button_donate")

		donateBtn:getChildByName("name1"):setString(Strings:get("UITitle_EN_Juanxian"))

		local isUnlock = self._clubSystem:isTechUnlock(pointData:getUnlockCondition())

		if isUnlock then
			levelLabel:setVisible(true)

			local pointLevel = pointData:getLevel()

			if pointLevel < pointData:getMaxLevel() then
				levelLabel:setString("Lv." .. pointLevel)
				limit_max:setVisible(false)
				donateBtn:setVisible(true)
			else
				levelLabel:setString(Strings:get("Club_Contribute_UI2"))
				donateBtn:setVisible(false)
				proLabel:setVisible(false)
				limit_max:setVisible(true)
			end

			progressBar:setVisible(true)

			local percent = pointData:getExp() / pointData:getUpgradeExp() * 100
			local curExp = pointData:getExp()

			if pointLevel == pointData:getMaxLevel() then
				percent = 100
				curExp = pointData:getUpgradeExp()
			end

			progrLoading:setPercent(percent)
			proLabel:setString(curExp .. "/" .. pointData:getUpgradeExp())
			curEffectPanel:setVisible(true)
			self:createEffectDesc(curEffectPanel, pointData, pointLevel)
			donateBtn:setTouchEnabled(true)

			local function callFunc(sender, eventType)
				self:onDonateClick(pointData:getPointId(), technology:getId())
			end

			mapButtonHandlerClick(nil, donateBtn, {
				ignoreClickAudio = true,
				func = callFunc
			})
		else
			limitPanel:setVisible(true)
			levelLabel:setVisible(false)
			progressBar:setVisible(false)
			limit_max:setVisible(false)
			self:createEffectDesc(curEffectPanel, pointData, 1)
			donateBtn:setVisible(false)

			local limitText = limitPanel:getChildByName("limitText")
			local condition = pointData:getUnlockCondition()

			if condition.ClubLevel and condition.ClubLevel > self._clubSystem:getLevel() then
				limitText:setString(Strings:get("Club_Contribute_UI12", {
					level = condition.ClubLevel
				}))
			end

			local developSystem = self:getInjector():getInstance(DevelopSystem)
			local playerLevel = developSystem:getPlayer():getLevel()

			if condition.LEVEL and playerLevel < condition.LEVEL then
				limitText:setString(Strings:get("Club_Contribute_UI5", {
					level = condition.LEVEL
				}))
			end
		end
	end
end

local sizeMap = {
	18,
	18,
	18
}
local heightMap = {
	25,
	25,
	20
}

function ClubNewTechnologyMediator:createEffectDesc(panel, pointData, level)
	local descPanel = panel

	descPanel:removeAllChildren()

	local descIdList = {}

	for i = 1, 3 do
		local descId = pointData:getDescByIndex(i)

		if descId and descId ~= "" then
			descIdList[#descIdList + 1] = descId
		end
	end

	local localLanguage = getCurrentLanguage()
	local labelH = 0

	for i = 1, #descIdList do
		local fontSize = sizeMap[#descIdList]
		local currentValue = pointData:getDescValue(i, level)
		local nextValue = pointData:getDescValue(i, level + 1)
		local str = Strings:get(descIdList[i], {
			fontSize = fontSize,
			fontName = TTF_FONT_FZYH_M,
			Value = pointData:getDescValue(i, level),
			Value1 = (currentValue < nextValue or nil) and " + " .. nextValue - currentValue
		})
		local descLabel = ccui.RichText:createWithXML(str, {})

		if localLanguage ~= GameLanguageType.CN then
			descLabel:setAnchorPoint(cc.p(0, 1))
			descLabel:setScale(0.9)
			descLabel:setVerticalSpace(-1)
			descLabel:ignoreContentAdaptWithSize(false)
			descLabel:setContentSize(cc.size(descPanel:getContentSize().width * 1.05, 0))
			descLabel:rebuildElements(true)
			descLabel:formatText()
			descLabel:setPosition(10, 65 - labelH)

			labelH = descLabel:getContentSize().height * 0.9
		else
			descLabel:setAnchorPoint(cc.p(0, 0.5))
			descLabel:ignoreContentAdaptWithSize(true)
			descLabel:renderContent()
			descLabel:setPosition(10, 45 - (i - 1) * heightMap[#descIdList])
		end

		descLabel:addTo(descPanel)
	end
end

function ClubNewTechnologyMediator:createTableView()
	local tableView = cc.TableView:create(self._listPanel:getContentSize())

	local function scrollViewDidScroll(view)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		local cellSize = self._pointCellPanel:getContentSize()

		return cellSize.width + 76, cellSize.height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._pointCellPanel:clone()

			sprite:setPosition(5, 0)
			cell:addChild(sprite)
			sprite:setVisible(true)
			sprite:setTag(123)

			local cell_Old = cell:getChildByTag(123)

			self:createCell(cell_Old, idx + 1, 1)
			cell:setTag(idx)
		else
			local cell_Old = cell:getChildByTag(123)

			self:createCell(cell_Old, idx + 1, 1)
			cell:setTag(idx)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		local techPoints = self._technologyList[1]:getTechPoints()

		return #techPoints
	end

	tableView:setTag(1234)

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._listPanel:addChild(tableView, 900)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()
end

function ClubNewTechnologyMediator:getTableViewByType()
	if not self._tableView then
		self:createTableView()
		self:refreshView()
	end

	return self._tableView
end

function ClubNewTechnologyMediator:updateView()
	self._technologys = self._clubSystem:getTechnologyListOj()
	self._technologyList = self._technologys:getList()

	if self._tableView then
		self._tableView:reloadData()
	end

	self:refreshView()
end

function ClubNewTechnologyMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ClubNewTechnologyMediator:onDonateClick(pointId, techId)
	if self._clubSystem:getClub():getCurDonateCount() < 1 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Contribute_Tip1")
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local view = self:getInjector():getInstance("ClubDonationView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		pointId = pointId,
		techId = techId
	})

	self:dispatch(event)
end

function ClubNewTechnologyMediator:onClickTotalPanel(sender, eventType)
	if eventType == ccui.TouchEventType.ended and not self._bubble:isVisible() then
		self._bubble:setVisible(true)
	end
end

function ClubNewTechnologyMediator:onForcedLevel(event)
	self:dismiss()
end
