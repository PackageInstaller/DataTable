--移除Buff

FightActionDelBuff = oo.class(FightActionBase);
local this = FightActionDelBuff;


function this:OnPlay()  

    local buff = self:GetBuff();
    if(buff)then        
        local cfgBuff = buff:GetCfg();
        if(cfgBuff.remove_time)then 
            FuncUtil:Call(self.Complete,self,cfgBuff.remove_time);
            CameraMgr:ApplyCommonAction(self,"to_default_camera");      
            FightActionAPIHandler:Handle(self.data);     
            return;
        end
    end

    FightActionAPIHandler:Handle(self.data);    
    self:Complete(); 
    --self:DoDel();
end

--function this:DoDel()
--    --FightActionAPIHandler:Handle(self.data);   
--    self:Complete();
--end

function this:GetBuff()
    return self.data and ClientBuffMgr:GetBuff(self.data.uuid);
end

--获取行动者
function this:GetActorCharacter()
    local buff = self:GetBuff();
    if(buff)then
        return buff:GetTarget();
    end
    return nil;
end

return this;
