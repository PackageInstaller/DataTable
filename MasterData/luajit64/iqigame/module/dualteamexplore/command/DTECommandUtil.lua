-- chunkname: @IQIGame\\Module\\DualTeamExplore\\Command\\DTECommandUtil.lua

DTECommandUtil = {}

function DTECommandUtil.GetEventID(command)
	if command == nil then
		logError("command == nil, 请确定传入了正确的参数，且在DTERequireCommand.lua文件里require了该Command")

		return nil
	end

	local type = command.Type()

	if type == DualTeamExploreBaseCommand.BASE_TYPE_NAME then
		logError("Command必须继承DualTeamExploreBaseCommand，且重写Type方法")

		return nil
	end

	return "DualTeamExploreEvent__" .. type
end
