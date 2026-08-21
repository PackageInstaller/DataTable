local Base = require("gamelogic.tower_mgr.tower")
local M = Util.create_child_mt(Base)

function M:_init(...)
  Base._init(self, ...)
  self.last_floor_award_list = {}
end

function M:on_exit()
  Base.on_exit(self)
  UIMgr:try_hide_ui("gecao_battle")
  self.last_floor_award_list = {}
  UIMgr:try_destory_ui("battle_drop_tips")
end

function M:cut_grass_entry_choose_award()
  TowerMgr:entry_choose_award_new(true)
end

function M:on_all_item_picked()
  if self:get_tower_pass() then
    self:check_pass_all_room()
  end
end

function M:is_pass_tower_animation()
  local all_drop_geted = SceneMgr:get_scene_item_mgr():is_all_drop_geted()
  if all_drop_geted and self:get_tower_pass() then
    return true
  end
  return false
end

function M:enter_next_floor()
  self.last_floor_award_list = TowerMgr:get_tower_progress().award_list
  MsgGame:mq_publish2(Const.MSG_ON_ENTER_NEW_FLOOR)
  local hero_list = SceneMgr:get_hero_list()
  local wait_hero_list = {}
  local tower = TowerMgr:get_tower()
  for uuid, hero in pairs(hero_list) do
    if uuid ~= Global.hero_uuid then
      table.insert(wait_hero_list, hero)
    end
  end
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_FLOOR_FINISHED, Global.hero, wait_hero_list[1], wait_hero_list[2], self.v_floor_num)
end

function M:_do_after_play_screen_black_out()
  if DebugSetting and not DebugSetting:is_enter_chapter() then
    local function cb()
      Global.scene_mgr:on_enter_main_scene()
      
      UIMgr:revert_cache_ui()
    end
    
    if TowerMgr then
      TowerMgr:on_exit_tower(cb)
    end
    return
  end
  local fight_info = TowerMgr:get_fight_info()
  if fight_info then
    self:cut_grass_entry_choose_award()
  end
  if Global.state_sound_mgr and self.v_is_play_end_anim then
    Global.state_sound_mgr:trigger_fight_state_by_id(Config.FIGHT_STATE.TOWER_WIN)
  end
end

function M:on_role_die_anima_end(npc_uuid)
  if not TowerMgr then
    return
  end
  self.v_die_npc = self.v_die_npc or {}
  self.v_die_npc[npc_uuid] = true
  local formation_num = UtilTable.hash_lenth(SceneMgr:get_hero_list())
  local die_num = 0
  for key, value in pairs(self.v_die_npc) do
    die_num = die_num + 1
  end
  if formation_num <= die_num then
    if DebugSetting and not DebugSetting:is_enter_chapter() then
      local function cb()
        Global.scene_mgr:on_enter_main_scene()
      end
      
      TowerMgr:on_exit_tower(cb)
      return
    end
    if self:is_skip_open_card() then
      local tower_progress = TowerMgr:get_tower_progress()
      local fight_info = TowerMgr:get_fight_info()
      TowerMgr:request_entry_choose_award(function(choose_reward_list)
        TowerMgr:get_fight_reward(nil, false, function()
          UIMgr:get_ui("gecao_settle"):ui_show(tower_progress, fight_info, choose_reward_list, true)
        end)
      end)
    else
      self:cut_grass_entry_choose_award()
    end
    self.v_is_all_die = true
  end
end

function M:is_skip_open_card()
  local award_list = TowerMgr:get_tower_progress().award_list
  local count = award_list and UtilTable.hash_lenth(award_list) or 0
  return 0 == count
end

function M:set_continue_fight_time(fight_time)
  Base.set_continue_fight_time(self, fight_time)
  self.last_floor_award_list = TowerMgr:get_tower_progress().award_list
  if fight_time and fight_time > 0 then
    local ui = UIMgr:try_get_visible_ui("gecao_battle")
    if not ui then
      UIMgr:get_ui("gecao_battle"):ui_show(nil, fight_time, true)
    end
  end
end

function M:on_scene_logic_finish()
  if self.v_floor_num == self:get_max_floor() and self:is_pass_room() then
    self:check_pass_all_room()
  end
end

function M:register_event()
  Base.register_event(self)
  Util.bind_msg(self, Const.MSG_SCENE_LOGIC_FINISH, self.on_scene_logic_finish, self)
end

function M:get_last_floor_award_list()
  return self.last_floor_award_list
end

return M
