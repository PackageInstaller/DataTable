-- chunkname: @IQIGame\\UI\\LoopMapUI\\LoopMapConvertCell.lua

local LoopMapConvertCell = classF(LoopMapBaseCell)

function LoopMapConvertCell:ctor(param)
	self.type = Constant.LoopMapCellType.Converter

	LuaUtility.SetImageColorWithGameObject(self.gameObject, 0.1965112, 0.5658887, 0.6037736, 1)
	LuaUtility.SetGameObjectShow(self.view.convertCell, true)

	self.openNode = param.openNode
	self.currentOpenNode = {}

	local len = #self.openNode

	for i = 1, len do
		self.currentOpenNode[i] = self.openNode[i]
	end
end

function LoopMapConvertCell:OnProcessing()
	for _, v in pairs(self.connectList) do
		local len = #self.currentOpenNode
		local isInputHave = false
		local isOutputHave = false

		for i = 1, len do
			if v.input == self.currentOpenNode[i] then
				isInputHave = true
			end

			if v.output == self.currentOpenNode[i] then
				isOutputHave = true
			end
		end

		if not isInputHave or not isOutputHave then
			self.isPowerOn = false

			return false
		end
	end

	self.isPowerOn = true

	return true
end

function LoopMapConvertCell:RevertState()
	LoopMapConvertCell.superClass.RevertState(self)

	self.currentOpenNode = {}

	local len = #self.openNode

	for i = 1, len do
		self.currentOpenNode[i] = self.openNode[i]
	end

	self:RefreshState()
end

function LoopMapConvertCell:Rotate()
	local len = #self.currentOpenNode

	for i = 1, len do
		self.currentOpenNode[i] = self.currentOpenNode[i] + 1

		if self.currentOpenNode[i] > 4 then
			self.currentOpenNode[i] = 1
		end
	end

	self:OnProcessing()
	self:RefreshState()
end

local two_state1 = {
	Constant.LoopMapDirection.Left,
	Constant.LoopMapDirection.Bottom
}
local two_state2 = {
	Constant.LoopMapDirection.Left,
	Constant.LoopMapDirection.Top
}
local two_state3 = {
	Constant.LoopMapDirection.Top,
	Constant.LoopMapDirection.Right
}
local two_state4 = {
	Constant.LoopMapDirection.Bottom,
	Constant.LoopMapDirection.Right
}
local three_State1 = {
	Constant.LoopMapDirection.Left,
	Constant.LoopMapDirection.Top,
	Constant.LoopMapDirection.Right
}
local three_State2 = {
	Constant.LoopMapDirection.Top,
	Constant.LoopMapDirection.Right,
	Constant.LoopMapDirection.Bottom
}
local three_State3 = {
	Constant.LoopMapDirection.Right,
	Constant.LoopMapDirection.Bottom,
	Constant.LoopMapDirection.Left
}
local three_State4 = {
	Constant.LoopMapDirection.Bottom,
	Constant.LoopMapDirection.Left,
	Constant.LoopMapDirection.Top
}

function LoopMapConvertCell:RefreshState()
	LuaUtility.SetGameObjectShow(self.view.twoConnect, false)
	LuaUtility.SetGameObjectShow(self.view.threeConnect, false)

	local len = #self.currentOpenNode

	if len == 2 then
		if self:_CheckState(two_state1) then
			LuaUtility.SetGameObjectShow(self.view.twoConnect, true)
			LuaUtility.SetRotationWithTransform(self.view.twoConnect.transform, 0, 0, 0)
		elseif self:_CheckState(two_state2) then
			LuaUtility.SetGameObjectShow(self.view.twoConnect, true)
			LuaUtility.SetRotationWithTransform(self.view.twoConnect.transform, 0, 0, -90)
		elseif self:_CheckState(two_state3) then
			LuaUtility.SetGameObjectShow(self.view.twoConnect, true)
			LuaUtility.SetRotationWithTransform(self.view.twoConnect.transform, 0, 0, -180)
		elseif self:_CheckState(two_state4) then
			LuaUtility.SetGameObjectShow(self.view.twoConnect, true)
			LuaUtility.SetRotationWithTransform(self.view.twoConnect.transform, 0, 0, -270)
		end
	elseif len == 3 then
		if self:_CheckState(three_State1) then
			LuaUtility.SetGameObjectShow(self.view.threeConnect, true)
			LuaUtility.SetRotationWithTransform(self.view.twoConnect.transform, 0, 0, 0)
		elseif self:_CheckState(three_State2) then
			LuaUtility.SetGameObjectShow(self.view.threeConnect, true)
			LuaUtility.SetRotationWithTransform(self.view.twoConnect.transform, 0, 0, -90)
		elseif self:_CheckState(three_State3) then
			LuaUtility.SetGameObjectShow(self.view.threeConnect, true)
			LuaUtility.SetRotationWithTransform(self.view.twoConnect.transform, 0, 0, -180)
		elseif self:_CheckState(three_State4) then
			LuaUtility.SetGameObjectShow(self.view.threeConnect, true)
			LuaUtility.SetRotationWithTransform(self.view.twoConnect.transform, 0, 0, -270)
		end
	end
end

function LoopMapConvertCell:_CheckState(state)
	local map = {}
	local len = #state

	for i = 1, len do
		map[state[i]] = 1
	end

	len = #self.currentOpenNode

	for i = 1, len do
		if map[self.currentOpenNode[i]] then
			map[self.currentOpenNode[i]] = nil
		end
	end

	len = getTableLength(map)

	return len <= 0
end

return LoopMapConvertCell
