-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/BattleSettingTaskItem.lua

module("logic.extensions.battle.viewsetting.BattleSettingTaskItem", package.seeall)

local M = class("BattleSettingTaskItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self.mainGO = self._compContainer.gameObject
	self._trs = self.mainGO.transform
end

function M:Awake()
	self._txtName = goutil.findChildTextComponent(self.mainGO, "content/txtName")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "content/txtContent")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "content/battleheroitem/heroIcon")
	self._imgQuality = goutil.findChildImageComponent(self.mainGO, "content/battleheroitem/imgQuality")
	self._imgQualityLine = goutil.findChildImageComponent(self.mainGO, "content/battleheroitem/imgQuality/imgLine")
	self._txtEmptyGo = goutil.findChild(self.mainGO, "content/txtName")
	self._finishSignGo = goutil.findChild(self.mainGO, "content/stateDone")
end

function M:setCellData(heroId, data, index)
	if data then
		local progressStr = self:_getProcessDesc(data:getCurCount(), data:getMaxCount())

		self._txtDesc.text = string.format("%s\r\n%s", data:getDesc(), progressStr)

		goutil.setActive(self._finishSignGo, data:getCurCount() >= data:getMaxCount())
	else
		goutil.setActive(self._finishSignGo, false)

		self._txtDesc.text = string.format("<color=#FFFFFF>%s</color>", lang("tip_setting_task_tips_1"))
	end

	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if heroMO then
		local modelCO = ModelConfig.instance:getModelConfig(heroMO:getModelId())
		local characterCO = heroMO:getCharacterCo()

		IconLoader.setSprite(self._imgIcon, IconType.RoleHeadIcon, modelCO.headIconName)
		IconLoader.setSprite(self._imgQuality, IconType.Skinlib, CharacterCOUtil.quality2IconName(characterCO.quality))
		IconLoader.setSprite(self._imgQualityLine, IconType.Skinlib, CharacterCOUtil.quality2LineName(characterCO.quality))

		self._txtName.text = heroMO:getName()
	else
		self._txtName.text = ""
	end
end

function M:_getProcessDesc(curCount, maxCount)
	return string.format("<color=#FFFFFF>(%s/%s)</color>", tonumber(curCount) > tonumber(maxCount) and maxCount or curCount, maxCount)
end

function M:OnDestroy()
	self._compContainer = nil
	self.mainGO = nil
	self._trs = nil
	self._viewElementsRegistry = nil
end

return M
