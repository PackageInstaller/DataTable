local Grid = Util.create_child_mt(require("ui.uiobject"))
local GridType = MineSweeperMgr.GRID_TYPE
local GridState = MineSweeperMgr.GRID_STATE
local GridUIState = MineSweeperMgr.GRID_UI_STATE
local BuffFxMap = {
  "Fx_Glod",
  "Fx_Pur",
  "Fx_Blue"
}

function Grid:ui_finish_load()
  self.v_nodetem_img = Util.get_image(nil, self.v_object)
  
  function self.v_wrap_fun()
    self:unlock()
    self:refresh()
    self.v_uicompents.Ani_UIMineBattle_Teshu_In_pd:Play()
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.minesweeper_grid_in_SOUND)
  end
  
  self.v_uicompents.Ani_UIMineBattle_Out_pd:stopped("+", self.v_wrap_fun)
end

function Grid:set_data(data)
  self.v_grid_info = data
  if self.v_lock then
    return
  end
  self:refresh()
  if not self.v_set_button_callback then
    local btn = Util.get_button(nil, self.v_object)
    self:set_button_listener(btn, function()
      if self.v_lock then
        return
      end
      if self.v_grid_info.ui_state == GridUIState.HIDE or self.v_grid_info.ui_state == GridUIState.SHOW then
        self.v_parent_ui:on_click_grid(self.v_grid_info.index)
      end
    end)
    self.v_set_button_callback = true
  end
end

function Grid:on_clear()
  self.v_uicompents.Ani_UIMineBattle_Out_pd:stopped("-", self.v_wrap_fun)
end

function Grid:refresh()
  local grid_id = self.v_grid_info.grid_id
  local state = self.v_grid_info.state
  local ui_state = self.v_grid_info.ui_state
  local is_selected = self.v_parent_ui.select_grid_index == self.v_grid_info.index
  if UNITY_EDITOR then
    self.v_uicompents.Text_txt.text = grid_id
    self.v_uicompents.TextState_txt.text = state
    self.v_uicompents.TextUIState_txt.text = ui_state
  end
  if ui_state == GridUIState.HIDE then
    local flags = 32
    self:set_uiobject(flags)
  elseif ui_state == GridUIState.HIDEFORBID then
    local flags = 1
    self:set_uiobject(flags)
  elseif ui_state == GridUIState.FORBID then
    local flags = 16
    self:set_uiobject(flags)
  elseif ui_state == GridUIState.GHOST then
    local flags = 256
    self:set_uiobject(flags)
  elseif ui_state == GridUIState.SHOW then
    local grid_type = self.v_grid_info.grid_type
    if grid_type == GridType.EMPTY or grid_type == GridType.ENTRANCE then
      local flags = is_selected and 8 or 0
      self:set_uiobject(flags)
    elseif grid_type == GridType.BLESS then
      if state == GridState.SHOW then
        local bless_id = self.v_grid_info.args[1]
        local bless_cfg = ShareRes.get_minesweeper_bless_cfg(bless_id)
        local bless_quality_id = bless_cfg.Quality
        local grid_cfg = ShareRes.get_minesweeper_grid_cfg(grid_id)
        local flags = 196 | (is_selected and 8 or 0)
        self:set_uiobject(flags)
        local bless_quality_icon = ShareRes.get_minesweeper_bless_quality_cfg(bless_quality_id).Icon
        ResMgr:load_set_icon(self.v_uicompents.Bg_img, grid_cfg.Bg)
        ResMgr:load_set_icon(self.v_uicompents.BuffQualityIcon_img, bless_quality_icon)
        ResMgr:load_set_icon(self.v_uicompents.Icon_img, bless_cfg.Icon)
        for quality_id, fx_name in ipairs(BuffFxMap) do
          local obj = self.v_uiobjects[fx_name]
          obj:SetActiveEx(quality_id == bless_quality_id)
        end
      elseif state == GridState.SHOWANDUSE then
        local flags = 0
        self:set_uiobject(flags)
      end
    elseif grid_type == GridType.EXIT then
      local grid_cfg = ShareRes.get_minesweeper_grid_cfg(grid_id)
      local flags = 192
      local select_flag = is_selected and 8 or 0
      local stairlock_flag = not MineSweeperMgr.exit_grid_unlocked and 2 or 0
      flags = flags | select_flag | stairlock_flag
      self:set_uiobject(flags)
      ResMgr:load_set_icon(self.v_uicompents.Bg_img, grid_cfg.Bg)
      ResMgr:load_set_icon(self.v_uicompents.Icon_img, grid_cfg.Icon)
    elseif grid_type == GridType.MONSTER then
      if state == GridState.SHOW then
        local grid_cfg = ShareRes.get_minesweeper_grid_cfg(grid_id)
        local flags = 192
        flags = flags | (is_selected and 8 or 0)
        self:set_uiobject(flags)
        ResMgr:load_set_icon(self.v_uicompents.Bg_img, grid_cfg.Bg)
        ResMgr:load_set_icon(self.v_uicompents.Icon_img, grid_cfg.Icon)
      elseif state == GridState.SHOWANDUSE then
        local flags = 0
        self:set_uiobject(flags)
      end
    elseif grid_type == GridType.BOSS then
      if state == GridState.SHOW then
        local grid_cfg = ShareRes.get_minesweeper_grid_cfg(grid_id)
        local flags = 704
        flags = flags | (is_selected and 8 or 0)
        self:set_uiobject(flags)
        ResMgr:load_set_icon(self.v_uicompents.Bg_img, grid_cfg.Bg)
        ResMgr:load_set_icon(self.v_uicompents.Icon_img, grid_cfg.Icon)
      elseif state == GridState.SHOWANDUSE then
        local flags = 0
        self:set_uiobject(flags)
      end
    elseif grid_type == GridType.ITEM then
      if state == GridState.SHOW then
        local grid_cfg = ShareRes.get_minesweeper_grid_cfg(grid_id)
        local flags = 1216
        flags = flags | (is_selected and 8 or 0)
        self:set_uiobject(flags)
        ResMgr:load_set_icon(self.v_uicompents.Bg_img, grid_cfg.Bg)
        ResMgr:load_set_icon(self.v_uicompents.Icon_img, grid_cfg.Icon)
        self.v_uicompents.Itemtext_txt.text = grid_cfg.Args[2]
      elseif state == GridState.SHOWANDUSE then
        local flags = 0
        self:set_uiobject(flags)
      end
    else
      local grid_cfg = ShareRes.get_minesweeper_grid_cfg(grid_id)
      local flags = 192
      flags = flags | (is_selected and 8 or 0)
      self:set_uiobject(flags)
      ResMgr:load_set_icon(self.v_uicompents.Bg_img, grid_cfg.Bg)
      ResMgr:load_set_icon(self.v_uicompents.Icon_img, grid_cfg.Icon)
    end
  end
end

function Grid:get_data()
  return self.v_grid_info
end

function Grid:select()
  self.v_uiobjects.Select:SetActiveEx(true)
end

function Grid:deselect()
  self.v_uiobjects.Select:SetActiveEx(false)
end

function Grid:set_uiobject(uiobject_flags)
  self.v_uiobjects.Bg:SetActiveEx(1 == uiobject_flags >> 7 & 1)
  self.v_uiobjects.Icon:SetActiveEx(1 == uiobject_flags >> 6 & 1)
  self.v_uiobjects.Close:SetActiveEx(1 == uiobject_flags >> 5 & 1)
  self.v_uiobjects.Forbid:SetActiveEx(1 == uiobject_flags >> 4 & 1)
  self.v_uiobjects.Select:SetActiveEx(1 == uiobject_flags >> 3 & 1)
  self.v_uiobjects.Buff:SetActiveEx(1 == uiobject_flags >> 2 & 1)
  self.v_uiobjects.StairLock:SetActiveEx(1 == uiobject_flags >> 1 & 1)
  self.v_uiobjects.Mask:SetActiveEx(1 == uiobject_flags & 1)
  self.v_nodetem_img.enabled = 1 ~= uiobject_flags >> 8 & 1 and true or false
  local scale = 1 == uiobject_flags >> 9 & 1 and 3 or 1
  self.v_object.transform:SetLocalScaleA(scale, scale, 1)
  self.v_uiobjects.Item:SetActiveEx(1 == uiobject_flags >> 10 & 1)
end

function Grid:lock()
  self.v_lock = true
end

function Grid:unlock()
  self.v_lock = false
end

function Grid:play_flip_vfx()
  self:lock()
  self.v_uicompents.Ani_UIMineBattle_Out_pd:Play()
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.minesweeper_grid_flip_SOUND)
end

function Grid:play_out_vfx()
  self:lock()
  self.v_uicompents.Ani_UIMineBattle_Out_pd:Play()
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.minesweeper_grid_out_SOUND)
end

return Grid
