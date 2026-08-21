local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local MineSweeperBuffUI = require("uimodule.activity.minesweeper.ui_minesweeper_buff")
local GridTemClass = require("uimodule.activity.minesweeper.grid_tem_class")
local GridTemKey = "MINESWEEPER_GRIDTEM"
local BlessTemClass = Util.create_child_mt(require("ui.uiobject"))
local BlessTemKey = "MINESWEEPER_BLESSTEM"
local mathx = require("base.mathx")
local GridState = MineSweeperMgr.GRID_STATE
local GridType = MineSweeperMgr.GRID_TYPE
local GridUIState = MineSweeperMgr.GRID_UI_STATE
local minesweeper_misc = ShareRes.get_minesweeper_misc()
local _insert = table.insert
local col = minesweeper_misc.Col
local row = minesweeper_misc.Row
local neighbour_offsets = {
  -col,
  -1,
  1,
  col
}
local neighbour_x_offsets = {
  0,
  -1,
  1,
  0
}
local neighbour_y_offsets = {
  -1,
  0,
  0,
  1
}
local monster_neighbour_offsets = {
  -col - 1,
  -col,
  -col + 1,
  -1,
  1,
  col - 1,
  col,
  col + 1
}
local monster_neighbour_x_offsets = {
  -1,
  0,
  1,
  -1,
  1,
  -1,
  0,
  1
}
local monster_neighbour_y_offsets = {
  -1,
  -1,
  -1,
  0,
  0,
  1,
  1,
  1
}
local boss_neighbour_offsets = {
  -2 * col - 2,
  -2 * col - 1,
  -2 * col,
  -2 * col + 1,
  -2 * col + 2,
  -col - 2,
  -col + 2,
  -2,
  2,
  col - 2,
  col + 2,
  2 * col - 2,
  2 * col - 1,
  2 * col,
  2 * col + 1,
  2 * col + 2
}
local boss_neighbour_x_offsets = {
  -2,
  -1,
  0,
  1,
  2,
  -2,
  2,
  -2,
  2,
  -2,
  2,
  -2,
  -1,
  0,
  1,
  2
}
local boss_neighbour_y_offsets = {
  -2,
  -2,
  -2,
  -2,
  -2,
  -1,
  -1,
  0,
  0,
  1,
  1,
  2,
  2,
  2,
  2,
  2
}
local qualityid_to_item = {
  Item = {
    "Quality1",
    "Quality2",
    "Quality3"
  },
  Light = {
    "QualityLight1",
    "QualityLight2",
    "QualityLight3"
  }
}

function BlessTemClass:ui_finish_load()
end

function BlessTemClass:set_data(data)
  for quality_id, v in ipairs(qualityid_to_item.Item) do
    self.v_uiobjects[v]:SetActiveEx(quality_id == data.quality_id)
  end
  local light_name = qualityid_to_item.Light[data.quality_id]
  self.v_uiobjects[light_name]:SetActiveEx(data.show)
end

function BlessTemClass:on_clear()
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    Util.show_notify_popup_message(function()
      self:save_exit()
    end, "是否保存当前进度", nil, "保存进度", "直接结算", function()
      self:fail_exit()
    end, nil, nil, true)
  end)
  self:set_button("BtnResetFloor", function()
    Util.show_notify_popup_message(function()
      self:lock_all_grid()
      MineSweeperMgr:request_reset_floor(function()
        self:play_refresh_vfx()
      end, function()
        self:unlock_all_grid()
      end)
    end, "是否重置本层", nil, "是", "否", nil, nil, nil, true)
  end)
  self:set_button("BtnGold", function()
    self:enable_tips(true)
  end)
  self:set_button("BtnEnemy", function()
    self:enable_tips(true)
  end)
  self:set_button("BtnScore", function()
    self:enable_tips(true)
  end)
  self:set_button("BtnClose", function()
    self:enable_tips(false)
  end)
  self:set_button("BtnHpDetail", function()
    local rule_id = minesweeper_misc.RuleId[2]
    UIMgr:get_ui("info_tips"):ui_show(rule_id)
  end)
  self:set_button("BtnBagBuff", function()
    UIMgr:get_ui("ui_minesweeper_buff"):ui_show(MineSweeperBuffUI.Type.Bag)
  end)
  self:set_button("NodeButton", function()
    local grids = MineSweeperMgr:get_minesweeper_grid_list()
    local grid_info = grids[self.select_grid_index]
    if grid_info.grid_type == GridType.EXIT then
      local minesweeper_chapter_info = MineSweeperMgr:get_minesweeper_chapter_info()
      local cur_floor_idx = minesweeper_chapter_info.floor_idx
      if cur_floor_idx == MineSweeperMgr.base_max_floor then
        UIMgr:get_ui("ui_minesweeper_settle"):ui_show(MineSweeperMgr.GAME_SETTLEMENT_TYPE.SUCCESS, MineSweeperMgr.GAME_MODE.BASE, function()
          self:ui_hide()
        end, function()
          self:lock_all_grid()
          MineSweeperMgr:use_grid(self.select_grid_index, nil, function()
            self:select_grid()
            self:play_refresh_vfx()
          end)
        end)
      elseif cur_floor_idx == MineSweeperMgr.endless_max_floor then
        UIMgr:get_ui("ui_minesweeper_settle"):ui_show(MineSweeperMgr.GAME_SETTLEMENT_TYPE.SUCCESS, MineSweeperMgr.GAME_MODE.ENDLESS, function()
          self:ui_hide()
        end)
      else
        self:lock_all_grid()
        MineSweeperMgr:use_grid(self.select_grid_index, nil, function()
          self:select_grid()
          self:play_refresh_vfx()
        end)
      end
    else
      MineSweeperMgr:use_grid(self.select_grid_index)
    end
  end)
  self.v_item_function_table = {
    [MineSweeperMgr.ITEM_TYPE.GOLD] = function(args)
      local pre_gold = tonumber(self.v_uicompents.GoldNum_txt.text)
      self.v_uicompents.GoldNum_txt.text = pre_gold + args[2]
    end,
    [MineSweeperMgr.ITEM_TYPE.HEALTH] = function(args)
      local max_hp = minesweeper_misc.StaminaLimit
      self.v_cur_hp = math.min(self.v_cur_hp + args[2], max_hp)
      self.v_real_fillamount = self.v_cur_hp / max_hp
      self.v_uicompents.HpText_txt.text = self.v_cur_hp .. "/" .. max_hp
    end,
    [MineSweeperMgr.ITEM_TYPE.SCORE] = function(args)
      local score = tonumber(self.v_uicompents.ScoreNum_txt.text)
      self.v_uicompents.ScoreNum_txt.text = score + args[2]
    end
  }
  self.v_static_sv_grid = SaticSv:new(self, self.v_uiobjects.Content, GridTemClass, GridTemKey)
  self.v_static_sv_bless = SaticSv:new(self, self.v_uiobjects.BuffLayout, BlessTemClass, BlessTemKey)
  self.v_safearea_canvas_group = Util.get_canvas_group("SafeArea", self.v_object)
end

function ui:ui_on_show()
  self:register_event()
  self:refresh(true)
  self:select_grid()
  
  function self.v_wrap_fun()
    self.v_uicompents.Ani_UIMineBattle_Refresh_In_pd:Play()
    local grid_instance_list = self.v_static_sv_grid:get_items()
    for _, grid_instance in ipairs(grid_instance_list) do
      grid_instance:unlock()
      grid_instance:refresh()
    end
  end
  
  self.v_uicompents.Ani_UIMineBattle_Refresh_Out_pd:stopped("+", self.v_wrap_fun)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:ui_on_update()
  self:hp_update_vfx()
  self:resetfloor_cd()
end

function ui:ui_on_hide()
  self.v_static_sv_grid:clear()
  if self.v_timer_handles then
    for _, timer_handle in ipairs(self.v_timer_handles) do
      Timer:remove_timer(timer_handle)
    end
  end
  self.v_uicompents.Ani_UIMineBattle_Refresh_Out_pd:stopped("-", self.v_wrap_fun)
end

function ui:ui_on_destroy()
end

function ui:cache_ui()
  return true
end

function ui:refresh(is_open_ui)
  local minesweeper_info = MineSweeperMgr:get_minesweeper_chapter_info()
  self.v_cur_hp = minesweeper_info.blood_count
  local max_hp = minesweeper_misc.StaminaLimit
  self.v_real_fillamount = self.v_cur_hp / max_hp
  self.v_uicompents.HpText_txt.text = self.v_cur_hp .. "/" .. max_hp
  if is_open_ui then
    self.v_uicompents.HpBarFill_img.fillAmount = self.v_real_fillamount
  end
  self.v_uicompents.GoldNum_txt.text = minesweeper_info.gold_count
  self.v_uicompents.ScoreNum_txt.text = minesweeper_info.cur_score
  self.v_uicompents.EnvBuffDesc_txt.text = ShareRes.create("minesweeper.minesweeper_chapter")[minesweeper_info.chapter_id].BuffDesc
  local minesweeper_bless_quality_cfg = ShareRes.create("minesweeper.minesweeper_bless_quality")
  local max_minesweeper_bless_count = 0
  local bless_quality_limit = {}
  local bless_quality_count = {}
  for id, v in pairs(minesweeper_bless_quality_cfg) do
    max_minesweeper_bless_count = max_minesweeper_bless_count + v.Limit
    bless_quality_limit[id] = v.Limit
    bless_quality_count[id] = 0
  end
  self.v_uicompents.BuffNum_txt.text = string.format("(%d/%d)", #minesweeper_info.bless_list, max_minesweeper_bless_count)
  for _, bless_id in ipairs(minesweeper_info.bless_list) do
    local bless_quality = ShareRes.get_minesweeper_bless_cfg(bless_id).Quality
    bless_quality_count[bless_quality] = bless_quality_count[bless_quality] + 1
  end
  local temp_list = {}
  for id, limit in ipairs(bless_quality_limit) do
    for i = 1, limit do
      if bless_quality_count[id] > 0 then
        _insert(temp_list, {quality_id = id, show = true})
        bless_quality_count[id] = bless_quality_count[id] - 1
      else
        _insert(temp_list, {quality_id = id, show = false})
      end
    end
  end
  self.v_static_sv_bless:update_list(temp_list)
  local cur_floor_idx = minesweeper_info.floor_idx
  local base_max_floor = MineSweeperMgr.base_max_floor
  local is_base_floor = cur_floor_idx <= base_max_floor
  self.v_uiobjects.BasicFloor:SetActiveEx(is_base_floor)
  self.v_uiobjects.EndlessFloor:SetActiveEx(not is_base_floor)
  if is_base_floor then
    self.v_uicompents.BasicFloorNum_txt.text = cur_floor_idx .. "/" .. base_max_floor
  else
    self.v_uicompents.EndlessFloorNum_txt.text = cur_floor_idx
  end
  self:refresh_grid()
  local chapter_cfg = ShareRes.create("minesweeper.minesweeper_floor")[MineSweeperMgr.chapter_group_id][cur_floor_idx]
  local monster_totle_count = chapter_cfg.MonsterLimit
  local monster_finished_count = monster_totle_count
  local grids = MineSweeperMgr:get_minesweeper_grid_list()
  for _, grid_info in ipairs(grids) do
    local grid_type = grid_info.grid_type
    if (grid_type == GridType.MONSTER or grid_type == GridType.BOSS) and grid_info.state ~= GridState.SHOWANDUSE then
      monster_finished_count = monster_finished_count - 1
    end
  end
  self.v_uicompents.EnemyNum_txt.text = monster_finished_count .. "/" .. monster_totle_count
  if self.select_grid_index then
    local grid = self.v_static_sv_grid:get_item_by_idx(self.select_grid_index)
    grid:select()
  end
  if self.v_cur_hp <= 0 then
    local ui_minesweeper_settle = UIMgr:try_get_visible_ui("ui_minesweeper_settle")
    if not ui_minesweeper_settle then
      UIMgr:get_ui("ui_minesweeper_settle"):ui_show(MineSweeperMgr.GAME_SETTLEMENT_TYPE.FAIL, nil, function()
        self:ui_hide()
      end)
    end
    return
  end
  if true == MineSweeperMgr.finish_all_monster and not minesweeper_info.is_open_all_grid then
    self:unbind_all_auto_mq()
    MineSweeperMgr:request_minesweeper_open_all_grid(function()
      self:ending_vfx()
    end)
  end
end

function ui:fail_exit()
  UIMgr:get_ui("ui_minesweeper_settle"):ui_show(MineSweeperMgr.GAME_SETTLEMENT_TYPE.MANUAL_EXIT, nil, function()
    self:ui_hide()
  end)
end

function ui:save_exit()
  self:ui_hide()
end

function ui:hp_update_vfx()
  local fill_img = self.v_uicompents.HpBarFill_img
  local src_fillamount = fill_img.fillAmount
  fill_img.fillAmount = mathx.lerp_number(src_fillamount, self.v_real_fillamount, 0.3)
end

function ui:resetfloor_cd()
  local cool_down_time = MineSweeperMgr.cool_down_time
  local real_time = Global.real_time
  if cool_down_time and cool_down_time > real_time then
    local diff = math.ceil(cool_down_time - real_time)
    self.v_uiobjects.CDNum:SetActiveEx(true)
    self.v_uicompents.CDNum_txt.text = diff
    self.v_uicompents.BtnResetFloor_btn.interactable = false
  else
    self.v_uiobjects.CDNum:SetActiveEx(false)
    self.v_uicompents.BtnResetFloor_btn.interactable = true
  end
end

function ui:refresh_grid()
  local grids = MineSweeperMgr:get_minesweeper_grid_list()
  local show_monster_boss_grid_list = {}
  local show_normal_grid_list = {}
  for index, grid_info in ipairs(grids) do
    grid_info.ui_state = nil
    local grid_type = grid_info.grid_type
    if grid_type == GridType.BOSS or grid_type == GridType.MONSTER then
      if grid_info.state == GridState.SHOW then
        _insert(show_monster_boss_grid_list, index)
      elseif grid_info.state == GridState.SHOWANDUSE then
        _insert(show_normal_grid_list, index)
      end
    elseif grid_info.state == GridState.SHOW or grid_info.state == GridState.SHOWANDUSE then
      _insert(show_normal_grid_list, index)
    end
  end
  for _, grid_index in ipairs(show_monster_boss_grid_list) do
    local grid_info = grids[grid_index]
    local grid_type = grid_info.grid_type
    if grid_type == GridType.MONSTER then
      grid_info.ui_state = GridUIState.SHOW
      for i, offset in ipairs(monster_neighbour_offsets) do
        local neighbour_grid_x = grid_info.col + monster_neighbour_x_offsets[i]
        local neighbour_grid_y = grid_info.row + monster_neighbour_y_offsets[i]
        if neighbour_grid_x > 0 and neighbour_grid_x <= col and neighbour_grid_y > 0 and neighbour_grid_y <= row then
          local neighbour_grid_index = grid_index + offset
          local neighbour_grid_info = grids[neighbour_grid_index]
          neighbour_grid_info.ui_state = GridUIState.FORBID
        end
      end
    elseif grid_type == GridType.BOSS then
      grid_info.ui_state = GridUIState.SHOW
      for i, offset in ipairs(monster_neighbour_offsets) do
        local neighbour_grid_x = grid_info.col + monster_neighbour_x_offsets[i]
        local neighbour_grid_y = grid_info.row + monster_neighbour_y_offsets[i]
        if neighbour_grid_x > 0 and neighbour_grid_x <= col and neighbour_grid_y > 0 and neighbour_grid_y <= row then
          local neighbour_grid_index = grid_index + offset
          local neighbour_grid_info = grids[neighbour_grid_index]
          neighbour_grid_info.ui_state = GridUIState.GHOST
        end
      end
      for i, offset in ipairs(boss_neighbour_offsets) do
        local neighbour_grid_x = grid_info.col + boss_neighbour_x_offsets[i]
        local neighbour_grid_y = grid_info.row + boss_neighbour_y_offsets[i]
        if neighbour_grid_x > 0 and neighbour_grid_x <= col and neighbour_grid_y > 0 and neighbour_grid_y <= row then
          local neighbour_grid_index = grid_index + offset
          local neighbour_grid_info = grids[neighbour_grid_index]
          neighbour_grid_info.ui_state = GridUIState.FORBID
        end
      end
    end
  end
  for _, grid_index in ipairs(show_normal_grid_list) do
    local grid_info = grids[grid_index]
    if grid_info.ui_state ~= GridUIState.GHOST then
      grid_info.ui_state = GridUIState.SHOW
    end
  end
  for grid_index, grid_info in ipairs(grids) do
    if not grid_info.ui_state then
      local connect_flag = false
      for i, offset in ipairs(neighbour_offsets) do
        local neighbour_grid_x = grid_info.col + neighbour_x_offsets[i]
        local neighbour_grid_y = grid_info.row + neighbour_y_offsets[i]
        if neighbour_grid_x > 0 and neighbour_grid_x <= col and neighbour_grid_y > 0 and neighbour_grid_y <= row then
          local neighbour_grid_index = grid_index + offset
          local neighbour_grid_info = grids[neighbour_grid_index]
          if neighbour_grid_info.ui_state == GridUIState.SHOW then
            connect_flag = true
            break
          end
        end
      end
      grid_info.ui_state = connect_flag and GridUIState.HIDE or GridUIState.HIDEFORBID
    end
  end
  local items = self.v_static_sv_grid:get_items()
  if #items ~= #grids then
    self.v_static_sv_grid:update_list(grids)
  else
    for index, item in ipairs(items) do
      item:set_data(grids[index])
    end
  end
end

function ui:select_grid(grid_index)
  if self.select_grid_index then
    local pre_grid = self.v_static_sv_grid:get_item_by_idx(self.select_grid_index)
    pre_grid:deselect()
  end
  if not grid_index then
    self.select_grid_index = nil
    self.v_uiobjects.NoInfo:SetActiveEx(true)
    self.v_uiobjects.InfoContent:SetActiveEx(false)
    return
  end
  local grid = self.v_static_sv_grid:get_item_by_idx(grid_index)
  grid:select()
  self.select_grid_index = grid_index
  local grids = MineSweeperMgr:get_minesweeper_grid_list()
  local grid_id = grids[grid_index].grid_id
  local grid_cfg = ShareRes.get_minesweeper_grid_cfg(grid_id)
  if grid_cfg and grid_cfg.Desc then
    self.v_uiobjects.NoInfo:SetActiveEx(false)
    self.v_uiobjects.InfoContent:SetActiveEx(true)
    self.v_uicompents.NodeName_txt.text = grid_cfg.Name
    self.v_uicompents.ScoreAddNum_txt.text = grid_cfg.Score
    self.v_uicompents.NodeBtnText_txt.text = grid_cfg.ButtonText
    self.v_uicompents.NodeDesc1_txt.text = grid_cfg.Desc
  end
end

function ui:flip_grid(grid_index)
  MineSweeperMgr:request_flip_grid(grid_index)
  local grid_instance = self.v_static_sv_grid:get_item_by_idx(grid_index)
  grid_instance:play_flip_vfx()
  self:refresh_grid()
end

function ui:on_click_grid(grid_index)
  local grids = MineSweeperMgr:get_minesweeper_grid_list()
  local grid_info = grids[grid_index]
  if grid_info.state == GridState.NOTSHOW then
    self:flip_grid(grid_index)
  elseif grid_info.state == GridState.SHOW then
    local grid_type = grid_info.grid_type
    if grid_type == GridType.MONSTER or grid_type == GridType.BOSS then
      self:select_grid(grid_index)
    elseif grid_type == GridType.ITEM then
      local grid_cfg = ShareRes.get_minesweeper_grid_cfg(grid_info.grid_id)
      local item_type = grid_cfg.Args[1]
      if item_type == MineSweeperMgr.ITEM_TYPE.HEALTH then
        local blood_count = MineSweeperMgr:get_minesweeper_chapter_info().blood_count
        if blood_count == minesweeper_misc.StaminaLimit then
          Util.show_message_tip(2810)
        else
          MineSweeperMgr:use_grid(grid_index)
        end
      else
        MineSweeperMgr:use_grid(grid_index)
      end
    elseif grid_type == GridType.BLESS then
      UIMgr:get_ui("ui_minesweeper_buff"):ui_show(MineSweeperBuffUI.Type.Item, grid_index)
    elseif grid_type == GridType.SHOP then
      UIMgr:get_ui("ui_minesweeper_shop"):ui_show(grid_index)
    elseif grid_type == GridType.EXIT then
      if MineSweeperMgr.exit_grid_unlocked then
        self:select_grid(grid_index)
      else
        Util.show_message_tip(2807)
      end
    end
  elseif grid_info.state == GridState.SHOWANDUSE then
    local grid_type = grid_info.grid_type
    if grid_type == GridType.EXIT then
      self:select_grid(grid_index)
    end
  end
end

function ui:enable_tips(enabled)
  self.v_uiobjects.Tips:SetActiveEx(enabled)
end

function ui:ending_vfx()
  self.v_safearea_canvas_group.blocksRaycasts = false
  local item_grididx_list = {}
  self.v_timer_handles = {}
  local interval = 0.2
  local hide_grid_count = 0
  local grid_instance_list = self.v_static_sv_grid:get_items()
  for i = row, 1, -1 do
    local start_offset = (i - 1) * col
    for j = 1, col do
      local index = start_offset + j
      local grid_instance = grid_instance_list[index]
      local grid_info = grid_instance:get_data()
      if grid_info.state == GridState.NOTSHOW then
        hide_grid_count = hide_grid_count + 1
        local timer_handle = Timer:add_timer(nil, hide_grid_count * interval, function()
          grid_instance:play_flip_vfx()
          grid_info.state = GridState.SHOW
          grid_info.ui_state = GridUIState.SHOW
          grid_instance:set_data(grid_info)
        end)
        _insert(self.v_timer_handles, timer_handle)
      end
      if grid_info.grid_type == GridType.ITEM then
        _insert(item_grididx_list, index)
      end
    end
  end
  local time_offset = hide_grid_count * interval + 0
  local grids = MineSweeperMgr:get_minesweeper_grid_list()
  for index, grid_index in ipairs(item_grididx_list) do
    local grid_info = grids[grid_index]
    local timer_handle = Timer:add_timer(nil, time_offset + index * interval, function()
      local grid_instance = grid_instance_list[grid_index]
      grid_instance:play_out_vfx()
      grid_info.state = GridState.SHOWANDUSE
      grid_info.ui_state = GridUIState.SHOW
      local grid_cfg = ShareRes.get_minesweeper_grid_cfg(grid_info.grid_id)
      local args = grid_cfg.Args
      local vfx_fun = self.v_item_function_table[args[1]]
      vfx_fun(args)
      grid_instance:set_data(grid_info)
    end)
    _insert(self.v_timer_handles, timer_handle)
  end
  local item_grid_count = #item_grididx_list
  time_offset = time_offset + item_grid_count * interval + 0.2
  local timer_handle = Timer:add_timer(nil, time_offset, function()
    self.v_safearea_canvas_group.blocksRaycasts = true
    self:register_event()
    self:refresh()
  end)
  _insert(self.v_timer_handles, timer_handle)
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_UPDATE_MINESWEEPER_INFO, self.on_update_minesweeper_info, self)
  self:bind_auto_mq(Const.MSG_ON_UPDATE_MINESWEEPER_GRID_INFO, self.on_update_minesweeper_grid_info, self)
  self:bind_auto_mq(Const.MSG_ON_MINESWEEPER_RESET_FLOOR, self.on_reset_floor, self)
end

function ui:lock_all_grid()
  local grid_instance_list = self.v_static_sv_grid:get_items()
  for _, grid_instance in ipairs(grid_instance_list) do
    grid_instance:lock()
  end
end

function ui:unlock_all_grid()
  local grid_instance_list = self.v_static_sv_grid:get_items()
  for _, grid_instance in ipairs(grid_instance_list) do
    grid_instance:unlock()
  end
end

function ui:play_refresh_vfx()
  self.v_uicompents.Ani_UIMineBattle_Refresh_Out_pd:Play()
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.minesweeper_grid_refresh_SOUND)
end

function ui:on_update_minesweeper_info()
  if 0 ~= MineSweeperMgr:get_minesweeper_chapter_info().floor_idx then
    self:refresh()
  end
end

function ui:on_update_minesweeper_grid_info(msg)
  local grids = msg.mm_x
  local grid_instance_list = self.v_static_sv_grid:get_items()
  for _, grid_info in ipairs(grids) do
    local grid_type = ShareRes.get_minesweeper_grid_type(grid_info.grid_id)
    if grid_type ~= GridType.EXIT then
      local grid_index = grid_info.index
      local grid_instance = grid_instance_list[grid_index]
      grid_instance:play_out_vfx()
    end
  end
  self:refresh_grid()
end

function ui:on_reset_floor()
  self:select_grid()
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(MineSweeperMgr.activity_id, self.v_ui_name, nil, true)
end

return ui
