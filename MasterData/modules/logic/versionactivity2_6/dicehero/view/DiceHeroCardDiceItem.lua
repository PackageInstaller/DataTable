-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroCardDiceItem.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroCardDiceItem", package.seeall)

local DiceHeroCardDiceItem = class("DiceHeroCardDiceItem", LuaCompBase)

function DiceHeroCardDiceItem:init(go)
	self._icon = gohelper.findChildImage(go, "")
	self._txtdicenum = gohelper.findChildTextMesh(go, "#txt_dicenum")
	self._goselect = gohelper.findChild(go, "#go_select")
	self._canvasGroup = gohelper.onceAddComponent(go, typeof(UnityEngine.CanvasGroup))
end

function DiceHeroCardDiceItem:addEventListeners()
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardSelectChange, self.refreshUI, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardDiceChange, self.refreshUI, self)
end

function DiceHeroCardDiceItem:removeEventListeners()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardSelectChange, self.refreshUI, self)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardDiceChange, self.refreshUI, self)
end

function DiceHeroCardDiceItem:initData(ruleInfo, cardMo, index)
	self._ruleInfo = ruleInfo
	self._cardMo = cardMo
	self._index = index

	local suitId = self._ruleInfo[1]
	local pointId = self._ruleInfo[2]

	if suitId == 0 then
		suitId = 8
	end

	local suitCo = lua_dice_suit.configDict[suitId]
	local pointCo = lua_dice_point.configDict[pointId]

	if suitCo then
		local arr = string.split(suitCo.icon2, "#")

		if not cardMo.matchNums[1] then
			UISpriteSetMgr.instance:setDiceHeroSprite(self._icon, (cardMo.matchNums[1] < self._index or nil) and (arr[2] or arr[1]))
		end
	end

	if pointCo then
		self._txtdicenum.text = pointCo.txt
	end

	self:refreshUI()
end

function DiceHeroCardDiceItem:refreshUI()
	local gameInfo = DiceHeroFightModel.instance:getGameData()

	if gameInfo.curSelectCardMo == self._cardMo then
		local isSelect = self._cardMo.curSelectUids[self._index]

		gohelper.setActive(self._goselect, isSelect)

		self._canvasGroup.alpha = isSelect and 1 or 0.4
	else
		gohelper.setActive(self._goselect, false)

		self._canvasGroup.alpha = 1
	end
end

return DiceHeroCardDiceItem
