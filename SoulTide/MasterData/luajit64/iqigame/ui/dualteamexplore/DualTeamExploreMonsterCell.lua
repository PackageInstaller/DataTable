-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamExploreMonsterCell.lua

local MonsterHeadCell = require("IQIGame.UI.Common.MonsterHeadCell")
local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.MonsterHeadCell = MonsterHeadCell.__New(self.MonsterHeadCellGO)
end

function m:SetData(monsterCid, positionType)
	self.MonsterHeadCell:SetData(monsterCid, positionType)
end

function m:Dispose()
	self.MonsterHeadCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
