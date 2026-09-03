-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleGroundLayer.lua

require("dm.battle.view.widget.BattleGroundCell")
require("dm.battle.view.BattlePerspective")

local gBattleArrayLayout = {
	{
		x = -0.38,
		y = 0.8333333333333334
	},
	{
		x = -0.38,
		y = 0.5
	},
	{
		x = -0.38,
		y = 0.16666666666666666
	},
	{
		x = -0.78,
		y = 0.8333333333333334
	},
	{
		x = -0.78,
		y = 0.5
	},
	{
		x = -0.78,
		y = 0.16666666666666666
	},
	{
		x = -1.18,
		y = 0.8333333333333334
	},
	{
		x = -1.18,
		y = 0.5
	},
	{
		x = -1.18,
		y = 0.16666666666666666
	}
}

function relPositionOfLeftside(idx)
	local pos = gBattleArrayLayout[idx % 100]

	return {
		x = pos.x,
		y = pos.y
	}
end

function relPositionOfRightside(idx)
	local pos = gBattleArrayLayout[idx % 100]

	return {
		x = -pos.x,
		y = pos.y
	}
end

local GROUNDCELL_NUM = 9
local ROLE_TOP_ZORDER = 10
local NORMAL_OPACITY = 180

BattleGroundLayer = class("BattleGroundLayer", BaseWidget, _M)

BattleGroundLayer:has("_contentLayer", {
	is = "r"
})
BattleGroundLayer:has("_groundLayer", {
	is = "r"
})
BattleGroundLayer:has("_leftGroundCells", {
	is = "r"
})
BattleGroundLayer:has("_rightGroundCells", {
	is = "r"
})
BattleGroundLayer:has("_viewContext", {
	is = "rw"
})

function BattleGroundLayer:initialize(view)
	super.initialize(self, view)
	self:setupView()
end

function BattleGroundLayer:dispose()
	for i, v in ipairs(self._leftGroundCells) do
		v:dispose()
	end

	for i, v in ipairs(self._rightGroundCells) do
		v:dispose()
	end

	super.dispose(self)
end

function BattleGroundLayer:enterWithData(data)
	self:initTeam()

	self._leftGroundCells = {}
	self._rightGroundCells = {}

	self:setupGroundCells(true)
	self:setupGroundCells(false)
	self:setupLeftGroundRect()
	self:setupRightGroundRect()
	self:registerTouchEvent()
end

function BattleGroundLayer:setupView()
	local view = self:getView()

	self._contentLayer = cc.Node:create()

	view:addChild(self._contentLayer)

	self._groundLayer = cc.GroupedNode:create()

	self._contentLayer:addChild(self._groundLayer)

	self._effectLayer = cc.Node:create()

	self._contentLayer:addChild(self._effectLayer, 1)

	self._cellLayer = cc.Node:create()

	self._groundLayer:addChild(self._cellLayer, -999)
end

function BattleGroundLayer:getCellLayer()
	return self._cellLayer
end

function BattleGroundLayer:adjustLayout(targetFrame)
	AdjustUtils.adjustLayoutByType(self:getView(), AdjustUtils.kAdjustType.Left)

	self.viewFrame = targetFrame

	self:setGroundTransform(0, 0, 1)

	local normResolution = CC_DESIGN_RESOLUTION

	self.blackMaskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), targetFrame.width * 2, targetFrame.height * 2)

	self.blackMaskLayer:setPosition(-display.width / 2, -display.height / 2)
	self._contentLayer:addChild(self.blackMaskLayer, -1)
	self.blackMaskLayer:setVisible(false)

	local maskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), targetFrame.width * 2, targetFrame.height * 2)

	maskLayer:setPosition(-targetFrame.width / 2, -normResolution.height / 2)
	self._contentLayer:addChild(maskLayer, -1)
	maskLayer:setVisible(false)

	self.maskLayer = maskLayer
end

function BattleGroundLayer:getViewFrame()
	return self.viewFrame
end

function BattleGroundLayer:getGroundFrame()
	return self.groundFrame
end

function BattleGroundLayer:getBattleArrayLayout()
	return gBattleArrayLayout
end

function BattleGroundLayer:getPerspectiveTool()
	return self.perspectiveTool
end

function BattleGroundLayer:setGroundTransform(tx, ty, scale)
	local viewFrame = self.viewFrame

	assert(viewFrame ~= nil, "viewFrame is uninitialized")

	local s = scale or 1
	local width = 732 * s
	local height = 256 * s

	self.perspectiveTool = BattlePerspective:new(width, height, 1, 3.5)

	self.perspectiveTool:setFarScale(0.9)

	local originx, originy = viewFrame.width * 0.5, 180

	if tx ~= nil then
		originx = originx + tx
	end

	if ty ~= nil then
		originy = originy + ty
	end

	self._groundLayer:setPosition(originx, originy)
	self._effectLayer:setPosition(originx, originy)

	self.groundFrame = {
		x = originx - width * 0.5,
		y = originy,
		width = width,
		height = height
	}
end

function BattleGroundLayer:setBlockCells(blockCells)
	self._blockCells = blockCells or {}

	self:previewCellLocks()
end

function BattleGroundLayer:initTeam()
	self._leftTeam = {}
	self._rightTeam = {}

	for i = 1, GROUNDCELL_NUM do
		self._leftTeam[i] = nil
		self._rightTeam[i] = nil
	end
end

function BattleGroundLayer:addUnitToTeam(isLeft, unit, pos)
	if isLeft then
		self._leftTeam[pos] = unit
	else
		self._rightTeam[pos] = unit
	end
end

function BattleGroundLayer:addEffevtive(node, position)
	self._effectLayer:addChild(node)
	node:setPosition(position)
end

function BattleGroundLayer:setupGroundCells(isLeft)
	local resPre = "pic_zhandou_zhanwei"

	for i = 1, GROUNDCELL_NUM do
		local var_18_0 = {
			normalImage = string.format(resPre .. "%02d_press_3.png", i)
		}

		var_18_0.occupiedImage = i == 8 and string.format(resPre .. "_zhu_%d.png", isLeft and 1 or 2) or nil
		var_18_0.highLightImage = string.format(resPre .. "%02d_press_3.png", i)
		var_18_0.healTargetImage = string.format(resPre .. "%02d_press", i) .. ".png"
		var_18_0.targetImage = string.format(resPre .. "%02d_press", i) .. "_2.png"
		var_18_0.randomImage = string.format(resPre .. "%02d_wen_%d.png", i, isLeft and 1 or 2)
		var_18_0.lockImage = string.format(resPre .. "%02d_press_4.png", i)
		var_18_0.isLeft = isLeft

		local args = var_18_0
		local groundCell = BattleGroundCell:new(args)
		local pos = self:relPositionFor(isLeft, i)

		groundCell:setBattleGround(self)

		local node = groundCell:getDisplayNode()

		groundCell:setOpacity(NORMAL_OPACITY)
		groundCell:setRelPosition(pos)
		self._cellLayer:addChild(node, -999)
		groundCell:setPosInTeam(i)
		groundCell:setScale(1, 1)

		if not isLeft then
			groundCell:setScaleX(-1 * node:getScaleX())

			self._rightGroundCells[i] = groundCell
		else
			self._leftGroundCells[i] = groundCell
		end
	end
end

function BattleGroundLayer:setupLeftGroundRect()
	self._leftGroundRect = {}

	local cell = self._leftGroundCells[9]
	local pos = cc.p(cell:getDisplayNode():getPosition())

	pos = cell:getDisplayNode():getParent():convertToWorldSpace(pos)

	local size = cell:getViewFrame()

	self._leftGroundRect.x = pos.x - size.width * 0.5
	self._leftGroundRect.y = pos.y - size.height * 0.5
	cell = self._leftGroundCells[1]
	pos = cc.p(self._leftGroundCells[1]:getDisplayNode():getPosition())
	pos = self._leftGroundCells[1]:getDisplayNode():getParent():convertToWorldSpace(pos)
	size = self._leftGroundCells[1]:getViewFrame()
	self._leftGroundRect.width = pos.x + size.width * 0.5
	self._leftGroundRect.height = pos.y + size.height * 0.5

	return self._leftGroundRect
end

function BattleGroundLayer:setupRightGroundRect()
	self._rightGroundRect = {}

	local cell = self._rightGroundCells[3]
	local pos = cc.p(cell:getDisplayNode():getPosition())

	pos = cell:getDisplayNode():getParent():convertToWorldSpace(pos)

	local size = cell:getViewFrame()

	self._rightGroundRect.x = pos.x + size.width * 0.5
	self._rightGroundRect.y = pos.y - size.height * 0.5
	cell = self._rightGroundCells[7]
	pos = cc.p(self._rightGroundCells[7]:getDisplayNode():getPosition())
	pos = self._rightGroundCells[7]:getDisplayNode():getParent():convertToWorldSpace(pos)
	size = self._rightGroundCells[7]:getViewFrame()
	self._rightGroundRect.width = pos.x + size.width * 0.5
	self._rightGroundRect.height = pos.y + size.height * 0.5

	return self._rightGroundRect
end

function BattleGroundLayer:setRelPosition(node, relPos, extraZ, height)
	local x, y, s, d2 = self.perspectiveTool:norm2view(relPos.x, relPos.y)

	d2 = d2 * 10

	local z = math.floor((extraZ or 0) - d2)

	node:setPosition(x, y + (height or 0))
	node:setLocalZOrder(z)
	node:setScale(s)
end

function BattleGroundLayer:relPositionFor(isLeft, idx)
	if isLeft then
		return relPositionOfLeftside(idx)
	else
		return relPositionOfRightside(idx)
	end
end

function BattleGroundLayer:convertView2RelPosition(pos)
	return cc.p(self.perspectiveTool:view2norm(pos.x, pos.y))
end

function BattleGroundLayer:convertRelPosition2View(relPos)
	local x, y, s, d2 = self.perspectiveTool:norm2view(relPos.x, relPos.y)

	return cc.p(x, y)
end

function BattleGroundLayer:convertRelPos2WorldSpace(relPos)
	local pos = self:convertRelPosition2View(relPos)

	return self._groundLayer:convertToWorldSpace(pos)
end

function BattleGroundLayer:convertWorldSpace2RelPos(pos)
	local p = self._groundLayer:convertToNodeSpace(pos)

	return self:convertView2RelPosition(p)
end

function BattleGroundLayer:relPosWithZoneAndOffset(zone, x, y)
	local yUnitLen = gBattleArrayLayout[1].y - gBattleArrayLayout[2].y

	if zone == 1 then
		local xUnitLen = gBattleArrayLayout[1].x - gBattleArrayLayout[4].x
		local originX = gBattleArrayLayout[1].x + xUnitLen
		local originY = gBattleArrayLayout[1].y + yUnitLen

		return {
			x = originX - x * xUnitLen,
			y = originY - y * yUnitLen
		}
	elseif zone == -1 then
		local xUnitLen = gBattleArrayLayout[1].x - gBattleArrayLayout[4].x
		local originX = -(gBattleArrayLayout[1].x + xUnitLen)
		local originY = gBattleArrayLayout[1].y + yUnitLen

		return {
			x = originX + x * xUnitLen,
			y = originY - y * yUnitLen
		}
	elseif zone == 0 then
		local xUnitLen = -gBattleArrayLayout[1].x / 2
		local originX = 0
		local originY = gBattleArrayLayout[1].y + yUnitLen

		return {
			x = originX - x * xUnitLen,
			y = originY - y * yUnitLen
		}
	end

	return {
		x = 0,
		y = 0
	}
end

function BattleGroundLayer:findNearbyEmpty(point, sender)
	local shortestLength = 70
	local retPos = -1

	for idx, __ in ipairs(self._leftGroundCells) do
		local cell = self._leftGroundCells[idx]

		if cell:canBeSitByCard(sender) and not cell:isLocked() then
			local cellPos = cc.p(cell:getDisplayNode():getPosition())
			local parentNode = cell:getDisplayNode():getParent()

			cellPos = parentNode:convertToWorldSpace(cellPos)

			local length = cc.pGetDistance(cellPos, point)

			if length < shortestLength then
				shortestLength = length
				retPos = idx
			end
		end

		if cell:getStatus() == GroundCellStatus.HIGHLIGHT and retPos < idx then
			cell:setStatus(GroundCellStatus.NORMAL)
		end
	end

	if retPos ~= -1 then
		local cell = self._leftGroundCells[retPos]

		cell:setStatus(GroundCellStatus.HIGHLIGHT)
	end

	return retPos
end

function BattleGroundLayer:findNearbyEmptyForExtraCard(point, sender, touchArea)
	local function hasCollision(idx, isLeft)
		for k, v in pairs(touchArea) do
			if math.abs(v.id) == idx then
				local rightDir = false

				rightDir = isLeft and v.id > 0 or v.id < 0

				if rightDir then
					return true
				end
			end
		end

		return false
	end

	local shortestLength = 70
	local retPos = -1
	local left = -1

	for idx, __ in ipairs(self._leftGroundCells) do
		if touchArea and hasCollision(idx, true) then
			local cell = self._leftGroundCells[idx]

			if cell:canBeSitByExtraSkillCard(sender) and not cell:isLocked() then
				local cellPos = cc.p(cell:getDisplayNode():getPosition())
				local parentNode = cell:getDisplayNode():getParent()

				cellPos = parentNode:convertToWorldSpace(cellPos)

				local length = cc.pGetDistance(cellPos, point)

				if length < shortestLength then
					shortestLength = length
					retPos = idx
					left = -1
				end
			end

			if cell:getStatus() == GroundCellStatus.HIGHLIGHT and retPos < idx then
				cell:setStatus(GroundCellStatus.NORMAL)
			end
		end
	end

	for idx, __ in ipairs(self._rightGroundCells) do
		if touchArea and hasCollision(idx, false) then
			local cell = self._rightGroundCells[idx]

			if cell:canBeSitByExtraSkillCard(sender) and not cell:isLocked() then
				local cellPos = cc.p(cell:getDisplayNode():getPosition())
				local parentNode = cell:getDisplayNode():getParent()

				cellPos = parentNode:convertToWorldSpace(cellPos)

				local length = cc.pGetDistance(cellPos, point)

				if length < shortestLength then
					shortestLength = length
					retPos = idx
					left = 1
				end
			end

			if cell:getStatus() == GroundCellStatus.HIGHLIGHT and retPos < idx then
				cell:setStatus(GroundCellStatus.NORMAL)
			end
		end
	end

	if retPos ~= -1 then
		if left < 0 then
			local cell = self._leftGroundCells[retPos]

			if cell then
				cell:setStatus(GroundCellStatus.HIGHLIGHT)
			end
		else
			local cell = self._rightGroundCells[retPos]

			if cell then
				cell:setStatus(GroundCellStatus.HIGHLIGHT)
			end
		end
	end

	return retPos, left == -1
end

function BattleGroundLayer:checkTouchCollision(sender, point, touchArea)
	if not sender.getType or sender:getType() == "hero" then
		local retPos = -1

		if cc.rectContainsPoint(self._leftGroundRect, point) then
			retPos = self:findNearbyEmpty(point, sender)
		end

		for idx, cell in ipairs(self._leftGroundCells) do
			if idx ~= retPos and cell:getStatus() == GroundCellStatus.HIGHLIGHT then
				cell:setStatus(GroundCellStatus.NORMAL)
			end
		end

		return retPos ~= -1, retPos
	else
		local retPos = -1
		local isleft

		if cc.rectContainsPoint(self._leftGroundRect, point) then
			retPos, isleft = self:findNearbyEmptyForExtraCard(point, sender, touchArea)
		end

		if cc.rectContainsPoint(self._rightGroundRect, point) then
			retPos, isleft = self:findNearbyEmptyForExtraCard(point, sender, touchArea)
		end

		for idx, cell in ipairs(self._leftGroundCells) do
			if idx ~= retPos and cell:getStatus() == GroundCellStatus.HIGHLIGHT then
				cell:setStatus(GroundCellStatus.NORMAL)
			end
		end

		for idx, cell in ipairs(self._rightGroundCells) do
			if idx ~= retPos and cell:getStatus() == GroundCellStatus.HIGHLIGHT then
				cell:setStatus(GroundCellStatus.NORMAL)
			end
		end

		return retPos ~= -1, retPos, isleft
	end
end

function BattleGroundLayer:checkCanPushHero(sender, point)
	if not sender then
		return false
	end

	local canPush, pos, isleft = self:checkTouchCollision(sender, point)

	if canPush then
		local cell = self._leftGroundCells[pos]

		cell:setStatus(GroundCellStatus.NORMAL)

		self._willPushCell = cell
		self._posIdx = pos

		return true, self._posIdx, isleft
	end

	return false
end

function BattleGroundLayer:resetGroundCell(cellId, status, heroModel)
	if not self._leftGroundCells[cellId] then
		return
	end

	if cellId > 0 then
		self._leftGroundCells[cellId]:setStatus(status, heroModel)

		self._leftTeam[cellId] = nil
	else
		self._rightGroundCells[-cellId]:setStatus(status, heroModel)

		self._rightTeam[-cellId] = nil
	end
end

function BattleGroundLayer:setCellOccupiedHero(cellId, heroModel)
	if not self._leftGroundCells[cellId] then
		return
	end

	if cellId > 0 then
		self._leftGroundCells[cellId]:setOccupiedHero(heroModel)
	else
		self._rightGroundCells[-cellId]:setOccupiedHero(heroModel)
	end
end

function BattleGroundLayer:checkCanPushSkill(sender, point, extra)
	if not sender then
		return false
	end

	local minY = self._leftGroundRect.y
	local maxY = minY + self._leftGroundRect.height

	if minY <= point.y and maxY >= point.y then
		return true
	end

	return false
end

function BattleGroundLayer:swipCellOccupiedHero(orgCellId, descCellId, heroModel)
	if orgCellId > 0 then
		local oldOccupiedHeros = self._leftGroundCells[orgCellId]:getOccupiedHeros()
		local newOccupiedHeros = self._leftGroundCells[descCellId]:getOccupiedHeros()

		self._leftGroundCells[orgCellId]:setOccupiedHeros(newOccupiedHeros)
		self._leftGroundCells[descCellId]:setOccupiedHeros(oldOccupiedHeros)
	else
		local oldOccupiedHeros = self._rightGroundCells[-orgCellId]:getOccupiedHeros()
		local newOccupiedHeros = self._rightGroundCells[-descCellId]:getOccupiedHeros()

		self._rightGroundCells[-orgCellId]:setOccupiedHeros(newOccupiedHeros)
		self._rightGroundCells[-descCellId]:setOccupiedHeros(oldOccupiedHeros)
	end
end

function BattleGroundLayer:getCellById(cellId)
	if cellId > 0 then
		return self._leftGroundCells[cellId]
	else
		return self._rightGroundCells[-cellId]
	end
end

function BattleGroundLayer:setTouchEnabled(enabled)
	self._touchEnabled = enabled
end

function BattleGroundLayer:isTouchEnabled()
	return self._touchEnabled
end

function BattleGroundLayer:registerTouchEvent()
	local function onTouched(touch, event)
		local eventType = event:getEventCode()

		if eventType == ccui.TouchEventType.began then
			return self:onTouchBegan(touch, event)
		elseif eventType == ccui.TouchEventType.moved then
			self:onTouchMoved(touch, event)
		elseif eventType == ccui.TouchEventType.ended then
			self:onTouchEnded(touch, event)
		end
	end

	local listener = cc.EventListenerTouchOneByOne:create()

	listener:setSwallowTouches(true)
	listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_ENDED)
	self:getView():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self:getView())
end

function BattleGroundLayer:addUnrealModel(role)
	local res = role:getStaticModelRes()

	self._pickModel = cc.Node:create()

	self._groundLayer:addChild(self._pickModel, 999)

	local model = cc.Sprite:create(res)

	model:setScaleX(-self._pickRole:getScale())
	model:setScaleY(self._pickRole:getScale())
	model:setOpacity(128)
	model:setAnchorPoint(cc.p(0.5, 0))
	self._pickModel:addChild(model)
	self:setRelPosition(self._pickModel, self._pickRole:getHomePlace(), nil, self._pickRole:getHeightOffset())
end

function BattleGroundLayer:createUnrealSpine(modelId)
	if self._pickSpine then
		self._pickSpine:removeAllChildren()
	else
		self._pickSpine = cc.Node:create()

		self._groundLayer:addChild(self._pickSpine, 0)
	end

	self._prevModel = modelId

	local modelCfg = ConfigReader:getRecordById("RoleModel", modelId)
	local model = modelCfg and modelCfg.Model
	local pre = "asset/anim/"
	local jsonFile = pre .. model .. ".skel"

	if not cc.FileUtils:getInstance():isFileExist(jsonFile) then
		jsonFile = self:createDefaultModel()
	end

	local roleAnim = sp.SkeletonAnimation:create(jsonFile)

	self._pickSpine:addChild(roleAnim)
	roleAnim:playAnimation(0, "stand", true)
	roleAnim:stopAnimation()
	roleAnim:setScale(0.675 * ((modelCfg or nil) and (modelCfg.Zoom or 1)) * 1.2)
	self._pickSpine:setVisible(false)
end

function BattleGroundLayer:attachSpine(modelId, cellId, touchPoint)
	if self._prevModel ~= modelId then
		self:createUnrealSpine(modelId)
	end

	self._pickSpine:setVisible(true)

	if cellId and false then
		local pos

		self:setRelPosition(self._pickSpine, cellId > 0 and relPositionOfLeftside(cellId) or relPositionOfRightside(-cellId), ROLE_TOP_ZORDER)
	else
		local touchPos = self._groundLayer:convertToNodeSpace(touchPoint)
		local pos = cc.p(self.perspectiveTool:view2norm(touchPos.x, touchPos.y))

		self:setRelPosition(self._pickSpine, pos, ROLE_TOP_ZORDER)
	end
end

function BattleGroundLayer:scaleCell(cellId)
	if cellId then
		for idx, cell in ipairs(self._leftGroundCells) do
			if idx == cellId and cell:getStatus() == GroundCellStatus.HIGHLIGHT then
				cell:runScaleAction()
			end
		end
	end
end

function BattleGroundLayer:hideUnrealSpine()
	if self._pickSpine then
		self._pickSpine:setVisible(false)
	end
end

function BattleGroundLayer:createDeaultModel()
	return "asset/anim/YFZZhu.skel"
end

function BattleGroundLayer:onTouchBegan(touch, event)
	if not self._touchEnabled then
		return false
	end

	if self._heroCard and self._heroCard:getType() ~= "hero" then
		if self._cancelHeroCardCallback then
			self._cancelHeroCardCallback()
		end

		return false
	end

	local pt = touch:getLocation()

	for i = 1, GROUNDCELL_NUM do
		local cell = self._leftGroundCells[i]
		local aabb = cell:getAABB()
		local wpos = cell:getDisplayNode():convertToWorldSpace(cc.p(0, 0))

		aabb = cc.rect(wpos.x - aabb.width / 2, wpos.y - aabb.height / 2, aabb.width, aabb.height)

		if cc.rectContainsPoint(aabb, pt) then
			if not cell:canBeSitByCard(self._heroCard) and self._leftTeam[i] then
				do return false end

				self._originTouchPos = pt
				self._pickRole = self._leftTeam[i]
				self._pickCell = cell
				self._pickCellIdx = i

				local roleNode = self._pickRole:getView()

				self._originRolePos = cc.p(roleNode:getPosition())

				self:addUnrealModel(self._pickRole)

				return true
			end

			return true
		end
	end

	if self._cancelHeroCardCallback then
		self._cancelHeroCardCallback()
	end

	return false
end

function BattleGroundLayer:onTouchMoved(touch, event)
	if not self._touchEnabled then
		return false
	end

	if self._heroCard and self._heroCard:getType() ~= "hero" then
		return false
	end

	local pt = touch:getLocation()

	self.checkTouchCollision(self, self, pt)
end

function BattleGroundLayer:onTouchEnded(touch, event)
	local touchPoint = touch:getLocation()
	local activeCard = self._heroCard
	local canPush, posIdx = self:checkCanPushHero(activeCard, touchPoint)

	if not canPush then
		return
	end

	if self._viewContext:isBattleFinished() then
		return
	end

	if self._heroCard and self._heroCard:getType() ~= "hero" then
		return false
	end

	local cost = activeCard:getCost()
	local uiMediator = self._viewContext:getValue("BattleUIMediator")

	if not uiMediator:checkEnergy(cost) then
		uiMediator:shineEnergyBar()

		return
	end

	if not activeCard:isAvailable() then
		return
	end

	self._onHeroCardCallback(self._heroCardArray, activeCard, posIdx)
end

function BattleGroundLayer:setCancelHeroCardCallback(callback)
	self._cancelHeroCardCallback = callback
end

function BattleGroundLayer:onClickedCell(cellId)
	self._onHeroCardCallback(self._heroCardArray, self._heroCard, cellId)
end

function BattleGroundLayer:onHeroCardTouchBegan(callback, cardArray, card)
	for idx, cell in ipairs(self._leftGroundCells) do
		cell:setOpacity(255)
	end

	self._onHeroCardCallback = callback
	self._heroCardArray = cardArray
	self._heroCard = card
end

function BattleGroundLayer:onHeroCardTouchEnded()
	for idx, cell in ipairs(self._leftGroundCells) do
		cell:setOpacity(NORMAL_OPACITY)
	end

	self._onHeroCardCallback = nil
	self._heroCardArray = nil
	self._heroCard = nil
end

function BattleGroundLayer:setMaskColorInvert(duration)
	self.maskLayer:setColor(cc.c4b(255, 255, 255, 255))

	local bf = cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE_MINUS_SRC_COLOR)

	self.maskLayer:setBlendFunc(bf)

	local delayTime = cc.DelayTime:create(duration)
	local call = cc.CallFunc:create(function()
		local bf = cc.blendFunc(gl.DST_COLOR, gl.SRC_COLOR)

		self.maskLayer:setBlendFunc(bf)
		self.maskLayer:setColor(cc.c4b(0, 0, 0, 255))
		self.maskLayer:setVisible(false)
	end)

	self.maskLayer:setVisible(true)
	self.maskLayer:runAction(cc.Sequence:create(delayTime, call))
end

function BattleGroundLayer:changeMaskLayer(colorInfo, duration, onEnd)
	if self.maskLayer == nil or colorInfo == nil then
		return
	end

	if self.maskLayer ~= nil then
		self.maskLayer:stopAllActions()
	end

	if colorInfo.color ~= nil then
		self.maskLayer:setColor(colorInfo.color)
	end

	if not colorInfo.opacity then
		local opacity = 255

		opacity = math.max(0, math.min(opacity, 255))

		if duration == nil or duration <= 0 then
			self.maskLayer:setVisible(opacity > 0)
			self.maskLayer:setOpacity(opacity)

			if onEnd ~= nil then
				onEnd()
			end
		else
			local fadeTo = cc.FadeTo:create(duration, opacity)
			local call = cc.CallFunc:create(function()
				self.maskLayer:setVisible(opacity > 0)

				if onEnd ~= nil then
					onEnd()
				end
			end)

			self.maskLayer:setVisible(true)
			self.maskLayer:runAction(cc.Sequence:create(fadeTo, call))
		end
	end
end

function BattleGroundLayer:flashScreen(arr, fps, callback)
	local actions = {}
	local index = 0
	local timePerFrame = 1 / fps
	local runNextAction, runOneAction

	function runOneAction(func, duration)
		if func ~= nil then
			func()
		end

		if self._flashTask ~= nil then
			self._flashTask:stop()

			self._flashTask = nil
		end

		if duration <= 0 then
			runNextAction()
		else
			local delayCountDown = duration
			local scheduler = self._viewContext:getScalableScheduler()

			self._flashTask = scheduler:schedule(function(task, dt)
				local timeFactor = self._viewContext:getTimeFactor()

				delayCountDown = delayCountDown - dt / timeFactor

				if delayCountDown <= 0 then
					task:stop()

					self._flashTask = nil

					runNextAction()
				end
			end)
		end
	end

	function runNextAction()
		index = index + 1

		if index <= #actions then
			local action = actions[index]

			runOneAction(action.func, action.duration or 0)
		else
			self:changeMaskLayer({
				opacity = 0,
				color = cc.c3b(0, 0, 0)
			}, 0)

			if callback then
				callback()
			end
		end
	end

	for _, task in ipairs(arr) do
		local color = GameStyle:stringToColor(task.color)
		local opacity = (task.alpha or 1) * 255

		if task.fadein ~= nil and task.fadein > 0 then
			local duration = (task.fadein or 0) * timePerFrame

			actions[#actions + 1] = {
				duration = duration,
				func = function()
					self:changeMaskLayer({
						color = color,
						opacity = opacity
					}, duration)
				end
			}
		end

		local duration = (task.duration or 1) * timePerFrame

		if duration > 0 and not task.colorInvert then
			actions[#actions + 1] = {
				duration = duration,
				func = function()
					self:changeMaskLayer({
						color = color,
						opacity = opacity
					}, 0)
				end
			}
		end

		if task.fadeout ~= nil and task.fadeout > 0 then
			local duration = (task.fadeout or 0) * timePerFrame

			actions[#actions + 1] = {
				duration = duration,
				func = function()
					self:changeMaskLayer({
						opacity = 0,
						color = color
					}, duration)
				end
			}
		end

		if task.colorInvert then
			local duration = (task.duration or 1) * timePerFrame

			actions[#actions + 1] = {
				duration = duration,
				func = function()
					self:setMaskColorInvert(duration)
				end
			}
		end
	end

	runNextAction()
end

function BattleGroundLayer:rock(rockType, amplitude, duration)
	rockType = rockType or 1
	amplitude = amplitude or 1

	local actionConfig = ConfigReader:getRecordById("ShakeScreen", tostring(rockType))
	local action = actionConfig.Factor
	local actionType = actionConfig.ShakeType

	for i, v in ipairs(action) do
		if actionType == "move" then
			v[3] = 1
		elseif actionType == "scale" then
			local s = v[1]

			v = {
				0,
				0,
				s
			}
		end
	end

	local battleCamera = self._viewContext:getValue("Camera")

	battleCamera:shake(action, duration or 0.03, amplitude)
end

function BattleGroundLayer:slowDown(configs)
	if configs == nil then
		return
	end

	local index = 1
	local config = configs[index]
	local mainMediator = self._viewContext:getValue("BattleMainMediator")
	local timeFactor = self._viewContext:getTimeFactor()
	local slow

	function slow(value, duration)
		if self._slowDownTask then
			self._slowDownTask:stop()

			self._slowDownTask = nil

			mainMediator:setTimeFactor(timeFactor)
		end

		mainMediator:setTimeFactor(value)

		local scheduler = self._viewContext:getScalableScheduler()

		self._slowDownTask = scheduler:schedule(function(task, dt)
			duration = duration - dt / value

			if duration < 0 then
				task:stop()

				self._slowDownTask = nil
				index = index + 1

				if index <= #configs then
					local config = configs[index]

					slow(config.value, config.duration)
				else
					mainMediator:setTimeFactor(timeFactor)
				end
			end
		end)
	end

	if config then
		slow(config.value, config.duration)
	end
end

function BattleGroundLayer:addEffectNode(anim, pos, callback)
	local relPos = self:convertView2RelPosition(pos)

	self:setRelPosition(anim, relPos)
	self._effectLayer:addChild(anim)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
		mc:removeFromParent(true)

		if callback then
			callback(mc)
		end
	end)
	anim:gotoAndPlay(1)
end

function BattleGroundLayer:addGroundBlackCount()
	self._groundBlackCount = self._groundBlackCount or 0
	self._groundBlackCount = self._groundBlackCount + 1

	self.blackMaskLayer:setOpacity(180)
	self.blackMaskLayer:setVisible(true)
end

function BattleGroundLayer:subGroundBlackCount()
	if not self._groundBlackCount then
		return
	end

	self._groundBlackCount = self._groundBlackCount - 1

	if self._groundBlackCount == 0 then
		self.blackMaskLayer:setOpacity(0)
		self.blackMaskLayer:setVisible(false)
	end
end

function BattleGroundLayer:previewCellLocks()
	if self._blockCells then
		for _, cellId in ipairs(self._blockCells) do
			local cell = self:getCellById(cellId)

			cell:showBlock()
		end
	end
end

function BattleGroundLayer:resumeCellLocks()
	if self._blockCells then
		for _, cellId in ipairs(self._blockCells) do
			local cell = self:getCellById(cellId)

			cell:hideBlock()
		end
	end
end

function BattleGroundLayer:previewTargets(infos, skipResume)
	if not skipResume then
		self:resumePreviews()
	end

	if infos then
		for _, cellInfo in ipairs(infos) do
			local cell = self:getCellById(cellInfo.id)

			cell:setPreview(cellInfo)
		end
	end
end

function BattleGroundLayer:resumePreviews()
	for i, cell in ipairs(self._leftGroundCells) do
		cell:resumePreview()
	end

	for i, cell in ipairs(self._rightGroundCells) do
		cell:resumePreview()
	end
end

local function __pos2id(zone, x, y)
	if zone > 0 then
		return (x - 1) * 3 + y
	elseif zone < 0 then
		return (1 - x) * 3 - y
	end
end

function BattleGroundLayer:showTarget(targets, actId, isHeal)
	local flip = self._viewContext:getValue("IsTeamAView") and 1 or -1

	for _, pos in ipairs(targets) do
		local cellId = __pos2id(pos.zone * flip, pos.x, pos.y)
		local cell = self:getCellById(cellId)

		cell:showTarget(actId, isHeal)
	end
end

function BattleGroundLayer:cancelTarget(actId)
	for i, cell in ipairs(self._leftGroundCells) do
		cell:cancelTarget(actId)
	end

	for i, cell in ipairs(self._rightGroundCells) do
		cell:cancelTarget(actId)
	end
end

function BattleGroundLayer:dropBattleLoot(srcRoleObject, item)
	if srcRoleObject:isLeft() then
		return
	end

	local context = self._viewContext
	local lootsWidget = context:getValue("BattleLootWidget")

	if lootsWidget == nil then
		return
	end

	local rolePos = srcRoleObject:getRelPosition()
	local roleHeight = srcRoleObject:getModelHeight()
	local viewPos = self:convertRelPosition2View(rolePos)
	local normPos = self:convertView2RelPosition({
		y = 0,
		x = viewPos.x
	})
	local dropPoint = {
		x = normPos.x,
		y = normPos.y,
		z = roleHeight * 0.4 + viewPos.y
	}

	lootsWidget:dropLoot(context:getScalableScheduler(), self, dropPoint, item)
end

function BattleGroundLayer:createDefaultModel()
	local pre = "asset/anim/"

	return pre .. "YFZZhu.skel"
end

function BattleGroundLayer:showProfessionalRestraint(genre, infos)
	local unitManager = self._viewContext:getValue("BattleUnitManager")
	local showList = {}

	if infos then
		for k, v in pairs(infos) do
			local cellId = v.id

			showList[cellId] = true
		end
	end

	local members = unitManager:getMembers()

	for k, unit in pairs(members) do
		local dataModel = unit:getDataModel()
		local cellId = dataModel:getCellId()

		if showList[cellId] and cellId < 0 then
			unit:showProfessionalRestraint(genre)
		else
			unit:resumeProfessionalRestraint()
		end
	end
end

function BattleGroundLayer:resumeProfessionalRestraint()
	local unitManager = self._viewContext:getValue("BattleUnitManager")
	local members = unitManager:getMembers()

	for k, v in pairs(members) do
		v:resumeProfessionalRestraint()
	end
end
