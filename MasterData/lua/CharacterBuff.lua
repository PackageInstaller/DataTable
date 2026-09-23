--角色Buff模块

local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	
	return ins;
end

function this:Init(character)
    if(self.character)then
        return;
    end

    self.character = character;
    self.buffs = {};
end

--更新Buff
function this:UpdateBuff(buff)
   local uid = buff:UID();

   local isNewBuff = not self.buffs[uid];

   local lastBuff = self.buffs[uid];  
   self.buffs[uid] = buff;

   local cfg = buff:GetCfg();

   if(isNewBuff and cfg.keep_state)then
       self.character.SetActiveKeepState(true);
   end
end

function this:GetBuffByCfgId(cfgId)
    if(self.buffs)then
        for _,buff in pairs(self.buffs)do
            local cfg = buff:GetCfg();
            if(cfg.id == cfgId)then
                return buff;
            end
        end
    end
end

--移除Buff
function this:RemoveBuff(buff)
   local uid = buff:UID();
   self.buffs[uid] = nil;

   local cfg = buff:GetCfg();
   if(cfg.keep_state)then
       self.character.SetActiveKeepState(false);
   end
end

function this:ApplyRemoveAll()
    if(self.buffs)then
        for _,buff in pairs(self.buffs)do
            buff:Remove(true);
        end
    end
end

--获取Buffs
function this:GetBuffs()
    return self.buffs;
end

--获取目标选择
function this:GetSelLimits()
    local list = nil;
    
    for _,buff in pairs(self.buffs)do
        local buffData = buff:GetData();
        
        --local buffCfg = buff:GetCfg();
        --LogError(buffData);
        if(buffData.sneer)then
            list = list or {};
            list[buffData.id] = 1;
        elseif(buffData)then                      
            local effs = buffData[BuffEvent_OnCreate];
            if(effs ~= nil)then
                for _,effData in ipairs(effs)do
                    if(effData.api == APIType.Sneer)then
                        list = list or {};
                        list[effData.casterID] = 1;
                    end
                end
            end
        end
    end
--    if(list)then
--        LogError("获取嘲讽数据=====================");
--        LogError(list);
--    end
    return list;
end
--获取Buff增加的护盾值
function this:GetHp()
    local left,max = 0,0;
    
    if(self.buffs)then
        for _,buff in pairs(self.buffs)do
            local buffData = buff:GetData();
        
            if(buffData ~= nil)then
                
                if(buffData.shield == nil)then

                    local effs = buffData[BuffEvent_OnCreate];
                    if(effs ~= nil)then
                        for _,effData in ipairs(effs)do
                            if(effData.api == APIType.AddShield)then
                                buffData.shield = effData.shield;                                    
                            end
                        end
                    end
                
                end

                if(buffData.shield)then
                    left = left + buffData.shield;
                    self.maxHpDic = self.maxHpDic or {};
                    local uid = buff:UID();
                    self.maxHpDic[uid] = self.maxHpDic[uid] or buffData.shield;
                    max = max + self.maxHpDic[uid];
                end

            end
        end
    end
    --LogError( tostring(left) .. "/" .. tostring(max));
    return left,max; 
end
return this;