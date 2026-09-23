--提示文本
local this = {};

--通用
this.common1 = "未解锁"
this.common2 = "玩家等级达到%s级开启"
this.common3 = "通关%s开启"
this.common4 = "输入的文字中不得含有屏蔽词"

--基地
this.tips1 = "修复需要消耗%s，是否确定？"  --建筑修复
this.tips2 = "角色会移动至该建筑中，是否进行？" --驻员变更
this.tips3 = "是否移除订单？" --驻员变更
this.tips4 = "制作能力不足，无法批量合成" --驻员变更
this.tips5 = "无法放置" --驻员变更
this.tips6 = "已达建造上限"
this.tips7 = "玩家等级不足"
this.tips8 = "指挥中枢等级不足"
this.tips9 = "能力未开启"
this.tips10 = "无相关信息"
this.tips11 = "已达建造上限"
this.tips12 = "来袭前%s分钟，不能调整来袭模式"
this.tips13 = "来袭期间，不能调整来袭模式"

--邮件
this.mail_tips1 = "是否删除已读邮件？"

--任务
this.mission_tips1 = "任务已过期"

--签到
this.Activity_tips2 = "兑换码输入错误！"
this.Activity_tips3 = "兑换成功、奖励已发送至您的邮箱"

--演习
this.Exercise_tips1 = "pvp战斗不能直接退出"

-- --构建
-- this.create_tips1 = "是否消耗%s对剩余构建加速"
-- this.create_tips2 = "是否消耗%s个进行加速"
-- this.create_tips3 = "卡池已关闭"
-- this.create_tips4 = "已达核心研发室上限"
-- this.create_tips5 = "物品数量不足"
-- this.create_tips6 = "第一次获得，是否锁定？"
-- this.create_tips7 = "没有匹配到可对战玩家"

--卡牌
this.role_tips1 = "同一阵容不能存在多张相同的卡牌！"
this.role_tips2 = "选中素材中包含了4星或以上卡牌，是否分解？"
this.role_tips3 = "技能格已满"
this.role_tips4 = "已达到选择上限"
this.role_tips5 = "是否花费%s%s购买%s个格子"
this.role_tips6 = "没有符合要求的角色"

-- --冷却
-- this.cool_tips1 = "请选择冷却装置"
-- this.cool_tips2 = "已达最大时间"
-- this.cool_tips3 = "当前队伍中存在冷却中的队员，不能进入战场！"
-- this.cool_tips4 = "当前队伍角色正在冷却，是否进入冷却室加速？"
-- this.cool_tips6 = "是否消耗%s进行加速？"
-- this.cool_tips7 = "达到%s等级开放"
--好友
this.friend_tips1 = "成功添加%s为好友"
this.friend_tips2 = "申请已达上限"

--能力
this.Ability_text1 = "没有可重置的能力"
this.Ability_text2 = "是否消耗%s%s进行能力重置？"
this.Ability_text3 = "是否消耗%s点能力点数开启%s"
this.Ability_text4 = "需要玩家达到%s级"

return this; 