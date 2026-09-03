-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ResourceDoubleActivityMediator.lua

ResourceDoubleActivityMediator = class("ResourceDoubleActivityMediator", DmPopupViewMediator, _M)

ResourceDoubleActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local lightColor = cc.c3b(180, 180, 180)
local darkColor = cc.c3b(50, 41, 41)

function ResourceDoubleActivityMediator:initialize()
	super.initialize(self)
end

function ResourceDoubleActivityMediator:dispose()
	super.dispose(self)
end

function ResourceDoubleActivityMediator:onRegister()
	self:bindWidgets()
	super.onRegister(self)
end

function ResourceDoubleActivityMediator:enterWithData(data)
	self._activity = data.activity
	self._activityId = self._activity:getId()
	self._parentMediator = data.parentMediator
	self._cloneCell = self:getView():getChildByFullName("cloneCell")
	self._main = self:getView():getChildByName("main")
	self._activityConfig = self._activity:getActivityConfig()
	self._listView = self._main:getChildByName("ListView")

	self._listView:setScrollBarEnabled(false)
	self:setupView()
	self:refreshUIView()
end

function ResourceDoubleActivityMediator:bindWidgets()
	self:bindWidget("main.btn_go", OneLevelMainButton, {
		buttonName = "DoubleDropsTitle03",
		handler = bind1(self.onClickGo, self)
	})
end

function ResourceDoubleActivityMediator:setupView()
	self._main:getChildByFullName("refreshPanel.times"):setString(self._activity:getTimeStr1())
end

function ResourceDoubleActivityMediator:getLastRewardDay()
	self._selectTag = 0

	for i = 1, #self._loginDayList do
		local taskInfo = self._loginDayList[i]
		local status = taskInfo:getStatus()

		if status == ActivityTaskStatus.kFinishNotGet then
			self._selectTag = i

			break
		end
	end
end

function ResourceDoubleActivityMediator:createTableView()
	local tableView = cc.TableView:create(cc.size(770, 330))

	local function scrollViewDidScroll(view)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		local size = self._cloneCell:getContentSize()

		return size.width, size.height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:updateCell(cell, idx + 1)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._loginDayList
	end

	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(cc.p(218, 85))
	tableView:addTo(self._main)
	tableView:setDelegate()
	tableView:setBounceable(false)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()

	self._tableView = tableView
end

function ResourceDoubleActivityMediator:updateCell(cell, index)
	local taskInfo = self._loginDayList[index]
	local status = taskInfo:getStatus()
	local reward = taskInfo:getReward()
	local cloneCell = cell:getChildByName("main")

	if not cloneCell then
		cloneCell = self._cloneCell:clone()

		cloneCell:addTo(cell):setName("main")
		cloneCell:setPosition(cc.p(0, 8))
		cloneCell:getChildByName("num1"):ignoreContentAdaptWithSize(true)
	end

	local spDay = self._activityConfig.specailDay
	local title = cloneCell:getChildByName("titleBg")

	title:getChildByName("num"):setString(index)

	local num1Image = cloneCell:getChildByName("num1")

	num1Image:loadTexture("hd_14r_d" .. index .. ".png", 1)

	local select = cloneCell:getChildByName("bgSelect")
	local unselect = cloneCell:getChildByName("bgUnselect")
	local finishAndGetView = cloneCell:getChildByName("finishAndGet")

	title:loadTexture("hd_14r_btn_hdi.png", ccui.TextureResType.plistType)
	title:getChildByName("text1"):setTextColor(lightColor)
	title:getChildByName("text2"):setTextColor(lightColor)
	title:getChildByName("num"):setTextColor(cc.c3b(255, 255, 255))

	local cellBgImg = self._activityConfig.cellBgImg
	local cellTitleImg = self._activityConfig.cellTitleImg

	if status == ActivityTaskStatus.kGet then
		finishAndGetView:setVisible(true)
		unselect:setVisible(false)
		select:setVisible(false)

		if cellBgImg then
			if not cellBgImg[5] then
				local path = "hd_14r_btn_ylq"

				finishAndGetView:loadTexture(path .. ".png", ccui.TextureResType.plistType)
			end
		end
	else
		finishAndGetView:setVisible(false)

		if table.indexof(spDay, index) then
			if not cellBgImg[1] then
				local selectPath = "hd_14r_btn_wxz_j"

				if not cellBgImg[2] then
					local unselectPath = "hd_14r_btn_xz_j"

					select:loadTexture(selectPath .. ".png", ccui.TextureResType.plistType)
					unselect:loadTexture(unselectPath .. ".png", ccui.TextureResType.plistType)
				end
			end
		end

		if not cellBgImg[3] then
			do
				local selectPath = "hd_14r_btn_wxz"

				if not cellBgImg[4] then
					local unselectPath = "hd_14r_btn_xz"

					select:loadTexture(selectPath .. ".png", ccui.TextureResType.plistType)
					unselect:loadTexture(unselectPath .. ".png", ccui.TextureResType.plistType)
				end
			end

			if index == self._selectTag then
				select:setVisible(false)
				unselect:setVisible(true)

				do
					local path = cellTitleImg or "hd_14r_btn_ldi"

					title:loadTexture(path .. ".png", ccui.TextureResType.plistType)
					title:getChildByName("text1"):setTextColor(darkColor)
					title:getChildByName("text2"):setTextColor(darkColor)
					title:getChildByName("num"):setTextColor(darkColor)
				end

				goto label_15_1
			end
		end

		select:setVisible(true)
		unselect:setVisible(false)
	end

	::label_15_1::

	local iconNode = cloneCell:getChildByName("rewardIcon")

	iconNode:removeAllChildren()

	local rewardData = reward.Content[1]
	local icon = IconFactory:createRewardIcon(rewardData, {
		isWidget = true
	})

	icon:setScaleNotCascade(0.6)
	icon:setSwallowTouches(false)
	icon:addTo(iconNode):center(iconNode:getContentSize())

	cell.icon = icon

	if status == ActivityTaskStatus.kGet then
		icon:setColor(cc.c3b(120, 120, 120))

		local iamge = ccui.ImageView:create("hd_14r_btn_go.png", ccui.TextureResType.plistType)

		iamge:addTo(iconNode):center(iconNode:getContentSize())
	end

	if self._parentMediator then
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), rewardData, {
			needDelay = true
		})
	else
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
			needDelay = true
		})
	end

	local rewardName = RewardSystem:getName(rewardData)
	local rewardNameStr = cloneCell:getChildByName("name")

	rewardNameStr:setString(rewardName)

	local strlen = utf8.len(rewardName)

	if strlen > 6 then
		rewardNameStr:setFontSize(14)
	else
		rewardNameStr:setFontSize(18)
	end

	if status == ActivityTaskStatus.kGet then
		rewardNameStr:setTextColor(cc.c3b(164, 160, 160))
		rewardNameStr:enableOutline(cc.c3b(0, 0, 0), 2)
	else
		rewardNameStr:setTextColor(cc.c3b(255, 255, 255))
		rewardNameStr:enableOutline(cc.c3b(83, 72, 54), 2)
	end

	local touchPanel = cloneCell:getChildByName("touchPanel")

	touchPanel:setSwallowTouches(false)
	touchPanel:addClickEventListener(function()
		self:touchCell(index)
	end)
end

function ResourceDoubleActivityMediator:touchCell(index)
	local cell = self._tableView:cellAtIndex(index - 1)

	if cell and cell.icon and cell.icon.isReturn then
		return
	end

	local taskInfo = self._loginDayList[index]
	local status = taskInfo:getStatus()

	if status == ActivityTaskStatus.kUnfinish then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Extra_Login_Lock", {
				num = index
			})
		}))
	elseif status == ActivityTaskStatus.kFinishNotGet then
		if self._selectTag == index then
			self:requsetGetReward(self._activity:getId(), taskInfo:getId())
		else
			self._selectTag = index

			local offX = self._tableView:getContentOffset().x

			self._tableView:reloadData()
			self._tableView:setContentOffset(cc.p(offX, 0))
		end
	elseif status == ActivityTaskStatus.kGet then
		-- block empty
	end
end

function ResourceDoubleActivityMediator:requsetGetReward(activityId, taskId)
	local data = {
		doActivityType = 101,
		taskId = taskId
	}

	self._activitySystem:requestDoActivity(activityId, data, function(response)
		if checkDependInstance(self) then
			self:getLastRewardDay()

			local offX = self._tableView:getContentOffset().x

			self._tableView:reloadData()
			self._tableView:setContentOffset(cc.p(offX, 0))

			local rewards = response.data.reward

			if rewards then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = rewards
				}))
			end
		end
	end)
end

function ResourceDoubleActivityMediator:refreshUIView()
	self._main:getChildByName("Text_24"):setString("")
	self._main:getChildByFullName("refreshPanel"):setLocalZOrder(99)

	if not self._activityConfig.titleImg then
		if not self._activityConfig.titleTxt then
			if not self._activityConfig.descTxt then
				local descTxt = "desc"

				self._main:getChildByFullName("Text_24"):setString(Strings:get(descTxt))

				local desc = self._activityConfig.descTxt2
				local label = ccui.RichText:createWithXML(Strings:get(desc, {
					fontSize = 24,
					fontName = TTF_FONT_FZYH_M
				}), {})

				label:setVerticalSpace(8)
				label:ignoreContentAdaptWithSize(true)
				label:rebuildElements()
				label:formatText()
				label:renderContent(560, 0)
				self._listView:pushBackCustomItem(label)
			end
		end
	end
end

function ResourceDoubleActivityMediator:onClickGo(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local actConfig = self._activity:getActivityConfig()
		local url = actConfig.link
		local param = {}

		self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
			url = url,
			extParams = param
		}))
	end
end
