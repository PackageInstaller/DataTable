local this={};

--编队条件
function this.New()
    this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
    return tab;
end

function this:Init(str)
    self.condition=str;
    self.conds={};
    if str~=nil and str~="" then
        --读取字符串中的条件ID
        local strs=StringUtil:Split(str,",");
        for k, v in ipairs(strs) do
            --解析条件
            local index=string.find(v,"[|&]");
            if index~=nil then
                local limitObj=TeamLimitGroup.New();
                limitObj:Init(v);
                table.insert(self.conds,limitObj);
            else
                -- LogError(v);
                local limitObj=TeamLimit.New();
                limitObj:Init(v);
                table.insert(self.conds,limitObj);
            end            
        end
    end
end

function this:GetID()
    return self.condition;
end

--检查卡牌是否满足条件
function this:CheckCard(teamData,cardData)
    local isPass=false;
    local errorCode=nil;
    if self.conds and teamData and cardData then
        local teamMemberNum=self:GetTeamMemberMaxNum();
        for k, v in ipairs(self.conds) do
            local result=false;
            result,errorCode=v:CheckCard(teamData,cardData);
            --检测当前还剩几个可以上阵的位置,当前条件检测为失效且还有其他位置可以任意放置时，继续检测，否则直接返回结果
            -- if result~=true then
            --     LogError("TeamCondition检测----------->失败\t 条件位置:"..tostring(k).."\t 总条件数:"..tostring(#self.conds).."\t")
            -- else
            --     LogError("TeamCondition检测----------->通过:\t 条件位置:"..tostring(k).."\t 总条件数:"..tostring(#self.conds))
            -- end
            if result~=true then
                isPass=false;
                if (teamMemberNum~=0 and (teamMemberNum-teamData:GetCount())<=1) or (teamMemberNum==0 and teamData:GetCount()>=g_TeamMemberMaxNum) or (#self.conds>1) then--不限数量则有6张卡可以上阵,条件数大于1则是筛选出条件的并集，否则继续进行判定
                    break;
                end
            elseif result and k==#self.conds then
                isPass=true;
            end
        end
        -- LogError("TeamCondition检测------------->卡牌ID："..tostring(cardData:GetCfgID()).."\t 是否通过："..tostring(isPass));
    end
    if isPass then
        return isPass
    else
        return isPass,errorCode;
    end
end

--返回当前限制下最多可以编入的队员数量，取最大值
function this:GetTeamMemberMaxNum()
    local limitNum=0;--是否限制了最大上阵人数，0为未限制
    for _,cond in ipairs(self.conds) do
        local count=0;
        if cond:GetClassType()=="TeamLimit" then
            count=cond:GetTeamLimitMemberNum();
        else
            for k,v in ipairs(cond.conds) do
                count=v:GetTeamLimitMemberNum();
                if count~=0 then
                    break;
                end
            end
        end
        if count~=0 then
            limitNum=count;
            break;
        end
    end
    return limitNum;
end

--检查队伍是否满足编程限制条件
function this:CheckPass(teamData)
    local isPass=false;
    if self.conds and teamData then
        for k, v in ipairs(self.conds) do
            local result=v:CheckPass(teamData);
            -- LogError(tostring(k).."\t"..tostring(result))
            if result~=true then
                isPass=false;
                break;
            elseif result and k==#self.conds then
                isPass=true;
            end
        end
    end
    return isPass;
end

function this:GetDesc()
    local list={};
    for k,v in ipairs(self.conds) do
        table.insert(list,v:GetDesc());
    end
    return list;
end

function this:Decode()
    --解析字符串成条件值
    -- LogError(self.condition)
    if self.condition~=nil and self.condition~="" then
        local list={};
        local tempList={};
        local  tempStr="";
        local lineNum=0;
        local lastNum=0;
        --判断分隔符位置
        --根据分隔符位置设置切割条件
        
        -- string.gsub(self.condition, '[^,|&]+', function(w)
        --     table.insert(tempList, w)
        -- end)
        -- for k, v in ipairs(tempList) do
        --     LogError(v);
        -- end
        -- for str in string.gmatch(self.condition, "[%z\1-\127\194-\244][\128-\191]*") do
        --     if lineNum<=2 and lineNum~=lastNum then
        --         table.insert(tempList,tempStr);    
        --     end
        --     if str=="," then
        --         lineNum=lineNum+1;
        --         if lineNum>2 then
        --             lineNum=1;
        --             table.insert(list,tempList);
        --             tempList={str};
        --         end
        --     else
        --         tempStr=tempStr..str;
        --     end
        -- end
    end
end

return this;