-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeCommentMediator.lua

StagePracticeCommentMediator = class("StagePracticeCommentMediator", DmPopupViewMediator, _M)

StagePracticeCommentMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
StagePracticeCommentMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
StagePracticeCommentMediator:has("_stagePracticeSystem", {
	is = "r"
}):injectWith("StagePracticeSystem")

local kBtnHandlers = {}
local kStrategyType = {
	kTop = 1,
	kSelf = 2,
	kNew = 3
}
local kStrategyTypeStr = {
	[kStrategyType.kTop] = Strings:get("EXPLORE_UI113"),
	[kStrategyType.kSelf] = Strings:get("EXPLORE_UI114"),
	[kStrategyType.kNew] = Strings:get("EXPLORE_UI61")
}
local CellType = {
	Hot = 2,
	New = 3,
	Normal = 1
}

function StagePracticeCommentMediator:initialize()
	super.initialize(self)
end

function StagePracticeCommentMediator:dispose()
	super.dispose(self)
end

function StagePracticeCommentMediator:onRemove()
	super.onRemove(self)
end

function StagePracticeCommentMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

local kCellWidth, kCellHeight = 490, 95

function StagePracticeCommentMediator:enterWithData(data)
	self:sortCommentList(data.serverdata)
	self:initData(data)
	self:initNodes()
end

function StagePracticeCommentMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._cellPanel = self:getView():getChildByFullName("main.clonecell")

	self._cellPanel:setVisible(false)

	self._bgWidget = bindWidget(self, "main.bg_node", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = self._pointData:getName(),
		title1 = Strings:get("UITitle_EN_Teshujizhi"),
		bgSize = {
			width = 837,
			height = 503
		}
	})

	self:bindWidget("main.send", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickSendComment, self)
		}
	})
	self:setTextField()
	self:refreshTableView()
end

function StagePracticeCommentMediator:initData(data)
	self._data = data.serverdata
	self._pointId = data.poindid
	self._mapId = data.mapid
	self._stagePractice = self._stagePracticeSystem:getStagePractice()
	self._pointData = self._stagePracticeSystem:getPointById(self._mapId, self._pointId)
end

function StagePracticeCommentMediator:refreshTableView()
	if self._tableView then
		self._tableView:removeFromParent(true)

		self._tableView = nil
	end

	self:createTableView()
end

function StagePracticeCommentMediator:scrollTabPanel(tag)
	local innerHeight = self._scroll:getInnerContainer():getContentSize().height
	local sizeHeight = self._scroll:getContentSize().height
	local posY = -innerHeight + sizeHeight

	posY = posY + (tag - 1) * (self._cellBtn:getContentSize().height + changeHeight)

	if posY > 0 then
		posY = 0
	end

	self._scroll:getInnerContainer():setPositionY(posY)
end

function StagePracticeCommentMediator:refreshTabBtns()
	for i = 1, #self._tabBtns do
		self:refreshTabBtnByIndex(i)
	end
end

function StagePracticeCommentMediator:refreshTabBtnByIndex(index)
	local btn = self._tabBtns[index]

	btn:setShowState(self._pointIndex == index)
end

local kCellWidth = 94

function StagePracticeCommentMediator:createTableView()
	local listLocator = self:getChildView("main.Panel_listLocator")
	local tableView = cc.TableView:create(listLocator:getContentSize())

	local function cellSizeForTable(table, idx)
		local height = kCellHeight + 3

		if self._commentList[idx + 1].type then
			height = height + 27
		end

		return kCellWidth, height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._cellPanel:clone()

			sprite:setPosition(cc.p(10, -10))
			sprite:setSwallowTouches(false)
			sprite:setAnchorPoint(cc.p(0, 0))
			sprite:setVisible(true)
			cell:addChild(sprite, 11, 123)
			self:createCell(sprite, idx + 1)
		else
			local cell_Old = cell:getChildByTag(123)

			self:createCell(cell_Old, idx + 1)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._commentList
	end

	tableView:setTag(1234)

	self._tableView = tableView

	self._tableView:setAnchorPoint(0.5, 0.5)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(listLocator:getPosition())
	tableView:setDelegate()
	listLocator:getParent():addChild(tableView)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
	tableView:setMaxBounceOffset(20)
end

function StagePracticeCommentMediator:createCell(cell, tag)
	print("tag------->", tag)

	local data = self._commentList[tag]

	if not data then
		return
	end

	local oldcell = cell:getChildByTag(123)

	if oldcell then
		oldcell:removeFromParent(false)
	end

	local nameLabel = cell:getChildByFullName("playername")

	nameLabel:setString(data.nickname)

	local infoLabel = cell:getChildByFullName("commentinfo")

	infoLabel:setString(data.content)

	local timeLabel = cell:getChildByFullName("timelabel")
	local zanshu = cell:getChildByFullName("zandi.zanshu")

	zanshu:setString(data.like)
	cell:getChildByFullName("zuirewzd"):setVisible(false)
	cell:getChildByFullName("zuirewzt"):setVisible(false)
	cell:getChildByFullName("typeImage"):setVisible(false)

	if data.type then
		cell:getChildByFullName("typeImage"):setVisible(true)

		local str = kStrategyTypeStr[data.type]

		cell:getChildByFullName("typeImage.type"):setString(str)
	end

	if data.hot then
		cell:getChildByFullName("zuirewzd"):setVisible(true)
		cell:getChildByFullName("zuirewzt"):setVisible(true)
	end

	cell:getChildByFullName("zandi.no"):setVisible(true)
	cell:getChildByFullName("zandi.yes"):setVisible(data.mylike)

	local zanbtn = cell:getChildByFullName("zanbtn")

	zanbtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			local yes = cell:getChildByFullName("zandi.yes")
			local no = cell:getChildByFullName("zandi.no")

			if yes:isVisible() then
				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = Strings:get("StagePtc_Comment_Tips_AlreadyPraise")
				}))

				return
			end

			self._stagePracticeSystem:requestSupportPointComment(self._pointId, self._mapId, data.id, function(response)
				yes:setVisible(true)
				self:sortCommentList(response.data)

				local offset = self._tableView:getContentOffset()

				self._tableView:reloadData()
				self._tableView:setContentOffset(offset)
			end)
		end
	end)
end

function StagePracticeCommentMediator:setTextField()
	self._commentInfo = convertTextFieldToEditBox(self:getView():getChildByFullName("main.inputbg.input"), nil, MaskWordType.CHAT)

	if self._commentInfo:getDescription() == "TextField" then
		self._commentInfo:setMaxLength(50)
		self._commentInfo:setMaxLengthEnabled(true)
	end

	self._commentInfo:setPlaceHolder(Strings:get("StagePtc_Comment_WordLimit"))
	self._commentInfo:onEvent(function(eventName, sender)
		if eventName == "began" then
			-- block empty
		elseif eventName == "ended" then
			self._oldStr = self._commentInfo:getText()

			local state, finalString = StringChecker.checkString(self._oldStr, MaskWordType.CHAT)

			if state == StringCheckResult.AllOfCharForbidden then
				self._oldStr = ""

				self._commentInfo:setText("")
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Input_Tip1")
				}))
			end
		elseif eventName == "return" then
			-- block empty
		elseif eventName == "changed" then
			-- block empty
		elseif eventName == "ForbiddenWord" then
			self:getEventDispatcher():dispatchEvent(ShowTipEvent({
				tip = Strings:get("Common_Tip1")
			}))
		elseif eventName == "Exceed" then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_WordNumber_Limit", {
					number = sender:getMaxLength()
				})
			}))
		end
	end)
end

function StagePracticeCommentMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end

function StagePracticeCommentMediator:onClickSendComment(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._commentInfo:getText() == "" or self._commentInfo:getText() == Strings:get("StagePtc_Comment_WordLimit") then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("StagePtc_Comment_Tips_NoneWord")
			}))

			return
		end

		self._stagePracticeSystem:requestPublishPointComment(self._pointId, self._mapId, self._commentInfo:getText(), function(response)
			dump(response.data, Strings:get("StagePtc_Comment_Tips_SendSuccess"))

			self._commentList = response.data.list

			self:sortCommentList(response.data)
			self._tableView:reloadData()
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("StagePtc_Comment_Tips_SendSuccess")
			}))
			self._commentInfo:setPlaceHolder(Strings:get("StagePtc_Comment_WordLimit"))
			self._commentInfo:setText("")
		end)
	end
end

function StagePracticeCommentMediator:sortCommentList(alldata)
	local toplist = alldata.top
	local myList = alldata.myList
	local alllist = alldata.list
	local newlist = {}
	local count = 0

	for k, v in pairs(toplist) do
		count = count + 1

		if count == 1 then
			v.hot = true
			v.type = kStrategyType.kTop
		end

		table.insert(newlist, v)
	end

	count = 0

	for k, v in pairs(myList) do
		count = count + 1

		if count == 1 then
			v.type = kStrategyType.kSelf
		end

		table.insert(newlist, v)
	end

	count = 0

	for k, v in pairs(alllist) do
		count = count + 1

		if count == 1 then
			v.type = kStrategyType.kNew
		end

		table.insert(newlist, v)
	end

	self._commentList = newlist

	do return end

	local toplist = alldata.top
	local alllist = alldata.list

	self._commentCnt = #alllist

	local newlist = {}
	local count = 1

	if #alllist < 10 then
		for k, v in pairs(alllist) do
			newlist[count] = v
			count = count + 1
			v.type = k == 1 and CellType.New or CellType.Normal
		end
	else
		for k, v in pairs(toplist) do
			newlist[count] = v
			v.hot = true
			count = count + 1
			v.type = k == 1 and CellType.Hot or CellType.Normal
		end

		local firstNew = false

		for k, v in pairs(alllist) do
			local isHot = false

			for index, value in pairs(toplist) do
				if value.content == v.content then
					isHot = true
				end
			end

			if not isHot then
				newlist[count] = v
				count = count + 1

				if not firstNew then
					v.type = CellType.New
					firstNew = true
				else
					v.type = CellType.Normal
				end
			end
		end
	end

	self._commentList = newlist
end
