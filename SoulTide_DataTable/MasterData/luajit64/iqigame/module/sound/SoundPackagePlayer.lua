-- chunkname: @IQIGame\\Module\\Sound\\SoundPackagePlayer.lua

local m = {
	__PlayingPackageId = 0,
	__IdGenerator = 0,
	__PackageList = {}
}

function m.__AddListeners()
	EventDispatcher.AddEventListener(EventID.StopBGM, m.OnStopBGM)
	EventDispatcher.AddEventListener(EventID.RestoreBGM, m.OnRestoreBGM)
	GameEntry.LuaEvent:Subscribe(ChangeSceneEventArgs.EventId, m.OnStartChangeScene)
end

function m.__RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.StopBGM, m.OnStopBGM)
	EventDispatcher.RemoveEventListener(EventID.RestoreBGM, m.OnRestoreBGM)
	GameEntry.LuaEvent:Unsubscribe(ChangeSceneEventArgs.EventId, m.OnStartChangeScene)
end

function m.__CreateInstanceID()
	m.__IdGenerator = m.__IdGenerator + 1

	return m.__IdGenerator
end

function m.Add(package)
	if package == nil then
		logError("参数package不能为空")

		return 0
	end

	if package.BGM == nil or package.BGM == 0 then
		logError("播放声音失败，BGM错误。sound cid：" .. tostring(package.BGM))

		return 0
	end

	if package.Environments ~= nil then
		for index, soundCid in pairs(package.Environments) do
			if soundCid <= 0 then
				logError("播放声音失败，环境音错误。sound cid：" .. soundCid)

				return 0
			end
		end
	end

	package.id = m.__CreateInstanceID()

	m.__ChangeSounds(package)
	table.insert(m.__PackageList, package)

	return package.id
end

function m.Remove(id)
	if id == nil then
		logError("参数id不能为空。")

		return
	end

	if id == 0 then
		logError("参数id不能为0，可能是因为调用SoundPackagePlayer.Add的时候传入的数据有错误，返回的id是0。")

		return
	end

	if #m.__PackageList == 0 then
		return
	end

	local index = -1
	local oldPackageListLength = #m.__PackageList

	for i = 1, oldPackageListLength do
		if m.__PackageList[i].id == id then
			index = i

			break
		end
	end

	local prevPackageIndex = index - 1

	if index == oldPackageListLength then
		local package = m.__PackageList[prevPackageIndex]

		m.__ChangeSounds(package)
	end

	table.remove(m.__PackageList, index)
end

function m.Pause()
	m.__ChangeSounds(nil)
end

function m.Resume()
	if #m.__PackageList == 0 then
		return
	end

	local package = m.__PackageList[#m.__PackageList]

	m.__ChangeSounds(package)
end

function m.__ChangeSounds(newPackage)
	if newPackage ~= nil and (newPackage.BGM == nil or newPackage.BGM == 0) then
		logError("播放声音失败，__ChangeSounds参数SoundPackageData.BGM错误：" .. tostring(newPackage.BGM))

		return
	end

	if newPackage ~= nil and (newPackage.id == nil or newPackage.id == 0) then
		logError("播放声音失败，__ChangeSounds参数SoundPackageData.id错误：" .. tostring(newPackage.id))

		return
	end

	local playingPackage

	if m.__PlayingPackageId ~= 0 then
		playingPackage = table.search(m.__PackageList, function(i, package)
			return package.id == m.__PlayingPackageId
		end)
	end

	if newPackage == nil and playingPackage == nil then
		return
	end

	m.__PlayingSounds = m.__PlayingSounds or {}

	if newPackage == nil or playingPackage ~= nil and newPackage.BGM ~= playingPackage.BGM then
		m.__StopSoundByCid(playingPackage.BGM)
	end

	if newPackage ~= nil and (playingPackage == nil or newPackage.BGM ~= playingPackage.BGM) then
		local serialId = GameEntry.Sound:PlaySound(newPackage.BGM, Constant.SoundGroup.BGM)

		m.__PlayingSounds[serialId] = newPackage.BGM
	end

	if playingPackage ~= nil and playingPackage.Environments ~= nil then
		for i = 1, #playingPackage.Environments do
			local envSoundCid = playingPackage.Environments[i]

			if newPackage == nil or newPackage.Environments == nil or table.indexOf(newPackage.Environments, envSoundCid) == -1 then
				m.__StopSoundByCid(envSoundCid)
			end
		end
	end

	if newPackage ~= nil and newPackage.Environments ~= nil then
		for i = 1, #newPackage.Environments do
			local envSoundCid = newPackage.Environments[i]

			if not m.__IsSoundPlaying(envSoundCid) then
				local serialId = GameEntry.Sound:PlaySound(envSoundCid, Constant.SoundGroup.ENVIRONMENT)

				m.__PlayingSounds[serialId] = envSoundCid
			end
		end
	end

	if newPackage ~= nil then
		m.__PlayingPackageId = newPackage.id
	else
		m.__PlayingPackageId = 0
	end
end

function m.__StopSoundByCid(cid)
	if m.__PlayingSounds == nil then
		return
	end

	for serialId, soundCid in pairs(m.__PlayingSounds) do
		if soundCid == cid then
			local cfgSoundData = CfgSoundTable[soundCid]

			GameEntry.Sound:StopSound(serialId, cfgSoundData.FadeOutSeconds)

			m.__PlayingSounds[serialId] = nil

			break
		end
	end
end

function m.__IsSoundPlaying(cid)
	if m.__PlayingSounds == nil then
		return false
	end

	for serialId, soundCid in pairs(m.__PlayingSounds) do
		if soundCid == cid then
			return true
		end
	end

	return false
end

function m.Replace(id, newPackage)
	if id == nil or id == 0 then
		logError("参数id非法：" .. tostring(id))

		return
	end

	if newPackage == nil then
		logError("参数newPackage非法：nil")

		return
	end

	newPackage.id = id

	if id == m.__PlayingPackageId then
		m.__ChangeSounds(newPackage)
	end

	for i = 1, #m.__PackageList do
		if m.__PackageList[i].id == id then
			m.__PackageList[i] = newPackage

			break
		end
	end
end

function m.ClearAfterStopAllSound()
	m.__PackageList = {}
	m.__PlayingSounds = {}
	m.__PlayingPackageId = 0
end

function m.OnStartChangeScene(sender, args)
	m.ClearAfterStopAllSound()
end

function m.OnStopBGM()
	m.Pause()
end

function m.OnRestoreBGM()
	m.Resume()
end

m.__AddListeners()

function m.Clear()
	m.__RemoveListeners()
end

SoundPackagePlayer = m
