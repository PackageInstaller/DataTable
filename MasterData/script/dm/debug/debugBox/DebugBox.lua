-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/DebugBox.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "DebugBoxTool")
require(__PACKAGE__ .. "DebugBoxMainIndex")
require(__PACKAGE__ .. "DebugViewParser")
require(__PACKAGE__ .. "view.DebugViewTemplate")
require(__PACKAGE__ .. "MemoryProfiler")

DebugBox = class("DebugBox", objectlua.Object, _M)

DebugBox:has("_mainIndex", {
	is = "r"
})
DebugBox:has("_subIndex", {
	is = "r"
})
DebugBox:has("_curIndex", {
	is = "rw"
})
DebugBox:has("_curSubIndex", {
	is = "rw"
})
DebugBox:has("_injector", {
	is = "rw"
})
DebugBox:has("_eventDispatcher", {
	is = "rw"
})

function DebugBox:initialize()
	self._viewParser = DebugViewParser:new()

	self:initIndexData()
end

function table.capacity(t)
	local cnt = 0
	local a

	while true do
		a = next(t, a)

		if a == nil then
			break
		end

		cnt = cnt + 1
	end

	return cnt
end

function DebugBox:initInjectorAndMapClass(injector)
	self._injector = injector

	require("dm.debug.debugBox.service.DataModificationDS")
	self._injector:mapClass(DataModificationDS, DataModificationDS)
end

function DebugBox:initEventDispatcher(eventDispatcher)
	self._eventDispatcher = eventDispatcher
end

function DebugBox:initIndexData()
	self._mainIndex = DebugBoxMainIndex:getMainIndex()
	self._subIndex = DebugBoxMainIndex:getSubIndex()

	if self._mainIndex == nil or table.capacity(self._mainIndex) == 0 then
		local name = {}

		for k, v in pairs(self._subIndex) do
			name[k] = v[1]
		end

		self._mainIndex = {
			{
				"其他",
				name
			}
		}
	end

	self:setCurIndex(1)
	self:setCurSubIndex(1)
end

function DebugBox:setupView(parentLayer)
	if parentLayer == nil then
		return
	end

	self._parentLayer = parentLayer

	local resDir = "debug/"
	local debugBtn = ccui.Button:create(resDir .. "btn_tishi_normal_zjm.png", resDir .. "btn_tishi_press_zjm.png", "")

	parentLayer:addChild(debugBtn)

	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local str = "网络延时：" .. tostring(gameServerAgent:getNetDelay()) .. " ms"

	self._timeLabel = cc.Label:createWithTTF(str, TTF_FONT_FZYH_R, 20)

	self._timeLabel:setTextColor(cc.c3b(255, 255, 0))
	self._timeLabel:posite(31.5, 65)
	debugBtn:addChild(self._timeLabel)
	self:addShowLocalTime()

	if self._timer == nil then
		self._timer = LuaScheduler:getInstance():schedule(handler(self, self.refreshNetDelay), 0.2, false)
	end

	local parentSize = parentLayer:getContentSize()

	debugBtn:setPosition(parentSize.width * 0.8, parentSize.height * 0.8)

	local move = false

	debugBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			move = false
			self._oldbtnPosX = sender:getPositionX()
			self._oldbtnPosY = sender:getPositionY()
		elseif eventType == ccui.TouchEventType.moved then
			local curPos = parentLayer:convertToNodeSpace(sender:getTouchMovePosition())

			debugBtn:setPosition(curPos)

			if math.abs(self._oldbtnPosX - curPos.x) > 15 or math.abs(self._oldbtnPosY - curPos.y) > 15 then
				move = true
			end
		elseif eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			if move == true then
				return
			end

			local endPos = parentLayer:convertToNodeSpace(sender:getTouchEndPosition())
			local boundBox = debugBtn:getBoundingBox()

			if cc.rectContainsPoint(boundBox, endPos) then
				self:show()
			end

			move = false
		end
	end)

	self.kScollerWidth = 400

	local rootNode = ccui.Layout:create()

	rootNode:retain()
	rootNode:setContentSize(cc.size(960, 640))
	rootNode:setBackGroundImageScale9Enabled(true)
	rootNode:setBackGroundImage(DebugBoxTool:getResPath("pic_dm_debug_mainbg.png"))
	rootNode:setBackGroundImageCapInsets(cc.rect(50, 50, 36, 43))
	rootNode:setTouchEnabled(true)

	local clipNode = ccui.Layout:create()
	local clipX = 15
	local clipY = 0

	clipNode:setContentSize(cc.size(rootNode:getContentSize().width - clipX * 2, rootNode:getContentSize().height - clipY * 2))
	clipNode:setPosition(clipX, clipY)
	rootNode:addChild(clipNode)
	clipNode:setClippingEnabled(true)

	local moveLeftPanel = ccui.Layout:create()

	moveLeftPanel:setName("moveLeftPanel")
	clipNode:addChild(moveLeftPanel)

	self.moveLeftPanel = moveLeftPanel

	local scollViewRect = ccui.Layout:create()

	scollViewRect:setName("scollViewRect")
	scollViewRect:setContentSize(cc.size(self.kScollerWidth, 500))
	scollViewRect:setPosition(50, rootNode:getContentSize().height * 0.5 - scollViewRect:getContentSize().height * 0.5)
	moveLeftPanel:addChild(scollViewRect, 1)
	scollViewRect:setBackGroundImageScale9Enabled(true)
	scollViewRect:setBackGroundImage(DebugBoxTool:getResPath("pic_dm_debug_tab_frame.png"))
	scollViewRect:setBackGroundImageCapInsets(cc.rect(20, 40, 18, 18))
	self:setupScrollerView(moveLeftPanel, scollViewRect)

	local scollViewRect2 = ccui.Layout:create()

	scollViewRect2:setContentSize(cc.size(self.kScollerWidth, 500))
	scollViewRect2:setPosition(rootNode:getContentSize().width * 0.5 + 30, rootNode:getContentSize().height * 0.5 - scollViewRect2:getContentSize().height * 0.5)
	moveLeftPanel:addChild(scollViewRect2, 1)
	scollViewRect2:setBackGroundImageScale9Enabled(true)
	scollViewRect2:setBackGroundImage(DebugBoxTool:getResPath("pic_dm_debug_tab_frame.png"))
	scollViewRect2:setBackGroundImageCapInsets(cc.rect(20, 40, 18, 18))
	self:setupRightScrollerView(moveLeftPanel, scollViewRect2)

	local sideBackBtn = ccui.Button:create(DebugBoxTool:getResPath("pic_dm_debug_tback_normal.png"), DebugBoxTool:getResPath("pic_dm_debug_tback_press.png"), "")

	rootNode:addChild(sideBackBtn)
	sideBackBtn:setPosition(40, rootNode:getContentSize().height * 0.5)
	sideBackBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			if moveLeftPanel:getPositionX() == 0 then
				return
			end

			if self.moveLeftPanel:getNumberOfRunningActions() > 0 then
				return
			end

			local moveto = cc.MoveTo:create(0.2, cc.p(0, 0))
			local callFunc2 = cc.CallFunc:create(function()
				return
			end)
			local seq = cc.Sequence:create(moveto, callFunc2)

			self.moveLeftPanel:stopAllActions()
			self.moveLeftPanel:runAction(seq)

			if self.moveLeftPanel:getChildByTag(775698) then
				self.moveLeftPanel:removeChildByTag(775698)
			end

			self._isShowSubView = false
		end
	end)

	local hideBtn = ccui.Button:create(DebugBoxTool:getResPath("pic_dm_debug_tback_normal.png"), DebugBoxTool:getResPath("pic_dm_debug_tback_press.png"), "")

	rootNode:addChild(hideBtn)
	hideBtn:setPosition(rootNode:getContentSize().width * 0.5, rootNode:getContentSize().height - 20)
	hideBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:hide()
		end
	end)

	self._dipalyNode = rootNode
end

function DebugBox:hide()
	if self:getDisplayNode():getParent() ~= nil then
		self:getDisplayNode():removeFromParent()
	end

	self:getDisplayNode():setVisible(false)
end

function DebugBox:show()
	if self._parentLayer ~= nil then
		print("DebugBox:show")

		if GameConfigs and GameConfigs.androidBack then
			local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")

			scene:popTopView()
		else
			self._parentLayer:addChild(self:getDisplayNode())
			self:getDisplayNode():setVisible(true)
		end
	end
end

function DebugBox:getDisplayNode()
	return self._dipalyNode
end

function DebugBox:getMainIndexCount()
	return #self._mainIndex
end

function DebugBox:getMainIndexDataByIndex(idx)
	return self._mainIndex[idx][1]
end

function DebugBox:getCurIndexSubDataCount()
	return #self._mainIndex[self._curIndex][2]
end

function DebugBox:getCurIndexSubDataByIndex(idx)
	return self._mainIndex[self._curIndex][2][idx]
end

function DebugBox:onClickMainTableCellAtIndex(idx)
	self:setCurIndex(idx)
	self:setCurSubIndex(1)

	if self._subIndexView then
		self._subIndexView:reloadData()
	end

	if self._mainIndexView then
		local offset = self._mainIndexView:getContentOffset()

		self._mainIndexView:reloadData()
		self._mainIndexView:setContentOffset(offset)
	end
end

function DebugBox:getSubIndexDataByKey(subIndexKey)
	for k, v in pairs(self._subIndex) do
		if v[1] == subIndexKey then
			return v
		end
	end

	return nil
end

function DebugBox:showCustomView(subIndexKey)
	local subIndexData = self:getSubIndexDataByKey(subIndexKey)
	local viewName = subIndexData and subIndexData[2]
	local viewClazz = _G[viewName]

	if viewClazz then
		local newViewObj = viewClazz:new()
		local viewNode = self._viewParser:tryCreateView(viewName, newViewObj)

		newViewObj:setInjector(self._injector)
		newViewObj:setEventDispatcher(self._eventDispatcher)

		if self.moveLeftPanel and viewNode and self.moveLeftPanel:getNumberOfRunningActions() == 0 then
			local newViewOffX = newViewObj.getViewWidth and newViewObj.getViewWidth() - 320 or 0
			local moveto = cc.MoveTo:create(0.2, cc.p(-self._dipalyNode:getContentSize().width * 0.5 + 30 - newViewOffX, 0))
			local callFunc2 = cc.CallFunc:create(function()
				return
			end)
			local seq = cc.Sequence:create(moveto, callFunc2)

			self.moveLeftPanel:runAction(seq)

			if self.moveLeftPanel:getChildByTag(775698) then
				self.moveLeftPanel:removeChildByTag(775698)
			end

			self.moveLeftPanel:addChild(viewNode, 1, 775698)
			viewNode:setPositionX(950)

			self._isShowSubView = true
		end
	else
		dump(subIndexData, "view class")
	end
end

function DebugBox:onClickSubIndexTableCellAtIndex(idx)
	local data = self:getCurIndexSubDataByIndex(idx)

	if self:getCurSubIndex() == idx or self._isShowSubView then
		self:showCustomView(data)
	end

	self:setCurSubIndex(idx)

	if self._subIndexView then
		local offset = self._subIndexView:getContentOffset()

		self._subIndexView:reloadData()
		self._subIndexView:setContentOffset(offset)
	end
end

function DebugBox:setupScrollerView(rootNode, scollViewRect)
	local delegate = {}
	local parent = self

	function delegate:createCellTemplate()
		local scollerCell = ccui.Layout:create()
		local cellHeight = 40

		scollerCell:setContentSize(cc.size(parent.kScollerWidth, cellHeight))

		local label = ccui.Text:create("--", TTF_FONT_FZYH_M, 30)

		label:setName("label")
		DebugBoxTool:centerAddNode(scollerCell, label, 20, 1)
		label:setPositionX(80)
		label:setAnchorPoint(cc.p(0, 0.5))

		local lineBg = ccui.Layout:create()

		lineBg:setContentSize(cc.size(parent.kScollerWidth, 2))
		lineBg:setPosition(0, 0)
		scollerCell:addChild(lineBg, 99)
		lineBg:setBackGroundImageScale9Enabled(true)
		lineBg:setBackGroundImage(DebugBoxTool:getResPath("pic_dm_debug_line.png"))
		lineBg:setBackGroundImageCapInsets(cc.rect(20, 0, 5, 1))

		local bgNormal = ccui.ImageView:create(DebugBoxTool:getResPath("pic_dm_debug_tab_normal.png"))

		bgNormal:setVisible(true)
		bgNormal:setName("bgNormal")
		bgNormal:setScale9Enabled(true)
		bgNormal:setContentSize(cc.size(parent.kScollerWidth, cellHeight))
		bgNormal:setCapInsets(cc.rect(30, 20, 14, 10))
		bgNormal:setAnchorPoint(cc.p(0, 0))
		scollerCell:addChild(bgNormal, 0)

		local bgPress = ccui.ImageView:create(DebugBoxTool:getResPath("pic_dm_debug_tab_press.png"))

		bgPress:setVisible(false)
		bgPress:setName("bgPress")
		bgPress:setScale9Enabled(true)
		bgPress:setCapInsets(cc.rect(30, 20, 14, 10))
		bgPress:setContentSize(cc.size(parent.kScollerWidth, cellHeight))
		bgPress:setAnchorPoint(cc.p(0, 0))
		scollerCell:addChild(bgPress, 0)

		return scollerCell
	end

	function delegate:tableCellTouched(table, cell)
		parent:onClickMainTableCellAtIndex(cell:getIdx() + 1)
	end

	function delegate:cellNum()
		return parent:getMainIndexCount()
	end

	function delegate:createCell(cell, idx)
		cell:setTouchEnabled(false)

		local data = parent:getMainIndexDataByIndex(idx)

		if data ~= nil then
			local label = cell:getChildByName("label")

			if label then
				label:setString(data)
			end

			local bgNormal = cell:getChildByName("bgNormal")
			local bgPress = cell:getChildByName("bgPress")

			bgNormal:setVisible(false)
			bgPress:setVisible(false)

			if parent:getCurIndex() == idx then
				bgPress:setVisible(true)
			else
				bgNormal:setVisible(false)
			end
		end
	end

	self._mainIndexView = DebugBoxTool:createTableView(rootNode, scollViewRect, delegate)
end

function DebugBox:setupRightScrollerView(rootNode, scollViewRect)
	local delegate = {}
	local parent = self

	function delegate:createCellTemplate()
		local scollerCell = ccui.Layout:create()
		local cellHeight = 40

		scollerCell:setContentSize(cc.size(parent.kScollerWidth, cellHeight))

		local label = ccui.Text:create("--", TTF_FONT_FZYH_M, 30)

		label:setName("label")
		DebugBoxTool:centerAddNode(scollerCell, label, 20, 1)
		label:setPositionX(80)
		label:setAnchorPoint(cc.p(0, 0.5))

		local lineBg = ccui.Layout:create()

		lineBg:setContentSize(cc.size(parent.kScollerWidth, 2))
		lineBg:setPosition(0, 0)
		scollerCell:addChild(lineBg, 1)
		lineBg:setBackGroundImageScale9Enabled(true)
		lineBg:setBackGroundImage(DebugBoxTool:getResPath("pic_dm_debug_line.png"))
		lineBg:setBackGroundImageCapInsets(cc.rect(20, 0, 5, 1))

		local bgNormal = ccui.ImageView:create(DebugBoxTool:getResPath("pic_dm_debug_tab_normal.png"))

		bgNormal:setVisible(true)
		bgNormal:setName("bgNormal")
		bgNormal:setScale9Enabled(true)
		bgNormal:setContentSize(cc.size(parent.kScollerWidth, cellHeight))
		bgNormal:setCapInsets(cc.rect(30, 20, 14, 10))
		bgNormal:setAnchorPoint(cc.p(0, 0))
		scollerCell:addChild(bgNormal, 0)

		local bgPress = ccui.ImageView:create(DebugBoxTool:getResPath("pic_dm_debug_tab_press.png"))

		bgPress:setVisible(false)
		bgPress:setName("bgPress")
		bgPress:setScale9Enabled(true)
		bgPress:setCapInsets(cc.rect(30, 20, 14, 10))
		bgPress:setContentSize(cc.size(parent.kScollerWidth, cellHeight))
		bgPress:setAnchorPoint(cc.p(0, 0))
		scollerCell:addChild(bgPress, 0)

		return scollerCell
	end

	function delegate:tableCellTouched(table, cell)
		parent:onClickSubIndexTableCellAtIndex(cell:getIdx() + 1)
	end

	function delegate:cellNum()
		return parent:getCurIndexSubDataCount()
	end

	function delegate:createCell(cell, idx)
		cell:setTouchEnabled(false)

		local data = parent:getCurIndexSubDataByIndex(idx)

		if data ~= nil then
			local label = cell:getChildByName("label")

			if label then
				label:setString(data)
			end

			local bgNormal = cell:getChildByName("bgNormal")
			local bgPress = cell:getChildByName("bgPress")

			bgNormal:setVisible(false)
			bgPress:setVisible(false)

			if parent:getCurSubIndex() == idx then
				bgPress:setVisible(true)
			else
				bgNormal:setVisible(false)
			end
		end
	end

	self._subIndexView = DebugBoxTool:createTableView(rootNode, scollViewRect, delegate)
end

function DebugBox:refreshNetDelay()
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")

	if DisposableObject:isDisposed(gameServerAgent) then
		return
	end

	local str = "网络延时：" .. tostring(gameServerAgent:getNetDelay()) .. " ms"

	if self._timeLabel then
		self._timeLabel:setString(str)
	else
		self:clearTime()
	end
end

function DebugBox:clearTime()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._timeLabel then
		self._timeLabel = nil
	end
end

function DebugBox:addShowLocalTime()
	if self._timeLabel and not DisposableObject:isDisposed(self._timeLabel) then
		local label = ccui.Text:create("", TTF_FONT_FZYH_R, 20)

		label:addTo(self._timeLabel):posite(70, -20)
		label:setColor(cc.c3b(255, 0, 0))

		local gameServerAgent = DmGame:getInstance()._injector:getInstance(GameServerAgent)

		local function checkTimeFunc()
			local remoteTimestamp = gameServerAgent:remoteTimestamp()
			local date = TimeUtil:localDate("%Y.%m.%d  %H:%M:%S", remoteTimestamp)

			label:setString(date)
		end

		self._localShowTimer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	end
end
