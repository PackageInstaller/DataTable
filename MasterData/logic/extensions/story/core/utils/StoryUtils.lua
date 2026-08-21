-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/utils/StoryUtils.lua

module("logic.extensions.story.core.utils.StoryUtils", package.seeall)

function ResetTransform(target)
	if goutil.isNil(target) then
		return
	end

	GameUtils.setLocalPos(target, 0, 0, 0)
	GameUtils.setLocalRotation(target, 0, 0, 0)
	GameUtils.setLocalScale(target, 1, 1, 1)
end

function ParseNumber(value)
	if GameUtils.isEmptyString(value) then
		return 0
	end

	return tonumber(value) or 0
end

function ParseBoolean(value)
	if value == "True" or value == "TRUE" or value == "true" or value == "1" then
		return true
	end

	return false
end

function ParseVector2(val)
	if GameUtils.isEmptyString(val) then
		return nil
	end

	local splitArr = string.split(val, ",")

	if splitArr and #splitArr >= 2 then
		return Vector2.New(tonumber(splitArr[1]), tonumber(splitArr[2]))
	end

	return nil
end

function ParseVector3(val)
	if GameUtils.isEmptyString(val) then
		return nil
	end

	local splitArr = string.split(val, ",")

	if splitArr and #splitArr >= 3 then
		return Vector3.New(tonumber(splitArr[1]), tonumber(splitArr[2]), tonumber(splitArr[3]))
	end

	return nil
end

function ParseVector4(val)
	if GameUtils.isEmptyString(val) then
		return nil
	end

	local splitArr = string.split(val, ",")

	if splitArr and #splitArr >= 4 then
		return Vector4.New(tonumber(splitArr[1]), tonumber(splitArr[2]), tonumber(splitArr[3]), tonumber(splitArr[4]))
	end

	return nil
end

function GetVector4String(val)
	return val.x .. "," .. val.y .. "," .. val.z .. "," .. val.w
end

function GetVector3String(val)
	return val.x .. "," .. val.y .. "," .. val.z
end

function GetVector2String(val)
	return val.x .. "," .. val.y
end

function GetRealTextAlign(alignment)
	if StoryConstDef.StoryAlignType.Left == alignment then
		return TMPro.TextAlignmentOptions.MidlineLeft
	elseif StoryConstDef.StoryAlignType.Middle == alignment then
		return TMPro.TextAlignmentOptions.Center
	elseif StoryConstDef.StoryAlignType.Right == alignment then
		return TMPro.TextAlignmentOptions.MidlineRight
	end

	return TMPro.TextAlignmentOptions.Center
end

function shakeGo(targetGo, shakeCode, time)
	local shakeCO = CameraShakeConfig.instance:getCameraShakeCO(shakeCode)
	local shakeComp = goutil.addComponentOnce(targetGo.gameObject, typeof(UIShakeEffect))

	shakeComp:Clear()

	if shakeCO then
		shakeComp:ShakeUI(time or shakeCO.lifeTime, shakeCO.magnitude, shakeCO.shakeMode - 1, shakeCO.decreaseRate)
	end
end

function stopShakeGo(targetGo)
	local shakeComp = goutil.addComponentOnce(targetGo.gameObject, typeof(UIShakeEffect))

	if shakeComp then
		shakeComp:Clear()
	end
end

function parseStoryText(text)
	if string.nilorempty(text) then
		return ""
	end

	local content = text

	content = StoryUtils.replaceAllRed(text)
	content = StringUtil.replaceAllSup(content)
	content = StoryUtils.replaceUserNameFlag(content)

	return content
end

function replaceAllRed(text)
	return string.gsub(text, "&(.-)&", "<#ff3e48>%1</color>")
end

function removeAllRed(text)
	return string.gsub(text, "&(.-)&", "%1")
end

function replaceUserNameFlag(content)
	if string.nilorempty(content) then
		return content
	end

	local _name = PlayerModel.instance:getNickName()

	if string.nilorempty(_name) then
		_name = "[玩家昵称]"
	end

	local _newStr = string.gsub(content, "{username}", _name)

	return _newStr
end
