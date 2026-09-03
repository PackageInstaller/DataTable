-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/SetHomeBgPopMediator.lua

SetHomeBgPopMediator = class("SetHomeBgPopMediator", DmPopupViewMediator)

SetHomeBgPopMediator:has("_customDataSystem", {
	is = "r"
}):injectWith("CustomDataSystem")
SetHomeBgPopMediator:has("_homeSystem", {
	is = "r"
}):injectWith("HomeSystem")

local kBtnHandlers = {
	["main.randomBox.Panel_5"] = {
		ignoreClickAudio = true,
		func = "onClickRandom"
	}
}

function SetHomeBgPopMediator:initialize()
	super.initialize(self)
end

function SetHomeBgPopMediator:dispose()
	super.dispose(self)
end

function SetHomeBgPopMediator:onRegister()
	super.onRegister(self)

	self._settingSystem = self:getInjector():getInstance(SettingSystem)
	self._settingModel = self._settingSystem:getSettingModel()

	self:mapButtonHandlersClick(kBtnHandlers)
end

function SetHomeBgPopMediator:enterWithData(data)
	self._main = self:getView():getChildByName("main")
	self._randomBox = self._main:getChildByName("randomBox")
	self._cloneCell = self:getView():getChildByName("cloneCell")
	self._allBg = self._homeSystem:getHomeBackgroundList()
	self._chooseIndex = 0
	self._setHomeBgId = data and data.setHomeBgId and data.setHomeBgId or self._settingSystem:getHomeBgId()

	self:createTableView()

	if CommonUtils.GetSwitch("fn_board_random") == true then
		local isRandom = self._settingModel:getRoleAndBgRandom()

		self:onRandomBoxChange(isRandom)
	else
		self._randomBox:setVisible(false)
	end
end

function SetHomeBgPopMediator:createTableView()
	local container = self._main:getChildByName("container")
	local tableView = cc.TableView:create(container:getContentSize())

	local function scrollViewDidScroll(view)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return 477, 131
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
		return math.ceil(#self._allBg / 2)
	end

	tableView:setPosition(0, 0)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setBounceable(false)
	container:addChild(tableView)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()

	self._tableView = tableView
end

function SetHomeBgPopMediator:updateCell(cell, index)
	cell:removeAllChildren()

	local layout = ccui.Layout:create()

	layout:setTouchEnabled(false)
	layout:setContentSize(cc.size(477, 165))
	layout:setAnchorPoint(0, 0)
	layout:addTo(cell):setName("main")

	local begin = 2 * index - 1
	local tail = 2 * index

	for i = begin, tail do
		if self._allBg[i] then
			local cell = self._cloneCell:clone()

			cell:setSwallowTouches(false)

			local thumb = cell:getChildByName("thumb")

			thumb:loadTexture("asset/common/" .. self._allBg[i].BGPContraction .. ".png", ccui.TextureResType.localType)
			thumb:setScale(0.8)

			local name = cell:getChildByName("name")

			name:setString(Strings:get(self._allBg[i].Name))
			cell:addTo(layout)
			cell:setTag(i)
			cell:setPosition(cc.p(93.5 + (i - begin) * 200, 70))

			if self._allBg[i].Id == self._setHomeBgId then
				cell:getChildByName("select"):setVisible(true)

				self._chooseIndex = i
			end

			local unlockCondition = self._allBg[i].Condition
			local isUnlock, argeNum = self:checkCondition(unlockCondition)
			local unlockView = cell:getChildByName("unlock")

			if isUnlock then
				unlockView:setVisible(false)
			else
				unlockView:setVisible(true)

				local str = Strings:get(self._allBg[i].Tips, {
					num = argeNum
				})

				unlockView:getChildByName("unlockText"):setString(str)
			end

			cell.isUnlock = isUnlock

			local function callFunc(sender)
				local beganPos = sender:getTouchBeganPosition()
				local endPos = sender:getTouchEndPosition()

				if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
					if self._chooseIndex == i then
						return
					end

					if not sender.isUnlock then
						return
					end

					local cellIndex = math.ceil(self._chooseIndex / 2)
					local cell = self._tableView:cellAtIndex(cellIndex - 1)

					if cell then
						local _icon = cell:getChildByName("main"):getChildByTag(self._chooseIndex)

						_icon:getChildByName("select"):setVisible(false)
					end

					self._chooseIndex = i

					sender:getChildByName("select"):setVisible(true)

					self._setHomeBgId = self._allBg[self._chooseIndex].Id

					self:dispatch(Event:new(EVT_VIEWBG_PREVIEW, {
						bgId = self._setHomeBgId
					}))
				end
			end

			mapButtonHandlerClick(nil, cell, {
				ignoreClickAudio = true,
				func = callFunc
			})
		end
	end
end

function SetHomeBgPopMediator:checkCondition(unlockCondition)
	local isOK = true
	local argeNum
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local unlockSystem = self:getInjector():getInstance(SystemKeeper)
	local playerLevel = developSystem:getPlayer():getLevel()

	for k, v in pairs(unlockCondition) do
		if k == "LEVEL" and playerLevel < v then
			isOK = false
			argeNum = v

			break
		end

		if k == "STAGE" then
			isOK, argeNum = unlockSystem:checkStagePointLock(v)
		end
	end

	return isOK, argeNum
end

function SetHomeBgPopMediator:onClickRandom()
	if self._doubleClickRandom then
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = Strings:get("MainScene_BoardHero_Random_2")
		}))
	else
		local isRandom = self._settingModel:getRoleAndBgRandom()

		self._settingModel:setRoleAndBgRandom(not isRandom)
		self:onRandomBoxChange(not isRandom)

		self._doubleClickRandom = true

		performWithDelay(self:getView(), function()
			self._doubleClickRandom = false
		end, 1)
	end
end

function SetHomeBgPopMediator:onRandomBoxChange(isRandom)
	local darkImage = self._randomBox:getChildByName("Image_Dark")
	local lightImage = self._randomBox:getChildByName("Image_Light")

	darkImage:setVisible(not isRandom)
	lightImage:setVisible(isRandom)
end
