local M = Util.create_class()

function M:_init(npc)
  set_npc_floating_text_hud_visible(npc, false)
  self.width = math.floor(get_sync_var("width"))
  self.length = math.floor(get_sync_var("length"))
  self.gap_time = get_sync_var("gap_time")
  self.path = get_sync_var("path")
  self.timeline_name = get_sync_var("timeline_name")
  self.animation_name = get_sync_var("animation_name")
  self.plat_prefix = get_sync_var("plat_prefix")
  self.control = 1
  self.max_control = get_sync_var("max_phase")
  self.phase_time_list = {}
  for i = 1, self.max_control do
    self.phase_time_list[i] = get_sync_var("time_phase" .. tostring(i))
  end
  self.phase_max_plat_num_list = {}
  for j = 1, self.max_control do
    self.phase_max_plat_num_list[j] = get_sync_var("max_plat_num_phase" .. tostring(j))
  end
  self.start_plat_num = get_sync_var("start_plat_num")
  self.current_plat_num = self.start_plat_num
  self.loop_order_list = {}
  self.loop_count = 1
  self.loop_difficulty = get_sync_var("loop_difficulty")
  self.cross_order_list = {}
  self.cross_count = 1
  self.max_cross_count = 0
  self.cross_difficulty = get_sync_var("cross_difficulty")
  self.over = false
  self.last_down = get_npc_time(npc)
  self.current_phase_start = get_npc_time(npc)
end

function M:on_frame()
  if self.over then
    return
  end
  self:phase_check()
  if self.control > self.max_control then
    self.control = -1
    self.over = true
    return
  end
  self:skill_main_logic()
end

function M:random_plat_down(plat_num)
  math.randomseed(os.time())
  for index = 1, plat_num do
    local w = math.random(self.width)
    local l = math.random(self.length)
    set_scene_timeline_speed(self.path .. "/CrisisPlat" .. tostring(w) .. "-" .. tostring(l) .. "/" .. self.timeline_name, 1)
    set_scene_plat_speed(self.plat_prefix .. tostring(w) .. "-" .. tostring(l), 1, self.animation_name, true)
  end
end

function M:straight_line_plat_down(start_x, start_y, width, length, order_list, direction)
  local x = math.floor(start_x)
  local y = math.floor(start_y)
  if "right" == direction then
    for index1 = 1, width do
      table.insert(order_list, {x, y})
      if index1 ~= width then
        y = y + 1
      end
    end
  elseif "left" == direction then
    for index2 = 1, width do
      table.insert(order_list, {x, y})
      if index2 ~= width then
        y = y - 1
      end
    end
  elseif "up" == direction then
    for index3 = 1, length do
      table.insert(order_list, {x, y})
      if index3 ~= length then
        x = x - 1
      end
    end
  elseif "down" == direction then
    for index4 = 1, length do
      table.insert(order_list, {x, y})
      if index4 ~= length then
        x = x + 1
      end
    end
  end
  return x, y, order_list
end

function M:loop_plat_down()
  local order_list = {}
  local w = self.width
  local l = self.length
  math.randomseed(os.time())
  local start_corner = math.random(4)
  if 1 == start_corner then
    local x = 1
    local y = 1
    local start_direction = math.random(2)
    if 1 == start_direction then
      ::lbl_25::
      x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "right")
      l = l - 1
      if 0 ~= l then
        x = x + 1
        x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "down")
        w = w - 1
        if 0 ~= w then
          y = y - 1
          x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "left")
          l = l - 1
          if 0 ~= l then
            x = x - 1
            x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "up")
            w = w - 1
            if 0 ~= w then
              y = y + 1
              goto lbl_25
            end
          end
        end
      end
    else
      ::lbl_95::
      x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "down")
      w = w - 1
      if 0 ~= w then
        y = y + 1
        x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "right")
        l = l - 1
        if 0 ~= l then
          x = x - 1
          x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "up")
          w = w - 1
          if 0 ~= w then
            y = y - 1
            x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "left")
            l = l - 1
            if 0 ~= l then
              x = x + 1
              goto lbl_95
            end
          end
        end
      end
    end
  elseif 2 == start_corner then
    local x = 1
    local y = l
    local start_direction = math.random(2)
    if 1 == start_direction then
      ::lbl_175::
      x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "left")
      l = l - 1
      if 0 ~= l then
        x = x + 1
        x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "down")
        w = w - 1
        if 0 ~= w then
          y = y + 1
          x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "right")
          l = l - 1
          if 0 ~= l then
            x = x - 1
            x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "up")
            w = w - 1
            if 0 ~= w then
              y = y - 1
              goto lbl_175
            end
          end
        end
      end
    else
      ::lbl_245::
      x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "down")
      w = w - 1
      if 0 ~= w then
        y = y - 1
        x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "left")
        l = l - 1
        if 0 ~= l then
          x = x - 1
          x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "up")
          w = w - 1
          if 0 ~= w then
            y = y + 1
            x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "right")
            l = l - 1
            if 0 ~= l then
              x = x + 1
              goto lbl_245
            end
          end
        end
      end
    end
  elseif 3 == start_corner then
    local x = w
    local y = l
    local start_direction = math.random(2)
    if 1 == start_direction then
      ::lbl_325::
      x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "left")
      l = l - 1
      if 0 ~= l then
        x = x - 1
        x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "up")
        w = w - 1
        if 0 ~= w then
          y = y + 1
          x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "right")
          l = l - 1
          if 0 ~= l then
            x = x + 1
            x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "down")
            w = w - 1
            if 0 ~= w then
              y = y - 1
              goto lbl_325
            end
          end
        end
      end
    else
      ::lbl_395::
      x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "up")
      w = w - 1
      if 0 ~= w then
        y = y - 1
        x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "left")
        l = l - 1
        if 0 ~= l then
          x = x + 1
          x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "down")
          w = w - 1
          if 0 ~= w then
            y = y + 1
            x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "right")
            l = l - 1
            if 0 ~= l then
              x = x - 1
              goto lbl_395
            end
          end
        end
      end
    end
  else
    local x = w
    local y = 1
    local start_direction = math.random(2)
    if 1 == start_direction then
      ::lbl_473::
      x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "right")
      l = l - 1
      if 0 ~= l then
        x = x - 1
        x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "up")
        w = w - 1
        if 0 ~= w then
          y = y - 1
          x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "left")
          l = l - 1
          if 0 ~= l then
            x = x + 1
            x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "down")
            w = w - 1
            if 0 ~= w then
              y = y + 1
              goto lbl_473
            end
          end
        end
      end
    else
      while true do
        x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "up")
        w = w - 1
        if 0 == w then
          break
        end
        y = y + 1
        x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "right")
        l = l - 1
        if 0 == l then
          break
        end
        x = x + 1
        x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "down")
        w = w - 1
        if 0 == w then
          break
        end
        y = y - 1
        x, y, order_list = self:straight_line_plat_down(x, y, w, l, order_list, "left")
        l = l - 1
        if 0 == l then
          break
        end
        x = x - 1
      end
    end
  end
  return order_list
end

function M:corss_line_plat_down()
  local order_list = {}
  local w = self.width
  local l = self.length
  math.randomseed(os.time())
  local start_direction = math.random(2)
  if 1 == start_direction then
    self.max_cross_count = self.width
    local odd_even = math.random(2)
    if 1 == odd_even then
      for index1 = 1, l do
        local temp_list = {}
        if 0 == index1 % 2 then
          local x = index1
          local y = 1
          _, _, temp_list = self:straight_line_plat_down(x, y, w, l, temp_list, "right")
        else
          local x = index1
          local y = w
          _, _, temp_list = self:straight_line_plat_down(x, y, w, l, temp_list, "left")
        end
        table.insert(order_list, temp_list)
      end
    else
      for index1 = 1, l do
        local temp_list = {}
        if 0 == index1 % 2 then
          local x = index1
          local y = w
          _, _, temp_list = self:straight_line_plat_down(x, y, w, l, temp_list, "left")
        else
          local x = index1
          local y = 1
          _, _, temp_list = self:straight_line_plat_down(x, y, w, l, temp_list, "right")
        end
        table.insert(order_list, temp_list)
      end
    end
  else
    self.max_cross_count = self.length
    local odd_even = math.random(2)
    if 1 == odd_even then
      for index2 = 1, w do
        local temp_list = {}
        if 0 == index2 % 2 then
          local x = 1
          local y = index2
          _, _, temp_list = self:straight_line_plat_down(x, y, w, l, temp_list, "down")
        else
          local x = l
          local y = index2
          _, _, temp_list = self:straight_line_plat_down(x, y, w, l, temp_list, "up")
        end
        table.insert(order_list, temp_list)
      end
    else
      for index2 = 1, w do
        local temp_list = {}
        if 0 == index2 % 2 then
          local x = l
          local y = index2
          _, _, temp_list = self:straight_line_plat_down(x, y, w, l, temp_list, "up")
        else
          local x = 1
          local y = index2
          _, _, temp_list = self:straight_line_plat_down(x, y, w, l, temp_list, "down")
        end
        table.insert(order_list, temp_list)
      end
    end
  end
  return order_list
end

function M:phase_check()
  if -1 == self.phase_time_list[self.control] then
    if get_sync_var("phase_change") then
      self.control = self.control + 1
      self.current_phase_start = get_npc_time(self.npc)
      set_sync_var("phase_change", false)
    end
  elseif get_npc_time(self.npc) >= self.current_phase_start + self.phase_time_list[self.control] then
    self.control = self.control + 1
    self.current_phase_start = get_npc_time(self.npc)
  end
end

function M:skill_main_logic()
  if self.phase_max_plat_num_list[self.control] > 0 then
    if get_npc_time(self.npc) >= self.last_down + self.gap_time then
      self.last_down = get_npc_time(self.npc)
      self:random_plat_down(self.current_plat_num)
      if self.current_plat_num < self.phase_max_plat_num_list[self.control] then
        self.current_plat_num = self.current_plat_num + 1
      end
    end
  elseif -1 == self.phase_max_plat_num_list[self.control] then
    if 0 == #self.loop_order_list then
      self.loop_order_list = self:loop_plat_down()
      self.loop_count = 1
    end
    if get_npc_time(self.npc) >= self.last_down + self.gap_time / ((self.width - 2) * (self.length - 2) + 2) / 10 * self.loop_difficulty then
      self.last_down = get_npc_time(self.npc)
      set_scene_timeline_speed(self.path .. "/CrisisPlat" .. tostring(self.loop_order_list[self.loop_count][1]) .. "-" .. tostring(self.loop_order_list[self.loop_count][2]) .. "/" .. self.timeline_name, 1)
      set_scene_plat_speed(self.plat_prefix .. tostring(self.loop_order_list[self.loop_count][1]) .. "-" .. tostring(self.loop_order_list[self.loop_count][2]), 1, self.animation_name, true)
      self.loop_count = self.loop_count + 1
    end
    if self.loop_count > self.width * self.length then
      self.loop_order_list = {}
    end
  elseif -2 == self.phase_max_plat_num_list[self.control] then
    if 0 == #self.cross_order_list then
      self.cross_order_list = self:corss_line_plat_down()
      self.cross_count = 1
    end
    if self.cross_count <= self.max_cross_count and get_npc_time(self.npc) >= self.last_down + self.gap_time / self.max_cross_count / 10 * self.cross_difficulty then
      self.last_down = get_npc_time(self.npc)
      for i = 1, #self.cross_order_list do
        set_scene_timeline_speed(self.path .. "/CrisisPlat" .. tostring(self.cross_order_list[i][self.cross_count][1]) .. "-" .. tostring(self.cross_order_list[i][self.cross_count][2]) .. "/" .. self.timeline_name, 1)
        set_scene_plat_speed(self.plat_prefix .. tostring(self.cross_order_list[i][self.cross_count][1]) .. "-" .. tostring(self.cross_order_list[i][self.cross_count][2]), 1, self.animation_name, true)
      end
      self.cross_count = self.cross_count + 1
    end
    if self.cross_count > self.max_cross_count and get_npc_time(self.npc) >= self.last_down + self.gap_time then
      self.cross_order_list = {}
    end
  end
end

function M:on_room_pass(room_id)
  self.over = true
end

return M
