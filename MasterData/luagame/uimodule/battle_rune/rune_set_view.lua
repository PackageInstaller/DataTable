local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local RUNE_SET_HERO_ITEM_CLASS = require("uimodule.battle_rune.rune_set_hero_item")
local RUNE_BAG_HERO_ITEM_CLASS = require("uimodule.battle_bag.rune_hero_item")
local RUNE_DETAIL_SKILL_ITEM_CLASS = require("uimodule.battle_rune.rune_detail_item")
local bagConfig = require("gamelogic.character.fight_bag_configs")
local RUNE_SET_HERO_ITEM_KEY = "RUNE_SET_HERO_ITEM_KEY"
local RUNE_DETAIL_SET_HERO_ITEM_KEY = "RUNE_DETAIL_SET_HERO_ITEM_KEY"
local BUDDY_RUNE_SET_ENTRY_KEY = "BUDDY_RUNE_SET_ENTRY_KEY"
local RUNE_HELPER = require("gamelogic.activity.rune2_helper")
local CommonDefine = require("cs_share.common_define")
local TEAM_CHANGE_STATE = {
  ADD = "ADD",
  NO_CHANGE = "NO_CHANGE",
  REDUCE = "REDUCE"
}
local TEAM_CHANGE_COLOR = {
  ADD = {
    color = Util.get_unity_color_by_hex(tonumber("6f97ed", 16))
  },
  NO_CHANGE = {
    color = Util.get_unity_color_by_hex(tonumber("FFFFFF", 16))
  },
  REDUCE = {
    color = Util.get_unity_color_by_hex(tonumber("b14646", 16))
  }
}
local ITEM_STATE = {
  ADD = 1,
  CHANGE = 2,
  MISMATCH = 3,
  DIE = 4
}
local DETAIL_CHANGE_STATE = {
  ADD = 1,
  CHANGE = 2,
  MISMATCH = 3
}
local NOT_HAVE_RUNE = 0

function ui:ui_finish_load()
  self:register_template()
end

local SHOW_MODE_TYPE = {Simple = 1, Detail = 2}
local SHOW_MODE_TOG_NAME = {
  [SHOW_MODE_TYPE.Simple] = "Simple",
  [SHOW_MODE_TYPE.Detail] = "Detail"
}
local SHOW_MODE_UI_NAME = {
  [SHOW_MODE_TYPE.Simple] = "SimpleMode",
  [SHOW_MODE_TYPE.Detail] = "DetailMode"
}

function ui:register_template()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("Sell", function()
    self:sell_rune_item()
  end)
  self.v_simple_tog = Util.get_toggle(nil, self.v_uiobjects.Simple)
  self:set_toggle_listener(self.v_simple_tog, function(is_on)
    if is_on then
      self:click_change_tog(SHOW_MODE_TYPE.Simple)
    end
  end)
  self.v_detail_tog = Util.get_toggle(nil, self.v_uiobjects.Detail)
  self:set_toggle_listener(self.v_detail_tog, function(is_on)
    if is_on then
      self:click_change_tog(SHOW_MODE_TYPE.Detail)
    end
  end)
  self:set_button("BtnChangeRune", function()
    self:click_detail_submit()
  end)
  self:set_button("BtnRecive", function()
    self:click_revive_btn()
  end)
  self:register_exist_auto_template(RUNE_SET_HERO_ITEM_KEY, self.v_uiobjects.CharTem, self.v_uiobjects.ChooseList)
  self:register_exist_auto_template(RUNE_DETAIL_SET_HERO_ITEM_KEY, self.v_uiobjects.DetailCharTem, self.v_uiobjects.CharList)
end

function ui:ui_on_show(drop_item)
  self.v_drop_item = drop_item
  self.v_item_id = drop_item.item_id
  self.v_drop_uuid = drop_item.uuid
  self.v_rune_uuid = drop_item.ran_ans_uuid
  self.v_show_mode = SHOW_MODE_TYPE.Simple
  self.v_simple_tog.isOn = false
  self.v_simple_tog.isOn = true
  self:refresh_hero_item_list()
  self:refresh_detail_hero_list()
  self:register_event()
  self:refresh_detail_ui(Global.hero)
  self:refresh_rune_info()
  self:bind_auto_mq(Const.MSG_ON_SELECT_RUNE_HERO_ITEM, self.response_click_hero_item, self)
  self:bind_auto_mq(Const.MSG_ON_HERO_REBORN_END, self.response_hero_reborn, self)
end

function ui:ui_on_hide()
  self.v_rune_uuid = nil
  self.v_hero = nil
  self.v_drop_item = nil
  self.v_item_id = nil
  self.v_drop_uuid = nil
  self.v_is_change = nil
  self.v_is_have = nil
  self.v_change_state = nil
  self.v_fight_hero_idx = nil
  self:clear_hero_item_list()
  self:clear_detail_item_list()
  self:clear_skill_item_list()
  self:clear_next_skill_item_list()
end

function ui:ui_on_destroy()
  self.v_simple_tog = nil
  self.v_detail_tog = nil
end

function ui:refresh_rune_info()
  local ran_ans_data = FightBagMgr:get_preview_random_entries(self.v_rune_uuid)
  local item_id = self.v_item_id
  local item_cfg = ShareRes.get_battle_item_cfg(item_id)
  local item_name = item_cfg.Name
  local level = ran_ans_data.random_grade
  local ucom = self.v_uicompents
  ucom.RuneName_txt.text = item_name
  ucom.ShowRuneLV_txt.text = level
  ucom.Level2_txt.text = Util.format_str("等级：{1}", level)
  local item_image = self.v_uicompents.RuneIcon_img
  local icon_path = UtilUI.get_battle_item_icon(item_id)
  ResMgr:load_set_icon(item_image, icon_path)
  local quality_image = self.v_uicompents.Quality_img
  ResMgr:load_set_icon(quality_image, bagConfig.Quality_Img[item_cfg.Quality])
end

function ui:refresh_hero_item_list()
  self:give_back_auto_cache(RUNE_SET_HERO_ITEM_KEY)
  self:clear_hero_item_list()
  self.v_hero_item_list = {}
  local hero_item_list = self:refresh_hero_item_order()
  local idx = 1
  for _, data in pairs(hero_item_list) do
    local hero = data.hero
    local item = self:get_auto_cache(RUNE_SET_HERO_ITEM_KEY)
    local item_lua = RUNE_SET_HERO_ITEM_CLASS:ui_wrap_ex(self, item, true)
    item_lua:set_data(hero, self.v_drop_item, idx)
    self.v_hero_item_list[idx] = item_lua
    idx = idx + 1
  end
end

function ui:refresh_detail_hero_list()
  self:give_back_auto_cache(RUNE_DETAIL_SET_HERO_ITEM_KEY)
  self:clear_detail_item_list()
  self.v_detail_hero_item_list = {}
  self.v_detail_hero_map = {}
  local hero_item_list = self:refresh_hero_item_order()
  local fight_hero_uuid = Global.hero.uuid
  local idx = 1
  self.v_fight_hero_idx = 1
  for _, data in pairs(hero_item_list) do
    local hero = data.hero
    local buddy_cfg = hero.buddy_cfg
    local buddy_id = buddy_cfg.Id
    local item = self:get_auto_cache(RUNE_DETAIL_SET_HERO_ITEM_KEY)
    local item_lua = RUNE_BAG_HERO_ITEM_CLASS:ui_wrap_ex(self, item, true)
    local now_hero_uuid = hero.uuid
    if now_hero_uuid == fight_hero_uuid then
      self.v_fight_hero_idx = idx
    end
    local is_have_rune = self:is_buddy_have_rune(buddy_id)
    local is_have_change = self:is_buddy_rune_change(buddy_id)
    local change_state = DETAIL_CHANGE_STATE.MISMATCH
    if not is_have_rune and is_have_change then
      change_state = DETAIL_CHANGE_STATE.CHANGE
    elseif is_have_rune and is_have_change then
      change_state = DETAIL_CHANGE_STATE.ADD
    end
    item_lua:set_data(hero, idx)
    item_lua:refresh_hero_mask(change_state == DETAIL_CHANGE_STATE.MISMATCH)
    self.v_detail_hero_item_list[idx] = item_lua
    self.v_detail_hero_map[now_hero_uuid] = idx
    idx = idx + 1
  end
end

function ui:refresh_hero_item_order()
  local hero_sort_list = {}
  local rune_cfg = ShareRes.get_battle_item_cfg(self.v_item_id)
  local item_rune_type = rune_cfg.Arg[1]
  local list = SceneMgr:get_hero_list()
  local idx = 1
  for _, hero in pairs(list) do
    local buddy_cfg = hero.buddy_cfg
    local buddy_id = buddy_cfg.Id
    local rune_type_list = buddy_cfg.RuneType
    local is_have_rune = true
    local buddy_rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
    if not buddy_rune_info then
      is_have_rune = false
    end
    local hero_item_state = ITEM_STATE.MISMATCH
    if hero:is_die() then
      hero_item_state = ITEM_STATE.DIE
    else
      for _, rune_type in pairs(rune_type_list) do
        if rune_type == item_rune_type then
          hero_item_state = is_have_rune and ITEM_STATE.CHANGE or ITEM_STATE.ADD
        end
      end
    end
    hero_sort_list[idx] = {hero = hero, hero_item_state = hero_item_state}
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
  self:bind_auto_mq(Const.MSG_ON_SUBMIT_RUNE_SET_HERO_ITEM, self.response_submit_rune_hero_item, self)
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
end

function ui:response_submit_rune_hero_item(msg)
  if not msg then
    return
  end
  local refresh_data = msg.mm_obj
  Rune2Mgr:set_buddy_rune(refresh_data, function()
    self:ui_hide()
  end)
end

function ui:sell_rune_item()
  local item = FightBagMgr:get_item_by_uuid(self.v_rune_uuid)
  local submit_data = {
    id = item.Id,
    uuid = item.uuid,
    count = item.count
  }
  
  local function cb()
    self:ui_hide()
  end
  
  Rune2Mgr:sell_rune_item(submit_data, cb)
end

function ui:click_change_tog(mode)
  for mode_type, tog_obj_name in pairs(SHOW_MODE_TOG_NAME) do
    local tog_obj = self.v_uiobjects[tog_obj_name]
  end
  for mode_type, mode_name in pairs(SHOW_MODE_UI_NAME) do
    local mode_obj = self.v_uiobjects[mode_name]
    mode_obj:SetActive(mode_type == mode)
  end
  if mode == SHOW_MODE_TYPE.Detail then
    self:refresh_detail_hero_list()
  else
    self:refresh_hero_item_list()
  end
end

function ui:refresh_detail_ui(hero)
  local id = hero.buddy_cfg.Id
  self.v_hero = hero
  self.v_is_have = false
  self.v_is_change = false
  self:refresh_now_team_level()
  self:refresh_now_detail_ui(id)
  self:refresh_next_detail_ui(id)
  self.v_change_state = DETAIL_CHANGE_STATE.MISMATCH
  if not self.v_is_have and self.v_is_change then
    self.v_change_state = DETAIL_CHANGE_STATE.ADD
  elseif self.v_is_have and self.v_is_change then
    self.v_change_state = DETAIL_CHANGE_STATE.CHANGE
  end
  self:refresh_change_state()
end

function ui:refresh_now_detail_ui(buddy_id)
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
    self:refresh_now_rune_skill_list(self.v_hero, pos)
    self.v_is_have = true
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

function ui:refresh_next_detail_ui(buddy_id)
  self.v_uiobjects.GetRuneInfor:SetActive(true)
  self.v_uiobjects.NoNextRune:SetActive(false)
  local ran_ans_data = FightBagMgr:get_preview_random_entries(self.v_rune_uuid)
  local item_id = self.v_item_id
  local item_cfg = ShareRes.get_battle_item_cfg(item_id)
  local rune_type = item_cfg.Arg[1]
  local rune_condition_lv = ran_ans_data.random_grade or 0
  local rune_cfg = ShareRes.get_buddy_rune_list_cfg(buddy_id, rune_type, rune_condition_lv)
  local revive_btn_obj = self.v_uiobjects.BtnRecive
  if not rune_cfg then
    self.v_uiobjects.GetRuneInfor:SetActive(false)
    self.v_uiobjects.TeamLevelUp:SetActive(false)
    self.v_uiobjects.NoNextRune:SetActive(true)
    revive_btn_obj:SetActive(false)
    return
  end
  self:refresh_next_team_level(buddy_id, rune_condition_lv)
  local ucom = self.v_uicompents
  local char_mode_get_txt = ucom.CharModeGet_txt
  local rune_icon_get_img = ucom.RuneIconGet_img
  local rune_level_get_txt = ucom.RuneLevelGet_txt
  local rune_bg_icon_new_img = ucom.RuneBgGet_img
  rune_level_get_txt.text = Util.format_str("等级{1}", rune_condition_lv)
  local change_btn_obj = self.v_uiobjects.BtnChangeRune
  local is_die = self.v_hero:is_die()
  change_btn_obj:SetActive(not is_die)
  revive_btn_obj:SetActive(is_die)
  local pos = ShareRes.get_buddy_pos_by_rune_type(buddy_id, rune_type)
  self:refresh_next_rune_skill_list(self.v_hero, pos, rune_condition_lv)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  local icon_name = buddy_cfg.RuneIcon[pos]
  local rune_icon_path = RUNE_HELPER.get_rune_icon(icon_name)
  ResMgr:load_set_icon(rune_icon_get_img, rune_icon_path)
  rune_bg_icon_new_img.color = RUNE_HELPER.RUNE_COLOR_A[rune_type].color
  char_mode_get_txt.text = buddy_cfg.RuneName[pos]
  self.v_is_change = true
end

function ui:response_click_hero_item(msg)
  if not msg then
    return
  end
  local select_hero = msg.mm_obj
  self:refresh_detail_ui(select_hero)
end

function ui:click_revive_btn()
  if not self.v_hero then
    Util.show_message_tip(2125)
    return
  end
  if self.v_hero:is_die() then
    local _, reborn_cost_num, reborn_cost_id = TowerMgr:get_reborn_cost()
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
      ChapterMgr:request_reborn()
    end
    
    Util.show_conform_tip(desc, nil, nil, nil, cb)
  end
end

function ui:click_detail_submit()
  if not self.v_hero then
    Util.show_message_tip(2126)
    return
  end
  local buddy_id = self.v_hero.buddy_cfg.Id
  self.v_next_pos_idx = NOT_HAVE_RUNE
  local item_id = self.v_item_id
  local item_cfg = ShareRes.get_battle_item_cfg(item_id)
  local rune_type = item_cfg.Arg[1]
  local hero_rune_list = ShareRes.get_buddy_rune_type_list(buddy_id)
  for pos_idx, now_rune_type in pairs(hero_rune_list) do
    if now_rune_type == rune_type then
      self.v_next_pos_idx = pos_idx
      break
    end
  end
  if self.v_next_pos_idx ~= NOT_HAVE_RUNE then
    local refresh_data = {
      hero_id = self.v_hero.uuid,
      drop_uuid = self.v_drop_uuid,
      rune_pos = self.v_next_pos_idx
    }
    Rune2Mgr:set_buddy_rune(refresh_data, function()
      self:ui_hide()
    end)
  else
    Util.show_message_tip(2126)
  end
end

function ui:refresh_next_team_level(buddy_id, add_lv)
  local change_lv
  self.v_uiobjects.TeamLevelUp:SetActive(true)
  local rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
  if rune_info then
    local level = rune_info.level
    change_lv = add_lv - level
  else
    change_lv = add_lv
  end
  local ucom = self.v_uicompents
  local team_level_up_txt = ucom.TeamLevelUp_txt
  local sign_type = change_lv < 0 and "" or "+"
  local change_state = TEAM_CHANGE_STATE.NO_CHANGE
  if change_lv > 0 then
    change_state = TEAM_CHANGE_STATE.ADD
  elseif change_lv < 0 then
    change_state = TEAM_CHANGE_STATE.REDUCE
  end
  team_level_up_txt.color = TEAM_CHANGE_COLOR[change_state].color
  team_level_up_txt.text = sign_type .. change_lv
end

function ui:refresh_now_team_level()
  local ucom = self.v_uicompents
  local now_team_lv = Rune2Mgr:get_rune_team_level()
  local team_level_now_txt = ucom.TeamLevelNow_txt
  team_level_now_txt.text = now_team_lv
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
    is_now_pos = is_now_pos
  }
  self.v_rune_skill_item:set_data(skill_param, RUNE_HELPER.DETAIL_ITEM_SHOW_TYPE.MULTIPLE)
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
    is_now_pos = true
  }
  self.v_rune_next_skill_item:set_data(skill_param, RUNE_HELPER.DETAIL_ITEM_SHOW_TYPE.MULTIPLE)
end

function ui:refresh_change_state()
  local uobj = self.v_uiobjects
  uobj.ChangeSign:SetActive(self.v_change_state ~= DETAIL_CHANGE_STATE.MISMATCH)
  uobj.Change:SetActive(self.v_change_state == DETAIL_CHANGE_STATE.CHANGE)
  uobj.New:SetActive(self.v_change_state == DETAIL_CHANGE_STATE.ADD)
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
  local rune_condition_lv = ran_ans_data.random_grade or 0
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

function ui:response_hero_reborn()
  self:refresh_hero_item_list()
  self:refresh_detail_hero_list()
  local hero_uuid = self.v_hero.uuid
  local tog_idx = self.v_detail_hero_map[hero_uuid]
  self.v_detail_hero_item_list[tog_idx]:on_select(tog_idx)
end

return ui
