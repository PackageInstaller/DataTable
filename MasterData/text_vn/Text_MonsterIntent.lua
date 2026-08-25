__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {Text = "Không rõ"},
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "Hành động của lượt tiếp theo không thể biết trước."
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {Text = "Không rõ"},
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "Hành động của lượt tiếp theo không thể biết trước."
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {Text = "Không rõ"},
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "Hành động của lượt tiếp theo không thể biết trước."
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {Text = "Không rõ"},
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "Hành động của lượt tiếp theo không thể biết trước."
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {Text = "Không rõ"},
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "Hành động của lượt tiếp theo không thể biết trước."
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {Text = "Không rõ"},
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "Hành động của lượt tiếp theo không thể biết trước."
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {Text = "Không rõ"},
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "Hành động của lượt tiếp theo không thể biết trước."
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {Text = "Đánh"},
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "Gây {s1} điểm thương cho đội ta."
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {Text = "Yếu đi"},
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "Sẽ áp dụng hiệu ứng tiêu cực lên đội của chúng ta."
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {Text = "Yếu đi"},
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "Sẽ gây ra hiệu ứng tiêu cực mạnh mẽ đối với phe ta."
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {
    Text = "tăng cường"
  },
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "Sẽ được tăng cường."
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {
    Text = "tăng cường"
  },
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "Sẽ được tăng cường."
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {
    Text = "tăng cường"
  },
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "Sẽ được tăng cường."
  },
  ["MonsterIntent_怪物意图强化_Name"] = {
    Text = "tăng cường"
  },
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "Sẽ được tăng cường."
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {Text = "Đánh"},
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "Gây {s1} điểm thương cho đội ta."
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "Đánh & suy yếu"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "Sẽ gây {s1} điểm thương cho đội ta và gây hiệu ứng tiêu cực cho đội ta."
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "Đánh & suy yếu"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "Sẽ gây {s1} điểm thương cho đội ta và gây hiệu ứng tiêu cực cho đội ta."
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "Đánh & tăng cường"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "Sẽ gây {s1} điểm thương cho đội ta, đồng thời được tăng cường."
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "Đánh&phòng thủ"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "Sẽ gây {s1} điểm thương và tạo lá chắn cho phe ta."
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {Text = "Bùng nổ"},
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "Vòng tiếp theo sẽ phát động cơn thịnh nộ bùng phát"
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {Text = "Bùng nổ"},
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "Vòng tiếp theo sẽ phát động cơn thịnh nộ bùng phát"
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {
    Text = "Choáng váng"
  },
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "Đang trong trạng thái choáng, không thể di chuyển hoặc hành động."
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {Text = "Bùng nổ"},
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "Vòng tiếp theo sẽ phát động cơn thịnh nộ bùng phát"
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {Text = "Bùng nổ"},
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "Lượt tiếp theo sẽ đánh bại người chơi."
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {Text = "Đánh"},
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "Gây {s1} điểm thương cho đội ta."
  },
  ["MonsterIntent_怪物意图防御_Name"] = {
    Text = "phòng thủ"
  },
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "Lá chắn sẽ được áp dụng."
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "Phòng thủ và suy yếu"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "Sẽ tạo ra một lớp lá chắn và áp dụng hiệu ứng tiêu cực lên phe ta."
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "Phòng thủ&tăng cường"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "Áp dụng lá chắn và tiến hành tăng cường."
  }
})
return Text_MonsterIntent
