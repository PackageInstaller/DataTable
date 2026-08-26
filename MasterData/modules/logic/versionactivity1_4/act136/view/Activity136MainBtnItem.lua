-- chunkname: @modules/logic/versionactivity1_4/act136/view/Activity136MainBtnItem.lua

module("modules.logic.versionactivity1_4.act136.view.Activity136MainBtnItem", package.seeall)

local Activity136MainBtnItem = class("Activity136MainBtnItem", ActCenterItemBase)

function Activity136MainBtnItem:onOpen()
	self.redDot = RedDotController.instance:addNotEventRedDot(self._goactivityreddot, Activity136Model.isShowRedDot, Activity136Model.instance)
end

function Activity136MainBtnItem:onRefresh()
	local mainActAtmosphereConfig = self:getMainActAtmosphereConfig()

	if self:isShowActivityEffect() then
		if not (mainActAtmosphereConfig.mainViewActBtnPrefix .. "icon_5") then
			local spriteName = "icon_5"

			UISpriteSetMgr.instance:setMainSprite(self._imgitem, spriteName, true)
			self:_refreshRedDot()
		end
	end
end

function Activity136MainBtnItem:onAddEvent()
	Activity136Controller.instance:registerCallback(Activity136Event.ActivityDataUpdate, self.refreshRedDot, self)
end

function Activity136MainBtnItem:onRemoveEvent()
	Activity136Controller.instance:unregisterCallback(Activity136Event.ActivityDataUpdate, self.refreshRedDot, self)
end

function Activity136MainBtnItem:onClick()
	Activity136Controller.instance:openActivity136View()
end

function Activity136MainBtnItem:_refreshRedDot()
	self.redDot:refreshRedDot()
end

return Activity136MainBtnItem
