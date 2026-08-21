local TYPE_COLLECTION = 1
local TYPE_ITEM = 2
local TYPE_ORNAMENT = 3
local TYPE_CONSUME_ITEM = 2
local TYPE_COMMON_COLLECTION = 1
local TYPE_SUIT = 2
local TYPE_EQUIP = 3
local BattleItemWidget = require("uimodule.battle_bag.battle_item")
local ItemInfoClass = require("uimodule.battle_bag.item_info")
local OrnInfoClass = require("uimodule.battle_bag.orn_info")
local EquipInfoClass = require("uimodule.battle_bag.equip_item_info")
local Item_Helper = require("utils.item_helper")
local ITEM_TYPE_ICON_PREFIX = "UICommon2/Icon/%s"
local battle_item_cfg = ShareRes.create("battle.battle_item_type")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local CommonDefine = require("cs_share.common_define")
local RUNE2_SOURCE = CommonDefine.RUNE2_SOURCE
local Base = require("ui.uibase")
local M = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_item_info = {
    "ItemInfo",
    BIND_TYPE.OBJECT
  },
  v_equip_info = {
    "EquipInfo",
    BIND_TYPE.OBJECT
  },
  v_pick_btn = {
    "PickBtn",
    BIND_TYPE.BUTTON
  },
  v_sold_btn = {
    "SoldBtn",
    BIND_TYPE.BUTTON
  },
  v_replace_btn = {
    "ReplaceBtn",
    BIND_TYPE.BUTTON
  },
  v_price_img = {
    "CurrencyIcon",
    BIND_TYPE.IMAGE
  },
  v_price_lab = {
    "ItemPrice",
    BIND_TYPE.TEXT
  }
}
local SELL_TYPE = {
  AWARD = 1,
  RECOVER = 2,
  ADD_CURSE = 3
}
local SELL_ICON = {
  [SELL_TYPE.AWARD] = "CurrencyIcon",
  [SELL_TYPE.RECOVER] = "BloodIcon",
  [SELL_TYPE.ADD_CURSE] = "CurseIcon"
}
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local ADD_CURSE_TYPE = curse_com_def.ADD_CURSE_TYPE

function M:ui_finish_load()
  self:init_model(MODEL)
  self.item_ui = BattleItemWidget:ui_wrap(self, self.v_uiobjects.ItemObj)
  self.v_orn_info_view = OrnInfoClass:ui_wrap(self, self.v_uiobjects.OrnInfo, false)
  self.v_item_info_view = ItemInfoClass:ui_wrap(self, self.v_item_info, false)
  self.v_equip_info_view = EquipInfoClass:ui_wrap(self, self.v_equip_info, false)
  self:set_button_listener(self.v_pick_btn, function()
    self:_onclick_pick_btn()
  end)
  self:set_button("SoldBtn", function()
    self:_onclick_sold_btn()
    self:ui_hide()
  end)
  self:set_button("ReplaceBtn", function()
    if not self:_onclick_replace_btn() then
      if Global.sound_mgr then
        Global.sound_mgr:play_pick_sound()
      end
      self:ui_hide()
    end
  end)
end

function M:ui_on_show(item)
  self.v_no_click = false
  local last_ui = UIMgr:get_fight_last_ui()
  if not item or UIMgr:try_get_visible_ui("fight_pause_common") or UIMgr:try_get_visible_ui("challenge_ring_plus") or UIMgr:try_get_visible_ui("not_progress_battle_suc_settle") then
    self:ui_hide()
    return
  end
  self.v_item = item
  local item_id = item.item_id
  self.v_is_collect = Item_Helper.get_is_collect(item_id)
  self.v_is_rune = Item_Helper.get_is_rune_item(item_id)
  self.v_is_ornament = BattleOrnamentMgr:is_ornament(item_id)
  if self.v_is_ornament then
    local param = FightBagMgr:get_preview_random_entries(self.v_item.ran_ans_uuid)
    self.v_sell_param = param
  end
  self.v_item.is_equip = self.v_is_collect
  self.v_item.is_ornament = self.v_is_ornament
  self.v_item.is_rune = self.v_is_rune
  local need_compare = self.v_is_collect or self.v_is_rune or self.v_is_ornament
  self:set_item_info(item_id, item.count)
  self:set_operate_panel(need_compare)
  self:refresh_operate_btn_ui()
  self:set_price(need_compare, item_id)
  self:bind_auto_mq(Const.MSG_ON_ENTER_ROOM, self.ui_hide, self)
  self:bind_auto_mq(Const.MSG_ON_BATTLE_LOADING_START, self.ui_hide, self)
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.response_ui_show, self)
  UIMgr:get_ui("fight"):set_map_visible(false)
end

function M:response_ui_show()
end

function M:ui_on_hide()
  self.v_no_click = false
  self.v_orn_info_view:set_enable(false)
  self.v_item_info_view:set_enable(false)
  self.v_equip_info_view:set_enable(false)
  self.item_ui:set_enable(false)
  self.v_sell_param = nil
  local battle_orn_tips = UIMgr:try_get_ui("battle_orn_tips")
  if battle_orn_tips and battle_orn_tips:visible() then
    battle_orn_tips.v_is_wear_orn = self.v_is_wear_orn
    battle_orn_tips:ui_hide()
  end
  self.v_is_wear_orn = nil
  UIMgr:get_ui("fight"):set_map_visible(true)
end

function M:get_showing_item()
  return self.v_item
end

function M:set_item_info(item_id, count)
  local item_type = TYPE_ITEM
  local item_cfg = ShareRes.get_battle_item_cfg(item_id)
  local ui_components = self.v_uicompents
  if not item_cfg then
    item_cfg = ShareRes.get_battle_equip_cfg(item_id)
    item_type = TYPE_COLLECTION
  end
  if not item_cfg then
    item_cfg = ShareRes.create("item.ornaments", item_id)
    item_type = TYPE_ORNAMENT
  end
  if not item_cfg then
    Log.Error("道具或收藏品不存在", item_id)
  end
  if self.v_is_collect then
    ui_components.ItemType_txt.text = Util.format_str("收藏品")
  else
    local cfg = ShareRes.create("battle.battle_item_type", item_cfg.Type)
    ui_components.ItemType_txt.text = cfg.name
  end
  local param = {show_num = count}
  if self.v_is_collect then
    param.item_data = Item_Helper.build_equip_collect_data(item_id, self.v_item.ran_ans_uuid)
  elseif self.v_is_rune then
    param.item_data = {
      ran_ans_uuid = self.v_item.ran_ans_uuid
    }
  end
  if not self.v_is_ornament then
    self.item_ui:set_enable(true, item_id, param)
    self.v_uiobjects.OrnObj:SetActive(false)
    self.v_uiobjects.ItemObj:SetActive(true)
  else
    local bg_img = Util.get_image("Bg2_", self.v_uiobjects.OrnObj)
    ResMgr:load_set_icon(bg_img, BattleOrnamentMgr:get_ornament_bg_icon(item_cfg.Quality))
    local icon_img = Util.get_image("OrnIcon_", self.v_uiobjects.OrnObj)
    ResMgr:load_set_icon(icon_img, item_cfg.Icon)
    self.v_uiobjects.OrnObj:SetActive(true)
    local same_obj = Util.get_child("Same_", self.v_uiobjects.OrnObj)
    same_obj:SetActive(false)
    self.v_uiobjects.ItemObj:SetActive(false)
  end
  ui_components.ItemName_txt.text = Util.format_str(item_cfg.Name)
  if item_type == TYPE_ITEM then
    self.v_item_info_view:set_enable(true, item_id)
  elseif item_type == TYPE_COLLECTION then
    self.v_equip_info_view:set_enable(true, param.item_data)
  elseif item_type == TYPE_ORNAMENT then
    self.v_orn_info_view:set_enable(true, item_id)
  end
end

function M:set_operate_panel(is_equip)
  self.v_pick_btn:SetActive(not is_equip)
  self.v_sold_btn:SetActive(false)
  self.v_replace_btn:SetActive(is_equip)
end

function M:refresh_operate_btn_ui()
  Util.enable_btn(self.v_uicompents.ReplaceBtn_btn)
  local replace_btn_txt = self.v_uicompents.ReplaceBtnName_txt
  local btn_name = Util.format_str("交换")
  if self.v_is_rune or self.v_is_collect then
    btn_name = Util.format_str("拾取")
  end
  if self.v_is_ornament then
    btn_name = Util.format_str(BattleOrnamentMgr:get_null_pos() and "装备" or "替换")
    if BattleOrnamentMgr:is_have_same_ornament(self.v_item.item_id) then
      btn_name = Util.format_str("已有")
      local same_obj = Util.get_child("Same_", self.v_uiobjects.OrnObj)
      same_obj:SetActive(true)
      Util.disable_btn(self.v_uicompents.ReplaceBtn_btn, true, false)
    end
  end
  replace_btn_txt.text = btn_name
end

function M:set_price(is_equip, item_id)
  if not is_equip then
    return
  end
  local sell_type = self.v_sell_param and self.v_sell_param.sell_type and self.v_sell_param.sell_type or SELL_TYPE.AWARD
  if self.v_sell_param and self.v_sell_param.sell_type then
    if self.v_sell_param.sell_type == SELL_TYPE.AWARD then
      local sell_arg = self.v_sell_param.sell_arg
      local award_cfg = ShareRes.get_battle_item_cfg(sell_arg[1])
      if award_cfg then
        ResMgr:load_set_icon(self.v_uicompents.CurrencyIcon_img, "Icon/BattleItem/" .. award_cfg.Icon)
      else
        Log.Error("道具表中无ID为", sell_arg[1], "的配置信息")
      end
      self.v_price_lab.text = (sell_arg[2] > 0 and "+" or "") .. sell_arg[2]
    elseif self.v_sell_param.sell_type == SELL_TYPE.RECOVER then
      local magic_id = tonumber(self.v_sell_param.sell_arg[1] .. "1")
      local cfg = ShareRes.get_magic_cfg(magic_id)
      if not cfg then
        Log.Error("战斗饰品特效表中无ID为", magic_id, "的配置信息")
      else
        self.v_price_lab.text = "+" .. math.floor(cfg.logic[2][1] / 100) .. "%"
      end
    else
      self.v_price_lab.text = "-" .. self.v_sell_param.sell_arg[1]
    end
  else
    local sell_price = BattleShopMgr:get_sell_price_by_item_id(item_id)
    self.v_price_lab.text = (sell_price > 0 and "+" or "") .. sell_price
  end
  for type, img_name in ipairs(SELL_ICON) do
    self.v_uiobjects[img_name]:SetActive(sell_type == type)
  end
end

function M:_onclick_pick_btn()
  if Global.sound_mgr then
    Global.sound_mgr:play_pick_sound()
  end
  local item_cfg = Item_Helper.get_item_cfg(self.v_item.item_id)
  if item_cfg.Type == BagCfg.BATTLE_ITEM_TYPE.ORNAMENTS then
    UIMgr:get_ui("curse_ring_ornaments_dorp"):ui_show(self.v_item)
    self:ui_hide()
    return
  end
  if self.v_is_collect then
    self.v_item.is_need_equip = true
  end
  SceneMgr:get_scene_item_mgr():pick_item(self.v_item)
end

function M:_onclick_sold_btn()
  if self.v_is_rune or self.v_is_ornament then
    self.v_item.need_sell = true
    if self.v_sell_param and self.v_sell_param.sell_type == SELL_TYPE.ADD_CURSE then
      local value = -self.v_sell_param.sell_arg[1]
      ChallengeRingPlusMgr:record_fight_add_curse_value(ADD_CURSE_TYPE.SELL_ORN, value)
      ChallengeRingPlusMgr:record_sell_orn_curse_value(value)
    end
  end
  if self.v_is_collect then
    self.v_item.is_need_equip = false
  end
  if not self.v_no_click then
    SceneMgr:get_scene_item_mgr():pick_item(self.v_item)
    self.v_no_click = true
  end
end

function M:_onclick_replace_btn()
  local after_click_hold_ui = false
  
  local function get_callback(is_need)
    self.v_item.is_need_equip = is_need
    SceneMgr:get_scene_item_mgr():pick_item(self.v_item)
  end
  
  if self.v_is_rune then
    local npc_data = self.v_item.npc_data
    local source_type = npc_data and RUNE2_SOURCE.NPC_DROP or RUNE2_SOURCE.DROP
    UIMgr:get_ui("ui_rune_set"):ui_show(self.v_item, source_type)
    return after_click_hold_ui
  end
  if self.v_is_collect then
    self.v_item.is_need_equip = true
    if not self.v_no_click then
      SceneMgr:get_scene_item_mgr():pick_item(self.v_item)
      self.v_no_click = true
    end
  end
  if self.v_is_ornament then
    if not BattleOrnamentMgr:get_select_pos() and not BattleOrnamentMgr:get_null_pos() then
      UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("槽位已满，请选择需替换的奇珍"))
      after_click_hold_ui = true
    else
      if not self.v_no_click then
        SceneMgr:get_scene_item_mgr():pick_item(self.v_item)
        self.v_no_click = true
      end
      self.v_is_wear_orn = true
    end
  end
  return after_click_hold_ui
end

return M
