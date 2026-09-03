-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityMailMediator.lua

ActivityMailMediator = class("ActivityMailMediator", DmPopupViewMediator, _M)

ActivityMailMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.contentLayer.receiveBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickReceive"
	},
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickClose"
	}
}

function ActivityMailMediator:initialize()
	super.initialize(self)
end

function ActivityMailMediator:dispose()
	super.dispose(self)
end

function ActivityMailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function ActivityMailMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
end

function ActivityMailMediator:enterWithData(data)
	self._activity = self._activitySystem:getActivityById("RiddlePreMail")

	if not self._activity then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return
	end

	self._index = 1
	self._redPoint = {}

	self:setupView()
	self:initData()
	self:initView()
end

function ActivityMailMediator:doReset()
	self._activity = self._activitySystem:getActivityById("RiddlePreMail")

	if not self._activity then
		self:onClickClose()

		return
	end

	self:initData()
	self:initView()
end

function ActivityMailMediator:setupView()
	self._main = self:getView():getChildByName("main")
	self._cellClone = self._main:getChildByName("cellClone")

	self._cellClone:setVisible(false)

	self._listView = self._main:getChildByName("ListView_Left")

	self._listView:setScrollBarEnabled(false)
	self._listView:setSwallowTouches(false)

	self._contentLayer = self._main:getChildByName("contentLayer")
end

function ActivityMailMediator:initData()
	self._data = self._activity:getMailList()
end

function ActivityMailMediator:initView()
	self._listView:removeAllChildren(true)

	if #self._data < 0 then
		self._contentLayer:setVisible(false)

		return
	end

	self:createTxt(self._contentLayer:getChildByName("txt2"), Strings:get("RiddleMailConten4"), 600, true)

	for index, data in ipairs(self._data) do
		local panel = self._cellClone:clone()

		panel:setVisible(true)
		panel:setTag(index)
		panel:setName("listPanel_" .. index)
		self._listView:pushBackCustomItem(panel)

		local function callFunc(sender, eventType)
			local beganPos = sender:getTouchBeganPosition()
			local endPos = sender:getTouchEndPosition()

			if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
				self:onClicMail(sender, self._data[sender:getTag()])
			end
		end

		mapButtonHandlerClick(nil, panel, {
			func = callFunc
		})
	end

	self:onClicMail(self._listView:getChildByName("listPanel_" .. self._index), self._data[self._index])
end

function ActivityMailMediator:updataCell(panel, data)
	panel:getChildByName("title"):setString(Strings:get(data.titleDes))
	panel:getChildByName("times"):setString(TimeUtil:localDate("%Y.%m.%d", data.startTime))
	panel:getChildByName("bg"):loadTexture(self._index == panel:getTag() and "Riddle_tab_mail_1.png" or "Riddle_tab_mail_2.png", ccui.TextureResType.plistType)
	panel:getChildByName("img"):loadTexture(data.status == 2 and "Riddle_img_mail_xf2.png" or "Riddle_img_mail_xf3.png", ccui.TextureResType.plistType)
	self:refreshActivityCalendarRedPoint(panel, data)
end

function ActivityMailMediator:onClicMail(panel, data)
	self._index = panel:getTag()

	self._activity:setMailStatus(data.id)

	data.status = self._activity:getMailStatus(data.id)

	for index, value in ipairs(self._data) do
		self:updataCell(self._listView:getChildByName("listPanel_" .. index), value)
	end

	self:setContent(panel, data)
end

function ActivityMailMediator:setContent(panel, data)
	self._contentLayer:setVisible(true)

	local title = self._contentLayer:getChildByName("title")

	title:setString(Strings:get(data.titleDes))

	local times = self._contentLayer:getChildByName("times")

	times:setString(Strings:get("EXPIRE_AFTER_READ") .. TimeUtil:localDate("%Y.%m.%d  %H:%M:%S", data.endTime))
	self:createTxt(self._contentLayer:getChildByName("txt"), Strings:get(data.contentDes), 600)
	self:createTxt(self._contentLayer:getChildByName("name"), Strings:get(data.addresser), 600, true)
	self:createTxt(self._contentLayer:getChildByName("txt1"), Strings:get(data.RiddleDes), 600)
end

function ActivityMailMediator:createTxt(node, str, width, noRebuild)
	local name = node:getName() .. "richText"

	if not self[name] then
		self[name] = ccui.RichText:createWithXML("", {})

		self[name]:addTo(node:getParent()):setName(name)
		self[name]:setAnchorPoint(node:getAnchorPoint())
		self[name]:setPosition(cc.p(node:getPosition()))
	end

	self[name]:setString(str)

	if not noRebuild then
		self[name]:renderContent(width, 0, true)
		self[name]:rebuildElements()
	end
end

function ActivityMailMediator:onClickReceive(sender)
	local view = self:getInjector():getInstance("SettingCodeExchangeView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}))
end

function ActivityMailMediator:onClickClose(sender, eventType, oppoRecord)
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)

	developSystem:dispatch(Event:new(EVT_ACTIVITY_MAIL_NEW))
	self:close()
end

function ActivityMailMediator:refreshActivityCalendarRedPoint(panel, data)
	if not self._redPoint[panel:getName()] then
		local redPoint = RedPoint:createDefaultNode()

		redPoint:setName("redPoint")
		redPoint:setScale(0.8)
		redPoint:addTo(panel):posite(300, 90)
		redPoint:setLocalZOrder(99900)

		self._redPoint[panel:getName()] = redPoint
	end

	self._redPoint[panel:getName()]:setVisible(self._activity:getMailStatus(data.id) ~= 2)
end
