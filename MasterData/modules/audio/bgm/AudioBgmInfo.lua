-- chunkname: @modules/audio/bgm/AudioBgmInfo.lua

module("modules.audio.bgm.AudioBgmInfo", package.seeall)

local AudioBgmInfo = class("AudioBgmInfo")

function AudioBgmInfo:ctor()
	self._bgmDatas = {}
	self._bgmUsageSceneMap = {}
	self._bgmUsageViewMap = {}
	self._bgmBindMap = {}

	self:_initBgmDatas()
	self:_initBgmUsage()
	self:_initBgmBind()
end

function AudioBgmInfo:_initBgmDatas()
	self:_addBgmData(AudioBgmEnum.Layer.Main, AudioEnum.UI.Resume_MainMusic, AudioEnum.UI.Pause_MainMusic)
	self:_addBgmData(AudioBgmEnum.Layer.PushBox, AudioEnum.Bgm.PushBox, AudioEnum.Story.Stop_PlotMusic)
	self:_addBgmData(AudioBgmEnum.Layer.Explore, AudioEnum.Bgm.play_ui_secretroom_music, AudioEnum.UI.Stop_UIMusic)
	self:_addBgmData(AudioBgmEnum.Layer.Dungeon, AudioEnum.UI.Play_UI_Slippage_Music, AudioEnum.UI.Stop_UIMusic)
	self:_addBgmData(AudioBgmEnum.Layer.Character, AudioEnum.UI.Play_UI_Unsatisfied_Music, AudioEnum.UI.Stop_UIMusic)
	self:_addBgmData(AudioBgmEnum.Layer.LeiMiTeBei, AudioEnum.Bgm.LeiMiTeBeiBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.LeiMiTeBeiDungeon, AudioEnum.Bgm.LeiMiTeBeiDungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Bp, AudioEnum.Bgm.PlayPassPortMusic, AudioEnum.Bgm.StopPassPortMusic)
	self:_addBgmData(AudioBgmEnum.Layer.DungeonWeekWalk, AudioEnum.WeekWalk.play_artificial_layer_type_1, AudioEnum.UI.Stop_UI_noise)
	self:_addBgmData(AudioBgmEnum.Layer.ChessGame, AudioEnum.Bgm.ChessGameBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Meilanni, AudioEnum.Bgm.play_activitymusic_humorousburglary_74bpm4_4, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Season, AudioEnum.Bgm.LeiMiTeBeiDungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.HandbookSkin, AudioEnum.Bgm.HandbookSkinBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.DungeonAmbientSound, 0, 0)
	self:_addBgmData(AudioBgmEnum.Layer.WeekWalk, 0, 0)
	self:_addBgmData(AudioBgmEnum.Layer.Summon, 0, 0)
	self:_addBgmData(AudioBgmEnum.Layer.Fight, 0, 0)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4MusicFree, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivityVideoView, 0, 0)
	self:_addBgmData(AudioBgmEnum.Layer.Story, 0, 0)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_2Main, AudioEnum.Bgm.ActivityMainBgm1_2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.JieXiKa, AudioEnum.Bgm.JieXiKaBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.YaXian, AudioEnum.Bgm.YaXianBgm1_2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Season1_2, AudioEnum.Bgm.Season1_2Bgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3Main, AudioEnum.Bgm.ActivityMainBgm1_3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3DungeonAmbientSound, 0, 0)
	self:_addBgmData(AudioBgmEnum.Layer.Season1_3, AudioEnum.Bgm.play_activitymusic_indiastargazing_theme_1_3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3ArmPipe, AudioEnum.Bgm.play_activitymusic_indialively_1_3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3Act307, AudioEnum.Bgm.play_activitymusic_indialively_1_3_2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3Act304, AudioEnum.Bgm.Activity1_3ChessMapViewBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_3Act120, AudioEnum.Bgm.play_activitymusic_indiastargazing_theme_1_3_act120, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Season1_4, AudioEnum.Bgm.play_plot_music_comfortable, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.RoleStoryActivity, AudioEnum.Story.play_plot_music_dailyemotion, AudioEnum.Story.Stop_PlotMusic)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_4Main, AudioEnum.Bgm.play_activitymusic_themesong1_4, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.TokenStore, AudioEnum.Bgm.play_activitymusic_tokenstore1_4, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.TaskAndCollected, AudioEnum.Bgm.play_activitymusic_mission1_4, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_4Act130, AudioEnum.Bgm.Activity130LevelViewBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_4Act131, AudioEnum.Bgm.Activity131LevelViewBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_4Act136, AudioEnum.Bgm.Activity136ViewBgm, AudioEnum.UI.Stop_UIMusic)
	self:_addBgmData(AudioBgmEnum.Layer.Season1_5, AudioEnum.Bgm.play_activitymusic_seasonmain_1_5, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_5Main, AudioEnum.Bgm.ActivityMainBgm1_5, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Activity142, AudioEnum.Bgm.Activity142Bgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.V1a5AiZiLa, AudioEnum.Bgm.V1a5AiZiLaBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_6Main, AudioEnum.Bgm.Act1_6DungeonBgm1, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_6Dungeon, AudioEnum.Bgm.Act1_6DungeonBgm1, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Act_QuNiang, AudioEnum.Bgm.role_activity_quniang, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Act_GeTian, AudioEnum.Bgm.role_activity_getian, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Cachot, AudioEnum.Bgm.CachotMainScene, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_7Main, AudioEnum.Bgm.Act1_7DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_8Main, AudioEnum.Bgm.Act1_8DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_8Dungeon, AudioEnum.Bgm.Act1_8DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_9Main, AudioEnum.Bgm.Act1_9DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Act_Lucy, AudioEnum.Bgm.role_activity_lucy, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Act_KaKaNia, AudioEnum.Bgm.role_activity_kakania, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity1_9SemmelWeisGift, AudioEnum.Bgm.SemmelWeisGift, AudioEnum.UI.Stop_UIMusic)
	self:_addBgmData(AudioBgmEnum.Layer.ToughBattle, AudioEnum.Bgm.ToughBattle, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.FairyLand, AudioEnum.Bgm.FairyLand, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.HeroInvitation, AudioEnum.Bgm.HeroInvitation, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.RougeFavorite, AudioEnum.Bgm.RougeFavorite, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.RougeMain, AudioEnum.Bgm.RougeMain, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.RougeScene, 0, 0)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_0Main, AudioEnum.Bgm.Act2_0DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Act_Joe, AudioEnum.Bgm.role_activity_joe, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Act_Mercuria, AudioEnum.Bgm.role_activity_mercuria, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.V2a0_WarmUp, AudioEnum.Bgm.play_ui_feichi_noise_yure_20200116, AudioEnum.Bgm.stop_ui_feichi_noise_yure_20200117)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_1Main, AudioEnum.Bgm.Act2_1DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.V2a1_WarmUp, AudioEnum.Bgm.play_ui_preheat_2_1_music_20211601, AudioEnum.Bgm.stop_ui_preheat_2_1_music_20211602)
	self:_addBgmData(AudioBgmEnum.Layer.Act_Aergusi, AudioEnum.Bgm.Act2_1_Aergusi, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Act_LanShouPa, AudioEnum.Bgm.Act2_1_LanShouPa, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_2Main, AudioEnum.Bgm.Act2_2DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.InvestigateRoleStory, AudioEnum.Bgm.play_activitymusic_sadness, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.NormalBattleV2_2, AudioEnum.Bgm.play_battle_youyui_2_2_normalfight, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.BossBattleV2_2, AudioEnum.Bgm.play_battle_youyui_2_2_bossfight, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.InvestigateView, AudioEnum.VersionActivity2_2Investigate.play_ui_youyu_survey_scene_loop, AudioEnum.UI.Stop_UI_Bus)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_3Main, AudioEnum.Bgm.Act2_3DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Tower, AudioEnum.TowerBgm.play_replay_music_towermain_2_3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.LinkageActivity_FullView, AudioEnum.Bgm.ui_shenghuo_discovery_amb_20234001, AudioEnum.Bgm.stop_ui_bus_2000048)
	self:_addBgmData(AudioBgmEnum.Layer.V2a3_WarmUp, AudioEnum.Bgm.play_ui_shenghuo_preheat_amb_20234003, AudioEnum.Bgm.stop_ui_bus_2000048)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4Main, AudioEnum.Bgm.Act2_4DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4Act178Game, AudioEnum.Act178.bgm_game, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4WuErLiXi, AudioEnum.WuErLiXi.bgm_wuerliximap, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_4WuErLiXiGame, AudioEnum.WuErLiXi.bgm_wuerliximapgame, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_5Main, AudioEnum.Bgm.Act2_5DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.AutoChess, AudioEnum.Bgm.play_autochess, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.LiangYue, AudioEnum.Bgm.LiangYue, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.FeiLinShiDuo, AudioEnum.Bgm.FeiLinShiDuo, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_6Main, AudioEnum.Bgm.Act2_6DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_6_DiceHero, AudioEnum2_6.DiceHero.Bgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_6_DiceHero_Game, AudioEnum2_6.DiceHero.Bgm_Game, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Xugouji, AudioEnum.Bgm.XugoujiBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_7Main, AudioEnum.Bgm.Act2_7DungeonBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.LengZhou6, AudioEnum.Bgm.LengZhou6Bgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.CooperGarland, AudioEnum.Bgm.CooperGarlandBgm, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_9Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_9Stealth, AudioEnum2_9.StealthGameBgm.StealthGameBgm, AudioEnum2_9.StealthGameBgm.StealthGameStopBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_8Main, AudioEnum2_8.PermanentBgm.EnterView, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.NuoDiKaBGM, AudioEnum2_8.PermanentBgm.NuoDiKa, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.MoLiDeErBGM, AudioEnum2_8.PermanentBgm.MoLiDeEr, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity2_8DungeonBoss, AudioEnum2_8.DungeonBgm.boss, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.SurvivalBGM, AudioEnum2_8.Survival.play_activitymusic_dl_state_2_8, AudioEnum2_8.Survival.stop_activitymusic_dl_state_2_8)
	self:_addBgmData(AudioBgmEnum.Layer.ShelterBGM, AudioEnum2_8.Survival.play_activitymusic_dl_camp_2_8, AudioEnum2_8.Survival.stop_activitymusic_dl_camp_2_8)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_0Main, AudioEnum3_0.PermanentBgm.EnterView, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.MaLiAnNaBGM, AudioEnum3_0.PermanentBgm.MaLiAnNa, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.KaRongBGM, AudioEnum3_0.PermanentBgm.KaRong, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.CommanStationEnterView, AudioEnum3_0.Bgm.play_ui_zhihuisuo_music, AudioEnum.UI.Stop_UIMusic)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_0MainAmbientSound, 0, 0)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_1Main, AudioEnum3_1.PermanentBgm.EnterView, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.NecrologistStoryView, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_2Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Udimo, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_3Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.ArcadeOutSide, AudioEnum3_3.bgm.play_8bit_music_explore, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.Igor, AudioEnum3_3.bgm.play_activitymusic_zuozhan_3_3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.ArcadeInSide, AudioEnum3_3.bgm.play_8bit_music_combat, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_4Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.PartyGame, 0, AudioEnum3_4.bgm.partygame_bgm_stop)
	self:_addBgmData(AudioBgmEnum.Layer.PartyGameLobby, AudioEnum3_4.bgm.partygame_lobby, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.PartyGameMain, AudioEnum3_4.bgm.partygame_main, AudioEnum3_4.bgm.partygame_bgm_stop)
	self:_addBgmData(AudioBgmEnum.Layer.V3A4RoleStory, 0, 0)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_5Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.SurvivalView, AudioEnum3_5.Survival.SurvivalView, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_6Main, AudioEnum3_6.bgm.play_activitymusic_theme_3_6, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.V3a6YaMi, AudioEnum3_6.bgm.play_moni_main_music_3_6, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_7Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.TowerV3a7, AudioEnum3_7.bgm.TowerV3a7, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.SodacheMain, AudioEnum3_7.Sodache.play_soudache_main_theme_camp_3_7, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.SodacheMap, AudioEnum3_7.Sodache.play_soudache_explore_3_7, AudioEnum3_7.Sodache.stop_activitymusic_soudache_3_7)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_8Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.V3a8Puzzle, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.SP02_AtomicOperationActivityGame, AudioEnum3_10.OperationActivity.play_8bit_music_combat, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.SP02_AtomicDungeonMain, AudioEnum3_10.Outside.play_qieluomei_map_music, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.SP02_AtomicDungeonPolygonSelect, AudioEnum3_10.Outside.play_qieluomei_xuanguan_music, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_10Main, AudioEnum3_10.Enter.play_activitymusic_theme_s02, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.SP02_AtomicDungeonTalent, AudioEnum3_10.Outside.play_qieluomei_qianghua_music, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.SP02_AVGView, AudioEnum3_10.Dungeon.play_activitymusic_3_database_s02, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.VersionActivity3_9Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.V3a9RacingGameLobby, V3a9RacingCarEnum.bgm.partygame_lobby, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	self:_addBgmData(AudioBgmEnum.Layer.V3a9RacingGameMain, V3a9RacingCarEnum.bgm.partygame_main, V3a9RacingCarEnum.bgm.partygame_bgm_stop)
	self:_addBgmData(AudioBgmEnum.Layer.V3a9Bird, AudioEnum.Bgm.play_lianji_playcards_music, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function AudioBgmInfo:_initBgmUsage()
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Main
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Main
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Explore
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Explore
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.PushBox
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.PushBox
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Fight
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Fight
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Cachot
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Cachot
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Story
	}, AudioBgmEnum.UsageType.View, {
		ViewName.StoryView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Dungeon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.DungeonMapView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.DungeonWeekWalk
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WeekWalkLayerView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Dungeon,
		AudioBgmEnum.Layer.DungeonWeekWalk
	}, AudioBgmEnum.UsageType.View, {
		ViewName.DungeonView
	}, DungeonController.queryBgm, nil)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivityVideoView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivityVideoView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Character
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WeekWalkCharacterView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Character
	}, AudioBgmEnum.UsageType.View, {
		ViewName.CharacterBackpackView,
		ViewName.CharacterView,
		ViewName.CharacterRankUpView,
		ViewName.CharacterTalentView,
		ViewName.CharacterExSkillView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.LeiMiTeBei
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivityEnterView,
		ViewName.VersionActivityExchangeView,
		ViewName.Permanent1_1EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.LeiMiTeBeiDungeon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivityDungeonMapView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Meilanni
	}, AudioBgmEnum.UsageType.View, {
		ViewName.MeilanniMainView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Bp
	}, AudioBgmEnum.UsageType.View, {
		ViewName.BpView,
		ViewName.BpSPView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Summon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.SummonView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.ChessGame
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity109ChessEntry
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.WeekWalk
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WeekWalkView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Season
	}, AudioBgmEnum.UsageType.View, {
		ViewName.SeasonMainView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.HandbookSkin
	}, AudioBgmEnum.UsageType.View, {
		ViewName.HandbookSkinView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_2Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_2EnterView,
		ViewName.VersionActivity1_2DungeonView,
		ViewName.Permanent1_2EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.YaXian
	}, AudioBgmEnum.UsageType.View, {
		ViewName.YaXianMapView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.JieXiKa
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity114View
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Season1_2
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Season1_2MainView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_3EnterView,
		ViewName.VersionActivity1_3DungeonMapView,
		ViewName.Permanent1_3EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Season1_3
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Season1_3MainView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3ArmPipe
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ArmMainView,
		ViewName.ArmRewardView,
		ViewName.ArmPuzzlePipeView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3Act307
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity1_3_119View
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3Act304
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity1_3ChessMapView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_3Act120
	}, AudioBgmEnum.UsageType.View, {
		ViewName.JiaLaBoNaMapView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Season1_4
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Season1_4MainView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.RoleStoryActivity
	}, AudioBgmEnum.UsageType.View, {
		ViewName.RoleStoryActivityMainView,
		ViewName.RoleStoryDispatchMainView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_4Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_4EnterView,
		ViewName.Permanent1_4EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.TokenStore
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity129View
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.TaskAndCollected
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_4TaskView,
		ViewName.Activity132CollectView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_4Act130
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity130LevelView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_4Act131
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity131LevelView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_4Act136
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity136View
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_5Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_5EnterView,
		ViewName.Permanent1_5EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Season1_5
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Season1_5MainView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Activity142
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity142MapView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.V1a5AiZiLa
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AiZiLaMapView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_6Dungeon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_6DungeonMapView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_6Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_6EnterView,
		ViewName.Permanent1_6EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Act_QuNiang
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActQuNiangLevelView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Act_GeTian
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActGeTianLevelView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_7Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_7EnterView,
		ViewName.Permanent1_7EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_8Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_8EnterView,
		ViewName.Permanent1_8EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_8Dungeon
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_8DungeonMapView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_9Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity1_9EnterView,
		ViewName.Permanent1_9EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Act_Lucy
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActLucyLevelView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Act_KaKaNia
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActKaKaNiaLevelView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity1_9SemmelWeisGift
	}, AudioBgmEnum.UsageType.View, {
		ViewName.SemmelWeisGiftView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.ToughBattle
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ToughBattleEnterView,
		ViewName.ToughBattleActEnterView,
		ViewName.ToughBattleMapView,
		ViewName.ToughBattleActMapView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.FairyLand
	}, AudioBgmEnum.UsageType.View, {
		ViewName.FairyLandView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.HeroInvitation
	}, AudioBgmEnum.UsageType.View, {
		ViewName.HeroInvitationDungeonMapView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.RougeFavorite
	}, AudioBgmEnum.UsageType.View, {
		ViewName.RougeFavoriteView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.RougeMain
	}, AudioBgmEnum.UsageType.View, {
		ViewName.RougeMainView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.RougeScene
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Rouge
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_0Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_0EnterView,
		ViewName.Permanent2_0EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Act_Joe
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActJoeLevelView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Act_Mercuria
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ActMercuriaLevelView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.V2a0_WarmUp
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V2a0_WarmUp
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_1Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_1EnterView,
		ViewName.Permanent2_1EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.V2a1_WarmUp
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V2a1_WarmUp
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Act_Aergusi
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AergusiLevelView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Act_LanShouPa
	}, AudioBgmEnum.UsageType.View, {
		ViewName.LanShouPaMapView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_2Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_2EnterView,
		ViewName.Permanent2_2EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.InvestigateRoleStory
	}, AudioBgmEnum.UsageType.View, {
		ViewName.InvestigateRoleStoryView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.InvestigateView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.InvestigateView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.NormalBattleV2_2,
		AudioBgmEnum.Layer.BossBattleV2_2
	}, AudioBgmEnum.UsageType.View, {
		ViewName.EliminateLevelView,
		ViewName.EliminateSelectRoleView,
		ViewName.EliminateSelectChessMenView
	}, EliminateLevelController.queryBgm, nil)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_3Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_3EnterView,
		ViewName.V2a3_ReactivityEnterview,
		ViewName.Permanent2_3EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Tower
	}, AudioBgmEnum.UsageType.View, {
		ViewName.TowerMainSelectView,
		ViewName.TowerMainEntryView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.LinkageActivity_FullView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.LinkageActivity_FullView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.V2a3_WarmUp
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V2a3_WarmUp
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4MusicFree
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_4MusicFreeView,
		ViewName.VersionActivity2_4MusicBeatView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_4EnterView,
		ViewName.Permanent2_4EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4Act178Game
	}, AudioBgmEnum.UsageType.View, {
		ViewName.PinballGameView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4WuErLiXiGame
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WuErLiXiGameView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_4WuErLiXi
	}, AudioBgmEnum.UsageType.View, {
		ViewName.WuErLiXiLevelView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_5Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_5EnterView,
		ViewName.Permanent2_5EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.AutoChess
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AutoChessMainView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.LiangYue
	}, AudioBgmEnum.UsageType.View, {
		ViewName.LiangYueLevelView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.FeiLinShiDuo
	}, AudioBgmEnum.UsageType.View, {
		ViewName.FeiLinShiDuoEpisodeLevelView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_6Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_6EnterView,
		ViewName.Permanent2_6EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_6_DiceHero
	}, AudioBgmEnum.UsageType.View, {
		ViewName.DiceHeroMainView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_6_DiceHero_Game
	}, AudioBgmEnum.UsageType.View, {
		ViewName.DiceHeroGameView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Xugouji
	}, AudioBgmEnum.UsageType.View, {
		ViewName.XugoujiLevelView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_7Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_7EnterView,
		ViewName.Permanent2_7EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.LengZhou6
	}, AudioBgmEnum.UsageType.View, {
		ViewName.LengZhou6LevelView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.CooperGarland
	}, AudioBgmEnum.UsageType.View, {
		ViewName.CooperGarlandLevelView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_9Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_9EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_9Stealth
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AssassinStealthGameView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_8Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_8EnterView,
		ViewName.Permanent2_8EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.NuoDiKaBGM
	}, AudioBgmEnum.UsageType.View, {
		ViewName.NuoDiKaLevelView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.MoLiDeErBGM
	}, AudioBgmEnum.UsageType.View, {
		ViewName.MoLiDeErLevelView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity2_8DungeonBoss
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity2_8BossStoryEnterView,
		ViewName.VersionActivity2_8BossActEnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.SurvivalBGM
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Survival
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.ShelterBGM
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.SurvivalShelter
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.ShelterBGM
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.SurvivalSummaryAct
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.ShelterBGM
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.SurvivalCollectionRoom
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity3_0Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity3_0EnterView,
		ViewName.Permanent3_0EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.MaLiAnNaBGM
	}, AudioBgmEnum.UsageType.View, {
		ViewName.Activity201MaLiAnNaLevelView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.KaRongBGM
	}, AudioBgmEnum.UsageType.View, {
		ViewName.KaRongLevelView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.CommanStationEnterView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.CommandStationEnterView,
		ViewName.CommandStationMapView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity3_1Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity3_1EnterView,
		ViewName.Permanent3_1EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.NecrologistStoryView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.NecrologistStoryView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity3_2Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity3_2EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Udimo
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Udimo
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Rouge2Scene
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.Rouge2
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity3_3Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity3_3EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.ArcadeOutSide
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ArcadeHallView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.Igor
	}, AudioBgmEnum.UsageType.View, {
		ViewName.IgorGameView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.ArcadeInSide
	}, AudioBgmEnum.UsageType.View, {
		ViewName.ArcadeGameView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity3_4Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity3_4EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.PartyGame
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.PartyGame
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.PartyGameLobby
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.PartyGameLobby
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.PartyGameMain
	}, AudioBgmEnum.UsageType.View, {
		ViewName.LaplaceForumMainView,
		ViewName.PartyGameLobbyLoadingView,
		ViewName.ChatRoomMainView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.V3A4RoleStory
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V3A4_RoleStoryGameView
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity3_5Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity3_5EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.SurvivalView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.SurvivalView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity3_6Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity3_6EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.V3a6YaMi
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V3a6YaMiMainView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity3_7Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity3_7EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.TowerV3a7
	}, AudioBgmEnum.UsageType.View, {
		ViewName.TowerV3a7MapView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.SodacheMain
	}, AudioBgmEnum.UsageType.View, {
		ViewName.SodacheMainView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.SodacheMap
	}, AudioBgmEnum.UsageType.View, {
		ViewName.SodacheMapView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity3_8Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity3_8EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.V3a8Puzzle
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V3a8PuzzleView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.SP02_AtomicOperationActivityGame
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AtomicOperationActivityGameView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.SP02_AtomicDungeonMain
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AtomicDungeonMainView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.SP02_AtomicDungeonPolygonSelect
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AtomicDungeonPolygonSelectView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.SP02_AtomicDungeonTalent
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AtomicCultivateView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity3_10Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity3_10EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.SP02_AVGView
	}, AudioBgmEnum.UsageType.View, {
		ViewName.AtomicAvgPlayView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.VersionActivity3_9Main
	}, AudioBgmEnum.UsageType.View, {
		ViewName.VersionActivity3_9EnterView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.V3a9RacingGameMain
	}, AudioBgmEnum.UsageType.Scene, {
		SceneType.RacingCar
	})
	self:_addBgmUsage({
		AudioBgmEnum.Layer.V3a9RacingGameLobby
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V3a9RacingCarMainView,
		ViewName.V3a9RacingCarLoadingView
	}, nil, nil, true)
	self:_addBgmUsage({
		AudioBgmEnum.Layer.V3a9Bird
	}, AudioBgmEnum.UsageType.View, {
		ViewName.V3a9BirdMainView,
		ViewName.V3a9BirdGameView
	}, nil, nil, true)
end

function AudioBgmInfo:_initBgmBind()
	self:_addBgmBind(AudioBgmEnum.Layer.Dungeon, {
		AudioBgmEnum.Layer.DungeonAmbientSound
	})
	self:_addBgmBind(AudioBgmEnum.Layer.VersionActivity1_3Main, {
		AudioBgmEnum.Layer.VersionActivity1_3DungeonAmbientSound
	})
	self:_addBgmBind(AudioBgmEnum.Layer.VersionActivity3_0Main, {
		AudioBgmEnum.Layer.VersionActivity3_0MainAmbientSound
	})
end

function AudioBgmInfo:_addBgmBind(mainLayer, layerList)
	self._bgmBindMap[mainLayer] = layerList
end

function AudioBgmInfo:_addBgmUsage(layerList, type, typeParam, queryFunc, queryFuncTarget, clearPauseBgm)
	local bgmUsage = AudioBgmUsage.New()

	bgmUsage.layerList = layerList
	bgmUsage.type = type
	bgmUsage.typeParam = typeParam
	bgmUsage.queryFunc = queryFunc
	bgmUsage.queryFuncTarget = queryFuncTarget
	bgmUsage.clearPauseBgm = clearPauseBgm

	local list

	if type == AudioBgmEnum.UsageType.Scene then
		list = self._bgmUsageSceneMap
	elseif type == AudioBgmEnum.UsageType.View then
		list = self._bgmUsageViewMap
	end

	for i, param in ipairs(typeParam) do
		if list[param] then
			logError(string.format("AudioBgmInfo:_addBgmUsage typeParam:%s 重复设置了", param))
		end

		list[param] = bgmUsage
	end

	return bgmUsage
end

function AudioBgmInfo:_addBgmData(layer, playId, stopId, resumeId, pauseId, switchGroup, switchState)
	if not self._bgmDatas[layer] then
		local data = AudioBgmData.New()

		self._bgmDatas[layer] = data
		data.layer = layer
		data.playId = playId
		data.stopId = stopId
		data.pauseId = pauseId
		data.resumeId = resumeId
		data.switchGroup = switchGroup
		data.switchState = switchState

		if AudioMgr.instance:useDefaultBGM() and data.layer ~= AudioBgmEnum.Layer.Fight then
			data.playId = AudioEnum.Default_UI_Bgm
			data.stopId = AudioEnum.Default_UI_Bgm_Stop
		end
	end
end

function AudioBgmInfo:modifyBgmData(layer, playId, stopId, resumeId, pauseId, switchGroup, switchState)
	local data = self._bgmDatas[layer]

	if not data then
		data = AudioBgmData.New()
		self._bgmDatas[layer] = data
	end

	data.playId = playId
	data.stopId = stopId
	data.resumeId = resumeId
	data.pauseId = pauseId
	data.switchGroup = switchGroup
	data.switchState = switchState
end

function AudioBgmInfo:modifyBgmAudioId(layer, playId)
	local data = self._bgmDatas[layer]

	if not data or data.playId == playId then
		return false
	end

	data.playId = playId

	return true
end

function AudioBgmInfo:removeBgm(layer)
	self._bgmDatas[layer] = nil
end

function AudioBgmInfo:clearBgm(layer)
	local data = self._bgmDatas[layer]

	if not data then
		return
	end

	data:clear()
end

function AudioBgmInfo:getBgmData(layer)
	return self._bgmDatas[layer]
end

function AudioBgmInfo:getViewBgmUsage(viewName)
	return self._bgmUsageViewMap[viewName]
end

function AudioBgmInfo:getSceneBgmUsage(sceneType)
	return self._bgmUsageSceneMap[sceneType]
end

function AudioBgmInfo:getBindList(layer)
	return self._bgmBindMap[layer]
end

return AudioBgmInfo
