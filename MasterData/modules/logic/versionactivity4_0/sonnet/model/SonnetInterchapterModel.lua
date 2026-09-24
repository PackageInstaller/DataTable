-- chunkname: @modules/logic/versionactivity4_0/sonnet/model/SonnetInterchapterModel.lua

module("modules.logic.versionactivity4_0.sonnet.model.SonnetInterchapterModel", package.seeall)

local SonnetInterchapterModel = class("SonnetInterchapterModel", BaseModel)

function SonnetInterchapterModel:onInit()
	self:reInit()
end

function SonnetInterchapterModel:reInit()
	self._words = {}
	self._wordStatus = {}
	self._unlockWords = {}
end

function SonnetInterchapterModel:initWords(words, isPush)
	self._words = {}
	self._wordStatus = {}

	for i, v in ipairs(words) do
		local id = v.id
		local status = v.status

		table.insert(self._words, v)

		self._wordStatus[id] = status
	end

	SonnetInterchapterController.instance:dispatchEvent(SonnetInterchapterEvent.InitWords, isPush)
end

function SonnetInterchapterModel:getWordStatus(id)
	return self._wordStatus[id]
end

function SonnetInterchapterModel:getAllUnlockWords()
	tabletool.clear(self._unlockWords)

	for i, v in ipairs(self._words) do
		if self._wordStatus[v.id] == SonnetInterchapterEnum.WordStatus.Unlocked then
			table.insert(self._unlockWords, v)
		end
	end

	return self._unlockWords
end

function SonnetInterchapterModel:getAllUsedWords()
	local words = {}

	for i, v in ipairs(self._words) do
		if self._wordStatus[v.id] == SonnetInterchapterEnum.WordStatus.Used then
			table.insert(words, v)
		end
	end

	return words
end

function SonnetInterchapterModel:getAllConsumedWords()
	local words = {}

	for i, v in ipairs(self._words) do
		if self._wordStatus[v.id] == SonnetInterchapterEnum.WordStatus.Consumed then
			table.insert(words, v)
		end
	end

	return words
end

function SonnetInterchapterModel:setWordStatus(id, status)
	if not self._wordStatus[id] then
		logError("SonnetInterchapterModel:setWordStatus id not exist id:", tostring(id))

		return
	end

	self._wordStatus[id] = status
end

function SonnetInterchapterModel:consumeWords(words)
	self:initWords(words)
end

SonnetInterchapterModel.instance = SonnetInterchapterModel.New()

return SonnetInterchapterModel
