-- chunkname: @modules/logic/globalvote/model/GlobalVoteInfoMo.lua

module("modules.logic.globalvote.model.GlobalVoteInfoMo", package.seeall)

local GlobalVoteInfoMo = pureTable("GlobalVoteInfoMo")

function GlobalVoteInfoMo:ctor(parent)
	self._parent = parent
end

function GlobalVoteInfoMo:init(msg)
	self._voteId = msg.voteId
	self._optionResults = {}

	for _, data in ipairs(msg.optionResults or {}) do
		local mo = GlobalOptionResultMo.New(self)

		mo:init(data)
		table.insert(self._optionResults, mo)
	end
end

function GlobalVoteInfoMo:voteId()
	return self._voteId or -1
end

function GlobalVoteInfoMo:optionResults()
	return self._optionResults or {}
end

return GlobalVoteInfoMo
