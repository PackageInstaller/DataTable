-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueSanityItem.lua

module("logic.extensions.roguelike.view.widgets.RogueSanityItem", package.seeall)

local M = class("RogueSanityItem")
local kChangeAniTime = 1

function M:ctor(container)
	local go = container.gameObject

	self._go = go
	self._viewElementsRegistry = ViewElementsRegistry.New(go)
	self._goFu = goutil.findChild(go, "fu")
	self._goZheng = goutil.findChild(go, "zheng")
end

function M:Awake()
	self:onInit()
	self:setEvent(true)
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_CHANGE_COLLECTOR, self._onShowChangeCollector, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_CHANGE_COLLECTOR, self._onShowChangeCollector, self)
	end
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:onInit()
	local registry = self._viewElementsRegistry

	self._txtNum = registry:findUIElement("rungroup_sanity_item_-2097741133", UIComponentType.Text)
	self._txtChangeNum = registry:findUIElement("rungroup_sanity_item_-341284200", UIComponentType.Text)
	self._imgIcon = registry:findUIElement("rungroup_sanity_item_-670300985", UIComponentType.Image)
end

function M:updateData(data)
	local san = RoguelikeModel.instance:getRoleSan()
	local sanMax = RoguelikeModel.instance:getRoleSanMax()
	local isSanDanger = RoguelikeModel.instance:getSanIsDanger()
	local colorStr = isSanDanger and "#e680cf" or "#fad48e"

	self._txtNum.text = string.format("<color=%s>%d/%d</color>", colorStr, san, sanMax)

	local spriteName = isSanDanger and "grid_sanity_01" or "grid_sanity_02"

	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Dice, spriteName)
	self:showChangeEffect(isSanDanger)
end

function M:showChangeEffect(isSanDanger)
	if self._lastTag ~= nil and self._lastTag ~= isSanDanger then
		goutil.setActive(self._goFu, false)
		goutil.setActive(self._goZheng, false)

		local danger = isSanDanger

		settimer(0.02, function()
			goutil.setActive(self._goFu, danger)
			goutil.setActive(self._goZheng, not danger)
		end, self, false)
	end

	self._lastTag = isSanDanger
end

function M:showChangeAni(changeValue)
	self._txtChangeNum.text = changeValue > 0 and "+" .. changeValue or changeValue

	goutil.setActive(self._txtChangeNum.gameObject, true)
	self:updateData()
	removetimer(self._delayHideText, self)
	settimer(kChangeAniTime, self._delayHideText, self, false)
end

function M:_delayHideText()
	goutil.setActive(self._txtChangeNum.gameObject, false)
	self:updateData()
end

function M:OnDestroy()
	self:setEvent(false)
	removetimer(self._delayHideText, self)
end

function M:_onShowChangeCollector(sender, changes)
	if #changes > 0 then
		local attrType = RoguelikeExtension_pb.AttrType

		for k, v in ipairs(changes) do
			if v.type == attrType.SAN then
				self:showChangeAni(v.num)
			end
		end
	end
end

return M
