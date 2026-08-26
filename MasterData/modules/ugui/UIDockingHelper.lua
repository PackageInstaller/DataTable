-- chunkname: @modules/ugui/UIDockingHelper.lua

module("modules.ugui.UIDockingHelper", package.seeall)

local CSRectTrHelper = SLFramework.UGUI.RectTrHelper
local UIDockingHelper = {}

function UIDockingHelper.__calcOfsV2FromCenterPivot(rectTransform)
	local rc = rectTransform.rect

	return Vector2(rc.width * (0.5 - rectTransform.pivot.x), rc.height * (0.5 - rectTransform.pivot.y))
end

function UIDockingHelper.__calcMidCenterLocalPosV2(tr, targetTr, isKeepPivot)
	local uiCamera = CameraMgr.instance:getUICamera()
	local screenPos = uiCamera:WorldToScreenPoint(targetTr.position)
	local localPosV2 = CSRectTrHelper.ScreenPosToAnchorPos(screenPos, tr.parent, uiCamera)

	if not isKeepPivot then
		local trOfs = UIDockingHelper.__calcOfsV2FromCenterPivot(tr)
		local targetTrOfs = UIDockingHelper.__calcOfsV2FromCenterPivot(targetTr)

		localPosV2 = localPosV2 - trOfs + targetTrOfs
	end

	return localPosV2
end

local ofs = 16

UIDockingHelper.Dock = {
	LB_RT = 10,
	RB_RT = 14,
	LB_RB = 8,
	RT_RT = 6,
	LT_LB = 1,
	LT_RB = 0,
	LT_LT = 3,
	RT_RB = 4,
	LB_LB = 9,
	RT_LB = 5,
	RB_LT = 15,
	LT_RT = 2,
	RB_LB = 13,
	RB_RB = 12,
	LB_LT = 11,
	RT_LT = 7,
	LT_U = 0 + ofs,
	MT_U = 3 + ofs,
	RT_U = 6 + ofs,
	LT_M = 1 + ofs,
	MT_M = 3 + ofs,
	RT_M = 7 + ofs,
	LT_D = 2 + ofs,
	MT_D = 5 + ofs,
	RT_D = 8 + ofs,
	ML_L = 9 + ofs,
	ML_M = 10 + ofs,
	ML_R = 11 + ofs,
	MR_L = 12 + ofs,
	MR_M = 13 + ofs,
	MR_R = 14 + ofs,
	LB_U = 15 + ofs,
	MB_U = 18 + ofs,
	RB_U = 21 + ofs,
	LB_M = 16 + ofs,
	MB_M = 19 + ofs,
	RB_M = 22 + ofs,
	LB_D = 17 + ofs,
	MB_D = 20 + ofs,
	RB_D = 23 + ofs
}

function UIDockingHelper._calcDockSudokuLocalPosV2(index, v2, tr, targetTr)
	if not index then
		return v2
	end

	local offsetX = 0
	local offsetY = 0
	local a = math.modf(index / 3)
	local b = index % 3

	b = b - 1

	local targetRc = targetTr.rect
	local thw = targetRc.width * 0.5
	local thh = targetRc.height * 0.5
	local trRc = tr.rect
	local hw = trRc.width * 0.5
	local hh = trRc.height * 0.5

	if a <= 2 then
		offsetY = offsetY + thh - hh * b
		a = a - 1
		offsetX = offsetX + thw * a
	elseif a <= 4 then
		a = a * 2 - 7
		offsetX = offsetX + thw * a + hw * b
	else
		offsetY = offsetY - thh - hh * b
		a = a - 6
		offsetX = offsetX + thw * a
	end

	v2.x = v2.x + offsetX
	v2.y = v2.y + offsetY

	return v2
end

function UIDockingHelper._calcDockCornorLocalPosV2(index, v2, tr, targetTr)
	if not index then
		return v2
	end

	local offsetX = 0
	local offsetY = 0
	local a = math.modf(index / 4)
	local b = index % 4
	local targetRc = targetTr.rect
	local thw = targetRc.width * 0.5
	local thh = targetRc.height * 0.5

	if a == 0 then
		offsetX = offsetX - thw
		offsetY = offsetY + thh
	elseif a == 1 then
		offsetX = offsetX + thw
		offsetY = offsetY + thh
	elseif a == 2 then
		offsetX = offsetX - thw
		offsetY = offsetY - thh
	elseif a == 3 then
		offsetX = offsetX + thw
		offsetY = offsetY - thh
	end

	local trRc = tr.rect
	local hw = trRc.width * 0.5
	local hh = trRc.height * 0.5

	if b == 0 then
		offsetX = offsetX + hw
		offsetY = offsetY - hh
	elseif b == 1 then
		offsetX = offsetX - hw
		offsetY = offsetY - hh
	elseif b == 2 then
		offsetX = offsetX + hw
		offsetY = offsetY + hh
	elseif b == 3 then
		offsetX = offsetX - hw
		offsetY = offsetY + hh
	end

	v2.x = v2.x + offsetX
	v2.y = v2.y + offsetY

	return v2
end

function UIDockingHelper.calcDockLocalPosV2(eDock, curRectTrans, targetRectTrans, isKeepPivot)
	local midCenterLocalPosV2 = UIDockingHelper.__calcMidCenterLocalPosV2(curRectTrans, targetRectTrans, isKeepPivot)

	if not eDock then
		return midCenterLocalPosV2
	end

	assert(eDock >= 0 and eDock <= 23 + ofs, "eDock=" .. tostring(eDock))

	local isSudoku = eDock >= ofs

	if isSudoku then
		return UIDockingHelper._calcDockSudokuLocalPosV2(eDock - ofs, midCenterLocalPosV2, curRectTrans, targetRectTrans)
	else
		return UIDockingHelper._calcDockCornorLocalPosV2(eDock, midCenterLocalPosV2, curRectTrans, targetRectTrans)
	end
end

function UIDockingHelper.setDock(eDock, curRectTrans, targetRectTrans, offsetX, offsetY, isKeepPivot)
	eDock = eDock or UIDockingHelper.Dock.MM_M

	local v2 = UIDockingHelper.calcDockLocalPosV2(eDock, curRectTrans, targetRectTrans, isKeepPivot)

	transformhelper.setLocalPos(curRectTrans, v2.x + (offsetX or 0), v2.y + (offsetY or 0), 0)
end

return UIDockingHelper
