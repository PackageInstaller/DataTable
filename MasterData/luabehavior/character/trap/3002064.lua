local monster = Util.create_class()

function monster:_init(npc)
  monster.npc = npc
  self.npc = npc
  monster.search = {}
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 399001, 1)
  if get_cur_room_id() == 800401 then
    set_npc_status(npc, 4, true)
    if get_npc_id(npc) == 3002064 then
      cast_magic(npc, npc, 30020640101, 1)
    end
    if get_npc_id(npc) == 3002065 then
      cast_magic(npc, npc, 30020650101, 1)
    end
  end
  if get_cur_room_id() ~= 800401 then
    for i = 1, 3 do
      if get_npc_id(monster.npc) == 3002063 + i then
        cast_missile_new(monster.npc, monster.npc, nil, nil, 30020640100 + i, 1)
      end
    end
  else
    cast_missile_new(monster.npc, monster.npc, nil, nil, 30020640102, 1)
  end
end

function monster.on_frame(monster)
  for i = 1, 3 do
    if get_sync_var("instrument") == i and get_npc_id(monster.npc) == 3002063 + i then
      cast_missile_new(monster.npc, monster.npc, nil, nil, 30020640201, 1)
      set_sync_var("instrument", 0)
    end
    if get_sync_var(i) and get_npc_id(monster.npc) == 3002063 + i then
      print("攻击信号" .. tostring(get_sync_var(i)))
      cast_missile_new(monster.npc, monster.npc, nil, nil, 30020640201, 1)
      set_sync_var(i, false)
    end
  end
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 30020640201 then
    if get_cur_room_id() == 800401 then
      cast_missile_new(monster.npc, monster.npc, nil, nil, 30020640203, 1)
    else
      print("乐器检测magic层数" .. tostring(get_magic_num(get_come_on_hero(), 300206102)))
      for i = 1, 3 do
        if get_npc_id(monster.npc) == 3002063 + i then
          cast_missile_new(monster.npc, monster.npc, nil, nil, 30020640201 + i, 1)
        end
      end
    end
  end
end

function monster.on_self_npc_removed(monster)
  for i = 1, 3 do
    if get_npc_id(monster.npc) == 3002060 + i then
      remove_missile_by_id(30020640100 + i, monster.npc, false)
      remove_missile_by_id(30020640201 + i, monster.npc, false)
    end
  end
  if get_cur_room_id() == 800401 then
    remove_missile_by_id(30020640203, monster.npc, false)
  end
  remove_missile_by_id(30020640201, monster.npc, false)
end

return monster
