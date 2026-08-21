-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/CommMonsterHeadCell.lua

module("logic.extensions.dungeon.view.CommMonsterHeadCell", package.seeall)

local M = class("CommMonsterHeadCell", SimpleCellComponent)

function M:ctor(container)
	self.super.ctor(self, container)

	self._clickHandler = Handler.New()
end

function M:buildUI()
	self._imgIcon = self._registry:getImage("battle_hero_item_892867850")
	self._imgCareerDi = self._registry:getImage("0&career_-1600786498")
	self._imgCareerSign = self._registry:getImage("0&career_1390243743")
	self._textLevel = self._registry:getText("battle_hero_item_1708325635")
	self._imgBossDi = self._registry:getImage("hero_item_-546250470")
	self._imgBossSign = self._registry:getImage("hero_item_261605169")
	self._goQuality = self._registry:getGo("hero_item_29007724")
	self._btnClick = self._registry:getBtn("battle_hero_item_-1904829982")
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickCell, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:_setData(monsterCode)
	self._monsterCode = monsterCode
	self._monsterCO = MonsterConfig.instance:getMonsterCO(self._monsterCode)
end

function M:_refreshUI()
	if self._monsterCO == nil then
		return
	end

	local isBoss = self._monsterCO.monsterType and self._monsterCO.monsterType == 2 or false

	goutil.setActive(self._imgBossDi.gameObject, isBoss)
	goutil.setActive(self._imgBossSign.gameObject, isBoss)
	goutil.setActive(self._noneGo, false)
	goutil.setActive(self._imgIcon.gameObject, true)
	goutil.setActive(self._goQuality, false)

	local modelCO = ModelConfig.instance:getModelConfig(self._monsterCO.modelId)

	IconLoader.setSprite(self._imgIcon, IconType.RoleCard, modelCO.halfIconName)
	IconLoader.setSprite(self._imgCareerDi, IconType.Skinlib, CharacterCOUtil.colorType2IconName(self._monsterCO.colorType))
	IconLoader.setSprite(self._imgCareerSign, IconType.Skinlib, CharacterCOUtil.career2IconName(self._monsterCO.career))

	self._textLevel.text = string.format("Lv.%s", self._monsterCO.level)
end

function M:_onClickCell()
	self._clickHandler:call(self)
end

function M:setClickListener(callbackFun, callbackObj)
	self._clickHandler:setListener(callbackFun, callbackObj)
end

function M:removeClickListener()
	self._clickHandler:clear()
end

return M
