--卡牌技能自动战斗配置类,记录了一张卡牌所有技能的预设值
local this={};

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

--_d格式：{cid=卡牌ID,index=该卡牌的预设下标,tStrategyData=详细配置}
function this:SetData(_d)
    self.data=_d;
end

--返回关联卡牌（如果有的话）
function this:GetCard()
    if self.data and self.data.cid then
        return FormationUtil.FindTeamCard(self.data.cid);
    end
end

function this:GetData()
    return self.data;
end

--返回所有的配置数据
function this:GetStrategyData()
    return self.data and self.data.tStrategyData or {{},{},{},true};
end

--设置指定技能的值
function this:SetSkillPreset(skillID,_d)
    if skillID and _d and self.data then
        local skillList=self:GetCardSkills();
        if skillList then
            for k,v in ipairs(skillList) do
                if v.id==skillID then
                    self.data.tStrategyData=self.data.tStrategyData or {};
                    if v.upgrade_type<=4 then
                        self.data.tStrategyData[v.upgrade_type]=_d;
                    else
                        self.data.tStrategyData[4]=_d;
                    end
                end
            end
        end
    end
end

--返回当前预设的索引
function this:GetIndex()
    if self.data and self.data.index then
        return self.data.index;
    end
end

function this:SetIsOverLoad(isOn)
    if self.data then
        self.data.tStrategyData=self.data.tStrategyData or {};
        self.data.tStrategyData.bOverLoad=isOn; 
    end
end

--是否使用OVERLOAD
function this:IsOverLoad()
    local isOver=true;
    if self.data and self.data.tStrategyData then
        return self.data.tStrategyData.bOverLoad;
    end
    return isOver;
end

--返回技能预设数据 返回CardSkillPreset对象数组
function this:GetSkillPresets()
    local list=nil;
    if self.data then
        local skillList=self:GetCardSkills();
        if skillList then
            list={};
            for k,v in ipairs(skillList) do
                local tab=CardSkillPreset.New();
                tab:SetCfgID(v.id);
                local index=v.upgrade_type>=4 and 4 or v.upgrade_type; --大于4的技能类型暂时按4算
                if self.data.tStrategyData and self.data.tStrategyData[index] then
                    tab:SetData(self.data.tStrategyData[index]);
                else
                    tab:SetData(tab:GetDefaultConfigs());
                end
                -- if v.upgrade_type then
                --     table.insert(list,v.upgrade_type,tab);
                -- else
                    table.insert(list,tab);
                -- end
            end
        end
    end
    return list;
end

--返回卡牌的技能数组，不包括OVERLOAD技能
function this:GetCardSkills()
    local list=nil;
    local card=self:GetCard();
    if card then
        list={};
        local cardCfg=card:GetCfg();
        for k,v in ipairs(cardCfg.jcSkills) do
            local cfg = Cfgs.skill:GetByID(v)
            if cfg and cfg.upgrade_type~=CardSkillUpType.OverLoad then --OverLoad不返回
                table.insert(list,cfg.upgrade_type,cfg);
            end
        end
        if cardCfg.tcSkills then
            for k,v in ipairs(cardCfg.tcSkills) do
                local cfg = Cfgs.skill:GetByID(v)
                if cfg and cfg.upgrade_type~=CardSkillUpType.OverLoad then --OverLoad不返回
                    -- if cfg.upgrade_type then
                    --     table.insert(list,cfg.upgrade_type,cfg);
                    -- else
                        table.insert(list,cfg);
                    -- end
                end
            end
        end
    end
    return list;
end

function this:IsEqual(prefab)
    if self.data and prefab then
        local d=prefab.data;
        if d.cid==self.data.cid and d.index==self.data.index and self:IsOverLoad()==prefab:IsOverLoad() then
            local skillCon=d.tStrategyData;
            if next(skillCon) then
                for k,v in ipairs(self.data.tStrategyData) do
                    if skillCon[k] then
                        for key,val in ipairs(v) do
                            if skillCon[k][key]==nil or val~=skillCon[k][key] then
                                return false
                            end
                        end
                    end
                end
                return true;
            end
        end
    end
    return false;
end

return this;