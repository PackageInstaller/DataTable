local this = {};

-- 获取当前的数据
function this.GetCurrNum(type, target, num)
    local count = num;
    if type == DungeonStarType.MoveNum and (num > target or num < 0) then -- 未达成时直接读取步数
        count = BattleMgr:GetStepNum();
    elseif type == DungeonStarType.BoxNum and (num < 0 or num < target) then
        count = BattleMgr:GetBoxNum();
    elseif type == DungeonStarType.KillMonsterNum and (num < 0 or num < target) then
        count = BattleMgr:GetKillCount();
    end
    return count;
end

function this.GetInfo(type, target, num, isEnterFight)
    local info = {};
    if isEnterFight then
        local starTips = {15056, 15063, 15083, 15084}
        if type == FightStarType.Pass then
            info = {
                tips = LanguageMgr:GetByID(starTips[type], num, target),
                isComplete = num >= target
            };
        elseif type == FightStarType.DeathNum then
            info = {
                tips = target > 0 and LanguageMgr:GetByID(starTips[type], target) or LanguageMgr:GetByID(25039),
                isComplete = num >= 0 and num <= target or false
            };
        else
            info = {
                tips = LanguageMgr:GetByID(starTips[type], target),
                isComplete = num >= 0 and num <= target or false
            };
        end
    else
        local starTips = {15056, 15057, 15058, 15059, 15060, 15061, 15062, 15063, 15064, 15065}
        if type == DungeonStarType.MoveNum or type == DungeonStarType.DeathNum or type == DungeonStarType.TeamNum then -- 条件类型为5
            info = {
                tips = LanguageMgr:GetByID(starTips[type], target),
                isComplete = num >= 0 and num <= target or false
            };
        else
            info = {
                tips = LanguageMgr:GetByID(starTips[type], num, target),
                isComplete = num >= target
            };
        end
    end
    return info;
end

-- 返回星级信息（已达成的） 需要计算 isLocal:是否查询本地数据
function this.GetStarInfo(dungeonID, completeNums, isLocal)
    local infos = {};
    completeNums = completeNums or {};
    if dungeonID then
        local cfg = Cfgs.MainLine:GetByID(dungeonID);
        local isEnterFight = false -- 直接战斗
        if cfg then
            isEnterFight = cfg.nGroupID ~= nil and cfg.nGroupID ~= ""
            for i = 1, 3 do
                local star = cfg["star" .. i];
                if star then
                    local num = completeNums[i] or -1;
                    if isLocal == true then
                        num = this.GetCurrNum(star[1], star[2], num);
                    end
                    local info = nil
                    if i == 1 then
                        local winCons = {15073, 15050, 15051, 15052, 15053, 15054}
                        info = {
                            tips = LanguageMgr:GetByID(15056, LanguageMgr:GetByID(winCons[star[1]])),
                            isComplete = num >= star[2]
                        };
                    else
                        info = this.GetInfo(star[1], star[2], num, isEnterFight);
                    end
                    table.insert(infos, info);
                end
            end
        end
    end
    return infos;
end

function this.GetInfo2(type, target, num, isEnterFight)
    local info = {};
    if isEnterFight then
        local starTips = {15056, 15063, 15083, 15084, 15110}
        if type == FightStarType.Pass then
            info = {
                tips = LanguageMgr:GetByID(starTips[type], num, target),
                isComplete = num > 0
            };
        elseif type == FightStarType.DeathNum then
            info = {
                tips = target > 0 and LanguageMgr:GetByID(starTips[type], target) or LanguageMgr:GetByID(25039),
                isComplete = num > 0
            };
        else
            info = {
                tips = LanguageMgr:GetByID(starTips[type], target),
                isComplete = num > 0
            };
        end
    else
        local starTips = {15056, 15057, 15058, 15059, 15060, 15061, 15062, 15063, 15064, 15065}
        if type == DungeonStarType.MoveNum or type == DungeonStarType.DeathNum or type == DungeonStarType.TeamNum then -- 条件类型为5
            info = {
                tips = LanguageMgr:GetByID(starTips[type], target),
                isComplete = num > 0
            };
        else
            info = {
                tips = LanguageMgr:GetByID(starTips[type], num, target),
                isComplete = num > 0
            };
        end
    end
    return info;
end

-- 返回星级信息（已达成的） 大于0时默认完成
function this.GetStarInfo2(dungeonID, completeNums)
    local infos = {};
    completeNums = completeNums or {};
    if dungeonID then
        local cfg = Cfgs.MainLine:GetByID(dungeonID);
        local isEnterFight = false -- 直接战斗
        if cfg then
            isEnterFight = cfg.nGroupID ~= nil and cfg.nGroupID ~= ""
            for i = 1, 3 do
                local star = cfg["star" .. i];
                local num = completeNums[i] or 0
                local info = nil
                if i == 1 then
                    local winCons = {15073, 15050, 15051, 15052, 15053, 15054}
                    info = {
                        tips = LanguageMgr:GetByID(15056, LanguageMgr:GetByID(winCons[star[1]])),
                        isComplete = num > 0
                    };
                else
                    info = this.GetInfo2(star[1], star[2], num, isEnterFight);
                end
                table.insert(infos, info);
            end
        end
    end
    return infos;
end

-- 战力派遣用
function this.GetStarInfo3(stars, completeNums)
    local infos = {};
    stars = stars or {};
    completeNums = completeNums or {};
    for i = 1, #stars do
        local star = stars[i];
        local num = completeNums[i] or 0
        local info = this.GetInfo3(star[1], star[2], num);
        table.insert(infos, info);
    end
    return infos;
end

function this.GetInfo3(type, target, num)
    local info = {};
    local starTips = {65015, 65016, 65017, 65018, 65019}
    if type == RogueSStarType.Pass then
        info = {
            tips = LanguageMgr:GetByID(starTips[type]),
            isComplete = num > 0
        }
    elseif type == RogueSStarType.KillMonster then
        local cfg = Cfgs.MonsterData:GetByID(target)
        local name = cfg and cfg.name or ""
        info = {
            tips = LanguageMgr:GetByID(starTips[type], name),
            isComplete = num > 0
        }
    elseif type == RogueSStarType.DeathNum then
        info = {
            tips = target == 0 and LanguageMgr:GetByID(65020) or LanguageMgr:GetByID(starTips[type], target),
            isComplete = num > 0
        }
    else
        info = {
            tips = LanguageMgr:GetByID(starTips[type], target),
            isComplete = num > 0
        }
    end
    return info
end

function this.GetStarInfo4(dungeonID)
    local infos = {};
    local dungeonData = DungeonMgr:GetDungeonData(dungeonID)
    infos = DungeonUtil.GetStarInfo2(dungeonID, dungeonData and dungeonData:GetNGrade() or {})
    return infos
end

-- 返回章节当前多倍掉落描述
function this.GetMultiDesc(id)
    local str = "";
    local cfg = this.GetMultiCfg(id)
    if cfg then
        local list = {};
        local infoNum = DungeonMgr:GetSectionMultiNum(id);
        if cfg.plrExpAdd then
            local num = cfg.plrExpAdd[2] - infoNum
            local str = StringUtil:SetByColor(num, num > 0 and "FFC146" or "FF7781") .. "/" .. cfg.plrExpAdd[2]
            table.insert(list, str);
        end
        if cfg.cardExpAdd then
            local num = cfg.cardExpAdd[2] - infoNum
            local str = StringUtil:SetByColor(num, num > 0 and "FFC146" or "FF7781") .. "/" .. cfg.cardExpAdd[2]
            table.insert(list, str);
        end
        if cfg.moneyAdd then
            local num = cfg.moneyAdd[2] - infoNum
            local str = StringUtil:SetByColor(num, num > 0 and "FFC146" or "FF7781") .. "/" .. cfg.moneyAdd[2]
            table.insert(list, str);
        end
        if cfg.dropAdd then
            local max = DungeonUtil.GetDropAdd(id)
            local num = max - infoNum;
            local str = StringUtil:SetByColor(num, num > 0 and "FFC146" or "FF7781") .. "/" .. max
            table.insert(list, str);
        end
        for k, v in ipairs(list) do
            if k == 1 then
                str = str .. v;
            else
                str = str .. " " .. v;
            end
        end
    end
    return str;
end

function this.GetVipMultiDesc(id)
    local cur, max = DungeonUtil.GetMultiNum(id)
    local info = DungeonMgr:GetLimitMultiInfo()
    if info and #info > 0 then
        local extraNum = 0
        local extraInfos = {}
        for i, v in ipairs(info) do
            if v.time > TimeUtil:GetTime() then
                table.insert(extraInfos, {
                    num = v.cnt,
                    id = v.item_id
                })
                extraNum = extraNum + v.cnt
            end
        end
        local str = LanguageMgr:GetByID(15133, cur) .. "\n"
        if #extraInfos > 0 then
            local count = max
            local use = max + extraNum - cur
            local num = 0
            local name = ""
            for i, v in ipairs(extraInfos) do
                local cfg = Cfgs.ItemInfo:GetByID(v.id)
                name = cfg and cfg.name or ""
                if count - use > 0 then
                    num = v.num
                else
                    num = v.num + count - use > 0 and v.num + count - use or 0
                end
                str = str .. LanguageMgr:GetByID(15134, num, name) .. "\n"
                count = count + v.num
            end
        end
        return str
    else
        return ""
    end
end

-- 获取回归多倍掉落总次数
function this.GetRegresAdd()
    local add = 0
    local isRegres = RegressionMgr:IsHuiGui()
    if isRegres then
        local cfgs = Cfgs.CfgDupDropCntAdd:GetAll()
        local arr = RegressionMgr:GetArr()
        if cfgs then
            for _, cfg in pairs(cfgs) do
                if cfg.regressionType ~= nil and #arr > 0 then
                    for _, m in ipairs(arr) do
                        if m.type == RegressionActiveType.DropAdd and m.activityId == cfg.id then
                            add = add + cfg.dropAddCnt
                        end
                    end
                end
            end
        end
    end
    return add
end

-- 获取多倍掉落总次数 返回：最大多倍次数,额外增加的多倍次数,是否无上限
function this.GetDropAdd(id)
    local add, max = 0, 0
    local isNotLimit, isUse = false, false
    if id then
        local cfgSection = Cfgs.Section:GetByID(id)
        if cfgSection then
            add, max, isNotLimit, isUse = GCalHelp:GetMultiDropMaxCnt(cfgSection, DungeonUtil.GetRegresAdd())
        end
    end
    return max, add, isNotLimit, isUse
end

-- 判断该章节是否有多倍掉落信息
function this.HasMultiDesc(id)
    local cfg = this.GetMultiCfg(id)
    if cfg and (cfg.plrExpAdd or cfg.cardExpAdd or cfg.moneyAdd) then
        return true;
    end
    local dropNum = this.GetDropAdd(id)
    if dropNum > 0 then
        return true
    end
    return false;
end

-- 返回章节还剩余多少次多倍掉落
function this.GetMultiNum(id)
    local cfg = this.GetMultiCfg(id)
    local cur, max = 0, 0
    local infoNum, limitTime = DungeonMgr:GetSectionMultiNum(id);
    if (cfg and this.HasMultiDesc(id)) then
        if cfg.plrExpAdd then
            cur = cfg.plrExpAdd[2] - infoNum
            max = cfg.plrExpAdd[2]
        elseif cfg.cardExpAdd then
            cur = cfg.cardExpAdd[2] - infoNum
            max = cfg.cardExpAdd[2]
        elseif cfg.moneyAdd then
            cur = cfg.moneyAdd[2] - infoNum
            max = cfg.moneyAdd[2]
        elseif cfg.dropAdd then
            max = DungeonUtil.GetDropAdd(id)
            cur = max - infoNum
        end
    end
    return cur, max, limitTime
end

function this.GetMultiCfg(sectionID)
    local cfg = nil
    local cfgSection = Cfgs.Section:GetByID(sectionID);
    if cfgSection and cfgSection.multiId then
        cfg = Cfgs.CfgDupDropMulti:GetByID(cfgSection.multiId)
    end
    return cfg
end

-- 查询剩余的多倍数量
function this.HasMultiNum(cfgId)
    local datas = DungeonMgr:GetAllSectionDatas()
    if datas and #datas > 0 then
        for i, v in pairs(datas) do
            if v:GetMultiID() and v:GetMultiID() == cfgId then
                local num = DungeonUtil.GetMultiNum(v:GetID())
                return num > 0
            end
        end
    end
    return false
end

-- 获取多倍的时间限制
function this.GetDropAddTime(id)
    local _, add = this.GetDropAdd(id)
    if add > 0 and g_ReCalAddDupMultiTime and g_ReCalAddDupMultiTime > 0 and g_ReCalAddDupMultiTime > TimeUtil:GetTime() then
        return g_ReCalAddDupMultiTime - TimeUtil:GetTime()
    end
    return 0
end

-- 是否限时多倍
function this.IsLimitDropAdd(id)
    local _, _, _, isLimit = this.GetDropAdd(id)
    return isLimit
end

function this.GetViewPath(sectionID)
    local sectionData = DungeonMgr:GetSectionData(sectionID)
    if sectionData and sectionData:GetInfo() then
        local info = sectionData:GetInfo()
        return info.view or "", info.childView or ""
    end
    return "", ""
end

function this.GetCost(cfg)
    local enterCost = cfg.cost and cfg.cost[1] or nil
    local winCost = cfg.winCost and cfg.winCost[1] or nil
    local cost = nil
    if enterCost then
        cost = {enterCost[1], enterCost[2], enterCost[3]}
    end
    if winCost then
        if cost ~= nil and cost[1] == winCost[1] then
            cost[2] = cost[2] + winCost[2]
        elseif cost == nil then
            cost = {winCost[1], winCost[2], winCost[3]}
        end
    end
    return cost
end

-- 获取实际消耗体力
function this.GetHot(cfg)
    local costNum1 = cfg.enterCostHot and cfg.enterCostHot or 0
    local costNum2 = cfg.winCostHot and cfg.winCostHot or 0
    local percent, num = DungeonUtil.GetExtreHotNum()
    local isHotUp = false
    if percent > 0 then
        percent = percent < 100 and percent or 100
        costNum1 = costNum1 * (100 - percent) / 100
        costNum2 = costNum2 * (100 - percent) / 100
        isHotUp = true
    end
    -- 因为是负数，所以向上取整
    local costNum = math.ceil(costNum1) + math.ceil(costNum2)
    if num > 0 then
        costNum = costNum + num > 0 and 0 or costNum + num
        isHotUp = true
    end
    return costNum, isHotUp
end

-- 体力消耗减少
function this.GetExtreHotNum()
    local add, percentAdd, regresAdd, regresPercentAdd = 0, 0, 0, 0
    local cfgs = Cfgs.CfgDupConsumeReduce:GetAll()
    local isRegres = RegressionMgr:IsHuiGui()
    if cfgs then
        for _, cfg in pairs(cfgs) do
            local type = cfg.type or 1
            if cfg.startTime and cfg.endTime then
                local startTime = TimeUtil:GetTimeStampBySplit(cfg.startTime)
                local endTime = TimeUtil:GetTimeStampBySplit(cfg.endTime)
                if TimeUtil:GetTime() >= startTime and TimeUtil:GetTime() < endTime then
                    if type == 1 then
                        percentAdd = percentAdd + cfg.consumeReduce
                    elseif type == 2 then
                        add = add + cfg.consumeReduce
                    end
                end
            elseif cfg.regressionType ~= nil then
                if isRegres then
                    local arr = RegressionMgr:GetArr()
                    if #arr > 0 then
                        for k, m in ipairs(arr) do
                            if m.type == RegressionActiveType.ConsumeReduce and m.activityId == cfg.id then
                                if type == 1 then
                                    percentAdd = percentAdd + cfg.consumeReduce
                                    regresPercentAdd = regresPercentAdd + cfg.consumeReduce
                                elseif type == 2 then
                                    add = add + cfg.consumeReduce
                                    regresAdd = regresAdd + cfg.consumeReduce
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return percentAdd, add, regresPercentAdd, regresAdd
end

function this.IsEnough(cfg)
    local isEnough, str = false, ""
    if cfg then
        local cost = DungeonUtil.GetCost(cfg)
        if cost then
            local cur = BagMgr:GetCount(cost[1])
            local need = cost[2]
            isEnough = cur >= need
            if not isEnough then
                local _cfg = Cfgs.ItemInfo:GetByID(cost[1])
                if _cfg and _cfg.name then
                    str = LanguageMgr:GetTips(15000, _cfg.name)
                end
            end
        else
            local cur = PlayerClient:Hot()
            local need = math.abs(DungeonUtil.GetHot(cfg))
            isEnough = cur >= need
            if not isEnough then
                str = LanguageMgr:GetTips(8013)
            end
        end
    end
    return isEnough, str
end

function this.GetHotChangeTime()
    local cfgs = Cfgs.CfgDupConsumeReduce:GetAll()
    local sTime, eTime = 0, 0
    if cfgs then
        for _, cfg in pairs(cfgs) do
            if cfg.startTime and cfg.endTime then
                local startTime = TimeUtil:GetTimeStampBySplit(cfg.startTime)
                local endTime = TimeUtil:GetTimeStampBySplit(cfg.endTime)
                if TimeUtil:GetTime() >= startTime and TimeUtil:GetTime() < endTime then
                    -- sTime = (sTime == 0 or sTime > startTime ) and startTime or sTime --获取最小开始时间
                    -- eTime = (eTime == 0 or eTime < endTime) and endTime or eTime --获取最大结束时间
                    sTime = startTime
                    eTime = endTime
                    break
                end
            end
        end
    end
    return sTime, eTime
end

function this.IsGlobalBossCloseTime(sid)
    local openInfo = DungeonMgr:GetActiveOpenInfo2(sid)
    local globalBossCloseTime = 0
    local desc = ""
    if openInfo then
        local _cfg = openInfo:GetCfg()
        if _cfg and _cfg.closeStartTime and _cfg.closeEndTime then
            desc = _cfg.desc
            local curTab = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
            local ss1 = StringUtil:split(_cfg.closeStartTime, " ")
            local ss2 = StringUtil:split(_cfg.closeEndTime, " ")
            if curTab.day == tonumber(ss1[1]) and curTab.day <= tonumber(ss2[1]) then
                local tab1 = TimeUtil:SplitTime(ss1[2])
                if curTab.hour >= tonumber(tab1[1]) then
                    local tab2 = TimeUtil:SplitTime(ss2[2])
                    globalBossCloseTime = TimeUtil:GetTime2(curTab.year, curTab.month, curTab.day, tab2[1], tab2[2],
                        tab2[3])
                    if TimeUtil:GetTime() < globalBossCloseTime then
                        return true, globalBossCloseTime, desc
                    end
                end
            end
        end
    end
    return false, globalBossCloseTime, desc
end

-- 获取默认队伍配置
function this.GetTeamReplaceInfos(cfgId)
    local cfg = Cfgs.CfgDupHadPassTeam:GetByID(cfgId)
    local infos = {}
    if cfg and cfg.item then
        for _, _item in pairs(cfg.item) do
            if _item.teamInfo then
                local json = Json.decode(_item.teamInfo)
                local datas = {}
                for k, v in pairs(json) do
                    if type(v) == "table" then
                        local teamData = DungeonUtil.GetTeamData(v)
                        teamData.uid = v.uid
                        table.insert(datas, teamData)
                    end
                end
                table.insert(infos, datas)
            end
        end
    end
    return infos
end

-- 封装成队伍数据
function this.GetTeamData(info)
    if info.data then
        local data = {}
        local index = 1
        local cfgSkill = nil
        for i, v in ipairs(info.data) do
            if v.card_info then
                local cardInfo = v
                -- index
                cardInfo.index = (v.bIsAssit or v.bIsNpc) and 6 or index
                index = index + 1
                if not v.bIsNpc then
                    -- skill
                    local skills = {}
                    if v.card_info.skills then
                        for k, m in ipairs(v.card_info.skills) do
                            cfgSkill = Cfgs.skill:GetByID(m)
                            if cfgSkill then
                                skills[m] = {
                                    id = m,
                                    type = cfgSkill.main_type
                                }
                            end
                        end
                    end
                    cardInfo.card_info.skills = skills
                    -- equips
                    local equips = {}
                    if v.card_info.equips then
                        for k, m in pairs(v.card_info.equips) do
                            if type(m) == "table" and m.cfgid then
                                equips[m.cfgid] = m
                            end
                        end
                    end
                    cardInfo.card_info.equips = equips
                else
                    v.cid = "npc_" .. v.cid
                    cardInfo.card_info = nil
                end
                table.insert(data, cardInfo)
            end
        end
        info.data = data
    end
    local teamData = TeamData.New()
    teamData:SetData(info)
    if info.skill_group_id > 0 then
        teamData.skillGroupID = info.skill_group_id
    end
    return teamData
end

function this.FindPaths(startIndex,targetIndex)
    if startIndex == targetIndex then
        return {startIndex}, 0
    end

    -- 构建邻接表
    if DungeonUtil.pathCfgs == nil then
        DungeonUtil.pathCfgs = {}
        local cfgs = Cfgs.DungeonPathFind:GetAll()
        if cfgs then
            for k, v in pairs(cfgs) do
                DungeonUtil.pathCfgs[v.id] = v
            end
        end
    end

    if not DungeonUtil.pathCfgs[startIndex] or not DungeonUtil.pathCfgs[targetIndex] then
        return nil, 0
    end

    --不在同一层级，直接跳到终点
    if DungeonUtil.pathCfgs[startIndex].level ~= DungeonUtil.pathCfgs[targetIndex].level then
         return {targetIndex}, 0
    end
    
    -- 初始化距离表
    local distances = {}
    local previous = {}
    local unvisited = {}
    
    for _, node in pairs(DungeonUtil.pathCfgs) do
        distances[node.id] = math.huge  -- 无穷大
        unvisited[node.id] = true
    end
    distances[startIndex] = 0
    
    while true do
        -- 找到未访问中距离最小的节点
        local current = nil
        local minDistance = math.huge
        
        for nodeId, isUnvisited in pairs(unvisited) do
            if isUnvisited and distances[nodeId] < minDistance then
                minDistance = distances[nodeId]
                current = nodeId
            end
        end
        
        if current == nil or current == targetIndex then
            break
        end
        
        unvisited[current] = false
        
        -- 更新邻居节点的距离
        if DungeonUtil.pathCfgs[current] then
            local currentPos = DungeonUtil.pathCfgs[current].pos
            for _, neighbor in ipairs(DungeonUtil.pathCfgs[current].next) do
                if current ~= neighbor and unvisited[neighbor] then
                    local neighborPos = DungeonUtil.pathCfgs[neighbor].pos
                    local edgeWeight = math.sqrt((currentPos[1] - neighborPos[1]) * (currentPos[1] - neighborPos[1]) + (currentPos[2] - neighborPos[2]) * (currentPos[2] - neighborPos[2]))
                    local newDistance = distances[current] + edgeWeight
                    if newDistance < distances[neighbor] then
                        distances[neighbor] = newDistance
                        previous[neighbor] = current
                    end
                end
            end
        end
    end

    -- 检查是否可达
    if distances[targetIndex] == math.huge then
        return nil, 0
    end
    
    -- 重建路径
    local path = {}
    local step = targetIndex
    while step ~= nil do
        table.insert(path, 1, step)
        step = previous[step]
    end
    
    return path, distances[targetIndex]
end

return this;
