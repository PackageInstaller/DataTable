local this = MgrRegister("AIStrategyMgr")

function this:Init()
    self.edits={};
    self.assistPrefs={};
end

--index:AI策略索引
function this:AddData(cid, index, tStrategyData)
    if cid and index and tStrategyData then
        self.data = self.data or {};
        if next(tStrategyData) then -- 有值才缓存
            local tab = CardAIPreset.New();
            tab:SetData({
                cid = cid,
                index = index,
                tStrategyData = tStrategyData
            });
            self.data[cid] = self.data[cid] or {};
            self.data[cid][index] = tab;
        end
    end
end

-- 返回指定卡牌已经设置过的AI预设方案
function this:GetListByCid(cid)
    if cid and self.data and self.data[cid] then
        return self.data[cid];
    end
    return nil;
end

-- 返回指定卡牌的第几套预设AI数据 realIndex:AI索引 isNew:复制一份数据而不是直接获取引用
function this:GetData(cid, realIndex, isNew)
    if cid==nil or realIndex==nil then
        return
    end
    if self.data and self.data[cid] and self.data[cid][realIndex] then
        if isNew then
            local tab = CardAIPreset.New();
            local tStrategyData = {};
            for k, v in ipairs(self.data[cid][realIndex]:GetStrategyData()) do
                local list = {};
                for _, val in ipairs(v) do
                    table.insert(list, val);
                end
                table.insert(tStrategyData, list);
            end
            tStrategyData.bOverLoad = self.data[cid][realIndex]:IsOverLoad();
            tab:SetData({
                cid = cid,
                index = realIndex,
                tStrategyData = tStrategyData
            });
            return tab;
        else
            return self.data[cid][realIndex];
        end
    end
end

-- 返回指定卡牌的默认技能预设配置 realIndex:int AI索引
function this:GetDefaultConfig(cid, realIndex)
    if  cid and realIndex then
        local card = FormationUtil.FindTeamCard(cid);
        if card then
            local list = {};
            local cardCfg = card:GetCfg();
            for k, v in ipairs(cardCfg.jcSkills) do
                local cfg = Cfgs.skill:GetByID(v)
                if cfg and cfg.upgrade_type ~= CardSkillUpType.OverLoad then -- OverLoad不返回
                    local tab = CardSkillPreset.New();
                    tab:SetCfgID(v);
                    local defaults=tab:GetDefaultConfigs();
                    if defaults~=nil then
                        table.insert(list, cfg.upgrade_type, defaults);
                    else
                        LogError("未在自动战斗表中配置该技能默认值:"..tostring(v));
                    end
                end
            end
            if cardCfg.tcSkills then
                for k, v in ipairs(cardCfg.tcSkills) do
                    local cfg = Cfgs.skill:GetByID(v)
                    if cfg and cfg.upgrade_type ~= CardSkillUpType.OverLoad then -- OverLoad不返回
                        local tab = CardSkillPreset.New();
                        tab:SetCfgID(v);
                        -- Log(cfg.upgrade_type.."\t"..tostring(#list))
                        local defaults=tab:GetDefaultConfigs();
                        if defaults~=nil then
                            table.insert(list,  defaults);
                        else
                            LogError("未在自动战斗表中配置该技能默认值:"..tostring(v));
                        end
                        -- end
                    end
                end
            end
            local tab = CardAIPreset.New();
            list.bOverLoad = g_OverLoadActivate==nil and false or g_OverLoadActivate==1;
            tab:SetData({
                cid = cid,
                index = realIndex,
                tStrategyData = list
            });
            return tab;
        end
    end
    return nil;
end

--无效代码
-- -- 保存预设方案 teamIndex:队伍ID，cardIndex:卡牌在队伍中的下标 cardAIPreset：卡牌预设配置 bApply:是否在保存时使用该方案
-- function this:SavePreset(teamIndex, cardIndex, cardAIPreset, bApply)
--     if teamIndex and cardIndex and cardAIPreset then
--         PlayerProto:SetAIStrategy(teamIndex, cardIndex, cardAIPreset:GetIndex(), cardAIPreset:GetStrategyData(), bApply);
--     end
-- end

-- -- 使用预设方案
-- function this:UsePreset(teamIndex, cardIndex)
--     if teamIndex and cardIndex then
--         local realIndex=FormationUtil.GetOrderByTeamIndex(teamIndex)
--         PlayerProto:SwitchAIStrategy(teamIndex, cardIndex, realIndex);
--     end
-- end
---

function this:FightUsePreset(dupIndex,oid,data)
    if dupIndex and oid and data then
        FightProto:SwitchAIStrategy(dupIndex, oid, data);
    end
end

function this:Clear()
    self.data = nil;
    self.edits=nil;
    self.assistPrefs=nil;
end

--返回临时数据，没有临时数据则返回当前的数据
function this:GetEditData(cid,teamIndex)
    if cid==nil or teamIndex==nil then
        return
    end
    local realIndex=FormationUtil.GetOrderByTeamIndex(teamIndex);
    if self.edits and self.edits[cid] and self.edits[cid][realIndex] then
        return self.edits[cid][realIndex].data;
    else
        local teamData=TeamMgr:GetTeamData(teamIndex,true);
        self.edits = self.edits or {};
        local teamItem=teamData:GetItem(cid);
        local tab=self:GetData(cid,realIndex,true);
        if tab==nil then
            tab=self:GetDefaultConfig(cid,realIndex);
        end
        self.edits[cid] = self.edits[cid] or {};
        self.edits[cid][realIndex] = {data=tab,teamIndex=teamIndex,itemIdx=teamItem and teamItem:GetIndex() or nil};
        return self.edits[cid][realIndex].data;
    end
end

--- func desc保存编辑的临时数据
function this:SaveEditData()
    local list=self:GetChangeList();
    if list and next(list) then
        PlayerProto:SetAIStrategy(list);
        return true;
    end
    return false;
end

--- func 清理缓存的编辑数据
---@param isSaveLocal bool 是否同步到本地数据
function this:ClearEditData(isSaveLocal)
    if isSaveLocal then
        for cid,v in pairs(self.edits) do
            for realIndex, val in pairs(v) do
                self:AddData(cid,realIndex,val.data:GetStrategyData());
            end
        end
    end
    self.edits=nil;
end

--- func 返回编辑过的列表
function this:GetChangeList()
    if self.edits then
        local list={};
        for cid,v in pairs(self.edits) do
            for realIndex, val in pairs(v) do
                if val.teamIndex==nil or val.itemIdx==nil then
                    LogError("未找到对应卡牌的队伍下标和索引");
                    return;
                end
                local c1=AIStrategyMgr:GetData(cid,realIndex,true);
                if c1==nil then  
                    c1=AIStrategyMgr:GetDefaultConfig(cid,realIndex);
                end
                if val.data:IsEqual(c1)~=true then --有修改则记录
                    local tab={};
                    tab.nTeamIndex=val.teamIndex;
                    tab.nCardIndex=val.itemIdx;
                    tab.nStrategyIndex=realIndex;
                    tab.tStrategyData=val.data:GetStrategyData();
                    tab.bApply=true;
                    table.insert(list,tab)
                end
            end
        end
        return list;
    end 
    return nil;
end

--- func 设置助战卡的AI预设
function this:SetAssistAIPrefs(cid,teamIndex,tStrategyData)
    self.assistPrefs=self.assistPrefs or {};
    if cid and teamIndex and tStrategyData then
        local tab = CardAIPreset.New();
        tab:SetData({
            cid = cid,
            index = 1,
            tStrategyData = tStrategyData
        });
        self.assistPrefs[teamIndex]=self.assistPrefs[teamIndex] or {};
        self.assistPrefs[teamIndex][cid]=tab;
    end
end

--- func 设置助战卡的AI预设 hasDefault：没有数据时是否返回默认值
function this:GetAssistAIPrefs(cid,teamIndex,hasDefault)
    if cid==nil or teamIndex==nil then
        return nil;
    end
    if self.assistPrefs and self.assistPrefs[teamIndex] and self.assistPrefs[teamIndex][cid] then
        return self.assistPrefs[teamIndex][cid]
    else
        self.assistPrefs[teamIndex]={};
        self.assistPrefs[teamIndex][cid]= self:GetDefaultConfig(cid,1);
    end
    return hasDefault and self.assistPrefs[teamIndex][cid] or nil;
end

function this:ClearAssistAIPrefs()
    self.assistPrefs={};
end

return this;
