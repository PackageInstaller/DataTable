-- chunkname: @IQIGame\\UI\\ExploreHall\\SpaceTreasureBtnController.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.ButtonText, ExploreHallUIApi:GetString("SpaceTreasureBtnText"))
	UGUIUtil.SetText(self.ButtonEnText, ExploreHallUIApi:GetString("SpaceTreasureBtnEnText"))
end

function m:Refresh()
	local isUnlock = UnlockFunctionModule.IsUnlock(Constant.UnlockType.SPACE_TREASURE)

	self.View:SetActive(isUnlock)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
