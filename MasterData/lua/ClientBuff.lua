--buff
local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

--设置数据
function this:SetData(buffData)
    if(buffData == nil)then
        return;
    end
    if(self.data and buffData.nCount)then
        --LogError(buffData.nCount);
        if(buffData.index and self.data.index and buffData.index < self.data.index)then
            return;
        end
    end 
    
    local lastShieldCount = self.data and (self.data.nShieldCount or self.data.nCount);
    local currShieldCount = buffData and buffData.nShieldCount;
    if(lastShieldCount and currShieldCount and lastShieldCount > currShieldCount)then        
        if(self.bes)then
            for _,be in ipairs(self.bes)do
               be.TryCall("DecayShield");
            end
        end
    end


    if(self.data)then
        for k,v in pairs(buffData)do
            self.data[k] = v;
        end
    else
        self.data = buffData;
        local cfgId = buffData.bufferID;
        self.cfg = Cfgs.BufferConfig:GetByID(cfgId);
        if(not self.cfg)then
            LogError("BufferConfig找不到配置：\n" .. table.tostring(buffData));
        end
        if(buffData.api == APIType.Buff)then
            self:ApplyBuffEff(self.cfg.add_effect,self.cfg.show_effect,self.cfg.add_action);        
            self:ApplyFloatFont();  
        end
    end   

    if(buffData.api == APIType.UpdateBuff)then
        if(self.cfg.update_effect)then
            self:ApplyBuffEff(self.cfg.update_effect);        
            self:ApplyFloatFont();  
        end   
    end     
    
    local targetCharacter = self:GetTarget();
    if(targetCharacter ~= nil)then
        targetCharacter.UpdateBuff(self);
    end   

    --LogError("数据===\n" .. table.tostring(self.data) .."\n配置===\n" .. table.tostring(self.cfg));
end
--飘字
function this:ApplyFloatFont()
    if(not self.cfg or not self.cfg.float_font)then
       return;
    end

    local targetCharacter = self:GetTarget();
    if(targetCharacter)then        
        targetCharacter.CreateFloatFont(self.cfg.float_font);
    end    
end
--特效
function this:ApplyBuffEff(effName,showEff,addAction)
   
    if(effName)then
        self:CreateBuffEffect(effName);
    end

    if(showEff)then
        local be = self:CreateBuffEffect(showEff);
        if(be)then        
            self.bes = self.bes or {};
            table.insert(self.bes,be);
        end    
    end    
    
    if(addAction)then
        --LogError(addAction);
        local targetCharacter = self:GetTarget();
        if(targetCharacter)then
            CSAPI.ApplyAction(targetCharacter.resParentGO,addAction);       
        end
    end    
end

function this:CreateBuffEffect(beKey)
    if(beKey)then       
        local targetCharacter = self:GetTarget();
        if(targetCharacter ~= nil)then        
            local be = targetCharacter.ApplyBuffEff(beKey,self);
            return be;
        end        
    end
        
    return nil;
end

--移除
function this:Remove(playRemoveEff)
--    LogError("移除buff");
--    LogError(self.data);
    local targetCharacter = self:GetTarget();
    if(targetCharacter ~= nil)then
        targetCharacter.RemoveBuff(self);

        if(self.bes)then
            for _,be in ipairs(self.bes)do
                if(be)then
                    be.Remove(self);
                end
            end
        end
        self.bes = nil;

        if(not playRemoveEff and self.cfg.remove_effect)then
            --self:CreateBuffEffect(self.cfg.remove_effect);
            local cfgBE = Cfgs.buff_effect:GetByKey(self.cfg.remove_effect);
            if(cfgBE and cfgBE.res and targetCharacter.gameObject)then
                local bodySize = targetCharacter.GetBodySize();
                ResUtil:CreateBuffEff(cfgBE.res,targetCharacter.gameObject,nil,bodySize);  
            end  
        end        

        

        if(not playRemoveEff and self.cfg.remove_action)then
             --LogError(self.data);
             local playRemoveAction = true;
             local buffs = targetCharacter.GetBuffs();
             if(buffs)then
                for _,buff in pairs(buffs)do
                    
                    --LogError(buff.data);
                    if(buff.data.bufferID == self.data.bufferID and buff.data.uuid ~= self.data.uuid)then
                        playRemoveAction = false;
                        break;
                    end
                end
             end
             if(playRemoveAction)then
                CSAPI.ApplyAction(targetCharacter.resParentGO,self.cfg.remove_action);      
             end
             --LogError("buff移除Action：" .. self.cfg.remove_action); 
        end
        --CSAPI.ApplyAction(targetCharacter.resParentGO,"action_60090");     
        --LogError(targetCharacter.gameObject.name);
        --CSAPI.ApplyAction(targetCharacter.gameObject,"action_GuangDun_Break");
    end
end



--获取buff目标
function this:GetTarget()
    if(self.character == nil)then
        if(self.data ~= nil)then       
           self.character = CharacterMgr:Get(self.data.targetID); 
        end
    end
    return self.character;
end

function this:UID()
    return self.data.uuid;
end

function this:GetData()
    return self.data;
end

function this:GetCfg()
    return self.cfg;
end

function this:GetShowCount()
    local data = self:GetData();
    local nShieldCount = nil;
    if(data.nShieldCount)then
        nShieldCount = data.nShieldCount;
    elseif(data["OnCreate"])then
        for _,v in ipairs(data["OnCreate"])do
            if(v.nShieldCount)then
                nShieldCount = v.nShieldCount;
            end
        end
    end
    local nCount = data.nCount;
    return nShieldCount or nCount;
end

--物理护盾分组14
local pShieldGroup = 14;
--能量护盾分组15
local eShieldGroup = 15;
--获取护盾
function this:GetShield()
    local cfg = self:GetCfg();
    local shieldType = nil;
    if(cfg)then
        if(cfg.group == pShieldGroup)then
            shieldType = 1;
        elseif(cfg.group == eShieldGroup)then
            shieldType = 2;
        end
    end

    if(shieldType)then
        local count = self:GetShowCount();
        return shieldType,count;
    end    
end

function this:IsShow()
    return self.cfg and self.cfg.icon;
end


return this;