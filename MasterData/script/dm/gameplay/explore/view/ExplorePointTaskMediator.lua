-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExplorePointTaskMediator.lua

ExplorePointTaskMediator = class("ExplorePointTaskMediator", DmPopupViewMediator, _M)

ExplorePointTaskMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")

local kBtnHandlers = {}

function ExplorePointTaskMediator:initialize()
	super.initialize(self)
end

function ExplorePointTaskMediator:dispose()
	super.dispose(self)
end

function ExplorePointTaskMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ExplorePointTaskMediator:enterWithData(data)
	self._mapData = self._exploreSystem:getMapTypesDic(data.id)
	self._showData = self._exploreSystem:getMapTasksById(data.id)

	self:initView()
end

function ExplorePointTaskMediator:initView()
	self._main = self:getView():getChildByName("main")
	self._touchPanel = self:getView():getChildByName("touchPanel")

	self._touchPanel:setVisible(false)
	self._touchPanel:setSwallowTouches(false)
	self._touchPanel:addClickEventListener(function()
		if self._touchPanel:isVisible() then
			self._touchPanel:setVisible(false)
		end
	end)

	local bg = self._touchPanel:getChildByFullName("bg")
	local text = self._touchPanel:getChildByFullName("bg.text")

	text:getVirtualRenderer():setMaxLineWidth(325)
	bg:setContentSize(cc.size(text:getAutoRenderSize().width + 50, text:getAutoRenderSize().height + 21))
	text:setPositionY(bg:getContentSize().height / 2)

	local bgNode = self._main:getChildByFullName("bgNode")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		bgSize = {
			width = 837,
			height = 503
		},
		title = Strings:get("EXPLORE_UI17"),
		title1 = Strings:get("UITitle_EN_Tansuorenwuxiangqing"),
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 40 or nil
	})

	local titleText = bgNode:getChildByFullName("title_node.Text_1")
	local titleTextWidth = titleText:getContentSize().width

	self:getView():getChildByFullName("main.tipBtn"):setPositionX(bgNode:getPositionX() + titleTextWidth + 90)

	self._rewardPanel = self._main:getChildByName("rewardPanel")
	self._taskPanel = self._main:getChildByName("taskPanel")
	self._loadingBg = self._rewardPanel:getChildByName("loadingBg")

	local loadingBar = self._loadingBg:getChildByName("loadingBar")

	loadingBar:setScale9Enabled(true)
	loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))

	self._rewardClone = self._loadingBg:getChildByName("clonePanel")

	self._rewardClone:setVisible(false)

	self._taskClone = self._main:getChildByName("taskClone")

	self._taskClone:setVisible(false)

	self._titleClone = self._main:getChildByName("titleClone")
	self._desc = self._titleClone:getChildByName("desc")

	self._titleClone:setVisible(false)
	GameStyle:setCommonOutlineEffect(self._taskClone:getChildByFullName("desc"))
	GameStyle:setCommonOutlineEffect(self._taskClone:getChildByFullName("num"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("text"))
	self:updateProgress()
	self:updateTask()
end

function ExplorePointTaskMediator:updateProgress()
	local dpMax = self._mapData:getTotalTaskDp()
	local progress = self._main:getChildByName("progress")
	local progress1 = self._main:getChildByName("progress1")

	progress:setString(self._mapData:getDpNum())
	progress1:setString("/" .. dpMax)

	local loadingBar = self._loadingBg:getChildByName("loadingBar")

	loadingBar:setPercent(self._mapData:getDpNum() / dpMax * 100)
end

function ExplorePointTaskMediator:getSizeCell(idx)
	local cellHeight = self._taskClone:getContentSize().height
	local cellHeight1 = self._titleClone:getContentSize().height
	local data = self._showData[idx + 1]
	local height = data.type == "title" and cellHeight1 or cellHeight

	if data.type ~= "title" then
		local id = data.id
		local dataCell = self._mapData:getTaskMapById(id)
		local showTypeName = dataCell:getShowTypeName()
		local taskValues = dataCell:getTaskValueList()
		local currentValue = taskValues[#taskValues].currentValue
		local targetValue = taskValues[#taskValues].targetValue

		if dataCell:getDesc() ~= "" then
			local var_8_0 = dataCell:getDesc()

			if not var_8_0 then
				var_8_0 = self._exploreSystem:getTaskDescByCondition(dataCell:getCondition())

				local taskDesc = var_8_0
				local str = taskDesc .. "（" .. currentValue .. "/" .. targetValue .. "）"

				self._desc:setString(str)

				height = self._desc:getContentSize().height

				if showTypeName and #showTypeName > 0 then
					height = height + cellHeight - 5
				end
			end
		end
	end

	if idx == 0 then
		return 460, height - 2
	end

	return 460, height + 9
end

function ExplorePointTaskMediator:updateTask()
	local function cellSizeForTable(table, idx)
		return self:getSizeCell(idx)
	end

	local function numberOfCellsInTableView(table)
		return #self._showData
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		local width, height = self:getSizeCell(idx)

		self:createTeamCell(cell, idx + 1, cc.size(width, height))

		return cell
	end

	local tableView = cc.TableView:create(self._taskPanel:getContentSize())

	self._taskView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setBounceable(false)
	self._taskPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
end

function ExplorePointTaskMediator:createTeamCell(cell, index, cellSize)
	cell:removeAllChildren()

	local panel
	local data = self._showData[index]

	if data.type == "title" then
		panel = self._titleClone:clone()

		panel:setVisible(true)
		panel:getChildByFullName("desc"):setString(data.text)
	elseif data.type == "task" then
		local id = data.id

		data = self._mapData:getTaskMapById(id)

		local taskValues = data:getTaskValueList()
		local currentValue = taskValues[#taskValues].currentValue
		local targetValue = taskValues[#taskValues].targetValue

		panel = self._taskClone:clone()

		panel:setVisible(true)

		local desc = panel:getChildByName("desc")

		if data:getDesc() ~= "" then
			local var_13_0 = data:getDesc()

			if not var_13_0 then
				var_13_0 = self._exploreSystem:getTaskDescByCondition(data:getCondition())

				local taskDesc = var_13_0
				local str = taskDesc .. "（" .. currentValue .. "/" .. targetValue .. "）"

				desc:setString(str)

				local numLbl = panel:getChildByName("num")

				numLbl:setString(Strings:get("EXPLORE_UI19", {
					num = data:getDp()
				}))

				if data:getIsComplete() then
					desc:setTextColor(cc.c3b(255, 255, 255))
					desc:setTextColor(cc.c3b(255, 255, 255))
				else
					desc:setTextColor(cc.c3b(195, 195, 195))
					panel:getChildByName("num"):setTextColor(cc.c3b(195, 195, 195))
				end

				desc:setPositionY(cellSize.height - 20)

				local showTypeName = data:getShowTypeName()

				if showTypeName and #showTypeName > 0 then
					local posX = desc:getPositionX() - 3

					for i = 1, #showTypeName do
						local image = ccui.ImageView:create(showTypeName[i].image .. ".png", 1)

						image:setAnchorPoint(cc.p(0, 0.5))
						image:setScale9Enabled(true)
						image:setCapInsets(cc.rect(17, 11, 10, 10))
						image:addTo(panel)
						image:setPositionX(posX)
						image:setPositionY(desc:getPositionY() - desc:getContentSize().height / 2 - 3 - image:getContentSize().height / 2)

						local text = cc.Label:createWithTTF(Strings:get(showTypeName[i].text), TTF_FONT_FZYH_M, 16)

						text:addTo(image)
						text:setColor(cc.p(0, 0, 0))

						local width = math.max(52, text:getContentSize().width + 18)
						local height = image:getContentSize().height

						image:setContentSize(cc.size(width, height))
						text:setPosition(cc.p(width / 2 - 2.5, height / 2 + 3))

						posX = posX + width
					end
				end
			end
		end
	end

	panel:setPosition(cc.p(0, 0))
	panel:addTo(cell)
end

function ExplorePointTaskMediator:onClickClose(sender, eventType)
	self:close()
end

function ExplorePointTaskMediator:onClickTip()
	if not self._touchPanel:isVisible() then
		self._touchPanel:setVisible(true)
	end
end
