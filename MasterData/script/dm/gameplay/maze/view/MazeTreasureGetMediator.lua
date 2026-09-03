-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeTreasureGetMediator.lua

MazeTreasureGetMediator = class("MazeTreasureGetMediator", DmPopupViewMediator, _M)

MazeTreasureGetMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {}

function MazeTreasureGetMediator:initialize()
	super.initialize(self)
end

function MazeTreasureGetMediator:dispose()
	super.dispose(self)
end

function MazeTreasureGetMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MazeTreasureGetMediator:dispose()
	super.dispose(self)
end

function MazeTreasureGetMediator:enterWithData(data)
	self._data = data.da
	self._info = data.info
	self._treasureData = {}

	for k, v in pairs(self._data) do
		self._treasureData.level = v.level
		self._treasureData.configId = v.configId
		self._treasureData.id = v.id
	end

	self._treasureData.name = self._info._name
	self._treasureData.desc = self._info._desc
	self._treasureData.icon = self._info._icon

	self:initData()
	self:initViews()
end

function MazeTreasureGetMediator:initData()
	return
end

function MazeTreasureGetMediator:initViews()
	self._main = self:getView()
	self._icon = self._main:getChildByFullName("icon")
	self._name = self._main:getChildByFullName("name")
	self._desc = self._main:getChildByFullName("desc")

	self._name:setString(self._treasureData.name)
	self._desc:setString(self._treasureData.desc)

	if string.find(self._treasureData.desc, "+") then
		local descs = string.split(self._treasureData.desc, "+")
		local text = ccui.Text:create("+" .. descs[2], TTF_FONT_FZY3JW, 16)

		text:setColor(cc.c3b(170, 240, 20))
		text:setAnchorPoint(cc.p(0, 0))
		text:enableOutline(cc.c4b(35, 15, 5, 76.5), 2)
		self._desc:setString(descs[1])

		local startPos = cc.p(self._desc:getAutoRenderSize())
		local areasize = self._desc:getTextAreaSize()

		self._desc:setContentSize(self._desc:getStringLength() * 18, math.ceil(self._desc:getStringLength() / 13) * 22)
		text:setTag(666)
		text:setPosition(self._desc:getStringLength() * 17, 0)
		self._desc:addChild(text)
	else
		self._desc:setString(self._treasureData.desc)
	end

	self._icon:loadTexture(self._treasureData.icon)
end

function MazeTreasureGetMediator:onTouchPanel(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
