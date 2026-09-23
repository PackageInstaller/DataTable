--编成限制关联对象
local this={};
function this.New()
    this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
    return tab;
end

function this:Init(cfgId)
    --初始化配置表信息
    -- LogError("TeamLimit:"..tostring(cfgId));
    if cfgId~=nil and cfgId~="" then
        self.cfgId = tonumber(cfgId);
        self.cfg = Cfgs.CfgInfiniteTowerteamlimited:GetByID(self.cfgId);
        if self.cfg~=nil then
            --初始化条件列表
            self.conds={};
            for key, val in pairs(TeamConditionOperator) do
                if string.find(self.cfg.conditionID,val) then
                    self.operator=TeamConditionOperator[key];
                    break;
                end
            end
            local counts=self:GetLimitNums();
            counts=counts or {};
            local limits=self:GetLimitedCondition();
            limits=limits or {};
            if self:GetOperator()~=nil then
                local ids=StringUtil:Split(self.cfg.conditionID,self:GetOperator());
                for k, v in ipairs(ids) do
                    local cond=TeamLimitCondition.New();
                    local count=counts[k]~=nil and counts[k] or counts[1]
                    local limit=limits[k]~=nil and limits[k] or limits[1]
                    local isTotalCount=false; --是否两个条件共用同一个数量值
                    if limit==TeamConditionLimitEditType.Max and #counts==1 then
                        isTotalCount=true;
                    end
                    cond:Init(v);
                    table.insert(self.conds,{cond=cond,count=count,limit=limit,isTotalCount=isTotalCount});
                end
            else
                local cond=TeamLimitCondition.New();
                cond:Init(self.cfg.conditionID);
                table.insert(self.conds,{cond=cond,count=counts[1],limit=limits[1]});
            end
        else
            LogError("找不到CfgInfiniteTowerteamlimited配置！id = " .. cfgId);	
        end
    end
end

--返回计数值数组
function this:GetLimitNums()
    return self.cfg and self.cfg.count or nil;
end

--返回队伍限制之后最多编入的队员数，6为未限制
function this:GetTeamLimitMemberNum()
    local limitNum=6;--是否限制了最大上阵人数，6为未限制
    for k,v in ipairs(self.conds) do
        local condItem=v.cond;
        if condItem:GetLimitedType()==TeamConditionLimitType.TeamItemNum then
            limitNum=v.count;
            break;
        end
    end
    return limitNum;
end

--返回编入条件
function this:GetLimitedCondition()
    return self.cfg and self.cfg.limitedcondition or nil;
end

--检查卡牌限制和符合条件的卡牌数量是否与限制条件吻合
function this:CheckCard(teamData,cardData)
    local isPass=false;
    if teamData==nil or cardData==nil then
        LogError("TeamLimit CheckCard传入参数错误！"..tostring(teamData==nil).."\t"..tostring(cardData==nil));
        return isPass;
    end
    --检查队伍是否满足编成限制条件
    local limitNum=self:GetTeamLimitMemberNum();
    -- local isPass2=self:CheckPass(teamData);
    local realCount=teamData:GetCount();
    local errorCode=nil;
    -- LogError("TeamLimit检测----------->"..tostring(self.cfg.id).."队伍限制上阵人数："..tostring(limitNum).."\t 队伍检测："..tostring(isPass2))
    -- if isPass2 and (realCount<limitNum or limitNum==0) then --当前已经满足限制条件且还有空位
    if (realCount<limitNum or limitNum==6) then --当前未满足上阵条件
        local passMemberNum=0;
        local passNum=0;--通过的条件个数
        for k, v in ipairs(self.conds) do
            local condItem=v.cond;
            local tempResult,eCode=condItem:CheckCard(cardData);
            if tempResult~=true and errorCode==nil then
               errorCode=eCode 
            end
            --对结果做处理
            if v.limit==TeamConditionLimitEditType.Dis then --禁止编入取相反的结果值
                tempResult=not tempResult;
            elseif v.limit==TeamConditionLimitEditType.Max then --最多编入,要判断是否超过上限值，满足之后其余不符合条件的卡牌也返回true
                local num=self:GetMemberNumByLimit(teamData,condItem);
                local targetCount=v.count; --目标数量
                if v.isTotalCount then --多个条件共用一个数量时
                    if tempResult then
                        passMemberNum=passMemberNum+num+1;
                        targetCount=targetCount-passMemberNum-1;
                    else
                        passMemberNum=passMemberNum+num;
                        targetCount=targetCount-passMemberNum;
                    end
                else
                    passMemberNum=tempResult and passMemberNum+num+1 or passMemberNum+num;
                    targetCount=targetCount-passMemberNum;
                end
                -- LogError("最多编入卡牌:"..tostring(self.cfg.id).."\t目标数："..tostring(targetCount).."\t当前队伍中的数量："..tostring(num).."\t是否并集："..tostring(v.isTotalCount).."\t当前卡牌通过限制的数量："..tostring(passNum).."\t已经符合的队员数："..tostring(passMemberNum).."\t"..tostring(tempResult).."\t"..tostring(limitNum-realCount));
                if targetCount<0 then
                    tempResult=false;
                elseif targetCount==0 then--当前队伍已经满足必须编入的值且该卡牌不符合所有条件
                    if (v.isTotalCount and passNum<=0 and k==#self.conds and tempResult~=true) then
                        tempResult=true;
                    elseif v.isTotalCount~=true and tempResult~=true then
                        tempResult=true;
                    end
                elseif ((limitNum-realCount)>targetCount and tempResult==true) or (targetCount>0 and tempResult~=true) then --还有多余的空位时
                    tempResult=true;
                end
            elseif v.limit==TeamConditionLimitEditType.Must then --必须编入，如果已经符合队伍需求时，其余卡牌的检测会返回true
                local num=self:GetMemberNumByLimit(teamData,condItem);
                local targetCount=v.count; --目标数量
                if v.isTotalCount then --多个条件共用一个数量时
                    if tempResult then
                        passMemberNum=passMemberNum+num+1;
                        targetCount=targetCount-passMemberNum-1;
                    else
                        passMemberNum=passMemberNum+num;
                        targetCount=targetCount-passMemberNum;
                    end
                else
                    targetCount=targetCount-num;
                end
                -- LogError("必须编入:"..tostring(self.cfg.id).."\t"..tostring(targetCount).."\t"..tostring(num));
                if targetCount<=0 then
                    tempResult=true;
                elseif (limitNum-realCount)>targetCount then --还有多余的空位时
                    tempResult=true;
                end
            end
            passNum=tempResult==true and passNum+1 or passNum;
            -- LogError("TeamLimit检测22222----------->"..tostring(tempResult).."\t"..tostring(v.limit).."\t"..tostring(self:GetOperator()));
            if self:GetOperator()==TeamConditionOperator.And then
                if tempResult~=true then
                    isPass=false;
                    break;
                elseif tempResult==true and k==#self.conds then
                    isPass=true;
                    break;
                end
            elseif (self:GetOperator()==TeamConditionOperator.Or or self:GetOperator()==nil) and tempResult==true then
                isPass=true;
                break;
            end
        end
    end
    if isPass then
        return isPass
    else
        return isPass,errorCode
    end
end

--根据限制条件返回队伍中符合的条件的卡牌数量
function this:GetMemberNumByLimit(teamData,limit)
    local num=0;
    if teamData and teamData:GetCount()>0 and limit then
        for k,v in ipairs(teamData.data) do
            local card=v:GetCard();
            if limit:CheckCard(card) then
                num=num+1;
            end
        end
    end
    return num;
end

--检查队伍是否满足编成限制条件
function this:CheckPass(teamData)
    local isPass=false;
    if teamData==nil then
        LogError("TeamLimit CheckPass传入参数错误！"..tostring(teamData==nil));
        return isPass;
    end
    if teamData:GetRealCount()<=0 then
        return isPass;
    end
    local lastNum=0;
    --根据计数方式和数量判定是否有限制条件满足
    for k, v in ipairs(self.conds) do
        local condItem=v.cond;
        local num=self:GetMemberNumByLimit(teamData,condItem);
        local isTrueNum=false;
        local targetCount=v.count; --目标数量
        if v.isTotalCount then --多个条件共用一个数量时
            targetCount=targetCount-lastNum;
            lastNum=num;
        end
        --数量验证
        if v.limit==TeamConditionLimitEditType.Only then--只编入
            if condItem:GetLimitedType()~=TeamConditionLimitType.TeamItemNum then --队伍人数例外
                targetCount=teamData:GetCount();--全局限制
            end
            isTrueNum=num==targetCount and true or false;
        elseif v.limit==TeamConditionLimitEditType.Dis then --禁止编入，全局
            if condItem:GetLimitedType()~=TeamConditionLimitType.TeamItemNum then  --只要非队伍人数且通过验证的数量大于1，则返回false
                if num>0 then
                    isTrueNum=false;
                    isPass=false;
                    break;
                else
                    isTrueNum=true;
                end
            end
        elseif v.limit==TeamConditionLimitEditType.Max then --最多编入
            isTrueNum=num<=targetCount and true or false;
        elseif v.limit==TeamConditionLimitEditType.Must then --必须编入
            isTrueNum=num>=targetCount and true or false;
        end
        -- LogError("队伍限制条件检测：目标数量："..tostring(targetCount).."\t当前数量："..tostring(num).."\t当前限制条件："..tostring(v.limit).."\t"..tostring(isTrueNum));
        if isTrueNum then
            if self:GetOperator()==TeamConditionOperator.Or then
                isPass=true;
                break;
            elseif self:GetOperator()==TeamConditionOperator.And and k==#self.conds then
                isPass=true;
            elseif self:GetOperator()==nil then
                isPass=true;
            end
        else
            if self:GetOperator()==TeamConditionOperator.And then
                isPass=false;
                break;
            end
        end
    end
    return isPass;
end


function this:GetDesc()
    if self.cfg.CfgLanguageID then
        return LanguageMgr:GetByID(self.cfg.CfgLanguageID);
    else
        LogError("未配置限制条件多语言信息！");
        LogError(self.cfg);
    end
    return "";
end

function this:GetClassType()
    return  "TeamLimit";
end

function this:GetOperator()
    return  self.operator;
end

return this