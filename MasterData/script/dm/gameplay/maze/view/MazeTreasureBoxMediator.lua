-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeTreasureBoxMediator.lua

MazeTreasureBoxMediator = class("MazeTreasureBoxMediator", DmPopupViewMediator, _M)

MazeTreasureBoxMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	exitbtn = "onClickExit"
}

function MazeTreasureBoxMediator:initialize()
	super.initialize(self)
end

function MazeTreasureBoxMediator:dispose()
	super.dispose(self)
end

function MazeTreasureBoxMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MazeTreasureBoxMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_TREASURE_BOX_UPDATE_SUC, self, self.refeshViews)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_TREASURE_BOX_OPTION_SUC, self, self.updateSelectBox)
end

function MazeTreasureBoxMediator:dispose()
	super.dispose(self)
end

function MazeTreasureBoxMediator:enterWithData(data)
	self._model = data._model
	self._index = data._index
	self._treasureList = self._model:isCanRefesh() and self._model:getFirstTreasure() or self._model:getItemList()
	self._selectTreasureId = ""

	self:initData()
	self:updateViews()

	self._curCell = nil
end

function MazeTreasureBoxMediator:initData()
	return
end

function MazeTreasureBoxMediator:updateViews()
	local cell = self:getView():getChildByFullName("cellclone")

	self._initPos = cc.p(self:getView():getChildByFullName("heropospanel.heropos"):getPosition())

	local num = 0

	for k, v in pairs(self._treasureList) do
		num = num + 1
	end

	if num == 2 then
		self._initPos = cc.p(self:getView():getChildByFullName("heropospanel.heropos_2"):getPosition())
	elseif num == 1 then
		self._initPos = cc.p(self:getView():getChildByFullName("heropospanel.heropos_1"):getPosition())
	end

	local count = 0

	for k, v in pairs(self._treasureList) do
		local cellview = cell:clone()

		cellview:getChildByFullName("select"):setVisible(not self._model:isRefeshType())
		cellview:getChildByFullName("selects"):setVisible(self._model:isRefeshType())
		cellview:getChildByFullName("refeshs"):setVisible(self._model:isCanRefesh())

		local name = self._model:getNameByBoxId(v.id)

		cellview:getChildByFullName("name"):setString(name)

		local icon = self._model:getIconPathByBoxId(v.id)

		cellview:getChildByFullName("icon"):loadTexture(icon)

		local desc = self._model:getDescByBoxId(v.id, v.value)
		local descNode = cellview:getChildByFullName("desc")
		local oldtext = descNode:getChildByTag(666)

		descNode:setContentSize(212, 36)

		if oldtext then
			oldtext:removeFromParent(false)
		end

		if string.find(desc, "+") then
			local descs = string.split(desc, "+")
			local text = ccui.Text:create("+" .. descs[2], TTF_FONT_FZY3JW, 16)

			text:setColor(cc.c3b(170, 240, 20))
			text:setAnchorPoint(cc.p(0, 0))
			text:enableOutline(cc.c4b(35, 15, 5, 76.5), 2)
			descNode:setString(descs[1])

			local startPos = cc.p(descNode:getAutoRenderSize())
			local areasize = descNode:getTextAreaSize()

			descNode:setContentSize(descNode:getStringLength() * 18, math.ceil(descNode:getStringLength() / 13) * 19)
			text:setTag(666)
			text:setPosition(descNode:getStringLength() * 17, 0)
			descNode:addChild(text)
		else
			descNode:setString(self._model:getDescByBoxId(v.id, v.value))
		end

		cellview:setPosition(self._initPos.x + count * (cellview:getContentSize().width + 20), self._initPos.y)

		if self._model:isRefeshType() and not self._model:isCanRefesh() then
			cellview:getChildByFullName("selects"):setPosition(cc.p(cellview:getChildByFullName("select"):getPosition()))
		end

		count = count + 1

		cellview:getChildByFullName("select"):addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickSelectTreasure(k, {
					_desc = desc,
					_name = name,
					_icon = icon
				})
			end
		end)

		local butbtn = cellview:getChildByFullName("selects")

		butbtn:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickUpdateSelectTreasure(k, {
					_desc = desc,
					_name = name,
					_icon = icon
				})
			end
		end)

		local refeshbtn = cellview:getChildByFullName("refeshs")

		refeshbtn:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickrefeshTreasure(k)
			end
		end)

		if self._model:isRefeshType() then
			self:getView():getChildByFullName("heropanel"):removeAllChildren()
		end

		self:getView():getChildByFullName("heropanel"):addChild(cellview)
	end
end

function MazeTreasureBoxMediator:updateSelectBox(response)
	local view = self:getInjector():getInstance("MazeTreasureGetView")
	local points = response._data.d.player.pansLab.points

	for k, v in pairs(points) do
		if v.treasures then
			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				da = v.treasures,
				info = self._curInfo
			}))
			self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
		end
	end

	self:close()
end

function MazeTreasureBoxMediator:refeshViews(response)
	self._treasureList = self._model:getFirstTreasure()

	self._model:setCanRefesh(false)
	self:updateViews()
end

function MazeTreasureBoxMediator:onClickSelectTreasure(buyid, info)
	local data = {
		buyId = buyid
	}
	local cjson = require("cjson.safe")
	local paramsData = cjson.encode(data)

	self._selectTreasureId = buyid
	self._curInfo = info

	self._mazeSystem:setOptionEventName(EVT_MAZE_TREASURE_BOX_OPTION_SUC)
	self._mazeSystem:requestMazestStartOption(self._index, paramsData)
end

function MazeTreasureBoxMediator:onClickUpdateSelectTreasure(getid, info)
	local data = {
		type = "buy"
	}
	local cjson = require("cjson.safe")
	local paramsData = cjson.encode(data)

	self._selectTreasureId = buyid
	self._curInfo = info

	self._mazeSystem:setOptionEventName(EVT_MAZE_TREASURE_BOX_OPTION_SUC)
	self._mazeSystem:requestMazestStartOption(self._index, paramsData)
end

function MazeTreasureBoxMediator:onClickrefeshTreasure(refeshid)
	local data = {
		type = "refresh"
	}
	local cjson = require("cjson.safe")
	local paramsData = cjson.encode(data)

	self._selectTreasureId = buyid

	self._mazeSystem:setOptionEventName(EVT_MAZE_TREASURE_BOX_UPDATE_SUC)
	self._mazeSystem:requestMazestStartOption(self._index, paramsData)
end

function MazeTreasureBoxMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:close()
	end
end
