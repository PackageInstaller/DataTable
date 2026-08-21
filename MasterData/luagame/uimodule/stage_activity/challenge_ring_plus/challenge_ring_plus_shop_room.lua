local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CommonDefine = require("cs_share.common_define")
local CURSE_CARD_TYPE = CommonDefine.CURSE_CARD_TYPE
local CHAL_TYPE2FORMN_TYPE = CommonDefine.CHAL_TYPE2FORMN_TYPE
local bagConfig = require("gamelogic.character.fight_bag_configs")
local Item_Helper = require("utils.item_helper")
local Card_Destory_Help = require("uimodule.stage_activity.challenge_ring_plus.curse_card_destory_helper")
local CURSE_OBJ_CALSS = require("uimodule.stage_activity.challenge_ring_plus.curse_obj")
local CHALLENGE_RING_SHOP_ROOM_ITEM_CLASS = require("uimodule.stage_activity.challenge_ring_plus.challene_ring_plus_shop_room_item")
local CHALLENGE_RING_CHAR_LIST_CLASS = require("uimodule.stage_activity.challenge_ring_plus.challene_ring_plus_char_list")
local CHALLENGE_RING_ORNAMENT_SLOT_CLASS = require("uimodule.stage_activity.challenge_ring_plus.challene_ring_plus_ornament_slot_pos")
local CHALLENGE_RING_SHOP_ROOM_ITEM_KEY = "CHALLENGE_RING_SHOP_ROOM_ITEM_KEY"
local CHALLENGE_RING_SHOP_ROOM_CHAR_HEAD = "CHALLENGE_RING_SHOP_ROOM_CHAR_HEAD"
local CHALLENGE_RING_SHOP_ROOM_ORNAMENT_SLOT = "CHALLENGE_RING_SHOP_ROOM_ORNAMENT_SLOT"
local curse_common_define = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local ADD_CURSE_TYPE = curse_common_define.ADD_CURSE_TYPE
local SELECT_IMG_CLOSE = 0
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_char_content = {
    "CharContent",
    BIND_TYPE.OBJECT
  },
  v_char_tem = {
    "CharTem",
    BIND_TYPE.OBJECT
  },
  v_team_rune_lv = {
    "TeamRuneLv",
    BIND_TYPE.TEXT
  },
  v_ornament_content = {
    "OrnamentContent",
    BIND_TYPE.OBJECT
  },
  v_ornament_tem = {
    "OrnamentTem",
    BIND_TYPE.OBJECT
  },
  v_shop_item_content = {
    "ShopItemContent",
    BIND_TYPE.OBJECT
  },
  v_shop_item_tem = {
    "ShopItemTem",
    BIND_TYPE.OBJECT
  },
  v_curse_obj = {
    "CurseObj",
    BIND_TYPE.OBJECT
  },
  v_change_ornament_layout = {
    "ChangeOrnamentLayout",
    BIND_TYPE.OBJECT
  },
  v_have_item_now_layout = {
    "HaveItemNow",
    BIND_TYPE.OBJECT
  },
  v_none_item_now_layout = {
    "NoneItemNow",
    BIND_TYPE.OBJECT
  },
  v_item_quality_now = {
    "ItemQualityNow",
    BIND_TYPE.IMAGE
  },
  v_item_icon_now = {
    "ItemIconNow",
    BIND_TYPE.IMAGE
  },
  v_item_name_now = {
    "ItemNameNow",
    BIND_TYPE.TEXT
  },
  v_item_desc_now = {
    "ItemDescNow",
    BIND_TYPE.TEXT
  },
  v_item_quality_next = {
    "ItemQualityNext",
    BIND_TYPE.IMAGE
  },
  v_item_icon_next = {
    "ItemIconNext",
    BIND_TYPE.IMAGE
  },
  v_item_name_next = {
    "ItemNameNext",
    BIND_TYPE.TEXT
  },
  v_item_desc_next = {
    "ItemDescNext",
    BIND_TYPE.TEXT
  },
  v_gold_icon_next = {
    "GoldIconNext",
    BIND_TYPE.IMAGE
  },
  v_gold_num_next = {
    "GoldNumNext",
    BIND_TYPE.TEXT
  },
  v_curse_icon_next = {
    "CurseIconNext",
    BIND_TYPE.IMAGE
  },
  v_curse_num_next = {
    "CurseNumNext",
    BIND_TYPE.TEXT
  },
  v_btn_pay_gold = {
    "BtnPayGold",
    BIND_TYPE.BUTTON
  },
  v_btn_pay_curse = {
    "BtnPayCurse",
    BIND_TYPE.BUTTON
  },
  v_gold_need_num = {
    "GoldNeed",
    BIND_TYPE.TEXT
  },
  v_curse_need_num = {
    "CurseNeed",
    BIND_TYPE.TEXT
  },
  v_btn_gold_icon = {
    "BtnPayGoldIcon",
    BIND_TYPE.IMAGE
  },
  v_btn_curse_icon = {
    "BtnPayCurseIcon",
    BIND_TYPE.IMAGE
  },
  v_asset_item = {
    "AssetItem",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    if self.v_change_ornament_layout.activeInHierarchy then
      self:refresh_ornament_view(false)
    else
      Card_Destory_Help.confirm_quit_ui(self)
    end
  end)
  self:set_button("BtnPayGold", function()
    self:click_btn_ornament_pay(false)
  end)
  self:set_button("BtnPayCurse", function()
    self:click_btn_ornament_pay(true)
  end)
  self:set_button("CloseOrntipsBtn", function()
    self:close_orn_tips()
  end)
  self:register_exist_auto_template(CHALLENGE_RING_SHOP_ROOM_ITEM_KEY, self.v_shop_item_tem, self.v_shop_item_content)
  self:register_exist_auto_template(CHALLENGE_RING_SHOP_ROOM_CHAR_HEAD, self.v_char_tem, self.v_char_content)
end

function ui:ui_on_show(goods_list, type, npc_data)
  if npc_data then
    goods_list = FunctionalNpcMgr:get_shop_data().shop_data
  end
  self:refresh_data(goods_list, type, npc_data)
end

function ui:refresh_data(goods_list, type, npc_data)
  self.v_goods_list = goods_list
  self.v_type = type
  self.v_npc_data = npc_data
  self:bind_event()
  self:set_curse_view()
  self:refresh_currency()
  self:set_objs_state_by_type()
end

function ui:ui_on_hide()
  self.v_ornament_slot_select_img = nil
  self.v_select_ornament_slot_pos = nil
  self.v_select_ornament_id = nil
  self.v_next_ornament_id = nil
  self.v_next_ornament_index = nil
  self.v_select_good_data = nil
  self:remove_wrap_shop_item_list()
  self:remove_wrap_char_head_list()
  self:remove_wrap_ornament_slot_list()
  self:clear_wrap_curse_obj()
end

function ui:ui_on_destroy()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_goods_list, self.v_type, self.v_npc_data
end

function ui:bind_event()
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DIAMOND_UPDATE, self.refresh_currency, self)
end

function ui:set_curse_view()
  if not self.v_npc_data then
    self.v_curse_view = CURSE_OBJ_CALSS:ui_wrap(self, self.v_curse_obj, false)
    self.v_curse_view:set_enable(true)
    self.v_btn_pay_curse.gameObject:SetActive(true)
    self.v_uiobjects.PriceCurse:SetActive(true)
  else
    self.v_curse_obj:SetActive(false)
    self.v_btn_pay_curse.gameObject:SetActive(false)
    self.v_uiobjects.PriceCurse:SetActive(false)
  end
end

function ui:refresh_currency()
  local moneyId = bagConfig.SHOW_CURRENCY[1]
  local cfg = FightBagMgr:get_cfg_by_id(moneyId)
  local moneyIcon = Util.get_image("Label", self.v_asset_item)
  ResMgr:load_set_icon(moneyIcon, UtilUI.get_battle_item_icon(cfg.Id))
  local moneyTxt = Util.get_text("Aomunt", self.v_asset_item)
  moneyTxt.text = CharacterMgr:get_res_val(moneyId)
end

function ui:close_orn_tips()
  self.v_uiobjects.CloseOrntipsBtn:SetActive(false)
  self.v_uiobjects.Orntips:SetActive(false)
end

function ui:set_objs_state_by_type()
  self.v_shop_item_content:SetActive(true)
  self.v_change_ornament_layout:SetActive(false)
  self:set_shop_item_info()
  if self.v_type == CURSE_CARD_TYPE.SHOP_RUNE then
    self.v_char_content:SetActive(true)
    self:set_char_list_view()
  elseif self.v_type == CURSE_CARD_TYPE.SHOP_ORNAMENTS then
    self.v_char_content:SetActive(false)
  end
end

function ui:set_char_list_view()
  self:give_back_auto_cache(CHALLENGE_RING_SHOP_ROOM_CHAR_HEAD, false)
  local fight_info = TowerMgr:get_fight_info()
  local fight_type = 0 == fight_info.type and 1 or fight_info.type
  local formation_type = CHAL_TYPE2FORMN_TYPE[fight_type]
  local cur_id = FormationMgr:get_formation_use_id(formation_type, fight_type)
  local _, team_list = FormationMgr:get_formation_info_by_id(formation_type, cur_id, fight_type)
  self:remove_wrap_char_head_list()
  self.v_char_head_list = {}
  local team_rune_sum_lv = 0
  for _, data in ipairs(team_list) do
    local buddy_id = data.buddy_id
    if buddy_id > 0 then
      local char_head_obj = self:get_auto_cache(CHALLENGE_RING_SHOP_ROOM_CHAR_HEAD)
      local char_head_lua_obj = CHALLENGE_RING_CHAR_LIST_CLASS:ui_wrap_ex(self, char_head_obj, true)
      local hero = SceneMgr:get_hero_by_id(buddy_id)
      char_head_lua_obj:set_data(hero, self.v_type)
      team_rune_sum_lv = team_rune_sum_lv + char_head_lua_obj:get_rune_lv()
      table.insert(self.v_char_head_list, char_head_lua_obj)
    end
  end
  self.v_team_rune_lv.text = team_rune_sum_lv
end

function ui:set_shop_item_info()
  self:give_back_auto_cache(CHALLENGE_RING_SHOP_ROOM_ITEM_KEY, false)
  self:remove_wrap_shop_item_list()
  self.v_shop_item_list = {}
  for index, good_data in ipairs(self.v_goods_list) do
    local shop_item = self:get_auto_cache(CHALLENGE_RING_SHOP_ROOM_ITEM_KEY)
    local shop_item_lua_obj = CHALLENGE_RING_SHOP_ROOM_ITEM_CLASS:ui_wrap_ex(self, shop_item, true)
    shop_item_lua_obj:set_data(good_data, self.v_type, index, self.v_npc_data)
    table.insert(self.v_shop_item_list, shop_item_lua_obj)
  end
end

function ui:set_ornament_slot_info()
  self:give_back_auto_cache(CHALLENGE_RING_SHOP_ROOM_ORNAMENT_SLOT, false)
  self:remove_wrap_ornament_slot_list()
  self.v_ornament_slot_list = {}
  self.v_ornament_slot_select_img = {}
  local ornament_list = BattleOrnamentMgr:get_ornaments_list()
  if not ornament_list then
    return
  end
  for pos, ornament_data in ipairs(ornament_list) do
    local ornament_slot_obj = self:get_auto_cache(CHALLENGE_RING_SHOP_ROOM_ORNAMENT_SLOT)
    local ornament_slot_lua_obj = CHALLENGE_RING_ORNAMENT_SLOT_CLASS:ui_wrap_ex(self, ornament_slot_obj, true)
    ornament_slot_lua_obj:set_data(pos, ornament_data.item_id)
    local select_obj = self:get_child_gameobj("Select", ornament_slot_obj)
    select_obj:SetActive(false)
    table.insert(self.v_ornament_slot_select_img, select_obj)
    table.insert(self.v_ornament_slot_list, ornament_slot_lua_obj)
  end
end

function ui:refresh_select_ornament_pos_info(pos, item_id)
  self.v_select_ornament_slot_pos = pos
  self.v_select_ornament_id = item_id
  self:refresh_select_ornament_slot_info()
end

function ui:refresh_select_ornament_slot_info()
  if self.v_change_ornament_layout.activeInHierarchy then
    if self.v_select_ornament_id then
      self.v_have_item_now_layout:SetActive(true)
      self.v_none_item_now_layout:SetActive(false)
      local item_obj = Util.get_child("ItemObj", self.v_have_item_now_layout)
      item_obj.gameObject:SetActive(false)
      local now_item_cfg = ShareRes.create("item.ornaments", self.v_select_ornament_id)
      ResMgr:load_set_icon(self.v_uicompents.OrnQualityNow_img, BattleOrnamentMgr:get_ornament_bg_icon(now_item_cfg.Quality))
      ResMgr:load_set_icon(self.v_uicompents.OrnIconNow_img, now_item_cfg.Icon)
      self.v_item_name_now.text = now_item_cfg.Name
      self.v_item_desc_now.text = now_item_cfg.Desc
    else
      self.v_have_item_now_layout:SetActive(false)
      self.v_none_item_now_layout:SetActive(true)
    end
    self:set_select_img_state(self.v_select_ornament_slot_pos)
  elseif self.v_select_ornament_id then
    self:set_select_img_state(self.v_select_ornament_slot_pos)
    local item_cfg = Item_Helper.get_item_cfg(self.v_select_ornament_id)
    local content_pos = {
      pos_x = -450,
      pos_y = 450 - (self.v_select_ornament_slot_pos - 1) * 100
    }
    local path = string.format("Icon/BattleItem/%s", item_cfg.Icon)
    local show_info = {
      name = item_cfg.Name,
      desc = "<color=#FCBA00>" .. item_cfg.Desc .. "</color>",
      icon_path = path,
      is_hide_effct_desc = true
    }
    self.v_uicompents.OrnDesc_txt.text = item_cfg.Desc
    if 5 == item_cfg.Quality then
      self.v_uicompents.OrnDesc_txt.color = BattleOrnamentMgr:get_ornament_color(item_cfg.Quality)
    else
      self.v_uicompents.OrnDesc_txt.color = BattleOrnamentMgr:get_ornament_color(0)
    end
    self.v_uicompents.Point_img.color = BattleOrnamentMgr:get_ornament_color(item_cfg.Quality)
    local target_pos = self.v_ornament_slot_list[self.v_select_ornament_slot_pos]:get_object_transform().position
    target_pos.x = target_pos.x + 0.7
    target_pos.y = target_pos.y + 0.5
    self.v_uiobjects.Orntips.transform.position = target_pos
    self.v_uiobjects.Orntips:SetActive(true)
    self.v_uiobjects.CloseOrntipsBtn:SetActive(true)
  else
    self:set_select_img_state(SELECT_IMG_CLOSE)
  end
end

function ui:refresh_ornament_view(is_show_change_ornament_layout)
  if is_show_change_ornament_layout then
    self.v_change_ornament_layout:SetActive(true)
    self.v_shop_item_content:SetActive(false)
    local slot_pos = 1
    local ornament_list = BattleOrnamentMgr:get_ornaments_list()
    if ornament_list then
      for pos, ornament_data in ipairs(ornament_list) do
        if not ornament_data.item_id or ornament_data.item_id <= 0 then
          slot_pos = ornament_data.id
          break
        end
      end
    end
    if self.v_ornament_slot_list[slot_pos] then
      self.v_ornament_slot_list[slot_pos]:on_click_btn()
    end
  else
    self.v_change_ornament_layout:SetActive(false)
    self.v_shop_item_content:SetActive(true)
    self:set_select_img_state(SELECT_IMG_CLOSE)
  end
end

function ui:refresh_ornament_replace_info(good_data, index)
  self.v_select_good_data = good_data
  self.v_next_ornament_id = good_data.id
  self.v_next_ornament_index = index
  local next_item_cfg = ShareRes.create("item.ornaments", good_data.id)
  ResMgr:load_set_icon(self.v_uicompents.OrnQualityNext_img, BattleOrnamentMgr:get_ornament_bg_icon(next_item_cfg.Quality))
  ResMgr:load_set_icon(self.v_uicompents.OrnIconNext_img, next_item_cfg.Icon)
  self.v_item_name_next.text = next_item_cfg.Name
  self.v_item_desc_next.text = next_item_cfg.Desc
  self.v_gold_num_next.text = ChallengeRingPlusMgr:get_after_discount_price(next_item_cfg.BuyCostCnt)
  self.v_curse_num_next.text = ChallengeRingPlusMgr:get_after_discount_curse_price(next_item_cfg.CurseCostCnt)
  self.v_gold_need_num.text = ChallengeRingPlusMgr:get_after_discount_price(next_item_cfg.BuyCostCnt)
  self.v_curse_need_num.text = ChallengeRingPlusMgr:get_after_discount_curse_price(next_item_cfg.CurseCostCnt)
end

function ui:click_btn_ornament_pay(is_use_curse_value, ornament_id, goods_index)
  local item_cfg = Item_Helper.get_item_cfg(ornament_id)
  local need_curse
  if BattleOrnamentMgr:is_have_same_ornament(ornament_id) then
    Util.show_message_tip(2286)
    return
  end
  if is_use_curse_value then
    need_curse = ChallengeRingPlusMgr:get_after_discount_curse_price(item_cfg.CurseCostCnt)
    if not ChallengeRingPlusMgr:is_can_buy(need_curse) then
      Util.show_message_tip(2115)
      return
    end
  else
    local moneyId = item_cfg.BuyCostId
    local cost_num = ChallengeRingPlusMgr:get_after_discount_price(item_cfg.BuyCostCnt)
    if cost_num > CharacterMgr:get_res_val(moneyId) then
      Util.show_message_tip(2115)
      return
    end
  end
  
  local function suc_cb()
    Util.show_message_tip(2048)
    self:ui_hide()
  end
  
  local pos = BattleOrnamentMgr:get_null_pos()
  if self.v_npc_data then
    BattleOrnamentMgr:buy_ornament_by_npc_shop(self.v_npc_data.npc_id, self.v_select_good_data.index, nil, pos, nil)
  else
    if is_use_curse_value then
      ChallengeRingPlusMgr:record_fight_add_curse_value(ADD_CURSE_TYPE.SHOP_BUY, need_curse)
    else
      ChallengeRingPlusMgr:set_is_not_use_curse_buy(true)
    end
    ChallengeRingPlusMgr:request_purchase_ornament(goods_index, is_use_curse_value, pos, suc_cb)
  end
end

function ui:set_select_img_state(pos)
  for index, select_img in ipairs(self.v_ornament_slot_select_img) do
    select_img:SetActive(index == pos)
  end
end

function ui:remove_wrap_shop_item_list()
  if self.v_shop_item_list then
    for _, obj in pairs(self.v_shop_item_list) do
      self:remove_wrap_ui(obj)
    end
    self.v_shop_item_list = nil
  end
end

function ui:remove_wrap_char_head_list()
  if self.v_char_head_list then
    for _, obj in pairs(self.v_char_head_list) do
      self:remove_wrap_ui(obj)
    end
    self.v_char_head_list = nil
  end
end

function ui:remove_wrap_ornament_slot_list()
  if self.v_ornament_slot_list then
    for _, obj in pairs(self.v_ornament_slot_list) do
      self:remove_wrap_ui(obj)
    end
    self.v_ornament_slot_list = nil
  end
end

function ui:clear_wrap_curse_obj()
  if self.v_curse_view then
    self:remove_wrap_ui(self.v_curse_view)
    self.v_curse_view = nil
  end
end

return ui
