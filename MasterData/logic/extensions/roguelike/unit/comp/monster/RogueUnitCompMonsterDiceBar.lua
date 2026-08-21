-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/monster/RogueUnitCompMonsterDiceBar.lua

module("logic.extensions.roguelike.unit.comp.monster.RogueUnitCompMonsterDiceBar", package.seeall)

local M = class("RogueUnitCompMonsterDiceBar", RogueUnitCompBase)
local URL_INFOBAR = ResName.Rungroup_monster_unit2
local DiceInfoItem = class("DiceInfoItem")

function DiceInfoItem:ctor(container)
	local go = container.gameObject

	self._imgDice = goutil.findChildImageComponent(go, "normal/attributeIcon")
	self._imgDice2 = goutil.findChildImageComponent(go, "light/attributeIcon")
	self._goNormal = goutil.findChild(go, "normal")
	self._goLight = goutil.findChild(go, "light")
	self._btn = Astral.ButtonAdapter.Get(self._imgDice.gameObject)
	self._btn2 = Astral.ButtonAdapter.Get(self._imgDice2.gameObject)

	self._btn:AddClickListener(self._onClick, self)
	self._btn2:AddClickListener(self._onClick, self)
end

function DiceInfoItem:removeListener()
	self._btn:RemoveClickListener()
	self._btn2:RemoveClickListener()
end

function DiceInfoItem:_onClick()
	ViewMgr.instance:open(ViewName.RogueMonsterCard)
end

function DiceInfoItem:setHighLight(isHighLight)
	goutil.setActive(self._goNormal, not isHighLight)
	goutil.setActive(self._goLight, isHighLight)
end

function DiceInfoItem:setDiceIcon(pattern)
	IconLoader.setSprite(self._imgDice, IconType.DynSpriteAtlas_Dice, string.format("dice_%d", RoguelikeConst.GetPatterIcon(pattern)))
	IconLoader.setSprite(self._imgDice2, IconType.DynSpriteAtlas_Dice, string.format("dice_%d", RoguelikeConst.GetPatterIcon(pattern)))

	self._dicePattern = pattern
end

function DiceInfoItem:getDicePattern()
	return self._dicePattern
end

function DiceInfoItem:destroy()
	self:removeListener()
end

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = SingleResLoader.New()
	self._goInst = nil
	self._followUIComp = nil
	self._viewElementsRegistry = nil
	self._isVisible = nil
	self._diceItems = {}
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_FEATURES_ROLL_RESULT, self._onFeatureRollResult, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_FEATURES_ROLL_REFRESH, self._onFeatureRollRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_FEATURES_ROLL_RESULT, self._onFeatureRollResult, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_FEATURES_ROLL_REFRESH, self._onFeatureRollRefresh, self)
	end
end

function M:getGoInst()
	return self._goInst
end

function M:getIsLoaded()
	return self._goInst ~= nil
end

function M:_onFeatureRollRefresh()
	self:updateDicePattern()
	self:_onFeatureRollResult()
end

function M:_onFeatureRollResult(sender, feature, isNew, index)
	local featureDice = RogueMgr.instance:getRogueFlow().judgeMgr:getCombatDiceFeatures()
	local curFeatureIndex = RogueMgr.instance:getRogueFlow().judgeMgr:getFeatureIndex()

	if #self._diceItems == 0 then
		self:delayShowFeatureResult()

		return
	end

	local hadMatch = false

	for k, v in ipairs(self._diceItems or {}) do
		local pattern = v:getDicePattern()
		local isHighLight = false

		isHighLight = curFeatureIndex == k

		if index then
			isHighLight = k == index
		end

		v:setHighLight(isHighLight)
	end
end

function M:delayShowFeatureResult()
	if #self._diceItems > 5 then
		removetimer(self.delayShowFeatureResult, self)
		self:_onFeatureRollResult()

		return
	end

	settimer(0.1, self.delayShowFeatureResult, self, false)
end

function M:showHighLight(index)
	for k, v in ipairs(self._diceItems or {}) do
		v:setHighLight(k == index)
	end
end

function M:onInit()
	self:setEvent(true)

	self._followUIComp = self._unit.uiFollow
end

function M:onReset()
	self:setEvent(false)
	removetimer(self.delayShowFeatureResult, self)

	if self._followUIComp then
		self._followUIComp:removeAllFollowGameObject()
	end

	if self._goInst then
		goutil.destroy(self._goInst)

		self._goInst = false
	end

	if self._resLoader then
		self._resLoader:clear()
	end

	self._isVisible = false
end

function M:onDestroy()
	self:setEvent(false)
	removetimer(self.delayShowFeatureResult, self)

	if self._followUIComp then
		self._followUIComp:removeAllFollowGameObject()
	end

	if self._goInst then
		goutil.destroy(self._goInst)
	end

	self._goInst = nil

	if self._resLoader then
		self._resLoader:clear()
	end

	for k, v in pairs(self._diceItems) do
		v:destroy()
	end

	self._diceItems = {}
	self._resLoader = nil
	self._followUIComp = nil
	self._viewElementsRegistry = nil
	self._isVisible = false
end

function M:setVisible(visible, exit)
	self._isVisible = visible

	if self._goInst then
		self:_setVisible()
	else
		if exit then
			return
		end

		if self._resLoader then
			self._resLoader:load(URL_INFOBAR, self._onResLoaded, self)
		end
	end
end

function M:_setVisible()
	goutil.setActive(self._goInst, self._isVisible)
end

function M:_onResLoaded()
	self._goInst = self._resLoader:getResInstance()

	self:_buildUI(self._goInst)

	local parentGo = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	goutil.addChildToParent(self._goInst, parentGo)
	self._followUIComp:addFollowGameObject(UIFollowType.Bottom, self._goInst)
	self._followUIComp:setPivot(UIFollowType.Bottom, 0, 0)
	self._followUIComp:setPerspectiveEnable(true)
	self:_setVisible()
end

function M:_buildUI(mainGO)
	local itemParent = mainGO.transform:GetChild(1)
	local featureDices = RogueMgr.instance:getRogueFlow().judgeMgr:getFeaturePatterns()

	self._diceItems = {}

	for i = 0, itemParent.childCount - 1 do
		local go = itemParent:GetChild(i).gameObject
		local item = Astral.LuaComponentContainer.Add(go, DiceInfoItem)

		item:setHighLight(false)
		item:setDiceIcon(featureDices[i + 1])
		table.insert(self._diceItems, item)
	end
end

function M:updateDicePattern()
	local featureDices = RogueMgr.instance:getRogueFlow().judgeMgr:getFeaturePatterns()

	for k, v in ipairs(self._diceItems or {}) do
		if featureDices[k] then
			v:setDiceIcon(featureDices[k])
		end
	end
end

function M:_onChangeVisible(visible)
	self:showByData(visible)
end

function M:clear()
	if self._followUIComp then
		self._followUIComp:removeAllFollowGameObject()
	end

	if self._goInst then
		goutil.destroy(self._goInst)
	end

	for k, v in pairs(self._diceItems) do
		v:destroy()
	end

	self._diceItems = {}
	self._goInst = false

	if self._resLoader then
		self._resLoader:clear()
	end
end

return M
