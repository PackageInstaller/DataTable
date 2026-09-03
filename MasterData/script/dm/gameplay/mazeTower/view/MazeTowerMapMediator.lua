-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mazeTower/view/MazeTowerMapMediator.lua

MazeTowerMapMediator = class("MazeTowerMapMediator", DmAreaViewMediator, _M)

MazeTowerMapMediator:has("_mazeTowerSystem", {
	is = "r"
}):injectWith("MazeTowerSystem")
MazeTowerMapMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.btn_rule"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	}
}
local moveActionTag = 1001
local checkDirActionTag = 1002
local dirInfo = {
	{
		1,
		0
	},
	{
		0,
		1
	},
	{
		-1,
		0
	},
	{
		0,
		-1
	}
}

function MazeTowerMapMediator:initialize()
	super.initialize(self)
end

function MazeTowerMapMediator:dispose()
	super.dispose(self)
end

function MazeTowerMapMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._scrollView = self._main:getChildByName("ScrollView")

	self._scrollView:setScrollBarEnabled(false)

	self._maskImg = self._main:getChildByName("Image_mask")
	self._topArrow = self._main:getChildByName("btn_top")
	self._bottomArrow = self._main:getChildByName("btn_bottom")

	self._scrollView:onScroll(function()
		self:refreshArrowShow()
	end)

	local winSize = cc.Director:getInstance():getWinSize()
	local size = self._scrollView:getContentSize()

	if winSize.height > 640 then
		self._scrollView:setContentSize(cc.size(size.width, size.height + (winSize.height - 640)))
		self._scrollView:offset(0, -(winSize.height - 640) * 0.5)
		self._maskImg:offset(0, -(winSize.height - 640) * 0.5)
	else
		self._scrollView:setContentSize(self._originalSize)
	end

	self._originalPos = cc.p(self._scrollView:getPosition())
end

function MazeTowerMapMediator:enterWithData()
	self._mazeTower = self._mazeTowerSystem:getMazeTower()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._curGridIndex = cc.p(self._mazeTower:getPosX(), self._mazeTower:getPosY())
	self._path = {}

	self:mapEventListeners()
	self:setupTopInfoWidget()
	self:setupView()
	self:initRocker()
end

function MazeTowerMapMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_TOWER_MOVE_END, self, self.onMoveFinish)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.refreshNumText)
end

function MazeTowerMapMediator:resumeWithData()
	self:refreshView()
end

function MazeTowerMapMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Stage_Maze_Name")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function MazeTowerMapMediator:setupView()
	self:initMapGrid()
	self:initRole()
	self:locationScrollview()
	self:refreshNumText()
	self:refreshArrowShow()
end

function MazeTowerMapMediator:refreshView()
	self._curGridIndex = cc.p(self._mazeTower:getPosX(), self._mazeTower:getPosY())

	if self._mazeTowerSystem:getIsReset() then
		self:showPassView(function()
			if self._nextPointId and self._nextPointId ~= "" then
				self._scrollView:removeAllChildren()
				self:setupView()
				self._role:setScaleX(self._roleScale)
				self._mazeTowerSystem:setIsReset(false)
			else
				self:dismiss({
					showTips = "Maze_Tip_1"
				})
			end
		end)
	else
		self:refreshGrid()
		self:resetRolePosition()
		self:refreshNumText()
	end
end

function MazeTowerMapMediator:refreshNumText()
	if not self._numRt then
		local numDi = self._main:getChildByName("Image_27")

		self._numRt = ccui.RichText:createWithXML("", {})

		self._numRt:addTo(numDi):center(numDi:getContentSize()):offset(0, -5)
	end

	self._numRt:setString(Strings:get("Maze_Num", {
		fontName = TTF_FONT_FZYH_M,
		Num = self._mazeTower:getTotalPointNum()
	}))

	local timesText = self._main:getChildByName("Text_times")

	timesText:setString(Strings:get("Maze_Num_Surplus", {
		num = self._mazeTower:getFightTime()
	}))
end

function MazeTowerMapMediator:refreshArrowShow()
	local innerPos = self._scrollView:getInnerContainerPosition()

	self._bottomArrow:setVisible(false)
	self._topArrow:setVisible(false)
	self._maskImg:setVisible(false)

	local innerSize = self._scrollView:getInnerContainerSize()

	if innerSize.height <= self._scrollViewSize.height then
		return
	end

	local maxy = self._scrollViewSize.height - innerSize.height

	if innerPos.y < 0 then
		self._bottomArrow:setVisible(true)
		self._maskImg:setVisible(true)
	end

	if innerPos.y == 0 or maxy < innerPos.y then
		self._topArrow:setVisible(true)
	end
end

function MazeTowerMapMediator:initMapGrid()
	self._curPointId = self._mazeTower:getCurPointId()
	self._pointConfig = ConfigReader:getRecordById("MazeRoom", self._curPointId)
	self._nextPointId = self._pointConfig.Next
	self._mapInfo = self._mazeTower:getMap()
	self._scrollViewSize = self._scrollView:getContentSize()
	self._line = #self._mapInfo
	self._column = #self._mapInfo[1]
	self._gridSize = cc.size(96, 96)
	self._cellNumSize = cc.size(self._column, self._line)

	for i, v in pairs(self._mapInfo) do
		for j, value in pairs(v) do
			local gridNode = self:createGrid(value)

			self._gridSize = gridNode:getContentSize()

			gridNode:addTo(self._scrollView):posite((j - 1) * self._gridSize.width, (self._line - i) * self._gridSize.height)
			gridNode:setName(i .. "_" .. j)
		end
	end

	self._scrollView:setInnerContainerSize(cc.size(self._column * self._gridSize.width, self._line * self._gridSize.height))

	self._dirOffset = {
		{
			self._column * self._gridSize.width - 40,
			0
		},
		{
			0,
			self._line * self._gridSize.height - 80
		},
		{
			50,
			0
		},
		{
			0,
			0
		}
	}
end

function MazeTowerMapMediator:createGrid(gridData)
	local layout = ccui.Layout:create()
	local gridBg = ccui.ImageView:create(((gridData:getIsBlock() or nil) and self._pointConfig.Icon[2]) .. ".png", 1)

	layout:setAnchorPoint(cc.p(0, 0))
	layout:setContentSize(gridBg:getContentSize())
	gridBg:addTo(layout):center(layout:getContentSize())

	if gridData:isHasUnFinishEvent() then
		local elementConfig = gridData:getElementConfig()
		local icon = ccui.ImageView:create(elementConfig.StateModel.model .. ".png", 1)

		icon:addTo(layout):center(layout:getContentSize()):setName("icon")
	end

	layout.gridData = gridData

	return layout
end

function MazeTowerMapMediator:refreshGrid()
	local key = self._curGridIndex.x .. "_" .. self._curGridIndex.y
	local cell = self._scrollView:getChildByName(key)
	local icon = cell:getChildByName("icon")
	local gridData = cell.gridData

	if gridData:isHasUnFinishEvent() then
		local elementConfig = gridData:getElementConfig()

		if icon then
			icon:removeFromParent()
		end

		icon = ccui.ImageView:create(elementConfig.StateModel.model .. ".png", 1)

		icon:setAnchorPoint(cc.p(0, 0))
		icon:addTo(cell):setName("icon")
	elseif icon then
		icon:setVisible(false)
	end
end

function MazeTowerMapMediator:initRole()
	local team = self._developSystem:getSpTeamByType(StageTeamType.MAZE_TOWER)
	local masterId = team:getMasterId()
	local masterData = self._masterSystem:getMasterById(masterId)
	local modelId = masterData:getModel()
	local model = ConfigReader:getDataByNameIdAndKey("RoleModel", modelId, "Model")

	self._roleNode = cc.Node:create()

	local role = RoleFactory:createRoleAnimation(model)

	role:setScale(0.35)

	self._roleScale = 0.35

	local x, y = self._mazeTower:getPosX(), self._mazeTower:getPosY()

	role:addTo(self._roleNode):posite(0, 5)

	local roleX, roleY = self._gridSize.width * y - self._gridSize.width * 0.5, self._gridSize.height * (self._line - x)

	self._roleNode:addTo(self._scrollView, 10):posite(roleX, roleY)

	self._skeletonAnimGroup = sp.SkeletonAnimationGroup:create()

	self._skeletonAnimGroup:start()
	role:setSkeletonAnimationGroup(self._skeletonAnimGroup)

	self._role = role

	local key = x .. "_" .. y
	local cell = self._scrollView:getChildByName(key)

	self._moveBg = ccui.ImageView:create("mjpt_img_bg_1.png", 1)

	self._moveBg:setAnchorPoint(cc.p(0, 0))
	self._moveBg:addTo(self._scrollView, 5):posite(cell:getPosition())
end

function MazeTowerMapMediator:locationScrollview()
	local x, y = self._mazeTower:getPosX(), self._mazeTower:getPosY()
	local offsetY = (self._line - (x - 1)) * self._gridSize.height - self._gridSize.height * 2.5
	local maxY = self._scrollView:getInnerContainerSize().height - self._scrollView:getContentSize().height

	if maxY < offsetY then
		offsetY = maxY
	end

	if offsetY < 0 then
		offsetY = 0
	end

	self._scrollView:setInnerContainerPosition(cc.p(0, -offsetY))

	self._innerPos = self._scrollView:getInnerContainerPosition()

	local innerSize = self._scrollView:getInnerContainerSize()

	if innerSize.height <= self._scrollViewSize.height then
		self._scrollView:setPositionY(self._originalPos.y + (self._scrollViewSize.height - self._line * self._gridSize.height) * 0.5)
	else
		self._scrollView:setPositionY(self._originalPos.y)
	end

	if innerSize.width <= self._scrollViewSize.width then
		self._scrollView:setPositionX(self._originalPos.x + (self._scrollViewSize.width - self._column * self._gridSize.width) * 0.5)
	else
		self._scrollView:setPositionX(self._originalPos.x)
	end
end

function MazeTowerMapMediator:getGridByPos(pos)
	local y = math.floor(pos.x / self._gridSize.width) + 1
	local x = self._line - math.floor(pos.y / self._gridSize.height)

	if x >= 1 and x <= self._line and y >= 1 and y <= self._column then
		return self._mapInfo[x][y]
	end
end

function MazeTowerMapMediator:getDirByDiff(diffPos)
	local degree = math.deg(math.atan(diffPos.y / diffPos.x))
	local dir = dirInfo[1]
	local offset = self._dirOffset[1]

	if diffPos.x >= 0 and diffPos.y >= 0 then
		if degree <= 45 then
			dir = dirInfo[1]
			offset = self._dirOffset[1]
		else
			dir = dirInfo[2]
			offset = self._dirOffset[2]
		end
	elseif diffPos.x < 0 and diffPos.y >= 0 then
		if degree <= -45 then
			dir = dirInfo[2]
			offset = self._dirOffset[2]
		else
			dir = dirInfo[3]
			offset = self._dirOffset[3]
		end
	elseif diffPos.x < 0 and diffPos.y < 0 then
		if degree <= 45 then
			dir = dirInfo[3]
			offset = self._dirOffset[3]
		else
			dir = dirInfo[4]
			offset = self._dirOffset[4]
		end
	elseif diffPos.x > 0 and diffPos.y <= 0 then
		if degree <= -45 then
			dir = dirInfo[4]
			offset = self._dirOffset[4]
		else
			dir = dirInfo[1]
			offset = self._dirOffset[1]
		end
	end

	return dir, offset
end

function MazeTowerMapMediator:initRocker()
	self._panel_rocker = self._main:getChildByName("Panel_rocker")
	self._rockerPan = self._panel_rocker:getChildByName("Image_touchPan")

	self._rockerPan:setOpacity(153)

	self._rockerPoint = self._rockerPan:getChildByName("Image_point")

	local originPosX, originPosY = self._rockerPoint:getPosition()
	local MaxDistance = 90
	local originPos = cc.p(self._rockerPan:getPosition())
	local touchBeginPos
	local timeScale = 1

	self._moveTimeForPerGrid = 0.03

	local function moveStep()
		local tickTime = app.getTime()
		local action = schedule(self:getView(), function()
			if not self._dirPos then
				return
			end

			while app.getTime() - tickTime >= self._moveTimeForPerGrid * timeScale do
				if not self._dirPos then
					return
				end

				tickTime = tickTime + self._moveTimeForPerGrid * timeScale

				local currentPos = cc.p(self._roleNode:getPosition())
				local diffPos = cc.pSub(cc.p(self._rockerPoint:getPosition()), cc.p(originPosX, originPosY))
				local absX = math.abs(diffPos.x)
				local absY = math.abs(diffPos.y)

				if absX < 10 and absY < 10 then
					timeScale = 1

					return
				end

				local dir, dirOffset = self:getDirByDiff(diffPos)
				local targetPos = cc.pAdd(currentPos, cc.p(dir[1] * 10, dir[2] * 10))

				self:dealTouch(targetPos, dirOffset)
			end
		end, 0)

		action:setTag(checkDirActionTag)
	end

	self._panel_rocker:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self._autoClickEvent = false
			self._touchPanValid = true

			self._rockerPan:setOpacity(255)
			self:getView():stopActionByTag(moveActionTag)

			touchBeginPos = sender:getTouchBeganPosition()

			local localPos = self._panel_rocker:convertToNodeSpace(touchBeginPos)
			local boundingBox = self._rockerPan:getBoundingBox()

			if not cc.rectContainsPoint(boundingBox, localPos) then
				self._rockerPan:setPosition(localPos)
			end

			self._rockerPan:setOpacity(255)
			self:getView():stopActionByTag(moveActionTag)
		elseif eventType == ccui.TouchEventType.moved then
			local curp = sender:getTouchMovePosition()

			if not self._dirPos and self._touchPanValid then
				self._dirPos = curp

				moveStep()
			end

			self._dirPos = curp

			local localPos = self._rockerPan:convertToNodeSpace(curp)
			local beginp = cc.p(originPosX, originPosY)
			local disttance = cc.pGetDistance(beginp, localPos)
			local diffPos = cc.pSub(localPos, beginp)

			if disttance > MaxDistance then
				localPos.x = beginp.x + diffPos.x * MaxDistance / disttance
				localPos.y = beginp.y + diffPos.y * MaxDistance / disttance
			end

			self._rockerPoint:setPosition(localPos)
		else
			self:stopStepMove()
			self._rockerPoint:moveTo({
				time = 0.1,
				x = originPosX,
				y = originPosY
			})
			self._rockerPan:setOpacity(191.25)
			self._rockerPan:setPosition(originPos)
		end
	end)
end

function MazeTowerMapMediator:isRoleInViewArena(rolePos)
	local rolePosY = rolePos.y
	local pos = self._scrollView:getInnerContainerPosition()
	local offsetY = rolePosY + pos.y

	if offsetY > 0 and offsetY + self._gridSize.height - self._scrollViewSize.height > 0 then
		return false
	end

	if offsetY < 0 then
		return false
	end

	return true
end

function MazeTowerMapMediator:dealTouch(pos, dirOffset)
	if not self:isRoleInViewArena(cc.p(self._roleNode:getPosition())) then
		self._scrollView:setInnerContainerPosition(self._innerPos)
	end

	local gridData = self:getGridByPos(pos)

	if not gridData then
		return
	end

	if gridData:getIsBlock() then
		return
	end

	local lastIndex = self._curGridIndex

	self._curGridIndex = cc.p(gridData:getX(), gridData:getY())

	if lastIndex.x ~= self._curGridIndex.x or lastIndex.y ~= self._curGridIndex.y then
		self._path[#self._path + 1] = self._curGridIndex
	end

	if gridData:isHasUnFinishEvent() then
		self:stopStepMove()

		return
	end

	local currentPos = cc.p(self._roleNode:getPosition())
	local diffPos = cc.p(pos.x - currentPos.x, pos.y - currentPos.y)

	diffPos.x = math.floor(diffPos.x * 100) * 0.01
	diffPos.y = math.floor(diffPos.y * 100) * 0.01

	if not self._isWalk then
		self._skeletonAnimGroup:setSpeedFactor(0.5)
		self._role:playAnimation(0, "run", true)

		self._isWalk = true
	end

	if diffPos.x < 0 then
		self._role:setScaleX(-1 * self._roleScale)
	elseif diffPos.x > 0 then
		self._role:setScaleX(self._roleScale)
	end

	if diffPos.x > 0 and pos.x > dirOffset[1] then
		return
	end

	if diffPos.x < 0 and pos.x < dirOffset[1] then
		return
	end

	if diffPos.y > 0 and pos.y > dirOffset[2] then
		return
	end

	if diffPos.y < 0 and pos.y < dirOffset[2] then
		return
	end

	if diffPos.x ~= 0 or diffPos.y ~= 0 then
		self._roleNode:offset(diffPos.x, diffPos.y)

		local key = gridData:getX() .. "_" .. gridData:getY()
		local cell = self._scrollView:getChildByName(key)

		self._moveBg:posite(cell:getPosition())
	end

	local rolePosY = self._roleNode:getPositionY()
	local pos = self._scrollView:getInnerContainerPosition()
	local offsetY = rolePosY + pos.y

	if offsetY > 0 and offsetY + self._gridSize.height - self._scrollViewSize.height > 0 then
		self._scrollView:setInnerContainerPosition(cc.p(pos.x, pos.y - diffPos.y))
	end

	if offsetY < 0 then
		self._scrollView:setInnerContainerPosition(cc.p(pos.x, pos.y - diffPos.y))
	end

	self._innerPos = self._scrollView:getInnerContainerPosition()

	self:refreshArrowShow()
end

function MazeTowerMapMediator:stopStepMove()
	self._dirPos = nil
	self._touchPanValid = false

	self:getView():stopActionByTag(checkDirActionTag)
	self._role:playAnimation(0, "stand", true)
	self:moveEnd()

	self._path = {}
	self._isWalk = false
end

function MazeTowerMapMediator:resetRolePosition()
	local x, y = self._mazeTower:getPosX(), self._mazeTower:getPosY()
	local roleX, roleY = self._gridSize.width * y - self._gridSize.width * 0.5, self._gridSize.height * (self._line - x)

	self._roleNode:posite(roleX, roleY)

	local key = x .. "_" .. y
	local cell = self._scrollView:getChildByName(key)

	if cell then
		self._moveBg:posite(cell:getPosition())
	end
end

function MazeTowerMapMediator:showPassView(callback)
	local delegate = __associated_delegate__(self)({
		willClose = function(self, popUpMediator, data)
			if callback then
				callback()
			end
		end
	})
	local view = self:getInjector():getInstance("MazeTowerPassView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, delegate))
end

function MazeTowerMapMediator:onClickBack()
	self:dismiss({})
end

function MazeTowerMapMediator:onClickRule()
	local rules = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Maze_RuleTranslate", "content")
	local params = {
		time = TimeUtil:getSystemResetDate()
	}
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		useParam = true,
		rule = rules.Desc,
		extraParams = params
	}, nil)

	self:dispatch(event)
end

function MazeTowerMapMediator:moveEnd()
	if #self._path == 0 then
		return
	end

	local gridData = self._mapInfo[self._curGridIndex.x][self._curGridIndex.y]

	if gridData and gridData:isHasUnFinishEvent() then
		local elementConfig = gridData:getElementConfig()

		if elementConfig.Type == "NORMAL" or elementConfig.Type == "BOSS" then
			if self._mazeTower:getFightTime() > 0 then
				local view = self:getInjector():getInstance("MazeTowerChallengeView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
					gridData = gridData
				}))
			else
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Maze_Tip_2")
				}))
			end

			table.remove(self._path, #self._path)
		end
	end

	local pos = {}

	for i, v in pairs(self._path) do
		pos[#pos + 1] = {
			v.x,
			v.y
		}
	end

	self._mazeTowerSystem:requestMove({
		pos = pos
	})
end

function MazeTowerMapMediator:onMoveFinish(event)
	local data = event:getData()

	self._curGridIndex = cc.p(self._mazeTower:getPosX(), self._mazeTower:getPosY())

	local gridData = self._mapInfo[self._curGridIndex.x][self._curGridIndex.y]

	if gridData then
		local rewards = data.rewards

		if rewards then
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				rewards = rewards
			}))
			self:resetRolePosition()
		end

		self:refreshView()
	end
end
