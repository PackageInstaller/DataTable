--编程限制条件元素
local  this={};
function this.New()
    this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
    return tab;
end

function this:Init(cfgId,limitNum,limitCond)
    self:InitCfg(cfgId);
end

function this:InitCfg(cfgId)
    -- LogError("TeamLimitCondition:"..tostring(cfgId));
    if cfgId~=nil and cfgId~="" then
        self.cfgId = tonumber(cfgId);
        self.cfg = Cfgs.CfgInfiniteTowerteamlimitedcondition:GetByID(self.cfgId);
        if self.cfg==nil then
            LogError("找不到CfgInfiniteTowerteamlimitedcondition配置！id = " .. cfgId);	
        end
    end
end

function this:GetID()
    return self.cfg and self.cfg.id or nil;
end

function this:GetLimitedType()
    return self.cfg and self.cfg.limitedtype or nil;
end

function this:GetLimitedVal()
    if self:GetLimitedType()==TeamConditionLimitType.CardID  then
        local isMainRole=false;
        for k,v in ipairs(g_InitRoleId) do
            if v==self.cfg.limtedtypeID then
                isMainRole=true;
                break;
            end
        end
        if isMainRole then --处理主角卡性别
            local sex=PlayerClient:GetSex();
            return g_InitRoleId[sex];
        end
    end
    return  self.cfg  and self.cfg.limitedtypeID  or nil;
end

--只编入和禁止编入两个为全局设置条件，最多编入和必须编入为单一设置条件，全局条件与具体的限制数量无关，对所有的卡牌有效,单一条件与具体的限制数量有关，只对满足条件的卡牌有效
function this:GetLimitedCond()
    return self.limitCond;
end

--检查传入的卡牌是否符合限制条件,这个方法不检测数量，只检测是否符合条件，数量检测在TeamLimit对象中进行判定
function this:CheckCard(cardData)
    local isPass=false;
    local errorCode=nil;
    if cardData==nil then
        LogError("TeamLimitCondition 传入参数错误！"..tostring(cardData==nil));
        return isPass,errorCode;
    end
    local limitType=self:GetLimitedType();
    local limitVal=self:GetLimitedVal();
    local roleInfo=cardData:GetCRoleData();
    if limitType==nil or limitVal==nil or  (roleInfo==nil and (limitType==TeamConditionLimitType.Faction or limitType==TeamConditionLimitType.TeamType or limitType==TeamConditionLimitType.Territory)) then
        -- LogError(cardData)
        -- LogError("TeamLimitCondition CheckCard中发现错误！"..tostring(limitType==nil).."\t"..tostring(limitVal==nil).."\t"..tostring(roleInfo==nil));
        return isPass,errorCode;
    end
    local tempVal=nil;
    if limitType==TeamConditionLimitType.CardID then  --卡牌ID
        isPass=cardData:GetCfgID()==limitVal;
        tempVal=cardData:GetCfgID();
    elseif limitType==TeamConditionLimitType.Quality then--稀有度
        isPass=cardData:GetQuality()==limitVal;
        tempVal=cardData:GetQuality();
    elseif limitType==TeamConditionLimitType.TeamType then--所属小队
        isPass=roleInfo:GetTeam()==limitVal;
        tempVal=roleInfo:GetTeam();
    elseif limitType==TeamConditionLimitType.RoleType then--角色定位
        local posInfo=cardData:GetPosEnum();
        tempVal="";
        if posInfo then
            for k,v in ipairs(posInfo) do
                tempVal=tempVal=="" and tostring(v) or tempVal..","..tostring(v);
                if v==limitVal then
                    isPass=true;
                    break;
                end
            end
        end
    elseif limitType==TeamConditionLimitType.CoreType then--核心类型
        isPass=cardData:GetMainType()==limitVal;
        tempVal=cardData:GetMainType();
    elseif limitType==TeamConditionLimitType.Territory then--地域
        isPass=roleInfo:GetBlood()==limitVal;
        tempVal=roleInfo:GetBlood();
    elseif limitType==TeamConditionLimitType.Faction then--所属
        isPass=roleInfo:GetBelonging()==limitVal;
        tempVal=roleInfo:GetBelonging();
    elseif limitType==TeamConditionLimitType.TeamItemNum then--队伍人数,需要与传入的数量做对比
        isPass=true;        
    elseif limitType==TeamConditionLimitType.LevelGreater then
        isPass=cardData:GetLv()>=limitVal;
        tempVal=cardData:GetLv();
        errorCode=49302
    elseif limitType==TeamConditionLimitType.LevelLess then
        isPass=cardData:GetLv()<=limitVal;
        tempVal=cardData:GetLv();
        errorCode=49302
    elseif limitType==TeamConditionLimitType.SuitType then --五件装备均为同一套装才算通过
        local equips=cardData:GetEquips();
        if equips~=nil and #equips==5 then
            isPass=true;
            for k,v in ipairs(equips) do
                if v:GetSuitID()~=limitVal then
                    isPass=false;
                    break;
                end
            end
        else
            isPass=false;
        end
    elseif limitType==TeamConditionLimitType.SuitQualityGreater then --装备品质，有空槽位也能通过测试
        local equips=cardData:GetEquips();
        if equips~=nil then
            isPass=true;
            for k,v in ipairs(equips) do
                if v:GetQuality()<limitVal then
                    isPass=false;
                    break;
                end
            end
        else
            isPass=true;
        end
        errorCode=49303
    elseif limitType==TeamConditionLimitType.SuitQualityLess then--装备品质，有空槽位也能通过测试
        local equips=cardData:GetEquips();
        if equips~=nil then
            isPass=true;
            for k,v in ipairs(equips) do
                if v:GetQuality()>limitVal then
                    isPass=false;
                    break;
                end
            end
        else
            isPass=true;
        end
        errorCode=49303
    elseif limitType==TeamConditionLimitType.SuitLevelGreater then--装备等级，有空槽位也能通过测试
        local equips=cardData:GetEquips();
        local lv=0;
        if equips~=nil then
            for k,v in ipairs(equips) do
                lv=lv+v:GetLv();
            end
        end
        isPass=lv>=limitVal;
        tempVal=lv;
        errorCode=49304
    elseif limitType==TeamConditionLimitType.SuitLevelLess then--装备等级，有空槽位也能通过测试
        local equips=cardData:GetEquips();
        local lv=0;
        if equips~=nil then
            for k,v in ipairs(equips) do
                lv=lv+v:GetLv();
            end
        end
        isPass=lv<=limitVal;
        tempVal=lv;
        errorCode=49304
    end
    -- LogError("条件ID："..tostring(self.cfg.id).."卡牌ID："..tostring(cardData:GetCfgID()).."\t限制类型："..tostring(limitType).."\t限制值："..tostring(limitVal).."\t当前值："..tostring(tempVal).."\t验证结果："..tostring(isPass))
    if isPass then
        return isPass
    else
        return isPass,errorCode;
    end
end

return this