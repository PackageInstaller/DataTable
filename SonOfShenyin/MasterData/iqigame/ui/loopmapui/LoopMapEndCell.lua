-- chunkname: @IQIGame\\UI\\LoopMapUI\\LoopMapEndCell.lua

local LoopMapEndCell = classF(LoopMapBaseCell)

function LoopMapEndCell:ctor(param)
	self.type = Constant.LoopMapCellType.End

	LuaUtility.SetImageColorWithGameObject(self.gameObject, 0.6603774, 0.2273941, 0.2273941, 1)

	self.matchCode = tonumber(param.params[1])
end

function LoopMapEndCell:GetMatchCode()
	return self.matchCode
end

return LoopMapEndCell
