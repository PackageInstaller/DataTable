--特殊勘探活动数据
local this = {}

function this.New()
    this.__index = this.__index or this
    local tab = {}
    setmetatable(tab, this)
    return tab
end

function this:SetCfg(cfgId)
    if (cfgId == nil) then
        LogError("初始化勘探配置数据失败！无效配置id")
    end
    if (self.cfg == nil) then
        self.cfg = Cfgs.CfgExtraExploration:GetByID(cfgId)
    end
end

function this:SetData(_d)
    self.data=_d;
    self.reviceList={};
    if self.data then
        self:SetCfg(self.data.id);
        if self.data.gets then
            for k,v in ipairs(self.data.gets) do
                local idx=v>=#self.cfg.item and #self.cfg.item or v;
                self.reviceList[idx]=v;--下标只到配置最后一级，值映射领取过的次数
            end
        end
    end
end

function this:UpdateGets(gets)
    if gets and self.data then
        self.data.gets=self.data.gets or {}
        self.reviceList=self.reviceList or {};
        for k, v in ipairs(gets) do
            table.insert(self.data.gets,v);
            local idx=v>=#self.cfg.item and #self.cfg.item or v;
            self.reviceList[idx]=v;
        end
    end
end

function this:GetRewardState(idx)
    if idx then
        --判断是否是最后一个值
        local realIdx=idx>=#self.cfg.item and #self.cfg.item or idx;
        local isRevice=self.reviceList[realIdx]~=nil;
        if self.cfg and self.cfg.item and self.cfg.item[realIdx] then
            local cfg=self.cfg.item[realIdx];
            if cfg.isInfinite then --无限次领取的
                local upExp=self.cfg.item[realIdx-1] and self.cfg.item[realIdx-1].exp or 0;
                local num=math.floor((self:GetCurrExp()-upExp)/cfg.exp);
                local rNum=isRevice and self.reviceList[realIdx]-realIdx+1 or 0;
                if num>rNum then
                    return 2;
                else
                    return 1;
                end
            elseif isRevice then
                return 3;
            elseif self:GetCurrExp()>=self.cfg.item[realIdx].exp then
                return 2;
            else
                return 1;
            end
        else
            return 1;
        end
    end
end

function this:GetCurrLv()
    local exp=self:GetCurrExp();
    local lv=0;
    if self.cfg and self.cfg.item then
        local upExp=0;
        for k, v in ipairs(self.cfg.item) do
            if k==#self.cfg.item then
                upExp=self:GetLevelUpExp(k-1);
                if exp>upExp then
                    lv=k;
                    break;
                end
            else
                upExp=v.exp;
            end
            if (k<#self.cfg.item and upExp>exp) or (k==#self.cfg.item and upExp>=exp) then
                lv=k;
                break;
            end
        end
    end
    return lv;
end

function this:GetID()
    return self.cfg and self.cfg.id or nil;
end

function this:GetCurrExp()
    return self.data and self.data.total or 0;
end

function this:IsMaxLv()
    local curExp=self:GetCurrExp();
    if self.cfg and self.cfg.item then
        local fullExp=0;
        for i=#self.cfg.item,1,-1 do
            if not self.cfg.item[i].isInfinite then
                fullExp=self.cfg.item[i].exp;
                break;
            end
        end
        return curExp>=fullExp;
    end
    return false;
end

--返回上一级的配置表
function this:GetUpLvCfg(_lv)
    local cfg=nil;
    local curLv=_lv or self:GetCurrLv();
    if self.cfg and self.cfg.item and curLv>1 then
        cfg=self.cfg.item[curLv-1];
    end
    return cfg;
end

function this:GetCurrExpPercent()
    local percent=0;
    local upCfg=self:GetUpLvCfg();
    local upExp=self:GetLevelUpExp();
    local currExp=self:GetCurrExp();
    if currExp==0 then
        return percent;
    end
    if upCfg and upExp then
        percent=(currExp-upCfg.exp)/(upExp-upCfg.exp);
        -- LogError("111111111111:"..tostring(currExp).."\t"..tostring(upExp).."\t"..tostring(upCfg.exp).."\t"..tostring(percent))
    elseif upExp then
        percent=currExp/upExp;
    end
    return percent;
end

function this:GetLevelUpExp(_lv)
    local lv=_lv or self:GetCurrLv();
    if self.cfg and self.cfg.item then
        local expCfg=self.cfg.item[lv];
        if lv==#self.cfg.item and expCfg and expCfg.isInfinite then--无限领取,动态计算升级经验
            local upExpCfg=self:GetUpLvCfg(_lv);
            local upExp=upExpCfg and upExpCfg.exp or 0;
            local idx=lv;
            if self.reviceList and self.reviceList[idx] then
                idx=self.reviceList[idx]+1;--下一级的级数
            end
            local realExp=(upExp+(idx-lv+1)*expCfg.exp);
            return realExp;
        else
            return self.cfg.item[lv].exp;
        end
    end
    return 0;
end

function this:GetEndTime()
    return self.cfg and self.cfg.endTime or nil;
end

function this:GetStartTime()
    return self.cfg and self.cfg.startTime or nil;
end

function this:IsOpen()
    local sTime=0;
    local eTime=0;
    if self:GetStartTime() then
        sTime=TimeUtil:GetTimeStampBySplit(self:GetStartTime());
    end
    if self:GetEndTime() then
        eTime=TimeUtil:GetTimeStampBySplit(self:GetEndTime());
    end
    if sTime==0 or eTime==0  then
        return true;
    elseif  (sTime==0 or (sTime~=0 and TimeUtil:GetTime() >sTime)) and (eTime==0 or eTime~=0 and (TimeUtil:GetTime() <eTime)) then
        return true;
    end
    return false;
end

function this:GetRewardCfgs(isSpecial,hasInfinite)
    local list={}
    local lessLv=nil;
    if self.cfg then
        for i=1,#self.cfg.item do
            if (self.cfg.item[i].isInfinite==true and hasInfinite) or (self.cfg.item[i].isInfinite~=true and hasInfinite~=true) then
                if self.cfg.item[i].tag~=nil and isSpecial==true then
                    table.insert(list,self.cfg.item[i])
                elseif isSpecial~=true then
                    table.insert(list,self.cfg.item[i])
                end
            end
            if lessLv==nil and self:GetRewardState(i)==2 then
                lessLv=i
            end
        end  
    end
    return list,lessLv;
end

--返回当前显示的阶段性奖励等级
function this:GetFixedSPCfg(exp)
    local currExp=exp or self:GetCurrExp();
    local list={};
    local index=1;
    if self.cfg then
        for i=1,#self.cfg.item do
            if self.cfg.item[i].tag then
                table.insert(list,self.cfg.item[i])
                if self.cfg.item[i].exp<=currExp then
                    index=index+1;
                end
            end
        end  
    end
    index=index>#list and #list or index;
    return list[index];
end

function this:GetFixedSPCfgByLv(lv)
    local currExp=lv or self:GetCurrLv();
    local list={};
    local index=1;
    if self.cfg and self.cfg.item then
        for i=1,#self.cfg.item do
            if self.cfg.item[i].tag then
                table.insert(list,self.cfg.item[i])
                if self.cfg.item[i].index<=currExp then
                    index=index+1;
                end
            end
        end  
    end
    index=index>#list and #list or index;
    return list[index];
end

function this:GetDesc()
    local str="";
    if self.cfg and self.cfg.des then
        str=LanguageMgr:GetByID(self.cfg.des)
    end
    return str;
end

function this:GetName()
    return self.cfg and self.cfg.name or ""
end

function this:Jump()
    if self.cfg and self.cfg.jump then
        JumpMgr:Jump(self.cfg.jump);
    end
end

--是否有未领取的
function this:HasRevice()
    local hasRevice=false;
    if self.data then
        local currLv=self:GetCurrLv();
        if self.reviceList and currLv>1 then
            for i=1,currLv-1 do 
                if self.reviceList[i]==nil then
                    hasRevice=true;
                    break;
                end
            end
            if self.cfg and currLv==#self.cfg.item and hasRevice~=true then--最后一级
                local state=self:GetRewardState(currLv);
                hasRevice=state==2;
            end
        elseif currLv>1 and (self.reviceList==nil or (self.reviceList and #self.reviceList==0)) then
            hasRevice=false;
        end
    end
    return hasRevice;
end

-- 返回当前无限领取档的可领取次数
function this:GetLoopReviceNum()
    local currLv = self:GetCurrLv();
    if self.cfg and self.cfg.item and currLv==#self.cfg.item and self.cfg.item[currLv] and self.reviceList then
        local cfg = self.cfg.item[currLv];
        local isRevice=self.cfg.item[currLv]~=nil;
        if cfg.isInfinite then -- 无限次领取的
            local upExp = self.cfg.item[currLv - 1] and self.cfg.item[currLv - 1].exp or 0;
            local num = math.floor((self:GetCurrExp() - upExp) / cfg.exp);
            local tNum=self.reviceList[currLv] and self.reviceList[currLv] or #self.cfg.item
            local rNum = isRevice and  - currLv + 1 or 0;
            if num > rNum then
                return num-rNum;
            end
        end
    end
    return 0;
end

--返回UI替换内容
function this:GetUIChange()
    return self.cfg and self.cfg.uiChange or nil;
end

return this;