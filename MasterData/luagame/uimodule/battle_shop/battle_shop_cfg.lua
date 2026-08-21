local cfg = {}
cfg.BATTLE_EQUIP_CFG_PATH = "battle.battle_collection"
cfg.BATTLE_ITEM_CFG_PATH = "battle.battle_item"
cfg.BATTLE_ITEM_BUY_CFG_PATH = "battle.battle_item_buy"
cfg.BATTLE_SHOP_REFRESH = "battle.battle_shop_refresh"
cfg.BATTLE_SHOP_ITEM_KEY = "BATTLE_SHOP_ITEM_KEY"
cfg.BATTLE_SHOP_ELETEM_KEY = "BATTLE_SHOP_ELETEM_KEY"
cfg.SHOP_TOGGLE = {BUY = 1, SELL = 2}
cfg.SHOP_TOOGLE_TEXT = {
  [1] = Util.format_str("购买"),
  [2] = Util.format_str("出售")
}
cfg.ITEM_TYPE_IDX = {"EQUIP", "ITEM"}
cfg.ITEM_TYPE_TOGGLE = {}
for idx, type_name in pairs(cfg.ITEM_TYPE_IDX) do
  cfg.ITEM_TYPE_TOGGLE[type_name] = idx
end
cfg.ITEM_TYPE_CFG = {
  [1] = {obj_name = "Equip"},
  [2] = {obj_name = "Item"}
}
cfg.ITEM_TYPE_TOGGLE_TEXT = {
  [1] = Util.format_str("武器"),
  [2] = Util.format_str("道具")
}
return cfg
