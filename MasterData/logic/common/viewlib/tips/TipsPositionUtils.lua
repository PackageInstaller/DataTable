-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/tips/TipsPositionUtils.lua

module("logic.common.viewlib.tips.TipsPositionUtils", package.seeall)

local M = {}
local kShiftingX = 10
local kShiftingY = 10
local kUiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

function M.alignScreenPosition(mainGO, x, y)
	local mainTransform = mainGO.transform
	local parentTransfrom = mainTransform.parent
	local halfScreenHeight = ViewMgr.instance:getUIHeight() * 0.5
	local halfWidth = RectTransformUtils.GetWidth(mainTransform) * 0.5
	local halfHeight = RectTransformUtils.GetHeight(mainTransform) * 0.5
	local targetX, targetY = RectTransformUtils.ScreenPointToLocalPointInRectangle(parentTransfrom, x, y, kUiCamera, 0, 0)
	local resultX, resultY = 0, 0

	if targetX > 0 then
		resultX = -halfWidth + targetX - kShiftingX
	else
		resultX = halfWidth + targetX + kShiftingX
	end

	local deltaHeight = halfScreenHeight - halfHeight

	if targetY > 0 then
		resultY = -halfHeight + targetY - kShiftingY

		if deltaHeight < math.abs(resultY) then
			resultY = -deltaHeight + kShiftingY
		end
	else
		resultY = halfHeight + targetY + kShiftingY

		if deltaHeight < math.abs(resultY) then
			resultY = deltaHeight - kShiftingY
		end
	end

	Astral.TransformUtil.SetLocalPos(mainTransform, resultX, resultY, 0)
end

return M
