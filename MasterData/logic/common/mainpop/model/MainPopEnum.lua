-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/mainpop/model/MainPopEnum.lua

module("logic.common.mainpop.model.MainPopEnum", package.seeall)

local MainPopEnum = {}
local _uid = 0

function MainPopEnum._getUID()
	_uid = _uid + 1

	return _uid
end

MainPopEnum.Type = {
	BattleReconnect = MainPopEnum._getUID(),
	LoginPopUps = MainPopEnum._getUID(),
	SystemOpenPopUps = MainPopEnum._getUID(),
	END = MainPopEnum._getUID()
}

return MainPopEnum
