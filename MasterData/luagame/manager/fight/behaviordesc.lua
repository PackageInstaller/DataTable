local M = {
  cast_skill = {
    [2] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true
  },
  lookat_npc = {
    [3] = true
  },
  remove_missile = {
    [2] = true
  },
  set_search_npc_limit = {
    [1] = true,
    [2] = true,
    [3] = true
  },
  search_npc = {
    [4] = 0,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true
  },
  cast_missile = {
    [2] = true,
    [3] = true,
    [4] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true
  },
  cast_missile_new = {
    [2] = true,
    [3] = true,
    [4] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true
  },
  cast_missile3 = {
    [2] = true,
    [3] = true,
    [4] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true
  },
  set_cam_default_angles = {
    [4] = true
  },
  switch_fight_bgm = {
    [3] = true
  },
  back_to_scene_camera = {
    [1] = true
  },
  set_strength_visible = {
    [1] = true
  },
  set_scene_tips = {
    [3] = true
  },
  set_aimed_move_state = {
    [1] = true
  },
  set_camera_click_swip_state = {
    [1] = true
  },
  set_camera = {
    [3] = true,
    [4] = true
  },
  set_npc_dead = {
    [2] = true,
    [4] = true
  },
  get_npc_offset_position = {
    [2] = true
  },
  set_indicator_active = {
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true
  },
  set_npc_target = {
    [2] = true
  },
  abort_skill = {
    [2] = true
  },
  rebound_missile = {
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true
  },
  get_target_angel = {
    [1] = true,
    [2] = true,
    [3] = true
  },
  focus_npc = {
    [1] = true,
    [2] = true
  },
  check_magic = {
    [1] = true
  },
  show_hero_by_keycode = {
    [2] = true
  },
  is_pass_room = {
    [1] = true
  },
  create_scene_effect = {
    [4] = true,
    [5] = true,
    [6] = true
  },
  abort_magic_by_id = {
    [3] = true
  },
  is_cast_skill_time = {
    [2] = true,
    [3] = true
  },
  get_magic_num = {
    [3] = true
  },
  get_npc_pos = {
    [2] = true
  },
  add_npc = {
    [7] = true
  },
  add_npc2 = {
    [9] = true
  },
  add_npc_by_pos_key = {
    [11] = true
  },
  get_active_char_element = {
    [1] = true
  },
  get_npc_distance = {
    [3] = true,
    [4] = true,
    [5] = true
  },
  set_hud_config = {
    [5] = true
  },
  active_hud = {
    [3] = true,
    [5] = true
  },
  change_follow_target = {
    [2] = true,
    [3] = true
  },
  change_follow_target_new = {
    [2] = true,
    [3] = true
  },
  listen_missile_begin_pos = {
    [5] = true
  },
  unlisten_missile_begin_pos = {
    [3] = true
  },
  listen_missile_end_pos = {
    [5] = true
  },
  unlisten_missile_end_pos = {
    [3] = true
  },
  check_play_born_sound = {
    [1] = true
  },
  listen_missile_evt = {
    [6] = true
  },
  unlisten_missile_evt = {
    [4] = true
  },
  play_timeline = {
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true
  },
  play_video = {
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true
  },
  init_special_fight_ui = {
    [2] = true,
    [3] = true
  },
  remove_missile_by_id = {
    [2] = true,
    [3] = true
  },
  listen_magic_begin = {
    [5] = true
  },
  unlisten_magic_begin = {
    [3] = true
  },
  listen_magic_end = {
    [5] = true
  },
  unlisten_magic_end = {
    [3] = true
  },
  set_btn_charging_type = {
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true
  },
  cast_magic = {
    [4] = true,
    [5] = true
  },
  npc_is_destroy = {
    [1] = true
  },
  change_npc_prefab = {
    [3] = true,
    [4] = true
  },
  get_unit_physical_button_cfg = {
    [1] = true,
    [2] = true
  },
  get_unit_logic_button_cfg = {
    [1] = true,
    [2] = true
  },
  get_unit_skill_action_cfg = {
    [1] = true,
    [2] = true
  },
  search_joystick_npc = {
    [5] = true
  },
  get_ui_obj_list = {
    [1] = true
  },
  flash_to_pos = {
    [4] = true,
    [5] = true,
    [6] = true
  },
  get_develop_level = {
    [3] = true
  },
  set_sceneobj_visible_save_state = {
    [3] = true
  },
  set_move_offsets_multi_map = {
    [2] = true
  },
  set_ui_object_visible = {
    [4] = true
  },
  get_npc_to_camera_offset_position = {
    [3] = true
  },
  get_nearest_walkable_pos = {
    [4] = true,
    [5] = true
  },
  listen_button_mq = {
    [5] = true
  },
  unlisten_button_mq = {
    [3] = true
  },
  change_hero_state = {
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true
  },
  log_on_npc = {
    [2] = true,
    [3] = true
  },
  set_all_npc_hp_visible = {
    [1] = true,
    [2] = true
  },
  set_npc_pretend_visible = {
    [5] = true,
    [3] = true,
    [4] = true
  },
  set_timer_pause = {
    [2] = true
  },
  add_sub_magic = {
    [3] = true
  },
  add_missile_atk_cd = {
    [3] = true
  },
  set_ban_skill_to_move = {
    [2] = true
  },
  set_skill_target = {
    [3] = true,
    [4] = true
  },
  get_part_npc = {
    [2] = true
  },
  set_effect_pos_control_bind = {
    [2] = true
  },
  check_element_ab_state = {
    [2] = true
  }
}
return M
