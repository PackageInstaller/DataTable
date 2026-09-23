-- 回归活动信息
RegressionProto = {}

-- 回归活动信息 
function RegressionProto:GetInfo()
    local proto = {"RegressionProto:GetInfo"}
    NetMgr.net:Send(proto)
end
function RegressionProto:GetInfoRet(proto)
    RegressionMgr:GetInfoRet(proto)
end

-- 日常资源找回领取奖励返回
function RegressionProto:ResourcesRecoveryGainRet(proto)
    if (proto.resourcesIsGain == 1) then
        RegressionMgr:SetResRecoveryGain(proto.resourcesIsGain)
        --EventMgr.Dispatch(EventType.HuiGui_Res_Recovery)
    end
end

--获取道具池信息
function RegressionProto:ItemPoolInfo(id,isNextRound)
    local proto = {"RegressionProto:ItemPoolInfo",{id=id,nextRound=isNextRound}}
    NetMgr.net:Send(proto)
end

function RegressionProto:ItemPoolInfoRet(proto)
    ItemPoolActivityMgr:UpdatePoolInfo(proto);
    RegressionMgr:CheckRedPointData();
    EventMgr.Dispatch(EventType.ItemPool_Date_Update);
end

--抽取道具池 id:道具池id，times：次数
function RegressionProto:ItemPoolDraw(id,times)
    local proto = {"RegressionProto:ItemPoolDraw",{id=id,times=times}}
    NetMgr.net:Send(proto)
end

function RegressionProto:ItemPoolDrawRet(proto)
    ItemPoolActivityMgr:OnDrawRet(proto);
    RegressionMgr:CheckRedPointData();
    EventMgr.Dispatch(EventType.ItemPool_Draw_Ret,proto);
end

--获取绑定活动信息
function RegressionProto:PlrBindInfo()
    local proto = {"RegressionProto:PlrBindInfo"}
    NetMgr.net:Send(proto)
end

--绑定活动数据返回
function RegressionProto:PlrBindInfoRet(proto)
    CollaborationMgr:OnBindInfoRet(proto);
    EventMgr.Dispatch(EventType.Collaboration_Info_Update)
end

--邀请绑定
function RegressionProto:PlrBindInvite(code,uid)
    if code~=nil then
        code=string.match(code,"%d+_%d+");
        local proto = {"RegressionProto:PlrBindInvite",{code=code,uid=uid}}
        NetMgr.net:Send(proto)
    elseif uid~=nil then
        local proto = {"RegressionProto:PlrBindInvite",{uid=uid}}
        NetMgr.net:Send(proto)
    else
        LanguageMgr:ShowTips(40005);
    end
end

--邀请绑定返回(我邀请别人)
function RegressionProto:PlrBindInviteRet(proto)
    CollaborationMgr:OnBindOver({data=proto,isMine=true});
    -- if proto and proto.isOk then
    --     CollaborationMgr:RecordInvitRet(true);
    -- end
    EventMgr.Dispatch(EventType.Collaboration_BindInvite_Ret,{data=proto,isMine=true})
end

--被邀请绑定
function RegressionProto:PlrBindBeInvite(proto)
    CollaborationMgr:UpdateInviteList(proto);
    EventMgr.Dispatch(EventType.Collaboration_Invite_Req)
end

--被邀请绑定结果响应
function RegressionProto:PlrBindBeInviteRet(isOk,uid)
    local proto = {"RegressionProto:PlrBindBeInviteRet",{isOk=isOk,inviter=uid}}
    NetMgr.net:Send(proto)
end

--邀请绑定结果(别人邀请我)
function RegressionProto:PlrBindInviteResult(proto)
    -- CollaborationMgr:OnBindOver({data=proto,isMine=false});
    if proto then
        CollaborationMgr:RemoveInviteList(proto.beInviter);
        if proto.isOk then
            CollaborationMgr:RecordInvitRet(true);
        end
    end
    EventMgr.Dispatch(EventType.Collaboration_BindInvite_Ret,{data=proto,isMine=false})
end

--获取邀请自身的列表
function RegressionProto:PlrBindInviteList(page)
    local proto = {"RegressionProto:PlrBindInviteList",{page=page}}
    NetMgr.net:Send(proto)
end

--同意/拒绝他人的结果返回
function RegressionProto:PlrBindBeInviteRetNotice(proto)
    CollaborationMgr:OnInviteOptionRet(proto);
    EventMgr.Dispatch(EventType.Collaboration_InviteOption_Ret,proto);
end

function RegressionProto:PlrBindInviteListRet(proto)
    CollaborationMgr:BindInviteUpdate(proto);
    EventMgr.Dispatch(EventType.Collaboration_BindInvite_Update)
end

--获取推荐列表
function RegressionProto:PlrBindRecoment(skip)
    local proto = {"RegressionProto:PlrBindRecoment",{page=skip}}
    NetMgr.net:Send(proto)
end


function RegressionProto:PlrBindRecomentRet(proto)
    CollaborationMgr:BindRecomentUpdate(proto);
    EventMgr.Dispatch(EventType.Collaboration_BindRecoment_Update)
end

--领取阶段奖励
function RegressionProto:PlrBindGainReward()
    local proto = {"RegressionProto:PlrBindGainReward"}
    NetMgr.net:Send(proto)
end

--领取阶段奖励返回
function RegressionProto:PlrBindGainRewardRet(proto)
    CollaborationMgr:OnGainRewardRet(proto);
    EventMgr.Dispatch(EventType.Collaboration_BindReward_Ret)
end

--获取绑定任务信息
function RegressionProto:PlrBindStageTaskInfo()
    local proto = {"RegressionProto:PlrBindStageTaskInfo"}
    NetMgr.net:Send(proto)
end

--获取绑定任务信息返回
function RegressionProto:PlrBindStageTaskInfoRet(proto)
    CollaborationMgr:OnStageTaskInfoRet(proto);
    EventMgr.Dispatch(EventType.Collaboration_StageTaskInfo_Ret)
end

function RegressionProto:PlrFundInfo(proto)
    RegressionMgr:SetFundTime(proto)
end

--获取燃料补给信息
function RegressionProto:ResupplyInfo()
    local proto = {"RegressionProto:ResupplyInfo"}
    NetMgr.net:Send(proto)
end

function RegressionProto:ResupplyInfoRet(proto)
    RegressionMgr:SetSupplyDatas(proto)
end

--燃料补给领取奖励
function RegressionProto:ResupplyGain(id,index)
    local proto = {"RegressionProto:ResupplyGain",{id = id,idx = index}}
    NetMgr.net:Send(proto)
end

--回归活跃返利信息
function RegressionProto:ActiveRewardsInfo()
    local proto = {"RegressionProto:ActiveRewardsInfo"}
    NetMgr.net:Send(proto)
end

--回归活跃返利信息返回
function RegressionProto:ActiveRewardsInfoRet(proto)
    RegressionMgr:SetRebateInfo(proto)
end

--回归活跃返利 奖励领取
function RegressionProto:ActiveRewardsGain(index)
    local proto = {"RegressionProto:ActiveRewardsGain",{idx = index}}
    NetMgr.net:Send(proto)
end