local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local RUNE_HELPER = require("gamelogic.activity.rune2_helper")
local RUNE_BAG_HERO_ITEM_CLASS = require("uimodule.battle_bag.rune_hero_item")
local RUNE_DETAIL_SKILL_ITEM_CLASS = require("uimodule.battle_rune.rune_detail_item")
local CommonDefine = require("cs_share.common_define")
local RUNE2_TYPE = CommonDefine.RUNE2_TYPE
local BUDDY_RUNE_ITEM_KEY = "BUDDY_RUNE_ITEM_KEY"
local TEAM_RUNE_BUFF_ITEM_KEY = "TEAM_RUNE_BUFF_ITEM_KEY"
local RUNE2_POSITION = CommonDefine.RUNE2_POSITION
local ITEM_ICON_PATH = "Icon/BattleItem/%s"
local bagConfig = require("gamelogic.character.fight_bag_configs")
local NOT_HAVE_RUNE = 0
local SKILL_LV_START = 1
local SKILL_LV_END = 3
local RUNE_POS_START = 1
local RUNE_POS_END = 2
local RUNE_BAG_TOG = {
  "Rune",
  "Bag",
  "Skill"
}

function ui:ui_finish_load()
  self:set_button("BtnResive", function()
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
        self:refresh_reborn_ui(self.v_hero)
        self:refresh_hero_image(self.v_hero)
        local tog_idx = self.v_hero_item_map[uuid]
        self.v_hero_item_list[tog_idx]:reborn()
      end)
    end
    
    Util.show_conform_tip(desc, nil, nil, nil, cb)
  end)
  self:set_button("BtnBuffDetail", function()
    UIMgr:get_ui("ui_rune_buff_tip"):ui_show()
  end)
  self.v_rune_tog_list = {}
  for i = RUNE_POS_START, RUNE_POS_END do
    local rune_tog = self.v_uicompents["RuneRoute" .. i .. "_tog"]
    self.v_rune_tog_list[i] = rune_tog
    self:set_toggle_listener(rune_tog, function(is_on)
      self:_on_click_rune_tog(is_on, i)
    end)
  end
  local blue_rect = Util.get_rect_transform(nil, self.v_uiobjects.BallBarBlue)
  local blue_width = blue_rect.sizeDelta.x
  local red_rect = Util.get_rect_transform(nil, self.v_uiobjects.BallBarRed)
  local red_width = red_rect.sizeDelta.x
  local yellow_rect = Util.get_rect_transform(nil, self.v_uiobjects.BallBarYellow)
  local yellow_width = yellow_rect.sizeDelta.x
  self.v_total_width = blue_width + red_width + yellow_width
  self:register_template()
end

function ui:register_template()
  self:register_exist_auto_template(BUDDY_RUNE_ITEM_KEY, self.v_uiobjects.CharTem, self.v_uiobjects.CharList)
  self:register_exist_auto_template(TEAM_RUNE_BUFF_ITEM_KEY, self.v_uiobjects.TeamBuffTem, self.v_uiobjects.TeamBuffContent)
end

function ui:ui_on_show(hero)
  self.v_hero = hero
  self:refresh_hero_list()
  self:refresh_show_hero_data(hero)
  self:refresh_team_level()
  self:refresh_rune_type_level()
  self:register_event()
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_SELECT_RUNE_HERO_ITEM, self.response_click_hero_item, self)
  self:bind_auto_mq(Const.MSG_ON_SELECT_RUNE_SKILL, self.response_select_rune_skill, self)
end

function ui:ui_on_hide()
  self:clear_hero_item_list()
  if self.v_rune_skill_item then
    self.v_rune_skill_item:ui_hide()
    self:remove_wrap_ui(self.v_rune_skill_item)
  end
  self.v_hero = nil
end

function ui:ui_on_destroy()
  self.v_rune_tog_list = nil
  self.v_currency_list = nil
  self.v_bag_fun_tog_list = nil
  self.v_total_width = nil
end

function ui:refresh_hero_list()
  local hero_list = SceneMgr:get_hero_list()
  self:give_back_auto_cache(BUDDY_RUNE_ITEM_KEY)
  self:clear_hero_item_list()
  self.v_hero_item_list = {}
  self.v_hero_item_map = {}
  local idx = 1
  for uuid, hero in pairs(hero_list) do
    local hero_item_go = self:get_auto_cache(BUDDY_RUNE_ITEM_KEY)
    local lua_obj = RUNE_BAG_HERO_ITEM_CLASS:ui_wrap_ex(self, hero_item_go, true)
    lua_obj:set_data(hero, idx)
    self.v_hero_item_list[idx] = lua_obj
    self.v_hero_item_map[uuid] = idx
    idx = idx + 1
  end
  for i = idx, 3 do
    local hero_item_go = self:get_auto_cache(BUDDY_RUNE_ITEM_KEY)
    local lua_obj = RUNE_BAG_HERO_ITEM_CLASS:ui_wrap_ex(self, hero_item_go, true)
    lua_obj:set_data(nil)
    self.v_hero_item_list[i] = lua_obj
  end
end

function ui:clear_hero_item_list()
  if self.v_hero_item_list then
    self:remove_wrap_ui_list(self.v_hero_item_list)
    self.v_hero_item_list = nil
    self.v_hero_item_map = nil
  end
end

function ui:refresh_show_hero_data(hero)
  self.v_hero = hero
  local buddy_id = hero.buddy_cfg.Id
  self:refresh_hero_image(hero)
  local buddy_rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
  if buddy_rune_info then
    self.v_rune_pos = buddy_rune_info.pos
  else
    self.v_rune_pos = RUNE2_POSITION.MAIN_POS
  end
  self.v_rune_lv = SKILL_LV_START
  self:referesh_hero_item_select(hero)
  self:refresh_rune_list(hero)
  self:refresh_reborn_ui(hero)
end

function ui:referesh_hero_item_select()
  if self.v_hero_item_list then
    for key, lua_obj in pairs(self.v_hero_item_list) do
      if self.v_hero and lua_obj.v_hero and self.v_hero.buddy_cfg.Id == lua_obj.v_hero.buddy_cfg.Id then
        lua_obj.v_uiobjects.Select:SetActive(true)
      else
        lua_obj.v_uiobjects.Select:SetActive(false)
      end
    end
  end
end

function ui:refresh_hero_image(hero)
  local hero_id = hero.buddy_cfg.Id
  local char_image = self.v_uicompents.ShowChar_img
  local mask_image = self.v_uicompents.CharMask_img
  local hero_icon = UtilUI.get_hero_images(hero_id, Config.HERO_ICON_LV.HD_FULL_IMG)
  if not hero_icon then
    return
  end
  ResMgr:load_set_icon(char_image, hero_icon, nil, true, self)
  ResMgr:load_set_icon(mask_image, hero_icon, nil, true, self)
  mask_image.gameObject:SetActive(hero and hero:is_anim_die_end())
end

function ui:refresh_rune_skill(hero, pos, lv)
  local buddy_id = hero.buddy_cfg.Id
  local ucom = self.v_uicompents
  local name_text = ucom.RuneSkillName_txt
  local desc_text = ucom.RuneSkillDesc_txt
  name_text.text = Util.format_str("暂无")
  desc_text.text = ""
  self.v_rune_lv = lv
  local rune_type = ShareRes.get_buddy_rune_type(buddy_id, pos)
  local rune_cfg = ShareRes.get_buddy_rune_lv_cfg(buddy_id, rune_type, lv)
  if rune_cfg then
    name_text.text = Util.format_str(rune_cfg.SkillName)
    desc_text.text = Util.format_str(rune_cfg.SkillDesc)
  end
  self:refresh_rune_tog_state(hero)
end

function ui:refresh_entry_item(entry_id, go, idx)
  local entry_cfg = ShareRes.get_entry_cfg(entry_id)
  local entry_desc_text = Util.get_text("EntryDesc", go)
  entry_desc_text.text = entry_cfg.Desc
end

function ui:refresh_rune_list(hero)
  local buddy_id = hero.buddy_cfg.Id
  local buddy_cfg = hero.buddy_cfg
  local buddy_rune_cfg = ShareRes.get_buddy_cfg(buddy_id)
  local buddy_rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
  local pos = RUNE2_POSITION.MAIN_POS
  if buddy_rune_info then
    pos = buddy_rune_info.pos
  end
  local rune_type_list = buddy_rune_cfg.RuneType
  for idx, cfg_rune_type in pairs(rune_type_list) do
    local rune_lv = 0
    local rune_mask_obj = self.v_uiobjects["RuneMask" .. idx]
    rune_mask_obj:SetActive(true)
    if pos == idx and buddy_rune_info then
      rune_lv = buddy_rune_info.level
      rune_mask_obj:SetActive(false)
    end
    local rune_level = self.v_uicompents["RuneLevel" .. idx .. "_txt"]
    if rune_lv > 0 then
      rune_level.gameObject:SetActive(true)
      rune_level.text = Util.format_str("x{1}", rune_lv)
    else
      rune_level.gameObject:SetActive(false)
    end
    local rune_image = self.v_uicompents["RuneIcon" .. idx .. "_img"]
    local rune_name_txt = self.v_uicompents["RuneName" .. idx .. "_txt"]
    local rune_choose_obj = self.v_uiobjects["RuneSelect" .. idx]
    local rune_bg_img = self.v_uicompents["Bg" .. idx .. "_img"]
    rune_bg_img.color = RUNE_HELPER.RUNE_COLOR_A[cfg_rune_type].color
    local icon_name = buddy_cfg.RuneIcon[idx]
    local icon_path = RUNE_HELPER.get_rune_icon(icon_name)
    ResMgr:load_set_icon(rune_image, icon_path)
    rune_choose_obj:SetActive(idx == self.v_rune_pos)
    local rune_name = buddy_cfg.RuneName[idx]
    rune_name_txt.text = rune_name
  end
  self:refresh_rune_skill_list(hero, self.v_rune_pos)
end

function ui:refresh_team_rune_effect(level)
  local team_rune_cfg = ShareRes.get_team_level_rune_cfg(level)
  if team_rune_cfg then
    self:give_back_auto_cache(TEAM_RUNE_BUFF_ITEM_KEY)
    self.v_uiobjects.TeamBuffContent:SetActive(true)
    local desc_list = team_rune_cfg.Desc
    for _, desc in pairs(desc_list) do
      local go = self:get_auto_cache(TEAM_RUNE_BUFF_ITEM_KEY)
      local buff_txt = Util.get_text("TextBg/TeamBuffText", go)
      buff_txt.text = Util.format_str(desc)
    end
  else
    self.v_uiobjects.TeamBuffContent:SetActive(false)
  end
end

function ui:refresh_rune_type_level()
  local ucom = self.v_uicompents
  local red_val = Rune2Mgr:get_rune_type_level(RUNE2_TYPE.RED_RUNE) or 0
  local yellow_val = Rune2Mgr:get_rune_type_level(RUNE2_TYPE.YELLOW_RUNE) or 0
  local blue_val = Rune2Mgr:get_rune_type_level(RUNE2_TYPE.BULE_RUNE) or 0
  ucom.RedLV_txt.text = red_val
  ucom.YellowLV_txt.text = yellow_val
  ucom.BlueLV_txt.text = blue_val
  self:refresh_ball_state(red_val, yellow_val, blue_val)
end

function ui:refresh_team_level()
  local lv = Rune2Mgr:get_rune_team_level()
  self.v_uicompents.TeaMBallLV_txt.text = lv
  self:refresh_team_rune_effect(lv)
end

function ui:response_click_hero_item(msg)
  if not msg then
    return
  end
  local select_hero = msg.mm_obj
  self:refresh_show_hero_data(select_hero)
end

function ui:_on_click_skill_tog(is_on, lv)
  if is_on then
    self:refresh_rune_skill(self.v_hero, self.v_rune_pos, lv)
  end
end

function ui:_on_click_rune_tog(is_on, pos)
  if is_on then
    self.v_rune_pos = pos
    self:refresh_rune_list(self.v_hero)
  end
end

function ui:refresh_rune_tog_state(hero)
  local buddy_id = hero.buddy_cfg.Id
  local buddy_rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
  local rune_lv = 0
  local have_rune = false
  if buddy_rune_info then
    local condition_lv = Rune2Mgr:get_rune_type_level(buddy_id)
    local pos = buddy_rune_info.pos
    local rune_type = ShareRes.get_buddy_rune_type(buddy_id, pos)
    have_rune = self.v_rune_pos == pos and true or false
    local rune_cfg = ShareRes.get_buddy_rune_list_cfg(buddy_id, rune_type, condition_lv)
    if rune_cfg then
      rune_lv = rune_cfg.Level
    end
  end
end

function ui:refresh_reborn_ui(hero)
  if not hero then
    Log.Error("no hero reborn")
    self.v_uiobjects.BtnResive:SetActive(false)
    return
  end
  local is_die = hero:is_anim_die_end()
  local is_show_reborn_btn = TowerMgr:is_show_reborn_btn()
  self.v_uiobjects.BtnResive:SetActive(is_die and is_show_reborn_btn)
  local icon_path, reborn_cost_num, _ = TowerMgr:get_reborn_cost(true)
  if not icon_path then
    self.v_uiobjects.BtnResive:SetActive(false)
    return
  end
  local ucom = self.v_uicompents
  local expend_item_img = ucom.ExpendItem_img
  local expend_cost_txt = ucom.ExpendCost_txt
  ResMgr:load_set_icon(expend_item_img, icon_path)
  expend_cost_txt.text = reborn_cost_num
end

function ui:refresh_rune_skill_list(hero, pos)
  local buddy_id = hero.buddy_cfg.Id
  if self.v_rune_skill_item then
    self.v_rune_skill_item:ui_hide()
    self:remove_wrap_ui(self.v_rune_skill_item)
  end
  self.v_rune_skill_item = RUNE_DETAIL_SKILL_ITEM_CLASS:ui_wrap_ex(self, self.v_uiobjects.RuneDetail, true)
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
  self.v_rune_skill_item:set_data(skill_param, RUNE_HELPER.DETAIL_ITEM_SHOW_TYPE.BAG_VIEW)
end

function ui:response_select_rune_skill(msg)
  if not msg then
    return
  end
  local rune_cfg = msg.mm_obj
  self.v_uicompents["RuneName" .. self.v_rune_pos .. "_txt"].text = rune_cfg.Name
end

function ui:refresh_ball_state(red_val, yellow_val, blue_val)
  local blue_rect = Util.get_rect_transform(nil, self.v_uiobjects.BallBarBlue)
  local red_rect = Util.get_rect_transform(nil, self.v_uiobjects.BallBarRed)
  local yellow_rect = Util.get_rect_transform(nil, self.v_uiobjects.BallBarYellow)
  local total_width = self.v_total_width
  yellow_rect.gameObject:SetActive(yellow_val > 0)
  red_rect.gameObject:SetActive(red_val > 0)
  blue_rect.gameObject:SetActive(blue_val > 0)
  local total_val = red_val + yellow_val + blue_val
  if 0 == total_val then
    return
  end
  local result_red = red_val / total_val
  local result_blue = blue_val / total_val
  local result_yellow = yellow_val / total_val
  local result_red_width = total_width * result_red
  local result_blue_width = total_width * result_blue
  local result_yellow_width = total_width * result_yellow
  blue_rect:SetSizeDeltaWidthA(result_blue_width)
  red_rect:SetSizeDeltaWidthA(result_red_width)
  yellow_rect:SetSizeDeltaWidthA(result_yellow_width)
end

function ui:_on_click_bag_tog(is_on, idx)
  if idx == self.v_tog_idx and is_on then
    return
  end
  self.v_tog_idx = idx
  for k, v in pairs(self.v_tog_panels) do
    v:set_enable(is_on and idx == k)
  end
end

function ui:cache_ui()
  return true
end

return ui
