-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsAdapterPosComp.lua

module("logic.extensions.tooltips.component.ToolTipsAdapterPosComp", package.seeall)

local TIPS_OX, TIPS_OY = 0.6, 0.4
local TIPS_OFFSET_SCALE = 0.0076
local MID_OFFSET_X_FLAG = 1
local BOTTOM_Y_FLAG = 997.2
local M = class("ToolTipsAdapterPosComp", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:onEnter()
	local info = self:getFirstParam()
	local posX, posY, posZ = self:adapterTipsPos(info.posX, info.posY, info.posZ)

	Astral.TransformUtil.SetPos(self.mainGO.transform, posX, posY, posZ)
end

function M:adapterTipsPos(posX, posY, posZ)
	local ox = TIPS_OX
	local rect = self.mainGO.transform.rect

	if posX > MID_OFFSET_X_FLAG then
		ox = -(rect.width * TIPS_OFFSET_SCALE + TIPS_OX)
	end

	posX = posX + ox
	posY = posY + TIPS_OY

	local tempY = posY - rect.height * TIPS_OFFSET_SCALE - BOTTOM_Y_FLAG

	if tempY < 0 then
		posY = posY - tempY
	end

	return posX, posY, posZ
end

return M
