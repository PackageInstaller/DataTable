-- chunkname: @modules/logic/versionactivity1_3/jialabona/define/JiaLaBoNaEnum.lua

module("modules.logic.versionactivity1_3.jialabona.define.JiaLaBoNaEnum", package.seeall)

local JiaLaBoNaEnum = _M

JiaLaBoNaEnum.StageType = {
	Branch = 2,
	Main = 1
}
JiaLaBoNaEnum.Stage = {
	StarIcon = {
		[JiaLaBoNaEnum.StageType.Main] = "v1a3_role1_og_stagestar1",
		[JiaLaBoNaEnum.StageType.Branch] = "v1a3_role1_og_stagestar2"
	},
	FrameBg = {
		[JiaLaBoNaEnum.StageType.Main] = "v1a3_role1_og_stagemainclearbg",
		[JiaLaBoNaEnum.StageType.Branch] = "v1a3_role1_og_stagebranchclearbg"
	},
	StageColor = {
		[JiaLaBoNaEnum.StageType.Main] = "#AFD3FF",
		[JiaLaBoNaEnum.StageType.Branch] = "#D5CAB0"
	},
	StageNameColor = {
		[JiaLaBoNaEnum.StageType.Main] = "#C2E4FF",
		[JiaLaBoNaEnum.StageType.Branch] = "#D5CAB0"
	}
}
JiaLaBoNaEnum.StatgePiontSpriteName = {
	Finished = "v1a3_role1_og_stagepointfinished",
	Current = "v1a3_role1_og_stagepointcurrent",
	UnFinished = "v1a3_role1_og_stagepointunfinished"
}
JiaLaBoNaEnum.Chapter = {
	Two = 2,
	One = 1
}
JiaLaBoNaEnum.MapSceneRes = {
	[JiaLaBoNaEnum.Chapter.One] = "scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_jlbn_zjm_01_p.prefab",
	[JiaLaBoNaEnum.Chapter.Two] = "scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_jlbn_zjm_02_p.prefab"
}
JiaLaBoNaEnum.ChapterPathAnimParam = {
	[JiaLaBoNaEnum.Chapter.One] = {
		{
			1,
			0.89
		},
		{
			0.89,
			0.71
		},
		{
			0.71,
			0.54
		},
		{
			0.54,
			0.28
		},
		{
			0.28,
			0
		}
	},
	[JiaLaBoNaEnum.Chapter.Two] = {
		{
			1,
			0.89
		},
		{
			0.89,
			0.68
		},
		{
			0.68,
			0.41
		},
		{
			0.41,
			0.28
		},
		{
			0.23,
			0
		}
	}
}
JiaLaBoNaEnum.AnimatorTime = {
	MapViewOpen = 1,
	TaskRewardMoveUp = 0.15,
	ChapterPath = 1,
	TaskReward = 0.5,
	SwithSceneOpen = 0.5,
	MapViewClose = 0.3
}
JiaLaBoNaEnum.StoryType = {
	Episode = 1,
	Interact = 2
}
JiaLaBoNaEnum.SceneResPath = {
	GroundPoSui = "scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_dimian_b.prefab"
}
JiaLaBoNaEnum.ComponentType = {
	Animator = typeof(UnityEngine.Animator),
	UIMesh = typeof(UIMesh)
}
JiaLaBoNaEnum.ResultLangResPath = {
	[0] = "Assets/ZResourcesLib/singlebg_lang/txt_v1a3_role1_singlebg/v1a3_role1_resulttitlefailed.png",
	"Assets/ZResourcesLib/singlebg_lang/txt_v1a3_role1_singlebg/v1a3_role1_resulttitlefailed_2.png",
	nil,
	"Assets/ZResourcesLib/singlebg_lang/txt_v1a3_role1_singlebg/v1a3_role1_resulttitlefailed_3.png"
}
JiaLaBoNaEnum.TaskMOAllFinishId = -100
JiaLaBoNaEnum.episodeId = 1380101
JiaLaBoNaEnum.chapterId = 13801

return JiaLaBoNaEnum
