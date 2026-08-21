-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueRoleStatusChangeTips.lua

module("logic.extensions.roguelike.view.widgets.RogueRoleStatusChangeTips", package.seeall)

local M = class("RogueRoleStatusChangeTips")

function M:ctor(go)
	self._go = go.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go.gameObject)
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	local registry = self._viewElementsRegistry

	self._txtState = registry:findUIElement("character_status_change_tips_235669840", UIComponentType.Text)
	self._heroIcon = registry:findUIElement("character_status_change_tips_-248149165", UIComponentType.Image)
	self._goHp = registry:findUIElement("character_status_change_tips_-868027438")
	self._goSan = registry:findUIElement("character_status_change_tips_460172539")
end

function M:setStateContent(state)
	self._txtState.text = state
end

function M:setHeadIcon(roleId)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(roleId)

	IconLoader.setSprite(self._heroIcon, IconType.Head, characterCO.modelId)
end

function M:updateData(data)
	removetimer(self._onHideTips, self)
	self:setHeadIcon(data.roleId)

	local num = data.changeHp ~= 0 and data.changeHp or data.changeSan

	self._txtState.text = num > 0 and "+" .. num or num

	goutil.setActive(self._goHp, data.changeHp ~= 0)
	goutil.setActive(self._goSan, data.changeSan ~= 0)
	self:setActive(true)
	settimer(0.8, self._onHideTips, self, false)
end

function M:_onHideTips()
	self:setActive(false)
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:OnDestroy()
	self._txtState = nil
	self._heroIcon = nil

	removetimer(self._onHideTips, self)
end

return M
