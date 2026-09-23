local ClientBuff = require "ClientBuff";

local this = {}
ClientBuffMgr = this;

--创建事件
BuffEvent_OnCreate = "OnCreate";

--初始化
function this:Init()
    self:Clean();
end
--清理
function this:Clean()
    if(self.datas ~= nil)then
        for id,buff in pairs(self.datas)do
            buff:Remove(true);
        end
    end
    self.datas = {};
    
    self:ClearRemovedBuffIds();
    --LogError("清理buff");
end
----获取Buff
function this:GetBuff(uid)
    return self.datas[uid];
end
--更新Buff
function this:UpdateBuff(buffData)
    local uid = buffData.uuid;
    local buff = self:GetBuff(uid);

    if(buff == nil)then       
        if(buffData.api == APIType.Buff)then
            buff = ClientBuff.New();
            self.datas[uid] = buff;

            --LogError("新buff" .. tostring(buffData.uuid))
        else
            return;
        end
    end

    if(buff ~= nil)then
        buff:SetData(buffData);

        if(self:IsRemoved(uid))then
            --LogError("已经移除的buff" .. uid);
            self:RemoveBuff(uid); 
        end
    end         
end
function this:IsRemoved(uid)
    return self.removedIds and self.removedIds[uid];
end
function this:ClearRemovedBuffIds()
    self.removedIds = nil;
end
--移除Buff
function this:RemoveBuff(uid)
    if(not uid)then
        return;
    end
    self.removedIds = self.removedIds or {};
    self.removedIds[uid] = 1;

    local buff = self:GetBuff(uid);

    if(buff)then
        buff:Remove();
        buff = nil;
        self.datas[uid] = nil;
    else
        --LogError("移除buff失败！没有buff " .. tostring(uid));
        --可能是加buff延迟导致的
    end   
end

this:Init();

return this;