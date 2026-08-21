-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/task/AirWorkShopTrophyTopTips.lua

module("logic.extensions.airworkshop.view.task.AirWorkShopTrophyTopTips", package.seeall)

local M = class("AirWorkShopTrophyTopTips", ViewComponent)

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._canvasGroup = self:getUIComponent("air_workshop_trophy_tips_1359150455", ComponentType.CanvasGroup)
	self._imgIcon = self:getImage("air_workshop_trophy_tips_-2050938661")
	self._txtName = self:getUIComponent("air_workshop_trophy_tips_690438440", UIComponentType.Text)
end

function M:destroyUI()
	self:_releaseTween()
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter(reasonType)
	self:_releaseTween()
	self._guiAnimation:StopTimelineAni()

	self._canvasGroup.alpha = 0

	self:setEvent(true)

	local info = self:getFirstParam() or {}
	local itemListData = info.itemDataList or {}

	if #itemListData == 0 then
		self:close()

		return
	end

	if #itemListData > 1 then
		printWarn(string.format("物品数量 %s > 1", #itemListData))
	end

	self:updateItem(itemListData[1])
	self._guiAnimation:PlayAniByName("open")

	local delayHide = info.delayHide or 1

	self._delayTween = DoTweenUtil.DelayedCall(delayHide, function()
		self:close()
	end)
end

function M:onEnterFinished()
	return
end

function M:onExit(reasonType)
	self:setEvent(false)
	self:_releaseTween()
end

function M:onExitFinished()
	return
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_releaseTween()
	if self._delayTween then
		self._delayTween:Kill(false)
	end

	self._delayTween = nil
end

function M:updateItem(itemData)
	self._txtName.text = itemData:getName()

	local icon = itemData:getIcon()
	local itemTypeEnum = itemData:getType()

	if string.nilorempty(icon) then
		return
	end

	IconLoader.setSpriteByItemType(self._imgIcon, itemTypeEnum, icon)
end

return M
