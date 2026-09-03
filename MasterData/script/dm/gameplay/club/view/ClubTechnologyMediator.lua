-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubTechnologyMediator.lua

ClubTechnologyMediator = class("ClubTechnologyMediator", DmAreaViewMediator, _M)

ClubTechnologyMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.bottomnode.Panel_totaldonation.btn"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onClickTotalPanel"
	}
}

function ClubTechnologyMediator:initialize()
	super.initialize(self)
end

function ClubTechnologyMediator:dispose()
	super.dispose(self)
end

function ClubTechnologyMediator:userInject()
	return
end

function ClubTechnologyMediator:onRegister()
	super.onRegister(self)

	self._view = self:getView()

	self:mapButtonHandlersClick(kBtnHandlers)
end

function ClubTechnologyMediator:enterWithData(data)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBDONATE_SUCC, self, self.updateView)

	self._tableViewCache = {}
	self._technologys = self._clubSystem:getTechnologyListOj()
	self._technologyList = self._technologys:getList()

	self:initeNode()
	self:initTabController(data)
	self:refreshView()
end

function ClubTechnologyMediator:initeNode()
	self._mainPanel = self._view:getChildByFullName("main")
	self._tabPanel = self._mainPanel:getChildByFullName("tab_panel")
	self._bottomNode = self._mainPanel:getChildByName("bottomnode")
	self._pointCellPanel = self._view:getChildByName("pointcell")

	self._pointCellPanel:setVisible(false)

	self._bubble = self._view:getChildByName("Panel_bubble")

	self._bubble:setVisible(false)

	self._tabPanel = self:getView():getChildByName("tab_panel")
end

function ClubTechnologyMediator:refreshView()
	local todayDonation = self._clubSystem:getClubInfoOj():getTodayDonation()
	local donationLimit = self._clubSystem:getDonateLimit()
	local totalPanel = self._bottomNode:getChildByName("Panel_totaldonation")
	local totalNum = totalPanel:getChildByName("totalnum")
	local donationNum = math.min(todayDonation, donationLimit)

	totalNum:setString(donationNum .. "/" .. donationLimit)

	local todayNum = self._bottomNode:getChildByName("todaynum")
	local curCount = self._clubSystem:getClub():getCurDonateCount()

	todayNum:setString(curCount .. "/" .. self._clubSystem:getMaxDonateCount())
end

function ClubTechnologyMediator:createCell(cell, idx, viewType)
	local technology = self._technologyList[viewType]
	local techPoints = technology:getTechPoints()
	local pointData = techPoints[idx]

	if pointData then
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
		local nameLabel = cell:getChildByName("CellTitle")

		nameLabel:setString(pointData:getName())
		nameLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec, {
			x = 0,
			y = -1
		}))

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

		local curEffectPanel = cell:getChildByName("Panel_cureffect")
		local nextEffectPanel = cell:getChildByName("Panel_nexteffect")
		local maxImgBg = cell:getChildByName("Image_maxbg")
		local maxImg = maxImgBg:getChildByName("Image_max")
		local donateBtn = cell:getChildByName("Button_donate")

		donateBtn:getChildByName("name1"):setString(Strings:get("UITitle_EN_Juanxian"))

		local isUnlock = self._clubSystem:isTechUnlock(pointData:getUnlockCondition())

		if isUnlock then
			levelLabel:setVisible(true)

			local pointLevel = pointData:getLevel()

			if pointLevel < pointData:getMaxLevel() then
				levelLabel:setString("Lv." .. pointLevel)
				maxImgBg:setVisible(false)
				nextEffectPanel:setVisible(true)
				donateBtn:setVisible(true)
				self:createEffectDesc(nextEffectPanel, pointData, pointLevel + 1)
			else
				levelLabel:setString(Strings:get("Club_Contribute_UI2"))
				nextEffectPanel:setVisible(false)
				donateBtn:setVisible(false)
				proLabel:setVisible(false)

				local lineGradiantVec2 = {
					{
						ratio = 0.8,
						color = cc.c4b(223, 255, 46, 255)
					},
					{
						ratio = 0.2,
						color = cc.c4b(156, 224, 3, 255)
					}
				}

				maxImgBg:setVisible(true)
				maxImg:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
				maxImg:enableOutline(cc.c4b(3, 1, 4, 255), 1)
				maxImg:setString(Strings:get("Club_Text203"))
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

			if self._clubSystem:getClub():getCurDonateCount() < 1 then
				-- block empty
			end
		else
			maxImgBg:setVisible(true)
			maxImg:setColor(cc.c3b(255, 255, 255))
			maxImg:enableOutline(cc.c4b(3, 1, 4, 255), 1)
			levelLabel:setVisible(false)
			progressBar:setVisible(false)
			self:createEffectDesc(curEffectPanel, pointData, 1)
			self:createEffectDesc(nextEffectPanel, pointData, 2)
			donateBtn:setVisible(false)

			local condition = pointData:getUnlockCondition()

			if condition.ClubLevel and condition.ClubLevel > self._clubSystem:getLevel() then
				maxImg:setString(Strings:get("Club_Contribute_UI12", {
					level = condition.ClubLevel
				}))
			end

			local developSystem = self:getInjector():getInstance(DevelopSystem)
			local playerLevel = developSystem:getPlayer():getLevel()

			if condition.LEVEL and playerLevel < condition.LEVEL then
				maxImg:setString(Strings:get("Club_Contribute_UI5", {
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

function ClubTechnologyMediator:createEffectDesc(panel, pointData, level)
	local text = panel:getChildByName("text")
	local descPanel = panel:getChildByName("Panel_desc")

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
		local str = Strings:get(descIdList[i], {
			fontSize = fontSize,
			fontName = TTF_FONT_FZYH_M,
			Value = pointData:getDescValue(i, level)
		})
		local descLabel = ccui.RichText:createWithXML(str, {})

		if localLanguage ~= GameLanguageType.CN then
			descLabel:setAnchorPoint(cc.p(0, 1))
			descLabel:setScale(0.9)
			descLabel:setVerticalSpace(-1)
			descLabel:ignoreContentAdaptWithSize(false)
			descLabel:setContentSize(cc.size(descPanel:getContentSize().width * 1.2, 0))
			descLabel:rebuildElements(true)
			descLabel:formatText()
			descLabel:setPosition(-5, 65 - labelH)

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

function ClubTechnologyMediator:createTableView(viewType)
	local tableView = cc.TableView:create(cc.size(864, 516))

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

			self:createCell(cell_Old, idx + 1, viewType)
			cell:setTag(idx)
		else
			local cell_Old = cell:getChildByTag(123)

			self:createCell(cell_Old, idx + 1, viewType)
			cell:setTag(idx)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		local techPoints = self._technologyList[viewType]:getTechPoints()

		return #techPoints
	end

	tableView:setTag(1234)

	self._tableViewCache[viewType] = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setPosition(253, 68)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._mainPanel:addChild(tableView, 900)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()
end

function ClubTechnologyMediator:initTabController(data)
	self._curTabIndex = data and data.index and data.index or 1

	self:createTabTouch()
end

function ClubTechnologyMediator:createTabTouch()
	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	local btnDatas = {}

	for i = 1, #self._technologyList do
		local data = self._technologyList[i]
		local isUnlock = self._clubSystem:isTechUnlock(data:getUnlockCondition())

		if isUnlock then
			local nameStr = data:getName()

			btnDatas[#btnDatas + 1] = {
				tabText = nameStr
			}
		end
	end

	local config = {
		onClickTab = function(name, tag)
			self._tabBtnWidget._style.ignoreSound = true

			self:onClickTab(name, tag)
		end
	}

	config.btnDatas = btnDatas

	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabIndex)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabPanel):posite(0, 0)
	view:setLocalZOrder(1100)
end

function ClubTechnologyMediator:onClickTab(name, tag)
	local curTechId = self._technologyList[tag]:getId()

	self._clubSystem:requestTargetDonationInfo(curTechId, function()
		self:setLayout(tag)
	end)
end

function ClubTechnologyMediator:setLayout(tag)
	self._curTabIndex = tag

	for _, view in pairs(self._tableViewCache) do
		view:setVisible(false)
	end

	self._selectTableView = self:getTableViewByType(tag)

	if self._selectTableView then
		self._selectTableView:setVisible(true)
		self:refreshView()
	end
end

function ClubTechnologyMediator:getTableViewByType(viewType)
	if not self._tableViewCache[viewType] then
		self:createTableView(viewType)
		self:refreshView()
	end

	return self._tableViewCache[viewType]
end

function ClubTechnologyMediator:updateView()
	self._technologys = self._clubSystem:getTechnologyListOj()
	self._technologyList = self._technologys:getList()

	local tableView = self._tableViewCache[self._curTabIndex]

	if tableView then
		tableView:reloadData()
	end

	self:refreshView()
end

function ClubTechnologyMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ClubTechnologyMediator:onDonateClick(pointId, techId)
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

function ClubTechnologyMediator:onClickTotalPanel(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._bubble:setVisible(true)
	elseif eventType == ccui.TouchEventType.ended then
		self._bubble:setVisible(false)
	elseif eventType == ccui.TouchEventType.canceled then
		self._bubble:setVisible(false)
	end
end
