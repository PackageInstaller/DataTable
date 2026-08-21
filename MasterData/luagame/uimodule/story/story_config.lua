local ShareRes = require("utils.share_res")
local common_def = require("cs_share.common_define")
local M = {}
M.STEP_TYPE = {
  CHAPTER_BG_ANIM = "Background",
  CHARACTER = "Character",
  ROLE_TALK = "Talking",
  BG_TALK = "BgTalk",
  FIGHT_TALK = "FightTalk",
  CAPTIONS_TALK = "CaptionsTalk",
  EFFECT = "Effects",
  SOUND = "Sound",
  BRANCH = "Selection",
  FIGHT_BRANCH = "FightBranch",
  NO_BRANCH = "NoBranch",
  CAMERA_EFFECT = "Camera",
  INSERT = "Insert",
  CHANGE_ANIM = "ChangeScene",
  TIMELINE = "TimelineData",
  WRITE_NAME = "WriteName",
  PLAYER_SETTING = "PlayerSetting"
}
M.STEP_LUA_PATH = {
  [M.STEP_TYPE.CHAPTER_BG_ANIM] = "uimodule.story.step_bg",
  [M.STEP_TYPE.ROLE_TALK] = "uimodule.story.step_talk",
  [M.STEP_TYPE.BG_TALK] = "uimodule.story.step_bg_talk",
  [M.STEP_TYPE.FIGHT_TALK] = "uimodule.story.step_fight_talk",
  [M.STEP_TYPE.CAPTIONS_TALK] = "uimodule.story.step_captions_talk",
  [M.STEP_TYPE.CHARACTER] = "uimodule.story.step_char",
  [M.STEP_TYPE.EFFECT] = "uimodule.story.step_effect",
  [M.STEP_TYPE.SOUND] = "uimodule.story.step_sound",
  [M.STEP_TYPE.BRANCH] = "uimodule.story.step_branch",
  [M.STEP_TYPE.CAMERA_EFFECT] = "uimodule.story.step_camera_effect",
  [M.STEP_TYPE.INSERT] = "uimodule.story.step_insert",
  [M.STEP_TYPE.CHANGE_ANIM] = "uimodule.story.step_change_anim",
  [M.STEP_TYPE.TIMELINE] = "uimodule.story.step_timeline",
  [M.STEP_TYPE.WRITE_NAME] = "uimodule.story.step_player_setting",
  [M.STEP_TYPE.PLAYER_SETTING] = "uimodule.story.step_player_setting"
}
M.NO_SPEED_CHANGE = {
  [M.STEP_TYPE.CHANGE_ANIM] = true,
  [M.STEP_TYPE.CAPTIONS_TALK] = true
}
M.SHOW_FIGHT_UI = {
  [M.STEP_TYPE.CAPTIONS_TALK] = true,
  [M.STEP_TYPE.FIGHT_BRANCH] = true
}
M.TALK_TYPE = {
  ROLE_TALK = 0,
  BG_TALK = 1,
  FIGHT_TALK = 2,
  CAPTIONS_TALK = 3
}
M.SPECIAL_STRING_FUN = {
  BBNAME = "_get_player_name"
}
M.PLAY_MODE = {AUTO_OFF = 0, AUTO_ON = 1}
M.UP_SPEED = 35
M.SPEED_DEFAULT = 1
M.CLICK_SPEED = 100
M.FADE_TXT_DEFAULT_SPEED = 20
M.GARBLED_DEFAULT_SPEED = 4
M.BRANCH_NUM = 4
M.MAX_CHAR_NUM = 6
M.BACKGROUND_BLUR_TYPE = {
  NONE = 0,
  SHOW = 1,
  HIDE = 2
}
M.STEP_PLAY_TYPE = {DEFAULT = 0, INSERT_PLAY = 1}
return M
