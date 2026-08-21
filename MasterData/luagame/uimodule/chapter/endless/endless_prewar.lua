local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ENDLESS_ENTRY_ITEM = "ENDLESS_ENTRY_ITEM"
local ENDLESS_ENTRY_GROUP_ITEM = "ENDLESS_ENTRY_GROUP_ITEM"
local ENDLESS_ENTRY_GROUP_ITEM_CLASS = require("uimodule.chapter.endless.endless_entry_group_item")
local QUALITY_PATH = Config.ENTRY_QUALITY_PATH
local INFINITE_ENTRY_TYPE = Config.CommonDefine.INFINITE_ENTRY_TYPE
local INFINITE_ENTRY_LIMIT = {
  [INFINITE_ENTRY_TYPE.GAIN] = "GainEntryLimit",
  [INFINITE_ENTRY_TYPE.NEGATIVE] = "NegativeEntryLimit"
}
local HARD_COLOR = {
  [true] = "FF3030",
  [false] = "EFC66E"
}
local HARD_BG_COLOR = {
  [true] = "FFFFFF",
  [false] = "000000"
}
local SELECT_BG_COLOR = {
  [true] = "FFFFFF",
  [false] = "FFFFFF"
}

local function sort(a, b)
  if a.Serial ~= b.Serial then
    return a.Serial < b.Serial
  else
    return false
  end
end

local function sort2(a, b)
  local a_group_cfg = ShareRes.get_infinite_entry_group_cfg(a.OwnerEntryGroup)
  local b_group_cfg = ShareRes.get_infinite_entry_group_cfg(b.OwnerEntryGroup)
  if a_group_cfg.Serial ~= b_group_cfg.Serial then
    return a_group_cfg.Serial < b_group_cfg.Serial
  elseif a.OwnerEntryGroup ~= b.OwnerEntryGroup then
    return a.OwnerEntryGroup < b.OwnerEntryGroup
  else
    return false
  end
end

function ui:ui_finish_load()
  self:set_button("BtnEnemy", function()
    self:on_click_enemy_btn()
  end)
  self:set_button("BtnFight", function()
    self:on_click_fight_btn()
  end)
  self:set_button("BtnReset", function()
    self:on_click_reset_btn()
  end)
  self:set_button("BtnRet1", function()
    self:on_click_return_btn()
  end)
  self.v_endless_entry_group_map = {}
  self.v_must_select_group = {}
  self.v_old_select_entry_map = {}
  self.v_endless_entry_type_map = {}
  self.v_endless_entry_type_count = {}
  for key, type_value in pairs(INFINITE_ENTRY_TYPE) do
    self.v_endless_entry_type_map[type_value] = {}
    self:reset_entry_count(type_value)
  end
  self:register_exist_auto_template(ENDLESS_ENTRY_ITEM, self.v_uiobjects.BuffTem, self.v_uiobjects.BuffContent)
  self:register_exist_auto_template(ENDLESS_ENTRY_GROUP_ITEM, self.v_uiobjects.BuffGroupTem, self.v_uiobjects.BuffGroupContent)
end

function ui:on_click_enemy_btn()
end

function ui:on_click_fight_btn()
  if not self:check_is_select_all_must_group() then
    Util.show_message_tip(2348)
    return
  end
  local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  ChapterEndlessMgr:infinite_selected_entry_save(self.v_infinite_id, self.v_select_entry_map)
  local point_cfg = ShareRes.get_chapter_point_cfg(infinite_cfg.EpisodeId)
  if point_cfg.FightCost and point_cfg.FightCost[1] > BagMgr:get_item_num(Config.PLAYER_SP_ITEMID) then
    Util.show_message_tip(2216)
    UIMgr:get_ui("uiforcerecharg"):ui_show()
    return
  end
  UIMgr:get_ui("team"):ui_show(self.v_infinite_id, infinite_cfg.EpisodeId, point_cfg.FightType)
end

function ui:on_click_reset_btn()
  local cfg
  for group_id, entry_id in pairs(self.v_select_entry_map) do
    cfg = ShareRes.get_infinite_entry_cfg(entry_id)
    if not self.v_must_select_group[group_id] then
      self.v_select_entry_map[group_id] = nil
      self.v_old_select_entry_map[group_id] = nil
      if self.v_endless_entry_type_map[cfg.Type][entry_id] then
        self.v_endless_entry_type_map[cfg.Type][entry_id] = nil
      end
      PlayerPrefsMgr:set_endless_ratio(group_id, self.v_infinite_id, entry_id)
    end
  end
  for key, type_value in pairs(INFINITE_ENTRY_TYPE) do
    self.v_endless_entry_type_count[type_value] = UtilTable.hash_lenth(self.v_endless_entry_type_map[type_value])
  end
  self:refresh_select_entry()
  for group_id, item in pairs(self.v_endless_entry_group_map) do
    if not self.v_must_select_group[group_id] then
      item:clear_select_data()
      item:refresh_select_entry()
      item:refresh_group_data()
    end
  end
  ChapterEndlessMgr:record_infinite_select_entry(self.v_infinite_id, self.v_select_entry_map)
end

function ui:on_click_return_btn()
  self:ui_hide()
end

function ui:on_select_entry(group_id, entry_id, entry_type, last_entry_id)
  if self.v_endless_entry_type_map[entry_type] then
    if last_entry_id then
      self.v_endless_entry_type_map[entry_type][last_entry_id] = nil
    end
    if entry_id then
      self.v_endless_entry_type_map[entry_type][entry_id] = true
    end
  end
  self.v_endless_entry_type_count[entry_type] = UtilTable.hash_lenth(self.v_endless_entry_type_map[entry_type])
  self.v_select_entry_map[group_id] = entry_id
  self:refresh_select_entry(nil == entry_id)
end

function ui:ui_on_show(infinite_id)
  local pos = self.v_uicompents.BuffGroupContent_rect.anchoredPosition
  self.v_uicompents.BuffGroupContent_rect:SetAnchoredPositionA(pos.x, 0, pos.z)
  self.is_hard = nil
  self.v_infinite_id = infinite_id
  self.v_uicompents.HardPd_pd:ResetPD()
  self.v_uicompents.SimplePd_pd:ResetPD()
  self:refresh_entry_group()
  self:refresh_select_entry()
  self:refresh_score()
  self:refresh_bg()
  self:create_blur()
end

function ui:ui_on_hide()
  self:clear_entry_group()
  UtilTable.clear_map(self.v_must_select_group)
  self.v_old_select_entry_map = nil
  self.v_select_entry_map = nil
  for key, type_value in pairs(INFINITE_ENTRY_TYPE) do
    self.v_endless_entry_type_map[type_value] = {}
    self:reset_entry_count(type_value)
  end
  self:release_blur_texture()
end

function ui:ui_on_destroy()
end

function ui:init_select_map()
  for key, type_value in pairs(INFINITE_ENTRY_TYPE) do
    self:reset_entry_count(type_value)
  end
  local record_map = ChapterEndlessMgr:get_infinite_select_entry(self.v_infinite_id)
  if record_map then
    self.v_select_entry_map = UtilTable.copy_table(record_map)
    local cfg
    for _, entry_id in pairs(self.v_select_entry_map) do
      cfg = ShareRes.get_infinite_entry_cfg(entry_id)
      if self.v_endless_entry_type_map[cfg.Type] then
        self.v_endless_entry_type_map[cfg.Type][entry_id] = true
        self.v_endless_entry_type_count[cfg.Type] = self.v_endless_entry_type_count[cfg.Type] + 1
      else
        Log.Error("获取词条分组失败，无效词条Type:", cfg.Type, "词条ID:", entry_id)
      end
    end
  else
    self.v_select_entry_map = {}
  end
  self.v_old_select_entry_map = UtilTable.copy_table(self.v_select_entry_map)
end

function ui:create_blur()
  Global.ui_mgr:set_backgroud_blur(self.v_cfg.name, self._set_blur_img, self)
end

function ui:refresh_bg()
  local cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  if not Util.is_empty(cfg.BgName) then
    ResMgr:load_set_icon(self.v_uicompents.FullBg_img, cfg.BgName, nil, true, self)
  end
end

function ui:refresh_score()
  local data = ChapterMgr:get_inf_chapter_data(self.v_infinite_id)
  self.v_uicompents.HistoryScore_txt.text = data.history_max_score or 0
end

function ui:refresh_entry_group()
  self:init_select_map()
  local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  local temp_list = {}
  if infinite_cfg.OptionGroup then
    for _, option_group_id in pairs(infinite_cfg.OptionGroup) do
      local all_group_cfg = ShareRes.get_infinite_entry_group_by_option(option_group_id)
      if all_group_cfg then
        for _, group_cfg in pairs(all_group_cfg) do
          temp_list[#temp_list + 1] = group_cfg
        end
      else
        Log.Error("获取词条配置失败，词条组id：", option_group_id)
      end
    end
  end
  table.sort(temp_list, sort)
  self:clear_entry_group()
  local group_id
  local obj_name = self.v_uiobjects.BuffGroupTem.name
  for index, group_cfg in ipairs(temp_list) do
    group_id = group_cfg.Id
    if group_cfg.Must then
      self.v_must_select_group[group_id] = true
    end
    local obj = self:get_auto_cache(ENDLESS_ENTRY_GROUP_ITEM)
    obj.name = obj_name .. index
    local item = ENDLESS_ENTRY_GROUP_ITEM_CLASS:ui_wrap_ex(self, obj, true)
    item:set_data(group_cfg, self.v_infinite_id)
    self.v_endless_entry_group_map[group_id] = item
  end
end

function ui:refresh_select_entry(is_remove)
  local temp_list = {}
  local cfg
  for key, entry_id in pairs(self.v_select_entry_map) do
    cfg = ShareRes.get_infinite_entry_cfg(entry_id)
    temp_list[#temp_list + 1] = cfg
  end
  self:give_back_auto_cache(ENDLESS_ENTRY_ITEM)
  if #temp_list <= 0 then
    self.v_uiobjects.NoBuff:SetActive(true)
  else
    self.v_uiobjects.NoBuff:SetActive(false)
    table.sort(temp_list, sort2)
  end
  local quality_img, icon_img, num_txt, pd
  local main_cfg = ShareRes.get_chapter_infinite_misc()
  local total_lv = main_cfg.DefaultCoeff or 0
  local entry_id, old_entry_id
  if is_remove then
    self:remove_select_entry()
  end
  local obj_name = self.v_uiobjects.BuffTem.name
  for index, entry_cfg in ipairs(temp_list) do
    entry_id = entry_cfg.Id
    local obj = self:get_auto_cache(ENDLESS_ENTRY_ITEM)
    obj.name = obj_name .. index
    obj.transform:SetAsLastSibling()
    quality_img = self:get_image("Quality", obj)
    ResMgr:load_set_icon(quality_img, QUALITY_PATH[entry_cfg.Quality])
    icon_img = self:get_image("BuffIcon", obj)
    ResMgr:load_set_icon(icon_img, entry_cfg.Icon)
    num_txt = self:get_text("DifficultyNum", obj)
    num_txt.text = entry_cfg.DifficultyCeof >= 0 and "+ " .. entry_cfg.DifficultyCeof or entry_cfg.DifficultyCeof
    total_lv = total_lv + entry_cfg.DifficultyCeof
    old_entry_id = self.v_old_select_entry_map[entry_cfg.OwnerEntryGroup]
    if not old_entry_id or old_entry_id ~= entry_id then
      pd = Util.get_playabledirector("Ani_BuffTem_Move", obj)
      pd:ResetPD()
      pd:Play()
      self.v_old_select_entry_map[entry_cfg.OwnerEntryGroup] = entry_id
    end
  end
  self:refresh_hard_or_simple(total_lv)
  self:refresh_buff_count()
end

function ui:remove_select_entry()
  for group_id, entry_id in pairs(self.v_old_select_entry_map) do
    if not self.v_select_entry_map[group_id] then
      self.v_old_select_entry_map[group_id] = nil
    end
  end
end

function ui:refresh_hard_or_simple(total_lv)
  local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  local is_hard = total_lv >= infinite_cfg.HardStyle
  local hard_color = HARD_COLOR[is_hard]
  local hard_bg_color = HARD_BG_COLOR[is_hard]
  if self.is_hard ~= is_hard then
    if self.is_hard ~= nil then
      if is_hard then
        self:play_hard_pd()
      else
        self:play_simple_pd()
      end
    end
    self.is_hard = is_hard
  end
  Util.set_color(self.v_uicompents.DifficultyNumTotal_txt, hard_color)
  Util.set_color(self.v_uicompents.DifficultyIcon_img, hard_color)
  Util.set_color(self.v_uicompents.DifficultyBg_img, hard_bg_color)
  self.v_uicompents.DifficultyNumTotal_txt.text = "x" .. total_lv
  self.v_uiobjects.Fx_UIEndlessPreFight_Bg:SetActive(is_hard)
end

function ui:play_hard_pd()
  self.v_uicompents.HardPd_pd:ResetPD()
  self.v_uicompents.HardPd_pd:Play()
  self.v_uicompents.SimplePd_pd:ResetPD()
  self.v_uiobjects.Glow:SetActive(true)
end

function ui:play_simple_pd()
  self.v_uicompents.HardPd_pd:ResetPD()
  self.v_uicompents.SimplePd_pd:ResetPD()
  self.v_uicompents.SimplePd_pd:Play()
  self.v_uiobjects.Glow:SetActive(false)
end

function ui:get_select_entry_id(group_id)
  return self.v_select_entry_map[group_id]
end

function ui:get_select_bg_color(is_select)
  return SELECT_BG_COLOR[is_select]
end

function ui:get_cache_data()
  return self.v_infinite_id
end

function ui:cache_ui()
  return true
end

function ui:check_is_must_select(group_id)
  return self.v_must_select_group[group_id]
end

function ui:check_is_select_all_must_group()
  for group_id, _ in pairs(self.v_must_select_group) do
    if not self:get_select_entry_id(group_id) then
      return false
    end
  end
  return true
end

function ui:clear_entry_group()
  self:give_back_auto_cache(ENDLESS_ENTRY_GROUP_ITEM)
  for key, item in pairs(self.v_endless_entry_group_map) do
    item:ui_hide()
    item:ui_destroy()
    self.v_endless_entry_group_map[key] = nil
  end
end

function ui:check_type_select_entry_count(entry_type)
  local cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  local limit = cfg[INFINITE_ENTRY_LIMIT[entry_type]]
  return limit >= self.v_endless_entry_type_count[entry_type] + 1
end

function ui:get_type_select_count_and_limit(entry_type)
  local cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  local limit = cfg[INFINITE_ENTRY_LIMIT[entry_type]]
  return self.v_endless_entry_type_count[entry_type], limit
end

function ui:refresh_buff_count()
  local cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  local limit = cfg[INFINITE_ENTRY_LIMIT[INFINITE_ENTRY_TYPE.GAIN]]
  local count = self.v_endless_entry_type_count[INFINITE_ENTRY_TYPE.GAIN]
  self.v_uicompents.BuffNumNow_txt.text = count
  self.v_uicompents.BuffNumMax_txt.text = limit
  limit = cfg[INFINITE_ENTRY_LIMIT[INFINITE_ENTRY_TYPE.NEGATIVE]]
  count = self.v_endless_entry_type_count[INFINITE_ENTRY_TYPE.NEGATIVE]
  self.v_uicompents.DebuffNumNow_txt.text = count
  self.v_uicompents.DebuffNumMax_txt.text = limit
end

function ui:reset_entry_count(entry_type)
  self.v_endless_entry_type_count[entry_type] = 0
end

return ui
