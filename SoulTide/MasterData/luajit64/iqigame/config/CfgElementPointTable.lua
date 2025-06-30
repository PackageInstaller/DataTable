-- chunkname: @IQIGame\\Config\\CfgElementPointTable.lua

local CfgElementPointTable = {
	[50000] = {
		Id = 50000,
		PointName = "Point_Root"
	},
	[50010] = {
		Id = 50010,
		PointName = "Point_Root2"
	},
	[50020] = {
		Id = 50020,
		PointName = "Point_TeamEffect"
	},
	[10200] = {
		Id = 10200,
		PointName = "Point_Skill"
	},
	[10201] = {
		Id = 10201,
		PointName = "Point_Hit"
	},
	[10202] = {
		Id = 10202,
		PointName = "Point_Blood"
	},
	[10203] = {
		Id = 10203,
		PointName = "Point_Head"
	},
	[10204] = {
		Id = 10204,
		PointName = "Point_FrontHit"
	},
	[10206] = {
		Id = 10206,
		PointName = "Point_Buff"
	},
	[11201] = {
		Id = 11201,
		PointName = "Point_Chest_front"
	},
	[11202] = {
		Id = 11202,
		PointName = "Point_Chest_behind"
	},
	[20010] = {
		Id = 20010,
		PointName = "Point_Chest"
	},
	[20011] = {
		Id = 20011,
		PointName = "Point_Text"
	},
	[60001] = {
		Id = 60001,
		PointName = "Point_UI_Custom02"
	},
	[60002] = {
		Id = 60002,
		PointName = "Point_UI_Custom04"
	},
	[60003] = {
		Id = 60003,
		PointName = "Point_UI_Custom06"
	},
	[11500] = {
		Id = 11500,
		PointName = "SkillEffectPoint01_front"
	},
	[11501] = {
		Id = 11501,
		PointName = "SkillEffectPoint02_front"
	},
	[11502] = {
		Id = 11502,
		PointName = "SkillEffectPoint03_front"
	},
	[11503] = {
		Id = 11503,
		PointName = "SkillEffectPoint04_front"
	},
	[11504] = {
		Id = 11504,
		PointName = "SkillEffectPoint05_front"
	},
	[10500] = {
		Id = 10500,
		PointName = "SkillEffectPoint01"
	},
	[10501] = {
		Id = 10501,
		PointName = "SkillEffectPoint02"
	},
	[10502] = {
		Id = 10502,
		PointName = "SkillEffectPoint03"
	},
	[10503] = {
		Id = 10503,
		PointName = "SkillEffectPoint04"
	},
	[10504] = {
		Id = 10504,
		PointName = "SkillEffectPoint05"
	},
	[9500] = {
		Id = 9500,
		PointName = "SkillEffectPoint01_behind"
	},
	[9501] = {
		Id = 9501,
		PointName = "SkillEffectPoint02_behind"
	},
	[9502] = {
		Id = 9502,
		PointName = "SkillEffectPoint03_behind"
	},
	[9503] = {
		Id = 9503,
		PointName = "SkillEffectPoint04_behind"
	},
	[9504] = {
		Id = 9504,
		PointName = "SkillEffectPoint05_behind"
	},
	[30000] = {
		Id = 30000,
		PointName = "Point_Scene_01"
	},
	[30001] = {
		Id = 30001,
		PointName = "Point_Scene_02"
	},
	[40001] = {
		Id = 40001,
		PointName = "Point_Skill_Flight"
	},
	[40002] = {
		Id = 40002,
		PointName = "Point_SkillEffect"
	},
	[40003] = {
		Id = 40003,
		PointName = "SceneEffectPoint"
	},
	[40004] = {
		Id = 40004,
		PointName = "SceneEffectPoint_front"
	},
	[40005] = {
		Id = 40005,
		PointName = "SceneEffectPoint_Root"
	},
	[40006] = {
		Id = 40006,
		PointName = "SceneEffectPoint_top"
	},
	[50001] = {
		Id = 50001,
		PointName = "Point_Buff_Tip_Left"
	},
	[50002] = {
		Id = 50002,
		PointName = "Point_Buff_Tip_Right"
	},
	[50003] = {
		Id = 50003,
		PointName = "Point_playdead"
	},
	[10710301] = {
		Id = 10710301,
		PointName = "Point_passive"
	},
	[20201401] = {
		Id = 20201401,
		PointName = "g_3"
	}
}

setmetatable(CfgElementPointTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgElementPointTable]")
	end
})

local defaultMetaTable = {
	__index = {
		PointName = ""
	}
}

for i, data in pairs(CfgElementPointTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgElementPointTable
