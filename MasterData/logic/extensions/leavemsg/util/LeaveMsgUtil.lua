-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/util/LeaveMsgUtil.lua

module("logic.extensions.leavemsg.util.LeaveMsgUtil", package.seeall)

local LeaveMsgUtil = {}

function LeaveMsgUtil.getMsgRelaceMark(typeEnum)
	if typeEnum == GameEnum.AirMsgTextEnum.Phrase then
		return string.format("<color=#BABABA>%s</color> %%s", "主体")
	elseif typeEnum == GameEnum.AirMsgTextEnum.Joiner then
		return string.format("<color=#BABABA>%s</color>", "连词")
	elseif typeEnum == GameEnum.AirMsgTextEnum.Word then
		return string.format("<color=#BABABA>%s</color>", "词汇")
	end
end

function LeaveMsgUtil.getSubjectNeedWorkCount(id)
	local needWordCount = 0

	if id > 0 then
		local co = AirWorkShopConfig.instance:getMsgCO(LeaveMsgEnum.MsgPartType.Subject, id)

		needWordCount = co.needWordCount
	end

	return needWordCount
end

function LeaveMsgUtil.TransSingleMsgData2Str(subjectId, wordIds, withJoiner, joinerId, colorStr, colorMsgTyp, emptyMarkColor)
	if string.nilorempty(colorStr) then
		colorMsgTyp = nil
	end

	local msgTypEnum = GameEnum.AirMsgTextEnum
	local needWordCount = 0
	local subject
	local wordLst = {}
	local coSubject = AirWorkShopConfig.instance:getMsgCO(msgTypEnum.Phrase, subjectId or -1)

	subject = coSubject.content

	if coSubject.id == -1 and not string.nilorempty(emptyMarkColor) then
		subject = string.format(LeaveMsgEnum.EmptyMarkEditColor, emptyMarkColor, emptyMarkColor)
	end

	needWordCount = coSubject.needWordCount

	for _, _wordId in ipairs(wordIds or {}) do
		local searchId = _wordId or -1
		local coWord = AirWorkShopConfig.instance:getMsgCO(msgTypEnum.Word, searchId)
		local content = coWord.content

		if searchId == -1 and not string.nilorempty(emptyMarkColor) then
			content = string.format(LeaveMsgEnum.EmptyMarkEditColor, emptyMarkColor, emptyMarkColor)
		end

		if colorMsgTyp == LeaveMsgEnum.MsgPartType.Word then
			table.insert(wordLst, string.format("<color=%s>%s</color>", colorStr, content))
		else
			table.insert(wordLst, content)
		end
	end

	for i = 1, needWordCount do
		if not wordLst[i] then
			local coWord = AirWorkShopConfig.instance:getMsgCO(msgTypEnum.Word, -1)
			local content = coWord.content

			if not string.nilorempty(emptyMarkColor) then
				content = string.format(LeaveMsgEnum.EmptyMarkEditColor, emptyMarkColor, emptyMarkColor)
			end

			table.insert(wordLst, content)
		end
	end

	local resultStr

	if needWordCount > 0 then
		if colorMsgTyp == LeaveMsgEnum.MsgPartType.Subject then
			resultStr = string.format("<color=%s>", colorStr) .. subject .. "</color>"
			resultStr = string.format(resultStr, unpack(wordLst))
		else
			resultStr = string.format(subject, unpack(wordLst))
		end
	elseif colorMsgTyp == LeaveMsgEnum.MsgPartType.Subject then
		resultStr = string.format("<color=%s>%s</color>", colorStr, subject)
	else
		resultStr = subject
	end

	if withJoiner then
		local searchId = joinerId or -1
		local coJoiner = AirWorkShopConfig.instance:getMsgCO(msgTypEnum.Joiner, searchId)
		local joinerStr = coJoiner.content

		if searchId == -1 and not string.nilorempty(emptyMarkColor) then
			joinerStr = string.format(LeaveMsgEnum.EmptyMarkEditColor, emptyMarkColor, emptyMarkColor)
		end

		if colorMsgTyp == LeaveMsgEnum.MsgPartType.Joiner then
			resultStr = string.format("<color=%s>%s</color> %s", colorStr, joinerStr, resultStr)
		else
			resultStr = string.format("%s %s", joinerStr, resultStr)
		end
	end

	return resultStr
end

return LeaveMsgUtil
