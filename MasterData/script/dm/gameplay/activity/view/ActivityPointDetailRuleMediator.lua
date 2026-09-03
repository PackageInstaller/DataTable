-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityPointDetailRuleMediator.lua

ActivityPointDetailRuleMediator = class("ActivityPointDetailRuleMediator", DmPopupViewMediator)

local kBtnHandlers = {
	["main.touchPanel"] = "onTouchLayout"
}

function ActivityPointDetailRuleMediator:dispose()
	super.dispose(self)
end

function ActivityPointDetailRuleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ActivityPointDetailRuleMediator:enterWithData(data)
	self._ruleId = data.ruleId
	self._ruleConfig = ConfigReader:getRecordById("PicGuide", self._ruleId)
	self._main = self:getView():getChildByFullName("main")
	self._bgPanel = self._main:getChildByFullName("Panel_1")
	self._listView = self._main:getChildByFullName("Panel_28")
	self._cloneCell = self._main:getChildByFullName("Panel_clone")

	self._cloneCell:setVisible(false)
	self:ignoreSafeArea()
	self:setupView()
	self:initAnim()
end

function ActivityPointDetailRuleMediator:setupView()
	self._touchPanel = self._main:getChildByFullName("touchPanel")

	self._touchPanel:setVisible(false)

	local nameText = self._main:getChildByFullName("Panel_31.Text_37")

	nameText:setString(Strings:get(self._ruleConfig.Name))

	local cellWidth, cellHeigth = 420, 260

	if #self._ruleConfig.Pic < 3 then
		if not ((cellWidth + 26) * #self._ruleConfig.Pic) then
			local tableViewWidth = self._listView:getContentSize().width
			local tableView = cc.TableView:create(cc.size(tableViewWidth, self._listView:getContentSize().height))

			local function scrollViewDidScroll(view)
				return
			end

			local function tableCellTouch(table, cell)
				self:touchCell(cell:getIdx() + 1)
			end

			local function cellSizeForTable(table, idx)
				return cellWidth + 26, cellHeigth
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
				return #self._ruleConfig.Pic
			end

			tableView:setAnchorPoint(0, 0)
			tableView:setPosition(cc.p(0, 0))
			tableView:addTo(self._listView)
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
	end
end

function ActivityPointDetailRuleMediator:updateCell(cell, index)
	cell:removeAllChildren()

	local data = self._ruleConfig.Pic[index]
	local layer = self._cloneCell:clone()

	layer:setVisible(true)
	layer:addTo(cell):posite(0, 0)

	local img = layer:getChildByName("Image_46")

	img:ignoreContentAdaptWithSize(false)
	img:loadTexture("asset/ui/activity/" .. data.Img, ccui.TextureResType.localType)

	local textDes = layer:getChildByName("Text_45")

	textDes:setString("")
	textDes:removeAllChildren()

	local richText = ccui.RichText:createWithXML(Strings:get(data.ShortText), {})

	richText:setAnchorPoint(0, 0)
	richText:setPosition(cc.p(0, 0))
	richText:addTo(textDes):setName("richText")
	richText:renderContent(400, 0)
	layer:getChildByName("Image_47"):setContentSize(cc.size(420, richText:getVirtualRendererSize().height + 10))
end

function ActivityPointDetailRuleMediator:touchCell(index)
	self._touchPanel:setVisible(true)

	local data = self._ruleConfig.Pic[index]
	local img = self._touchPanel:getChildByName("Image_32")
	local imgDi = self._touchPanel:getChildByName("Image_28")

	img:setScale(0.5)
	imgDi:setScale(0.5)
	img:runAction(cc.ScaleTo:create(0.1, 1))
	imgDi:runAction(cc.ScaleTo:create(0.1, 1))
	img:ignoreContentAdaptWithSize(false)
	img:loadTexture("asset/ui/activity/" .. data.Img, ccui.TextureResType.localType)

	local textDes = self._touchPanel:getChildByName("Text_38")

	textDes:setString("")

	local richText = textDes:getChildByName("richText")

	if not richText then
		richText = ccui.RichText:createWithXML("", {})

		richText:setAnchorPoint(0, 1)
		richText:setPosition(cc.p(0, 0))
		richText:addTo(textDes):setName("richText")
		richText:renderContent(600, 0, true)
	end

	richText:setString(Strings:get(data.LongText))
end

function ActivityPointDetailRuleMediator:ignoreSafeArea()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._bgPanel:setContentSize(cc.size(winSize.width, 353))

	local imgWidth = 73
	local bgImgNum = math.ceil(winSize.width / imgWidth)
	local imgClone = self._main:getChildByFullName("Image_33")

	for i = 1, bgImgNum do
		local img = imgClone:clone()

		img:addTo(self._bgPanel):posite((i - 1) * imgWidth, -36)
	end

	self._listView:setContentSize(cc.size(winSize.width - 40, 261))
end

function ActivityPointDetailRuleMediator:initAnim()
	local originX, orginY = self._bgPanel:getPosition()
	local originX1, originY1 = self._listView:getPosition()

	self._bgPanel:setPositionX(originX - 1000)
	self._bgPanel:runAction(cc.MoveTo:create(0.3, cc.p(originX, orginY)))
	self._listView:setPositionX(originX1 + 1000)
	self._listView:runAction(cc.MoveTo:create(0.3, cc.p(originX1, originY1)))
end

function ActivityPointDetailRuleMediator:onTouchLayout()
	self._touchPanel:setVisible(false)
end
