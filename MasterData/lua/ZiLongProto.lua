ZiLongProto={}
local this=ZiLongProto;
---查询是否领取
---isTryfalse true 不领取  false 领取
function this.SendGetGuestBinding(isTryfalse)
    local proto={"ZiLongProto:GetGuestBinding",{isTry=isTryfalse}};
    NetMgr.net:Send(proto);
end

---4500
function ZiLongProto:GetGuestBinding(proto)
      --Log("接收到紫龙 ZiLongProto:GetGuestBinding：")
      --LogError("接收到紫龙 ZiLongProto:GetGuestBinding："..table.tostring(proto))
end

---4501
------isTryfalse true 不领取  false 领取
function this.SendGetGuestBindingRet(isTryfalse)
    local proto={"ZiLongProto:GetGuestBindingRet",{isTry=isTryfalse}};
    NetMgr.net:Send(proto);
end

---4501
------isTryfalse true 不领取  false 领取
function ZiLongProto:GetGuestBindingRet(proto)
    AdvBindingRewards.QuerystateBack(proto)
end