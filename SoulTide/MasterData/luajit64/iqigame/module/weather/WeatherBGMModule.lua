-- chunkname: @IQIGame\\Module\\Weather\\WeatherBGMModule.lua

WeatherBGMModule = {}

function WeatherBGMModule.LoadScene(sceneID, isAddScene)
	if isAddScene then
		return
	end

	WeatherBGMModule.currentSceneID = sceneID

	WeatherBGMModule.changeScene()
end

function WeatherBGMModule.changeScene()
	if WeatherBGMModule.currentSceneID == SceneID.MainCity or WeatherBGMModule.currentSceneID == SceneID.Home then
		WeatherBGMModule.PlayBGM()
	end
end

function WeatherBGMModule.PlayBGM()
	local package = WeatherBGMModule.GetSceneBgmPack()

	WeatherBGMModule.currentSoundPackId = SoundPackagePlayer.Add(package)
end

function WeatherBGMModule.GetSceneBgmPack()
	local cfgWeather = CfgMainCityWeatherTable[WeatherModule.currentWeatherCid]
	local weatherIndex = WeatherModule.periodOfTime
	local performanceID = cfgWeather.Performance[weatherIndex]
	local cfgPerformance = CfgMainCityWeatherPerformanceTable[performanceID]
	local bgmCid, envSoundCidList

	if WeatherBGMModule.currentSceneID == SceneID.MainCity then
		local prefabBg = PlayerPrefsUtil.GetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.MainCity_Spine_BG)
		local bgType = prefabBg == 0 and 1 or prefabBg

		if bgType == 2 then
			local cfgSoulResData = SoulModule.curSoulData:GetCfgSoulRes2D()

			if cfgSoulResData.SpineBGM ~= 0 then
				bgmCid = cfgSoulResData.SpineBGM
			end
		elseif bgType == 3 then
			local cfgSoulMarry = GirlModule.GetSoulOathData(SoulModule.curSoulData.soulCid)

			if cfgSoulMarry then
				bgmCid = cfgSoulMarry.MainUIBGM
			end
		end

		if bgmCid == nil then
			bgmCid = cfgPerformance.MainCityBGM

			if cfgPerformance.MainCityEnvironmentalSound ~= 0 then
				envSoundCidList = {
					cfgPerformance.MainCityEnvironmentalSound
				}
			end
		end
	elseif WeatherBGMModule.currentSceneID == SceneID.Home then
		bgmCid = cfgPerformance.HomelandBGM

		if cfgPerformance.HomelandEnvironmentalSound ~= 0 then
			envSoundCidList = {
				cfgPerformance.HomelandEnvironmentalSound
			}
		end
	end

	return SoundPackageData.New(bgmCid, envSoundCidList)
end

function WeatherBGMModule.OnChangeWeather()
	local package = WeatherBGMModule.GetSceneBgmPack()

	SoundPackagePlayer.Replace(WeatherBGMModule.currentSoundPackId, package)
end

function WeatherBGMModule.GetFishBgmPackage()
	local package

	if WeatherBGMModule.currentSceneID == SceneID.Home then
		local cfgWeather = CfgMainCityWeatherTable[WeatherModule.currentWeatherCid]
		local weatherIndex = WeatherModule.periodOfTime
		local performanceID = cfgWeather.Performance[weatherIndex]
		local cfgPerformance = CfgMainCityWeatherPerformanceTable[performanceID]
		local bgmCid = cfgPerformance.FishUiBGM
		local envSoundCidList

		if cfgPerformance.FishUiEnvironmentalSound ~= 0 then
			envSoundCidList = {
				cfgPerformance.FishUiEnvironmentalSound
			}
		end

		if bgmCid then
			package = SoundPackageData.New(bgmCid, envSoundCidList)
		end
	end

	return package
end

function WeatherBGMModule.ChangeBgmSpine(bgType)
	if WeatherBGMModule.currentSceneID == SceneID.MainCity then
		local cfgSoulResData = SoulModule.curSoulData:GetCfgSoulRes2D()

		if cfgSoulResData.SpineBGM == 0 and bgType == 2 then
			return
		end

		local cfgWeather = CfgMainCityWeatherTable[WeatherModule.currentWeatherCid]
		local weatherIndex = WeatherModule.periodOfTime
		local performanceID = cfgWeather.Performance[weatherIndex]
		local cfgPerformance = CfgMainCityWeatherPerformanceTable[performanceID]
		local bgmCid, envSoundCidList

		if bgType == 2 then
			bgmCid = cfgSoulResData.SpineBGM
		elseif bgType == 3 then
			local cfgSoulMarry = GirlModule.GetSoulOathData(SoulModule.curSoulData.soulCid)

			if cfgSoulMarry then
				bgmCid = cfgSoulMarry.MainUIBGM
			end
		else
			bgmCid = cfgPerformance.MainCityBGM

			if cfgPerformance.MainCityEnvironmentalSound ~= 0 then
				envSoundCidList = {
					cfgPerformance.MainCityEnvironmentalSound
				}
			end
		end

		if WeatherBGMModule.currentSoundPackId ~= nil and bgmCid then
			local package = SoundPackageData.New(bgmCid, envSoundCidList)

			SoundPackagePlayer.Replace(WeatherBGMModule.currentSoundPackId, package)
		end
	end
end

function WeatherBGMModule.Shutdown()
	return
end
