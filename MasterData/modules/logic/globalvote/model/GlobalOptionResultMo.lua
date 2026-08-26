-- chunkname: @modules/logic/globalvote/model/GlobalOptionResultMo.lua

module("modules.logic.globalvote.model.GlobalOptionResultMo", package.seeall)

local GlobalOptionResultMo = pureTable("GlobalOptionResultMo")

function GlobalOptionResultMo:ctor(parent)
	self._parent = parent
end

function GlobalOptionResultMo:init(info)
	self._optionId = info.optionId
	self._optionResult = info.optionResult
end

function GlobalOptionResultMo:optionId()
	return self._optionId or -1
end

function GlobalOptionResultMo:optionResult()
	return self._optionResult or 0
end

return GlobalOptionResultMo
