-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/model/LeaveMsgMO.lua

module("logic.extensions.leavemsg.model.LeaveMsgMO", package.seeall)

local M = class("LeaveMsgMO")

function M:ctor(dataNO)
	if dataNO then
		self:updateFromMessageCompositeNO(dataNO)
	else
		self:clear()
	end
end

function M:dispatchCurPreview()
	GlobalDispatcher:dispatchEvent(LeaveMsgEventType.ON_EDIT_ALL_PREVIEW, self:getAllParagraphFinish(), self:getPreviewMsg(), self:getEmoji())
end

function M:updateFromMessageCompositeNO(dataNO)
	self:clear()

	for _, MessagePartNO in ipairs(dataNO.textPart or {}) do
		local index = #self._msg.paragraph
		local type = MessagePartNO.type
		local id = MessagePartNO.id

		if type == GameEnum.AirMsgTextEnum.Phrase then
			self._msg.paragraph[index][type] = id
		elseif type == GameEnum.AirMsgTextEnum.Word then
			table.insert(self._msg.paragraph[index][type], id)
		elseif type == GameEnum.AirMsgTextEnum.Joiner then
			local newParagraph = self:_newParagraph()

			newParagraph[LeaveMsgEnum.MsgPartType.Joiner] = id
			self._msg.paragraph[index + 1] = newParagraph
		end
	end

	self._msg[LeaveMsgEnum.MsgPartType.Emoji] = dataNO.emoji or -1

	local voice = dataNO.voice or -1

	self._msg[LeaveMsgEnum.MsgPartType.VoiceHero] = voice > 0 and math.floor(voice / 1000) or voice
	self._msg[LeaveMsgEnum.MsgPartType.VoiceHeroRes] = voice
	self._pageType = self:_getPreviewMsgPageType()
end

function M:trans2MessageCompositeNO(msgMO)
	local pageType = self:getPageType()
	local messageCompositeNO = msgMO and msgMO or BattleExtension_pb.MessageCompositeNO()
	local emoji = self:getEmoji()

	if emoji > 0 then
		messageCompositeNO.emoji = emoji
	end

	if pageType == LeaveMsgEnum.MsgType.Voice then
		local voice = self:getVoice()

		if voice and voice > 0 then
			messageCompositeNO.voice = voice
		end
	elseif pageType == LeaveMsgEnum.MsgType.Word and self:getPageAllFinish(pageType, false) then
		local typeLst = {
			LeaveMsgEnum.MsgPartType.Joiner,
			LeaveMsgEnum.MsgPartType.Subject,
			LeaveMsgEnum.MsgPartType.Word
		}

		for i = 1, #self._msg.paragraph do
			local data = self._msg.paragraph[i]

			for _, _type in ipairs(typeLst) do
				if _type == LeaveMsgEnum.MsgPartType.Word then
					for _, id in ipairs(data[_type] or {}) do
						if id > 0 then
							local messagePartNO = BattleExtension_pb.MessagePartNO()

							messagePartNO.type = LeaveMsgEnum.MsgPart2AirMsgEnum[_type]
							messagePartNO.id = id

							table.insert(messageCompositeNO.textPart, messagePartNO)
						end
					end
				else
					local id = data[_type]

					if id > 0 then
						local messagePartNO = BattleExtension_pb.MessagePartNO()

						messagePartNO.type = LeaveMsgEnum.MsgPart2AirMsgEnum[_type]
						messagePartNO.id = id

						table.insert(messageCompositeNO.textPart, messagePartNO)
					end
				end
			end
		end
	end

	return messageCompositeNO
end

function M:getAllParagraphFinish(canOnlyEmoji)
	if canOnlyEmoji == nil then
		canOnlyEmoji = true
	end

	local pageType = self._pageType and self._pageType or LeaveMsgEnum.MsgType.Word
	local allFinish = self:getPageAllFinish(pageType, canOnlyEmoji)

	return allFinish
end

function M:getPageAllFinish(pageType, canOnlyEmoji)
	local allFinish = true

	if pageType == LeaveMsgEnum.MsgType.Word then
		for i = 1, self:getParagraphCount() do
			local data = self._msg.paragraph[i]
			local Subject = data[LeaveMsgEnum.MsgPartType.Subject]
			local Joiner = data[LeaveMsgEnum.MsgPartType.Joiner]
			local WordLst = data[LeaveMsgEnum.MsgPartType.Word]
			local needWordCount = 1

			if Subject < 0 then
				allFinish = false
			else
				needWordCount = LeaveMsgUtil.getSubjectNeedWorkCount(data[LeaveMsgEnum.MsgPartType.Subject])
			end

			if i > 1 and Joiner < 0 then
				allFinish = false
			end

			if needWordCount > 0 and needWordCount > self:_getWordCount(WordLst) then
				allFinish = false
			end
		end
	elseif pageType == LeaveMsgEnum.MsgType.Voice then
		allFinish = self._msg[LeaveMsgEnum.MsgPartType.VoiceHeroRes] > 0
	end

	if not allFinish and canOnlyEmoji and self:getEmoji() > 0 then
		allFinish = true
	end

	return allFinish
end

function M:_getPreviewMsgPageType()
	local pageType = self._pageType

	if not pageType then
		local voice = self:getVoice()
		local isVoice = voice and voice > 0

		pageType = isVoice and LeaveMsgEnum.MsgType.Voice or LeaveMsgEnum.MsgType.Word
	end

	return pageType
end

function M:getPreviewMsg(split, emptyMarkColor, forShowUp)
	local title = ""
	local str = ""
	local pageType = self:_getPreviewMsgPageType()

	if pageType == LeaveMsgEnum.MsgType.Word then
		if forShowUp then
			if self:getPageAllFinish(pageType) then
				str = self:getPreviewMsgWordPage(emptyMarkColor)
			end
		else
			str = self:getPreviewMsgWordPage(emptyMarkColor)
		end
	elseif pageType == LeaveMsgEnum.MsgType.Voice then
		title, str = self:getPreviewMsgVoicePage(split)
	end

	if split then
		return title, str
	else
		return str
	end
end

function M:getPreviewMsgVoicePage(split)
	local title = ""
	local str = "..."
	local voice = self._msg[LeaveMsgEnum.MsgPartType.VoiceHeroRes] or -1

	if voice > 0 then
		local heroId = math.floor(voice / 1000) + 2000000
		local audioId = voice % 1000
		local cfg = CharacterAudioConfig.instance:getCharacterAudioCOByHeroIdAndAudioId(heroId, audioId)
		local voiceStr = cfg and cfg.qipaoContent or "..."

		if split then
			title = string.format("%s:", ContainmentUtil.getHeroName(heroId))
			str = voiceStr
		else
			str = string.format("%s:%s", ContainmentUtil.getHeroName(heroId), voiceStr)
		end
	elseif self._msg[LeaveMsgEnum.MsgPartType.VoiceHero] > 0 then
		local heroId = self._msg[LeaveMsgEnum.MsgPartType.VoiceHero]

		if split then
			title = string.format("%s:", ContainmentUtil.getHeroName(heroId))
			str = "..."
		else
			str = string.format("%s:...", ContainmentUtil.getHeroName(heroId))
		end
	end

	return title, str
end

function M:getPreviewMsgWordPage(emptyMarkColor)
	local str = ""
	local strResult = {}

	for i = 1, self:getParagraphCount() do
		local data = self._msg.paragraph[i]
		local subjectId = data[LeaveMsgEnum.MsgPartType.Subject]
		local wordIds = data[LeaveMsgEnum.MsgPartType.Word]
		local joinerId = data[LeaveMsgEnum.MsgPartType.Joiner]
		local withJoiner = i > 1
		local colorStr, colorMsgType
		local strSingle = LeaveMsgUtil.TransSingleMsgData2Str(subjectId, wordIds, withJoiner, joinerId, colorStr, colorMsgType, emptyMarkColor)

		table.insert(strResult, strSingle)
	end

	str = table.concat(strResult, "\n")

	return str
end

function M:getPreviewMsgTmpRelpace(paragraphIndex, typeEnum, value, subIndex)
	local str = ""
	local pageType = self._pageType and self._pageType or LeaveMsgEnum.MsgType.Word

	if pageType == LeaveMsgEnum.MsgType.Word then
		local strResult = {}
		local targetIndex = self:getParagraphCount()

		targetIndex = targetIndex < paragraphIndex and paragraphIndex or targetIndex

		for i = 1, targetIndex do
			local data = self:_copyParagraph(self._msg.paragraph[i] or self:_newParagraph())
			local subjectId = data[LeaveMsgEnum.MsgPartType.Subject]
			local wordIds = data[LeaveMsgEnum.MsgPartType.Word] or {}
			local joinerId = data[LeaveMsgEnum.MsgPartType.Joiner]
			local withJoiner = i > 1

			if paragraphIndex and paragraphIndex == i then
				value = value or -1

				if typeEnum == LeaveMsgEnum.MsgPartType.Subject then
					subjectId = value
				elseif typeEnum == LeaveMsgEnum.MsgPartType.Word then
					wordIds[subIndex] = value
				elseif typeEnum == LeaveMsgEnum.MsgPartType.Word then
					joinerId = value
				end
			end

			local strSingle = LeaveMsgUtil.TransSingleMsgData2Str(subjectId, wordIds, withJoiner, joinerId, "#ffffff", typeEnum)

			table.insert(strResult, strSingle)
		end

		str = table.concat(strResult, "\n")
	elseif pageType == LeaveMsgEnum.MsgType.Voice then
		str = ""
	end

	return str
end

function M:clear()
	self._msg = {
		paragraph = {
			self:_newParagraph()
		},
		[LeaveMsgEnum.MsgPartType.Emoji] = -1,
		[LeaveMsgEnum.MsgPartType.VoiceHero] = -1,
		[LeaveMsgEnum.MsgPartType.VoiceHeroRes] = -1
	}
	self._pageType = false
end

function M:_newParagraph()
	return {
		[LeaveMsgEnum.MsgPartType.Joiner] = -1,
		[LeaveMsgEnum.MsgPartType.Subject] = -1,
		[LeaveMsgEnum.MsgPartType.Word] = {}
	}
end

function M:_copyParagraph(otherParagraph)
	local new = self:_newParagraph()

	new[LeaveMsgEnum.MsgPartType.Joiner] = otherParagraph[LeaveMsgEnum.MsgPartType.Joiner]
	new[LeaveMsgEnum.MsgPartType.Subject] = otherParagraph[LeaveMsgEnum.MsgPartType.Subject]

	TableUtil.addRange(new[LeaveMsgEnum.MsgPartType.Word], otherParagraph[LeaveMsgEnum.MsgPartType.Word])

	return new
end

function M:getParagraphCount()
	local count = 0

	for _, data in pairs(self._msg.paragraph or {}) do
		local wordCount = self:_getWordCount(data[LeaveMsgEnum.MsgPartType.Word])

		if data[LeaveMsgEnum.MsgPartType.Subject] > 0 or data[LeaveMsgEnum.MsgPartType.Joiner] > 0 or wordCount > 0 then
			count = count + 1
		end
	end

	return count == 0 and 1 or count
end

function M:_getWordCount(lst)
	local wordCount = 0

	for _, wordId in pairs(lst or {}) do
		if wordId > 0 then
			wordCount = wordCount + 1
		end
	end

	return wordCount
end

function M:setPageType(pageType)
	self._pageType = pageType
end

function M:getPageType()
	return self._pageType
end

function M:setMsgId(paragraphIndex, typeEnum, value, subIndex)
	value = value or -1

	local paragraph = self._msg.paragraph[paragraphIndex] or self:_newParagraph()

	if typeEnum == LeaveMsgEnum.MsgPartType.Word then
		subIndex = subIndex or 1
		paragraph[typeEnum][subIndex] = value
	else
		paragraph[typeEnum] = value
	end

	self._msg.paragraph[paragraphIndex] = paragraph
end

function M:hasVoice()
	local voice = self:getVoice()

	return voice and voice > 0
end

function M:playVoice()
	local voice = self:getVoice()

	if voice and voice > 0 then
		local heroId = math.floor(voice / 1000) + 2000000
		local audioId = voice % 1000
		local cfg = CharacterAudioConfig.instance:getCharacterAudioCOByHeroIdAndAudioId(heroId, audioId)
		local voiceId = cfg and cfg.voiceId or -1
		local VoiceEnumRes = CharacterInfoEnum.VoiceRes[audioId]
		local voiceRes = VoiceEnumRes and string.format(VoiceEnumRes, heroId) or voiceId
		local wwiseCo = CriwareAudioConfig.instance:getCOByName(voiceRes)

		if not wwiseCo then
			if Astral.OSDef.isEditor then
				FloatWordMgr.instance:show(string.format("角色[%s]audioId[%s]无法找到资源", heroId, audioId))
			elseif enableErrorLog then
				printError(string.format("角色[%s]audioId[%s]无法找到资源", heroId, audioId))
			end

			return
		end

		CriwareAudioFacade.instance:playVoiceByName(voiceRes, self.mainGO, nil, nil)
	end
end

function M:getVoice()
	return self._msg[LeaveMsgEnum.MsgPartType.VoiceHeroRes]
end

function M:setVoice(voice)
	self._msg[LeaveMsgEnum.MsgPartType.VoiceHeroRes] = voice
end

function M:setVoiceHero(heroId)
	self._msg[LeaveMsgEnum.MsgPartType.VoiceHero] = heroId
end

function M:getVoiceHero()
	return self._msg[LeaveMsgEnum.MsgPartType.VoiceHero]
end

function M:setEmoji(emoji)
	self._msg[LeaveMsgEnum.MsgPartType.Emoji] = emoji
end

function M:getEmoji()
	return self._msg[LeaveMsgEnum.MsgPartType.Emoji] or -1
end

function M:getMsgCO(paragraphIndex, typeEnum, subIndex)
	local paragraph = self._msg.paragraph[paragraphIndex] or self:_newParagraph()
	local id = paragraph[typeEnum]

	if typeEnum == LeaveMsgEnum.MsgPartType.Word then
		subIndex = subIndex or 1
		id = paragraph[typeEnum][subIndex]
	end

	id = id or -1

	return AirWorkShopConfig.instance:getMsgCO(LeaveMsgEnum.MsgPart2AirMsgEnum[typeEnum], id)
end

function M:getMsgTabContent(paragraphIndex, typeEnum, subIndex)
	local co = self:getMsgCO(paragraphIndex, typeEnum, subIndex)

	return co.tabContent
end

function M:deepCopy()
	local msgMO = self:trans2MessageCompositeNO()

	return LeaveMsgMO.New(msgMO)
end

function M:isSame(leaveMsgMO)
	if not leaveMsgMO then
		return false
	end

	if self:getEmoji() ~= leaveMsgMO:getEmoji() then
		return false
	end

	local curPageType = self:_getPreviewMsgPageType()
	local otherPageType = leaveMsgMO:_getPreviewMsgPageType()

	if curPageType ~= otherPageType then
		return false
	end

	if curPageType == LeaveMsgEnum.MsgType.Voice then
		return self:getVoice() == leaveMsgMO:getVoice()
	elseif curPageType == LeaveMsgEnum.MsgType.Word then
		if self:getParagraphCount() ~= leaveMsgMO:getParagraphCount() then
			return false
		end

		return self:getPreviewMsgWordPage() == leaveMsgMO:getPreviewMsgWordPage()
	end
end

return M
