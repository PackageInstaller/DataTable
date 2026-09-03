-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/equip/EquipListView.lua

EquipListView = class("EquipListView", DisposableObject, _M)

EquipListView:has("_view", {
	is = "r"
})
EquipListView:has("_info", {
	is = "r"
})
EquipListView:has("_mediator", {
	is = "r"
})
EquipListView:has("_equipIndex", {
	is = "r"
})
EquipListView:has("_selectEquipId", {
	is = "r"
})
EquipListView:has("_viewType", {
	is = "rw"
})

local componentPath = "asset/ui/EquipList.csb"
local kColumnNum = 4
local kEquipsShowType = {
	[EquipsShowType.kStrengthen] = Strings:get("Equip_UI63_1"),
	[EquipsShowType.kStar] = Strings:get("Equip_UI43"),
	[EquipsShowType.kAllUpdate] = Strings:get("Equip_UI63_1")
}

function EquipListView:initialize(info)
	self._info = info
	self._mediator = info.mediator
	self._viewType = info.data.viewType
	self._developSystem = self._mediator:getInjector():getInstance("DevelopSystem")
	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()

	self:refreshData(info.data)
	self:createView(info.mainNode)
	super.initialize(self)
end

function EquipListView:dispose()
	self._selectImage:release()
	self._equipSystem:clearEquipConsumeItems()
	super.dispose(self)
end

function EquipListView:refreshData(data)
	self._equipList = {}
	self._selectEquipId = ""
	self._heroData = nil

	dump(self._viewType, "self._viewType_____")

	if data then
		self._viewType = data.viewType or self._viewType
		self._equipList = self._equipSystem:getEquipList(self._viewType, data.params)

		if self._viewType ~= EquipsShowType.kStar then
			self._selectEquipId = self._equipList[1] and self._equipList[1].item and self._equipList[1].item:getId() or self._equipList[1] and self._equipList[1]:getId() or ""
		end

		if data.params and data.params.heroId then
			local id = data.params.heroId

			self._heroData = self._heroSystem:getHeroById(id)
		end
	end
end

function EquipListView:createView(mainNode)
	self._view = mainNode or cc.CSLoader:createNode(componentPath)
	self._emptyTip = self._view:getChildByFullName("emptyTip")

	self._emptyTip:setVisible(false)

	self._listPanel = self._view:getChildByFullName("listPanel")

	self._listPanel:removeAllChildren()

	self._cellClone = self._view:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	self._selectImage = self:createSelectImage()

	self:initEquipView()
end

function EquipListView:initEquipView()
	local width = self._listPanel:getContentSize().width
	local height = self._cellClone:getContentSize().height

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		if idx == 0 then
			return width, height + 16
		end

		return width, height
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(#self._equipList / kColumnNum)
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createCell(cell, idx + 1)

		return cell
	end

	local size = cc.size(width, self._listPanel:getContentSize().height)
	local tableView = cc.TableView:create(size)

	self._equipView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(cc.p(0, 0))
	tableView:setDelegate()
	tableView:setBounceable(false)
	self._listPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	self._equipView:reloadData()
end

function EquipListView:createCell(cell, index)
	cell:removeAllChildren()

	for i = 1, kColumnNum do
		local equipIndex = kColumnNum * (index - 1) + i
		local equipData = self._equipList[equipIndex]

		if equipData then
			local equipId
			local node = self._cellClone:clone()

			node:setVisible(true)
			node:addTo(cell)
			node:setPosition(cc.p((i - 1) * self._cellClone:getContentSize().width, 0))
			node:setTouchEnabled(true)
			node:setSwallowTouches(false)

			local tipPanel = node:getChildByFullName("tipPanel")

			tipPanel:setVisible(false)

			local iconPanel = node:getChildByFullName("iconPanel")
			local icon

			if equipData.item and equipData.item:getSubType() and equipData.item:getSubType() == ItemTypes.K_EQUIP_EXP then
				equipId = equipData.item:getId()
				icon = IconFactory:createIcon({
					scaleRatio = 0.8,
					id = equipData.item:getConfigId(),
					amount = equipData.count,
					rarity = equipData.item:getRarity()
				}, {
					showAmount = true
				})

				icon:addTo(iconPanel):center(iconPanel:getContentSize())
				icon:setColor(cc.c3b(255, 255, 255))
				iconPanel:setColor(cc.c3b(255, 255, 255))
				tipPanel:setColor(cc.c3b(255, 255, 255))

				local quickSelectItems = self._equipSystem:getStrengthenConsumeItems()
				local num = 0

				for i = 1, #quickSelectItems do
					if quickSelectItems[i] == equipId then
						num = num + 1
					end
				end

				if num > 0 then
					local selectImage = ccui.ImageView:create("zhuangbei_bg_gou.png", 1)
					local image = ccui.ImageView:create("zb_btn_duigou.png", 1)

					selectImage:addTo(node)
					selectImage:setPosition(cc.p(23, 18))
					image:addTo(selectImage):posite(15, 20)
					image:setScale(0.9)
					selectImage:setName("SelectImage")
					self:createMinusPanel(selectImage, num, equipId)

					if equipData.count - num <= 0 then
						node:setTouchEnabled(false)
					end
				end
			else
				equipId = equipData:getId()

				local level = equipData:getLevel()
				local star = equipData:getStar()
				local rarity = equipData:getRarity()
				local param = {
					id = equipData:getEquipId(),
					level = level,
					star = star,
					rarity = rarity,
					lock = not equipData:getUnlock()
				}

				icon = IconFactory:createEquipIcon(param)

				icon:addTo(iconPanel):center(iconPanel:getContentSize())
				icon:setColor(cc.c3b(255, 255, 255))
				iconPanel:setColor(cc.c3b(255, 255, 255))
				tipPanel:setColor(cc.c3b(255, 255, 255))

				local heroId = equipData:getHeroId()

				if heroId ~= "" then
					tipPanel:setVisible(true)

					local heroIcon = tipPanel:getChildByFullName("heroIcon")
					local heroInfo = {
						id = IconFactory:getRoleModelByKey("HeroBase", heroId)
					}
					local headImgName = IconFactory:createRoleIconSpriteNew(heroInfo)

					headImgName:setScale(0.2)

					headImgName = IconFactory:addStencilForIcon(headImgName, 2, cc.size(39, 39))

					headImgName:addTo(heroIcon):center(heroIcon:getContentSize()):offset(-0.5, -0.5)
					icon:setColor(cc.c3b(131, 131, 131))
				end

				if self._heroData then
					local type = self._heroData:getType()
					local typeRange = equipData:getOccupation()
					local occupationType = equipData:getOccupationType()
					local heroId = self._heroData:getId()

					if occupationType == nil or occupationType == 0 then
						if not table.indexof(typeRange, type) then
							tipPanel:setColor(cc.c3b(131, 131, 131))
							iconPanel:setColor(cc.c3b(131, 131, 131))
						end
					elseif occupationType == 1 and not table.indexof(typeRange, heroId) then
						tipPanel:setColor(cc.c3b(131, 131, 131))
						iconPanel:setColor(cc.c3b(131, 131, 131))
					end
				end

				if self._viewType == EquipsShowType.kReplace then
					if self._selectEquipId == equipData:getId() then
						self._selectImage:setVisible(true)
						self._selectImage:removeFromParent(false)
						self._selectImage:addTo(node):center(node:getContentSize())
					end
				elseif self._viewType == EquipsShowType.kStrengthen then
					local quickSelectItems = self._equipSystem:getStrengthenConsumeItems()

					if table.indexof(quickSelectItems, equipData:getId()) then
						local selectImage = ccui.ImageView:create("zhuangbei_bg_gou.png", 1)
						local image = ccui.ImageView:create("zb_btn_duigou.png", 1)

						selectImage:addTo(node)
						selectImage:setPosition(cc.p(23, 18))
						image:addTo(selectImage):posite(15, 20)
						image:setScale(0.9)
						selectImage:setName("SelectImage")
						iconPanel:setColor(cc.c3b(131, 131, 131))
					end
				elseif self._viewType == EquipsShowType.kStar then
					local starConsumeItem = self._equipSystem:getStarConsumeItem()

					if starConsumeItem == equipData:getId() then
						self._selectImage:setVisible(true)
						self._selectImage:removeFromParent(false)
						self._selectImage:addTo(node):center(node:getContentSize())
					end
				end
			end

			icon:setScale(0.74)
			node:addTouchEventListener(function(sender, eventType)
				self:onClickEquipIcon(sender, eventType, equipId)
			end)
		end
	end
end

function EquipListView:refreshView()
	self._emptyTip:setString(kEquipsShowType[self._viewType])
	self._emptyTip:setVisible(#self._equipList <= 0)
	self._equipView:stopScroll()

	local offsetY = self._equipView:getContentOffset().y

	self._equipView:reloadData()
	self._equipView:setContentOffset(cc.p(0, offsetY))
end

function EquipListView:refreshViewBySwitchTab()
	self._emptyTip:setString(kEquipsShowType[self._viewType])
	self._emptyTip:setVisible(#self._equipList <= 0)
	self._equipView:stopScroll()
	self._equipView:reloadData()
	self:showTableCellAni()
end

function EquipListView:hideTip()
	self._emptyTip:setVisible(false)
end

function EquipListView:showTip()
	self._emptyTip:setVisible(#self._equipList <= 0)
end

function EquipListView:createSelectImage()
	local selectImage = ccui.ImageView:create("yizhuang_icon_ixuanzhong.png", 1)

	selectImage:addTo(self:getView())
	selectImage:setLocalZOrder(-1)
	selectImage:setScale(0.92)
	selectImage:setName("SelectImage")
	selectImage:setVisible(false)
	selectImage:retain()
	selectImage:removeFromParent(false)

	return selectImage
end

function EquipListView:createMinusPanel(node, amount, equipId)
	local panel = ccui.Layout:create()

	panel:setContentSize(cc.size(74, 28))
	panel:addTo(node):posite(30, 60)
	panel:setSwallowTouches(true)
	panel:setTouchEnabled(true)
	panel:addClickEventListener(function()
		self._equipSystem:setStrengthenConsumeItems(equipId, -1)

		local quickSelectItems = self._equipSystem:getStrengthenConsumeItems()
		local num = 0

		for i = 1, #quickSelectItems do
			if quickSelectItems[i] == equipId then
				num = num + 1
			end
		end

		self:refreshMinusPanel(node, num, equipId)

		if num == 0 then
			node:removeFromParent()
		end

		self._mediator:refreshByMinus()
	end)
	panel:setName("MinusBtn")

	local image = ccui.ImageView:create("zhuangbei_bg_amount.png", 1)

	image:setAnchorPoint(cc.p(1, 0.5))
	image:addTo(panel):posite(55, 10)
	image:setScale9Enabled(true)
	image:setCapInsets(cc.rect(8, 17, 11, 1))
	image:setContentSize(cc.size(52, 35))

	local image = ccui.ImageView:create("yh_btn_jian.png", 1)

	image:addTo(panel):posite(45, 6)

	local label = ccui.Text:create(amount, TTF_FONT_FZYH_M, 20)

	label:addTo(panel):posite(17, 13)
	label:setName("MinusNum")
end

function EquipListView:refreshMinusPanel(node, amount)
	local panel = node:getChildByName("MinusBtn")
	local label = panel:getChildByFullName("MinusNum")

	label:setString(amount)
end

function EquipListView:refreshLevelUpItems(node, equipId)
	local equipData = self._bagSystem:getEntryById(equipId)
	local iconPanel = node:getChildByFullName("iconPanel")

	if equipData then
		if equipData.item and equipData.item:getSubType() and equipData.item:getSubType() == ItemTypes.K_EQUIP_EXP then
			local quickSelectItems = self._equipSystem:getStrengthenConsumeItems()
			local num = 0

			for i = 1, #quickSelectItems do
				if quickSelectItems[i] == equipId then
					num = num + 1
				end
			end

			if num > 0 then
				local selectImage = node:getChildByFullName("SelectImage")

				if not selectImage then
					selectImage = ccui.ImageView:create("zhuangbei_bg_gou.png", 1)

					local image = ccui.ImageView:create("zb_btn_duigou.png", 1)

					selectImage:addTo(node)
					selectImage:setPosition(cc.p(23, 18))
					selectImage:setName("SelectImage")
					image:addTo(selectImage):posite(15, 20)
					image:setScale(0.9)
					self:createMinusPanel(selectImage, num, equipId)
				else
					self:refreshMinusPanel(selectImage, num, equipId)
				end

				if equipData.count - num <= 0 then
					node:setTouchEnabled(false)
				end
			else
				node:removeChildByName("SelectImage")
			end
		end
	else
		local quickSelectItems = self._equipSystem:getStrengthenConsumeItems()
		local selectImage = node:getChildByFullName("SelectImage")

		if table.indexof(quickSelectItems, equipId) then
			if not selectImage then
				selectImage = ccui.ImageView:create("zhuangbei_bg_gou.png", 1)

				local image = ccui.ImageView:create("zb_btn_duigou.png", 1)

				selectImage:addTo(node)
				selectImage:setPosition(cc.p(23, 18))
				image:addTo(selectImage):posite(15, 20)
				image:setScale(0.9)
				selectImage:setName("SelectImage")
				iconPanel:setColor(cc.c3b(131, 131, 131))
			end
		else
			iconPanel:setColor(cc.c3b(255, 255, 255))
			node:removeChildByName("SelectImage")
		end
	end
end

function EquipListView:showTableCellAni()
	local equipSystem = self._equipSystem
	local cells = self._equipView:getContainer():getChildren()

	for i = 1, #cells do
		local nodes = cells[i]:getChildren()

		for j = 1, #nodes do
			equipSystem:runIconShowAction(nodes[j], j)
		end
	end
end

function EquipListView:onClickEquipIcon(sender, eventType, equipId)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended then
		if self._isReturn then
			if self._viewType == EquipsShowType.kReplace then
				self:onSelectToReplace(sender, equipId)
			elseif self._viewType == EquipsShowType.kStrengthen then
				self:onSelectToLevelUp(sender, equipId)
			elseif self._viewType == EquipsShowType.kStar then
				self:onSelectToStarUp(sender, equipId)
			end
		end
	elseif eventType == ccui.TouchEventType.canceled then
		-- block empty
	end
end

function EquipListView:onSelectToReplace(sender, equipId)
	if equipId == self._selectEquipId then
		return
	end

	self._selectImage:setVisible(true)
	self._selectImage:removeFromParent(false)
	self._selectImage:addTo(sender):center(sender:getContentSize())

	self._selectEquipId = equipId

	self._mediator:onClickEquipCell()
end

function EquipListView:onSelectToStarUp(sender, equipId)
	if equipId == self._selectEquipId then
		return
	end

	local equipData = self._mediator._equipData
	local isUseEquipItemNum = equipData:getIsUseEquipItemNum()

	if not isUseEquipItemNum then
		return
	end

	if equipData:isMaxStar() then
		self._mediator:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI62_1")
		}))

		return
	end

	if self._equipSystem:getEquipById(equipId):getHeroId() ~= "" then
		return
	end

	self._selectEquipId = equipId

	local function cancelCallback()
		self._selectEquipId = ""
	end

	local function sureCallback()
		self._selectEquipId = equipId
	end

	if not self._equipSystem:getEquipById(equipId):getUnlock() then
		self._mediator:onClickEquipUnLock(equipId, cancelCallback, sureCallback)

		return
	end

	self._mediator:onClickEquipCellToStarUp()

	local starConsumeItem = self._equipSystem:getStarConsumeItem()

	if starConsumeItem == self._selectEquipId then
		self._selectImage:setVisible(true)
		self._selectImage:removeFromParent(false)
		self._selectImage:addTo(sender):center(sender:getContentSize())
	end
end

function EquipListView:onSelectToLevelUp(sender, equipId)
	self._selectEquipId = equipId

	local equipData = self._mediator._equipData

	if equipData:isMaxLevel() then
		self._mediator:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI61")
		}))

		return
	end

	if equipData:isStarMaxExp() then
		self._mediator:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI44")
		}))

		return
	end

	local canAdd = self._equipSystem:canAddConsumeItem(equipId)

	if not canAdd then
		self._mediator:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI29")
		}))

		return
	end

	local function callback()
		self:refreshLevelUpItems(sender, equipId)
	end

	self._mediator:onClickEquipCell(callback)
end
