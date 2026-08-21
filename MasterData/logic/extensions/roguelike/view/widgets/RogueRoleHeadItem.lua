-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueRoleHeadItem.lua

module("logic.extensions.roguelike.view.widgets.RogueRoleHeadItem", package.seeall)

local M = class("RogueRoleHeadItem")

function M:ctor(go)
	self._go = go
	self._imgIcon = goutil.findChildComponent(go, "headMask/headIcon", UIComponentType.Image)

	if not self._imgIcon then
		self._imgIcon = goutil.findChildComponent(go, "mask/headIcon", UIComponentType.Image)
	end

	self._txtHp = goutil.findChildComponent(go, "hp/txtHp", UIComponentType.Text)
	self._txtSan = goutil.findChildComponent(go, "san/txtSan", UIComponentType.Text)
end

function M:setHp(hp, maxHp)
	maxHp = maxHp or hp
	self._txtHp.text = hp
end

function M:setSan(san)
	self._txtSan.text = san
end

function M:setHeadIcon(roleId)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(roleId)

	if characterCO then
		local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

		IconLoader.setSprite(self._imgIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	end
end

return M
