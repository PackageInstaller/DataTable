-- chunkname: @IQIGame\\Module\\FormatRole\\FormatRoleModule.lua

FormatRoleModule = {}

function FormatRoleModule.InitData()
	FormatRoleModule.CurWarlockData = nil
	FormatRoleModule.Type = {
		Pos = 1,
		Hero = 3,
		Skin = 2
	}
	FormatRoleModule.CurChangeType = nil
	FormatRoleModule.WarlockData = nil
end

function FormatRoleModule.Initialize()
	FormatRoleModule.InitData()
end

function FormatRoleModule.GetFormatRole()
	FormatRoleModule.WarlockData = WarlockModule.WarlockDataDic[PlayerModule.PlayerInfo.baseInfo.showHeroCid]

	return FormatRoleModule.WarlockData
end

function FormatRoleModule.ChangeShowHcid(heroCid, xpos, ypos, size)
	net_player.changeShowHero(heroCid)
end

function FormatRoleModule.ChangeShowHcidResult(code)
	EventDispatcher.Dispatch(EventID.ChangeShowHcid)
end
