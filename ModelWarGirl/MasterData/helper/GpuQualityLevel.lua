-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Helper\\GpuQualityLevel.lua

local QualityLevelByGpu = {
	{
		"Direct3D",
		Const.GAME_QUALITY.High
	},
	{
		"Adreno (TM) 685",
		Const.GAME_QUALITY.High
	},
	{
		"Adreno (TM) 680",
		Const.GAME_QUALITY.High
	},
	{
		"Adreno (TM) 660",
		Const.GAME_QUALITY.High
	},
	{
		"Adreno (TM) 650",
		Const.GAME_QUALITY.High
	},
	{
		"Adreno (TM) 640",
		Const.GAME_QUALITY.High
	},
	{
		"Adreno (TM) 630",
		Const.GAME_QUALITY.High
	},
	{
		"Adreno (TM) 620",
		Const.GAME_QUALITY.High
	},
	{
		"Adreno (TM) 618",
		Const.GAME_QUALITY.Mid
	},
	{
		"Adreno (TM) 616",
		Const.GAME_QUALITY.Mid
	},
	{
		"Adreno (TM) 615",
		Const.GAME_QUALITY.Mid
	},
	{
		"Adreno (TM) 612",
		Const.GAME_QUALITY.Fast
	},
	{
		"Adreno (TM) 610",
		Const.GAME_QUALITY.Fast
	},
	{
		"Adreno (TM) 540",
		Const.GAME_QUALITY.Mid
	},
	{
		"Adreno (TM) 530",
		Const.GAME_QUALITY.Mid
	},
	{
		"Adreno (TM) 512",
		Const.GAME_QUALITY.Fast
	},
	{
		"Adreno (TM) 510",
		Const.GAME_QUALITY.Fast
	},
	{
		"Adreno (TM) 509",
		Const.GAME_QUALITY.Fast
	},
	{
		"Adreno (TM) 508",
		Const.GAME_QUALITY.Fast
	},
	{
		"Adreno (TM) 506",
		Const.GAME_QUALITY.Fast
	},
	{
		"Adreno (TM) 505",
		Const.GAME_QUALITY.Fast
	},
	{
		"Adreno (TM) 504",
		Const.GAME_QUALITY.Low
	},
	{
		"Adreno (TM) 430",
		Const.GAME_QUALITY.Fast
	},
	{
		"Adreno (TM) 420",
		Const.GAME_QUALITY.Fast
	},
	{
		"Adreno (TM) 418",
		Const.GAME_QUALITY.Fast
	},
	{
		"Adreno (TM) 405",
		Const.GAME_QUALITY.Low
	},
	{
		"Adreno (TM) 330",
		Const.GAME_QUALITY.Low
	},
	{
		"Adreno (TM) 320",
		Const.GAME_QUALITY.Low
	},
	{
		"Adreno (TM) 308",
		Const.GAME_QUALITY.Low
	},
	{
		"Adreno (TM) 306",
		Const.GAME_QUALITY.Low
	},
	{
		"Adreno (TM) 305",
		Const.GAME_QUALITY.Low
	},
	{
		"Adreno (TM) 304",
		Const.GAME_QUALITY.Low
	},
	{
		"Adreno (TM) 225",
		Const.GAME_QUALITY.Low
	},
	{
		"Adreno (TM) 220",
		Const.GAME_QUALITY.Low
	},
	{
		"Adreno (TM) 205",
		Const.GAME_QUALITY.Low
	},
	{
		"Adreno (TM) 203",
		Const.GAME_QUALITY.Low
	},
	{
		"Adreno (TM) 200",
		Const.GAME_QUALITY.Low
	},
	{
		"Apple A13",
		Const.GAME_QUALITY.High
	},
	{
		"Apple A12X",
		Const.GAME_QUALITY.High
	},
	{
		"Apple A12",
		Const.GAME_QUALITY.High
	},
	{
		"Apple A11",
		Const.GAME_QUALITY.High
	},
	{
		"Apple A10X",
		Const.GAME_QUALITY.High
	},
	{
		"Apple A10",
		Const.GAME_QUALITY.High
	},
	{
		"Apple A9X",
		Const.GAME_QUALITY.High
	},
	{
		"Apple A9",
		Const.GAME_QUALITY.High
	},
	{
		"Apple A8X",
		Const.GAME_QUALITY.Mid
	},
	{
		"Apple A8",
		Const.GAME_QUALITY.Mid
	},
	{
		"Apple A7",
		Const.GAME_QUALITY.Fast
	},
	{
		"Apple A6X",
		Const.GAME_QUALITY.Fast
	},
	{
		"Apple A6",
		Const.GAME_QUALITY.Low
	},
	{
		"Apple A5X",
		Const.GAME_QUALITY.Low
	},
	{
		"Apple A5",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-G77 MP11-Global",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G77 MP11",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G77 MP9",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G77 MC9",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G77 MP8",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G77 MC8",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G77 MC7",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G77 MP4",
		Const.GAME_QUALITY.Mid
	},
	{
		"Mali-G77",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G76 MP16",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G76 MP12",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G76 MP10",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G76 MP5",
		Const.GAME_QUALITY.Mid
	},
	{
		"Mali-G76 MC4",
		Const.GAME_QUALITY.Mid
	},
	{
		"Mali-G76",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G72 MP18",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G72 MP12",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G72 MP3",
		Const.GAME_QUALITY.Mid
	},
	{
		"Mali-G72",
		Const.GAME_QUALITY.Mid
	},
	{
		"Mali-G71 MP20",
		Const.GAME_QUALITY.Mid
	},
	{
		"Mali-G71 MP8",
		Const.GAME_QUALITY.Mid
	},
	{
		"Mali-G71 MP2",
		Const.GAME_QUALITY.Mid
	},
	{
		"Mali-G71",
		Const.GAME_QUALITY.Mid
	},
	{
		"Mali-G57 MC6",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G57 MP6",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G57 MC5",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G57",
		Const.GAME_QUALITY.High
	},
	{
		"Mali-G52 MP6",
		Const.GAME_QUALITY.Mid
	},
	{
		"Mali-G52 MC2",
		Const.GAME_QUALITY.Mid
	},
	{
		"Mali-G52 MP1",
		Const.GAME_QUALITY.Mid
	},
	{
		"Mali-G52",
		Const.GAME_QUALITY.Mid
	},
	{
		"Mali-G51 MP4",
		Const.GAME_QUALITY.Fast
	},
	{
		"Mali-G51",
		Const.GAME_QUALITY.Fast
	},
	{
		"Mali-T880 MP12",
		Const.GAME_QUALITY.Fast
	},
	{
		"Mali-T880 MP4",
		Const.GAME_QUALITY.Fast
	},
	{
		"Mali-T880 MP2",
		Const.GAME_QUALITY.Fast
	},
	{
		"Mali-T880",
		Const.GAME_QUALITY.Fast
	},
	{
		"Mali-T860 MP2",
		Const.GAME_QUALITY.Fast
	},
	{
		"Mali-T860",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-T830 MP3",
		Const.GAME_QUALITY.Fast
	},
	{
		"Mali-T830 MP2",
		Const.GAME_QUALITY.Fast
	},
	{
		"Mali-T830 MP1",
		Const.GAME_QUALITY.Fast
	},
	{
		"Mali-T830",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-T820 MP1",
		Const.GAME_QUALITY.Fast
	},
	{
		"Mali-T760 MP8",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-T760 MP6",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-T760 MP5",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-T760 MP2",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-T760",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-T720 MP2",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-T720",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-T628 MP4",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-T628",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-T624",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-T604",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-450 MP4",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-450 MP",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-400 MP",
		Const.GAME_QUALITY.Low
	},
	{
		"Mali-300",
		Const.GAME_QUALITY.Low
	},
	{
		"NVIDIA Tegra K1",
		Const.GAME_QUALITY.High
	},
	{
		"NVIDIA Tegra X1",
		Const.GAME_QUALITY.High
	},
	{
		"NVIDIA Tegra",
		Const.GAME_QUALITY.Mid
	},
	{
		"PowerVR GM9446",
		Const.GAME_QUALITY.Fast
	},
	{
		"PowerVR GE8329",
		Const.GAME_QUALITY.Fast
	},
	{
		"PowerVR GE8322",
		Const.GAME_QUALITY.Fast
	},
	{
		"PowerVR GE8320",
		Const.GAME_QUALITY.Fast
	},
	{
		"PowerVR GE8100",
		Const.GAME_QUALITY.Fast
	},
	{
		"PowerVR GE6430",
		Const.GAME_QUALITY.Low
	},
	{
		"PowerVR G6430",
		Const.GAME_QUALITY.Low
	},
	{
		"PowerVR Rogue G6430",
		Const.GAME_QUALITY.Low
	},
	{
		"PowerVR Rogue G6200",
		Const.GAME_QUALITY.Fast
	},
	{
		"PowerVR G6200",
		Const.GAME_QUALITY.Fast
	},
	{
		"PowerVR SGX 544MP2",
		Const.GAME_QUALITY.Fast
	},
	{
		"PowerVR SGX 544MP",
		Const.GAME_QUALITY.Fast
	},
	{
		"PowerVR SGX 544",
		Const.GAME_QUALITY.Fast
	},
	{
		"PowerVR SGX 540",
		Const.GAME_QUALITY.Low
	},
	{
		"PowerVR SGX 531",
		Const.GAME_QUALITY.Low
	},
	{
		"Intel(R) HD",
		Const.GAME_QUALITY.Fast
	},
	{
		"Vivante GC7000",
		Const.GAME_QUALITY.Mid
	},
	{
		"Vivante GC4000",
		Const.GAME_QUALITY.Fast
	},
	{
		"Vivante GC1000",
		Const.GAME_QUALITY.Low
	},
	{
		"GC1000 core",
		Const.GAME_QUALITY.Low
	},
	{
		"GC860 core",
		Const.GAME_QUALITY.Low
	},
	{
		"GC800 core",
		Const.GAME_QUALITY.Low
	}
}

return QualityLevelByGpu
