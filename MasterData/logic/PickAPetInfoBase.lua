-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/specialviews/PickAPetInfoBase.lua

module("logic.extensions.challenge.view.specialviews.PickAPetInfoBase", package.seeall)

local PickAPetInfoBase = class("PickAPetInfoBase")

function PickAPetInfoBase:ctor()
	self._gameType = PickAPetModel.GameType.Default
	self._gateId = 1
	self._callback = nil
end

function PickAPetInfoBase:onGameOverCallback()
	return
end

function PickAPetInfoBase:getGameType()
	return self._gameType
end

function PickAPetInfoBase:getGateId()
	return self._gateId
end

function PickAPetInfoBase:setGateId(gateId)
	self._gateId = gateId
end

function PickAPetInfoBase:getViewDesc()
	return "真身"
end

function PickAPetInfoBase:getIconName()
	return "icon_10155_qianniaowan", "icon_10020_yuandulingbao"
end

function PickAPetInfoBase:setOnCloseCallback(callback)
	self._callback = callback
end

function PickAPetInfoBase:doOnClose(...)
	local params = {
		...
	}

	if #params > 0 then
		GameUtil.callBack(self._callback, unpack(params))
	else
		GameUtil.callBack(self._callback)
	end
end

return PickAPetInfoBase
