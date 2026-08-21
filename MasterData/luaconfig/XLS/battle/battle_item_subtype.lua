local t = {
  {
    [4] = {
      SubtypeId = 4,
      TypeId = 1,
      TypeName = "test_item2"
    }
  },
  {
    {
      SubtypeId = 1,
      TypeId = 2,
      TypeName = "healing_salve"
    },
    {
      SubtypeId = 2,
      TypeId = 2,
      TypeName = "no_judge_salve"
    },
    {
      SubtypeId = 3,
      TypeId = 2,
      TypeName = "test_item1"
    },
    [5] = {
      SubtypeId = 5,
      TypeId = 2,
      TypeName = "test_item3"
    }
  },
  [4] = {
    {
      SubtypeId = 1,
      TypeId = 4,
      TypeName = "talent_attr_to_god"
    }
  },
  [5] = {
    [6] = {
      SubtypeId = 6,
      TypeId = 5,
      TypeName = "skill_book"
    }
  },
  [6] = {
    [7] = {
      SubtypeId = 7,
      TypeId = 6,
      TypeName = "treasure_box"
    }
  },
  [7] = {
    {
      SubtypeId = 1,
      TypeId = 7,
      TypeName = "floor_preview"
    }
  },
  [8] = {
    {
      SubtypeId = 1,
      TypeId = 8,
      TypeName = "buff_item"
    },
    {
      SubtypeId = 2,
      TypeId = 8,
      TypeName = "passive_buff_item"
    }
  },
  [9] = {
    {
      SubtypeId = 1,
      TypeId = 9,
      TypeName = "chal_ring_attr_item"
    },
    {
      SubtypeId = 2,
      TypeId = 9,
      TypeName = "chal_ring_draw_item"
    },
    {
      SubtypeId = 3,
      TypeId = 9,
      TypeName = "chal_ring_replace_item"
    },
    {
      SubtypeId = 4,
      TypeId = 9,
      TypeName = "chal_ring_copy_item"
    },
    {
      SubtypeId = 5,
      TypeId = 9,
      TypeName = "chal_ring_emblem_item"
    },
    {
      SubtypeId = 6,
      TypeId = 9,
      TypeName = "chal_ring_stock"
    },
    {
      SubtypeId = 7,
      TypeId = 9,
      TypeName = "chal_ring_add_salve_effect"
    },
    {
      SubtypeId = 8,
      TypeId = 9,
      TypeName = "chal_ring_add_sell_count"
    }
  },
  buff_item = nil,
  chal_ring_add_salve_effect = nil,
  chal_ring_add_sell_count = nil,
  chal_ring_attr_item = nil,
  chal_ring_copy_item = nil,
  chal_ring_draw_item = nil,
  chal_ring_emblem_item = nil,
  chal_ring_replace_item = nil,
  chal_ring_stock = nil,
  floor_preview = nil,
  healing_salve = nil,
  no_judge_salve = nil,
  passive_buff_item = nil,
  skill_book = nil,
  talent_attr_to_god = nil,
  test_item1 = nil,
  test_item2 = nil,
  test_item3 = nil,
  treasure_box = nil
}
t.buff_item = t[8][1]
t.chal_ring_add_salve_effect = t[9][7]
t.chal_ring_add_sell_count = t[9][8]
t.chal_ring_attr_item = t[9][1]
t.chal_ring_copy_item = t[9][4]
t.chal_ring_draw_item = t[9][2]
t.chal_ring_emblem_item = t[9][5]
t.chal_ring_replace_item = t[9][3]
t.chal_ring_stock = t[9][6]
t.floor_preview = t[7][1]
t.healing_salve = t[2][1]
t.no_judge_salve = t[2][2]
t.passive_buff_item = t[8][2]
t.skill_book = t[5][6]
t.talent_attr_to_god = t[4][1]
t.test_item1 = t[2][3]
t.test_item2 = t[1][4]
t.test_item3 = t[2][5]
t.treasure_box = t[6][7]
return t
