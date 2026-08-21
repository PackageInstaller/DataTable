local Cfg = {}
Cfg.WEAPEN_IDX = 1
Cfg.ITEM_IDX = 2
Cfg.PUZZLE_IDX = 3
Cfg.QUALITYS = {QUALITY_3 = 3, QUALITY_4 = 4}
Cfg.ITEM_TYPE = {
  ALL = 1,
  COMSUME = 2,
  MATS = 3,
  OTHERS = 4
}
Cfg.MAX_ITEM_DURATION = 31536000
Cfg.IMPORTANT_QUALITY = {
  [5] = true
}
Cfg.TRIGGER_DYNAMIC_EFFECT_TYPE = {
  SHOW = 1,
  PAGE = 2,
  LEFT_VIEW_SHOW = 3,
  LEFT_VIEW_HIDE = 4
}
Cfg.CAPACITY = {
  [Cfg.WEAPEN_IDX] = ShareRes.get_bag_capacity_by_award_type(Config.AWARD_TYPE.EQUIP),
  [Cfg.ITEM_IDX] = ShareRes.get_bag_capacity_by_award_type(Config.AWARD_TYPE.ITEM)
}
return Cfg
