-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/ChangeHeadImgMediator.lua

ChangeHeadImgMediator = class("ChangeHeadImgMediator", DmPopupViewMediator, _M)

ChangeHeadImgMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ChangeHeadImgMediator:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")

local KMenu = {
	[KTabType.HEAD] = {
		{
			title = Strings:get("Setting_Ui_Text_4")
		},
		{
			title = Strings:get("Setting_Ui_Text_5")
		},
		{
			title = Strings:get("Setting_Ui_Text_6")
		},
		{
			title = Strings:get("Setting_Ui_Text_Awaken")
		},
		{
			title = Strings:get("Setting_Ui_Text_skin")
		}
	},
	[KTabType.FRAME] = {
		{
			title = Strings:get("Setting_Ui_Text_4")
		},
		{
			title = Strings:get("Frame_UI_2")
		},
		{
			title = Strings:get("Frame_UI_3")
		},
		{
			title = Strings:get("Frame_UI_4")
		},
		{
			title = Strings:get("Frame_UI_6")
		}
	}
}
local kCount = 4
local kWidth = 90

function ChangeHeadImgMediator:initialize()
	super.initialize(self)
end

function ChangeHeadImgMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function ChangeHeadImgMediator:onRegister()
	super.onRegister(self)
	self:bindWidget("main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Setting_Text22"),
		title1 = Strings:get("UITitle_EN_Genghuantouxiang"),
		bgSize = {
			width = 902,
			height = 480
		}
	})

	self._main = self:getView():getChildByName("main")

	local btn = self:getView():getChildByFullName("main.view_0.exchangeBtn")

	local function callfunc()
		self:onClickExchange()
	end

	mapButtonHandlerClick(nil, btn, {
		func = callfunc
	})
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
end

function ChangeHeadImgMediator:enterWithData(data)
	self._tabType = data.tabType or KTabType.HEAD
	self._selectType = data.selectType or 1

	self:getData()
	self:createTableView()

	self._menu = {}
	self._cloneBtn = self._main:getChildByFullName("view.btn1")

	self._cloneBtn:setVisible(false)

	self._topPanel = self._main:getChildByFullName("view.topPanel")

	self:initTabBar()
end

function ChangeHeadImgMediator:getData()
	self._player = self._developSystem:getPlayer()

	if self._tabType == KTabType.HEAD then
		if not self._headList then
			local data = self._settingSystem:getShowHeadImgList()
			local master = {}
			local hero = {}
			local awaken = {}
			local skin = {}

			for i = 1, #data do
				local v = data[i]

				if v.config.Type == 1 then
					hero[#hero + 1] = v
				elseif v.config.Type == 2 or v.config.Type == 6 then
					master[#master + 1] = v
				elseif v.config.Type == 4 then
					awaken[#awaken + 1] = v
				elseif v.config.Type == 5 then
					skin[#skin + 1] = v
				end

				if tostring(v.id) == tostring(self._player:getHeadId()) then
					self._curDataHead = v
				end
			end

			self._headList = {
				data,
				master,
				hero,
				awaken,
				skin
			}
		end

		self._data = self._headList
		self._curData = self._curDataHead
		self._selectId = self._curData.id
	else
		if not self._frameList then
			self._frameList = {}

			local activity = {}
			local festival = {}
			local zodiac = {}
			local leadstage = {}
			local data = self._settingSystem:getShowHeadFrameList()

			for i = 1, #data do
				local v = data[i]

				if v.config.Type == KFrameType.ACTIVITY then
					table.insert(activity, v)
				elseif v.config.Type == KFrameType.FESTIVAL then
					table.insert(festival, v)
				elseif v.config.Type == KFrameType.Zodiac then
					table.insert(zodiac, v)
				elseif v.config.Type == KFrameType.LEADSTAGE then
					table.insert(leadstage, v)
				end

				if tostring(v.id) == tostring(self._player:getCurHeadFrame()) then
					self._curDataFrame = v
					self._selectId = v.id
				end
			end

			self._frameList = {
				data,
				activity,
				festival,
				zodiac,
				leadstage
			}
		end

		self._data = self._frameList
		self._curData = self._curDataFrame
		self._selectId = self._curData.id
	end
end

function ChangeHeadImgMediator:initTabBar()
	for i = 1, 2 do
		local _btn = self:getView():getChildByFullName("main.btn_" .. i)

		_btn:setTag(i)

		local function callfunc(sender)
			self:onClickTabBtn(sender)
		end

		mapButtonHandlerClick(nil, _btn, {
			clickAudio = "Se_Click_Tab_1",
			func = callfunc
		})

		local lightText = _btn:getChildByFullName("light.text")
		local darkText = _btn:getChildByFullName("dark.text")

		lightText:setVisible(false)
		darkText:setVisible(false)
		lightText:enableOutline(cc.c4b(3, 1, 4, 51), 1)
		lightText:setColor(cc.c4b(177, 235, 16, 73.94999999999999))
		lightText:enableShadow(cc.c4b(3, 1, 4, 25.5), cc.size(1, 0), 1)
		darkText:enableOutline(cc.c4b(3, 1, 4, 51), 1)
		darkText:setColor(cc.c4b(110, 108, 108, 255))
		darkText:enableShadow(cc.c4b(3, 1, 4, 25.5), cc.size(1, 0), 1)
	end

	self:onClickTabBtn()
end

function ChangeHeadImgMediator:setTabBarStatus()
	for i = 1, 2 do
		local _btn = self:getView():getChildByFullName("main.btn_" .. i)
		local text = _btn:getChildByFullName("text")

		if i == self._tabType then
			_btn:getChildByFullName("light"):setVisible(true)
			_btn:getChildByFullName("dark"):setVisible(false)
			text:setTextColor(cc.c3b(0, 0, 0))
		else
			_btn:getChildByFullName("light"):setVisible(false)
			_btn:getChildByFullName("dark"):setVisible(true)
			text:setTextColor(cc.c3b(255, 255, 255))
		end
	end
end

function ChangeHeadImgMediator:onClickTabBtn(sender)
	if sender then
		if sender:getTag() == self._tabType then
			return
		end

		self._tabType = sender:getTag()

		self:resetSelect()
	end

	self:getData()
	self:setTabBarStatus()
	self:setSelectTab()
end

function ChangeHeadImgMediator:setSelectTab()
	if not self._menu[self._tabType] then
		self._menu[self._tabType] = {}

		local menu = KMenu[self._tabType]

		for i = 1, #menu do
			local _btn = self._cloneBtn:clone()

			_btn:setVisible(true)

			_btn.type = i

			_btn:addTo(self._topPanel)
			_btn:setPosition((i - 1) * 73 + 13, 15)
			_btn:getChildByFullName("Text_48"):setString(menu[i].title)
			_btn:getChildByName("image"):loadTexture("sz_btn_02.png", 1)
			_btn:getChildByName("Text_48"):setTextColor(cc.c3b(255, 255, 255))

			local function callfunc(sender)
				self:onChangeSelectType(sender)
			end

			mapButtonHandlerClick(nil, _btn, {
				ignoreClickAudio = true,
				func = callfunc
			})

			self._menu[self._tabType][i] = _btn
		end
	end

	self:onChangeSelectType()
end

function ChangeHeadImgMediator:resetSelect()
	for i = 1, #self._menu do
		local menu = self._menu[i]

		if menu then
			for j = 1, #menu do
				if i == self._tabType then
					menu[j]:setVisible(true)
				else
					menu[j]:setVisible(false)
				end

				menu[j]:getChildByName("image"):loadTexture("sz_btn_02.png", 1)
				menu[j]:getChildByName("Text_48"):setTextColor(cc.c3b(255, 255, 255))
			end
		end
	end

	self._selectTypePre = 1
	self._selectType = 1
end

function ChangeHeadImgMediator:onChangeSelectStatus()
	local menu = self._menu[self._tabType]

	if menu then
		if self._selectTypePre then
			local btn = menu[self._selectTypePre]

			btn:getChildByName("image"):loadTexture("sz_btn_02.png", 1)
			btn:getChildByName("Text_48"):setTextColor(cc.c3b(255, 255, 255))
		end

		local btn = menu[self._selectType]

		btn:getChildByName("image"):loadTexture("sz_btn_01.png", 1)
		btn:getChildByName("Text_48"):setTextColor(cc.c3b(0, 0, 0))
	end
end

function ChangeHeadImgMediator:onChangeSelectType(sender)
	if sender then
		local type = sender.type

		if type == self._selectType then
			return
		end

		self._selectTypePre = self._selectType
		self._selectType = type
	end

	self:onChangeSelectStatus()
	self._tableView:reloadData()
	self:refreshHeadImgInfoView()
end

function ChangeHeadImgMediator:createLineCell(imgViewPanel, index)
	local tab = self._data[self._selectType]

	for i = 1, kCount do
		local headInfo = tab[(index - 1) * kCount + i]

		if headInfo then
			local icon

			if self._tabType == KTabType.HEAD then
				icon = self:createIconHead(imgViewPanel, headInfo, i)
			elseif self._tabType == KTabType.FRAME then
				icon = self:createIconFrame(imgViewPanel, headInfo, i)
			end

			local function callFunc(sender, eventType)
				self:onClickHeadIcon(sender, headInfo, index)
			end

			mapButtonHandlerClick(nil, icon, {
				clickAudio = "Se_Click_Select_1",
				func = callFunc
			})

			if headInfo.unlock == 0 then
				icon:setGray(true)
			end

			self:setSelectStatus(headInfo, icon)
		end
	end
end

function ChangeHeadImgMediator:createIconHead(view, headInfo, index)
	local icon = IconFactory:createPlayerIcon({
		frameStyle = 3,
		id = headInfo.id,
		size = cc.size(80, 80)
	})

	icon:setAnchorPoint(cc.p(0, 0)):setScale(0.8)
	icon:addTo(view):posite(25 + (index - 1) * kWidth, 13)
	icon:setTouchEnabled(true)
	icon:setSwallowTouches(false)
	icon:setTag(index)

	return icon
end

function ChangeHeadImgMediator:createIconFrame(view, headInfo, index)
	if not headInfo.config.Picture then
		local img = "sz_bg_txk"

		img = "asset/head/" .. img .. ".png"

		local icon = ccui.ImageView:create(img)

		icon:setAnchorPoint(cc.p(0, 0)):setScale(0.3)
		icon:addTo(view):posite(25 + (index - 1) * kWidth - 12, 8)
		icon:setTouchEnabled(true)
		icon:setSwallowTouches(false)
		icon:setTag(index)

		if headInfo.config and headInfo.config.Type == "LIMIT" and getCurrentLanguage() == GameLanguageType.CN then
			local tnode = IconFactory:createBaseNode()
			local img = ccui.ImageView:create("asset/common/common_bg_xb_4.png", ccui.TextureResType.localType)

			IconFactory:centerAddNode(tnode, img)

			local lvLabel = cc.Label:createWithTTF("", CUSTOM_TTF_FONT_1, 18)

			lvLabel:setString(Strings:get("ActivityBlock_UI_13"))
			lvLabel:setColor(cc.c3b(255, 255, 255))
			lvLabel:addTo(tnode):offset(0, 5)
			tnode:setScale(1 / icon:getScale() * 0.8)
			tnode:addTo(icon):center(icon:getContentSize()):offset(70, 90)
		end

		return icon
	end
end

function ChangeHeadImgMediator:setSelectStatus(headInfo, icon)
	local id = self._player:getHeadId()
	local image

	if tostring(headInfo.id) == tostring((self._tabType == KTabType.FRAME or nil) and self._player:getCurHeadFrame()) then
		if self._tabType == KTabType.HEAD then
			image = ccui.ImageView:create("sz_txt_syz02.png", 1)

			image:setPosition(cc.p(59 + (icon:getTag() - 1) * kWidth, 67))
		elseif self._tabType == KTabType.FRAME then
			image = ccui.ImageView:create("sz_bg_qtsz_d02.png", 1)

			image:setPosition(cc.p(59 + (icon:getTag() - 1) * kWidth, 53))
		end

		image:addTo(icon:getParent()):setName("used")

		local label = cc.Label:createWithTTF("", "asset/font/CustomFont_FZYH_M.TTF", 16)

		label:setString(Strings:get("Frame_UI_5"))
		label:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)
		label:setOverflow(cc.LabelOverflow.SHRINK)
		label:setDimensions(70, 30)
		label:addTo(image):center(image:getContentSize())
		GameStyle:setCommonOutlineEffect(label, 1)
	end

	if tostring(headInfo.id) == self._selectId then
		local image = ccui.ImageView:create("zb_btn_duigou.png", 1)

		image:setScale(1.2)
		image:addTo(icon:getParent()):setName("selected")
		image:setPosition(cc.p(60 + (icon:getTag() - 1) * kWidth, 42))
	end
end

function ChangeHeadImgMediator:createTableView()
	local tableView = cc.TableView:create(cc.size(390, 245))

	local function scrollViewDidScroll(table)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return 550, 90
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		else
			cell:removeAllChildren()
		end

		self:createLineCell(cell, idx + 1)

		return cell
	end

	local function numberOfCellsInTableView(table)
		local tab = self._data[self._selectType]

		return math.ceil(#tab / kCount)
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(286, 145)
	tableView:setDelegate()
	self._main:addChild(tableView)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:setBounceable(false)

	self._tableView = tableView
end

function ChangeHeadImgMediator:onClickClose(sender, eventType)
	self:close()
end

function ChangeHeadImgMediator:onClickExchange(sender)
	if not self._curData then
		return
	end

	if self._curData.unlock == 1 then
		local function callBack()
			self._tableView:reloadData()
			self:refreshHeadImgInfoView()
		end

		if self._tabType == KTabType.HEAD then
			self._settingSystem:requestChangeHeadImg(self._curData.id, function()
				callBack()
			end)
		end

		if self._tabType == KTabType.FRAME then
			self._settingSystem:requestChangeHeadFrame(self._curData.id, function()
				callBack()
			end)
		end
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get(self._curData.config.UnlockDesc, {
				fontName = CUSTOM_TTF_FONT_1
			})
		}))
	end
end

function ChangeHeadImgMediator:onClickHeadIcon(sender, headInfo, index)
	local beganPos = sender:getTouchBeganPosition()
	local endPos = sender:getTouchEndPosition()

	if math.abs(beganPos.x - endPos.x) < 20 and math.abs(beganPos.y - endPos.y) < 20 then
		if tostring(headInfo.id) == self._selectId then
			return
		end

		self._selectId = tostring(headInfo.id)

		local offsetY = self._tableView:getContentOffset().y

		self._tableView:reloadData()
		self._tableView:setContentOffset(cc.p(0, offsetY))

		self._curData = headInfo

		self:refreshHeadImgInfoView()
	end
end

function ChangeHeadImgMediator:refreshHeadImgInfoView()
	if not self._curData then
		return
	end

	if self._tabType == KTabType.FRAME then
		self:refreshHeadFrameInfoView()

		return
	end

	local info = self._curData.config
	local nameText = self._main:getChildByFullName("view_0.imageName")

	nameText:setString(Strings:get(info.HeadName))
	self:setDescView(Strings:get(info.HeadDesc))

	local headPanel = self._main:getChildByFullName("view_0.head")

	headPanel:removeAllChildren()

	local headicon, oldIcon = IconFactory:createPlayerIcon({
		frameStyle = 3,
		headFrameScale = 0.415,
		id = self._curData.id,
		size = cc.size(82, 82),
		headFrameId = self._player:getCurHeadFrame()
	})

	oldIcon:setScale(0.4)
	headicon:addTo(headPanel):center(headPanel:getContentSize())

	local isUsed = self._main:getChildByFullName("view_0.isUsed")
	local btn = self._main:getChildByFullName("view_0.exchangeBtn")
	local getText = self._main:getChildByFullName("view_0.getDesc")

	getText:setString("")

	if tostring(self._curData.id) == tostring(self._player:getHeadId()) then
		isUsed:setVisible(true)
		btn:setVisible(false)
	else
		isUsed:setVisible(false)

		if self._curData.unlock == 1 then
			btn:setVisible(true)
		else
			btn:setVisible(false)
			getText:setString(Strings:get(self._curData.config.UnlockDesc, {
				fontName = CUSTOM_TTF_FONT_1
			}))
		end
	end
end

function ChangeHeadImgMediator:refreshHeadFrameInfoView()
	if not self._curData then
		return
	end

	local info = self._curData.config
	local nameText = self._main:getChildByFullName("view_0.imageName")

	nameText:setString(Strings:get(info.Name))
	self:setDescView(Strings:get(info.Desc))

	local headPanel = self._main:getChildByFullName("view_0.head")

	headPanel:removeAllChildren()

	local headicon, oldIcon = IconFactory:createPlayerIcon({
		frameStyle = 3,
		headFrameScale = 0.415,
		id = self._player:getHeadId(),
		size = cc.size(82, 82),
		headFrameId = self._curData.id
	})

	oldIcon:setScale(0.4)
	headicon:addTo(headPanel):center(headPanel:getContentSize())

	local isUsed = self._main:getChildByFullName("view_0.isUsed")
	local btn = self._main:getChildByFullName("view_0.exchangeBtn")
	local getText = self._main:getChildByFullName("view_0.getDesc")
	local expireText = self._main:getChildByFullName("view_0.expireTime")

	getText:setString("")
	expireText:setString("")

	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._curData.isLimit and not self._curData.isExpire and self._curData.expireTime and self._curData.useText then
		self:setExpireTimer(expireText, self._curData)
	end

	if tostring(self._curData.id) == tostring(self._player:getCurHeadFrame()) then
		isUsed:setVisible(true)
		btn:setVisible(false)
	else
		isUsed:setVisible(false)

		if self._curData.unlock == 1 then
			btn:setVisible(true)
		else
			btn:setVisible(false)
			getText:setString(Strings:get(info.ResourceDesc))
		end
	end

	if self._curData.frameData and self._curData.unlock == 1 then
		local tb = TimeUtil:localDate("*t", tonumber(self._curData.frameData) / 1000)

		getText:setString(Strings:get("Frame_UI_1") .. tb.year .. "." .. tb.month .. "." .. tb.day)
	end
end

function ChangeHeadImgMediator:setExpireTimer(expireText, data)
	local strId = data.useText
	local gameServerAgent = self:getInjector():getInstance(GameServerAgent)

	local function checkTimeFunc()
		local curTime = gameServerAgent:remoteTimeMillis()
		local remainTime = data.expireTime - curTime
		local str = TimeUtil:formatTimeStr(remainTime * 0.001)

		expireText:setString(Strings:get(strId, {
			day = str
		}))
	end

	if not self._timer then
		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end
end

function ChangeHeadImgMediator:setDescView(str)
	local scrollView = self._main:getChildByFullName("view_0.ScrollView_Desc")

	scrollView:setScrollBarEnabled(false)

	local descText = scrollView:getChildByName("desc")

	descText:getVirtualRenderer():setDimensions(scrollView:getContentSize().width, 0)
	descText:getVirtualRenderer():setLineSpacing(2)
	descText:setString(str)

	local h = descText:getContentSize().height < 96 and 96 or descText:getContentSize().height

	scrollView:setInnerContainerSize(cc.size(descText:getContentSize().width, h))
	scrollView:scrollToTop(0.01, false)
	descText:setPosition(cc.p(0, h))
end

function ChangeHeadImgMediator:doReset()
	self._frameList = nil

	self:getData()
	self._tableView:reloadData()
	self:refreshHeadImgInfoView()
end
