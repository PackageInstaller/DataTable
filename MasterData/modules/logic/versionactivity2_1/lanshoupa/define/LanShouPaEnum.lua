-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/define/LanShouPaEnum.lua

module("modules.logic.versionactivity2_1.lanshoupa.define.LanShouPaEnum", package.seeall)

local LanShouPaEnum = _M

LanShouPaEnum.MinSlideX = 0
LanShouPaEnum.MaxSlideX = 1110
LanShouPaEnum.SceneMaxX = 14.92
LanShouPaEnum.SlideSpeed = 1
LanShouPaEnum.MaxShowEpisodeCount = 5
LanShouPaEnum.ProgressType = {
	Interact = 1,
	BeforeStory = 0,
	Finished = 3,
	AfterStory = 2
}
LanShouPaEnum.StageType = {
	Branch = 2,
	Main = 1
}
LanShouPaEnum.Stage = {
	StarIcon = {
		[LanShouPaEnum.StageType.Main] = "v1a3_role1_og_stagestar1",
		[LanShouPaEnum.StageType.Branch] = "v1a3_role1_og_stagestar2"
	},
	FrameBg = {
		[LanShouPaEnum.StageType.Main] = "v1a3_role1_og_stagemainclearbg",
		[LanShouPaEnum.StageType.Branch] = "v1a3_role1_og_stagebranchclearbg"
	},
	StageColor = {
		[LanShouPaEnum.StageType.Main] = "#AFD3FF",
		[LanShouPaEnum.StageType.Branch] = "#D5CAB0"
	},
	StageNameColor = {
		[LanShouPaEnum.StageType.Main] = "#C2E4FF",
		[LanShouPaEnum.StageType.Branch] = "#D5CAB0"
	}
}
LanShouPaEnum.StatgePiontSpriteName = {
	Finished = "v1a3_role1_og_stagepointfinished",
	Current = "v1a3_role1_og_stagepointcurrent",
	UnFinished = "v1a3_role1_og_stagepointunfinished"
}
LanShouPaEnum.Chapter = {
	Two = 2,
	One = 1
}
LanShouPaEnum.MapSceneRes = {
	[LanShouPaEnum.Chapter.One] = "scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_jlbn_zjm_01_p.prefab",
	[LanShouPaEnum.Chapter.Two] = "scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_jlbn_zjm_02_p.prefab"
}
LanShouPaEnum.ChapterPathAnimParam = {
	[LanShouPaEnum.Chapter.One] = {
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
	[LanShouPaEnum.Chapter.Two] = {
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
LanShouPaEnum.AnimatorTime = {
	MapViewOpen = 1,
	TaskRewardMoveUp = 0.15,
	ChapterPath = 1,
	TaskReward = 0.5,
	SwithSceneOpen = 0.5,
	MapViewClose = 0.3
}
LanShouPaEnum.SceneResPath = {
	GroundPoSui = "scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_dimian_b.prefab"
}
LanShouPaEnum.ComponentType = {
	Animator = typeof(UnityEngine.Animator),
	UIMesh = typeof(UIMesh)
}
LanShouPaEnum.ResultLangResPath = {
	[0] = "Assets/ZResourcesLib/singlebg_lang/txt_v1a3_role1_singlebg/v1a3_role1_resulttitlefailed.png",
	"Assets/ZResourcesLib/singlebg_lang/txt_v1a3_role1_singlebg/v1a3_role1_resulttitlefailed_2.png",
	nil,
	"Assets/ZResourcesLib/singlebg_lang/txt_v1a3_role1_singlebg/v1a3_role1_resulttitlefailed_3.png"
}
LanShouPaEnum.TaskMOAllFinishId = -100
LanShouPaEnum.episodeId = 1211401
LanShouPaEnum.chapterId = 13801
LanShouPaEnum.lvSceneType = {
	Light = 1,
	Moon = 2
}

return LanShouPaEnum
