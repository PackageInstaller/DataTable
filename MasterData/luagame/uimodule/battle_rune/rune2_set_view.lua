local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local RUNE_SET_HERO_ITEM_CLASS = require("uimodule.battle_rune.rune_set_hero_item")
local RUNE_DETAIL_SKILL_ITEM_CLASS = require("uimodule.battle_rune.rune_detail_item")
local bagConfig = require("gamelogic.character.fight_bag_configs")
local RUNE_SET_HERO_ITEM_KEY = "RUNE_SET_HERO_ITEM_KEY"
local RUNE_HELPER = require("gamelogic.activity.rune2_helper")
local ITEM_ICON_PATH = "Icon/BattleItem/%s"
local BTN_ICON_PATH = "UICommon2/Bg/%s"
local ACTIVE_SET_ICON_NAME = "Common_kjd"
local NOT_ACTIVE_SET_ICON_NAME = "Common_kjd02"
local CommonDefine = require("cs_share.common_define")
local RUNE2_SOURCE = CommonDefine.RUNE2_SOURCE
local Item_Helper = require("utils.item_helper")
local CURSE_OBJ_CALSS = require("uimodule.stage_activity.challenge_ring_plus.curse_obj")
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local ADD_CURSE_TYPE = curse_com_def.ADD_CURSE_TYPE
local ITEM_STATE = {
  ADD = 1,
  CHANGE = 2,
  MISMATCH = 3,
  DIE = 4,
  LvUp = 5,
  MaxLv = 6
}
local DETAIL_CHANGE_STATE = {
  ADD = 1,
  CHANGE = 2,
  MISMATCH = 3,
  LvUp = 4,
  MaxLv = 5
}

function ui:ui_finish_load()
  self:register_template()
end

function ui:register_template()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("Sell", function()
    self:sell_rune_item()
  end)
  self:set_button("DetailClose", function()
    self:_click_detail_bg()
  end)
  self:set_button("BtnSetRune", function()
    self:_click_set_hero_rune()
  end)
  self:set_button("BtnRelive", function()
    self:_click_relive_hero_btn()
  end)
  self:set_button("BtnPayGold", function()
    self:_click_btn_pay(false)
  end)
  self:set_button("BtnPayCurse", function()
    self:_click_btn_pay(true)
  end)
  self:register_exist_auto_template(RUNE_SET_HERO_ITEM_KEY, self.v_uiobjects.CharTem, self.v_uiobjects.ChooseList)
end

function ui:ui_on_show(drop_item, source_type, shop_npc_data)
  self.v_be_selling = false
  self.v_shop_npc_data = shop_npc_data
  self.v_drop_item = drop_item
  self.v_item_id = drop_item.item_id
  self.v_uuid = drop_item.uuid
  self.v_index = drop_item.index
  self.v_drop_uuid = drop_item.drop_uuid
  self.v_rune_uuid = drop_item.ran_ans_uuid
  self.v_source_type = source_type
  local npc_data = drop_item.npc_data
  if npc_data then
    self.v_npc_id = npc_data.npc_id
  end
  SceneMgr:c2gs_call_scene("on_open_rune_ui")
  BehaviorMgr:call_scene_logic_event_fun("on_open_rune_ui")
  self:hide_detail_ui()
  self:refresh_hero_item_list()
  self:_refresh_currency()
  self:register_event()
  self:refresh_rune_item_info()
  if self.v_source_type == RUNE2_SOURCE.CURSE_SHOP_RUNE then
    self:refresh_curse_info()
    self:refresh_npc_show()
  else
    self:refresh_action_btn()
    self:refresh_sell_ui()
  end
end

function ui:ui_on_hide()
  self.v_rune_uuid = nil
  self.v_hero = nil
  self.v_drop_item = nil
  self.v_item_id = nil
  self.v_uuid = nil
  self.v_fight_hero_idx = nil
  self.v_hero_deatil_item_state = nil
  self.v_npc_id = nil
  self.v_drop_uuid = nil
  self.v_shop_npc_data = nil
  Util.enable_btn(self.v_uicompents.BtnPayGold_btn)
  Util.enable_btn(self.v_uicompents.BtnPayCurse_btn)
  Util.enable_btn(self.v_uicompents.BtnSetRune_btn)
  self:clear_hero_item_list()
  self:clear_detail_item_list()
  self:clear_skill_item_list()
  self:clear_next_skill_item_list()
  self:clear_wrap_curse_obj()
end

function ui:ui_on_destroy()
end

function ui:refresh_npc_show()
  if self.v_shop_npc_data then
    self.v_uiobjects.ChalRingObj:SetActive(true)
    self.v_uiobjects.BtnPayCurse:SetActive(false)
  else
    self.v_uiobjects.BtnPayCurse:SetActive(true)
  end
end

function ui:refresh_rune_item_info()
  local item_id = self.v_item_id
  local item_cfg = ShareRes.get_battle_item_cfg(item_id)
  local item_name = item_cfg.Name
  local ucom = self.v_uicompents
  ucom.RuneName_txt.text = item_name
  self.v_uiobjects.ShowRuneLVObj:SetActive(false)
  local item_image = self.v_uicompents.RuneIcon_img
  local icon_path = UtilUI.get_battle_item_icon(item_id)
  ResMgr:load_set_icon(item_image, icon_path)
  local quality_image = self.v_uicompents.Quality_img
  ResMgr:load_set_icon(quality_image, bagConfig.Quality_Img[item_cfg.Quality])
end

function ui:refresh_hero_item_list(uuid)
  self:give_back_auto_cache(RUNE_SET_HERO_ITEM_KEY)
  self:clear_hero_item_list()
  self.v_hero_item_list = {}
  local hero_item_list = self:refresh_hero_item_order()
  local idx = 1
  local select_idx
  for _, data in pairs(hero_item_list) do
    local hero = data.hero
    if uuid and hero.uuid == uuid then
      select_idx = idx
    end
    local item = self:get_auto_cache(RUNE_SET_HERO_ITEM_KEY)
    local item_lua = RUNE_SET_HERO_ITEM_CLASS:ui_wrap_ex(self, item, true)
    item_lua:set_data(hero, self.v_drop_item, idx)
    self.v_hero_item_list[idx] = item_lua
    idx = idx + 1
  end
  if select_idx then
    for now_idx, lua_obj in pairs(self.v_hero_item_list) do
      if now_idx == select_idx then
        lua_obj:on_select(select_idx)
      end
    end
  end
end

function ui:refresh_hero_item_order()
  local hero_sort_list = {}
  self.v_hero_deatil_item_state = {}
  local rune_cfg = ShareRes.get_battle_item_cfg(self.v_item_id)
  local item_rune_type = rune_cfg.Arg[1]
  local list = SceneMgr:get_hero_list()
  local idx = 1
  for uuid, hero in pairs(list) do
    local buddy_cfg = hero.buddy_cfg
    local buddy_id = buddy_cfg.Id
    local rune_type_list = buddy_cfg.RuneType
    local is_have_rune = true
    local cur_rune_type
    local buddy_rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
    if not buddy_rune_info then
      is_have_rune = false
    else
      cur_rune_type = buddy_rune_info.rune_type
    end
    local hero_item_state = ITEM_STATE.MISMATCH
    if hero:is_die() then
      hero_item_state = ITEM_STATE.DIE
    elseif Rune2Mgr:is_rune_lv_max(buddy_id, item_rune_type) then
      hero_item_state = ITEM_STATE.MaxLv
    else
      local pos = ShareRes.get_buddy_pos_by_rune_type(buddy_id, item_rune_type)
      if pos then
        if is_have_rune then
          hero_item_state = cur_rune_type == item_rune_type and ITEM_STATE.LvUp or ITEM_STATE.CHANGE
        else
          hero_item_state = ITEM_STATE.ADD
        end
      end
    end
    hero_sort_list[idx] = {hero = hero, hero_item_state = hero_item_state}
    local hero_detail_item_state = DETAIL_CHANGE_STATE.MISMATCH
    if hero_item_state == ITEM_STATE.CHANGE then
      hero_detail_item_state = DETAIL_CHANGE_STATE.CHANGE
    elseif hero_item_state == ITEM_STATE.ADD then
      hero_detail_item_state = DETAIL_CHANGE_STATE.ADD
    elseif hero_item_state == ITEM_STATE.LvUp then
      hero_detail_item_state = DETAIL_CHANGE_STATE.LvUp
    elseif hero_item_state == ITEM_STATE.MaxLv then
      hero_detail_item_state = DETAIL_CHANGE_STATE.MaxLv
    end
    self.v_hero_deatil_item_state[uuid] = hero_detail_item_state
    idx = idx + 1
  end
  table.sort(hero_sort_list, function(a, b)
    local a_state = a.hero_item_state
    local b_state = b.hero_item_state
    if a_state == b_state then
      local a_uuid = a.hero.uuid
      local b_uuid = b.hero.uuid
      return a_uuid < b_uuid
    end
    return a_state < b_state
  end)
  return hero_sort_list
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_SELECT_RUNE_SET_HERO_ITEM, self.response_click_rune_hero_item, self)
  self:bind_auto_mq(Const.MSG_ON_OPEN_RUNE_SET_HERO_DETAIL, self.response_open_rune_hero_detail, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DIAMOND_UPDATE, self._refresh_currency, self)
end

function ui:clear_hero_item_list()
  if self.v_hero_item_list then
    self:remove_wrap_ui_list(self.v_hero_item_list)
    self.v_hero_item_list = nil
  end
end

function ui:clear_detail_item_list()
  if self.v_detail_hero_item_list then
    self:remove_wrap_ui_list(self.v_detail_hero_item_list)
    self.v_detail_hero_item_list = nil
    self.v_detail_hero_map = nil
  end
end

function ui:response_click_rune_hero_item(msg)
  if not msg then
    return
  end
  local idx = msg.mm_x
  local hero_uuid = msg.mm_obj
  for _, lua_obj in pairs(self.v_hero_item_list) do
    lua_obj:on_select(idx)
  end
  self.v_hero = SceneMgr:get_hero_by_uuid(hero_uuid)
  self:refresh_btn_click_state(self.v_hero.buddy_cfg.Id)
  self:refresh_action_btn()
end

function ui:refresh_btn_click_state(buddy_id)
  local item_id = self.v_item_id
  local item_cfg = ShareRes.get_battle_item_cfg(item_id)
  local rune_type = item_cfg.Arg[1]
  local pos = ShareRes.get_buddy_pos_by_rune_type(buddy_id, rune_type)
  if Rune2Mgr:is_rune_lv_max(buddy_id, rune_type) or not pos then
    if self.v_source_type == RUNE2_SOURCE.CURSE_SHOP_RUNE then
      Util.disable_btn(self.v_uicompents.BtnPayGold_btn, true, false)
      Util.disable_btn(self.v_uicompents.BtnPayCurse_btn, true, false)
    else
      Util.disable_btn(self.v_uicompents.BtnSetRune_btn, true, false)
    end
  elseif self.v_source_type == RUNE2_SOURCE.CURSE_SHOP_RUNE then
    Util.enable_btn(self.v_uicompents.BtnPayGold_btn)
    Util.enable_btn(self.v_uicompents.BtnPayCurse_btn)
  else
    Util.enable_btn(self.v_uicompents.BtnSetRune_btn)
  end
end

function ui:_click_set_hero_rune()
  if not self.v_hero then
    Util.show_message_tip(2116)
    return
  end
  if self.v_hero:is_die() then
    Util.show_message_tip(2117)
    return
  end
  local item_id = self.v_item_id
  local item_cfg = ShareRes.get_battle_item_cfg(item_id)
  local rune_type = item_cfg.Arg[1]
  local buddy_id = self.v_hero.buddy_cfg.Id
  local pos = ShareRes.get_buddy_pos_by_rune_type(buddy_id, rune_type)
  if not pos then
    Util.show_message_tip(2118)
    return
  end
  if Rune2Mgr:is_rune_lv_max(buddy_id, rune_type) then
    Util.show_message_tip(2119)
    return
  end
  local refresh_data = {
    hero_id = self.v_hero.uuid,
    uuid = self.v_uuid,
    rune_pos = pos,
    source_type = self.v_source_type,
    npc_id = self.v_npc_id,
    drop_uuid = self.v_drop_uuid
  }
  Rune2Mgr:set_buddy_rune(refresh_data, function()
    self:ui_hide()
  end)
end

function ui:sell_rune_item()
  if self.v_be_selling then
    return
  end
  
  local function cb()
    self.v_be_selling = false
    self:ui_hide()
  end
  
  local sell_param = {
    uuid = self.v_uuid,
    npc_id = self.v_npc_id,
    drop_uuid = self.v_drop_uuid
  }
  Rune2Mgr:sell_rune_item(sell_param, self.v_source_type, cb)
  self.v_be_selling = true
end

function ui:open_detail_ui(hero)
  self:show_detail_ui()
  self:refresh_now_detail_ui(hero)
  self:refresh_next_detail_ui(hero)
  self:refresh_change_state(hero)
end

function ui:refresh_now_detail_ui(hero)
  local buddy_id = hero.buddy_cfg.Id
  self.v_uiobjects.NowRuneInfor:SetActive(false)
  self.v_uiobjects.NoNowRune:SetActive(true)
  local rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
  if rune_info then
    self.v_uiobjects.NowRuneInfor:SetActive(true)
    self.v_uiobjects.NoNowRune:SetActive(false)
    local pos = rune_info.pos
    local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
    local rune_condition_lv = rune_info.level or 0
    local ucom = self.v_uicompents
    local char_mode_now_txt = ucom.CharModeNow_txt
    local rune_icon_now_img = ucom.RuneIconNow_img
    local rune_level_now_txt = ucom.RuneLevelNow_txt
    local rune_bg_icon_now_img = ucom.RuneBgNow_img
    char_mode_now_txt.text = buddy_cfg.RuneName[pos]
    rune_level_now_txt.text = Util.format_str("等级{1}", rune_condition_lv)
    local icon_name = buddy_cfg.RuneIcon[pos]
    local rune_icon_path = RUNE_HELPER.get_rune_icon(icon_name)
    ResMgr:load_set_icon(rune_icon_now_img, rune_icon_path)
    self:refresh_now_rune_skill_list(hero, pos)
    local rune_type = buddy_cfg.RuneType[pos]
    rune_bg_icon_now_img.color = RUNE_HELPER.RUNE_COLOR_A[rune_type].color
  end
end

function ui:refresh_entry_item(entry_id, go)
  local entry_cfg = ShareRes.get_entry_cfg(entry_id)
  local entry_name_text = Util.get_text("EntryName", go)
  entry_name_text.text = entry_cfg.Name
  local entry_desc_text = Util.get_text("EntryDesc", go)
  entry_desc_text.text = entry_cfg.Desc
end

function ui:refresh_next_detail_ui(hero)
  local buddy_id = hero.buddy_cfg.Id
  self.v_uiobjects.GetRuneInfor:SetActive(true)
  self.v_uiobjects.NoNextRune:SetActive(false)
  local item_id = self.v_item_id
  local item_cfg = ShareRes.get_battle_item_cfg(item_id)
  local rune_type = item_cfg.Arg[1]
  local rune_cfg
  local rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
  local rune_condition_lv = rune_info and rune_info.level + 1 or 1
  if rune_info and rune_info.rune_type and rune_info.rune_type ~= rune_type then
    rune_condition_lv = 1
  end
  if not Rune2Mgr:is_rune_lv_max(buddy_id, rune_type) then
    rune_cfg = ShareRes.get_buddy_rune_list_cfg(buddy_id, rune_type, rune_condition_lv)
    if not rune_cfg then
      self.v_uiobjects.GetRuneInfor:SetActive(false)
      self.v_uiobjects.NoNextRune:SetActive(true)
      return
    end
    self.v_uiobjects.RuneMaxLv:SetActive(false)
  else
    self.v_uiobjects.GetRuneInfor:SetActive(false)
    self.v_uiobjects.NoNextRune:SetActive(false)
    self.v_uiobjects.RuneMaxLv:SetActive(true)
    return
  end
  local ucom = self.v_uicompents
  local char_mode_get_txt = ucom.CharModeGet_txt
  local rune_icon_get_img = ucom.RuneIconGet_img
  local rune_level_get_txt = ucom.RuneLevelGet_txt
  local rune_bg_icon_new_img = ucom.RuneBgGet_img
  rune_level_get_txt.text = Util.format_str("等级{1}", rune_condition_lv)
  local pos = ShareRes.get_buddy_pos_by_rune_type(buddy_id, rune_type)
  self:refresh_next_rune_skill_list(hero, pos, rune_condition_lv)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  local icon_name = buddy_cfg.RuneIcon[pos]
  local rune_icon_path = RUNE_HELPER.get_rune_icon(icon_name)
  ResMgr:load_set_icon(rune_icon_get_img, rune_icon_path)
  rune_bg_icon_new_img.color = RUNE_HELPER.RUNE_COLOR_A[rune_type].color
  char_mode_get_txt.text = buddy_cfg.RuneName[pos]
end

function ui:refresh_now_rune_skill_list(hero, pos)
  local buddy_id = hero.buddy_cfg.Id
  self:clear_skill_item_list()
  self.v_rune_skill_item = RUNE_DETAIL_SKILL_ITEM_CLASS:ui_wrap_ex(self, self.v_uiobjects.RuneDetailNow, true)
  local entry_list
  local now_rune_lv = 0
  local rune_type = ShareRes.get_buddy_rune_type(buddy_id, pos)
  local buddy_rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
  local buddy_now_pos
  if buddy_rune_info then
    buddy_now_pos = buddy_rune_info.pos
    if buddy_now_pos == pos then
      entry_list = buddy_rune_info.entry_list
    end
    local rune_lv = buddy_rune_info.level
    now_rune_lv = rune_lv
  end
  local is_now_pos = buddy_now_pos and buddy_now_pos == pos
  local skill_param = {
    buddy_id = buddy_id,
    rune_type = rune_type,
    buddy_rune_lv = now_rune_lv,
    entry_list = entry_list,
    is_now_pos = is_now_pos,
    star_list_info = {
      star_list_key = "SkillStarNow",
      star_key = "StarNow",
      star_light_key = "Light"
    }
  }
  self.v_rune_skill_item:set_data(skill_param, RUNE_HELPER.DETAIL_ITEM_SHOW_TYPE.SET_NOW_VIEW)
end

function ui:refresh_next_rune_skill_list(hero, pos, rune_lv)
  local buddy_id = hero.buddy_cfg.Id
  self:clear_next_skill_item_list()
  self.v_rune_next_skill_item = RUNE_DETAIL_SKILL_ITEM_CLASS:ui_wrap_ex(self, self.v_uiobjects.RuneDetailGet, true)
  local now_rune_lv = rune_lv
  local rune_type = ShareRes.get_buddy_rune_type(buddy_id, pos)
  local skill_param = {
    buddy_id = buddy_id,
    rune_type = rune_type,
    buddy_rune_lv = now_rune_lv,
    is_now_pos = true,
    star_list_info = {
      star_list_key = "SkillStarGet",
      star_key = "StarGet",
      star_light_key = "Light"
    }
  }
  self.v_rune_next_skill_item:set_data(skill_param, RUNE_HELPER.DETAIL_ITEM_SHOW_TYPE.SET_NEXT_VIEW)
end

function ui:refresh_change_state(hero)
  local uobj = self.v_uiobjects
  local uuid = hero.uuid
  local change_state = self.v_hero_deatil_item_state[uuid]
  uobj.ChangeSign:SetActive(change_state ~= DETAIL_CHANGE_STATE.MISMATCH)
  uobj.Change:SetActive(change_state == DETAIL_CHANGE_STATE.CHANGE)
  uobj.New:SetActive(change_state == DETAIL_CHANGE_STATE.ADD)
  uobj.LvUp:SetActive(change_state == DETAIL_CHANGE_STATE.LvUp)
  uobj.MaxLv:SetActive(change_state == DETAIL_CHANGE_STATE.MaxLv)
end

function ui:is_buddy_have_rune(buddy_id)
  local rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
  return rune_info
end

function ui:is_buddy_rune_change(buddy_id)
  local ran_ans_data = FightBagMgr:get_preview_random_entries(self.v_rune_uuid)
  local item_id = self.v_item_id
  local item_cfg = ShareRes.get_battle_item_cfg(item_id)
  local rune_type = item_cfg.Arg[1]
  local rune_condition_lv = 1
  local rune_cfg = ShareRes.get_buddy_rune_list_cfg(buddy_id, rune_type, rune_condition_lv)
  return rune_cfg
end

function ui:clear_skill_item_list()
  if self.v_rune_skill_item then
    self.v_rune_skill_item:ui_hide()
    self:remove_wrap_ui(self.v_rune_skill_item)
  end
end

function ui:clear_next_skill_item_list()
  if self.v_rune_next_skill_item then
    self.v_rune_next_skill_item:ui_hide()
    self:remove_wrap_ui(self.v_rune_next_skill_item)
  end
end

function ui:response_open_rune_hero_detail(msg)
  if not msg then
    return
  end
  local hero = msg.mm_obj
  self:open_detail_ui(hero)
end

function ui:_click_detail_bg()
  self:hide_detail_ui()
end

function ui:show_detail_ui()
  local uobj = self.v_uiobjects
  uobj.AssetBar:SetActive(false)
  uobj.DetailTip:SetActive(true)
  uobj.Title:SetActive(false)
  uobj.BtnRet1:SetActive(false)
  uobj.DetailMode:SetActive(true)
  uobj.SimpleMode:SetActive(false)
  uobj.ChalRingObj:SetActive(false)
end

function ui:hide_detail_ui()
  local uobj = self.v_uiobjects
  uobj.AssetBar:SetActive(true)
  uobj.DetailTip:SetActive(false)
  uobj.Title:SetActive(true)
  uobj.BtnRet1:SetActive(true)
  uobj.DetailMode:SetActive(false)
  uobj.SimpleMode:SetActive(true)
  if self.v_source_type == RUNE2_SOURCE.CURSE_SHOP_RUNE then
    uobj.Sell:SetActive(false)
    uobj.BtnSetRune:SetActive(false)
    uobj.ChalRingObj:SetActive(true)
    uobj.BtnPayObj:SetActive(true)
    uobj.BtnRelive:SetActive(false)
  else
    uobj.Sell:SetActive(true)
    uobj.BtnSetRune:SetActive(true)
    uobj.ChalRingObj:SetActive(false)
  end
end

function ui:_refresh_currency()
  local currency_obj = self.v_uiobjects.Asset_Item
  local moneyId = bagConfig.SHOW_CURRENCY[1]
  local cfg = FightBagMgr:get_cfg_by_id(moneyId)
  local moneyIcon = Util.get_image("Label", currency_obj)
  ResMgr:load_set_icon(moneyIcon, string.format(ITEM_ICON_PATH, cfg.Icon))
  local moneyTxt = Util.get_text("Aomunt", currency_obj)
  moneyTxt.text = CharacterMgr:get_res_val(moneyId)
end

function ui:refresh_action_btn()
  local is_die = false
  local is_can_set = false
  if self.v_hero then
    local uuid = self.v_hero.uuid
    local change_state = self.v_hero_deatil_item_state[uuid]
    is_can_set = not is_die and change_state ~= DETAIL_CHANGE_STATE.MISMATCH
    is_die = self.v_hero:is_die()
  end
  if is_can_set then
    Util.enable_btn(self.v_uicompents.BtnSetRune_btn)
  else
    Util.disable_btn(self.v_uicompents.BtnSetRune_btn, true, false)
  end
  local tower_info = TowerMgr:get_tower_progress()
  local is_show_reborn_btn
  if tower_info.episode_id and tower_info.episode_id > 0 then
    is_show_reborn_btn = TowerMgr:is_show_reborn_btn()
  else
    is_show_reborn_btn = false
  end
  self.v_uiobjects.BtnRelive:SetActive(is_die and is_show_reborn_btn)
  if self.v_source_type == RUNE2_SOURCE.CURSE_SHOP_RUNE then
    self.v_uiobjects.BtnPayObj:SetActive(not is_die or not is_show_reborn_btn)
  end
end

function ui:_click_relive_hero_btn()
  if not self.v_hero then
    Util.show_message_tip(2120)
    return
  end
  if self.v_hero:is_die() then
    local _, reborn_cost_num, reborn_cost_id = TowerMgr:get_reborn_cost(true)
    if not reborn_cost_id or 0 == reborn_cost_id then
      Util.show_message_tip(2114)
      return
    end
    local desc = Util.format_str("是否花费{1}钻石立即复活该角色", reborn_cost_num)
    
    local function cb()
      local cur_num = BagMgr:get_item_num(reborn_cost_id)
      if cur_num < reborn_cost_num then
        Util.show_message_tip(2115)
        return
      end
      local uuid = self.v_hero.uuid
      ChapterMgr:request_reborn(uuid, function()
        self:refresh_hero_item_list(uuid)
        self:refresh_action_btn()
      end)
    end
    
    Util.show_conform_tip(desc, nil, nil, nil, cb)
  else
    Util.show_message_tip(2121)
  end
end

function ui:refresh_sell_ui()
  local sell_price = BattleShopMgr:get_sell_price_by_item_id(self.v_item_id)
  self.v_uicompents.SellValue_txt.text = sell_price
  local sell_icon = self.v_uicompents.SellIcon_img
  local currency_id = ShareRes.get_single_key_define("BattleCurrencyId")
  local cfg = FightBagMgr:get_cfg_by_id(currency_id)
  local sell_path = string.format(ITEM_ICON_PATH, cfg.Icon)
  ResMgr:load_set_icon(sell_icon, sell_path)
end

function ui:refresh_curse_info()
  self:set_curse_view()
  local rune_cfg = ShareRes.get_battle_item_cfg(self.v_item_id)
  self.v_uicompents.GoldNeed_txt.text = ChallengeRingPlusMgr:get_after_discount_price(rune_cfg.BuyCostCnt)
  self.v_uicompents.CurseNeed_txt.text = ChallengeRingPlusMgr:get_after_discount_curse_price(rune_cfg.CurseCostCnt)
end

function ui:set_curse_view()
  if self.v_shop_npc_data then
    self.v_uiobjects.CurseObj:SetActive(false)
  else
    self:clear_wrap_curse_obj()
    self.v_curse_view = CURSE_OBJ_CALSS:ui_wrap(self, self.v_uiobjects.CurseObj, false)
    self.v_curse_view:set_enable(true)
  end
end

function ui:clear_wrap_curse_obj()
  if self.v_curse_view then
    self:remove_wrap_ui(self.v_curse_view)
    self.v_curse_view = nil
  end
end

function ui:_click_btn_pay(is_use_curse_value)
  if not self.v_hero then
    Util.show_message_tip(2122)
    return
  end
  if self.v_hero:is_die() then
    Util.show_message_tip(2123)
    return
  end
  local item_cfg = ShareRes.get_battle_item_cfg(self.v_item_id)
  local rune_type = item_cfg.Arg[1]
  local buddy_id = self.v_hero.buddy_cfg.Id
  local pos = ShareRes.get_buddy_pos_by_rune_type(buddy_id, rune_type)
  if not pos then
    Util.show_message_tip(2124)
    return
  end
  if Rune2Mgr:is_rune_lv_max(buddy_id, rune_type) then
    Util.show_message_tip(2119)
    return
  end
  local rune_cfg = ShareRes.get_battle_item_cfg(self.v_item_id)
  local need_curse
  if is_use_curse_value then
    need_curse = ChallengeRingPlusMgr:get_after_discount_curse_price(rune_cfg.CurseCostCnt)
    if not ChallengeRingPlusMgr:is_can_buy(need_curse) then
      Util.show_message_tip(2115)
      return
    end
  else
    local moneyId = rune_cfg.BuyCostId
    local cost_num = ChallengeRingPlusMgr:get_after_discount_price(rune_cfg.BuyCostCnt)
    if cost_num > CharacterMgr:get_res_val(moneyId) then
      Util.show_message_tip(2115)
      return
    end
  end
  local item_cfg = ShareRes.get_battle_item_cfg(self.v_item_id)
  local rune_type = item_cfg.Arg[1]
  local buddy_id = self.v_hero.buddy_cfg.Id
  local pos = ShareRes.get_buddy_pos_by_rune_type(buddy_id, rune_type)
  if self.v_shop_npc_data then
    local npc_id = self.v_shop_npc_data.npc_id
    local good_index = self.v_index
    Rune2Mgr:buy_rune_by_npc_shop(npc_id, good_index, self.v_hero, pos, nil)
  else
    if is_use_curse_value then
      ChallengeRingPlusMgr:record_fight_add_curse_value(ADD_CURSE_TYPE.SHOP_BUY, need_curse)
    else
      ChallengeRingPlusMgr:set_is_not_use_curse_buy(true)
    end
    ChallengeRingPlusMgr:request_purchase_rune(self.v_uuid, is_use_curse_value, self.v_hero.uuid, pos)
  end
end

return ui
