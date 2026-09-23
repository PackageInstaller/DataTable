--助战排序
this={}

--根据角色排序
function this.SortByRoleTag(a,b,c1,c2)
    local teamData=TeamMgr:GetTeamData();
    if teamData then
        local a1=teamData:GetItemByRoleTag(c1:GetRoleTag())==nil and 2 or 1;
        local b2=teamData:GetItemByRoleTag(c2:GetRoleTag())==nil and 2 or 1;
        if a1~=b2 then
            return a1>b2
        end
    end
    return nil 
end

function this.SortByLv(a,b)
    if a.level~=b.level then
        return a.level>b.level
    end
    return nil
end

--根据登陆时间排序
function this.SortByLoginTime(a,b)
    if a.last_save_time~=b.last_save_time then
        return a.last_save_time>b.last_save_time
    end
    return nil
end

--根据好友状态排序 
function this.SortByState(a,b)
    if a.is_fls~=b.is_fls then
        local a1=a.is_fls==true and 2 or 1
        local b2=b.is_fls==true and 2 or 1
        return a1>b2;
    end
    return nil
end

function this.SortByID(a,b,c1,c2)
    if c1:GetCfgID()~=c2:GetCfgID() then
        return c1:GetCfgID()>c2:GetCfgID()
    end
    return nil
end

local SortFunc = {
	[1] = this.SortByState,
	[2] = this.SortByRoleTag,
	[3] = this.SortByLv,
	[4] = this.SortByLoginTime,
	[5] = this.SortByID,
}

function this.Sort(a,b)
    if SortFunc then
        for k,v in ipairs(SortFunc) do
            local c1 = CharacterCardsData(a.assist.card)
            local c2 = CharacterCardsData(b.assist.card)
            local val = v(a.assist, b.assist,c1,c2);
			if val~=nil then
				return val;
			end
        end
    end
end

function this.Sort2(a,b)
    if SortFunc then
        for k,v in ipairs(SortFunc) do
            local val = v(a:GetData().assist, b:GetData().assist,a,b);
			if val~=nil then
				return val;
			end
        end
    end
end

return this;