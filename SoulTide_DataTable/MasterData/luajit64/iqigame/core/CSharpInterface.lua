-- chunkname: @IQIGame\\Core\\CSharpInterface.lua

CSharpInterface = {}

function CSharpInterface.SendHearBeat()
	if NetManager.IsConnect[NetworkChannelName.Game] then
		net_user.ping()
	end

	NetManager.PingCheckTimeOut(NetworkChannelName.Game)
end

function CSharpInterface.AddBGM(bgmCid)
	local package = SoundPackageData.New(bgmCid, nil)

	return SoundPackagePlayer.Add(package)
end

function CSharpInterface.ReplaceBGM(id, bgmCid)
	local package = SoundPackageData.New(bgmCid, nil)

	SoundPackagePlayer.Replace(id, package)
end

function CSharpInterface.RemoveBGM(id)
	SoundPackagePlayer.Remove(id)
end

function CSharpInterface.GetFixedTextI18NValue(id)
	if CSharpInterface.AutoTextI18NAvailable == nil then
		local hasData = false

		for i, v in pairsCfg(CfgAutoTextI18NTable) do
			hasData = true

			break
		end

		CSharpInterface.AutoTextI18NAvailable = hasData
	end

	if not CSharpInterface.AutoTextI18NAvailable then
		return nil
	end

	local cfgAutoTextI18NData = CfgAutoTextI18NTable[id]

	if cfgAutoTextI18NData ~= nil then
		return cfgAutoTextI18NData.Text
	end

	return nil
end
