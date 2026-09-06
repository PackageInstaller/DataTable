-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationNameRegexProcess.lua

module("logic.extensions.formation.view.FormationNameRegexProcess", package.seeall)

local Regex = System.Text.RegularExpressions.Regex
local FormationNameRegexProcess = class("FormationNameRegexProcess")

function FormationNameRegexProcess:init(pattern)
	self._regex = Regex.New(pattern)
end

function FormationNameRegexProcess:isMatch(input)
	return self._regex:IsMatch(input)
end

function FormationNameRegexProcess:getMatchInput(input)
	local strTable = StringUtil.utf8split(input)
	local resultInput = ""

	for k, v in pairs(strTable) do
		if self._regex:IsMatch(v) then
			resultInput = resultInput .. v
		end
	end

	return resultInput
end

function FormationNameRegexProcess:clampStringAvailableLength(input, maxLength)
	local strTable = StringUtil.utf8split(input)
	local resultStr = ""
	local curlength = 0

	for k, v in pairs(strTable) do
		curlength = string.len(v) > 1 and curlength + 3 or string.find(v, "%u") and curlength + 3 or curlength + 2

		if curlength <= maxLength then
			resultStr = resultStr .. v
		else
			break
		end
	end

	return resultStr
end

return FormationNameRegexProcess
