-- chunkname: @IQIGame\\Module\\DualTeamExplore\\Command\\DTEOpenDialogCommand.lua

local m = {
	DialogCid = 0
}

m = extend(DualTeamExploreBaseCommand, m)

function m.New(dialogCid)
	local obj = Clone(m)

	obj:Init(dialogCid)

	return obj
end

function m:Init(dialogCid)
	self.DialogCid = dialogCid
end

function m.Type()
	return "DTEOpenDialogCommand"
end

DTEOpenDialogCommand = m
