--宠物协议
SummerProto={}

--获取宠物信息，不发id则全部获得
function SummerProto:PetInfo(id)
    local proto = {"SummerProto:PetInfo",{id=id}}
    NetMgr.net:Send(proto)
end

function SummerProto:PetInfoRet(proto)
    PetActivityMgr:OnActivityDataRet(proto); 
    PetActivityMgr:ChecekRedInfo()
    EventMgr.Dispatch(EventType.PetActivity_PetInfo_Ret);
end

--宠物运动
function SummerProto:PetSport(type,time,scene)
    local proto = {"SummerProto:PetSport",{ty=type,time=time,scene=scene}}
    NetMgr.net:Send(proto)
end

function SummerProto:PetSportRet(proto)
    EventMgr.Dispatch(EventType.PetActivity_Sport_Ret);
    PetActivityMgr:ChecekRedInfo();
end

--切换宠物
function SummerProto:PetSwitch(id)
    local proto = {"SummerProto:PetSwitch",{id=id}}
    NetMgr.net:Send(proto)
end

function SummerProto:PetSwitchRet(proto)
    PetActivityMgr:OnSwitchPet(proto);
    EventMgr.Dispatch(EventType.PetActivity_Switch_Ret,proto)
end

--宠物养成领取
function SummerProto:PetGainReward()
    local proto = {"SummerProto:PetGainReward"}
    NetMgr.net:Send(proto)
end

function SummerProto:PetGainRewardRet(proto)
    if proto and proto.idx then
        PetActivityMgr:UpdatePetRevice(proto);
        if proto.rewards then
            UIUtil:OpenSummerReward({proto.rewards})
        end
    end
    PetActivityMgr:ChecekRedInfo()
    EventMgr.Dispatch(EventType.PetActivity_GainReward_Ret,proto)
end

--领取宠物礼物奖励
function SummerProto:GainRandomGift()
    local proto = {"SummerProto:GainRandomGift"}
    NetMgr.net:Send(proto)
end

function SummerProto:GainRandomGiftRet(proto)
    if proto then
        -- PetActivityMgr:UpdatePetGiftRevice(proto);
        PetActivityMgr:SetHasRandReward(false);
        PetActivityMgr:UpdateNextRandom(proto);
        if proto.rewards then
            UIUtil:OpenSummerReward({proto.rewards})
        end
    end
    PetActivityMgr:ChecekRedInfo()
    EventMgr.Dispatch(EventType.PetActivity_GainReward_Ret,proto)
end

--单个宠物更新推送
function SummerProto:PetPush(proto)
    if proto and proto.info then
        PetActivityMgr:OnPetUpdate(proto.info);
        PetActivityMgr:UpdateNextRandom(proto);
    end
    PetActivityMgr:ChecekRedInfo()
    EventMgr.Dispatch(EventType.PetActivity_UpdatePet_Ret,proto)
end

--宠物已解锁图鉴更新
function SummerProto:BestiaryPush(proto)
    if proto and proto.id then
        PetActivityMgr:UpdateUnLockList(proto.id)
    end
    PetActivityMgr:ChecekRedInfo()
    EventMgr.Dispatch(EventType.PetActivity_Bestiary_Ret,proto)
end

--领取图鉴奖励
function SummerProto:GainBestiaryReward(id)
    local proto = {"SummerProto:GainBestiaryReward",{id=id}}
    NetMgr.net:Send(proto)
end

function SummerProto:GainBestiaryRewardRet(proto)
    if proto and proto.id then
        PetActivityMgr:UpdateReviceList(proto.id)
        if proto.rewards then
            UIUtil:OpenSummerReward({proto.rewards})
        end
    end
    PetActivityMgr:ChecekRedInfo()
    EventMgr.Dispatch(EventType.PetActivity_BestiaryReward_Ret,proto)
end