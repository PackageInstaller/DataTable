-- chunkname: @modules/logic/rouge/dlc/101/controller/RougeDLCEvent101.lua

module("modules.logic.rouge.dlc.101.controller.RougeDLCEvent101", package.seeall)

local RougeDLCEvent101 = _M
local _uid = 1

local function E(name)
	assert(RougeDLCEvent101[name] == nil, "[RougeDLCEvent101] error redefined RougeDLCEvent101." .. name)

	RougeDLCEvent101[name] = _uid
	_uid = _uid + 1
end

E("UpdateLimitGroup")
E("OnSelectBuff")
E("RefreshLimiterDebuffTips")
E("UpdateBuffState")
E("UpdateEmblem")
E("CloseBuffDescTips")

return RougeDLCEvent101
