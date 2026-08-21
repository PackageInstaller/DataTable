local Base = require("ui.uiobject")
local LoopListClass = require("ui.widget.infinite_loop_list")
local WEAPON_ITEM_CLASS = require("uimodule.archives.archive_equip_item")
local ui = Util.create_child_mt(Base)
local _tinsert = table.insert
local _tsort = table.sort

function ui:ui_finish_load()
  self.v_weapon_loop_list = LoopListClass:new(self, self.v_uiobjects.EquipViewList, WEAPON_ITEM_CLASS)
end

function ui:ui_on_show()
  self.v_build_data, self.v_get_num, self.v_all_num = self:build_data()
  self:refresh_panel_info(self.v_get_num, self.v_all_num)
  self.v_weapon_loop_list:stop_scroll()
  self.v_uiobjects.EquipViewList:SetActive(false)
  if self.v_refresh_timer then
    Timer:remove_timer(self.v_refresh_timer)
    self.v_refresh_timer = nil
  else
    self.v_refresh_timer = Timer:add_timer("archive_equip_refresh", 0.1, function()
      self:refresh_weapon_cell(self.v_build_data)
      self:play_in_eff()
      self.v_uiobjects.EquipViewList:SetActive(true)
    end)
  end
end

function ui:build_data()
  local original_weapon_info = ShareRes.get_equip()
  local temp = {}
  local get_num = 0
  local all_num = 0
  local any_red = false
  for id, cfg in pairs(original_weapon_info) do
    if not cfg.BuddyID then
    elseif ShareRes.get_buddy_is_show(cfg.BuddyID) and cfg.ShowInArchive and CharacterMgr:check_buddy_release(cfg.BuddyID) then
      local temp_insert = {}
      temp_insert.weapon_name = cfg.Name
      temp_insert.weapon_icon = cfg.Icon
      temp_insert.weapon_id = cfg.Id
      temp_insert.weapon_quality = cfg.Quality
      temp_insert.weapon_quality_bg1 = ShareRes.get_equip_icon_cfg(cfg.Quality).ArchiveQualityBg
      temp_insert.weapon_quality_bg2 = ShareRes.get_equip_icon_cfg(cfg.Quality).ArchiveQualityBgBottom
      temp_insert.weapon_quality_icon = ShareRes.get_equip_icon_cfg(cfg.Quality).QualityIcon
      temp_insert.weapon_isred = ArchiveMgr:is_redpoint_archive_equip(cfg.Id)
      temp_insert.weapon_isunlock = ArchiveMgr:is_unlock_archive_equip(cfg.Id)
      _tinsert(temp, temp_insert)
      if temp_insert.weapon_isunlock then
        get_num = get_num + 1
      end
      if temp_insert.weapon_isred then
        any_red = true
      end
      all_num = all_num + 1
    end
  end
  
  local function sort_func(a, b)
    if a.weapon_isunlock ~= b.weapon_isunlock then
      return a.weapon_isunlock
    end
    if a.weapon_quality ~= b.weapon_quality then
      return a.weapon_quality > b.weapon_quality
    end
    if a.weapon_id ~= b.weapon_id then
      return a.weapon_id < b.weapon_id
    end
    return false
  end
  
  _tsort(temp, sort_func)
  return temp, get_num, all_num, any_red
end

function ui:refresh_weapon_cell(use_data)
  self.v_weapon_loop_list:refresh_data(use_data)
end

function ui:refresh_panel_info(get_num, all_num)
  self.v_uicompents.NowNum_txt.text = get_num
  self.v_uicompents.MaxNum_txt.text = all_num
end

function ui:click_item(weapon_id, isred)
  if weapon_id then
    if isred then
      ArchiveMgr:req_click_action(ArchiveMgr.CommonDefind.ARCH_TYPE.EQUIP_SYS, weapon_id)
    end
    UIMgr:get_ui("char_weapon", true):ui_show(nil, nil, nil, weapon_id)
  end
end

function ui:disable_all_red_point()
  ArchiveMgr:disable_all_equip_red()
end

function ui:play_in_eff()
end

function ui:ui_on_hide()
  if self.v_refresh_timer then
    Timer:remove_timer(self.v_refresh_timer)
    self.v_refresh_timer = nil
  end
  self.v_weapon_loop_list:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_weapon_loop_list:ui_on_destroy()
end

function ui:cache_ui()
  return true
end

return ui
