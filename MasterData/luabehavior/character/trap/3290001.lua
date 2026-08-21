local M = Util.create_class()
local CommonRole = import("common.role")
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local hold = false
local CD = 0

function M:_init()
  self.faster = 329000101
  if get_cur_room_id() == 329031 then
  end
end

function M:on_input(input_id)
  if 60 == input_id then
    hold = true
    print(hold)
  end
end

function M:on_touch_up(output_id, iscancel)
  if 60 == output_id and not iscancel then
    hold = false
    print(hold)
  end
end

function M:on_frame()
  if check_npc_status(get_come_on_hero(), 9) == false or false == hold then
    abort_magic_by_id(get_come_on_hero(), 3290301)
    abort_magic_by_id(get_come_on_hero(), 3290303)
  end
  if check_npc_status(get_come_on_hero(), 2) then
    hold = false
    play_ui_fight_button_effect({"Skill_Guid", 8})
  end
  if check_npc_status(get_come_on_hero(), 9) == true and true == hold then
    if 0 == get_magic_num(get_come_on_hero(), 3290303) then
      cast_magic(self.npc, get_come_on_hero(), 3290303, 1)
    end
    if get_npc_time(self.npc) > CD then
      cast_magic(self.npc, get_come_on_hero(), 3290301, 1)
    end
  end
end

function M:on_self_magic_end(target, magic_id, magic_kind, magic_type, is_break)
  if target == get_come_on_hero() and 3290303 == magic_id then
    stop_ui_fight_button_effect({"FightSkill", 8})
  end
end

function M:on_self_magic_begin(target, magic_id, magic_kind, magic_type, is_break)
  if target == get_come_on_hero() and 3290303 == magic_id then
    play_ui_fight_button_effect({"FightSkill", 8})
    stop_ui_fight_button_effect({"Skill_Guid", 8})
    CD = get_npc_time(self.npc) + 0.1
  end
  if target == get_come_on_hero() and 3290301 == magic_id then
    CD = get_npc_time(self.npc) + 0.1
  end
end

return M
