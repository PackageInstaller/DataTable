local M = Util.create_class()

function M:_init()
  self.skill04 = {
    300102604,
    0,
    0,
    0,
    0,
    get_skill_cfg(300102604).CastTime,
    get_skill_cfg(300102604).AfterTime
  }
  self.skill03 = {
    300102603,
    0,
    0,
    0,
    0,
    get_skill_cfg(300102603).CastTime,
    get_skill_cfg(300102603).AfterTime
  }
  self.skill02 = {
    300102602,
    0,
    0,
    0,
    0,
    get_skill_cfg(300102602).CastTime,
    get_skill_cfg(300102602).AfterTime
  }
  self.skill01 = {
    300102601,
    0,
    0,
    0,
    0,
    get_skill_cfg(300102601).CastTime,
    get_skill_cfg(300102601).AfterTime
  }
  self.control = 0
  self.ball_nums = nil
  self.missile_list = {}
  self.local_timer = 0
end

function M:on_start()
  listen_missile_begin_pos(self.npc, 30010260101, self.preload_missile_note, self)
  listen_missile_begin_pos(self.npc, 30010260102, self.preload_missile_note, self)
  listen_missile_begin_pos(self.npc, 30010260103, self.preload_missile_note, self)
end

function M:on_remove()
  unlisten_missile_begin_pos(self.npc, 30010260101, self)
  unlisten_missile_begin_pos(self.npc, 30010260102, self)
  unlisten_missile_begin_pos(self.npc, 30010260103, self)
end

function M:preload_missile_note(owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= self.npc then
    return
  end
  if not self.missile_list[1] then
    self.missile_list[1] = missile
  elseif not self.missile_list[2] then
    self.missile_list[2] = missile
  elseif not self.missile_list[3] then
    self.missile_list[3] = missile
  end
end

function M:on_frame()
  if not is_in_challenge() and is_pass_room() then
    abort_skill(self.npc)
    self.control = 9
  end
  local now_time = get_npc_time(self.npc)
  if 0 == self.control then
    cast_skill(self.npc, nil, self.skill01[1])
    self.control = 1
    self.ball_nums = 1
  end
  if 1 == self.control then
    local target_list = search_npc(self.npc, 4, 8, nil, 3, true)
    local ball_skill_list = {
      [1] = self.skill02[1],
      [2] = self.skill03[1],
      [3] = self.skill04[1]
    }
    for _, v in pairs(target_list) do
      if check_npc_distance(self.npc, v, 8, true) and self.ball_nums < 4 then
        abort_skill(self.npc, true)
        remove_missile(self.missile_list[self.ball_nums])
        lookat_npc(self.npc, v, 1)
        cast_skill(self.npc, v, ball_skill_list[self.ball_nums])
        self.ball_nums = self.ball_nums + 1
      end
    end
    if 4 == self.ball_nums then
      self.control = 2
      self.local_timer = now_time + 3
    end
  end
  if 2 == self.control and now_time >= self.local_timer then
    self.control = 0
  end
end

return M
