-- chunkname: @modules/logic/necrologiststory/common/NecrologistStoryHelper.lua

module("modules.logic.necrologiststory.common.NecrologistStoryHelper", package.seeall)

local NecrologistStoryHelper = class("NecrologistStoryHelper")

NecrologistStoryHelper.EmptyString = ""

function NecrologistStoryHelper.addHyperLinkClick(textComp, clickCallback, clickCallbackObj)
	if gohelper.isNil(textComp) then
		logError("textComp is nil, please check !!!")

		return
	end

	local hyperLinkClick = gohelper.onceAddComponent(textComp, typeof(ZProj.TMPHyperLinkClick))

	hyperLinkClick:SetClickListener(clickCallback or NecrologistStoryHelper.defaultClick, clickCallbackObj)
end

function NecrologistStoryHelper.defaultClick(linkId, clickPosition)
	NecrologistStoryController.instance:openTipView(linkId, clickPosition)
end

function NecrologistStoryHelper.getDesc(storyId, bracketColor)
	local config = NecrologistStoryConfig.instance:getStoryConfig(storyId)

	return NecrologistStoryHelper.getDescByConfig(config, bracketColor)
end

function NecrologistStoryHelper.getDescByConfig(storyConfig, bracketColor)
	local desc = storyConfig.desc

	return NecrologistStoryHelper.buildDesc(desc, bracketColor)
end

function NecrologistStoryHelper.buildDesc(desc, bracketColor)
	desc = NecrologistStoryHelper.addColor(desc, bracketColor)

	local var_5_0, var_5_1 = NecrologistStoryHelper.addLink(desc)

	desc = var_5_0

	return var_5_0, var_5_1
end

function NecrologistStoryHelper.addLink(desc)
	local result = string.gsub(desc, "%[(.-)%]", NecrologistStoryHelper._replaceDescTagFunc)

	result = string.gsub(result, "【(.-)】", NecrologistStoryHelper._replaceDescTagFunc)

	local hasLink = string.find(result, "<link=") ~= nil

	return result, hasLink
end

function NecrologistStoryHelper._replaceDescTagFunc(name)
	name = NecrologistStoryHelper.removeRichTag(name)

	local introduceId = tonumber(name)
	local co = NecrologistStoryConfig.instance:getIntroduceCo(introduceId) or NecrologistStoryConfig.instance:getIntroduceCoByName(name)

	if not co then
		return name
	end

	name = co.name

	if not co.notAddLink or co.notAddLink == 0 then
		return string.format("<u><link=%s>%s</link></u>", co.id, name)
	end

	return name
end

function NecrologistStoryHelper.removeRichTag(name)
	return string.gsub(name, "<.->", "")
end

function NecrologistStoryHelper.loadSituationFunc(situation)
	local condition = string.format("return %s", situation)
	local func, err = loadstring(condition)

	if not func then
		logError(string.format("条件表达式错误 表达式:%s error:%s", situation, err))
	end

	return func
end

function NecrologistStoryHelper.addColor(desc, bracketColor)
	desc = NecrologistStoryHelper.addBracketColor(desc, bracketColor)

	return desc
end

function NecrologistStoryHelper.addBracketColor(desc, bracketColor)
	if string.nilorempty(bracketColor) then
		bracketColor = "#AE5D30"
	end

	local bracketColorFormat = NecrologistStoryHelper.getColorFormat(bracketColor, "%1")

	desc = string.gsub(desc, "%[.-%]", bracketColorFormat)
	desc = string.gsub(desc, "【.-】", bracketColorFormat)

	return desc
end

function NecrologistStoryHelper.getColorFormat(color, text)
	return string.format("<color=%s>%s</color>", color, text)
end

function NecrologistStoryHelper.getTimeFormat(time)
	local hour = math.floor(time)
	local minute = math.floor((time - hour) * 60)
	local period = hour >= 12 and "PM" or "AM"
	local displayHour = hour % 12

	if displayHour == 0 then
		displayHour = 12
	end

	return displayHour, minute, period
end

function NecrologistStoryHelper.getTimeFormat2(time)
	local hour = math.floor(time)
	local minute = math.floor((time - hour) * 60)
	local displayHour = hour % 24

	return displayHour, minute
end

NecrologistStoryHelper.DialogNameTag = "{roleName}"

function NecrologistStoryHelper.getDialogName(storyConfig)
	local name = storyConfig.name

	if string.match(name, NecrologistStoryHelper.DialogNameTag) then
		local storyGroupConfig = NecrologistStoryConfig.instance:getPlotGroupCo(storyConfig.storygroup)

		return true, string.gsub(name, NecrologistStoryHelper.DialogNameTag, storyGroupConfig.roleName)
	end

	return false, name
end

function NecrologistStoryHelper.checkDragDirection(startPos, endPos, checkDir)
	local dragDeltaX = endPos.x - startPos.x
	local dragDeltaY = endPos.y - startPos.y

	if checkDir == NecrologistStoryEnum.DirType.Left then
		return dragDeltaX < 0
	elseif checkDir == NecrologistStoryEnum.DirType.Right then
		return dragDeltaX > 0
	elseif checkDir == NecrologistStoryEnum.DirType.Top then
		return dragDeltaY > 0
	elseif checkDir == NecrologistStoryEnum.DirType.Bottom then
		return dragDeltaY < 0
	end

	return true
end

function NecrologistStoryHelper.getPlotRoleStoryId(plotId)
	local config = NecrologistStoryConfig.instance:getStoryConfig(plotId)
	local storyGroupConfig = NecrologistStoryConfig.instance:getPlotGroupCo(config.storygroup)

	return storyGroupConfig.storyId
end

function NecrologistStoryHelper.calculateLinksRectData(tmpText)
	local list = {}
	local textTransform = tmpText.transform
	local linkInfoList = tmpText.textInfo.linkInfo
	local characterInfoList = tmpText.textInfo.characterInfo
	local camera = CameraMgr.instance:getUICamera()
	local bl, tr
	local iter = linkInfoList:GetEnumerator()

	while iter:MoveNext() do
		local linkInfo = iter.Current
		local answerIndex = tonumber(linkInfo:GetLinkID())
		local firstCharInfo = characterInfoList[linkInfo.linkTextfirstCharacterIndex]

		bl = textTransform:TransformPoint(Vector3.New(firstCharInfo.bottomLeft.x, firstCharInfo.descender, 0))

		if linkInfo.linkTextLength == 1 then
			tr = textTransform:TransformPoint(Vector3.New(firstCharInfo.topRight.x, firstCharInfo.ascender, 0))

			local centerPos, width, height = NecrologistStoryHelper.getCenterPosAndSize(bl, tr, tmpText, camera)

			table.insert(list, {
				centerPos,
				width,
				height,
				answerIndex
			})
		elseif linkInfo.linkTextLength > 1 then
			local lastCharInfo = characterInfoList[linkInfo.linkTextfirstCharacterIndex + linkInfo.linkTextLength - 1]

			if firstCharInfo.lineNumber == lastCharInfo.lineNumber then
				tr = textTransform:TransformPoint(Vector3.New(lastCharInfo.topRight.x, lastCharInfo.ascender, 0))

				local centerPos, width, height = NecrologistStoryHelper.getCenterPosAndSize(bl, tr, tmpText, camera)

				table.insert(list, {
					centerPos,
					width,
					height,
					answerIndex
				})
			else
				tr = textTransform:TransformPoint(Vector3.New(firstCharInfo.topRight.x, firstCharInfo.ascender, 0))

				local startLineNumber = firstCharInfo.lineNumber

				for i = 1, linkInfo.linkTextLength - 1 do
					local characterIndex = linkInfo.linkTextfirstCharacterIndex + i
					local tmpCharInfo = characterInfoList[characterIndex]
					local currentLineNumber = tmpCharInfo.lineNumber

					if currentLineNumber == startLineNumber then
						tr = textTransform:TransformPoint(Vector3.New(tmpCharInfo.topRight.x, tmpCharInfo.ascender, 0))
					else
						local centerPos, width, height = NecrologistStoryHelper.getCenterPosAndSize(bl, tr, tmpText, camera)

						table.insert(list, {
							centerPos,
							width,
							height,
							answerIndex
						})

						startLineNumber = currentLineNumber
						bl = textTransform:TransformPoint(Vector3.New(tmpCharInfo.bottomLeft.x, tmpCharInfo.descender, 0))
						tr = textTransform:TransformPoint(Vector3.New(tmpCharInfo.topRight.x, tmpCharInfo.ascender, 0))
					end
				end

				local centerPos, width, height = NecrologistStoryHelper.getCenterPosAndSize(bl, tr, tmpText, camera)

				table.insert(list, {
					centerPos,
					width,
					height,
					answerIndex
				})
			end
		end
	end

	return list
end

function NecrologistStoryHelper.getCenterPosAndSize(bl, tr, tmpText, camera)
	local blPos = recthelper.worldPosToAnchorPos(bl, tmpText.transform, camera, camera)
	local trPos = recthelper.worldPosToAnchorPos(tr, tmpText.transform, camera, camera)
	local centerPos = (blPos + trPos) * 0.5
	local width = trPos.x - blPos.x
	local height = trPos.y - blPos.y

	return centerPos, width, height
end

function NecrologistStoryHelper.getOptionDesc(optionData, isFinish)
	local isEnding = optionData.isEnding

	if isEnding then
		return (isFinish or nil) and (optionData.endingCo.name or NecrologistStoryHelper.EmptyString)
	end

	local optionDescs = string.split(NecrologistStoryHelper.getDescByConfig(optionData.config), "#")

	return optionDescs[optionData.index] or NecrologistStoryHelper.EmptyString
end

function NecrologistStoryHelper.setWeatherIcon(imgWeather, weather, setNativeSize)
	if not imgWeather then
		return
	end

	if not weather or weather == 0 then
		gohelper.setActive(imgWeather, false)

		return
	end

	gohelper.setActive(imgWeather, true)

	local resIndex = NecrologistStoryEnum.WeatherType2ResIndex[weather]
	local icon = string.format("rolestory_weather%s", resIndex)

	UISpriteSetMgr.instance:setRoleStorySprite(imgWeather, icon, setNativeSize)
end

function NecrologistStoryHelper.setWeatherWihteIcon(imgWeather, weather, setNativeSize)
	if not imgWeather then
		return
	end

	if not weather or weather == 0 then
		gohelper.setActive(imgWeather, false)

		return
	end

	gohelper.setActive(imgWeather, true)

	local resIndex = NecrologistStoryEnum.WeatherType2ResIndex[weather]
	local icon = string.format("rolestory_weather%s_1", resIndex)

	UISpriteSetMgr.instance:setRoleStorySprite(imgWeather, icon, setNativeSize)
end

function NecrologistStoryHelper.setWeatherTxt(txtWeather, weather)
	if not txtWeather then
		return
	end

	if not weather or weather == 0 then
		return
	end

	local resIndex = NecrologistStoryEnum.WeatherType2ResIndex[weather]

	txtWeather.text = luaLang(string.format("necrologiststory_weather_%s", resIndex))
end

function NecrologistStoryHelper.stringTotimeData(str)
	if string.nilorempty(str) then
		return
	end

	local _, _, y, m1, d = string.find(str, "(%d+)-(%d+)-(%d+)")

	return true, y, m1, d
end

function NecrologistStoryHelper.getStoryGroupIndex(storyGroup)
	return storyGroup % 100
end

function NecrologistStoryHelper.getTimeStrByConfig(config)
	if not string.nilorempty(config.date) then
		return config.date
	end

	local displayHour, minute = NecrologistStoryHelper.getTimeFormat2(config.time)

	return (string.format("%d:%02d", displayHour, minute))
end

function NecrologistStoryHelper.parseEventParam(eventId, param)
	local data = {}

	if eventId == NecrologistStoryEvent.PlotChangePic then
		data.storyId = tonumber(param[1])
		data.picRes = param[2]
	end

	return data
end

function NecrologistStoryHelper.getUCharArr(ucharStr)
	local ret = {}

	if LuaUtil.isEmptyStr(ucharStr) then
		return ret
	end

	local len = #ucharStr
	local validTag = {}
	local stack = {}
	local i = 1

	while i <= len do
		if string.sub(ucharStr, i, i) == "<" then
			local tagEnd = string.find(ucharStr, ">", i)

			if not tagEnd then
				i = i + 1
			else
				local tag = string.sub(ucharStr, i, tagEnd)

				if string.find(tag, "/>", 1, true) then
					validTag[i] = tagEnd
					i = tagEnd + 1
				else
					local closeName = string.match(tag, "^</(%w+)")

					if closeName then
						local matchedIdx

						for j = #stack, 1, -1 do
							if stack[j].name == closeName then
								matchedIdx = j

								break
							end
						end

						if matchedIdx then
							local m = stack[matchedIdx]

							table.remove(stack, matchedIdx)

							validTag[m.startPos] = m.endPos
							validTag[i] = tagEnd
						end

						i = tagEnd + 1
					else
						local openName = string.match(tag, "^<(%w+)")

						if openName then
							table.insert(stack, {
								name = openName,
								startPos = i,
								endPos = tagEnd
							})

							i = tagEnd + 1
						else
							i = i + 1
						end
					end
				end
			end
		else
			i = i + 1
		end
	end

	local i = 1

	while i <= len do
		if string.sub(ucharStr, i, i) == "<" and validTag[i] then
			local tagEnd = validTag[i]

			table.insert(ret, string.sub(ucharStr, i, tagEnd))

			i = tagEnd + 1
		else
			local b = string.byte(ucharStr, i)
			local charLen = 1

			if b and b > 127 then
				if b >= 194 and b <= 223 then
					charLen = 2
				elseif b >= 224 and b <= 239 then
					charLen = 3
				elseif b >= 240 and b <= 244 then
					charLen = 4
				end
			end

			table.insert(ret, string.sub(ucharStr, i, i + charLen - 1))

			i = i + charLen
		end
	end

	return ret
end

function NecrologistStoryHelper.getEachCharWithTags(charList)
	local result = {}
	local tagStack = {}

	for i = 1, #charList do
		local seg = charList[i]

		if string.sub(seg, 1, 1) == "<" then
			local closeName = string.match(seg, "^</(%w+)")

			if closeName then
				for j = #tagStack, 1, -1 do
					if tagStack[j].name == closeName then
						table.remove(tagStack, j)

						break
					end
				end
			elseif not string.find(seg, "/>", 1, true) then
				local openName = string.match(seg, "^<(%w+)")

				if openName then
					table.insert(tagStack, {
						name = openName,
						raw = seg
					})
				else
					result[#result + 1] = {
						char = seg,
						wrapped = NecrologistStoryHelper.wrapChar(seg, tagStack)
					}
				end
			end
		else
			result[#result + 1] = {
				char = seg,
				wrapped = NecrologistStoryHelper.wrapChar(seg, tagStack)
			}
		end
	end

	return result
end

function NecrologistStoryHelper.wrapChar(ch, tagStack)
	local n = #tagStack

	if n == 0 then
		return ch
	end

	local sb = {}

	for j = 1, n do
		sb[#sb + 1] = tagStack[j].raw
	end

	sb[#sb + 1] = ch

	for j = n, 1, -1 do
		sb[#sb + 1] = "</" .. tagStack[j].name .. ">"
	end

	return table.concat(sb)
end

return NecrologistStoryHelper
