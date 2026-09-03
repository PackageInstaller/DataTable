-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maskword/controller/MaskWordSystem.lua

MaskWordType = {
	CHAT = 1,
	NAME = 2
}
MaskWordDB = {
	[MaskWordType.CHAT] = "ForbiddenChat",
	[MaskWordType.NAME] = "ForbiddenName"
}
MaskWordSystem = class("MaskWordSystem", Facade, _M)

MaskWordSystem:has("_maskWordService", {
	is = "r"
}):injectWith("MaskWordService")

function MaskWordSystem:initialize()
	super.initialize(self)

	self._maskWord = {}
	self._dbMaskWord = {}

	self:initMaskWord(MaskWordType.CHAT)
	self:initMaskWord(MaskWordType.NAME)
end

function MaskWordSystem:initMaskWord(maskType)
	self._dbMaskWord[maskType] = ConfigReader:getDataTable(MaskWordDB[maskType])
	self._maskWord[maskType] = {}

	table.copy(self._dbMaskWord[maskType], self._maskWord[maskType])
end

function MaskWordSystem:userInject(injector)
	return
end

function MaskWordSystem:dispose()
	super.dispose(self)
end

function MaskWordSystem:requestMaskWord(callback, isBlockUI)
	if isBlockUI == nil then
		isBlockUI = true
	end

	local params = {}

	self._maskWordService:requestMaskWord(params, isBlockUI, function(response)
		if response.resCode == GS_SUCCESS then
			for key, maskType in pairs(MaskWordType) do
				self._maskWord[maskType] = {}

				table.copy(self._dbMaskWord[maskType], self._maskWord[maskType])
				self:addMaskWord(response.data.normal, nil, maskType)
				self:addMaskWord(response.data.special, tostring(1), maskType)
			end

			if callback then
				callback()
			end
		end
	end)
end

function MaskWordSystem:addMaskWord(words, type, maskType)
	if not words then
		return
	end

	for i = 1, #words do
		self._maskWord[maskType][words[i]] = {
			Name = words[i],
			Type = type
		}
	end
end

function MaskWordSystem:listenMaskWordDiff()
	self._maskWordService:listenMaskWordDiff(function(message, response)
		self:requestMaskWord(nil, false)
	end)
end

function MaskWordSystem:getMaskWord(maskType)
	return self._maskWord[maskType]
end
