-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/constdef/VersionCrtl.lua

module("logiccommon.common.constdef.VersionCrtl", package.seeall)

local VersionCrtl = class("VersionCrtl")

VersionCrtl.enabledResPriority = false
VersionCrtl.enabledCheckLowerMemory = true
VersionCrtl.enableNotificationPush = false
VersionCrtl.enableJiguangNotificationPush = false

function VersionCrtl:init()
	local gameVersionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if Framework.OSDef.RunOS == Framework.OSDef.IOS then
		VersionCrtl.enabledResPriority = gameVersionCode == 0 or gameVersionCode > 200
		VersionCrtl.enabledCheckLowerMemory = gameVersionCode == 0 or gameVersionCode > 200
		VersionCrtl.enableNotificationPush = gameVersionCode == 0 or gameVersionCode >= 223
		VersionCrtl.enableJiguangNotificationPush = gameVersionCode == 0 or gameVersionCode >= 995
	else
		VersionCrtl.enabledResPriority = gameVersionCode == 0 or gameVersionCode > 200
		VersionCrtl.enabledCheckLowerMemory = gameVersionCode == 0 or gameVersionCode > 200
		VersionCrtl.enableNotificationPush = gameVersionCode == 0 or gameVersionCode >= 223
		VersionCrtl.enableJiguangNotificationPush = gameVersionCode == 0 or gameVersionCode >= 995
	end

	VersionCrtl.enabledResPriority = false

	if gameVersionCode == 0 or gameVersionCode > 200 then
		Framework.ResourceCache.enableResPriority = VersionCrtl.enabledResPriority
	end

	local starterGO = UnityEngine.GameObject.Find("AoUnityStarter")

	if starterGO then
		self._pjaqStarter = starterGO:GetComponent(typeof(PjaqmStarter))
	end
end

function VersionCrtl:addLowMemoryListener(listener, listenerObj)
	print("memory: addLowMemoryListene:", VersionCrtl.enabledCheckLowerMemory and self._pjaqStarter)

	if VersionCrtl.enabledCheckLowerMemory and self._pjaqStarter then
		self._pjaqStarter:AddLowMemoryListener(listener, listenerObj)
	else
		Game.MemoryWarning.AddListener(listener, listenerObj)
	end
end

function VersionCrtl:addTrimMemoryListener(listener, listenerObj)
	print("memory: addTrimMemoryListener:", VersionCrtl.enabledCheckLowerMemory and self._pjaqStarter)

	if VersionCrtl.enabledCheckLowerMemory and self._pjaqStarter then
		self._pjaqStarter:AddTrimMemoryListener(listener, listenerObj)
	else
		Game.MemoryWarning.AddListener(listener, listenerObj)
	end
end

function VersionCrtl:setBuglyUserId(userId)
	if self._pjaqStarter then
		self._pjaqStarter.SetUserId(tostring(userId))
	end
end

VersionCrtl.instance = VersionCrtl.New()

return VersionCrtl
