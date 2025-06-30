-- chunkname: @IQIGame\\Scene\\Login\\LoginScene.lua

local m = {}

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	return
end

function m:OnEnter()
	UIModule.RecoverAfterForceRelease()
	UIModule.Open(Constant.UIControllerName.LoginUI, Constant.UILayer.UI)

	local cfgGlobalData = CfgGlobalTable[1058]
	local sounds = string.split(cfgGlobalData.Parameter, "|")
	local index = math.random(1, #sounds)
	local soundCid = tonumber(sounds[index])

	GameEntry.Sound:PlaySound(soundCid, Constant.SoundGroup.CHARACTER)

	local timer = Timer.New(function()
		local cfgSceneListData = CfgSceneListTable[SceneID.Login]

		if cfgSceneListData.BGM ~= 0 then
			local package = SoundPackageData.New(cfgSceneListData.BGM, nil)

			SoundPackagePlayer.Add(package)
		end
	end, 1)

	timer:Start()
end

function m:OnLeave()
	return
end

return m
