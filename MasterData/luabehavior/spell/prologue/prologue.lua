local M = Util.create_class()

function M:_init(npc)
  self.God = get_god_npc()
  set_sound_reverb_state(true)
  if get_cur_room_id() == 1001 then
    self.ling = get_come_on_hero()
    listen_attr_change_mq(self.ling, 74, self.skill2ready, self)
  end
  if get_cur_room_id() == 1006 then
  end
  if get_cur_room_id() == 1003 then
  end
end

function M:on_input(input_id)
  if get_sync_var("step1") and 15 == input_id and check_magic(self.npc, 100010101) then
    stop_ui_fight_button_effect({
      "Skill_Guid1",
      1
    })
  end
  if get_sync_var("step2") and 20 == input_id and check_magic(self.npc, 100010104) then
    stop_ui_fight_button_effect({
      "Skill_Guid5",
      5
    })
    cast_magic(self.npc, self.npc, 100010101, 0)
  end
end

function M:skill2ready(npc, attr_tpe, change_value)
  if get_sync_var("step2") and 100 == get_npc_attr(self.ling, 74) then
    cast_magic(self.God, self.God, 100010104, 0)
  end
end

function M:on_story_begin(story_id, step_id, param)
  if 1000001 == story_id and 95 == step_id then
    set_sceneobj_visible_save_state("scene_timeline1", true, false)
  end
  if 1000003 == story_id then
    unlisten_attr_change_mq(self.ling, 74, self)
  end
end

function M:on_story_finish(story_id)
  if 1000001 == story_id then
    play_video("prologue1.mp4", true, 1, 1, "Sound_prologue1")
    stop_play_bgm(0)
  end
  if 1000002 == story_id then
    stop_timeline("timeline_black")
    play_timeline("timeline0_1up", 0, 3, nil, true, true, true)
    set_sync_var("play", true)
    set_sceneobj_visible_save_state("/Root/LevelObj/scene_timeline0_0", true, false)
  end
  if 1000007 == story_id then
  end
  if 1000008 == story_id then
    stop_timeline("timeline0_3bangongshi")
    play_timeline("timeline0_3bangongshi2", 0, 100000, nil, false, true, true)
  end
  if 1000010 == story_id then
    set_sync_var("boss", true)
  end
  if 4000102 == story_id then
    self.play_video_prologue1 = get_npc_time(self.npc) + 0.5
  end
end

function M:on_video_play_end()
  if get_cur_room_id() == 1001 then
    play_timeline("timeline0_1up", 0, 1.5, nil, true, true, true)
    set_sync_var("play", true)
    set_sceneobj_visible_save_state("/Root/LevelObj/scene_timeline0_0", true, false)
    start_play_bgm(1)
  end
end

function M:on_timeline_end(timeline_name)
  if "timeline0_1up" == timeline_name then
    self.timeline_timer = nil
  end
  if "timeline0_2_drop" == timeline_name then
    local h = get_come_on_hero()
    char_visible(false)
    cast_skill(h, h, 100101591, nil, nil)
    self.UItimer = get_npc_time(self.npc) + 0
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  if 100101591 == skill_id then
    set_ui_object_visible("fight", "Main", true)
  end
end

function M:on_frame()
  if self.timeline_timer and get_npc_time(self.npc) > self.timeline_timer then
    self.timeline_timer = nil
    set_sceneobj_visible_save_state("scene_timeline2", true, false)
  end
  if self.timeline_timer1 and get_npc_time(self.npc) > self.timeline_timer1 then
    self.timeline_timer1 = nil
    play_timeline("timeline0_2down", 0, 3, nil, false, true, true)
    self.tp_timer1 = get_npc_time(self.npc) + 6.8
  end
  if self.tp_timer1 and get_npc_time(self.npc) > self.tp_timer1 then
    self.tp_timer1 = nil
  end
  if self.tp_timer1 and get_npc_time(self.npc) > self.tp_timer1 then
    self.tp_timer1 = nil
  end
  if self.bangongshi and get_npc_time(self.npc) > self.bangongshi then
    self.bangongshi = nil
    start_stroy(1000008)
  end
  if self.UItimer and get_npc_time(self.npc) > self.UItimer then
    self.UItimer = nil
  end
  if self.TeamSkill_Guid1 and get_npc_time(self.npc) > self.TeamSkill_Guid1 then
    self.TeamSkill_Guid1 = nil
    set_ui_object_visible("fight", "TeamSkill_Guid1", false)
  end
  if self.play_video_prologue1 and get_npc_time(self.npc) > self.play_video_prologue1 then
    self.play_video_prologue1 = nil
    play_video("prologue1.mp4", true, 1, 1, "Sound_prologue1")
  end
end

function M:on_npc_group_clear(group_id)
end

function M:on_hero_showup_or_back(npc, is_showup)
  set_ui_object_visible("fight", "TeamSkill_Guid1", false)
  self.TeamSkill_Guid1 = get_npc_time(self.npc) + 3
end

return M
