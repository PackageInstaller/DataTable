-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tsoul/view/TSoulSuitMediator.lua

TSoulSuitMediator = class("TSoulSuitMediator", DmPopupViewMediator, _M)

TSoulSuitMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local Suit_ImgDi = {
	"timesoul_img_tz_di_lv.png",
	"timesoul_img_tz_di_lv.png",
	"timesoul_img_tz_di_lan.png",
	"timesoul_img_tz_di_zi.png",
	"timesoul_img_tz_di_cheng.png",
	"timesoul_img_tz_di_hong.png"
}
local kBtnHandlers = {}

function TSoulSuitMediator:initialize()
	super.initialize(self)
end

function TSoulSuitMediator:dispose()
	super.dispose(self)
end

function TSoulSuitMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._tSoulSystem = self._developSystem:getTSoulSystem()

	local bgNode = self:getView():getChildByFullName("main.bg")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("TimeSoul_Main_SuitUI_15"),
		bgSize = {
			width = 1105,
			height = 640
		}
	})
	bgNode:getChildByFullName("Image_bg3"):setScaleY(0.77)
	bgNode:getChildByFullName("Image_bg4"):setPositionY(124)

	self._btnOk = self:bindWidget("main.okBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onOkClicked, self)
		}
	})
end

function TSoulSuitMediator:enterWithData(data)
	self._data = self._tSoulSystem:getSuitConfig()
	self._choseId = data.chooseId

	if self._choseId then
		for i, v in ipairs(self._data) do
			if v.Id == self._choseId then
				self._chooseIndex = i

				break
			end
		end
	else
		self._chooseIndex = 1
	end

	self:setUpView()
end

local TSoulIconFile = "asset/items/"

function TSoulSuitMediator:setUpView()
	self._main = self:getView():getChildByFullName("main")
	self._listView = self._main:getChildByFullName("list_view")
	self._cloneCell = self._main:getChildByFullName("Panel_16")

	self._cloneCell:setVisible(false)

	self._desList = self._main:getChildByFullName("Panel_content")

	self._desList:setScrollBarEnabled(false)

	local tableView = cc.TableView:create(cc.size(238, 422))

	local function scrollViewDidScroll(view)
		return
	end

	local function tableCellTouch(table, cell)
		self:touchCell(cell:getIdx() + 1)
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
		return #self._data
	end

	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(cc.p(0, 0))
	tableView:addTo(self._listView)
	tableView:setDelegate()
	tableView:setBounceable(false)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()

	self._tableView = tableView

	local minOffset = self._tableView:minContainerOffset().y
	local space = self._cloneCell:getContentSize().height

	if self._chooseIndex > 2 then
		self._tableView:setContentOffset(cc.p(0, minOffset + space * (self._chooseIndex - 2)))
	end

	self:refreshRight()
end

function TSoulSuitMediator:updateCell(cell, index)
	cell:removeAllChildren()

	local data = self._data[index]
	local itemClone = self._cloneCell:clone()

	itemClone:setVisible(true)
	itemClone:addTo(cell):posite(0, 0)

	local name = itemClone:getChildByFullName("tex")
	local img = itemClone:getChildByFullName("Image_78")
	local imgDi = itemClone:getChildByFullName("Image_77")

	name:setString(Strings:get(data.Name))
	img:ignoreContentAdaptWithSize(true)
	img:setScale(0.7)
	img:loadTexture(TSoulIconFile .. data.SuitIcon .. ".png")
	imgDi:loadTexture(Suit_ImgDi[data.SuitRareity], 1)
end

function TSoulSuitMediator:touchCell(index)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	if self._chooseIndex == index then
		return
	end

	self._chooseIndex = index

	self:refreshRight()
end

function TSoulSuitMediator:refreshRight()
	local data = self._data[self._chooseIndex]

	for i = 1, 3 do
		if data.Part[i] then
			local config = ConfigReader:getRecordById("Tsoul", data.Part[i])
			local panel = self._main:getChildByFullName("Panel_clone" .. i)
			local name = panel:getChildByFullName("namelabel")
			local img = panel:getChildByFullName("Image_icon")
			local imgRareity = panel:getChildByFullName("Image_13")

			imgRareity:loadTexture(KTSoulRareityName[data.SuitRareity], 1)
			img:ignoreContentAdaptWithSize(true)
			img:setScale(0.7)
			img:loadTexture(TSoulIconFile .. config.Icon .. ".png")
			name:setString(Strings:get(config.Name))
		end
	end

	self._desList:removeAllChildren()

	local width = self._desList:getContentSize().width
	local SuitDesc = data.SuitDesc

	for k, v in pairs(SuitDesc) do
		local attrType = data.Suitattr[tonumber(k)] or data.Suitlevattr[1]
		local attrNum = data.Partattr[tonumber(k)] or data.Partlevattr[1]

		if AttributeCategory:getAttNameAttend(attrType) ~= "" then
			attrNum = attrNum * 100 .. "%"
		end

		local des = Strings:get(v, {
			Suitattr = getAttrNameByType(attrType),
			Partattr = attrNum,
			fontName = TTF_FONT_FZYH_M
		})
		local label = ccui.RichText:createWithXML(des, {})

		label:renderContent(width, 0)
		label:setAnchorPoint(cc.p(0, 0))
		label:setPosition(cc.p(0, 0))

		local height = label:getContentSize().height
		local newPanel = ccui.Layout:create()

		newPanel:setContentSize(cc.size(width, height + 8))
		label:addTo(newPanel)
		self._desList:pushBackCustomItem(newPanel)
	end
end

function TSoulSuitMediator:onOkClicked(sender, eventType)
	self:onClickClose()
end

function TSoulSuitMediator:onClickClose(sender, eventType)
	self:close()
end
