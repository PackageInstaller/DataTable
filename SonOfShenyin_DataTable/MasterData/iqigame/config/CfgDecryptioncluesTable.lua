-- chunkname: @IQIGame\\Config\\CfgDecryptioncluesTable.lua

local CfgDecryptioncluesTable = {
	[1001] = {
		Angle = 90,
		Shape = "/PlotThread/ThreadItem/Thread_IconBg_07.png",
		CluesID = 1002,
		ImageBackground = "/PlotThread/ThreadResource/Resource_ThreadBG_01.png",
		Id = 1001,
		SucceedParam = "1001",
		RightAngle = 90,
		Title = getI18NValue(180014379),
		Des = getI18NValue(180014378)
	},
	[1002] = {
		Id = 1002,
		Shape = "/PlotThread/ThreadItem/Thread_IconBg_04.png",
		SucceedParam = "1002",
		CluesID = 2009,
		Title = getI18NValue(180023127),
		Des = getI18NValue(180023126)
	},
	[2001] = {
		Id = 2001,
		Shape = "/PlotThread/ThreadItem/Thread_IconBg_04.png",
		SucceedParam = "2001",
		CluesID = 2009,
		Title = getI18NValue(180023129),
		Des = getI18NValue(180023128)
	},
	[2002] = {
		Id = 2002,
		Shape = "/PlotThread/ThreadItem/Thread_IconBg_08.png",
		SucceedParam = "2002",
		CluesID = 3009,
		Title = getI18NValue(180023131),
		Des = getI18NValue(180023130)
	},
	[2003] = {
		Id = 2003,
		Shape = "/PlotThread/ThreadItem/Thread_IconBg_04.png",
		SucceedParam = "2003",
		CluesID = 3017,
		Title = getI18NValue(180029047),
		Des = getI18NValue(180029046)
	},
	[2004] = {
		Id = 2004,
		Shape = "/PlotThread/ThreadItem/Thread_IconBg_10.png",
		SucceedParam = "2004",
		CluesID = 3023,
		Title = getI18NValue(180029049),
		Des = getI18NValue(180029048)
	},
	[3001] = {
		Id = 3001,
		Shape = "/PlotThread/ThreadItem/Thread_IconBg_02.png",
		SucceedParam = "3001",
		CluesID = 4005,
		Title = getI18NValue(180027660),
		Des = getI18NValue(180027659)
	},
	[3002] = {
		Id = 3002,
		Shape = "/PlotThread/ThreadItem/Thread_IconBg_10.png",
		SucceedParam = "3002",
		CluesID = 4006,
		Title = getI18NValue(180027662),
		Des = getI18NValue(180027661)
	},
	[1101] = {
		Angle = 45,
		Shape = "/PlotThread/ThreadItem/Thread_IconBg_07.png",
		CluesID = 2209,
		ImageBackground = "/PlotThread/ThreadResource/Resource_ThreadBG_01.png",
		Id = 1101,
		SucceedParam = "1101",
		RightAngle = 135,
		Title = getI18NValue(180037032),
		Des = getI18NValue(180037031)
	}
}

setmetatable(CfgDecryptioncluesTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgDecryptioncluesTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Angle = 0,
		RightAngle = 0,
		Shape = "",
		CluesID = 0,
		Title = "",
		ImageBackground = "",
		SucceedParam = "",
		FirstAngle = 0,
		Des = ""
	}
}

for i, data in pairs(CfgDecryptioncluesTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgDecryptioncluesTable
