local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local Char_Helper = require("uimodule.character.char_helper")

function ui:ui_finish_load()
  self:bind_auto_mq(Const.ON_CLIMBING_TOWER_STAGE_SELECT, self.on_climbing_tower_stage_select, self)
end

function ui:ui_on_hide()
  self.v_buddy_info = nil
end

function ui:ui_on_show()
end

function ui:set_data(info, show_left)
  self.v_info = info
  self.v_uiobjects.StageTemL:SetActive(show_left)
  self.v_uiobjects.StageTemR:SetActive(not show_left)
  self.v_show_item = show_left and self.v_uiobjects.StageTemL or self.v_uiobjects.StageTemR
  self:refresh_item_name()
  self:refresh_item_bg()
  self:refresh_difficulty()
  self:refresh_lock()
  self:refresh_item_icon()
  self:refresh_select(self.v_parent_ui:get_select_id())
  self:refresh_item_star()
  local item_btn = Util.get_button(nil, self.v_show_item)
  self:set_button_listener(item_btn, function()
    if not self.v_is_open then
      Util.show_message_tip(self.v_tips)
      return
    end
    local msg = MsgGame:mq_publish2(Const.ON_CLIMBING_TOWER_STAGE_SELECT)
    msg.mm_x = self
  end)
end

function ui:refresh_item_name()
  local name = Util.get_text("StageName_", self.v_show_item)
  name.text = self.v_info.cfg.Name
end

function ui:refresh_item_bg()
  local normal_obj = Util.get_child_gameobj("BgNormal_", self.v_show_item)
  local hard_obj = Util.get_child_gameobj("BgHard_", self.v_show_item)
  normal_obj:SetActive(1 ~= self.v_info.cfg.Difficulty)
  hard_obj:SetActive(1 == self.v_info.cfg.Difficulty)
end

function ui:refresh_item_icon()
  local icon_path = ShareRes.create("chapter.climbing_tower")[self.v_info.cfg.Group].SmallIcon
  if self.v_is_open then
    local un_lock_icon = Util.get_image("BgUnlock_/StageIcon_", self.v_show_item)
    ResMgr:load_set_icon(un_lock_icon, icon_path)
  else
    local lock_icon = Util.get_image("BgLock_/StageIconLock_", self.v_show_item)
    ResMgr:load_set_icon(lock_icon, icon_path)
  end
end

function ui:refresh_difficulty()
  local award_obj = Util.get_child_gameobj("SpAward_", self.v_show_item)
  award_obj:SetActive(1 == self.v_info.cfg.Difficulty)
  if 1 == self.v_info.cfg.Difficulty and self.v_info.cfg.DifficultyAwardIcon then
    local icon = Util.get_image("SpAwardIcon_", award_obj)
    ResMgr:load_set_icon(icon, self.v_info.cfg.DifficultyAwardIcon)
  end
end

function ui:refresh_item_star()
  local star_layout = Util.get_child_gameobj("Star", self.v_show_item)
  local light_list = {}
  for i = 1, 3 do
    local un_light = Util.get_child_gameobj(Util.format_str("Star{1}_", i), star_layout)
    local light = Util.get_child_gameobj(Util.format_str("Star{1}_/Light", i), star_layout)
    light:SetActive(false)
    un_light:SetActive(true)
    table.insert(light_list, light)
  end
  local star_count = 0
  if self.v_info.data then
    star_count = ClimbingTowerMgr:get_star_with_bit(self.v_info.data.star)
    for i = 1, star_count do
      light_list[i]:SetActive(true)
    end
  end
end

function ui:on_climbing_tower_stage_select(msg)
  local item = msg.mm_x
  self:refresh_select(item:get_cfg_id())
end

function ui:refresh_select(select_id)
  local is_select = select_id == self.v_info.cfg.Id
  local select_obj = Util.get_child_gameobj("Select_", self.v_show_item)
  select_obj:SetActive(is_select)
  if is_select then
    self.v_parent_ui:refresh_select_item(self)
    local detail_ui = UIMgr:try_get_visible_ui("ui_chapter_detail_info")
    if not detail_ui then
      UIMgr:get_ui("ui_chapter_detail_info"):ui_show(self.v_info, nil, nil, nil, true)
    else
      detail_ui:refresh_panel(self.v_info, nil, nil, nil, true)
    end
  end
end

function ui:refresh_lock()
  local lock_obj = Util.get_child_gameobj("BgLock_", self.v_show_item)
  local un_lock_obj = Util.get_child_gameobj("BgUnlock_", self.v_show_item)
  local condition_open = false
  local front_open = false
  if self.v_info.data then
    condition_open = self.v_info.data.condition_open
    front_open = self.v_info.data.front_open
  end
  local is_open = false
  if condition_open and front_open then
    is_open = true
  end
  un_lock_obj:SetActive(is_open)
  lock_obj:SetActive(not is_open)
  local tips
  if not is_open then
    local condition = ShareRes.create("condition.condition", self.v_info.cfg.Condition)
    if condition then
      tips = condition.Desc
    end
  end
  self.v_is_open = is_open
  self.v_tips = tips
end

function ui:get_cfg_id()
  return self.v_info.cfg.Id
end

function ui:get_cfg()
  return self.v_info.cfg
end

function ui:get_is_open()
  return self.v_is_open
end

function ui:get_tips()
  return self.v_tips
end

function ui:is_can_click()
  if not self.v_is_owner then
    return false
  end
  return true
end

function ui:set_select_visible(visible)
  self.v_uiobjects.Select:SetActive(visible)
end

function ui:get_buddy_id()
  return self.v_buddy_id
end

function ui:get_language_index()
  return self.v_language_index
end

function ui:get_language()
  return self.v_language
end

return ui
