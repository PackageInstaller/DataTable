-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargod/model/StarGodNotify.lua

module(..., package.seeall)

local StarGodNotify = class("StarGodNotify")

StarGodNotify.OnMessengerStateChange = 1
StarGodNotify.OnStarGodInfoChange = 2
StarGodNotify.OnOneKeyHuntUp = 3
StarGodNotify.OnAutoCombine = 4
StarGodNotify.OnBagInfoChanged = 5
StarGodNotify.OnChangeOneKey = 6
StarGodNotify.OnChangeOneKeySuc = 7
StarGodNotify.OnClickStarGod = 8
StarGodNotify.OnStarGodEquiped = 9
StarGodNotify.OnStarGodEquiping = 10
StarGodNotify.OnPickUp = 11
StarGodNotify.OnHuntUpStarGod = 12
StarGodNotify.OnClickLevelUp = 13
StarGodNotify.OnStatusInvalid = 14

function StarGodNotify:ctor()
	NotifyDispatcher.extend(self)
end

function StarGodNotify.dispatch(msg, ...)
	StarGodNotify.instance:dispatch(msg, ...)
end

function StarGodNotify.addListener(msg, func, msger)
	StarGodNotify.instance:addListener(msg, func, msger)
end

function StarGodNotify.removeListener(msg, func, msger)
	StarGodNotify.instance:removeListener(msg, func, msger)
end

StarGodNotify.instance = StarGodNotify.New()

return StarGodNotify
