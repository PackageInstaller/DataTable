local M = Util.create_class()

function M:_init()
  set_ui_object_visible("fight", "Btn_skillTower", false)
  self.stage_skill_id = 300106101
end

function M:on_input(input_id)
  if 60 == input_id and get_npc_cd_charge(self.npc, self.stage_skill_id) >= get_skill_cfg(self.stage_skill_id).CdChargePerCost then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.stage_skill_id)
  else
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and 300106101 == skill_id then
    set_sync_var("NPC_on", true)
    if get_cur_room_id() == 3050101 then
      play_simple_timeline("3050101", true)
    end
    if get_cur_room_id() == 3050102 then
      play_simple_timeline("3050102", true)
    end
    if get_cur_room_id() == 3050201 then
      play_simple_timeline("3050201", true)
      print("调用一下")
    end
    if get_cur_room_id() == 3050301 then
      play_simple_timeline("305311", true)
    end
    if get_cur_room_id() == 3050302 then
      play_simple_timeline("305322", true)
    end
    if get_cur_room_id() == 3050303 then
      play_simple_timeline("305333", true)
    end
    if get_cur_room_id() == 3050304 then
      play_simple_timeline("305344", true)
    end
    if get_cur_room_id() == 3050306 then
      play_simple_timeline("30535", true)
    end
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  if npc == self.npc and false == is_break then
    if 300106101 == skill_id then
      set_sync_var("NPC_off", true)
    end
    if get_cur_room_id() == 3050101 then
      play_simple_timeline("3050101", false)
      stop_timeline("3050101")
    end
    if get_cur_room_id() == 3050102 then
      play_simple_timeline("3050102", false)
      stop_timeline("3050102")
    end
    if get_cur_room_id() == 3050201 then
      play_simple_timeline("3050201", false)
      stop_timeline("3050201")
    end
    if get_cur_room_id() == 3050301 then
      play_simple_timeline("305311", false)
      stop_timeline("305311")
    end
    if get_cur_room_id() == 3050302 then
      play_simple_timeline("305322", false)
      stop_timeline("305322")
    end
    if get_cur_room_id() == 3050303 then
      play_simple_timeline("305333", false)
      stop_timeline("305333")
    end
    if get_cur_room_id() == 3050304 then
      play_simple_timeline("305344", false)
      stop_timeline("305344")
    end
    if get_cur_room_id() == 3050306 then
      play_simple_timeline("30535", false)
      stop_timeline("30535")
    end
  end
end

return M
