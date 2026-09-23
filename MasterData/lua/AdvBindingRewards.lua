AdvBindingRewards={}
local this=AdvBindingRewards;


this.isHadReward=false;
this.isTry=false;
this.rewards={};
this.BackAction=nil;
---查询状态
function this.Querystate()
    ZiLongProto.SendGetGuestBinding(true)
end

---领取状态
function this.Claimstatus(action)
    this.BackAction=action;
    ZiLongProto.SendGetGuestBinding(false)
end
---查询状态 返回
function this.QuerystateBack(proto)
    --Log("ZiLongProto:GetGuestBindingRet：")
    --LogError("接收到紫龙 ZiLongProto:GetGuestBindingRet："..table.tostring(proto))
    this.isTry=proto["isTry"]
    this.isHadReward=proto["isHadReward"]
    this.rewards=proto["rewards"]
    if   this.isTry==false and this.isHadReward and this.rewards and #this.rewards>0 then
        --print("领取奖励成功")
        if next(proto.rewards) then
            UIUtil:OpenReward( {proto.rewards})
            if this.BackAction~=nil then
                this.BackAction();
                this.BackAction=nil;
                this.isHadReward=false;
                this.isTry=false
            end
        end
    end
end