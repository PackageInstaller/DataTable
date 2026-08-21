local M = {}
M.MAGIC_TYPE = {
  ChangeTimeScale = 1,
  ChangeAttribAdditive = 2,
  AddBehavior = 3,
  ShakeCamera = 4,
  TrackCamera = 5,
  SetNpcStatus = 6,
  HideJoint = 7,
  PlayEffect = 8,
  NoLogic = 9,
  ForceShift = 10,
  CamPosition = 11,
  CamTransform = 12,
  CamFOV = 13,
  ChangeAttr = 14,
  SkillEnergy = 15,
  FightBtnEffect = 16,
  HurtDamage = 17,
  UIObjectVisble = 19,
  SetArmor = 20,
  DamageCorrect = 21,
  RgbSplit = 22,
  Heal = 23,
  HealCorrect = 24,
  HpShield = 25,
  SparmorCorrect = 26,
  BeGrab = 27,
  BeThrow = 28,
  CamFocusBlur = 29,
  CritCorret = 30,
  SkillMaxEnergy = 31,
  ShakeBone = 32,
  ChangeModelScale = 33,
  EnergyRecovery = 34,
  TempBlue = 35,
  CutHpShield = 36,
  SPECAIL_DMG = 37,
  KILL_LEVEL = 38,
  DemageImmune = 39,
  CameraDutch = 40,
  Trigger = 41,
  ForbidSwitchHero = 42,
  ChangeTough = 43,
  ChangeAbnormalStatus = 44,
  CustomEvent = 45,
  ElementAbnormalEffect = 46,
  DamageSharing = 47,
  ChangeWeaponAttachPoint = 48,
  SpecialElementAbnormalEffect = 49,
  VisibleMesh = 50,
  Abnormal_Flag = 51,
  SnapShot_Sound = 52,
  AttrLimit = 53
}
M.MAGIC_REBORT_TYPE = {
  [M.MAGIC_TYPE.ChangeAttr] = true,
  [M.MAGIC_TYPE.ChangeAttribAdditive] = true,
  [M.MAGIC_TYPE.HurtDamage] = true
}
M.UPDATE_TYPE = {
  SeparateTime = 1,
  RTimeClearAll = 2,
  RTimeClearOne = 3,
  RTimeClearALLAbortOne = 4
}
M.IMMUNIT_TYPE = {
  ImmunityAll = 1,
  ExceptHad = 2,
  ExceptAdd = 3
}
M.MAGIC_REPORT_ON_EFFECT = {
  [M.MAGIC_TYPE.HurtDamage] = true,
  [M.MAGIC_TYPE.Heal] = true
}
M.MAGIC_BROARDCAST_TYPE = {
  NONE = 0,
  BEGIN_END = 1,
  SELF_ACTION_END = 2,
  ONLY_BEGIN = 3,
  ONLY_END = 4
}
M.EFFECT_BIND_TYPE = {
  SCENE_MAGIC = 1,
  ONLY_POS = 2,
  ONLY_ROTATION = 3
}
M.MAGIC_CUSTOM_EVENTS_DEFINE_TYPE = {
  COPY_ATTR = 1,
  DEDUCT_HP = 2,
  CHANGE_ATTR = 3
}
M.TIME_SCELE_TYPE = {
  ALL = 1,
  EXCEPT_EFFECT = 2,
  EXCEPT_LIFE = 3,
  NONE = 4,
  UNSCALE = 5
}
M.DAMAGE_CORRECT_EFFECT_TYPE = {
  ONCE = 0,
  EFFECT_COUNT = 1,
  MAGIC_LIFE = 2
}
M.MAGIC_EFFECT_TYPE = {
  EVENT = 1,
  EFFECT_FUNC = 2,
  OBJECT = 3
}
return M
