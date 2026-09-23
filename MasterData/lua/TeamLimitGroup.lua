--编成限制组对象
local this={}

function this.New()
    this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
    return tab;
end

function this:Init(str)
    if str~=nil and str~="" then
        -- LogError("TeamLimitGroup:"..tostring(str));
        self.conds={};
        for key, val in pairs(TeamConditionOperator) do
            if string.find(str,val) then
                self.operator=TeamConditionOperator[key];
                break;
            end
        end
        local ids=StringUtil:Split(str,self:GetOperator());
        for _,c in ipairs(ids) do
            local limit=TeamLimit.New();
            limit:Init(c);
            table.insert(self.conds,limit);
        end
    end
end

--判断当前卡牌状态是否可以上阵到队伍中
function this:CheckCard(teamData,cardData)
    if teamData==nil or cardData==nil or self.conds==nil then
        LogError("TeamLimitGroup-------->检测："..tostring(self.cfg.id).."CheckCard传入的数据不得为空！param1:"..tostring(teamData==nil).."\tparam2:"..tostring(cardData==nil).."\tparam3:"..tostring(self.conds==nil));
        return
    end
    local result,errorCode=false,nil;
    for k, v in ipairs(self.conds) do
        local rlt,eCode=v:CheckCard(teamData,cardData)
        -- LogError("TeamLimitGroup-------->检测："..tostring(v.cfgId).."\t操作符："..tostring(self:GetOperator()).."\t结果："..tostring(rlt).."\t k："..tostring(k).."\t length："..tostring(#self.conds))
        if rlt and self:GetOperator()==TeamConditionOperator.Or then
            result=true;
            break;
        elseif self:GetOperator()==TeamConditionOperator.And then
            if rlt~=true then
                errorCode=errorCode==nil and eCode or errorCode;
                result=false;
                break;
            elseif rlt==true and k==#self.conds then
                result=true;
            end
        elseif rlt~=true then
            errorCode=errorCode==nil and eCode or errorCode;
        end
    end
    -- LogError("TeamLimitGroup-------->检测完毕："..tostring(result))
    if result then
        return result;
    else
        return result,errorCode;
    end
end

--检查队伍是否满足编程限制条件
function this:CheckPass(teamData)
    if teamData==nil or self.conds==nil then
        LogError("CheckPass传入的数据不得为空！param1:"..tostring(teamData==nil).."\tparam2:"..tostring(self.conds==nil));
        return
    end
    local result=false;
    for k, v in ipairs(self.conds) do
        local rlt=v:CheckPass(teamData)
        if rlt and self:GetOperator()==TeamConditionOperator.Or then
            result=true;
            break;
        elseif self:GetOperator()==TeamConditionOperator.And then
            if rlt~=true then
                result=false;
                break;
            elseif rlt==true and k==#self.conds then
                result=true;
            end
        end
    end
    return result;
end

function this:GetOperator()
    return self.operator;
end

function this:GetDesc()
    if self.conds==nil or #self.conds<=1 then
        return "";
    end
    if self:GetOperator()~=nil then
        local id=self:GetOperator()==TeamConditionOperator.Or and 49025 or 49026
        return LanguageMgr:GetByID(id,self.conds[1]:GetDesc(),self.conds[2]:GetDesc());
    else
        return "";
    end
end

function this:GetClassType()
    return  "TeamLimitGroup";
end

return this