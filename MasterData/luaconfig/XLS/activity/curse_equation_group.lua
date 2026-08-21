local t = {
  {
    DropCount = 3,
    DropType = 1,
    FixedDrop = {},
    Id = 1,
    IsSelect = true,
    RandomDrop = {
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9
    },
    RefreshCount = 1,
    RefreshItemCount = 50,
    RefreshItemId = 500001,
    SelectCount = 1,
    TitleText = "测试用随机可选掉落",
    beizhu = "测试用"
  },
  {
    DropCount = 1,
    DropType = 1,
    FixedDrop = nil,
    Id = 2,
    IsSelect = false,
    RandomDrop = {
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9
    },
    RefreshCount = 1,
    RefreshItemCount = 50,
    RefreshItemId = 500001,
    SelectCount = 1,
    TitleText = "测试用随机不可选掉落",
    beizhu = "测试用"
  },
  {
    DropCount = 2,
    DropType = 2,
    FixedDrop = {1, 2},
    Id = 3,
    IsSelect = false,
    RandomDrop = nil,
    RefreshCount = 1,
    RefreshItemCount = 50,
    RefreshItemId = 500001,
    SelectCount = 1,
    TitleText = "测试用固定不可选掉落",
    beizhu = "测试用"
  },
  {
    DropCount = 2,
    DropType = 2,
    FixedDrop = {1, 2},
    Id = 4,
    IsSelect = true,
    RandomDrop = nil,
    RefreshCount = 1,
    RefreshItemCount = 50,
    RefreshItemId = 500001,
    SelectCount = 1,
    TitleText = "测试用固定可选掉落",
    beizhu = "测试用"
  },
  {
    DropCount = 2,
    DropType = 2,
    FixedDrop = {14, 16},
    Id = 5,
    IsSelect = true,
    RandomDrop = nil,
    RefreshCount = 0,
    RefreshItemCount = 0,
    RefreshItemId = 0,
    SelectCount = 1,
    TitleText = "请选择一个片段",
    beizhu = "圣誓相关"
  },
  {
    DropCount = 2,
    DropType = 2,
    FixedDrop = {11, 12},
    Id = 6,
    IsSelect = true,
    RandomDrop = nil,
    RefreshCount = 0,
    RefreshItemCount = 0,
    RefreshItemId = 0,
    SelectCount = 1,
    TitleText = "请选择一个片段",
    beizhu = "时沙相关"
  },
  {
    DropCount = 2,
    DropType = 2,
    FixedDrop = {11, 13},
    Id = 7,
    IsSelect = true,
    RandomDrop = nil,
    RefreshCount = 0,
    RefreshItemCount = 0,
    RefreshItemId = 0,
    SelectCount = 1,
    TitleText = "请选择一个片段",
    beizhu = "永夏相关"
  },
  {
    DropCount = 2,
    DropType = 2,
    FixedDrop = {12, 15},
    Id = 8,
    IsSelect = true,
    RandomDrop = nil,
    RefreshCount = 0,
    RefreshItemCount = 0,
    RefreshItemId = 0,
    SelectCount = 1,
    TitleText = "请选择一个片段",
    beizhu = "巨企相关"
  },
  {
    DropCount = 2,
    DropType = 2,
    FixedDrop = {13, 14},
    Id = 9,
    IsSelect = true,
    RandomDrop = nil,
    RefreshCount = 0,
    RefreshItemCount = 0,
    RefreshItemId = 0,
    SelectCount = 1,
    TitleText = "请选择一个片段",
    beizhu = "铸雷相关"
  },
  {
    DropCount = 2,
    DropType = 2,
    FixedDrop = {15, 16},
    Id = 10,
    IsSelect = true,
    RandomDrop = nil,
    RefreshCount = 0,
    RefreshItemCount = 0,
    RefreshItemId = 0,
    SelectCount = 1,
    TitleText = "请选择一个片段",
    beizhu = "神谕相关"
  },
  {
    DropCount = 3,
    DropType = 1,
    FixedDrop = nil,
    Id = 11,
    IsSelect = true,
    RandomDrop = {
      11,
      12,
      13,
      14,
      15,
      16
    },
    RefreshCount = 1,
    RefreshItemCount = 50,
    RefreshItemId = 500001,
    SelectCount = 1,
    TitleText = "请选择一个片段",
    beizhu = "全随机"
  }
}
t[2].FixedDrop = t[1].FixedDrop
t[3].RandomDrop = t[1].FixedDrop
t[4].RandomDrop = t[1].FixedDrop
t[5].RandomDrop = t[1].FixedDrop
t[6].RandomDrop = t[1].FixedDrop
t[7].RandomDrop = t[1].FixedDrop
t[8].RandomDrop = t[1].FixedDrop
t[9].RandomDrop = t[1].FixedDrop
t[10].RandomDrop = t[1].FixedDrop
t[11].FixedDrop = t[1].FixedDrop
return t
