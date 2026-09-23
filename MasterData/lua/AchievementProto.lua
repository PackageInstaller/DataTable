AchievementProto = {}

--获取成就的数据
function AchievementProto:GetFinishInfo()
    local proto = {"AchievementProto:GetFinishInfo", {}};
	NetMgr.net:Send(proto);
end

--获取成就的数据返回 --finish_list:CfgAchieveFinishVal的id，完成的次数
function AchievementProto:GetFinishInfoRet(proto)
    Log("AchievementProto:GetFinishInfoRet")
    Log(proto)
    AchievementMgr:SetDatas(proto)
end

--成就的领取详情
function AchievementProto:GetRewardInfo()
    local proto = {"AchievementProto:GetRewardInfo", {}};
	NetMgr.net:Send(proto);
end

--成就的领取详情返回
function AchievementProto:GetRewardInfoRet(proto)
    Log("AchievementProto:GetRewardInfoRet")
    Log(proto)
    AchievementMgr:SetRewardInfos(proto)
end

--成就信息刷新
function AchievementProto:UpdateFinishInfoRet(proto)
    AchievementMgr:UpdateFinishInfo(proto)
end

--成就领取
function AchievementProto:GetReward(id, callBack)
    local proto = {"AchievementProto:GetReward", {id = id}};
	NetMgr.net:Send(proto);
    self.rewardCallBack = callBack
end

--成就领取返回
function AchievementProto:GetRewardRet(proto)
    Log("AchievementProto:GetRewardRet")
    Log(proto)
    if proto and proto.achievementReward then
        AchievementMgr:ShowReward({proto.achievementReward}, proto.gets,self.rewardCallBack)
    end
    self.rewardCallBack = nil
end

--一键领取奖励
function AchievementProto:GetAllReward()
    local proto = {"AchievementProto:GetAllReward", {}};
	NetMgr.net:Send(proto);
end

--一键领取奖励返回
function AchievementProto:GetAllRewardRet(proto)
    Log("AchievementProto:GetAllRewardRet")
    Log(proto)
    if proto and proto.achievementRewards then
        AchievementMgr:ShowReward(proto.achievementRewards, proto.gets)
    end
end


