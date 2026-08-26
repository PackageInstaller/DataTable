-- chunkname: @modules/common/utils/StringExtend.lua

module("modules.common.utils.StringExtend", package.seeall)

local StringExtend = StringExtend

function StringExtend.activateExtend()
	return
end

if isDebugBuild then
	local srcSplit = string.split

	function string.split(input, delimiter)
		if GameUtil.needLogInFightSceneUseStringFunc() then
			logError("战斗场景中不要用`string.split`, 用`FightStrUtil.getSplitCache`代替")
		end

		return srcSplit(input, delimiter)
	end

	local srcSplitToNumber = string.splitToNumber

	function string.splitToNumber(input, delimiter)
		if GameUtil.needLogInFightSceneUseStringFunc() then
			logError("战斗场景中不要用`string.splitToNumber`, 用`FightStrUtil.getSplitToNumberCache`代替")
		end

		return srcSplitToNumber(input, delimiter)
	end
end

function string.delBracketContent(input)
	input = string.gsub(input, "%b()", "")
	input = string.gsub(input, "（.-）", "")

	return input
end

return StringExtend
