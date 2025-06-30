-- chunkname: @IQIGame\\UI\\LoopMapUI\\LoopMapStartCell.lua

local LoopMapStartCell = classF(LoopMapBaseCell)

function LoopMapStartCell:ctor(param)
	self.type = Constant.LoopMapCellType.Start

	LuaUtility.SetImageColorWithGameObject(self.gameObject, 0.2179601, 0.5849056, 0.2306134, 1)

	self.matchCode = tonumber(param.params[1])
end

function LoopMapStartCell:GetMatchCode()
	return self.matchCode
end

return LoopMapStartCell
