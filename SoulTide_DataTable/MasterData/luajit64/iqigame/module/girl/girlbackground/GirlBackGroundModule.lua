-- chunkname: @IQIGame\\Module\\Girl\\GirlBackGround\\GirlBackGroundModule.lua

local m = {}
local GirlBackGroundData = require("IQIGame.Module.Girl.GirlBackGround.GirlBackGroundData")

function m.Reload()
	local value = SaveDataModule.GetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.SaveServerDataKey.GirlBackGround)

	if value == nil or value == 0 then
		for i, v in pairsCfg(CfgGirlBackgroundTable) do
			if v.Default then
				value = v.Id

				break
			end
		end
	end

	m.currentUseBG = value

	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.GetBackGroundPath(cid)
	local cfg = CfgGirlBackgroundTable[cid]
	local day = WeatherModule.periodOfTime >= 1 and WeatherModule.periodOfTime <= 3
	local path, bgm, environmentalSound

	if day then
		path = UIGlobalApi.GetArtPath(cfg.DayPrefab)
		bgm = cfg.DayBGM
		environmentalSound = cfg.DayEnvironmentalSound
	else
		path = UIGlobalApi.GetArtPath(cfg.NightPrefab)
		bgm = cfg.NightBGM
		environmentalSound = cfg.NightEnvironmentalSound
	end

	return path, bgm, environmentalSound
end

function m.GetBackGroundData()
	local tab = {}

	for i, v in pairsCfg(CfgGirlBackgroundTable) do
		if not v.IsHide then
			local unlock = v.IsLock == 0

			if not unlock and PlayerModule.PlayerInfo.unlockGirlBackgrounds then
				unlock = table.indexOf(PlayerModule.PlayerInfo.unlockGirlBackgrounds, v.Id) ~= -1
			end

			local data = GirlBackGroundData.New(v.Id, unlock)

			table.insert(tab, data)
		end
	end

	table.sort(tab, function(a, b)
		local lockA = a.unlock and 1 or 0
		local lockB = b.unlock and 1 or 0

		if lockA == lockB then
			return a:GetConfigData().Sort < b:GetConfigData().Sort
		end

		return lockB < lockA
	end)

	return tab
end

function m.Shutdown()
	m.girlBackGroundDataTab = {}
	m.currentUseBG = nil

	m.RemoveListeners()
end

function m.SaveBackGround(cid)
	SaveDataModule.SaveInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.SaveServerDataKey.GirlBackGround, cid)

	m.currentUseBG = cid

	EventDispatcher.Dispatch(EventID.UpdateGirlBackgroundEvent, cid)
end

GirlBackGroundModule = m
