-- chunkname: @modules/logic/act189/rpc/Activity189Event.lua

module("modules.logic.act189.rpc.Activity189Event", package.seeall)

local Activity189Event = _M
local _uid = 1

local function E(name)
	assert(Activity189Event[name] == nil, "[Activity189Event] error redefined Activity189Event." .. name)

	Activity189Event[name] = _uid
	_uid = _uid + 1
end

E("onReceiveGetAct189InfoReply")
E("onReceiveGetAct189OnceBonusReply")

return Activity189Event
