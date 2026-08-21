-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/RoguelikeTestMenuView.lua

module("logic.extensions.hacktool.view.RoguelikeTestMenuView", package.seeall)

local PATTERN = RoguelikeConst.DICE_PATTERN
local HeroInfoItem = class("HeroInfoItem")

function HeroInfoItem:ctor(go)
	self._go = go

	local tra = go.transform

	self._txtName = tra:Find("name"):GetComponent("Text")
	self._btnDelete = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnDelete"))

	self._btnDelete:AddClickListener(self.onClickBtnDelete, self)

	self._dropProp = tra:Find("Dropdown"):GetComponent(UIComponentType.DropdownApapter)

	goutil.setActive(go, true)
end

function HeroInfoItem:setData(data)
	self._txtName.text = data.name
	self._data = data
end

function HeroInfoItem:getHeroId()
	return self._data.id
end

function HeroInfoItem:getDropProp()
	return tonumber(self._dropProp.dropdown.value) + 1
end

function HeroInfoItem:onClickBtnDelete()
	if RogueMgr.instance:isInRogue() then
		print("不允许重新选择角色")

		return
	end

	if self._data then
		self._btnDelete:RemoveClickListener()

		if self._data.callback then
			self._data.callback(self._data.id)
		end
	end
end

function HeroInfoItem:unbindEvents()
	self._btnDelete:RemoveClickListener()
end

local PatternItem = class("PatternItem")

function PatternItem:ctor(go)
	self._go = go

	local tra = go.transform

	self._txtName = tra:Find("Text"):GetComponent("Text")
	self._dropDownApapter = goutil.findChild(go, "Dropdown"):GetComponent(UIComponentType.DropdownApapter)
end

function PatternItem:setData(data)
	self._txtName.text = data.name
	self._value = data.value
end

function PatternItem:getValue()
	return self._value
end

function PatternItem:getCount()
	return tonumber(self._dropDownApapter.dropdown.value)
end

local DefaultHeroIds = {
	2000011,
	2000012,
	2000013,
	2000020
}
local PatternMap = {
	{
		name = "暴击面",
		value = PATTERN.CRITICAL_STRIKE
	},
	{
		name = "献祭面",
		value = PATTERN.SACRIFICE
	},
	{
		name = "蚀智面",
		value = PATTERN.REDUCE_WISDOM
	},
	{
		name = "流血面",
		value = PATTERN.BLEEDING
	},
	{
		name = "恍惚面",
		value = PATTERN.TRANCE
	},
	{
		name = "诅咒面",
		value = PATTERN.CURSE
	},
	{
		name = "祝福面",
		value = PATTERN.BLESSING
	}
}
local M = class("RoguelikeTestMenuView", ViewComponent)

function M:ctor()
	M.super:ctor()

	self._heroItems = {}
end

function M:buildUI()
	self._btnReturn = self:getBtn("0&title_view_-878360263")
	self._btnAddHero = self:getBtn("roguelike_test_menu_panel_-479957066")
	self._btnFight = self:getBtn("roguelike_test_menu_panel_1049324008")
	self._btnTestMonster = self:getBtn("roguelike_test_menu_panel_-306853490")
	self._btnEvent = self:getBtn("roguelike_test_menu_panel_53974249")
	self._btnRectify = self:getBtn("roguelike_test_menu_panel_-635258315")
	self._btnShowDice = self:getBtn("roguelike_test_menu_panel_-1043805880")
	self._btnTestProp = self:getBtn("roguelike_test_menu_panel_33787161")
	self._txtShowDice = self._btnShowDice.transform:Find("Text"):GetComponent("Text")
	self._inputHeroId = self:getInput("roguelike_test_menu_panel_14142669")
	self._inputMonsterId = self:getInput("roguelike_test_menu_panel_-1690172639")
	self._inputEventId = self:getInput("roguelike_test_menu_panel_-1496306835")
	self._goHeroInfo = self:getGo("roguelike_test_menu_panel_-64905887")
	self._goHeroInfoItem = self:getGo("roguelike_test_menu_panel_-258231932")
	self._goPatterns = self:getGo("roguelike_test_menu_panel_-2052043472")
	self._goPatternItem = self:getGo("roguelike_test_menu_panel_398588990")
	self._patternItems = {}

	for i = 1, 7 do
		local itemGo = Astral.GameObjectUtil.CloneAndSetParent(self._goPatternItem, self._goPatterns.transform, nil)
		local item = PatternItem.New(itemGo)
		local data = {}

		data.name = PatternMap[i].name
		data.value = PatternMap[i].value

		item:setData(data)
		table.insert(self._patternItems, item)
		goutil.setActive(itemGo, true)
	end
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnAddHero:AddClickListener(self._onClickAddHero, self)
	self._btnFight:AddClickListener(self._onClickFight, self)
	self._btnTestMonster:AddClickListener(self._onClickTestMonster, self)
	self._btnEvent:AddClickListener(self._onClickEvent, self)
	self._btnRectify:AddClickListener(self._onClickRectify, self)
	self._btnShowDice:AddClickListener(self._onClickShowDice, self)
	self._btnTestProp:AddClickListener(self._onClickTestProp, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnAddHero:RemoveClickListener()
	self._btnFight:RemoveClickListener()
	self._btnTestMonster:RemoveClickListener()
	self._btnEvent:RemoveClickListener()
	self._btnRectify:RemoveClickListener()
	self._btnShowDice:RemoveClickListener()
	self._btnTestProp:RemoveClickListener()

	for k, v in pairs(self._heroItems) do
		v:unbindEvents()
	end
end

function M:onEnter()
	for k, v in pairs(DefaultHeroIds) do
		self:addHeroItem(v)
	end

	self:updateShowDiceText()
	RogueMgr.instance:setIsClientMode(true)
	ViewMgr.instance:close(ViewName.HackToolView)
end

function M:onExit()
	RogueMgr.instance:setIsClientMode(false)
end

function M:_onClickTestProp()
	ViewMgr.instance:open(ViewName.RogueTestEffect)
end

function M:_onClickShowDice()
	RogueMgr.instance:reverseShowDice()
	self:updateShowDiceText()
end

function M:updateShowDiceText()
	self._txtShowDice.text = RogueMgr.instance:getNeedShowDice() and lang("tip_hide_dice") or lang("tip_show_dice")
end

function M:_onClickAddHero()
	if RogueMgr.instance:isInRogue() then
		print("不允许重新选择角色")

		return
	end

	local heroId = self._inputHeroId:GetText()

	if heroId ~= nil and heroId ~= "" and self._heroItems[heroId] == nil then
		if self:getSelectHeroCount() >= 4 then
			print("超过数量")

			return
		end

		self:addHeroItem(tonumber(heroId))
	end
end

function M:getSelectHeroCount()
	local count = 0

	for k, v in pairs(self._heroItems) do
		count = count + 1
	end

	return count
end

function M:addHeroItem(heroId)
	if self:getSelectHeroCount() >= 4 or self._heroItems[heroId] ~= nil then
		return
	end

	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(heroId)

	if not roleCo then
		print("找不到配置", heroId)

		return
	end

	local itemGo = Astral.GameObjectUtil.CloneAndSetParent(self._goHeroInfoItem, self._goHeroInfo.transform, nil)
	local item = HeroInfoItem.New(itemGo)
	local data = {}

	data.name = RoguelikeConfig.instance:getRoleName(heroId)
	data.id = heroId

	function data.callback(id)
		self:onClickHeroDelete(id)
	end

	item:setData(data)

	self._heroItems[heroId] = item
end

function M:resetGameExtraPattern()
	if not RogueMgr.instance:isInRogue() then
		return
	end

	local patterns = {}

	for i = 1, #self._patternItems do
		local count = self._patternItems[i]:getCount()

		for j = 1, count do
			table.insert(patterns, self._patternItems[i]:getValue())
		end
	end

	RogueMgr.instance:getStateMgr():addTempExtraPattern(patterns)
end

function M:onClickHeroDelete(heroId)
	if self._heroItems[heroId] then
		goutil.destroy(self._heroItems[heroId]._go)

		self._heroItems[heroId] = nil
	end
end

function M:_onClickTestMonster()
	ViewMgr.instance:open(ViewName.RogueTestMonster)
end

function M:_onClickFight()
	local monsterId = self._inputMonsterId:GetText()

	if monsterId == nil or monsterId == "" then
		monsterId = 1019901

		self._inputMonsterId:SetText(monsterId)
	end

	monsterId = tonumber(monsterId)

	local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(monsterId)

	if monsterCo then
		if self:getSelectHeroCount() ~= 4 then
			print("角色数量不足")

			return
		end

		self:initRogue()
		self:resetGameExtraPattern()
		self:setSelectProp()
		ViewMgr.instance:open(ViewName.RogueMeetMonster, monsterId)
		self:close()
	else
		print("没有怪物配置", monsterId)
	end
end

function M:setSelectProp()
	for k, v in pairs(self._heroItems) do
		RogueMgr.instance:getRogueFlow().model:setRoleSelectProp(k, v:getDropProp())
	end
end

function M:initRogue()
	if RogueMgr.instance:isInRogue() then
		return
	end

	local tb = {}

	tb.roleIds = {}

	for k, v in pairs(self._heroItems) do
		table.insert(tb.roleIds, v:getHeroId())
	end

	RogueMgr.instance:enter(tb)
end

function M:_onClickEvent()
	local eventId = self._inputEventId:GetText()

	if eventId == nil or eventId == "" then
		eventId = 1000110

		self._inputEventId:SetText(eventId)
	end

	eventId = tonumber(eventId)

	local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)

	if eventCo then
		if self:getSelectHeroCount() ~= 4 then
			print("角色数量不足")

			return
		end

		self:initRogue()
		self:resetGameExtraPattern()
		self:setSelectProp()
		self:close()
		ViewMgr.instance:open(ViewName.RogueMeetEvent, eventId, true)
	else
		print("没有事件配置", eventId)
	end
end

function M:_onClickRectify()
	if self:getSelectHeroCount() ~= 4 then
		print("角色数量不足")

		return
	end

	self:initRogue()
	self:resetGameExtraPattern()
	self:setSelectProp()
end

function M:_onClickReturn()
	self:back()
end

return M
