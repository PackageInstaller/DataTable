-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/DungeonEnemyItem.lua

module("logic.extensions.dungeon.view.DungeonEnemyItem", package.seeall)

local M = class("DungeonEnemyItem")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._bossDi = goutil.findChild(self._mainGO, "imgDossDi")
	self._bossMask = goutil.findChild(self._mainGO, "imgDossMask")
	self._bossSign = goutil.findChild(self._mainGO, "imgDossSign")
	self._normalMask = goutil.findChild(self._mainGO, "imgMask")
	self._noneIcon = goutil.findChild(self._mainGO, "Image1")
	self._iconImg = goutil.findChildImageComponent(self._mainGO, "imgIcon")
	self._careerDi = goutil.findChildImageComponent(self._mainGO, "career/type1/imgCareerDi")
	self._careerSign = goutil.findChildImageComponent(self._mainGO, "career/type1/imgCareerSign")
	self._lvTxt = goutil.findChildTextComponent(self._mainGO, "lvValue")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGO, "click"))

	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:OnDestroy()
	self._btnClick:RemoveClickListener()
end

function M:getGO()
	return self._mainGO
end

function M:setVisible(visible)
	goutil.setActive(self._mainGO, visible)
end

function M:updateByCode(monsterCode)
	self._monsterCode = monsterCode

	local monsterCO = MonsterConfig.instance:getMonsterCO(self._monsterCode)
	local modelCO = ModelConfig.instance:getModelConfig(monsterCO.modelId)

	IconLoader.setSprite(self._iconImg, IconType.RoleCard, modelCO.halfIconName)
	IconLoader.setSprite(self._careerDi, IconType.Skinlib, CharacterCOUtil.colorType2IconName(monsterCO.colorType))
	IconLoader.setSprite(self._careerSign, IconType.Skinlib, CharacterCOUtil.career2IconName(monsterCO.career))

	self._lvTxt.text = string.format("Lv.%s", monsterCO.level)

	local isBoss = monsterCO.monsterType == BattleEnum.MonsterType.BOSS

	goutil.setActive(self._bossDi, isBoss)
	goutil.setActive(self._bossMask, isBoss)
	goutil.setActive(self._bossSign, isBoss)
	goutil.setActive(self._normalMask, not isBoss)
end

function M:setNone(isNone)
	goutil.setActive(self._noneIcon, isNone)
	goutil.setActive(self._bossDi, not isNone)
	goutil.setActive(self._bossMask, not isNone)
	goutil.setActive(self._bossSign, not isNone)
	goutil.setActive(self._normalMask, not isNone)
	goutil.setActive(self._iconImg.gameObject, not isNone)
	goutil.setActive(self._lvTxt.gameObject, not isNone)
	goutil.setActive(self._careerDi.gameObject, not isNone)
	goutil.setActive(self._careerSign.gameObject, not isNone)
end

function M:_onClickSelf()
	return
end

return M
