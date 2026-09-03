-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleChangeWidget.lua

BattleChangeWidget = class("BattleChangeWidget", BaseWidget)

function BattleChangeWidget:initialize(view)
	super.initialize(self, view)
	self:setupView()
end

function BattleChangeWidget:dispose()
	super.dispose(self)
end

function BattleChangeWidget:setupView()
	local view = self:getView()

	self._text1 = view:getChildByFullName("text1")
	self._text2 = view:getChildByFullName("text2")
	self._text = view:getChildByFullName("text")

	view:setVisible(false)

	self._numAll = 0
	self._numIndex = 1
end

function BattleChangeWidget:addChangeNum(addNum)
	if self._numAll < 1 then
		return
	end

	self._numIndex = self._numIndex + addNum

	if self._numIndex > self._numAll then
		self._numIndex = self._numAll
	end

	self._view:setVisible(true)
	self._text:setString(tostring(self._numIndex) .. "/" .. tostring(self._numAll))
end

function BattleChangeWidget:init(num)
	self._numAll = num

	self:addChangeNum(0)
end
