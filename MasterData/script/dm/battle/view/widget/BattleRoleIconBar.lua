-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleRoleIconBar.lua

BattleRoleIconBar = class("BattleRoleIconBar", BaseWidget)

BattleRoleIconBar:has("_viewContext", {
	is = "r"
})

function BattleRoleIconBar:initialize(view, mode, viewContext)
	super.initialize(self, view)

	self._viewContext = viewContext
end

function BattleRoleIconBar:dispose()
	if self._showTask then
		self._showTask:stop()

		self._showTask = nil
	end

	if self._buffIconEntry then
		self._buffIconEntry:stop()

		self._buffIconEntry = nil
	end

	super.dispose(self)
end

function BattleRoleIconBar:bindActor(actor)
	self._actor = actor

	self:_setup()
end

function BattleRoleIconBar:_setup()
	self._buffList = {}
	self._buffIconList = {}
	self._buffDurList = {}

	local iconPanel = cc.Node:create()

	iconPanel:posite(-83, 14)

	self._ipl = 4
	self._width = 35
	self._height = 35
	self._showBuffTime = 1

	local roleType = self._actor:getDataModel():getRoleType()

	if roleType == RoleType.Master then
		iconPanel:offset(26, 0)
	else
		self._ipl = 3

		iconPanel:offset(26, -10)
	end

	self._view:addChild(iconPanel)

	self._iconPanel = iconPanel
end

function BattleRoleIconBar:addBuffIcon(buffid, iconRes, duration)
	local index = self:findBuff(buffid)

	if index then
		return
	end

	local index = #self._buffList + 1

	self._buffList[index] = buffid
	self._buffDurList[index] = duration

	local icon = cc.Sprite:createWithSpriteFrameName(iconRes .. ".png")

	self._buffIconList[index] = icon

	self:setIconPos(icon, index)
	icon:addTo(self._iconPanel):setScale(0.5)

	local label = ccui.Text:create(tostring(duration), CUSTOM_TTF_FONT_1, 36)

	label:setName("durLabel")
	label:setAnchorPoint(cc.p(1, 0))
	label:addTo(icon):posite(60, -10)
	label:enableOutline(cc.c4b(0, 0, 0, 255), 4)

	if duration >= 99 then
		label:setVisible(false)
	else
		label:setVisible(true)
	end

	self:scheduleShowBuff(self._showBuffTime)
end

function BattleRoleIconBar:setIconPos(icon, index)
	icon:setPosition(((index - 1) % self._ipl + 0.5) * self._width, (math.floor((index - 1) / self._ipl) + 0.5) * self._height)
end

function BattleRoleIconBar:tickBuff(buffid, duration)
	local index = self:findBuff(buffid)

	if not index then
		return
	end

	local icon = self._buffIconList[index]
	local label = icon:getChildByName("durLabel")

	if label then
		label:setString(tostring(duration))

		if duration >= 99 then
			label:setVisible(false)
		else
			label:setVisible(true)
		end
	end
end

function BattleRoleIconBar:stackBuff(buffid, duration, stackCount)
	local index = self:findBuff(buffid)

	if not index then
		return
	end

	self._buffDurList[index] = duration

	local icon = self._buffIconList[index]
	local label = icon:getChildByName("durLabel")

	if label then
		label:setString(tostring(duration))

		if duration >= 99 then
			label:setVisible(false)
		else
			label:setVisible(true)
		end
	end

	self:scheduleShowBuff(showBuffTime)
end

function BattleRoleIconBar:findBuff(buffid)
	for index, bid in ipairs(self._buffList) do
		if bid == buffid then
			return index
		end
	end
end

function BattleRoleIconBar:removeIcon(buffid)
	local index = self:findBuff(buffid)

	if not index then
		return
	end

	local icon = self._buffIconList[index]

	icon:removeFromParent(true)
	table.remove(self._buffList, index)
	table.remove(self._buffIconList, index)
	table.remove(self._buffDurList, index)

	for i = index, #self._buffIconList do
		local icon = self._buffIconList[i]

		self:setIconPos(icon, i)
	end
end

function BattleRoleIconBar:scheduleShowBuff(duration)
	if self._buffIconEntry then
		self._buffIconEntry:stop()

		self._buffIconEntry = nil
	elseif self._view:isVisible() then
		return
	end

	self._actor:updateHpBarVisibility(true)

	local scheduler = self._viewContext:getScalableScheduler()

	self._buffIconEntry = scheduler:schedule(function(task, dt)
		self._actor:updateHpBarVisibility(false)
		task:stop()

		self._buffIconEntry = nil
	end, duration, false)
end

function BattleRoleIconBar:stopShowTask(...)
	if self._buffIconEntry then
		self._buffIconEntry:stop()

		self._buffIconEntry = nil
	end
end
