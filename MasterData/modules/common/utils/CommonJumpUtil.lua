-- chunkname: @modules/common/utils/CommonJumpUtil.lua

module("modules.common.utils.CommonJumpUtil", package.seeall)

local CommonJumpUtil = _M

function CommonJumpUtil._enterMainScene(param)
	logError("enter main scene " .. cjson.encode(param))
end

function CommonJumpUtil._jumpSpecial(param)
	logError("jump special " .. cjson.encode(param))
end

function CommonJumpUtil._openSpecialView(param)
	logError("open special view " .. cjson.encode(param))
end

CommonJumpUtil.JumpTypeSpecialFunc = {
	special = CommonJumpUtil._jumpSpecial
}
CommonJumpUtil.JumpViewSpecialFunc = {
	["view#special"] = CommonJumpUtil._openSpecialView
}
CommonJumpUtil.JumpSceneFunc = {
	["scene#main"] = CommonJumpUtil._enterMainScene
}
CommonJumpUtil.JumpSeparator = "#"
CommonJumpUtil.JumpType = {
	View = "view",
	Scene = "scene"
}

function CommonJumpUtil.jump(jumpString)
	if string.nilorempty(jumpString) then
		return
	end

	local jumpStringSplitArr = string.split(jumpString, CommonJumpUtil.JumpSeparator)
	local jumpType = string.trim(jumpStringSplitArr[1])
	local specialJumpTypeFunc = CommonJumpUtil.JumpTypeSpecialFunc[jumpType]

	if specialJumpTypeFunc then
		local param = CommonJumpUtil._deserializeParams(jumpStringSplitArr, 2)

		specialJumpTypeFunc(param)
	elseif jumpType == CommonJumpUtil.JumpType.View then
		local param = CommonJumpUtil._deserializeParams(jumpStringSplitArr, 3)
		local viewName = string.trim(jumpStringSplitArr[2])
		local specialKey = CommonJumpUtil.JumpType.View .. CommonJumpUtil.JumpSeparator .. viewName
		local specialViewFunc = CommonJumpUtil.JumpViewSpecialFunc[specialKey]

		if specialViewFunc then
			specialViewFunc(param)
		else
			ViewMgr.instance:openView(viewName, param)
		end
	elseif jumpType == CommonJumpUtil.JumpType.Scene then
		local sceneName = string.trim(jumpStringSplitArr[2])
		local specialKey = CommonJumpUtil.JumpType.Scene .. CommonJumpUtil.JumpSeparator .. sceneName
		local jumpSceneFunc = CommonJumpUtil.JumpSceneFunc[specialKey]

		if jumpSceneFunc then
			local param = CommonJumpUtil._deserializeParams(jumpStringSplitArr, 3)

			jumpSceneFunc(param)
		else
			logError("jumpType scene invalid: " .. jumpString)
		end
	else
		logError("jumpType invalid: " .. jumpString)
	end
end

function CommonJumpUtil._deserializeParams(jumpStringSplitArr, index)
	local spCount = #jumpStringSplitArr

	if spCount < index then
		return nil
	end

	local jsonStr = jumpStringSplitArr[spCount]

	if index < spCount then
		local temp = {}

		for i = index, spCount do
			table.insert(temp, jumpStringSplitArr[i])
		end

		jsonStr = table.concat(temp, CommonJumpUtil.JumpSeparator)
	end

	return cjson.decode(jsonStr)
end

return CommonJumpUtil
