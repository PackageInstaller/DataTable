-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/GainMaskView.lua

module("logic.extensions.playerinfo.view.info.GainMaskView", package.seeall)

local M = class("GainMaskView", ViewComponent)

function M:buildUI()
	self._imgIcon = self:getImage("unlock_mask_view_-97592128")
	self._raycast = self:getBtn("0&empty_mask_tips_29887572")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._raycast:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._raycast:RemoveClickListener()
end

function M:onEnter()
	local data = self:getFirstParam()

	self:updateData(data)
end

function M:_onClickClose()
	self:close()
end

function M:onExit()
	return
end

function M:updateData(data)
	local cfg = BackpackConfig.instance:getItemInfoByItemId(data:getItemId())

	IconLoader.setSprite(self._imgIcon, IconType.PlayerInfoMask, cfg.icon)
end

return M
