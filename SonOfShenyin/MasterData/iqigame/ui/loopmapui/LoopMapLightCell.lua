-- chunkname: @IQIGame\\UI\\LoopMapUI\\LoopMapLightCell.lua

local LoopMapLightCell = classF(LoopMapBaseCell)

function LoopMapLightCell:ctor(param)
	self.type = Constant.LoopMapCellType.Light

	LuaUtility.SetImageColorWithGameObject(self.gameObject, 0.6415094, 0.6391343, 0.233001, 1)

	self.rotateList = {}

	local len = #param.params

	for i = 1, len do
		local strArr = string.split(param.params[i], "|")
		local tb = {}

		tb.row = tonumber(strArr[1])
		tb.column = tonumber(strArr[2])

		table.insert(self.rotateList, tb)
	end
end

function LoopMapLightCell:OnProcessing()
	local len = #self.rotateList

	for i = 1, len do
		EventDispatcher.Dispatch(EventID.LoopMapUIRotateConvertEvent, self.rotateList[i].row, self.rotateList[i].column)
	end

	self.isPowerOn = true

	return true
end

return LoopMapLightCell
