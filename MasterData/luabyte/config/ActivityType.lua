local ActivityType = {}
ActivityType.NONE = 0
ActivityType.ONLINE_GIFT_BAG = 1      --在线
ActivityType.TIME_LIMIT_PVE = 2       --限时副本
ActivityType.DAILY_GOALS = 3          --特派
ActivityType.SIGN = 4                 --登陆
ActivityType.VOTE = 5                 --投票
ActivityType.SPACECRAFT_UPGRADE = 6   --战舰升级
ActivityType.EXCHANGE = 7             --兑换
ActivityType.SEVENDAYSHOP = 8         --七日售卖
ActivityType.SEVENDAYSCORE = 9        --七日积分
ActivityType.MASKEDBALL_MAIN = 10     --假面舞会
ActivityType.MASKEDBALL_TASK = 11     --假面舞会任务
ActivityType.MASKEDBALL_SHOP = 12     --假面舞会商店
ActivityType.PASS_MAIN = 13           --通行证
ActivityType.PASS_TASK = 14           --通行证任务
ActivityType.DORM_DAILY_GOALS = 15    --宿舍三日目标
ActivityType.PASS_SHOP = 16           -- 通行证商店
ActivityType.DORM_PUZZLE = 17         -- 宿舍拼图活动
ActivityType.RES_ACTIVITY_COPY = 18   -- 资源活动副本
ActivityType.MAIN_ACTIVITY_COPY = 19  -- 主线活动副本
ActivityType.OFFER_ACTIVITY_COPY = 20 -- 悬赏活动副本
ActivityType.TURNTABLE = 21           -- 转盘活动
ActivityType.TURNTABLE_TASK = 22      -- 转盘子活动-任务
ActivityType.BACKSTORY = 23           -- 回归剧情活动

ActivityType.ActivityState = {
    Ongoing = 0,   -- 进行中
    Completed = 1, -- 已完成
    Received = 2   -- 已领取
}

return ActivityType
