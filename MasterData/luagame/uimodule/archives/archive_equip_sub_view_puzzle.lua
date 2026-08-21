local Base = require("ui.uiobject")
local LoopListClass = require("ui.widget.infinite_loop_list")
local PUZZLE_ITEM_CLASS = require("uimodule.archives.archive_puzzle_item")
local QUALITY_CFG = ShareRes.create("buddy.buddy_puzzle_quality")
local ui = Util.create_child_mt(Base)
local _tinsert = table.insert
local _tsort = table.sort

function ui:ui_finish_load()
  self.v_puzzle_loop_list = LoopListClass:new(self, self.v_uiobjects.PluginList, PUZZLE_ITEM_CLASS)
end

function ui:ui_on_show()
  self.v_build_data, self.v_get_num, self.v_all_num = self:build_data()
  self.v_uicompents.NowNum_txt.text = self.v_get_num
  self.v_uicompents.MaxNum_txt.text = self.v_all_num
  self.v_quality_page_list = {}
  for quality = 1, 3 do
    local btn = self.v_uicompents["Lv" .. quality .. "_btn"]
    self:set_button_listener(btn, function()
      self:switch_quality(quality)
    end)
    self.v_quality_page_list[quality] = self.v_uiobjects["LvBg" .. quality]
  end
  self:refresh_view(self.v_build_data[1].id)
  self.v_puzzle_loop_list:stop_scroll()
  self:refresh_puzzle_cell(self.v_build_data)
  self:refresh_list_selected()
end

function ui:refresh_view(puzzle_id)
  self.v_puzzle_id = puzzle_id
  self.v_puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(puzzle_id)
  self:switch_quality(1)
end

function ui:get_selected_puzzle_id()
  return self.v_puzzle_id
end

function ui:refresh_list_selected()
  local all_itmes = self.v_puzzle_loop_list:get_all_uis()
  for _, ui_item in pairs(all_itmes) do
    ui_item:update_selected()
  end
end

function ui:switch_quality(quality)
  for index, obj in ipairs(self.v_quality_page_list) do
    obj:SetActiveEx(quality == index)
  end
  quality = quality + 2
  local icon_path = self.v_puzzle_cfg.IconPath[quality]
  ResMgr:load_set_icon(self.v_uicompents.PluginsIcon_img, icon_path, function()
    self.v_uicompents.PluginsIcon_img:SetNativeSize()
  end, true)
  ResMgr:load_set_icon(self.v_uicompents.QualityBg_img, QUALITY_CFG[quality].QualityBgArchive)
  ResMgr:load_set_icon(self.v_uicompents.ItemIcon_img, ShareRes.get_item_icon_path(self.v_puzzle_cfg.Id))
  local item_quality_path = ShareRes.get_quality_path(quality)
  ResMgr:load_set_icon(self.v_uicompents.ItemQuality_img, item_quality_path)
  self.v_uicompents.ItemName_txt.text = self.v_puzzle_cfg.Name
  local entry_id = self.v_puzzle_cfg.EntryId
  self.v_uiobjects.EffectObj:SetActive(nil ~= entry_id)
  if entry_id then
    local entry_cfg = ShareRes.get_buddy_puzzle_entry_cfg(entry_id, quality)
    self.v_uicompents.EffectName_txt.text = entry_cfg.Name
    self.v_uicompents.EffectLv_txt.text = "Lv." .. entry_cfg.Lv
    self.v_uicompents.EffectDesc_txt.text = entry_cfg.Desc
  end
  local desc = self.v_puzzle_cfg.ArchiveDesc
  self.v_uiobjects.StoryObj:SetActive(nil ~= desc)
  if desc then
    self.v_uicompents.StoryDesc_txt.text = self.v_puzzle_cfg.ArchiveDesc
  end
end

function ui:build_data()
  local buddy_puzzles = ShareRes.create("buddy.buddy_puzzle")
  local temp = {}
  local get_num = 0
  local all_num = 0
  local any_red = false
  for id, cfg in pairs(buddy_puzzles) do
    if cfg.ShowInArchive and self:check_puzzle_release(cfg) then
      local temp_insert = {}
      temp_insert.id = id
      temp_insert.cfg = cfg
      temp_insert.puzzle_isred = ArchiveMgr:is_redpoint_archive_puzzle(cfg.Id)
      temp_insert.puzzle_isunlock = ArchiveMgr:is_unlock_archive_puzzle(cfg.Id)
      _tinsert(temp, temp_insert)
      if temp_insert.puzzle_isunlock then
        get_num = get_num + 1
      end
      if temp_insert.puzzle_isred then
        any_red = true
      end
      all_num = all_num + 1
    end
  end
  
  local function sort_func(a, b)
    if a.puzzle_isunlock ~= b.puzzle_isunlock then
      return a.puzzle_isunlock
    end
    return a.id < b.id
  end
  
  _tsort(temp, sort_func)
  return temp, get_num, all_num, any_red
end

function ui:refresh_puzzle_cell(use_data)
  self.v_puzzle_loop_list:refresh_data(use_data)
end

function ui:click_item(puzzle_id)
  if puzzle_id then
    self:refresh_view(puzzle_id)
    self:refresh_list_selected()
  end
end

function ui:disable_all_red_point()
  ArchiveMgr:disable_all_puzzle_red()
end

function ui:ui_on_hide()
  if self.v_refresh_timer then
    Timer:remove_timer(self.v_refresh_timer)
    self.v_refresh_timer = nil
  end
  self.v_puzzle_loop_list:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_puzzle_loop_list:ui_on_destroy()
end

function ui:cache_ui()
  return true
end

function ui:check_puzzle_release(puzzle_cfg)
  if puzzle_cfg and puzzle_cfg.ReleaseTime then
    return Date.check_time_pass_by_scheme_id(puzzle_cfg.ReleaseTime)
  end
  return true
end

return ui
