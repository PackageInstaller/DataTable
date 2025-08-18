-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\CueDataBank.lua

local DataPath = "ClientData/CueData/"
local CueDataBank = {}
local CueData = {}
local DataVirtualPath = "ClientData.CueData."

function CueDataBank.initCueData(cueFile)
	if cueFile and cueFile ~= "" then
		local fullDataPath = DataPath .. CueDataBank._getRealFile(cueFile)
		local actorCueData = require(fullDataPath)

		if actorCueData ~= nil then
			for k, v in pairs(actorCueData) do
				CueData[k] = v
			end

			return true
		else
			return false
		end
	end
end

function CueDataBank._getRealFile(cueFile)
	return cueFile
end

function CueDataBank.refreshData(cueFile)
	if cueFile then
		package.loaded[DataVirtualPath .. CueDataBank._getRealFile(cueFile)] = nil

		CueDataBank.initCueData(cueFile)
	end

	package.loaded[DataVirtualPath .. CueDataBank._getRealFile("Common")] = nil

	CueDataBank.initCueData("Common")
end

function CueDataBank.clearCueData()
	CueData = {}
end

function CueDataBank.getCueData(cueId)
	if CueData[cueId] == nil then
		return
	end

	return CueData[cueId]
end

return CueDataBank
