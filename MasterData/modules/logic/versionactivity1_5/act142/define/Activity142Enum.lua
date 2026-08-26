-- chunkname: @modules/logic/versionactivity1_5/act142/define/Activity142Enum.lua

module("modules.logic.versionactivity1_5.act142.define.Activity142Enum", package.seeall)

local Activity142Enum = _M

Activity142Enum.UI_BlOCK_KEY = "Activity142UIBlock"
Activity142Enum.RETURN_CHECK_POINT = "Activity142ReturnCheckPoint"
Activity142Enum.RESET_GAME = "Activity142ResetGame"
Activity142Enum.FIRING_BALL = "Activity142FiringBall"
Activity142Enum.SWITCH_PLAYER = "Activity142PlayerBorn"
Activity142Enum.PLAY_MAP_VIEW_ANIM = "Activity142MapViewPlayAnim"
Activity142Enum.MAP_ITEM_UNLOCK = "Activity142MapItemUnlock"
Activity142Enum.MAP_CATEGORY_UNLOCK = "Activity142CategoryUnlock"
Activity142Enum.EPISODE_STAR_UNLOCK = "Activity142EpisodeStarUnlock"
Activity142Enum.COLLECTION_UNLOCK = "Activity142CollectionUnlock"
Activity142Enum.STORY_REVIEW_UNLOCK = "Activity142StoryReviewUnlock"
Activity142Enum.MAX_EPISODE_SINGLE_CHAPTER = 4
Activity142Enum.MAX_EPISODE_SINGLE_SP_CHAPTER = 3
Activity142Enum.TASK_ALL_RECEIVE_ITEM_EMPTY_ID = -100
Activity142Enum.MAX_FIRE_BALL_NUM = 5
Activity142Enum.COLLECTION_VIEW_OFFSET = 0.015
Activity142Enum.DEFAULT_STAR_NUM = 1
Activity142Enum.AUTO_ENTER_EPISODE_ID = 1
Activity142Enum.NOT_PLAY_UNLOCK_ANIM_CHAPTER = 1
Activity142Enum.OPEN_MAP_VIEW_TIME = 1
Activity142Enum.CLOSE_MAP_VIEW_TIME = 0.3
Activity142Enum.MAP_VIEW_SWITCH_ANIM = "switch"
Activity142Enum.MAP_VIEW_SWITCH_SET_MAP_ITEM_ANIM_TIME = 0.16
Activity142Enum.CATEGORY_IDLE_ANIM = "idle"
Activity142Enum.CATEGORY_UNLOCK_ANIM = "unlock"
Activity142Enum.CATEGORY_CACHE_KEY = "ACT142_CATEGORY_IS_UNLOCK"
Activity142Enum.MAP_ITEM_IDLE_ANIM = "idle"
Activity142Enum.MAP_ITEM_UNLOCK_ANIM = "unlock"
Activity142Enum.MAP_ITEM_CACHE_KEY = "ACT142_MAP_ITEM_IS_UNLOCK"
Activity142Enum.MAP_STAR_IDLE_ANIM = "idle"
Activity142Enum.MAP_STAR_OPEN_ANIM = "open"
Activity142Enum.MAP_STAR_CACHE_KEY = "ACT142_MAP_STAR_IS_UNLOCK"
Activity142Enum.COLLECTION_IDLE_ANIM = "idle"
Activity142Enum.COLLECTION_UNLOCK_ANIM = "unlock"
Activity142Enum.COLLECTION_CACHE_KEY = "ACT142_COLLECTION_IS_UNLOCK"
Activity142Enum.STORY_REVIEW_IDLE_ANIM = "idle"
Activity142Enum.STORY_REVIEW_UNLOCK_ANIM = "unlock"
Activity142Enum.STORY_REVIEW__CACHE_KEY = "ACT142_STORY_REVIEW_IS_UNLOCK"
Activity142Enum.PLAYER_SWITCH_TIME = 1.5
Activity142Enum.SWITCH_OPEN_ANIM = "swopen"
Activity142Enum.SWITCH_CLOSE_ANIM = "swclose"
Activity142Enum.GAME_VIEW_CLOSE_EYE_TIME = 0.5
Activity142Enum.GAME_VIEW_EYE_CLOSE_ANIM = "open"
Activity142Enum.GAME_VIEW_EYE_OPEN_ANIM = "close"
Activity142Enum.CanBlockFireBallInteractType = {
	[Va3ChessEnum.InteractType.Player] = true,
	[Va3ChessEnum.InteractType.AssistPlayer] = true,
	[Va3ChessEnum.InteractType.Obstacle] = true,
	[Va3ChessEnum.InteractType.Brazier] = true,
	[Va3ChessEnum.InteractType.BoltLauncher] = true,
	[Va3ChessEnum.InteractType.StandbyTrackEnemy] = true,
	[Va3ChessEnum.InteractType.SentryEnemy] = true,
	[Va3ChessEnum.InteractType.TriggerFail] = true
}
Activity142Enum.CanFireKillInteractType = {
	[Va3ChessEnum.InteractType.StandbyTrackEnemy] = true,
	[Va3ChessEnum.InteractType.SentryEnemy] = true,
	[Va3ChessEnum.InteractType.TriggerFail] = true
}
Activity142Enum.CanMoveKillInteractType = {
	[Va3ChessEnum.InteractType.SentryEnemy] = true
}
Activity142Enum.HorBaffleResPath = {
	[0] = "scenes/v1a5_m_s12_dfw_krd/perefab/stone_a.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_b.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_c.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_d.prefab"
}
Activity142Enum.VerBaffleResPath = {
	[0] = "scenes/v1a5_m_s12_dfw_krd/perefab/stone_e.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_f.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_g.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_h.prefab"
}
Activity142Enum.BrokenGroundItemPath = "scenes/v1a5_m_s12_dfw_krd/perefab/diban_xianjing.prefab"
Activity142Enum.SwitchPlayerEffPath = "scenes/v1a5_m_s12_dfw_krd/perefab/vx_fire.prefab"
Activity142Enum.BaffleOffset = {
	baffleOffsetY = 0.44,
	baffleOffsetX = 0.64
}

return Activity142Enum
