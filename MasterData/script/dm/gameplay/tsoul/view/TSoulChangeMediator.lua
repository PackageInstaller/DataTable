-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tsoul/view/TSoulChangeMediator.lua

TSoulChangeMediator = class("TSoulChangeMediator", DmPopupViewMediator, _M)

TSoulChangeMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local KShowCellNum = 4
local kBtnHandlers = {}

function TSoulChangeMediator:initialize()
	super.initialize(self)
end

function TSoulChangeMediator:dispose()
	self._selectImage:release()
	super.dispose(self)
end

function TSoulChangeMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._tSoulSystem = self._developSystem:getTSoulSystem()

	local bgNode = self:getView():getChildByFullName("main.bg")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("TimeSoul_Change_Title"),
		bgSize = {
			width = 1105,
			height = 640
		}
	})

	self._btnOk = self:bindWidget("main.Node_right.btnOk", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onOkClicked, self)
		}
	})
end

function TSoulChangeMediator:enterWithData(data)
	local param = {}

	param.pos = data.pos
	param.heroId = data.heroId
	self._listData = self._tSoulSystem:getTSoulListByPosition(param)
	self._chooseId = data.chooseId
	self._tmpChooseId = self._chooseId
	self._isChange = self._chooseId ~= nil
	self._heroId = data.heroId
	self._pos = data.pos

	self:setUpView()
	self:setTsoulsView()
	self:tabClickByIndex(self._selectPanel:getChildByName("btn1"), true)
	self:refreshRightView()
end

function TSoulChangeMediator:setUpView()
	self._main = self:getView():getChildByFullName("main")
	self._selectPanel = self._main:getChildByName("selectPanel")
	self._cellClone = self._main:getChildByName("Panel_clone")

	self._cellClone:setVisible(false)

	local buttons = {}

	for i = 1, 2 do
		local button = self._selectPanel:getChildByName("btn" .. i)

		buttons[#buttons + 1] = button

		if i == 1 then
			button.subType = TSoulShowSort.SortByRaretyUp or TSoulShowSort.SortByLevelUp
		end

		button.index = i

		button:addClickEventListener(function(sender)
			self:tabClickByIndex(sender)
		end)
	end

	self._selectImage = self:createSelectImage()

	self._btnOk:setButtonName((self._isChange or nil) and (Strings:get("Equip_UI19") or Strings:get("equipment")))
end

function TSoulChangeMediator:tabClickByIndex(button, isFirst)
	AudioEngine:getInstance():playEffect("Se_Click_Tab_2", false)

	if isFirst then
		self._sortType = 1
		self._subType = true
	else
		self._subType = self._sortType == button.index and not self._subType or true
	end

	self._sortType = button.index

	for i = 1, 2 do
		local iamge = self._selectPanel:getChildByFullName("btn" .. i .. ".image")
		local text = self._selectPanel:getChildByFullName("btn" .. i .. ".Text_48")
		local arrow = self._selectPanel:getChildByFullName("btn" .. i .. ".Image_8")
		local pic = self._sortType == i and "gg_btn_s_xz.png" or "gg_btn_s_wxz.png"

		text:setTextColor(self._sortType == i and cc.c3b(88, 88, 88) or cc.c3b(255, 246, 255))
		iamge:loadTexture(pic, ccui.TextureResType.plistType)

		if self._sortType == i then
			arrow:setRotation(self._subType and 0 or 180)
		else
			arrow:setRotation(0)
		end
	end

	local sortIndex

	self._tSoulSystem:sortTSoulList(self._listData, self._sortType == 1 and self._subType and TSoulShowSort.SortByRaretyUp or self._sortType == 1 and not self._subType and TSoulShowSort.SortByRaretyDown or self._sortType == 2 and self._subType and TSoulShowSort.SortByLevelUp or TSoulShowSort.SortByLevelDown, {
		self._chooseId
	})

	if isFirst and not self._chooseId then
		self._chooseId = self._listData[1]:getId()
	end

	self._heroView:reloadData()
end

function TSoulChangeMediator:createSelectImage()
	local selectImage = ccui.ImageView:create("timesoul_img_shipodi_xz.png", 1)

	selectImage:addTo(self:getView())
	selectImage:setName("SelectImage")
	selectImage:setVisible(false)
	selectImage:retain()
	selectImage:removeFromParent(false)
	selectImage:setScale(0.95)

	return selectImage
end

function TSoulChangeMediator:changeSelectImage(sender)
	self._selectImage:setVisible(true)
	self._selectImage:removeFromParent(false)
	self._selectImage:addTo(sender):center(sender:getContentSize())
end

function TSoulChangeMediator:setTsoulsView()
	local heroList = self._main:getChildByName("list_view")

	self._cellWidth = heroList:getContentSize().width
	self._cellHeight = self._cellClone:getContentSize().height

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		return self._cellWidth, self._cellHeight + 10
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(#self._listData / KShowCellNum)
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createTSoulCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(heroList:getContentSize())

	self._heroView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setBounceable(false)
	heroList:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
end

function TSoulChangeMediator:createTSoulCell(cell, index)
	cell:removeAllChildren()

	for i = 1, KShowCellNum do
		local tSoulData = self._listData[KShowCellNum * (index - 1) + i]

		if tSoulData then
			local tSoulId = tSoulData:getId()
			local clone = self._cellClone:clone()

			clone:setVisible(true)
			clone:setTouchEnabled(true)
			clone:setSwallowTouches(false)
			clone:addTo(cell)
			clone:setPosition(cc.p((i - 1) * (self._cellClone:getContentSize().width + 10) + 20, 0))

			local name = clone:getChildByFullName("namelabel")
			local lv = clone:getChildByFullName("lvlabel")
			local attrText = clone:getChildByFullName("text")
			local attrImage = clone:getChildByFullName("image")
			local imgIcon = clone:getChildByFullName("Image_icon")
			local imgRareity = clone:getChildByFullName("Image_13")

			imgIcon:ignoreContentAdaptWithSize(true)
			imgIcon:loadTexture(tSoulData:getIcon())
			imgIcon:setScale(0.6)
			GameStyle:setQualityText(name, tSoulData:getRarity())
			name:setString(tSoulData:getName())
			lv:setString(Strings:get("TimeSoul_Change_Sort_3") .. tSoulData:getLevel())
			imgRareity:loadTexture(KTSoulRareityName[tSoulData:getRarity()], 1)

			local bastAttr = tSoulData:getBaseAttr()

			attrImage:loadTexture(AttrTypeImage[next(bastAttr)], 1)
			attrText:setString(bastAttr[next(bastAttr)])

			if index == 1 and i == 1 then
				self:changeSelectImage(clone)
			end

			imgRareity:setColor(cc.c3b(255, 255, 255))
			imgIcon:setColor(cc.c3b(255, 255, 255))

			local panelLock = clone:getChildByName("Panel_lock")

			panelLock:setVisible(false)

			local heroId = tSoulData:getHeroId()

			if heroId ~= "" then
				imgRareity:setColor(cc.c3b(131, 131, 131))
				imgIcon:setColor(cc.c3b(131, 131, 131))
				panelLock:setVisible(true)

				local heroIcon = panelLock:getChildByFullName("heroIcon")
				local heroInfo = {
					id = IconFactory:getRoleModelByKey("HeroBase", heroId)
				}
				local headImgName = IconFactory:createRoleIconSpriteNew(heroInfo)

				headImgName:setScale(0.2)

				headImgName = IconFactory:addStencilForIcon(headImgName, 2, cc.size(31, 31))

				headImgName:addTo(heroIcon):center(heroIcon:getContentSize()):offset(-0.5, -0.5)
			end

			clone:addTouchEventListener(function(sender, eventType)
				self:onClickTSoulItem(sender, eventType, tSoulId)
			end)
		end
	end
end

function TSoulChangeMediator:refreshRightView()
	local tSoulData = self._tSoulSystem:getTSoulById(self._chooseId)

	if not tSoulData then
		return
	end

	local rightPanel = self._main:getChildByName("Node_right")
	local textName = rightPanel:getChildByFullName("text_name")
	local textLv = rightPanel:getChildByFullName("textlv")
	local imgIcon = rightPanel:getChildByFullName("Image_icon")

	GameStyle:setQualityText(textName, tSoulData:getRarity())
	textName:setString(tSoulData:getName())
	textLv:setString(Strings:get("TimeSoul_Change_Sort_3") .. tSoulData:getLevel())
	imgIcon:ignoreContentAdaptWithSize(true)
	imgIcon:loadTexture(tSoulData:getIcon())
	imgIcon:setScale(0.8)

	local totalNum = tSoulData:getMaxAttrNum() + 1
	local attrs = getTSoulAttNumber(tSoulData:getAllAttr())
	local listViewAttr = rightPanel:getChildByFullName("listView_attr")

	listViewAttr:setScrollBarEnabled(false)
	listViewAttr:removeAllChildren()

	local attrClone = self:getView():getChildByFullName("cloneCell")
	local cellSize = attrClone:getContentSize()
	local totalElements = #attrs
	local rowCount = math.ceil(totalElements / 2)

	for row = 1, rowCount do
		local rowNode = ccui.Widget:create()

		rowNode:setContentSize(cc.size(listViewAttr:getContentSize().width, cellSize.height))

		for col = 1, 2 do
			local index = (row - 1) * 2 + col

			if totalElements < index then
				break
			end

			local node = attrClone:clone()
			local posX = col == 1 and 10 or 210

			node:setPosition(cc.p(posX, 0))
			rowNode:addChild(node)

			local img = node:getChildByName("image")
			local text = node:getChildByName("text_name")
			local text2 = node:getChildByName("text_value")
			local imgDi = node:getChildByName("Image_70")
			local imgLock = node:getChildByName("Image_lock")

			img:setVisible(false)
			text:setVisible(false)
			text2:setVisible(false)
			imgLock:setVisible(false)

			if attrs[index] then
				if row == 1 and col == 1 then
					if not KTSoulAttrBgState.KNormal then
						local bgState = KTSoulAttrBgState.KKong

						imgDi:loadTexture(KTSoulAttrBgName[bgState], ccui.TextureResType.plistType)
						img:setVisible(true)
						text:setVisible(true)
						text2:setVisible(true)
						img:loadTexture(attrs[index].icon, ccui.TextureResType.plistType)
						text:setString(attrs[index].attrName .. " :   " .. attrs[index].num)
						text2:setString("")
					end
				end
			elseif index <= totalNum then
				imgDi:loadTexture(KTSoulAttrBgName[KTSoulAttrBgState.KKong], ccui.TextureResType.plistType)
			else
				imgLock:setVisible(true)
				imgDi:loadTexture(KTSoulAttrBgName[KTSoulAttrBgState.KLock], ccui.TextureResType.plistType)
			end
		end

		listViewAttr:pushBackCustomItem(rowNode)
	end

	local listView = rightPanel:getChildByFullName("listView")

	listView:setScrollBarEnabled(false)
	listView:removeAllChildren()

	local width = listView:getContentSize().width
	local suitData = tSoulData:getSuitData()

	if suitData then
		local SuitDesc = suitData.SuitDesc
		local index = 1

		for k, v in pairs(SuitDesc) do
			if index < 3 then
				local attrType = suitData.Suitattr[tonumber(k) - 1] or suitData.Suitlevattr[1]
				local attrNum = suitData.Partattr[tonumber(k) - 1] or suitData.Partlevattr[1]

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
				label:setPosition(cc.p(0, 8))

				local newPanel = ccui.Layout:create()
				local height = label:getContentSize().height + 12

				newPanel:setContentSize(cc.size(width, height))
				label:addTo(newPanel)
				listView:pushBackCustomItem(newPanel)

				local pic = ccui.ImageView:create("timesoul_img_ycdi_3.png", ccui.TextureResType.plistType)

				pic:setScale9Enabled(true)
				pic:setContentSize(cc.size(width, 1))
				pic:setAnchorPoint(cc.p(0, 0))
				pic:addTo(newPanel):posite(0, 0)
			else
				local Tsoul_SuitLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_SuitLevel", "content")
				local maxLevel = {}

				for level, id in pairs(Tsoul_SuitLevel) do
					table.insert(maxLevel, level)
				end

				table.sort(maxLevel, function(a, b)
					return tonumber(a) < tonumber(b)
				end)

				for key, level in pairs(maxLevel) do
					local attrName = Tsoul_SuitLevel[level]
					local attrType = suitData.Suitlevattr[1]

					if suitData[attrName] then
						local attrNum = suitData[attrName][1]

						if AttributeCategory:getAttNameAttend(attrType) ~= "" then
							attrNum = attrNum * 100 .. "%"
						end

						local des = Strings:get(v, {
							level = level,
							Suitattr = getAttrNameByType(attrType),
							Partattr = attrNum,
							fontName = TTF_FONT_FZYH_M
						})
						local label = ccui.RichText:createWithXML(des, {})

						label:renderContent(width, 0)
						label:setAnchorPoint(cc.p(0, 0))
						label:setPosition(cc.p(0, 8))

						local height = label:getContentSize().height + 12
						local newPanel = ccui.Layout:create()

						newPanel:setContentSize(cc.size(width, height))
						label:addTo(newPanel)
						listView:pushBackCustomItem(newPanel)
					end
				end
			end

			index = index + 1
		end
	end

	self._btnOk:setVisible(self._tmpChooseId ~= self._chooseId)
end

function TSoulChangeMediator:onClickTSoulItem(sender, eventType, tSoulId)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		self._chooseId = tSoulId

		self:changeSelectImage(sender)
		self:refreshRightView()
	end
end

function TSoulChangeMediator:onOkClicked(sender, eventType)
	local tsoulData = self._tSoulSystem:getTSoulById(self._chooseId)

	if not tsoulData then
		return
	end

	if tsoulData:getHeroId() ~= "" then
		local param = {
			heroId = self._heroId,
			tsoulId = self._chooseId,
			pos = self._pos
		}
		local data = {
			title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
			content = Strings:get("TimeSoul_Main_SuitUI_17"),
			sureBtn = {},
			cancelBtn = {}
		}
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				outSelf._tSoulSystem:requestTSoulReplace(param)
				outSelf:onClickClose()
			elseif data.response == "cancel" then
				-- block empty
			elseif data.response == "close" then
				-- block empty
			end
		end

		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))

		return
	end

	local param = {
		heroId = self._heroId,
		tsoulId = self._chooseId,
		pos = self._pos
	}

	self._tSoulSystem:requestTSoulMounting(param)
	self:onClickClose()
end

function TSoulChangeMediator:onClickClose(sender, eventType)
	self:close()
end
