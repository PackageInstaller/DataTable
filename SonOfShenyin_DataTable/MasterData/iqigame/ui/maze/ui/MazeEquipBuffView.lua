-- chunkname: @IQIGame\\UI\\Maze\\UI\\MazeEquipBuffView.lua

local mazeEquipBuffItem = require("IQIGame.UI.Maze.UI.MazeEquipBuffItem")
local m = {
	MazeEquipBuffList = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData()
	local allbuffCfgs = MazeModule.GetGemBuffCfgs()

	for i = 1, #allbuffCfgs do
		if self.MazeEquipBuffList[i] == nil then
			local obj = GameObject.Instantiate(self.buffPrefab)

			LuaUtility.SetGameObjectShow(obj, true)
			obj.transform:SetParent(self.buffContent.transform, false)

			local mazeEquipBuffItemView = mazeEquipBuffItem.New(obj)

			self.MazeEquipBuffList[i] = mazeEquipBuffItemView
		end

		self.MazeEquipBuffList[i]:SetData(allbuffCfgs[i])
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	for k, v in pairs(self.MazeEquipBuffList) do
		v:Dispose()
	end

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
