local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	
	return ins;
end

--角色
this.character = nil;

--独占特效
this.coverEffs = nil;
--轮播特效
this.orderEffs = nil;
--轮播特效间隔时间
local playOrderSpaceTime = 3000;

--初始化
function this:Init(character)
     if(self.character)then
        return;
    end

    self.character = character;
    --self.effs = {};--全部特效
    self.effsUniqueness = {};--唯一性特效

    self.coverEffs = {};
    self.orderEffs = {};

    self.bes = {};
end 

function this:Clean()
    self.effsUniqueness = nil;
    self.coverEffs = nil;
    self.orderEffs = nil;

    if(self.bes)then
        for _,be in ipairs(self.bes)do
            be.Remove();
        end
        self.bes = nil;
    end
end

--申请添加Buff特效
function this:ApplyBuffEff(key,caller)    
    if(not self.effsUniqueness)then
        return;
    end
    if(not self.character)then
        return;
    end

    if(key == nil)then
        LogError("添加Buff特效失败！key无效");    
        return;
    end
    local cfg = Cfgs.buff_effect:GetByKey(key);

    if(cfg == nil)then
        LogError("不存在Buff特效配置" .. key);    
        return;
    end
 
    local be = nil;
    if(cfg.uniqueness)then
        --唯一
        be = self.effsUniqueness[key];       
    end

    if(be == nil)then
        local go = CSAPI.CreateGO("BuffEff",0,0,0,self.character.GetBuffEffNode(cfg.attach));
        be = ComUtil.GetLuaTable(go);    
        
        --overload原因，先屏蔽，后续调整
        --self.character.SetBuffEffShowState(true);    
   end
   
   if(cfg.uniqueness)then
       self.effsUniqueness[key] = be;
   end

   be.SetCharacter(self.character);
   be.Set(cfg,caller);
   
   
   --处理播放模式
   local playEffs = self:GetPlayEffTable(cfg.play_model);
   if(playEffs)then
       local channel = be.GetPlayCannel();
       if(playEffs[channel] == nil)then
            playEffs[channel]  = {};
       end
       local t = playEffs[channel];
       t[be.GetKey()] = be;
   end   

--    LogError("添加buff特效=======");
--    LogError(cfg);

   self:UpdatePlayEffs();

   table.insert(self.bes,be);
   return be;
end
--移除buff特效
function this:RemoveBuffEff(be)
    local cfg = be.GetCfg();

    local playEffs = self:GetPlayEffTable(cfg.play_model);
   if(playEffs)then
       local channel = be.GetPlayCannel();
       if(playEffs[channel])then
            local t = playEffs[channel];
            t[be.GetKey()] = nil;
       end
   end

   if(self.effsUniqueness and self.effsUniqueness[cfg.key])then
        self.effsUniqueness[cfg.key] = nil;
   end

--    LogError("移除buff特效=======");
--    LogError(cfg);
   self:UpdatePlayEffs();
end
--获取播放特效表
function this:GetPlayEffTable(playModel)
    return nil;--取消轮播、独占buff
--    if(playModel == 1)then
--        return self.orderEffs;
--    elseif(playModel == 2)then
--        return self.coverEffs;
--    end
--    return nil;
end

--更新播放特效
function this:UpdatePlayEffs()
    self:UpdateCoverEff();
    self:ApplyPlayOrderEff();
end

function this:ApplyPlayOrderEff()
    if(self.isApplying)then
        return;
    end

    if(self:ExistPlayOrderEff() == false)then
        return;
    end

    self.isApplying = true;
    self:UpdateOrderEff();
    FuncUtil:Call(self.ApplyNextTimer,self,500);    
end

function this:ApplyNextTimer()
    self.isApplying = nil;
    if(IsNil(character.gameObject))then
        return;
    end
    self:ApplyPlayOrderEff();
end

--更新轮播特效
function this:UpdateOrderEff()
    if(self.orderEffs)then
        for channelId,channels in pairs(self.orderEffs)do
            
            if(channelId and self:IsPlayChannelCover(channelId) == false)then
                --频道没被占用

                local currKey = nil;
                local firstKey = nil;
                local targetKey = nil;

                if(channels)then
                
                    for key,be in pairs(channels)do
                       firstKey = firstKey or key;

                       if(currKey)then
                            if(targetKey == nil)then
                                targetKey = key;
                            end
                       elseif(be.IsShow())then
                            currKey = key;
                       end
                    end

                    targetKey = targetKey or firstKey;                    
                    self:SetPlayEffState(channels,targetKey);
                end
            else
                self:SetPlayEffState(channels,nil);
            end           

        end
    end
end

--function this:ShowTargetOrderEff(be)

--end

--更新独占特效
function this:UpdateCoverEff()    
    if(self.coverEffs)then      
        for _,channels in pairs(self.coverEffs)do
            local currPriority = -999;
            local currKey = nil;
            if(channels)then              
                for key,be in pairs(channels)do
                    local priority = be.GetPlayPriority();
                    if(priority > currPriority)then
                        currPriority = priority;
                        currKey = key;
                    end
                end
                self:SetPlayEffState(channels,currKey);
            end
        end
    end
end
--播放频道是否被占用
function this:IsPlayChannelCover(channelId)
    if(channelId and self.coverEffs and self.coverEffs[channelId])then
        for key,be in pairs(self.coverEffs[channelId])do
            if(be)then
                return true;
            end
        end
    end

    return false;
end

--是否存在轮播特效
function this:ExistPlayOrderEff()
    if(self.orderEffs)then
        for channelId,channels in pairs(self.orderEffs)do
            if(channels)then
                for key,be in pairs(channels)do
                    if(be)then
                        return true;
                    end
                end
            end
        end
    end
    return false;
end

function this:SetPlayEffState(list,showKey)
    if(list)then
        for key,be in pairs(list)do
            if(be)then
--                DebugLog("设置可见状态=======");
--                DebugLog(be.GetCfg());
                if(showKey and key == showKey)then
                    be.SetShowState(true);
                else
                    be.SetShowState(false);
                end
            end
        end
    end
end


return this;