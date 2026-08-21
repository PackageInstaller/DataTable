-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/MonsterHeadCell.lua

module("logic.extensions.dungeon.view.MonsterHeadCell", package.seeall)

local M = class("MonsterHeadCell")

function M:ctor(compContainer)
	self._go = compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self._noneGo = self._viewElementsRegistry:findUIElement("boss_icon_162410125")
	self._iconImg = self._viewElementsRegistry:findUIElement("boss_icon_-1683764635", UIComponentType.Image)
	self._careerDi = self._viewElementsRegistry:findUIElement("0&career_-1600786498", UIComponentType.Image)
	self._careerSign = self._viewElementsRegistry:findUIElement("0&career_1390243743", UIComponentType.Image)
	self._lvTxt = self._viewElementsRegistry:findUIElement("enemy_head_-339693310", UIComponentType.Text)
end

function M:setShowMonsterStatus(state)
	self._ifShowMonster = true
end

function M:setMonsterCode(code)
	self._monsterCode = code

	self:_refreshView()
end

function M:_refreshView()
	if self._ifShowMonster then
		goutil.setActive(self._noneGo, false)
		goutil.setActive(self._iconImg.gameObject, true)

		local monsterCO = MonsterConfig.instance:getMonsterCO(self._monsterCode)
		local modelCO = ModelConfig.instance:getModelConfig(monsterCO.modelId)

		IconLoader.setSprite(self._iconImg, IconType.RoleCard, modelCO.halfIconName)
		IconLoader.setSprite(self._careerDi, IconType.Skinlib, CharacterCOUtil.colorType2IconName(monsterCO.colorType))
		IconLoader.setSprite(self._careerSign, IconType.Skinlib, CharacterCOUtil.career2IconName(monsterCO.career))

		self._lvTxt.text = string.format("Lv.%s", monsterCO.level)
	else
		goutil.setActive(self._noneGo, true)
		goutil.setActive(self._iconImg.gameObject, false)
	end
end

function M:OnDestroy()
	self._viewElementsRegistry:cleanRegistry()

	self._viewElementsRegistry = nil
end

return M
