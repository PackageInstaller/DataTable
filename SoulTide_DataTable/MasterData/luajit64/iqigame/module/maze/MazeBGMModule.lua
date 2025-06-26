-- chunkname: @IQIGame\\Module\\Maze\\MazeBGMModule.lua

MazeBGMModule = {
	SoundPackageId = 0
}

function MazeBGMModule.Init()
	MazeBGMModule.Play()
end

function MazeBGMModule.Play()
	local package = MazeBGMModule.GetSoundPackage()

	MazeBGMModule.SoundPackageId = SoundPackagePlayer.Add(package)
end

function MazeBGMModule.GetSoundPackage()
	local cfgMazeLevelResData = CfgMazeLevelResTable[MazeDataModule.MazeLevelResID]
	local cfgMazeWeatherData = CfgMazeWeatherTable[MazeDataModule.WeatherCid]
	local environmentSoundCid = cfgMazeLevelResData.EnvironmentalSound
	local weatherSoundCid = cfgMazeWeatherData.EnvironmentalSound
	local envSoundCids

	if environmentSoundCid ~= 0 or weatherSoundCid ~= 0 then
		envSoundCids = {}

		if environmentSoundCid ~= 0 then
			table.insert(envSoundCids, environmentSoundCid)
		end

		if weatherSoundCid ~= 0 then
			table.insert(envSoundCids, weatherSoundCid)
		end
	end

	local package = SoundPackageData.New(cfgMazeLevelResData.BGM, envSoundCids)

	return package
end

function MazeBGMModule.ChangeWeatherSound()
	local package = MazeBGMModule.GetSoundPackage()

	SoundPackagePlayer.Replace(MazeBGMModule.SoundPackageId, package)
end

function MazeBGMModule.Clear()
	MazeBGMModule.SoundPackageId = 0
end
