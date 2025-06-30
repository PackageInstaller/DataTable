-- chunkname: @IQIGame\\UI\\ExploreHall\\EndlessMazeBtnController.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	local label1, label2 = ExploreHallUIApi:GetString("EndlessMazeLabel")

	UGUIUtil.SetText(self.EndlessMazeLabel1, label1)
	UGUIUtil.SetText(self.EndlessMazeLabel2, label2)
	UGUIUtil.SetTextInChildren(self.ExploringView, ExploreHallUIApi:GetString("ExploringViewText"))
end

function m:SetData(isUnlock, unfinishedMazeCid)
	self.View:SetActive(isUnlock)

	if not isUnlock then
		return
	end

	self.ExploringView:SetActive(unfinishedMazeCid ~= nil)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
