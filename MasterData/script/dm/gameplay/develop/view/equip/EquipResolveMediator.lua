-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/equip/EquipResolveMediator.lua

EquipResolveMediator = class("EquipResolveMediator", DmAreaViewMediator, _M)

EquipResolveMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
EquipResolveMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kColumnNum = 5
local kResolveNum = 99
local kCellHeight = 102

function EquipResolveMediator:initialize()
	super.initialize(self)
end

function EquipResolveMediator:dispose()
	if self._equipListView then
		self._equipListView:dispose()

		self._equipListView = nil
	end

	super.dispose(self)
end

function EquipResolveMediator:userInject()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()
	self._bagSystem = self._developSystem:getBagSystem()
end

function EquipResolveMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EQUIP_RESOLVE_SUCC, self, self.onResolveSuccessCallback)

	self._resolveBtn = self:bindWidget("main.infoNode.resolveBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickResolve, self)
		}
	})
	self._main = self:getView():getChildByName("main")
	self._infoNode = self._main:getChildByFullName("infoNode")
	self._listPanel = self._main:getChildByFullName("listPanel")
	self._cellClone = self._main:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	self._emptyNode = self._main:getChildByFullName("emptyNode")

	self._emptyNode:setVisible(false)

	local roleNode = self._main:getChildByName("roleNode")
	local roleModel = IconFactory:getRoleModelByKey("HeroBase", "SDTZi")
	local role = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		id = roleModel
	})

	role:addTo(roleNode):posite(67, -60)

	local goldIcon = self._infoNode:getChildByName("goldIcon")
	local icon = IconFactory:createPic({
		id = CurrencyIdKind.kGold
	})

	icon:addTo(goldIcon)

	self._cellWidth = self._listPanel:getContentSize().width

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._listPanel:setContentSize(cc.size(self._cellWidth, winSize.height - 65))
end

function EquipResolveMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipResolveRes", "content")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("EQUIP_TITLE")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function EquipResolveMediator:enterWithData(data)
	data = data or {}
	self._selectIds = {}
	self._rewards = {}
	self._equipList = self._equipSystem:getEquipList(EquipsShowType.kResolve)

	local index

	if data.equipId then
		local equipData = self._equipSystem:getEquipById(data.equipId)

		if equipData:getUnlock() then
			self._selectIds[#self._selectIds + 1] = data.equipId
		end

		for i = 1, #self._equipList do
			if self._equipList[i]:getId() == data.equipId then
				index = i

				break
			end
		end
	end

	self:setupTopInfoWidget()
	self:initEquipView()
	self:refreshSelectView()

	if index then
		local maxIndex = math.ceil(#self._equipList / kColumnNum)

		index = math.ceil(index / kColumnNum)

		local offsetY = kCellHeight * (index - maxIndex)
		local maxOffsetY = self._equipView:maxContainerOffset().y

		offsetY = math.min(offsetY, maxOffsetY)

		self._equipView:setContentOffset(cc.p(0, offsetY))
	end
end

function EquipResolveMediator:refreshData()
	self._selectIds = {}
	self._equipList = self._equipSystem:getEquipList(EquipsShowType.kResolve)
end

function EquipResolveMediator:refreshView()
	self:refreshData()
	self:refreshSelectView()
	self._equipView:reloadData()
end

function EquipResolveMediator:refreshSelectView()
	local length = #self._selectIds

	if length <= 0 then
		self._emptyNode:setVisible(true)
		self._infoNode:setVisible(false)

		return
	end

	self._emptyNode:setVisible(false)
	self._infoNode:setVisible(true)

	local selectPanel = self._infoNode:getChildByName("selectPanel")
	local selectNum = self._infoNode:getChildByName("selectNum")
	local goldNum = self._infoNode:getChildByName("goldNum")

	selectNum:setString(length .. "/" .. kResolveNum)
	self:getResolveItems()
	goldNum:setString(self._goldNum)
	selectPanel:removeAllItems()
	selectPanel:setScrollBarEnabled(false)

	local rewards = self._rewards

	if #rewards > 0 then
		for i = 1, #rewards do
			local layout = ccui.Layout:create()

			layout:setContentSize(cc.size(100, 100))

			local icon = IconFactory:createIcon(rewards[i], {
				showAmount = true,
				isWidget = true
			})

			icon:addTo(layout):center(layout:getContentSize())
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
				needDelay = true
			})
			selectPanel:pushBackCustomItem(layout)

			local scale = 0.7

			icon:setScale(scale)

			if icon.getAmountLabel then
				local label = icon:getAmountLabel()

				label:setScale(0.8 / scale)
				label:enableOutline(cc.c4b(0, 0, 0, 255), 2)
			end
		end
	end
end

function EquipResolveMediator:getResolveItems()
	local function checkRepeat(list, item)
		for i = 1, #list do
			if list[i].id == item.id then
				return list[i]
			end
		end

		return nil
	end

	self._goldNum = 0

	local length = #self._selectIds
	local itemList, equipList = {}, {}

	for i = 1, length do
		local id = self._selectIds[i]
		local goldNum, items, equips = self._equipSystem:getResolveItemsById(id)

		self._goldNum = self._goldNum + goldNum

		for j = 1, #items do
			local v = checkRepeat(itemList, items[j])

			if not v then
				itemList[#itemList + 1] = clone(items[j])
			else
				v.amount = v.amount + items[j].amount
			end
		end

		for j = 1, #equips do
			equipList[#equipList + 1] = clone(equips[j])
		end
	end

	table.sort(itemList, function(a, b)
		local configA = ConfigReader:getRecordById("ItemConfig", a.id)
		local configB = ConfigReader:getRecordById("ItemConfig", b.id)

		if configA.Quality == configB.Quality then
			return configA.Sort > configB.Sort
		end

		return configA.Quality > configB.Quality
	end)
	table.sort(equipList, function(a, b)
		local configA = ConfigReader:getRecordById("HeroEquipBase", a.id)
		local configB = ConfigReader:getRecordById("HeroEquipBase", b.id)

		if configA.Rareity == configB.Rareity then
			return configA.Sort > configB.Sort
		end

		return configA.Rareity > configB.Rareity
	end)

	local rewards = {}

	for i = 1, #itemList do
		rewards[#rewards + 1] = {
			type = RewardType.kItem,
			code = itemList[i].id,
			amount = itemList[i].amount,
			id = itemList[i].id
		}
	end
end

function EquipResolveMediator:initEquipView()
	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		return self._cellWidth, kCellHeight
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

	local size = cc.size(self._cellWidth, self._listPanel:getContentSize().height)
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
	tableView:setMaxBounceOffset(10)
	self._equipView:reloadData()
end

function EquipResolveMediator:createCell(cell, index)
	cell:removeAllChildren()

	for i = 1, kColumnNum do
		local equipIndex = kColumnNum * (index - 1) + i
		local equipData = self._equipList[equipIndex]

		if equipData then
			local level = equipData:getLevel()
			local star = equipData:getStar()
			local rarity = equipData:getRarity()
			local unlock = equipData:getUnlock()
			local node = self._cellClone:clone()

			node:setVisible(true)
			node:addTo(cell)
			node:setPosition(cc.p((i - 1) * 100, 0))

			local iconPanel = node:getChildByFullName("iconPanel")
			local param = {
				id = equipData:getEquipId(),
				level = level,
				star = star,
				rarity = rarity,
				lock = not unlock
			}
			local icon = IconFactory:createEquipIcon(param)

			icon:addTo(iconPanel):center(iconPanel:getContentSize())
			icon:setScale(0.74)
			node:setSwallowTouches(false)
			node:setTouchEnabled(true)
			node:addTouchEventListener(function(sender, eventType)
				self:onClickEquipIcon(sender, eventType, equipData)
			end)

			if table.indexof(self._selectIds, equipData:getId()) then
				local selectImage = ccui.ImageView:create("zhuangbei_bg_gou.png", 1)
				local image = ccui.ImageView:create("zb_btn_duigou.png", 1)

				selectImage:addTo(node)
				selectImage:setPosition(cc.p(23, 18))
				image:addTo(selectImage):posite(15, 20)
				image:setScale(0.9)
				selectImage:setName("SelectImage")
				iconPanel:setColor(cc.c3b(131, 131, 131))
			end
		end
	end
end

function EquipResolveMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function EquipResolveMediator:onClickEquipIcon(sender, eventType, equipData)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended then
		if self._isReturn then
			if not equipData:getUnlock() then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Equip_UI58")
				}))

				return
			end

			local equipId = equipData:getId()
			local index = table.indexof(self._selectIds, equipId)

			if index then
				table.remove(self._selectIds, index)
			else
				local length = #self._selectIds

				if length >= kResolveNum then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("Equip_UI50", {
							num = kResolveNum
						})
					}))

					return
				end

				self._selectIds[#self._selectIds + 1] = equipId
			end

			self:refreshSelectView()

			local iconPanel = sender:getChildByFullName("iconPanel")
			local selectImage = sender:getChildByFullName("SelectImage")

			if table.indexof(self._selectIds, equipData:getId()) then
				if not selectImage then
					selectImage = ccui.ImageView:create("zhuangbei_bg_gou.png", 1)

					local image = ccui.ImageView:create("zb_btn_duigou.png", 1)

					selectImage:addTo(sender)
					selectImage:setPosition(cc.p(23, 18))
					image:addTo(selectImage):posite(15, 20)
					image:setScale(0.9)
					selectImage:setName("SelectImage")
					iconPanel:setColor(cc.c3b(131, 131, 131))
				end
			else
				iconPanel:setColor(cc.c3b(255, 255, 255))
				sender:removeChildByName("SelectImage")
			end
		end
	elseif eventType == ccui.TouchEventType.canceled then
		-- block empty
	end
end

function EquipResolveMediator:onClickResolve()
	if #self._selectIds <= 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI51")
		}))

		return
	end

	local params = {
		equipIds = self._selectIds
	}

	self._equipSystem:requestEquipResolve(params)
end

function EquipResolveMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	if self._curTabType == 1 then
		if self._curMediator and self._selectView then
			local btn_onekeyup = self._selectView:getChildByFullName("main.levelpanel.btn_onekeyup")

			storyDirector:setClickEnv("EquipResolveMediator.btn_onekeyup", btn_onekeyup, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				self._curMediator:onClickOneKeyLevelUp(sender, eventType)
			end)

			local btn_qualityup = self._selectView:getChildByFullName("main.quality.btn_qualityup")

			storyDirector:setClickEnv("EquipResolveMediator.btn_qualityup", btn_qualityup, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				self._curMediator:onClickQualityup(sender, eventType)
			end)
		end
	elseif self._curTabType == 2 and self._curMediator and self._selectView then
		local btn_starup = self._selectView:getChildByFullName("main.starpanel.upitems.btn_starup")

		storyDirector:setClickEnv("EquipResolveMediator.btn_starup", btn_starup, function(sender, eventType)
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self._curMediator:onClickStarUp(sender, eventType)
		end)
	end

	for pos = 1, 6 do
		local index = pos
		local equipCell = self._equipPanel:getChildByName("icon" .. index)

		if equipCell then
			storyDirector:setClickEnv("EquipResolveMediator.equipCell_" .. index, equipCell, function(sender, eventType)
				self:onEquipIconClick(index)
			end)
		end
	end

	local tabBtns = self._tabBtns

	for i = 1, #tabBtns do
		local btn = tabBtns[i]
		local name = btn:getName()
		local tag = btn:getTag()

		storyDirector:setClickEnv("EquipResolveMediator.tabBtn_" .. name, btn, function(sender, eventType)
			self:onClickTab(name, tag)
			self._tabController:selectTabByTag(self._tabType)
		end)
	end

	storyDirector:notifyWaiting("enter_EquipResolveMediator")
end

function EquipResolveMediator:onResolveSuccessCallback(response)
	local rewards = table.deepcopy({}, self._rewards)

	if #rewards > 0 then
		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			rewards = rewards
		}))
	end

	self._rewards = {}

	self:refreshView()
end
