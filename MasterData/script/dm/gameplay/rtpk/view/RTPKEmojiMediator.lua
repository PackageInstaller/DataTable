-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpk/view/RTPKEmojiMediator.lua

RTPKEmojiMediator = class("RTPKEmojiMediator", DmPopupViewMediator, _M)

RTPKEmojiMediator:has("_rtpkSystem", {
	is = "r"
}):injectWith("RTPKSystem")
RTPKEmojiMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local emojiPath = "asset/emotion/"
local kBtnHandlers = {}
local maxCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "EMJ_MaxEquip", "content")

function RTPKEmojiMediator:initialize()
	super.initialize(self)
end

function RTPKEmojiMediator:dispose()
	super.dispose(self)
end

function RTPKEmojiMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function RTPKEmojiMediator:enterWithData(data)
	self._player = self._developSystem:getPlayer()
	self._usedList = self:getUsedList()
	self._emojiList = self:getSortEmoji()

	self:initWigetInfo()
	self:setUsedEmoji()
	self:setEmojiList()
end

function RTPKEmojiMediator:getUsedList()
	local list = {}
	local data = self._player:getUsedEmoji()

	for k, v in pairs(data) do
		list[tonumber(k + 1)] = v
	end

	return list
end

function RTPKEmojiMediator:getSortEmoji()
	local ownList = self._player:getUnlockedEmoji()
	local config = ConfigReader:getDataTable("MasterFace")
	local list = {}

	for k, v in pairs(config) do
		local data = {}

		data.id = k
		data.unlock = 0

		if ownList[k] then
			data.unlock = 1
		end

		data.config = config[k]
		list[#list + 1] = data
	end

	table.sort(list, function(a, b)
		local aUsed = self:isUsedEmoji(a.id) and 1 or 0
		local bUsed = self:isUsedEmoji(b.id) and 1 or 0

		if aUsed == bUsed then
			if a.unlock == b.unlock then
				return a.id < b.id
			end

			return a.unlock > b.unlock
		else
			return bUsed < aUsed
		end
	end)

	return list
end

function RTPKEmojiMediator:initWigetInfo()
	self._view = self:getView()
	self._main = self._view:getChildByName("main")
	self._emojiCell = self._main:getChildByName("cell")

	self._emojiCell:setVisible(false)

	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "bg_popup_dark.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("RTPK_EMO_UI2"),
		bgSize = {
			width = 753,
			height = 635
		}
	})

	self._okBtn = self:bindWidget("main.btn_ok", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickOk, self)
		}
	})
	self._cancelBtn = self:bindWidget("main.btn_cancel", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickCancel, self)
		}
	})
end

function RTPKEmojiMediator:setUsedEmoji()
	if not self._useCellArr then
		self._useCellArr = {}

		for i = 1, maxCount do
			local cell = self._emojiCell:clone()

			cell:setVisible(true)
			cell:addTo(self._main):posite(279 + (i - 1) * 98, 415)
			cell:getChildByName("Image_select"):setVisible(false)
			cell:getChildByName("Panel_lock"):setVisible(false)

			self._useCellArr[#self._useCellArr + 1] = cell

			local function callFuncGo(sender, eventType)
				self:onClickUsedCell(sender, eventType, i)
			end

			mapButtonHandlerClick(nil, cell, {
				func = callFuncGo
			})
		end
	end

	for i = 1, maxCount do
		local cell = self._useCellArr[i]
		local diImg = cell:getChildByName("Image_94")

		diImg:removeAllChildren()

		local emojiId = self._usedList[i]

		if emojiId then
			local config = ConfigReader:getRecordById("MasterFace", emojiId)
			local emojiImg = ccui.ImageView:create(emojiPath .. config.EMJPic, 0)

			emojiImg:addTo(diImg):center(diImg:getContentSize()):setScale(0.4)
		end
	end
end

function RTPKEmojiMediator:setEmojiList()
	local tableView = cc.TableView:create(cc.size(616, 220))

	local function numberOfCells(view)
		return math.ceil(#self._emojiList / 6)
	end

	local function cellSize(table, idx)
		return 616, 95
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local layout = ccui.Layout:create()

			layout:setContentSize(cc.size(616, 95))
			layout:addTo(cell):posite(0, 0):setTag(111)
		end

		self:updateTableCell(cell:getChildByTag(111), idx + 1)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setDelegate()
	tableView:addTo(self._main):posite(263, 140)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()

	self._tableView = tableView
end

function RTPKEmojiMediator:updateTableCell(cell, index)
	local maxCount = 6

	for i = 1, maxCount do
		local realIndex = i + (index - 1) * maxCount
		local data = self._emojiList[realIndex]

		if data then
			local emojiCell = cell:getChildByName("emoji" .. i)

			if not emojiCell then
				emojiCell = self._emojiCell:clone()

				emojiCell:setVisible(true)
				emojiCell:addTo(cell):posite(16 + (i - 1) * 98, 7)
				emojiCell:setName("emoji" .. i)
			end

			local isUsed = self:isUsedEmoji(data.id)
			local selectImg = emojiCell:getChildByName("Image_select")

			selectImg:setVisible(isUsed)

			local diImg = emojiCell:getChildByName("Image_94")

			diImg:removeAllChildren()

			local emojiImg = ccui.ImageView:create(emojiPath .. data.config.EMJPic, 0)

			emojiImg:addTo(diImg):center(diImg:getContentSize()):setScale(0.4)

			local lockPanel = emojiCell:getChildByName("Panel_lock")
			local lockText = lockPanel:getChildByName("Text_lock")

			lockPanel:setVisible(data.unlock == 0)

			if lockPanel:isVisible() then
				lockText:setString(Strings:get(data.config.Source))
			end

			local function callFuncGo(sender, eventType)
				self:onClickListCell(sender, eventType, realIndex)
			end

			mapButtonHandlerClick(nil, emojiCell, {
				func = callFuncGo
			})
			emojiCell:setSwallowTouches(false)
		end
	end
end

function RTPKEmojiMediator:isUsedEmoji(id)
	for i, v in pairs(self._usedList) do
		if v == id then
			return true
		end
	end
end

function RTPKEmojiMediator:moveToUsedList(id)
	for i = 1, 6 do
		local data = self._usedList[i]

		if not data then
			self._usedList[#self._usedList + 1] = id

			local cell = self._useCellArr[i]
			local diImg = cell:getChildByName("Image_94")
			local config = ConfigReader:getRecordById("MasterFace", id)
			local emojiImg = ccui.ImageView:create(emojiPath .. config.EMJPic, 0)

			emojiImg:addTo(diImg):center(diImg:getContentSize()):setScale(0.4)

			break
		end
	end
end

function RTPKEmojiMediator:onCloseClicked()
	self:close()
end

function RTPKEmojiMediator:onClickUsedCell(sender, eventType, index)
	local data = self._usedList[index]

	if not data then
		return
	end

	table.remove(self._usedList, index)
	self:setUsedEmoji()

	self._emojiList = self:getSortEmoji()

	self._tableView:reloadData()
end

function RTPKEmojiMediator:onClickListCell(sender, eventType, index)
	local data = self._emojiList[index]

	if data.unlock == 0 then
		return
	end

	if self:isUsedEmoji(data.id) then
		return
	end

	if #self._usedList >= maxCount then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("RTPK_EMO_Tips1")
		}))

		return
	end

	self:moveToUsedList(data.id)

	self._emojiList = self:getSortEmoji()

	self._tableView:reloadData()
end

function RTPKEmojiMediator:onClickOk()
	if #self._usedList == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("RTPK_EMO_Tips2")
		}))

		return
	end

	self._rtpkSystem:requestUseEmoji(self._usedList)
	self:close()
end

function RTPKEmojiMediator:onClickCancel()
	self:close()
end
