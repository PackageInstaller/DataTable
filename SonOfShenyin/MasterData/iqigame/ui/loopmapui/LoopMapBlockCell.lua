-- chunkname: @IQIGame\\UI\\LoopMapUI\\LoopMapBlockCell.lua

local LoopMapBlockCell = classF(LoopMapBaseCell)

function LoopMapBlockCell:ctor(go)
	self.type = Constant.LoopMapCellType.Block

	LuaUtility.SetImageColorWithGameObject(self.gameObject, 0.5283019, 0.3278909, 0.03737985, 1)
end

function LoopMapBlockCell:IsNeedAddInLineList()
	return false
end

return LoopMapBlockCell
