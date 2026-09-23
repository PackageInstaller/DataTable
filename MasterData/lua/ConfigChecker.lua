-- 配置容错检测及特殊处理
-- 此函数会在每个配置表的设置为只读表前调用, 在此可以修改配置表
-- ConfigChecker:[表名(同配置一致)](cfg)
-- OPENDEBUG()
ConfigChecker = {}

if not CURRENT_TIME then
    CURRENT_TIME = os.time()
end

-- 检查副本数据
function ConfigChecker:CheckDungeon()
    -- for duplicateID,v in pairs(MainLine) do
    --     function FunCheckDungeon(duplicateID,v)
    --         LogDebugEx("检查副本数据:"..duplicateID)
    --         -- LogTable(v)
    --         local dungeonData = Loader:Require("Dungeon.Dungeon_" .. duplicateID)
    --         ASSERT(dungeonData.born, "没有配置出生点")
    --         ASSERT(dungeonData.groups[dungeonData.born], "没有配置出生点坐标组")
    --         for i,v in ipairs(dungeonData.monsters) do
    --             ASSERT(v.born, "没有配置怪物出生点")
    --             ASSERT(dungeonData.groups[v.born], "没有配置怪物出生点坐标组")
    --         end
    --         ASSERT(dungeonData.mapid, "没有配置地图id")
    --         local mapData = Loader:Require("Map.Map_" .. dungeonData.mapid)
    --         LogDebugEx("检查地图数据:".. dungeonData.mapid)
    --         for i,v in ipairs(dungeonData.groups) do
    --             for i2,gid in ipairs(v) do
    --                 ASSERT(mapData[gid], "地图不包含坐标id为"..gid.."的格子")
    --             end
    --         end
    --     end
    --     local ok,err = pcall(FunCheckDungeon, duplicateID,v)
    --     if not ok then
    --         print("err msg ",err)
    --     end
    -- end
end

function ConfigChecker:ShowCheckPrimaryKeyErr(checkCfg, errCfg, findKey)
    LogTable(errCfg, '报错的哪一行数据为:')
    if checkCfg.cfgFieldKey2 then
        LogInfo('配置表:' .. checkCfg.cfgName .. '.' .. checkCfg.cfgFieldKey .. '.' .. checkCfg.cfgFieldKey2)
    else
        LogInfo('配置表:' .. checkCfg.cfgName .. '.' .. checkCfg.cfgFieldKey)
    end

    LogInfo('在表[' .. checkCfg.relevance .. ']中找不到主键为' .. findKey .. '的配置')
    ASSERT()
end

-- 主键关联有效性检测
function ConfigChecker:CheckPrimaryKey()
    for k, checkCfg in pairs(ConfigPrimaryKey) do
        -- 要检查的表格
        LogInfo('CheckPrimaryKey() 开始检查表格 ' .. checkCfg.cfgName .. ' 与关联表格 ' .. checkCfg.relevance)

        -- 关联表A
        local cfgA = _G[checkCfg.cfgName]

        -- 关联表B
        local cfgB = _G[checkCfg.relevance]

        -- 检查字段名称
        local strCheckField = checkCfg.cfgFieldKey
        if checkCfg.cfgFieldKey2 then
            strCheckField = strCheckField .. ' -> ' .. checkCfg.cfgFieldKey2
        end

        -- 遍历表A的每一行
        for k, cfga in pairs(cfgA) do
            local f1 = cfga[checkCfg.cfgFieldKey]
            if f1 ~= nil then
                if type(f1) == 'table' then
                    for _, f1v in pairs(f1) do
                        if checkCfg.cfgFieldKey2 then
                            local f2 = f1v[checkCfg.cfgFieldKey2]
                            if f2 ~= nil then
                                if type(f2) == 'table' then
                                    for _, f2v in pairs(f2) do
                                        if not cfgB[f2v] then
                                            self:ShowCheckPrimaryKeyErr(checkCfg, cfga, f2v)
                                        end
                                    end
                                else
                                    if not cfgB[f2] then
                                        self:ShowCheckPrimaryKeyErr(checkCfg, cfga, f2)
                                    end
                                end
                            end
                        else
                            if not cfgB[f1v] then
                                self:ShowCheckPrimaryKeyErr(checkCfg, cfga, f1v)
                            end
                        end
                    end
                else
                    if not cfgB[f1] then
                        self:ShowCheckPrimaryKeyErr(checkCfg, cfga, f1)
                    end
                end
            end
        end
    end
end

-- 奖励表
function ConfigChecker:RewardInfo(cfg)
    -- LogTable(cfg)
    for k, v in pairs(cfg) do
        if not v.item[1] then
            ASSERT(false, '掉落表id:' .. k .. '，为空，或者 item 数组的下标不是从1开始！')
        end

        for i, item in ipairs(v.item) do
            if item.level or item.dupID then
                v.bIsLimit = true
            end

            if item.type == RandRewardType.ITEM then
                ASSERT(
                        ItemInfo[item.id],
                        string.format("掉落表id:%s,index:%s, item.id为:%s, 表 ItemInfo 找不到配置",k, i, item.id)
                )
            elseif item.type == RandRewardType.CARD then
                ASSERT(
                        CardData[item.id],
                        string.format("掉落表id:%s,index:%s, item.id为:%s, 表 CardData 找不到配置",k, i, item.id)
                )
            elseif item.type == RandRewardType.EQUIP then
                ASSERT(
                        CfgEquip[item.id],
                        string.format("掉落表id:%s,index:%s, item.id为:%s, 表 CfgEquip 找不到配置",k, i, item.id)
                )
            elseif item.type == RandRewardType.TEMPLATE then
                ASSERT(
                        cfg[item.id],
                        string.format("掉落表id:%s,index:%s, item.id为:%s, 表 RewardInfo 找不到配置",k, i, item.id)
                )
            end

            if item.level then
                if #item.level < 2 then
                    ASSERT(false, string.format("掉落表id:%s, index:%s, item.id为:%s, item.level 数组程度小于2",k, i, item.id))
                end
            end

            if item.openTimes then
                if #item.openTimes < 2 then
                    ASSERT(false, string.format("掉落表id:%s, index:%s, item.id为:%s, item.openTimes 数组程度小于2",k, i, item.id))
                end

                local begTime = GCalHelp:GetTimeStampBySplit(item.openTimes[1], item)
                local endTime = GCalHelp:GetTimeStampBySplit(item.openTimes[2], item)
                ASSERT(begTime ~= 0, string.format("掉落表id:%s, index:%s, item.openTimes 开始时间 %s 错误",k, i, item.openTimes[1]))
                ASSERT(endTime ~= 0, string.format("掉落表id:%s, index:%s, item.openTimes 结束时间 %s 错误",k, i, item.openTimes[2]))
                ASSERT(begTime <= endTime, string.format("掉落表id:%s, index:%s, item.id为:%s, item.openTimes 开始时间不小于结束时间",k, i, item.id))
                item.openTimesArr = {begTime, endTime}
            end
        end
    end
end

-- 卡牌表
function ConfigChecker:CardData(cfgs)
    ---------------------------------------------------------------------
    -- 遍历所有卡牌
    g_fightCardCnt = 0
    g_cardNumByQuality = {}

    g_openCardCnt = 0
    g_openCardCntByQuality = {}

    for k, v in pairs(cfgs) do
        if v.get_from_gm then
            if CARD_TYPE.FIGHT == v.card_type then
                g_fightCardCnt = g_fightCardCnt + 1
                GCalHelp:Add(g_cardNumByQuality, v.quality, 1)
            end

            if v.role_id then
                local roleCfg = CfgCardRole[v.role_id]
                if roleCfg and roleCfg.bShowInAltas then
                    g_openCardCnt = g_openCardCnt + 1
                    GCalHelp:Add(g_openCardCntByQuality, v.quality, 1)
                end
            end
        end

        -- 检查天赋技能
        if v.tfSkills then
            for _, talentId in ipairs(v.tfSkills) do
                local skilCfg = _G['skill'][talentId]
                if not skilCfg then
                    LogInfo(
                            string.format(
                                    'Error Card id: %d, talent skill id: %d in tfSkills not find skill info from skill cfg!',
                                    v.id,
                                    talentId
                            )
                    )
                elseif skilCfg.main_type ~= SkillMainType.CardTalent then
                    LogInfo(
                            string.format(
                                    'Error Card id: %d, talent skill id: %d type is: %d, not：%d error!',
                                    v.id,
                                    talentId,
                                    skilCfg.main_type,
                                    SkillMainType.CardTalent
                            )
                    )
                end
            end
        end

        local skills = {}
        if v.jcSkills then
            for i, skillID in ipairs(v.jcSkills) do
                table.insert(skills, skillID)
            end
        end

        if v.tfSkills then
            for i, skillID in ipairs(v.tfSkills) do
                table.insert(skills, skillID)
            end
        end

        if v.tcSkills then
            for i, skillID in ipairs(v.tcSkills) do
                table.insert(skills, skillID)
            end
        end

        v.skills = skills

        -- 检测转换形态转换相关
        v.notBuyChangeCardIds = {}
        v.changeCardIds = v.changeCardIds or {}
        for _, arr in ipairs(v.changeCardIds) do
            local cfgId = arr[1]
            local openId = arr[2]

            local cfg = cfgs[cfgId]
            if not cfg then
                assert(false, string.format('卡牌id %s 的 changeCardIds 中的卡牌ID %s, 找不到配置', k, cfgId))
            end

            if openId and openId ~= 0 then
                local openCfg = CfgOpenRules[openId]
                if not openCfg then
                    assert(false, string.format('卡牌id %s 的 changeCardIds 中的 openId %s, 找不到配置', k, openId))
                end
            end

            local cpNumArr = {'jcSkills', 'tfSkills', 'tcSkills'}
            for _, f in ipairs(cpNumArr) do
                local lhs = v[f] or {}
                local rhs = cfg[f] or {}
                if #lhs ~= #rhs then
                    assert(false, string.format('卡牌id %s 与 %s 的 %s 字段，长度不相等，转换角色技能需要一样长度', k, cfgId, f))
                end
            end

            if not openId or openId ~= OpenRuleType.Add then
                table.insert(v.notBuyChangeCardIds, arr)
            end
        end

        v.notBuyAllTcSkills = {}
        v.allTcSkills = v.allTcSkills or {}
        for _, arr in ipairs(v.allTcSkills) do
            local skillId = arr[1]
            local openId = arr[2]

            local cfg = skill[skillId]
            if not cfg then
                assert(false, string.format('卡牌id %s 的 allTcSkills 中的技能ID %s, 技能表中找不到配置', k, skillId))
            end

            if openId and openId ~= 0 then
                local openCfg = CfgOpenRules[openId]
                if not openCfg then
                    assert(false, string.format('卡牌id %s 的 allTcSkills 中的 openId %s, 找不到配置', k, openId))
                end
            end

            if not openId or openId ~= OpenRuleType.Add then
                table.insert(v.notBuyAllTcSkills, arr)
            end
        end

        if v.fit_result then
            assert(cfgs[v.fit_result], '卡牌id:' .. v.id .. ' 的 v.fit_result 值：' .. v.fit_result .. ' 在卡牌表找不到对应配置')
        end

        if v.skin then
            table.sort(v.skin)
        end

        ASSERT(v.nJump, '没有配置跳跃步数' .. v.id)
        ASSERT(v.nStep, '没有配置移动步数' .. v.id)
        ASSERT(v.break_id, '没有配置突破模板 break_id' .. v.id)

        for i = 0, 3, 1 do
            local useId = v.break_id + i
            if not CardBreakMaterial[useId] then
                ASSERT(
                        false,
                        '卡牌cfgId:' ..
                                v.id ..
                                ', break_id:' ..
                                v.break_id .. '的第[ ' .. i + 1 .. ' ]级id:' .. useId .. '在CardBreakMaterial找不到配置'
                )
            end
        end

        -- 记录所有皮肤可使用的最小突破等级，以内会出现重复，所以不能使用排序加二分查找法
        local skinMinBreakLv = {}
        if v.breakModels then
            table.sort(v.breakModels)

            for ix, skinId in ipairs(v.breakModels) do
                local ov = skinMinBreakLv[skinId]
                if not ov or ix < ov then
                    skinMinBreakLv[skinId] = ix
                end
            end
        end

        for _, tCId in ipairs(v.tTransfo or {}) do
            local tCfg = CardData[tCId]
            -- LogTable(tCfg.breakModels, "cid:" .. tCId)
            for ix, skinId in ipairs(tCfg.breakModels or {}) do
                local ov = skinMinBreakLv[skinId]
                if not ov or ix < ov then
                    skinMinBreakLv[skinId] = ix
                end
            end
        end

        v.skinMinBreakLv = skinMinBreakLv
        -- LogTable(v.skinMinBreakLv, "v.skinMinBreakLv:")
        if v.coreItemId then
            local itemCfg = ItemInfo[v.coreItemId]
            ASSERT(itemCfg, 'ItemInfo没有id=' .. v.coreItemId)

            local isFind = false
            for _, val in ipairs(itemCfg.dy_arr) do
                local isOk = (val == v.id)
                if isOk then
                    isFind = true
                    break
                end
            end

            ASSERT(
                    isFind,
                    string.format(
                            '卡牌 %s 的 coreItemId [%s] 对应物品的 itemCfg.dy_arr 里面需要包含卡牌id:%s.',
                            v.id,
                            v.coreItemId,
                            table.tostring(itemCfg.dy_arr)
                    )
            )
        end
        if (v.uniteLabel) then
            v.unite = GetUnites(v.uniteLabel,v.id)
        end
        -- if (v.uniteLabel) then
        --     local removeIDs = {}
        --     local uniteIDs = {}
        --     for _, _cfg in pairs(CardData) do
        --         --需要剔除的id
        --         if (_cfg.fit_result) then --合体id
        --             removeIDs[_cfg.fit_result] = _cfg.fit_result
        --         end
        --         if (_cfg.tTransfo) then --变身id
        --             for _, _id in ipairs(_cfg.tTransfo) do
        --                 removeIDs[_id] = _id
        --             end
        --         end

        --         local count = 0
        --         for _, _info in ipairs(v.uniteLabel) do
        --             local cfgLabel = CfgUniteLabel[_info[1]]
        --             local cfg1 = nil
        --             if (_cfg.role_id and cfgLabel.cfgType == 1) then
        --                 cfg1 = CfgCardRole[_cfg.role_id]
        --             else
        --                 cfg1 = _cfg
        --             end
        --             if (cfg1) then
        --                 --判断条件
        --                 local num = 0
        --                 if (cfgLabel.key) then
        --                     for _, content in ipairs(_info[2]) do
        --                         if (cfgLabel.type ~= 2) then
        --                             if (cfg1[cfgLabel.key] == content) then
        --                                 num = num + 1
        --                             end
        --                         else --区间类型
        --                             if
        --                             (content[1] < 0 and content[2] < 0) or
        --                                     (content[1] < 0 and cfg1[cfgLabel.key] < content[2]) or
        --                                     (content[2] < 0 and cfg1[cfgLabel.key] > content[1]) or
        --                                     (cfg1[cfgLabel.key] > content[1] and cfg1[cfgLabel.key] < content[2])
        --                             then
        --                                 num = num + 1
        --                             end
        --                         end
        --                     end
        --                 end
        --                 if (num > 0) then
        --                     if (_info[3] == 1) then --或条件
        --                         count = count + 1
        --                     else --与条件
        --                         if (num >= #_info[2]) then
        --                             count = count + 1
        --                         end
        --                     end
        --                 end
        --             end
        --         end
        --         -- if (count >= #v.uniteLabel and _cfg.get_from_gm) then
        --         if (count >= #v.uniteLabel) then
        --             table.insert(uniteIDs, _cfg.id)
        --         end
        --     end
        --     if (#uniteIDs > 0) then
        --         table.sort(
        --                 uniteIDs,
        --                 function(a, b)
        --                     return a < b
        --                 end
        --         )
        --         local lastID = 0
        --         local ids = {}
        --         for _, uniteID in ipairs(uniteIDs) do --剔除不需要和相同的id
        --             if (not (removeIDs[uniteID]) and not (uniteID == v.id) and not (uniteID == lastID)) then
        --                 table.insert(ids, uniteID)
        --             end
        --             lastID = uniteID
        --         end
        --         v.unite = ids
        --     end
        -- end

        -- if v.id == 50010 then
        -- 	LogTable(v)
        -- 	ASSERT()
        -- end

        if v.summon then
            ASSERT(v.add_role_id, '填了, summon 必须要填 add_role_id 字段')
        end

        if v.role_id then
            ASSERT(
                    CfgCardRole[v.role_id],
                    '卡牌配置表的id:' .. v.id .. ', 的 role_id:' .. v.role_id .. ', 在 CfgCardRole 表格找不到数据'
            )
        end

        if v.add_role_id then
            ASSERT(
                    CfgCardRole[v.add_role_id],
                    '卡牌配置表的id:' .. v.id .. ', 的 add_role_id:' .. v.add_role_id .. ', 在 CfgCardRole 表格找不到数据'
            )
        end
    end
end

function ConfigChecker:CfgCardRole(cfgs)
    g_CardRoleShowCnt = 0
    g_CardPoleShowByQuality = {}

    for id, cfg in pairs(cfgs) do
        ASSERT(cfg.aModels, 'CfgCardRole id：' .. id .. '没填 aModels')

        if character then
            -- 服务器没这个表
            ASSERT(character[cfg.aModels], 'CfgCardRole id：' .. id .. ', 的aModels:' .. '在角色模型表 character 找不到数据。')
        end

        if cfg.bShowInAltas and cfg.aCards and #cfg.aCards > 0 then
            g_CardRoleShowCnt = g_CardRoleShowCnt + 1
            for _, cardId in ipairs(cfg.aCards) do
                local cardCfg = CardData[cardId]
                if cardCfg and CARD_TYPE.FIGHT == cardCfg.card_type then
                    GCalHelp:Add(g_CardPoleShowByQuality, cardCfg.quality, 1)
                    break
                end
            end

        end
    end
end

-- 怪物表
function ConfigChecker:MonsterData(cfg)
    for k, v in pairs(cfg) do
        local skills = {}
        if v.jcSkills then
            for i, skillID in ipairs(v.jcSkills) do
                table.insert(skills, skillID)
            end
        end

        if v.tfSkills then
            for i, skillID in ipairs(v.tfSkills) do
                table.insert(skills, skillID)
            end
        end

        if v.subTfSkills then
            for i, skillID in ipairs(v.subTfSkills) do
                table.insert(skills, skillID)
            end
        end

        if v.tcSkills then
            for i, skillID in ipairs(v.tcSkills) do
                table.insert(skills, skillID)
            end
        end
        v.skills = skills
        if (v.card_id and CardData[v.card_id] and CardData[v.card_id].uniteLabel) then
            v.unite = GetUnites(CardData[v.card_id].uniteLabel,v.id)
        end

        -- if (v.card_id and CardData[v.card_id] and CardData[v.card_id].uniteLabel) then
        --     local removeIDs = {}
        --     local uniteIDs = {}
        --     for _, _cfg in pairs(MonsterData) do
        --         --需要剔除的id
        --         if (_cfg.fit_result) then --合体id
        --             removeIDs[_cfg.fit_result] = _cfg.fit_result
        --         end
        --         if (_cfg.tTransfo) then --变身id
        --             for _, _id in ipairs(_cfg.tTransfo) do
        --                 removeIDs[_id] = _id
        --             end
        --         end

        --         local count = 0
        --         for _, _info in ipairs(CardData[v.card_id].uniteLabel) do
        --             local cfgLabel = CfgUniteLabel[_info[1]]
        --             local cfg1 = nil
        --             if (_cfg.card_id and CardData[_cfg.card_id] and CardData[_cfg.card_id].role_id and cfgLabel.cfgType == 1) then
        --                 cfg1 = CfgCardRole[CardData[_cfg.card_id].role_id]
        --             else
        --                 cfg1 = CardData[_cfg.card_id]
        --             end
        --             if (cfg1) then
        --                 --判断条件
        --                 local num = 0
        --                 if (cfgLabel.key) then
        --                     for _, content in ipairs(_info[2]) do
        --                         if (cfgLabel.type ~= 2) then
        --                             if (cfg1[cfgLabel.key] == content) then
        --                                 num = num + 1
        --                             end
        --                         else --区间类型
        --                             if
        --                             (content[1] < 0 and content[2] < 0) or
        --                                     (content[1] < 0 and cfg1[cfgLabel.key] < content[2]) or
        --                                     (content[2] < 0 and cfg1[cfgLabel.key] > content[1]) or
        --                                     (cfg1[cfgLabel.key] > content[1] and cfg1[cfgLabel.key] < content[2])
        --                             then
        --                                 num = num + 1
        --                             end
        --                         end
        --                     end
        --                 end
        --                 if (num > 0) then
        --                     if (_info[3] == 1) then --或条件
        --                         count = count + 1
        --                     else --与条件
        --                         if (num >= #_info[2]) then
        --                             count = count + 1
        --                         end
        --                     end
        --                 end
        --             end
        --         end

        --         -- if (count >= #v.uniteLabel and _cfg.get_from_gm) then
        --         if (count >= #CardData[v.card_id].uniteLabel) then
        --             table.insert(uniteIDs, _cfg.id)
        --         end
        --     end

        --     if (#uniteIDs > 0) then
        --         table.sort(
        --                 uniteIDs,
        --                 function(a, b)
        --                     return a < b
        --                 end
        --         )
        --         local lastID = 0
        --         local ids = {}
        --         for _, uniteID in ipairs(uniteIDs) do --剔除不需要和相同的id
        --             if (not (removeIDs[uniteID]) and not (uniteID == v.id) and not (uniteID == lastID)) then
        --                 table.insert(ids, uniteID)
        --             end
        --             lastID = uniteID
        --         end
        --         v.unite = ids
        --     end
        -- end
    end
end

--获取卡牌表和怪物表同调id组
function GetUnites(uniteLabels,cfgId)
    cfgId = cfgId or 0
    if (uniteLabels) then
        local removeIDs = {}
        local uniteIDs = {}
        for _, _cfg in pairs(CardData) do
            --需要剔除的id
            if (_cfg.fit_result) then --合体id
                removeIDs[_cfg.fit_result] = _cfg.fit_result
            end
            -- if (_cfg.tTransfo) then --变身id
            --     for _, _id in ipairs(_cfg.tTransfo) do
            --         removeIDs[_id] = _id
            --     end
            -- end

            local count = 0
            for _, _info in ipairs(uniteLabels) do
                local cfgLabel = CfgUniteLabel[_info[1]]
                local cfg1 = nil
                if (_cfg.role_id and cfgLabel.cfgType == 1) then
                    cfg1 = CfgCardRole[_cfg.role_id]
                else
                    cfg1 = _cfg
                end
                if (cfg1) then
                    --判断条件
                    local num = 0
                    if (cfgLabel.key) then
                        for _, content in ipairs(_info[2]) do
                            if (cfgLabel.type ~= 2) then
                                if (cfg1[cfgLabel.key] == content) then
                                    num = num + 1
                                end
                            else --区间类型
                                if
                                (content[1] < 0 and content[2] < 0) or
                                        (content[1] < 0 and cfg1[cfgLabel.key] < content[2]) or
                                        (content[2] < 0 and cfg1[cfgLabel.key] > content[1]) or
                                        (cfg1[cfgLabel.key] > content[1] and cfg1[cfgLabel.key] < content[2])
                                then
                                    num = num + 1
                                end
                            end
                        end
                    end
                    if (num > 0) then
                        if (_info[3] == 1) then --或条件
                            count = count + 1
                        else --与条件
                            if (num >= #_info[2]) then
                                count = count + 1
                            end
                        end
                    end
                end
            end
            if (count >= #uniteLabels) then
                table.insert(uniteIDs, _cfg.id)
            end
        end

        for _, _cfg in pairs(MonsterData) do
            --需要剔除的id
            if (_cfg.fit_result) then --合体id
                removeIDs[_cfg.fit_result] = _cfg.fit_result
            end
            -- if (_cfg.tTransfo) then --变身id
            --     for _, _id in ipairs(_cfg.tTransfo) do
            --         removeIDs[_id] = _id
            --     end
            -- end

            local count = 0
            for _, _info in ipairs(uniteLabels) do
                local cfgLabel = CfgUniteLabel[_info[1]]
                local cfg1 = nil
                if (_cfg.card_id and CardData[_cfg.card_id] and CardData[_cfg.card_id].role_id and cfgLabel.cfgType == 1) then
                    cfg1 = CfgCardRole[CardData[_cfg.card_id].role_id]
                else
                    cfg1 = CardData[_cfg.card_id]
                end
                if (cfg1) then
                    --判断条件
                    local num = 0
                    if (cfgLabel.key) then
                        for _, content in ipairs(_info[2]) do
                            if (cfgLabel.type ~= 2) then
                                if (cfg1[cfgLabel.key] == content) then
                                    num = num + 1
                                end
                            else --区间类型
                                if
                                (content[1] < 0 and content[2] < 0) or
                                        (content[1] < 0 and cfg1[cfgLabel.key] < content[2]) or
                                        (content[2] < 0 and cfg1[cfgLabel.key] > content[1]) or
                                        (cfg1[cfgLabel.key] > content[1] and cfg1[cfgLabel.key] < content[2])
                                then
                                    num = num + 1
                                end
                            end
                        end
                    end
                    if (num > 0) then
                        if (_info[3] == 1) then --或条件
                            count = count + 1
                        else --与条件
                            if (num >= #_info[2]) then
                                count = count + 1
                            end
                        end
                    end
                end
            end

            if (count >= #uniteLabels) then
                table.insert(uniteIDs, _cfg.id)
            end
        end

        if (#uniteIDs > 0) then
            table.sort(uniteIDs,function(a, b)
                        return a < b
                    end)
            local lastID = 0
            local ids = {}
            for _, uniteID in ipairs(uniteIDs) do --剔除不需要和相同的id
                if (not (removeIDs[uniteID]) and not (uniteID == cfgId) and not (uniteID == lastID)) then
                    table.insert(ids, uniteID)
                end
                lastID = uniteID
            end
            return ids
        end
    end
    return nil
end

function ConfigChecker:skill(cfg)
    for k, v in pairs(cfg) do
        v.skillGroup = math.floor(v.id / 100)

        -- 暂时可以重复，取消检测
        -- local equipSkillInfo = CfgEquipSkill[k]
        -- if equipSkillInfo then
        --     ASSERT(false, "技能表id, 与装备技能id重复，值为：" .. k)
        -- end
        -- 核心技能、对饮 ovload 技能检测
        -- Tips: +1000 是策划约定的，如果修改这个值，需要同步修改卡牌技能升级Card:AddSkillLv()里的 +1000
        if false and v.upgrade_type == CardSkillUpType.C then
            local ovloadId = v.id + 1000
            local ovloadCfg = cfg[ovloadId]
            if not ovloadCfg then
                ASSERT(false, '技能id:' .. v.id .. '没有找到对应的overload技能id:' .. ovloadId)
            end

            if ovloadCfg.type ~= 9 then
                ASSERT(
                        false,
                        '技能id:' ..
                                v.id .. '没有找到对应的overload技能id:' .. ovloadId .. ', 的技能类型为：' .. ovloadCfg.type .. ', 约定类型应该为：9.'
                )
            end
        end
    end
end

-- 关卡表
function ConfigChecker:MainLine(cfgs)
    -- LogDebug("IS_CLIENT:" .. IS_CLIENT)
    g_CalMainLineStarIxs = {}
    g_CalMainLineCount = {}
    g_AbattoirSeason = {}
    g_MultTeamStageDup = {}
    for k, v in pairs(cfgs) do
        if v.starIx then
            local arr = GCalHelp:GetTb(g_CalMainLineStarIxs, v.starIx, {})
            table.insert(arr, k)
        end
        if v.group and v.type then
            -- 1剧情副本不算星
            if not v.sub_type or v.sub_type ~= 1 then
                local groupArr = GCalHelp:GetTb(g_CalMainLineCount, v.group, {})
                local typeArr = GCalHelp:GetTb(groupArr, v.type, {})
                table.insert(typeArr, k)
            end
        end

        if v.forceSkill then
            table.sort(v.forceSkill)
        end

        if v.nGroupID or v.type == 110  then
            -- 直接进入战斗
            -- type==110建造关卡，不需要星数
        else
            v.star = {}
            v.mapStar = {}
            for i = 1, 3 do
                local config = v['star' .. i]
                table.insert(v.star, config[1])

                v.mapStar[config[1]] = i
            end
        end
        v.skillGroup = math.floor(v.id / 100)

        if v.arrForceTeam then
            local arrForceTeam = {}
            for i, v in ipairs(v.arrForceTeam) do
                ASSERT(ForceTeam[v], '没有配置强制队伍' .. v)
                arrForceTeam[i] = ForceTeam[v].arrForceTeam
            end
            v.arrForceTeam = arrForceTeam
        end

        if v.encounterReward then
            ASSERT(v.encounterRate, '没有配置随机遇怪概率')
            ASSERT(v.encounterMonster, '没有配置随机遇怪')

            local encounterMonster = {total = 0, data = {}}
            for i, v2 in ipairs(v.encounterMonster) do
                encounterMonster.total = encounterMonster.total + v2[2]
                v2[2] = encounterMonster.total
                table.insert(encounterMonster.data, v2)
            end

            v.encounterMonster = encounterMonster
        end

        if v.nBegTime then
            -- 期效副本开始结束时间
            v.nBegTime = GCalHelp:GetTimeStampBySplit(v.begTime, v)
            v.nEndTime = GCalHelp:GetTimeStampBySplit(v.endTime, v)
        end

        v.enterLimitHot = (v.enterCostHot or 0) + (v.winCostHot or 0)

        if v.chapterLevel and v.dungeonGroup then
            --乱序演习关卡难度
            local ccc = DungeonGroup[v.dungeonGroup]
            if ccc then
                if not ccc.randomChapters then
                    ccc.randomChapters = {}
                end

                local arr = GCalHelp:GetTb(ccc.randomChapters, v.chapterLevel, {})
                table.insert(arr, v.id)
            else
                ASSERT(false, string.format('没有该关卡组 关卡id：%s 对应的关卡组ID:%s', v.id, v.dungeonGroup))
            end
        end

        if v.roundLevel and v.type == 12 then
            -- 战力派遣
            local ccc = DungeonGroup[v.dungeonGroup]
            if not ccc then
                ASSERT(false, string.format('战力派遣没有该关卡组 关卡id：%s 对应的关卡组ID:%s', v.id, v.dungeonGroup))
            end
            if not ccc.rounds then
                ccc.rounds = {}
            end
            ccc.rounds[v.roundLevel] = v.id
        end
        if v.roundLevel and v.type == 18 then
            -- 深塔计划
            local tdgCfg = DungeonGroup[v.dungeonGroup]
            if not tdgCfg then
                ASSERT(false, string.format('深塔计划没有该关卡组 关卡id：%s 对应的关卡组ID:%s', v.id, v.dungeonGroup))
            end
            if not tdgCfg.rounds then
                tdgCfg.rounds = {}
            end
            if not tdgCfg.rounds[v.roundLevel] then
                tdgCfg.rounds[v.roundLevel] = {}
            end
            tdgCfg.rounds[v.roundLevel] = v.id
        end

        if v.type == 15 then
            -- 限制肉鸽爬塔
            local ccc = DungeonGroup[v.dungeonGroup]
            if not ccc then
                ASSERT(false, string.format('限制肉鸽爬塔没有该关卡组 关卡id：%s 对应的关卡组ID:%s', v.id, v.dungeonGroup))
            end

            ccc.rounds = GCalHelp:GetTb(ccc, 'rounds',{})

            if v.isInfinity then
                ccc.boss = v.id
            else
                ccc.rounds[v.roundLevel] = v.id
            end
        end
        if v.season and v.turn and v.type and v.type == 14 and v.weight and v.themeType then
            g_AbattoirSeason[v.season] = g_AbattoirSeason[v.season] or {}
            g_AbattoirSeason[v.season][v.turn] =  g_AbattoirSeason[v.season][v.turn] or {}

            local tCfg = {id = v.id,weight = v.weight,themeType = v.themeType}
            table.insert(g_AbattoirSeason[v.season][v.turn],tCfg)
        end

        if v.type == 17 and v.stage then
            local gpCfg = DungeonGroup[v.dungeonGroup]
            local actId = gpCfg.eventId
            if gpCfg and actId then
                g_MultTeamStageDup[actId] = g_MultTeamStageDup[actId] or {}
                g_MultTeamStageDup[actId][v.stage] = g_MultTeamStageDup[actId][v.stage] or {}
                g_MultTeamStageDup[actId][v.stage].dups = g_MultTeamStageDup[actId][v.stage].dups or {}
                local dups = g_MultTeamStageDup[actId][v.stage].dups
                dups[v.id] = true
                local dupNum = g_MultTeamStageDup[actId][v.stage].dupNum or 0
                g_MultTeamStageDup[actId][v.stage].dupNum = dupNum + 1
                g_MultTeamStageDup[actId][v.stage].groupId = g_MultTeamStageDup[actId][v.stage].groupId or v.dungeonGroup
            end

            -- g_MultTeamStageDup[v.stage] = g_MultTeamStageDup[v.stage] or {}
            -- g_MultTeamStageDup[v.stage].dups = g_MultTeamStageDup[v.stage].dups or {}
            -- local dups = g_MultTeamStageDup[v.stage].dups
            -- dups[v.id] = true
            -- local dupNum = g_MultTeamStageDup[v.stage].dupNum or 0
            -- g_MultTeamStageDup[v.stage].dupNum = dupNum + 1
            -- g_MultTeamStageDup[v.stage].groupId = g_MultTeamStageDup[v.stage].groupId or v.dungeonGroup
        end

        if v.roundLevel and v.type == 20 then
            -- 连锁战线
            local tdgCfg = DungeonGroup[v.dungeonGroup]
            if not tdgCfg then
                ASSERT(false, string.format('连锁战线没有该关卡组 关卡id：%s 对应的关卡组ID:%s', v.id, v.dungeonGroup))
            end
            if not tdgCfg.rounds then
                tdgCfg.rounds = {}
            end
            if not tdgCfg.rounds[v.roundLevel] then
                tdgCfg.rounds[v.roundLevel] = {}
            end
            tdgCfg.rounds[v.roundLevel] = v.id
        end
    end
end

function CheckFormation(formation, list)
    local map = {}
    for i = 1, 4 do
        map[i] = {}
        for j = 1, 4 do
            map[i][j] = 0
        end
    end
    -- [row][col]
    -- MonsterData.grids
    -- MonsterFormation
    local cfgFormation = MonsterFormation[formation]
    ASSERT(cfgFormation, '没有配置阵型' .. formation)
    if cfgFormation.relative == 1 then
        ASSERT(nil, '周目怪物阵型应该用绝对坐标' .. formation)
    end
    for i, v in ipairs(cfgFormation.coordinate) do
        local monsterID = list[i]
        -- ASSERT(monsterID, "阵型与怪物列表数量不一致")
        if monsterID and monsterID ~= 0 then
            local monster = MonsterData[monsterID]
            ASSERT(monster, '怪物配置不存在' .. monsterID)
            if monster.grids then
                -- 占多格
                local cfgGrids = MonsterFormation[monster.grids]
                ASSERT(cfgGrids, '没有配置阵型' .. monster.grids)
                -- if cfgGrids.relative == 0 then ASSERT(nil, "怪物占格阵型应该用相对坐标"..formation) end
                for i, coor in ipairs(cfgGrids.coordinate) do
                    local row = coor[1] + v[1]
                    local col = coor[2] + v[2]
                    -- LogDebugEx(string.format("coordinate%s, %s, %s", monsterID, row, col))
                    if cfgGrids.relative == 0 then
                        -- 绝对坐标
                        row = coor[1]
                        col = coor[2]
                    end
                    if row > 4 or col > 4 then
                        LogTable(cfgFormation)
                        LogTable(v)
                        LogTable(cfgGrids)
                        ASSERT(nil, '超出格子monsterID=' .. monsterID)
                    end
                    if map[row][col] == 1 then
                        ASSERT(nil, '格子被占用monsterID=' .. monsterID)
                    end
                    map[row][col] = 1
                end
            else
                if map[v[1]][v[2]] == 1 then
                    ASSERT(nil, '格子被占用monsterID=' .. monsterID)
                end
                map[v[1]][v[2]] = 1
            end
        end
    end
end

function ConfigChecker:MonsterGroup(cfg)
    for k, v in pairs(cfg) do
        ASSERT(v.nJump, '没有配置跳跃步数' .. v.id)
        ASSERT(v.nStep, '没有配置移动步数' .. v.id)
        for i, stage in ipairs(v.stage) do
            -- CheckFormation(stage.formation, stage.monsters)
            local ret, err = pcall(CheckFormation, stage.formation, stage.monsters)
            if err then
                LogDebugEx(string.format('MonsterGroup id[%s] 周目[%s]', v.id, i))
                LogError(err)
                ASSERT()
            end
        end

        -- 怪物等级用显示怪的等级(用数值模板的等级跟玩家一样)
        local id = v.monster
        -- LogTable(v)
        local mcfg = MonsterData[id]
        ASSERT(mcfg, '没有显示怪物的配置' .. id .. '/' .. v.id)
        v.level = mcfg.level
    end
    -- LogTable(cfg)
end

-- 光环表
function ConfigChecker:cfgHalo(cfg)
    local attr = {'attack', 'maxhp', 'defense', 'speed', 'crit_rate', 'crit', 'hit', 'resist'}
    local fixedAttr = {
        -- 4.4光环改动新增固定属性值加成，攻击防御气血按固定值加成
        [44] = 'attack_fixed',
        [45] = 'maxhp_fixed',
        [46] = 'defense_fixed',
    }
    for k, v in pairs(cfg) do
        -- 4.4 关环改动，关环站位位置改变，原有代码注释
        -- local coorHalo = {}
        -- local coordinate = v.coordinate
        -- for i = 2, #coordinate do
        --     -- local item = {coordinate[i][1] - coordinate[1][1],  coordinate[i][2] - coordinate[1][2]}
        --     table.insert(coorHalo, {coordinate[i][1] - coordinate[1][1], coordinate[i][2] - coordinate[1][2]})
        -- end
        -- v.coorHalo = coorHalo

        v.newCoorHalo = {}
        for idx, lvInfo in ipairs(v.infos) do
            if lvInfo.coorId then
                local coorCfg = cfgHaloCoordinate[lvInfo.coorId]
                ASSERT(coorCfg, "cfgHaloCoordinate表没有配置对应的ID"..lvInfo.coorId)
                local coor = coorCfg.coordinate
                v.newCoorHalo[lvInfo.coorId] = {}

                for i = 2, #coor do
                    table.insert(v.newCoorHalo[lvInfo.coorId], {coor[i][1] - coor[1][1], coor[i][2] - coor[1][2]})
                end
            end

            lvInfo.percents = {}
            lvInfo.fixedAttr = {}
            for i, attrname in pairs(attr) do
                if lvInfo[attrname] then
                    lvInfo.percents[attrname] = lvInfo[attrname]
                end
            end

            for i, attrname in pairs(fixedAttr) do
                if lvInfo[attrname] then
                    lvInfo.fixedAttr[attrname] = lvInfo[attrname]
                end
            end

        end
    end
end


-- 光环特效表
function ConfigChecker:cfgHaloEffect(cfg)
    local attr = {'attack', 'maxhp', 'defense', 'speed', 'crit_rate', 'crit', 'hit', 'resist'}
    local fixedAttr = {
        -- 4.4光环改动新增固定属性值加成，攻击防御气血按固定值加成
        [44] = 'attack_fixed',
        [45] = 'maxhp_fixed',
        [46] = 'defense_fixed',
    }

    for k, v in pairs(cfg) do
        v.percents = {}
        v.fixedAttr = {}
        for i, attrname in pairs(attr) do
            if v[attrname] then
                v.percents[attrname] = v[attrname]
            end
        end

        for i, attrname in pairs(fixedAttr) do
            if v[attrname] then
                v.fixedAttr[attrname] = v[attrname]
            end
        end
    end

end

-- 世界boss
function ConfigChecker:cfgWorldBoss(cfgs)
    if IS_CLIENT then
        return
    end

    for k, v in pairs(cfgs) do
        v.nBeginTime = GCalHelp:GetTimeStampBySplit(v.nBeginTime)
        v.nEndTime = GCalHelp:GetTimeStampBySplit(v.nEndTime)
        v.nDailyBeginTime = GCalHelp:GetTimeStampBySplit(v.nDailyBeginTime)
        v.nDailyEndTime = GCalHelp:GetTimeStampBySplit(v.nDailyEndTime)
    end
end

function ConfigChecker:CfgGuildFightSchedule(cfgs)
    if IS_CLIENT then
        return
    end

    local curTime = os.time()
    for k, oneCfg in pairs(cfgs) do
        oneCfg.nOpenTime = GCalHelp:CalTimeByArr(oneCfg.openTime, curTime)
        oneCfg.nCloseTime = GCalHelp:CalTimeByArr(oneCfg.closeTime, curTime)

        for _, v in pairs(oneCfg.infos) do
            v.nStartTime = GCalHelp:CalTimeByArr(v.startTime, curTime)
            v.nEndTime = GCalHelp:CalTimeByArr(v.endTime, curTime)
            v.nRangRewardTime = GCalHelp:CalTimeByArr(v.rangRewardTime, curTime)
            v.nFightResultRewardTime = GCalHelp:CalTimeByArr(v.fightResultRewardTime, curTime)
        end
    end

    -- LogTable(cfgs, "ConfigChecker:CfgGuildFightSchedule:")
end

function ConfigChecker:CfgBCompoundOrder(cfgs)
    for k, v in pairs(CfgBCompoundLvl) do
        v.orderIds = {}
    end

    for k, v in pairs(cfgs) do
        local cfg = CfgBCompoundLvl[v.buildLv]
        table.insert(cfg.orderIds, v.id)
    end

    local len = #CfgBCompoundLvl
    for i = 1, len, 1 do
        local curCfg = CfgBCompoundLvl[i]
        table.sort(curCfg.orderIds)

        local nextCfg = CfgBCompoundLvl[i + 1]

        if nextCfg then
            for _, val in ipairs(curCfg.orderIds) do
                table.insert(nextCfg.orderIds, val)
            end

            table.sort(nextCfg.orderIds)
        end
    end

    -- LogTable(CfgBCompoundLvl, "CfgBCompoundLvl:")
end

function ConfigChecker:CfgExpeditionTask(cfgs)
    if IS_CLIENT then
        return
    end

    for _, lvCfg in ipairs(CfgExpeditionLvl) do
        lvCfg.taskIds = {}
        lvCfg.flushDupIds = {}
    end

    -- 把需要等级的插入到等级配置里面
    for taskType, cfg in pairs(cfgs) do
        for _, subId in ipairs(cfg.subs or {}) do
            local subCfg = CfgExpeditionTaskSub[subId]
            if subCfg then
                for index, task in pairs(subCfg.tasks) do
                    local lvCfg = nil

                    if task.eventId then
                        table.sort(task.eventId)
                    end

                    if task.tFlush then
                        table.sort(task.tFlush)
                    end

                    if task.buildLv then
                        lvCfg = CfgExpeditionLvl[task.buildLv]
                    else
                        -- 不需要等级的，都放到1级去
                        lvCfg = CfgExpeditionLvl[1]
                    end

                    if task.flushDupId then
                        -- 记录关卡开通的任务，通关的时候判断用
                        for _, dupId in ipairs(task.flushDupId) do
                            local byDubIdTb = GCalHelp:GetTb(lvCfg.flushDupIds, dupId)
                            local byTypeTb = GCalHelp:GetTb(byDubIdTb, taskType)
                            local BySubIdTb = GCalHelp:GetTb(byTypeTb, subId)
                            table.insert(BySubIdTb, index)
                        end
                    else
                        -- 记录该等级下所有的任务
                        local byTypeTb = GCalHelp:GetTb(lvCfg.taskIds, taskType)
                        local byTypeSubIdTb = GCalHelp:GetTb(byTypeTb, subId)
                        table.insert(byTypeSubIdTb, index)
                    end
                end
            end
        end
    end

    local sortTasks = function(taskIds)
        for typeId, byTypes in pairs(taskIds) do
            for subId, bySubs in pairs(byTypes) do
                table.sort(bySubs)
            end
        end
    end

    -- 把不需要等级的，全部等级都放入一遍
    local arrLen = #CfgExpeditionLvl
    for i = 1, arrLen, 1 do
        local curCfg = CfgExpeditionLvl[i]

        sortTasks(curCfg.taskIds)

        local nextCfg = CfgExpeditionLvl[i + 1]

        -- 把当前的 taskIds 拷贝到下一等级去
        if nextCfg then
            for taskType, byTypes in pairs(curCfg.taskIds) do
                local nextType = GCalHelp:GetTb(nextCfg.taskIds, taskType)
                for taskSubId, subs in pairs(byTypes) do
                    local nextSubArr = GCalHelp:GetTb(nextType, taskSubId)
                    for _, val in ipairs(subs) do
                        table.insert(nextSubArr, val)
                    end
                    table.sort(nextSubArr)
                end
            end
        end
    end

    -- LogTrace("CfgExpeditionTask:")
    -- LogTable(CfgExpeditionLvl, "CfgExpeditionLvl:")
end

local checkAbilityPercent = function(cfg, abCfg, per)
    if per >= -100 and per <= 100 then
        return
    end

    LogDebug('per:%s error, must >= -100 and = 100', per)
    LogTable(cfg, 'checkAbilityPercent cfg')
    ASSERT(false)
end

local checkAbilityArrLen = function(cfg, abCfg, field, len)
    if #abCfg[field] < len then
        LogDebug('%s len less than %s', field, len)
        LogTable(cfg, 'checkAbilityArrLen cfg')
        ASSERT(false)
    end
end
local checkAbilityItem = function(cfg, abCfg, itemId)
    if not ItemInfo[itemId] then
        LogDebug('Not find item id: %s', itemId)
        LogTable(cfg, 'checkAbilityArrLen cfg')
        ASSERT(false)
    end
end

local checkOneArr = function(cfg, abCfg, field)
    local arrs = abCfg[field]
    if not arrs or type(arrs) ~= 'table' then
        LogTable(cfg, 'checkOneArr cfg ' .. field .. ' error!')
        ASSERT(false)
    end

    for _, v in ipairs(abCfg[field]) do
        if type(v) == 'table' then
            LogDebug('must one array: %s', field)
            LogTable(cfg, 'checkOneArr cfg')
            ASSERT(false)
        end
    end
end

local checkMultiArr = function(cfg, abCfg, field)
    local arrs = abCfg[field]
    if not arrs or type(arrs) ~= 'table' then
        LogTable(abCfg, 'checkMultiArr cfg ' .. field .. ' error!')
        ASSERT(false)
    end

    for _, v in ipairs(arrs) do
        if type(v) ~= 'table' then
            LogDebug('must multi array: %s', field)
            LogTable(cfg, 'checkMultiArr cfg')
            ASSERT(false)
        end
    end
end

function ConfigChecker:CfgCardRoleAbilityPool(cfgs)
    for _, cfg in pairs(cfgs) do
        if cfg.needBuildTypes then
            table.sort(cfg.needBuildTypes)
        else
            cfg.needBuildTypes = {}
        end

        for _, abCfg in ipairs(cfg.arr) do
            if cfg.type == RoleAbilityType.Controler then
                -- RoleAbilityType.Controler = 1 -- 指挥者
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
                checkOneArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.Leaderer then
                -- RoleAbilityType.Leaderer = 2 -- 领导者
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
            elseif cfg.type == RoleAbilityType.Labor then
                -- RoleAbilityType.Labor = 3 -- 专员
                checkAbilityArrLen(cfg, abCfg, 'vals', 4)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
                ASSERT(abCfg.vals[4] == 1 or abCfg.vals[4] == 2 or abCfg.vals[4] == 0)
            elseif cfg.type == RoleAbilityType.Quality then
                -- RoleAbilityType.Quality = 4 -- 质检员
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
                checkAbilityItem(cfg, abCfg, abCfg.vals[2])
                checkAbilityPercent(cfg, abCfg, abCfg.vals[3])
            elseif cfg.type == RoleAbilityType.Cost then
                -- RoleAbilityType.Cost = 5 -- 成本
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
            elseif cfg.type == RoleAbilityType.Explorer then
                -- RoleAbilityType.Explorer = 6 -- 探索员
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.Scientist then
                -- RoleAbilityType.Scientist = 7 -- 科学家 --not use
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.Fighter then
                -- RoleAbilityType.Fighter = 8 -- 战斗员
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
            elseif cfg.type == RoleAbilityType.Engineer then
                -- RoleAbilityType.Engineer = 9 -- 工程师
                checkAbilityArrLen(cfg, abCfg, 'vals', 3)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
            elseif cfg.type == RoleAbilityType.Artisan then
                -- RoleAbilityType.Artisan = 10 -- 技术员
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.Traders then
                -- RoleAbilityType.Traders = 11 -- 交易员
                checkMultiArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.OptimizeTraders then
                -- RoleAbilityType.OptimizeTraders = 12 -- 优化专员
                checkMultiArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.Seller then
                -- RoleAbilityType.Seller = 13 -- Seller
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
            elseif cfg.type == RoleAbilityType.PowerOpt then
                -- RoleAbilityType.PowerOpt = 14 -- 能源优化师
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
            elseif cfg.type == RoleAbilityType.CombineWorker then
                -- RoleAbilityType.CombineWorker = 15 -- 合成工人
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.DeepExplorer then
                -- RoleAbilityType.DeepExplorer = 16 -- 深度探索员
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.ExplorLeader then
                -- RoleAbilityType.ExplorLeader = 17 -- 探索队长
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
            elseif cfg.type == RoleAbilityType.Adventurer then
                -- RoleAbilityType.Adventurer = 18 -- 冒险家
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.SpacePirate then
                -- RoleAbilityType.SpacePirate = 19 -- 宇宙海盗
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.ActiveSeller then
                -- RoleAbilityType.ActiveSeller = 20 -- 积极销售员，除自身外，根据入驻人员增加订单数，但是其他角色能力不生效，也不扣除疲劳
            elseif cfg.type == RoleAbilityType.AloneSeller then
                -- RoleAbilityType.AloneSeller = 21 -- 独行销售员， 增加入驻上限 - 入驻人员数量 的订单数，不包括自己
            elseif cfg.type == RoleAbilityType.BuySeller then
                -- RoleAbilityType.BuySeller = 22 -- 采购员
                checkMultiArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.SupperItemer then
                -- RoleAbilityType.SupperItemer = 23 -- 高级物料员
                checkMultiArr(cfg, abCfg, 'valArrs')
                for _, lvInfo in ipairs(cfg.arr) do
                    for _, arr in ipairs(lvInfo.valArrs) do
                        table.sort(arr[3])
                    end
                end
            elseif cfg.type == RoleAbilityType.Pacifyer then
                -- RoleAbilityType.Pacifyer = 24 -- 安抚精英
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
            elseif cfg.type == RoleAbilityType.Eluder then
                -- RoleAbilityType.Eluder = 25 -- 避难专员
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.PartDev then
                -- RoleAbilityType.PartDev = 26 -- 研发专注
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
            elseif cfg.type == RoleAbilityType.OptimizeDev then
                -- RoleAbilityType.OptimizeDev = 27 -- 研发提升
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.FightCmder then
                -- RoleAbilityType.FightCmder = 28 -- 战斗指挥员
                checkMultiArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.ProductAdder then
                -- RoleAbilityType.ProductAdder = 29 -- 产能增长
                checkAbilityArrLen(cfg, abCfg, 'vals', 4)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
                checkOneArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.Storer then
                -- RoleAbilityType.Storer = 30 -- 仓管员
                checkMultiArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.Troubler then
                -- RoleAbilityType.Troubler = 31 -- 麻烦制造者
                checkMultiArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.Unityer then
                -- RoleAbilityType.Unityer = 32 -- 团结员
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.UpQuality then
                -- RoleAbilityType.UpQuality = 33 -- 质检专家
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
            elseif cfg.type == RoleAbilityType.CombineGift then
                -- RoleAbilityType.CombineGift = 34 -- 合成额外奖励能力
                checkMultiArr(cfg, abCfg, 'valArrs')
            end
        end
    end

    -- LogTable(CfgCardRoleAbilityPool, "CfgCardRoleAbilityPool:")
    -- LogTable(CfgCardRoleAbilityPool[1001], "CfgCardRoleAbilityPool 1001")
    -- LogTable(CfgCardRoleAbilityPool[1002], "CfgCardRoleAbilityPool 1002")
end

function ConfigChecker:CfgBuidingBase(cfgs)
    local buildByType = {}
    g_BuildCenterCfgId = nil

    for _, cfg in pairs(cfgs) do
        if not cfg.needAbilitys then
            cfg.needAbilitys = {}
        end
        buildByType[cfg.type] = cfg

        if cfg.type == BuildsType.ControlTower then
            g_BuildCenterCfgId = cfg.id
        end
    end

    for id, cfg in pairs(CfgCardRoleAbilityPool) do
        for _, nt in ipairs(cfg.needBuildTypes) do
            local arr = buildByType[nt]
            if arr then
                table.insert(buildByType[nt].needAbilitys, id)
            else
                LogWarning('CfgCardRoleAbilityPool 所配置的能力卡池id:' .. id .. '存在无效的建筑类型:' .. nt)
            end
        end
    end

    for _, cfg in pairs(cfgs) do
        table.sort(cfg.needAbilitys)
    end

    -- LogTable(CfgBuidingBase, "CfgBuidingBase:")
end

function ConfigChecker:CfgBControlTowerLvl(cfgs)
    if not IS_SERVER then
        return
    end

    for _, cfg in pairs(cfgs) do
        cfg.buildNumLimit = GCalHelp:ArrToMap(cfg.buildNumLimit, 1)
        -- LogTable(cfg, "cfg:")
    end
end

function ConfigChecker:CfgBProductLvl(cfgs)
    if not IS_SERVER then
        return
    end

    for _, cfg in pairs(cfgs) do
        cfg.rewardLimits = GCalHelp:ArrToMap(cfg.rewardLimits, 1)
        -- LogTable(cfg, "cfg:")
    end
end

function ConfigChecker:CfgBCompoundLvl(cfgs)
    if not IS_SERVER then
        return
    end

    for _, cfg in pairs(cfgs) do
        if cfg.rewardTimes then
            table.sort(cfg.rewardTimes)
        end
    end
end

-- 操作日志
function ConfigChecker:LogMap(cfgs)
    LogItem = {}
    for _, cfg in pairs(cfgs) do
        LogItem[cfg.key] = cfg.id
        cfg.srcText = cfg.text
        for i = 1, 10 do
            cfg.text = string.gsub(cfg.text, 'char' .. i, '%%s', 1)
            -- print(cfg.text)
        end
    end

    -- LogTable(LogItem, "LogItem")
    -- LogTable(cfgs, "LogMap")
    -- ASSERT()
end

function ConfigChecker:CfgFriendConst(cfgs)
    for _, cfg in pairs(cfgs) do
        eFriendConst[cfg.sEnum] = cfg.id
    end
end

function ConfigChecker:CfgClothes(cfgs)
    for _, cfg in pairs(cfgs) do
        if cfg.canUses then
            table.sort(cfg.canUses)
        end

        if cfg.notUses then
            table.sort(cfg.notUses)
        end
    end
end

function ConfigChecker:CfgEquip(cfgs)
    g_EquipBySuit = {}

    for _, cfg in pairs(cfgs) do
        -- 检查随机技能
        if cfg.randSkills then
            for _, randId in ipairs(cfg.randSkills) do
                local randCfg = CfgEquipRandSkill[randId]
                if not randCfg then
                    ASSERT(false, 'CfgEquip not find cfg id: ' .. randId .. ', in CfgEquipRandSkill from randSkills!')
                end

                if not next(randCfg.infos) then
                    ASSERT(false, 'CfgEquipRandSkill cfg id：' .. randId .. ' field infos is empty!')
                end
            end
        end

        if cfg.refreshLibId then
            local libCfg = CfgEquipRefreshLib[cfg.refreshLibId]
            if not libCfg then
                ASSERT(false, 'CfgEquip not find refreshLibcfg id: ' .. cfg.refreshLibId .. ', in CfgEquipRefreshLib from refreshLibId!')
            end

            if not next(libCfg.infos) then
                ASSERT(false, 'CfgEquipRefreshLib cfg id：' .. cfg.refreshLibId .. ' field infos is empty!')
            end

        end

        if cfg.suitId then
            local bySuitId = GCalHelp:GetTb(g_EquipBySuit, cfg.suitId, {})
            local byQuality = GCalHelp:GetTb(bySuitId, cfg.nQuality, {})
            table.insert(byQuality, cfg)
        end
    end

    -- 按照位置排序一下
    for suitId, infoA in pairs(g_EquipBySuit) do
        for quality, equipArr in pairs(infoA) do
            -- 按位置从小到大排序
            table.sort(
                    equipArr,
                    function(lhs, rhs)
                        return lhs.nSlot < rhs.nSlot
                    end
            )

            -- LogTable(equipArr, "equipArr:")
        end
    end
end

function ConfigChecker:CfgEquipRefreshLib(cfgs)
    -- if IS_CLIENT then
    --     return
    -- end

    for _, cfg in pairs(cfgs) do
        local arr = cfg.infos
        if not arr then
            return
        end
        local field = 'weight'
        local sumField = 'sumWeight'
        local sumWeight = 0
        cfg.mapRare = {}
        for _, info in ipairs(arr) do
            local orign = info[field]
            if not orign then
                LogError('GCalHelp:CalArrWeight not field %s', field)
            end
            info[sumField] = orign + sumWeight
            sumWeight = sumWeight + orign
            cfg.rareCnt = cfg.rareCnt or 0
            if info.isRare then
                cfg.rareCnt = cfg.rareCnt + 1
                local skillCfg = CfgEquipSkill[info.skillId]
                cfg.mapRare[info.skillId] = true
            end
            if not cfg.showRareCnt and info.showRareCnt then
                cfg.showRareCnt = info.showRareCnt
            end
        end
    end
end

function ConfigChecker:CfgEquipRandSkill(cfgs)
    if IS_CLIENT then
        return
    end

    for _, cfg in pairs(cfgs) do
        GCalHelp:CalArrWeight(cfg.infos, 'weight', 'sumWeight')

        for _, info in ipairs(cfg.infos) do
            if not info.lvCfgId then
                ASSERT(false, 'CfgEquipRandSkill cfg id: ' .. info.id .. ', lvCfgId is empty')
            end

            local lvCfg = CfgEquipRandSkillLv[info.lvCfgId]
            if not lvCfg then
                ASSERT(false, 'CfgEquipRandSkill cfg id: ' .. cfg.id .. ', lvCfgId: ' .. info.lvCfgId .. ' error')
            end
        end
    end
end

function ConfigChecker:CfgEquipRandSkillLv(cfgs)
    if IS_CLIENT then
        return
    end

    for _, cfg in pairs(cfgs) do
        GCalHelp:CalArrWeight(cfg.infos, 'weight', 'sumWeight')

        if not next(cfg.infos) then
            ASSERT(false, 'CfgEquipRandSkillLv cfg id:' .. cfg.id .. ', infos is empty')
        end
    end
end

function ConfigChecker:CfgEquipSkill(cfgs)
    g_CalExcludeSkillIds = {}

    for id, cfg in pairs(cfgs) do
        local baseId, lv = GCalHelp:GetEquipBaseIdAndLv(cfg.id)

        -- 将等级上限保存在一级技能id后边
        local baseCfg = cfgs[baseId]
        if not baseCfg.maxLv or lv > baseCfg.maxLv then
            baseCfg.maxLv = lv
        end

        -- 暂时可以重复，取消检测
        -- local skilInfo = skill[id]
        -- if skilInfo then
        --     ASSERT(false, "装备技能id, 与技能表id重复，值为：" .. id)
        -- end
        if cfg.nExcludeId and cfg.nType == EquipSkillType.Fight and cfg.nGetSkillId then
            g_CalExcludeSkillIds[id] = {nExcludeId = cfg.nExcludeId, nEquipSkillId = id, nSkillId = cfg.nGetSkillId}
        end
    end

    if IS_SERVER and not IS_CLIENT then
        LogTable(g_CalExcludeSkillIds, "g_CalExcludeSkillIds:")
    end    
end

function CalCardPoolIdByCnt(jCfg)
    local ret = {}
    if jCfg then
        -- LogTable(jCfg, "GobalCfg:CalIdByCnt:")
        for _, v in pairs(jCfg) do
            local cnt, rewardId = v[1], v[2]
            -- 操作次数, 使用id
            if 0 == cnt then
                ret.default = rewardId
            elseif -1 == cnt then
                ret.first10 = rewardId
            else
                ret[cnt] = rewardId
            end
        end
    end

    return ret
end

function ConfigChecker:CfgCardPool(cfgs)
    g_defSelCardPoolIdArr = {}
    g_gobalOpenCardPoolIdArr = {}
    g_fixTimeOpenCardPoolIdArr = {}

    for id, cfg in pairs(cfgs) do
        if cfg.childIds then
            for _, arr in ipairs(cfg.childIds) do
                local cnt, cid = arr[1], arr[2]
                if not cfgs[cid] then
                    ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中的 childIds 字段的子id:%s 在配置表中找不到', id, cid))
                end
            end

            if cfg.nType ~= CardPoolType.GobalCreateCnt then
                ASSERT(false, string.format('CfgCardPool 配置表 id :%s 的卡池类型应该为3', id))
            end
        end

        if cfg.nType == CardPoolType.JustFinish and not cfg.nSort then
            ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中的 nSort 为空', id))
        end

        if cfg.nType == CardPoolType.FixTimeFirstLogin then
            if not cfg.duration or cfg.duration < 1 then
                ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中的 duration 不允许为 %s', id, cfg.duration))
            end

            if not cfg.plrCreateTime then
                ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中的 plrCreateTime 为空', id))
            end

            cfg.nPlrCreateTime = GCalHelp:GetTimeStampBySplit(cfg.plrCreateTime, cfg)
        end

        -- 查看奖励
        local hadFirstReward = false
        for _, arr in ipairs(cfg.jCardsId) do
            -- LogTable(cfg, "ConfigChecker:CfgCardPool cfg:")
            local cnt, rewardId = arr[1], arr[2]
            if not RewardInfo[rewardId] then
                ASSERT(
                        false,
                        string.format('CfgCardPool 配置表 id :%s 中 jCardsId 的 rewardId:%s 在奖励表 RewardInfo 中找不到', id, rewardId)
                )
            end

            if cnt == -1 then
                hadFirstReward = true
            end
        end

        if cfg.nFirstTryCnt then
            if not cfg.nFirstLogCnt or cfg.nFirstLogCnt < 1 then
                ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中配置了 nFirstLogCnt 那么 nFirstLogCnt 不能为0，且需要配置', id))
            end
        end

        if hadFirstReward then
            if not cfg.nFirstTryCnt then
                ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中没有配置 nFirstLogCnt, 但是配置了新手10首抽奖励', id))
            end
        else
            if cfg.nFirstTryCnt then
                ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中配置了 nFirstLogCnt, 但是没有配置了新手10首抽奖励', id))
            end
        end

        if cfg.sel_card_ids then
            table.sort(cfg.sel_card_ids)
        end

        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.sStart, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.sEnd, cfg)

        if IS_SERVER then
            -- 额外卡池奖励模板
            cfg.rewardIdInfos = CalCardPoolIdByCnt(cfg.jCardsId)

            -- 额外奖励
            cfg.exRewardIdInfos = CalCardPoolIdByCnt(cfg.jReward)

            -- 设置父卡池id
            if cfg.childIds then
                for ix, arr in ipairs(cfg.childIds) do
                    local cId = arr[2]
                    local cCfg = CfgCardPool[cId]
                    cCfg.parentId = id
                end
                table.insert(g_gobalOpenCardPoolIdArr, id)
            end

            if cfg.def_sel_card_ix and cfg.sel_quality and cfg.sel_card_ids then
                if not table.empty(cfg.sel_card_ids) and cfg.def_sel_card_ix <= #cfg.sel_card_ids then
                    if not cfg.nEnd or cfg.nEnd == 0 or cfg.nEnd > CURRENT_TIME then
                        table.insert(g_defSelCardPoolIdArr, id)
                        LogDebug(
                                string.format(
                                        'CardGetLog:CheckInitData() cfg.nStart:%s, cfg.nEnd:%s add to defSelCardPoolIdArr',
                                        cfg.nStart,
                                        cfg.nEnd
                                )
                        )
                    end
                end
            end

            if cfg.nType == CardPoolType.FixTimeFirstLogin then
                table.insert(g_fixTimeOpenCardPoolIdArr, id)
            end
        end
    end
end

function ConfigChecker:CfgDorm(cfgs)
    for _, cfg in pairs(cfgs) do
        if cfg.id < 1 or cfg.id >= 100 then
            ASSERT(false, string.format('CfgDorm 配置表 id 为:%s, id允许范围为 0 < id < 100', cfg.id))
        end

        for _, info in pairs(cfg.infos) do
            if info.index < 1 or info.index >= 100 then
                ASSERT(
                        false,
                        string.format('CfgDorm 配置表 id 为:%s index 为: %s, index 允许范围为 0 < index < 100', cfg.id, info.index)
                )
            end
        end
    end
end

function ConfigChecker:CfgExploration(cfgs)
    -- LogTable(cfgs, "ConfigChecker:CfgExploration:")
    for id, cfg in pairs(cfgs) do
        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
    end
end

function ConfigChecker:ItemInfo(cfgs)
    GCfgEquipItemId = {}

    g_toItemArr = {}
    g_MainThemeUILong = {}

    for id, cfg in pairs(cfgs) do
        if cfg.to_item_id then
            ASSERT(cfgs[cfg.to_item_id], string.format('ConfigChecker:ItemInfo(cfgs) 物品id:%s, 的 to_item_id:%s 找不到物品配置信息', id, cfg.to_item_id))
            local arr = GCalHelp:GetTb(g_toItemArr, cfg.to_item_id)
            table.insert(arr, id)
        end

        if cfg.sExpiry then
            cfg.nExpiry = GCalHelp:GetTimeStampBySplit(cfg.sExpiry, cfg)
            ASSERT(cfg.expiryIx, string.format('ConfigChecker:ItemInfo(cfgs) 物品id:%s, 的 sExpiry 与 expiryIx, 必须都填', id))
        end

        if cfg.expiryIx then
            ASSERT(cfg.sExpiry and cfg.sExpiry ~= '', string.format('ConfigChecker:ItemInfo(cfgs) 物品id:%s, 的 sExpiry 与 expiryIx, 必须都填', id))
        end

        if cfg.exipiry_type then
            if cfg.exipiry_type[1] < 1 or cfg.exipiry_type[1] > 3 then
                ASSERT(false, string.format('ConfigChecker:ItemInfo(cfgs) 物品id:%s, 的 exipiry_type 类型错误', id, cfg.to_item_id))
            end
        end

        if cfg.type == ITEM_TYPE.ICON_FRAME then
            local frameCfg = AvatarFrame[cfg.dy_value2]
            if frameCfg then
                ASSERT(not frameCfg.item_id, string.format('ConfigChecker:ItemInfo(cfgs) 该头像框id=%s已有对应的物品id=%s,头像框配置冲突', cfg.dy_value2, id))
                frameCfg.item_id = id
            else
                ASSERT(false, string.format('ConfigChecker:ItemInfo(cfgs) 头像框表里找不到该物品id:%s对应的头像框id：%s', id, cfg.dy_value2))
            end

        elseif cfg.type == ITEM_TYPE.DORM_PET then
            local petCfg = CfgDormPet[cfg.dy_value1]
            if petCfg then
                ASSERT(not petCfg.item_id, string.format('ConfigChecker:ItemInfo(cfgs) 该宿舍宠物id=%s已有对应的物品id=%s,配置冲突', cfg.dy_value1, id))
                petCfg.item_id = id
            else
                ASSERT(false, string.format('ConfigChecker:ItemInfo(cfgs) 宿舍宠物表里找不到该物品id:%s对应的宿舍宠物id：%s', id, cfg.dy_value1))
            end
        elseif cfg.type == ITEM_TYPE.CARD then
            local cardCfg = CardData[cfg.dy_value1]
            if not cardCfg then
                ASSERT(false, string.format('ConfigChecker:ItemInfo(cfgs) 角色CardData表里找不到该物品id:%s对应的卡牌id：%s', id, cfg.dy_value1))
            end
            cardCfg.itemId = id
        elseif cfg.type == ITEM_TYPE.ICON then
            local avatarCfg = CfgAvatar[cfg.dy_value2]
            if avatarCfg then
                ASSERT(not avatarCfg.item_id, string.format('ConfigChecker:ItemInfo(cfgs) 该头像id=%s已有对应的物品id=%s,头像表配置冲突', cfg.dy_value2, id))
                avatarCfg.item_id = id
            else
                ASSERT(false, string.format('ConfigChecker:ItemInfo(cfgs) 头像表里找不到该物品id:%s对应的头像框id：%s', id, cfg.dy_value2))
            end
        elseif cfg.type == ITEM_TYPE.ICON_TITLE then
            local titleCfg = CfgIconTitle[cfg.dy_value2]
            if titleCfg then
                ASSERT(not titleCfg.item_id, string.format('ConfigChecker:ItemInfo(cfgs) 该称号id=%s已有对应的物品id=%s,称号表配置冲突', cfg.dy_value2, id))
                titleCfg.item_id = id
            else
                ASSERT(false, string.format('ConfigChecker:ItemInfo(cfgs) 称号表里找不到该物品id:%s对应的玩家称号id：%s', id, cfg.dy_value2))
            end
        elseif cfg.type == ITEM_TYPE.ICON_EMOTE then
            local emoteCfg = CfgIconEmote[cfg.dy_value2]
            if emoteCfg then
                ASSERT(not emoteCfg.item_id, string.format('ConfigChecker:ItemInfo(cfgs) 该战斗表情id=%s已有对应的物品id=%s,玩家表情表配置冲突', cfg.dy_value2, id))
                emoteCfg.item_id = id
            else
                ASSERT(false, string.format('ConfigChecker:ItemInfo(cfgs) 表情表里找不到该物品id:%s对应的玩家表情id：%s', id, cfg.dy_value2))
            end
        elseif cfg.type == ITEM_TYPE.BG_ITEM then
            local menuBgCfg = CfgMenuBg[cfg.dy_value1]
            if menuBgCfg then
                ASSERT(not menuBgCfg.item_id, string.format('ConfigChecker:ItemInfo(cfgs) 该主界面背景id=%s已有对应的物品id=%s,主界面背景表配置冲突', cfg.dy_value1, id))
                menuBgCfg.item_id = id
            else
                ASSERT(false, string.format('ConfigChecker:ItemInfo(cfgs) 主界面背景表里找不到该物品id:%s对应的主界面背景id：%s', id, cfg.dy_value1))
            end
        elseif cfg.type == ITEM_TYPE.EQUIP then
            if cfg.dy_value1 then
                GCfgEquipItemId[cfg.dy_value1] = id
            end
        elseif cfg.type == ITEM_TYPE.PROP then
            if cfg.dy_value1 == PROP_TYPE.IconFrame then
                local item_id = cfg.dy_arr[1]
                local iconFrameItem = cfgs[item_id]
                ASSERT(
                        iconFrameItem.dy_value2 == cfg.dy_value2,
                        string.format(
                                'ConfigChecker:ItemInfo(cfgs) 头像框道具id:%s的对应的头像框id:%s 与 使用后获得的头像框物品id:%s对应的头像框id：%s 不符',
                                id,
                                cfg.dy_value2,
                                item_id,
                                iconFrameItem.dy_value2
                        )
                )
                ASSERT(
                        iconFrameItem.type == ITEM_TYPE.ICON_FRAME,
                        string.format('ConfigChecker:ItemInfo(cfgs) 道具id:%s的物品对应的头像框物品:%s，类型不对', id, item_id)
                )
            elseif cfg.dy_value1 == PROP_TYPE.Icon then
                local item_id = cfg.dy_arr[1]
                local iconItem = cfgs[item_id]
                ASSERT(
                        iconItem.dy_value2 == cfg.dy_value2,
                        string.format(
                                'ConfigChecker:ItemInfo(cfgs) 头像道具id:%s的对应的头像id:%s 与 使用后获得的头像物品id:%s对应的头像id：%s 不符',
                                id,
                                cfg.dy_value2,
                                item_id,
                                iconItem.dy_value2
                        )
                )
                ASSERT(iconItem.type == ITEM_TYPE.ICON, string.format('ConfigChecker:ItemInfo(cfgs) 道具id:%s的物品对应的头像物品:%s，类型不对', id, item_id))
            elseif cfg.dy_value1 == PROP_TYPE.Pet then
                ASSERT(CfgPet[cfg.dy_value2], string.format("ConfigChecker:ItemInfo(cfgs) 宠物道具id：%s使用后获得的宠物在宠物表没有对应的id：%s", id, cfg.dy_value2))
            elseif cfg.dy_value1 == PROP_TYPE.PetItem then
                ASSERT(CfgPetItem[cfg.dy_value2], string.format("ConfigChecker:ItemInfo(cfgs) 宠物道具id：%s使用后获得的宠物物品在宠物物品表没有对应的id：%s", id, cfg.dy_value2))
            elseif cfg.dy_value1 == PROP_TYPE.PetArchive then
                ASSERT(CfgPetArchive[cfg.dy_value2], string.format("ConfigChecker:ItemInfo(cfgs) 宠物道具id：%s使用后获得的宠物图鉴在宠物图鉴表没有对应的id：%s", id, cfg.dy_value2))
            elseif cfg.dy_value1 == PROP_TYPE.Music then
                    ASSERT(cfg.dy_value2, string.format("ConfigChecker:ItemInfo(cfgs) 物品id：%s使用后获得的音乐在ItemInfo没配dy_value2", id))
                    ASSERT(CfgMusic[cfg.dy_value2], string.format("ConfigChecker:ItemInfo(cfgs) 音乐id：%s使用后获得的音乐在音乐表[CfgMusic]没有对应的id：%s", id, cfg.dy_value2))
            elseif cfg.dy_value1 == PROP_TYPE.IconTitle then
                local item_id = cfg.dy_arr[1]
                local iconItem = cfgs[item_id]
                ASSERT(
                        iconItem.dy_value2 == cfg.dy_value2,
                        string.format(
                                'ConfigChecker:ItemInfo(cfgs) 称号道具id:%s的对应的称号id:%s 与 使用后获得的称号物品id:%s对应的称号id：%s 不符',
                                id,
                                cfg.dy_value2,
                                item_id,
                                iconItem.dy_value2
                        )
                )
                ASSERT(iconItem.type == ITEM_TYPE.ICON_TITLE, string.format('ConfigChecker:ItemInfo(cfgs) 道具id:%s的物品对应的称号物品:%s，类型不对', id, item_id))
            end
        elseif cfg.type == ITEM_TYPE.VOUCHER then
            if cfg.dy_value1 then
                if not CfgVoucher[cfg.dy_value1] then
                    ASSERT(false, string.format('ConfigChecker:ItemInfo(cfgs) 物品%s 的 dy_value1 配置的抵扣券id, 在 CfgVoucher 表中找不到配置', cfg.id, cfg.dy_value1))
                end
            else
                ASSERT(false, string.format('ConfigChecker:ItemInfo(cfgs) 物品%s的 dy_value1 为抵扣券id，没有填写', cfg.id))
            end
        elseif cfg.type == ITEM_TYPE.MAIN_THEME_UI and not cfg.effectiveTime then
            local themeId = cfg.dy_value2 or cfg.dy_value1
            local themeCfg = CfgUiTheme[themeId]
            if themeCfg then
                g_MainThemeUILong[themeCfg.id] = cfg.id
            end
        end

        -- cfg.hide : 只导出了客户端
        if IS_CLIENT and not cfg.hide then
            if cfg.type == ITEM_TYPE.CARD then
                ASSERT(
                        CardData[cfg.dy_value1],
                        'ConfigChecker:ItemInfo(cfgs) 物品表的: dy_value1:' .. (cfg.dy_value1 or 'empty') .. ', item.id为:' .. id .. ', 表 CardData 找不到配置！'
                )
            elseif cfg.type == ITEM_TYPE.EQUIP then
                ASSERT(
                        CfgEquip[cfg.dy_value1],
                        'ConfigChecker:ItemInfo(cfgs) 物品表的: dy_value1:' .. (cfg.dy_value1 or 'empty') .. ', item.id为:' .. id .. ', 表 CfgEquip 找不到配置！'
                )
            elseif cfg.type == ITEM_TYPE.SKIN then
            end
        end
        if cfg.dy2Times then
            cfg.dy2StartTimes = GCalHelp:GetTimeStampBySplit(cfg.dy2Times, cfg)
        end

    end
end

function ConfigChecker:AvatarFrame(cfgs)
    for id, cfg in pairs(cfgs) do
        -- id ==1 默认头像框，无对应物品id
        if id ~= 1 then
            ASSERT(cfg.item_id, string.format('头像框id:%s无对应的的物品id,配置不对', id))
        end
    end
end

function ConfigChecker:CfgAvatar(cfgs)
    for id, cfg in pairs(cfgs) do
        -- 道具头像要有对应的物品id
        ASSERT(cfg.item_id, string.format('头像id:%s无对应的的物品id,配置不对', id))
    end
end

function ConfigChecker:CfgIconTitle(cfgs)
    for id, cfg in pairs(cfgs) do
        -- 称号要有对应的物品id
        if id ~= 1 then
            ASSERT(cfg.item_id, string.format('称号id:%s无对应的的物品id,配置不对', id))
        end
    end
end

function ConfigChecker:CfgIconEmote(cfgs)
    g_IconEmotesDefault = {}
    for id, cfg in pairs(cfgs) do
        -- 玩家表情要有对应的表情ID
        -- if id ~= 1 then
        ASSERT(cfg.item_id, string.format('表情id:%s无对应的的物品id,配置不对', id))
        -- end
        if cfg.is_Open == 1 then
            table.insert(g_IconEmotesDefault, cfg.item_id)
        end
    end
end

function ConfigChecker:CfgMenuBg(cfgs)
    g_MenuBGDefault = {}
    for id, cfg in pairs(cfgs) do
        -- 主界面背景要有对应的物品id
        ASSERT(cfg.item_id, string.format('主界面背景id:%s无对应的的物品id,配置不对', id))
        if cfg.is_Open == 1 then
            table.insert(g_MenuBGDefault, cfg.item_id)
        end
    end
end

function ConfigChecker:CfgActive(cfgs)
    for k, v in pairs(cfgs) do
        if v.begTime then
            v.nBegTime = GCalHelp:GetTimeStampBySplit(v.begTime, v)
        end
        if v.endTime then
            v.nEndTime = GCalHelp:GetTimeStampBySplit(v.endTime, v)
        end
    end
end

function ConfigChecker:CfgActiveEntry(cfgs)
    if IS_SERVER then
        local battleEndTimeTable = {}
        for _, v in pairs(cfgs) do

            ASSERT(v.begTime, string.format("CfgActiveEntry() not begTime:%s", v.begTime))
            v.nBegTime = GCalHelp:GetTimeStampBySplit(v.begTime, v)

            ASSERT(v.endTime, string.format("CfgActiveEntry() not nEndTime:%s", v.endTime))
            v.nEndTime = GCalHelp:GetTimeStampBySplit(v.endTime, v)

            if v.hardBegTime then
                v.nHardBegTime = GCalHelp:GetTimeStampBySplit(v.hardBegTime, v)
            end

            if v.exBegTime then
                v.nExBegTime = GCalHelp:GetTimeStampBySplit(v.exBegTime, v)
            end

            if v.battleendTime then
                v.nBattleendTime = GCalHelp:GetTimeStampBySplit(v.battleendTime, v)
                if v.config and v.nConfigID then
                    local config_table = _G[v.config]
                    if v.period and v.period == 2 then
                        local tarCfg = config_table[v.nConfigID]
                        --LogTable(tarCfg, "config_table")
                        if tarCfg.infos then
                            for _, info in ipairs(tarCfg.infos) do
                                if info.sectionID then
                                    battleEndTimeTable[info.sectionID] = v.nBattleendTime
                                end
                            end
                        end
                    else
                        if config_table and config_table[v.nConfigID] then
                            local tar_config = config_table[v.nConfigID]
                            if tar_config.sectionID then

                                if not battleEndTimeTable[tar_config.sectionID] then
                                    battleEndTimeTable[tar_config.sectionID] = v.nBattleendTime
                                else
                                    LogI('CfgActiveEntry sectionID出现重复,id:' .. v.id .. ',config:' .. v.config .. ',nConfigID:' .. v.nConfigID)
                                end
                            end
                        end
                    end
                end
            end

            if v.resetIx then
                v.resetTime = GCalHelp:GetTimeStampBySplit(v.resetIx, v)
                LogDebugEx("CHECK V.v.resetIx", v.resetIx, v.resetTime)
            end

            _G['DupActiveBattleEndTime'] = battleEndTimeTable
        end
    end
end

function ConfigChecker:CfgCardElem(cfgs)
    for k, cfg in pairs(cfgs) do
        for groupId, info in pairs(cfg.infos) do
            local gCfg = CfgCardElemGroup[groupId]
            info.minGetCnt = gCfg.MinTimes or 0
            info.maxGetCnt = gCfg.MaxTimes or MAX_UNSIGNED_INT
        end
    end
end

function ConfigChecker:CfgCardRoleUpgrade(cfgs)
    if IS_CLIENT then
        local sumNeedExp = 0
        for i, cfg in ipairs(cfgs) do
            if sumNeedExp ~= cfg.mExp then
                local msg =
                string.format('CfgCardRoleUpgrade, id:%s, mExp:%s is wrong, will be %s', i, cfg.mExp, sumNeedExp)
                assert(fasle, msg)
            end

            if cfg.nExp then
                sumNeedExp = sumNeedExp + cfg.nExp
            end
        end
    end
end

function ConfigChecker:CfgLimitedTime(cfgs)
    -- 计算操作
    for _, v in pairs(cfgs) do
        if v.times then
            local times = SplitString(v.times, '-')
            if times then
                local start_time = times[1]
                if start_time then
                    local start_times = SplitString(start_time, ':')
                    if start_times and #start_times == 3 then
                        local s_time = {}
                        s_time.time = start_time
                        s_time.time_h = start_times[1]
                        s_time.time_m = start_times[2]
                        s_time.time_s = start_times[3]
                        v.s_time = s_time
                    end
                end

                local end_time = times[2]
                if end_time then
                    local end_times = SplitString(end_time, ':')
                    if end_times and #end_times == 3 then
                        local e_time = {}
                        e_time.time = end_time
                        e_time.time_h = end_times[1]
                        e_time.time_m = end_times[2]
                        e_time.time_s = end_times[3]
                        v.e_time = e_time
                    end
                end
            end
        end
    end
end

function ConfigChecker:CfgDySetOpenCfgs(cfgs)
    for _, cfg in pairs(cfgs) do
        local cfgName = cfg.id
        local cfgStructInfo = ConfigParser.m_mapTableInfo[cfgName]
        -- LogTable(cfgStructInfo, "ConfigChecker:CfgDySetOpenCfgs cfgStructInfo:")

        cfg.key = nil
        cfg.sheetName = cfgStructInfo.sheetname

        -- 这个控制的字段，后端不一定有，但是前端一定需要有的，因为是更新给前端用的
        if IS_SERVER then
            if cfg.show_ids then
                table.sort(cfg.show_ids)
            end
        else
            -- IS_CLIENT
            -- IS_SERVER
            local fields = cfg.fields
            local checkCfgs = _G[cfgName]

            local _, checkCfg = next(checkCfgs)

            for _, info in pairs(fields) do
                if info.sub_tb then
                    local _, subCheckCfg = next(checkCfg[info.sub_tb])
                    ASSERT(
                            subCheckCfg,
                            string.format('CfgDySetOpenCfgs 配置的表格 %s 的 %s 中的字段 %s 找不到', cfgName, info.sub_tb, info.field)
                    )

                    if not GCalHelp:FindArrByFor(cfgStructInfo.names, info.sub_tb) then
                        ASSERT(false, string.format('CfgDySetOpenCfgs 配置的表格 %s 中的字段 %s 找不到', cfgName, info.sub_tb))
                    end

                    if info.sub_index_type then
                        if info.sub_index_type ~= 'number' and info.sub_index_type ~= 'string' then
                            ASSERT(
                                    false,
                                    string.format(
                                            'CfgDySetOpenCfgs 配置的表格 %s 中的字段 %s, sub_index_type 只能是 string or number',
                                            cfgName,
                                            info.field
                                    )
                            )
                        end
                    else
                        ASSERT(
                                false,
                                string.format('CfgDySetOpenCfgs 配置的表格 %s 中的字段 %s 没有配置 sub_index_type', cfgName, info.sub_tb)
                        )
                    end
                end

                if not info.field_type then
                    ASSERT(false, string.format('CfgDySetOpenCfgs 配置的表格 %s 中的字段 field_type 没有配置', cfgName))
                else
                    if
                    info.field_type ~= 'date' and info.field_type ~= 'json' and info.field_type ~= 'number' and
                            info.field_type ~= 'string' and
                            info.field_type ~= 'bool'
                    then
                        ASSERT(false, string.format('CfgDySetOpenCfgs 配置的表格 %s 中的字段 %s 不正确', cfgName, info.field_type))
                    end
                end

                if not GCalHelp:FindArrByFor(cfgStructInfo.names, info.field) then
                    ASSERT(false, string.format('CfgDySetOpenCfgs 配置的表格 %s 中的字段 %s 找不到', cfgName, info.field))
                end
            end
        end
    end
end

function ConfigChecker:CfgActiveList(cfgs)
    g_ActiveSign_2 = {}
    g_OpenConditionRecordTime = {}
    g_Open_SkinRebate = {}
    for _, fCfg in pairs(cfgs) do
        if fCfg.sTime then
            fCfg.nStartTime = GCalHelp:GetTimeStampBySplit(fCfg.sTime, fCfg)
        end
        if fCfg.eTime then
            fCfg.nEndTime = GCalHelp:GetTimeStampBySplit(fCfg.eTime, fCfg)
        end
        if fCfg.data then
            fCfg.resetKey = GCalHelp:GetTimeStampBySplit(fCfg.data, fCfg)
        end
        if fCfg.info and fCfg.info.signInId then
            g_ActiveSign_2[fCfg.info.signInId] = fCfg.id
        end
        if fCfg.time and not table.empty(fCfg.time) then
            table.insert(g_OpenConditionRecordTime, fCfg.id)
        end
        if fCfg.type == ActivityListType.SkinRebate then
            if fCfg.nEndTime == 0 or fCfg.nEndTime > CURRENT_TIME then
                g_Open_SkinRebate[fCfg.info.skinId] = true
            end
        end
    end
end

function ConfigChecker:CfgSpecialDrops(cfgs)
    g_RtHotItemToGroup = {}
    for _, fCfg in pairs(cfgs) do
        if fCfg.DropsStartTime then
            fCfg.nStartTime = GCalHelp:GetTimeStampBySplit(fCfg.DropsStartTime, fCfg)
        end
        if fCfg.DropsEndTime then
            fCfg.nEndTime = GCalHelp:GetTimeStampBySplit(fCfg.DropsEndTime, fCfg)
        end
        if fCfg.ReturnHot then
            g_RtHotItemToGroup[fCfg.ReturnHot] = fCfg.id
        end
    end
end

function ConfigChecker:CfgThemeLayout(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.mFurniture = {}
        for _, info in pairs(cfg.infos) do
            local cfgId = info.cfgID
            local val = cfg.mFurniture[cfgId] or 0
            cfg.mFurniture[cfgId] = val + 1
        end
    end
end

function ConfigChecker:CfgCommodity(cfgs)
    g_CanByShop = {shop = {}, tab = {}}
    g_CheckTimeShop = {shop = {}, tab = {}}
    -- 返利卡的皮肤商品组
    g_SkinIDShop = {}
    -- 共用记录的商品组
    g_GroupShop = {}
    --分段上架的商品组
    g_SplitTimeShop = {}

    -- 记录所有需要支付的商品id
    g_ShopIsPayIds = {}

    -- 计算操作
    for id, v in pairs(cfgs) do
        local isPayCommodity = false
        for _, costKey in pairs(ShopPriceKey) do
            if (v[costKey] and v[costKey][1] and v[costKey][1][1] and v[costKey][1][1] == -1) then
                table.insert(g_ShopIsPayIds, id)
                if isPayCommodity then
                    ASSERT(false, string.format('商品id：%s 的jcost和jcost1不允许都为-1直购', v.id))
                end
                isPayCommodity = true
            end
        end

        v.limitedTimes = {}
        v.limitedWeek = {}
        v.nDiscountStart = GCalHelp:GetTimeStampBySplit(v.sDiscountStart, v)
        v.nDiscountEnd = GCalHelp:GetTimeStampBySplit(v.sDiscountEnd, v)

        v.nBuyStart = GCalHelp:GetTimeStampBySplit(v.sBuyStart, v)
        v.nBuyEnd = GCalHelp:GetTimeStampBySplit(v.sBuyEnd, v)
        if v.jCosts and not table.empty(v.jCosts) and v.jCosts1 and not table.empty(v.jCosts1) then
            local cost1 = v.jCosts[1]
            if cost1[1] ~= -1 then
                ASSERT(false, string.format('商品id：%s 直购的默认消耗配的不是-1', v.id))
            end
        end

        if v.limitedTimeID then
            if v.nBuyStart > 0 or v.nBuyEnd > 0 then
                ASSERT(false, string.format('CfgCommodity 的 v.id = %s，配置了limitedTimeID，不需要配v.sBuyStart和v.sBuyEnd', v.id))
                break
            end

            local limitedTimes = SplitString(v.limitedTimeID, ',')
            if limitedTimes and #limitedTimes > 0 then
                v.limitedTimes = limitedTimes
                for _, limitedTime in pairs(limitedTimes) do
                    local tarLimit = CfgLimitedTime[tonumber(limitedTime)]
                    if tarLimit then
                        if tarLimit.times then
                            local times = SplitString(tarLimit.times, '-')
                            if times then
                                local start_time = times[1]
                                if start_time then
                                    local start_times = SplitString(start_time, ':')
                                    if start_times and #start_times == 3 then
                                        local s_time = {}
                                        s_time.time = start_time
                                        s_time.time_h = start_times[1]
                                        s_time.time_m = start_times[2]
                                        s_time.time_s = start_times[3]
                                        tarLimit.s_time = s_time
                                    end
                                end

                                local end_time = times[2]
                                if end_time then
                                    local end_times = SplitString(end_time, ':')
                                    if end_times and #end_times == 3 then
                                        local e_time = {}
                                        e_time.time = end_time
                                        e_time.time_h = end_times[1]
                                        e_time.time_m = end_times[2]
                                        e_time.time_s = end_times[3]
                                        tarLimit.e_time = e_time
                                    end
                                end

                                if tarLimit.s_time and tarLimit.e_time then
                                    local startTime = GCalHelp:GetTimestampByTime(tarLimit.s_time.time_h, tarLimit.s_time.time_m, tarLimit.s_time.time_s)
                                    local endTime = GCalHelp:GetTimestampByTime(tarLimit.e_time.time_h, tarLimit.e_time.time_m, tarLimit.e_time.time_s)

                                    if startTime >= endTime then
                                        assert(false, string.format('CfgLimitedTime 的 id = %s，开始时间：%s 必须小于结束时间：%s 晚', tarLimit.id, tarLimit.s_time.time, tarLimit.e_time.time))
                                    end
                                end


                            end
                        end


                        if not v.limitedWeek[tarLimit.week] then
                            v.limitedWeek[tarLimit.week] = {}
                        end
                        v.limitedWeek[tarLimit.week][tarLimit.id] = tarLimit
                    end
                end

                local target = {}
                for week, val in pairs(v.limitedWeek) do
                    local timeWeek = {}
                    local limitedWeekTable = {}
                    for _, time in pairs(val) do
                        local startTime = GCalHelp:GetTimestampByTime(time.s_time.time_h, time.s_time.time_m, time.s_time.time_s)
                        table.insert(timeWeek, startTime)
                        limitedWeekTable[startTime] = time
                        --LogI("id:%s,week:%s,times:%s", time.id, time.week, time.times)
                    end

                    table.sort(timeWeek)
                    target[week] = {}
                    for _, startTime in pairs(timeWeek) do
                        local time = limitedWeekTable[startTime]
                        table.insert(target[week], time)
                    end

                end
                v.limitedWeek = target
            end
            if v.group then
                if v.tabID then
                    if not g_CheckTimeShop.tab[v.group] then
                        g_CheckTimeShop.tab[v.group] = {}
                    end
                    if not g_CheckTimeShop.tab[v.group][v.tabID] then
                        g_CheckTimeShop.tab[v.group][v.tabID] = {}
                    end
                    table.insert(g_CheckTimeShop.tab[v.group][v.tabID], v.id)
                else
                    if not g_CheckTimeShop.shop[v.group] then
                        g_CheckTimeShop.shop[v.group] = {}
                    end
                    table.insert(g_CheckTimeShop.shop[v.group], v.id)
                end
            end
        else
            --if v.nBuyEnd == 0 or CURRENT_TIME < v.nBuyEnd then
            --
            --end
            if v.group then
                if v.tabID then
                    if not g_CanByShop.tab[v.group] then
                        g_CanByShop.tab[v.group] = {}
                    end
                    if not g_CanByShop.tab[v.group][v.tabID] then
                        g_CanByShop.tab[v.group][v.tabID] = {}
                    end
                    table.insert(g_CanByShop.tab[v.group][v.tabID], v.id)
                else
                    if not g_CanByShop.shop[v.group] then
                        g_CanByShop.shop[v.group] = {}
                    end
                    table.insert(g_CanByShop.shop[v.group], v.id)
                end
            end
        end

        if v.skinID then
            if not g_SkinIDShop[v.skinID] then
                g_SkinIDShop[v.skinID] = {}
            end
            table.insert(g_SkinIDShop[v.skinID], v.id)

            if not v.rewardID then
                assert(false, string.format('CfgCommodity 的 id = %s 配置了皮肤组编号，返利奖励物品不允许为空', v.id))
            end
        end

        if v.shopGroupID then
            if not g_GroupShop[v.shopGroupID] then
                g_GroupShop[v.shopGroupID] = {}
            end
            table.insert(g_GroupShop[v.shopGroupID], v.id)
        end

        if v.sSplitTime then
            if not g_SplitTimeShop[v.sSplitTime] then
                g_SplitTimeShop[v.sSplitTime] = {}
            end
            table.insert(g_SplitTimeShop[v.sSplitTime], v.id)

            if v.sBuyStart or v.sBuyEnd then
                assert(false, string.format('CfgCommodity 的 id = %s 配置了多时段，不需要再配开始结束时间', v.id))
            end
        end
    end
end

function ConfigChecker:CfgShopTab(cfgs)
    g_CfgShopTabOpenTime = {}
    for _, v in pairs(cfgs) do
        if not g_CfgShopTabOpenTime[v.group] then
            g_CfgShopTabOpenTime[v.group] = {}
        end
        local pageStartTime = GCalHelp:GetTimeStampBySplit(v.startTime, v)
        local pageEndTime = GCalHelp:GetTimeStampBySplit(v.endTime, v)
        v.nStartTime = pageStartTime
        v.nEndTime = pageEndTime
        table.insert(g_CfgShopTabOpenTime[v.group], {id = v.id, open_time = pageStartTime, close_time = pageEndTime})
    end
end

function ConfigChecker:CfgShopPage(cfgs)
    g_CfgShopPageOpenTime = {}
    g_CfgShopPageStoreVer = {}

    for _, v in pairs(cfgs) do
        local pageStartTime = GCalHelp:GetTimeStampBySplit(v.openTime, v)
        local pageEndTime = GCalHelp:GetTimeStampBySplit(v.closeTime, v)
        v.nStartTime = pageStartTime
        v.nEndTime = pageEndTime
        table.insert(
                g_CfgShopPageOpenTime,
                {shop_id = v.id, group_id = nil, open_time = pageStartTime, close_time = pageEndTime}
        )

        v.tabPage = {}

        if v.topGroup then
            if g_CfgShopTabOpenTime[v.topGroup] then
                for _, tabOpenTime in pairs(g_CfgShopTabOpenTime[v.topGroup]) do
                    table.insert(v.tabPage, v.id)
                    table.insert(
                            g_CfgShopPageOpenTime,
                            {
                                shop_id = v.id,
                                group_id = tabOpenTime.id,
                                open_time = tabOpenTime.open_time,
                                close_time = tabOpenTime.close_time
                            }
                    )
                end
            end
        end

        if v.storeVer then
            g_CfgShopPageStoreVer[v.id] = v.storeVer
        end
    end
end

function ConfigChecker:CfgMail(cfgs)
    if IS_CLIENT then
        return
    end

    for _, v in pairs(cfgs) do
        v.start_time = GCalHelp:GetTimeStampBySplit(v.start_time, v)
    end
end

function ConfigChecker:CfgRoleDormitoryEvents(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    GCalHelp:CalArrWeight(cfgs, 'weight', 'sumWeight')

    g_DormNotStoryEvents = {}
    for id, cfg in ipairs(cfgs) do
        if not cfg.story then
            table.insert(g_DormNotStoryEvents, cfg)
        end
    end
    -- LogTable(cfgs, 'CfgRoleDormitoryEvents:')
end

function ConfigChecker:CfgLifeBuffer(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    for _, cfg in pairs(cfgs) do
        cfg.sFieldName = CfgCardPropertyEnum[cfg.nType].sFieldName
        if cfg.jVal then
            if cfg.sFieldName == 'add_get_item_num' or cfg.sFieldName == 'add_get_item_pct' then
                cfg.jValMap = {}

                -- 这两个是根据掉落id来的，所以弄称map
                for _, arr in ipairs(cfg.jVal) do
                    cfg.jValMap[arr[1]] = table.copy(arr)
                end
            else
                cfg.jValMap = cfg.jVal
            end
        end

        ASSERT(cfg.sFieldName, 'Type id: ' .. cfg.nType .. ' not find sFieldName in CfgCardPropertyEnum')
    end
end

function ConfigChecker:CfgBAssault(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    for i, cfg in pairs(cfgs) do
        GCalHelp:CalArrWeight(cfg.teamInfos, 'weight', 'sumWeight')

        -- 计算好突袭的时间点
        cfg.openTimeStamps = {}
        if cfg.openTimes then
            for _, arr in ipairs(cfg.openTimes) do
                local begHour = arr[1]
                local endHour = arr[2]
                local joinDiff = arr[3]

                local begTime = TimerHelper:CalTimeStamp(nil, nil, nil, begHour, 0, 0)
                local endTime = TimerHelper:CalTimeStamp(nil, nil, nil, endHour, 0, 0)
                local joinDiffTime = endTime - joinDiff

                table.insert(cfg.openTimeStamps, {begTime, endTime, joinDiffTime})
            end
        end
    end
end

function ConfigChecker:CfgActiveRankReward(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.ranks = {}
        local curRank = 1
        for _, info in ipairs(cfg.infos) do
            for randIndex = curRank, info.maxRank, 1 do
                cfg.ranks[randIndex] = info.rewards
                curRank = randIndex
            end
        end
    end
end

function ConfigChecker:CfgSignReward(cfgs)
    g_ActiveSign_1 = {}

    for id, info in pairs(cfgs) do
        info.nBegTime = GCalHelp:GetTimeStampBySplit(info.begTime, info)
        info.nEndTime = GCalHelp:GetTimeStampBySplit(info.endTime, info)
        info.nSendTime = GCalHelp:GetTimeStampBySplit(info.sendTime, info)
        info.nSendTimeStop = GCalHelp:GetTimeStampBySplit(info.sendTimeStop, info)
        if info.activityID then
            g_ActiveSign_1[info.id] = info.activityID
            --LogI("g_ActiveSign：%s,%s", info.id, info.activityID)
        end
    end
end

function ConfigChecker:CfgCardPropertyEnum(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    g_cardFieldToIndex = {}

    for _, cfg in ipairs(cfgs) do
        g_cardFieldToIndex[cfg.sFieldName] = cfg.id
    end
end

function CommSetTaskFirstIdByList(tasks, cfgs)
    --给所有任务赋值任务链的第一个任务id（从第一个任务递归下去）
    for _, cfg in pairs(tasks) do
        --给第一个任务赋值
        local taskCfg = cfgs[cfg.id]
        taskCfg.nFirstTaskId = cfg.id
        --后置任务
        CommSetTaskFirstId(cfg.aNexTasks, cfgs, cfg.id)
    end
end

--给所有任务赋值任务链的第一个任务id（递归设置）
function CommSetTaskFirstId(nextTasks, cfgs, firstId)
    if nextTasks and table.size(nextTasks) > 0 then
        for _, nextTask in pairs(nextTasks) do
            local nextCfg = cfgs[nextTask.id]
            nextCfg.nFirstTaskId = firstId
            CommSetTaskFirstId(nextCfg.aNexTasks, cfgs, firstId)
        end
    end
end

function CommCalCfgTasks(cfgs, t)
    local firstTasks = {}
    local stageFirstTasks = {}
    local stageTasks = {}
    --LogI("eStageTaskType:%s", t)
    local resetTypeTasks = {}
    local returnTypeTasks = {}

    for _, cfg in pairs(cfgs) do
        local aFinishIds = cfg.aFinishIds
        if aFinishIds then
            for _, finishId in ipairs(aFinishIds) do
                if not CfgTaskFinishVal[finishId] then
                    LogE(string.format('任务：%s:%s 的 aFinishIds ：%s 在CfgTaskFinishVal中没有配置', cTaskCfgNames[t], cfg.id, finishId))
                end
            end
        end
        if eStageTask[t] then
            if cfg.nStage then
                local old = stageTasks[cfg.nStage] or 0
                stageTasks[cfg.nStage] = old + 1
            end
        end

        if t == eTaskType.RegressionBind then
            local resetType = cfg.type
            local returnType = cfg.playertype
            if not returnTypeTasks[returnType] then
                returnTypeTasks[returnType] = {}
            end
            table.insert(returnTypeTasks[returnType], cfg)

            if resetType == PeriodType.Day or resetType == PeriodType.Week then
                -- 只有每日或每周刷新的任务才插入
                if not resetTypeTasks[returnType] then
                    resetTypeTasks[returnType] = {}
                end
                if not resetTypeTasks[returnType][resetType] then
                    resetTypeTasks[returnType][resetType] = {}
                end

                table.insert(resetTypeTasks[returnType][resetType], cfg)
            end
        elseif t == eTaskType.RegressionTask then
            local type = cfg.type

            if type and not cfg.nStage then
                if not resetTypeTasks[type] then
                    resetTypeTasks[type] = {}
                end
                table.insert(resetTypeTasks[type], cfg)
            end
        elseif (t == eTaskType.RichMan or t == eTaskType.SkinPass) and cfg.nRestType then
            local resetType = cfg.nRestType
            resetTypeTasks[resetType] = resetTypeTasks[resetType] or {}
            if resetType == PeriodType.Day or resetType == PeriodType.Week then
                table.insert(resetTypeTasks[resetType], cfg)
            end
        end

        if not cfg.nPreTaskId or cfg.nPreTaskId == 0 then
            if eStageTask[t] then
                --LogTable(cfg, "cfg")
                if cfg.nStage then
                    if not stageFirstTasks[cfg.nStage] then
                        stageFirstTasks[cfg.nStage] = {}
                    end
                    table.insert(stageFirstTasks[cfg.nStage], cfg)
                elseif t ~= eTaskType.RegressionTask then
                    LogW('阶段类型任务%s：%s 缺少nStage的配置', t, cfg.id)
                end
            else
                -- 设置初始任务id
                table.insert(firstTasks, cfg)
            end
        else
            local preTask = cfgs[cfg.nPreTaskId]
            if preTask then
                if not preTask.aNexTasks then
                    preTask.aNexTasks = {}
                end
                -- 设置后置任务id
                table.insert(preTask.aNexTasks, cfg)
            end
        end
        cfg.nOpenTime = GCalHelp:GetTimeStampBySplit(cfg.sOpenTime, cfg)
        cfg.nCloseTime = GCalHelp:GetTimeStampBySplit(cfg.sCloseTime, cfg)
    end

    if eStageTask[t] then
        --LogTable(stageFirstTasks, "stageFirstTasks")
        cfgs.stageFirstTasks = stageFirstTasks
        cfgs.stageTasks = stageTasks
        for _, v in ipairs(stageFirstTasks) do
            CommSetTaskFirstIdByList(v, cfgs)
        end
    else
        cfgs.aFirstTasks = firstTasks
        CommSetTaskFirstIdByList(firstTasks, cfgs)
    end
    if t == eTaskType.RegressionBind then
        cfgs.returnTypeTasks = returnTypeTasks
        cfgs.resetTypeTasks = resetTypeTasks
    elseif t == eTaskType.RegressionTask then
        -- 4.6 回归任务新增 每日刷新与不刷新任务
        cfgs.dailyRefreshTasks = resetTypeTasks
    elseif t == eTaskType.RichMan or t == eTaskType.SkinPass then
        cfgs.resetTypeTasks = resetTypeTasks
    end
end

function ConfigChecker:CfgTaskMain(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Main)
end

function ConfigChecker:CfgTaskSub(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Sub)
end

function ConfigChecker:CfgTaskDaily(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Daily)
end

function ConfigChecker:CfgTaskWeekly(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Weekly)
end

function ConfigChecker:CfgTaskActivity(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Activity)
end

function ConfigChecker:CfgDupTower(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.DupTower)
end

function ConfigChecker:CfgTmpDupTower(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.TmpDupTower)
end

function ConfigChecker:CfgDupTaoFa(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.DupTaoFa)
end

function ConfigChecker:CfgDupStory(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Story)
end

function ConfigChecker:CfgDupFight(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.DupFight)
end

function ConfigChecker:CfgSevenDayTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Seven)
end

function ConfigChecker:CfgSevenDayFinish(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.SevenStage)
end

function ConfigChecker:CfgTaskDayExploration(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.DayExplore)
end

function ConfigChecker:CfgTaskWeekExploration(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.WeekExplore)
end

function ConfigChecker:CfgTaskExploration(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Explore)
end

function ConfigChecker:CfgGuideTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Guide)
end

function ConfigChecker:CfgGuideFinish(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.GuideStage)
end

function ConfigChecker:CfgNewYearFinish(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.NewYearFinish)
end

function ConfigChecker:CfgRegressionTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.RegressionTask)
end

function ConfigChecker:CfgNewYearTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.NewYear)
end

function ConfigChecker:CfgRegressionFundTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Regression)
end

function ConfigChecker:CfgRogueTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Rogue)
end

function ConfigChecker:CfgRegressionBind(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.RegressionBind)
end

function ConfigChecker:CfgRegressionBindStage(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.RegressionBindStage)
end

function ConfigChecker:CfgTotalBattleTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.StarPalace)
end

function ConfigChecker:CfgPetArchive(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Pet)
end


function ConfigChecker:cfgColosseumMission(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.AbattoirMoon)
end

function ConfigChecker:cfgColosseumSeasonMission(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.AbattoirSeason)
end

function ConfigChecker:CfgDupLiZhan(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.DupLiZhan)
end


function ConfigChecker:CfgTaskPuzzle(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Puzzle)
end

function ConfigChecker:cfgWorldBossMission(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.GlobalBossDay)
end

function ConfigChecker:cfgWorldBossMonthMission(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.GlobalBossMonth)
end

function ConfigChecker:CfgPointsBattle(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.PointsBattle)
end

function ConfigChecker:cfgAnniversaryMission(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.AnniversaryMission)
end

function ConfigChecker:CfgMultiteamEntrance(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.MultTeam)
end


function ConfigChecker:CfgNewPlayerSevenDayTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.NewPlayerSeven)
end
function ConfigChecker:cfgMonopolyMission(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.RichMan)
end


function ConfigChecker:CfgSonicoTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.SONICO)
end

function ConfigChecker:cfgWarzoneMission(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.EternalBattle)
end
function ConfigChecker:CfgSkinPassMission(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.SkinPass)
end

function ConfigChecker:CfgSonicoTaskReward(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.SONICOStage)
end

function ConfigChecker:CfgDupLianSuo(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.ChainFront)
end

function ConfigChecker:CfgGoldenRebateMission(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.GoldenRebate)
end

function ConfigChecker:CfgStoryCollectionActTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.StoryCollectionAct)
end

function ConfigChecker:CfgStoryCollectionTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.StoryCollection)
end


function ConfigChecker:CfgExtraExploration(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    for _, cfg in pairs(cfgs) do
        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
    end
end

function ConfigChecker:CfgSkinPass(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    for _, cfg in pairs(cfgs) do
        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.begTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
    end
end

function ConfigChecker:CfgSkinPassReward(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end
    g_SkinPassDup = {}
    for _, cfg in pairs(cfgs) do
        for _,mCfg in ipairs(cfg.item or {}) do
            if mCfg.group then
                for _,dId in ipairs(mCfg.group) do
                    g_SkinPassDup[dId] = {id = cfg.id,lv = mCfg.level,reward = mCfg.reward}
                end
            end
        end

    end
end


function ConfigChecker:CfgTaskFinishVal(cfgs)
    local sN = 2
    local eN = 10
    for _, fCfg in pairs(cfgs) do
        for n = sN, eN, 1 do
            local sField = 'aVal' .. n
            local cfgArr = fCfg[sField]
            if cfgArr then
                table.sort(cfgArr)
            end
        end
    end
end

function ConfigChecker:CfgFurniture(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end
    for k, cfg in pairs(cfgs) do
        cfg.nBuyStart = GCalHelp:GetTimeStampBySplit(cfg.sBuyStart, cfg)
        cfg.nBuyEnd = GCalHelp:GetTimeStampBySplit(cfg.sBuyEnd, cfg)
    end
end

-- 计算主题表的舒适度和价格
function ConfigChecker:CfgFurnitureTheme(cfgs)
    for k, cfg in pairs(cfgs) do
        local comfort, price_1, price_2 = 0, 0, 0
        local id1, id2 = nil, nil
        local layoutCfg = CfgThemeLayout[cfg.layoutId]
        if (layoutCfg) then
            for n, m in ipairs(layoutCfg.infos) do
                local furCfg = CfgFurniture[m.cfgID]
                if (not furCfg.special) then
                    comfort = comfort + furCfg.comfort
                    price_1 = price_1 + furCfg.price_1[1][2]
                    price_2 = price_2 + furCfg.price_2[1][2]
                    if (id1 == nil) then
                        id1, id2 = furCfg.price_1[1][1], furCfg.price_2[1][1]
                    end
                end
            end
        end

        cfg.comfort = comfort
        cfg.price_1 = {{id1, price_1}}
        cfg.price_2 = {{id2, price_2}}
        cfg.nBuyStart = GCalHelp:GetTimeStampBySplit(cfg.sStart, cfg)
        cfg.nBuyEnd = GCalHelp:GetTimeStampBySplit(cfg.sEnd, cfg)
    end
end

-- 家具类型表重新排序
function ConfigChecker:CfgFurnitureEnum(cfgs)
    table.sort(
            cfgs,
            function(a, b)
                return a.index < b.index
            end
    )
end

function ConfigChecker:CardExpAddRand(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    -- 卡牌经验暴击表特殊处理
    GCalHelp:CalArrWeight(cfgs, 'weight', 'sumWeight')
end

function ConfigChecker:CfgEquipExpRand(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    -- 装备经验暴击表特殊处理
    GCalHelp:CalArrWeight(cfgs, 'nWeight', 'sumWeight')
end

function ConfigChecker:CfgDupDropCntAdd(cfgs)
    -- 累计总共添加的次数
    g_AddDupMultiCnt = 0
    g_SpecialMultiId = nil
    g_ReCalAddDupMultiTime = nil

    for _, cfg in pairs(cfgs) do
        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)

        local isInRange = GLogicCheck:IsInRange(cfg.nStart, cfg.nEnd, CURRENT_TIME, true)
        if isInRange then
            local isUse = false
            if cfg.dropAddCnt and not cfg.regressionType then
                isUse = true
                g_AddDupMultiCnt = g_AddDupMultiCnt + cfg.dropAddCnt
            elseif cfg.specialMultiId and not g_SpecialMultiId then
                isUse = true
                g_SpecialMultiId = cfg.specialMultiId
            end

            if isUse and cfg.nEnd ~= 0 then
                -- 开启的判断结束时间，保存最小的需要计算时间
                if not g_ReCalAddDupMultiTime or cfg.nEnd < g_ReCalAddDupMultiTime then
                    g_ReCalAddDupMultiTime = cfg.nEnd
                end
            end
        else
            -- 只需要查看还没开启的
            if cfg.nStart and cfg.nStart > CURRENT_TIME then
                if not g_ReCalAddDupMultiTime or cfg.nStart < g_ReCalAddDupMultiTime then
                    g_ReCalAddDupMultiTime = cfg.nStart
                end
            end
        end
    end

    -- LogTrace("ConfigChecker:CfgDupDropCntAdd()")
    LogDebug(
            'ConfigChecker:CfgDupDropCntAdd() g_AddDupMultiCnt:%s, g_ReCalAddDupMultiTime:%s, g_SpecialMultiId:%s',
            g_AddDupMultiCnt,
            g_ReCalAddDupMultiTime,
            g_SpecialMultiId
    )
end

function ConfigChecker:CfgDupConsumeReduce(cfgs)
    -- 累计减少体力消耗百分比
    g_DupConsumeReduce = 0
    g_ReCalDupConRedTime = nil

    for _, cfg in pairs(cfgs) do
        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)

        local isInRange = GLogicCheck:IsInRange(cfg.nStart, cfg.nEnd, CURRENT_TIME, true)
        if isInRange and not cfg.regressionType then
            g_DupConsumeReduce = g_DupConsumeReduce + cfg.consumeReduce
            if cfg.nEnd ~= 0 then
                -- 开启的判断结束时间，保存最小的需要计算时间
                if not g_ReCalDupConRedTime or cfg.nEnd < g_ReCalDupConRedTime then
                    g_ReCalDupConRedTime = cfg.nEnd
                end
            end
        else
            -- 只需要查看还没开启的
            if cfg.nStart > CURRENT_TIME then
                if not g_ReCalDupConRedTime or cfg.nStart < g_ReCalDupConRedTime then
                    g_ReCalDupConRedTime = cfg.nStart
                end
            end
        end
    end

    LogDebug(
            'ConfigChecker:CfgDupConsumeReduce() g_DupConsumeReduce:%s, g_ReCalDupConRedTime:%s',
            g_DupConsumeReduce,
            g_ReCalDupConRedTime
    )
end

function ConfigChecker:global_setting(cfgs)
    LogDebugEx('load global_setting:')
    for k, v in pairs(cfgs) do
        if v.key ~= '' then
            LogDebugEx('load global_setting:' .. v.key)
            local val = ConfigParser:FormatValue(v.value, v.type)

            -- print(IS_CLIENT, v.user, v.user == 1)
            if IS_CLIENT and (v.user == 1 or not v.user) then
                _G[v.key] = val
            elseif IS_SERVER and (v.user == 2 or not v.user) then
                _G[v.key] = val
                Loader:AddReplaceFile(v.key)
            end
        end
    end
    -- LogDebug("global_setting: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
    table.sort(g_BuildTradeFlushTimes)
    -- LogTable(g_BuildTradeFlushTimes, "g_BuildTradeFlushTimes:")

    table.sort(g_WeekHoliday)
    -- LogTable(g_WeekHoliday, "g_WeekHoliday:")

    table.sort(g_ArmyFightListScoreRange)

end

function ConfigChecker:CfgRogueMapGlobal(cfgs)
    local tmpCfg = {}
    for k, v in pairs(cfgs) do
        if v.key ~= '' then
            local val = ConfigParser:FormatValue(v.value, v.type)

            -- print(IS_CLIENT, v.user, v.user == 1)
            -- if IS_CLIENT and (v.user == 1 or not v.user) then
            --     _G[v.key] = val
            -- elseif IS_SERVER and (v.user == 2 or not v.user) then
            --     _G[v.key] = val
            --     Loader:AddReplaceFile(v.key)
            -- end
            if IS_SERVER then
                tmpCfg[v.key] = val
            end
        end
    end

    for k, v in pairs(tmpCfg) do
        cfgs[k] = v
    end
end

function ConfigChecker:CfgAchieve(cfgs)
    local achievementFinishIds = {}
    for cfgid, cfg in pairs(cfgs) do
        local aFinishIds = cfg.aFinishIds
        if not aFinishIds then
            LogError(string.format('CfgAchieve id:%s 的aFinishIds不允许为空', cfgid))
        end

        local aFinishId = aFinishIds[1]
        local finishCount = aFinishIds[2]
        if not aFinishId then
            LogError(string.format('CfgAchieve id:%s 的条件Id不允许为空', cfgid))
        end
        if not finishCount then
            LogError(string.format('CfgAchieve id:%s 的完成次数不允许为空', cfgid))
        end

        if not achievementFinishIds[aFinishId] then
            achievementFinishIds[aFinishId] = {}
        end
        cfg.aFinishId = aFinishId
        cfg.finishCount = finishCount
        table.insert(achievementFinishIds[aFinishId], cfgid)
        if not CfgAchieveFinishVal[aFinishId] then
            LogE(string.format('CfgAchieve：%s 的 aFinishId ：%s 在CfgAchieveFinishVal中没有配置', cfg.id, aFinishId))
        end
    end
    cfgs.achievementFinishIds = achievementFinishIds
end

function ConfigChecker:CfgAchieveFinishVal(cfgs)
    local achieveGroup = {}
    for cfgid, cfg in pairs(cfgs) do
        local nType = cfg.nType
        if not nType then
            LogError('CfgAchieveFinishVal id:%s 的nType不允许为空', cfgid)
        end
        if cfg.aVal2 then
            table.sort(cfg.aVal2)
        end

        local group = eAchieveFinishType.GetTypeById(nType)

        if not achieveGroup[group] then
            achieveGroup[group] = {}
        end
        table.insert(achieveGroup[group], cfgid)
    end
    cfgs.achieveGroup = achieveGroup
end

function ConfigChecker:CfgBadge(cfgs)
    local badgedFinishIds = {}
    for cfgid, cfg in pairs(cfgs) do
        local aFinishIds = cfg.aFinishIds
        if not aFinishIds then
            LogError(string.format('CfgBadge id:%s 的aFinishIds不允许为空', cfgid))
        end

        local aFinishId = aFinishIds[1]
        local finishCount = aFinishIds[2]
        if not aFinishId then
            LogError(string.format('CfgBadge id:%s 的条件Id不允许为空', cfgid))
        end
        if not finishCount then
            LogError(string.format('CfgBadge id:%s 的完成次数不允许为空', cfgid))
        end

        if not badgedFinishIds[aFinishId] then
            badgedFinishIds[aFinishId] = {}
        end
        cfg.aFinishId = aFinishId
        cfg.finishCount = finishCount
        table.insert(badgedFinishIds[aFinishId], cfgid)

        if not CfgBadgeFinishVal[aFinishId] then
            LogE(string.format('徽章CfgBadge：%s 的 aFinishId ：%s 在CfgBadgeFinishVal中没有配置', cfg.id, aFinishId))
        end
    end
    cfgs.badgedFinishIds = badgedFinishIds
end

function ConfigChecker:CfgBadgeFinishVal(cfgs)
    local badgedGroup = {}
    for cfgid, cfg in pairs(cfgs) do
        local nType = cfg.nType
        if not nType then
            LogError(string.format('CfgBadgeFinishVal id:%s 的nType不允许为空', cfgid))
        end
        if cfg.aVal2 then
            table.sort(cfg.aVal2)
        end
        local group = eBadgedFinishType.GetTypeById(nType)

        --LogI("group:%s", group)

        if not badgedGroup[group] then
            badgedGroup[group] = {}
        end
        table.insert(badgedGroup[group], cfgid)
    end
    cfgs.badgedGroup = badgedGroup
end

function ConfigChecker:CfgReturningActivity(cfgs)
    for returnType, cfg in pairs(cfgs) do
        for idx, ccc in pairs(cfg.infos) do
            if ccc.activityId then
                if ccc.type == RegressionActiveType.DropAdd then
                    ASSERT(
                            CfgDupDropCntAdd[ccc.activityId],
                            string.format(
                                    'CfgReturningActivity id:%s, sub index:%s 填写的活动关联ID(%s)在掉落次数加成表CfgDupDropCntAdd里找不到',
                                    returnType,
                                    idx,
                                    ccc.activityId
                            )
                    )
                    ccc.relateCfg = CfgDupDropCntAdd[ccc.activityId]
                elseif ccc.type == RegressionActiveType.ConsumeReduce then
                    ASSERT(
                            CfgDupConsumeReduce[ccc.activityId],
                            string.format(
                                    'CfgReturningActivity id:%s, sub index:%s 填写的活动关联ID(%s)在体力消耗减少表CfgDupConsumeReduce里找不到',
                                    returnType,
                                    idx,
                                    ccc.activityId
                            )
                    )
                    ccc.relateCfg = CfgDupConsumeReduce[ccc.activityId]
                elseif ccc.type == RegressionActiveType.Banner then
                    -- 回归卡池
                    local cardPoolCfg = CfgCardPool[ccc.activityId]
                    if not cardPoolCfg or cardPoolCfg.nType ~= CardPoolType.Regression then
                        ASSERT(
                                false,
                                string.format(
                                        'CfgReturningActivity id:%s, sub index:%s 填写的对应的卡池id：%s找不到配置或者卡池类型不是%s[CardPoolType.Regression].',
                                        returnType,
                                        idx,
                                        ccc.activityId,
                                        CardPoolType.Regression
                                )
                        )
                    end
                end
            end

            ccc.nStartTime = GCalHelp:GetTimeStampBySplit(ccc.starttime, ccc)
            ccc.nEndTime = GCalHelp:GetTimeStampBySplit(ccc.endtime, ccc)
        end
    end
end

function ConfigChecker:CfgItemPoolReward(cfgs)
    for id, cfg in pairs(cfgs) do
        cfg.roundPool = {}
        local roundPool = cfg.roundPool
        for idx, v in pairs(cfg.pool) do
            for _, round in ipairs(v.rounds) do
                if not roundPool[round] then
                    roundPool[round] = {}
                end
                roundPool[round][idx] = v
            end
        end
    end
end

function ConfigChecker:CfgItemPool(cfgs)
    for id, cfg in pairs(cfgs) do
        if cfg.Proptype == 1 then
            ASSERT(cfg.starttime, string.format('道具池活动表 CfgItemPool, id %s 没有配置 starttime', id))
            ASSERT(cfg.endtime, string.format('道具池活动表 CfgItemPool, id:%s 没有配置 endTime', id))

            cfg.nStartTime = GCalHelp:GetTimeStampBySplit(cfg.starttime, cfg)
            cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endtime, cfg)
        end

        if cfg.costtype == 2 then
            -- 每轮消耗都不一致，需要判断消耗长度与实际道具组数量是否一致
            local timesSum = #cfg.cost

            local poolRewardCfg = CfgItemPoolReward[cfg.group]
            assert(poolRewardCfg, string.format("道具池活动表 id:%s,对应的group:%s，在道具组奖励表里找不到对应的ID", id, cfg.group))

            local rewardNum = 0
            for _, v in ipairs(poolRewardCfg.pool) do
                assert(v.iskeyreward, string.format("道具池奖励表id:%s，此类型所有的奖励需是关键奖励", cfg.group))
                rewardNum = rewardNum + v.rewardnum
            end

            assert(timesSum == rewardNum, string.format("道具池id:%s抽取消耗长度(%s)与道具组奖励表id:%s长度(%s)不符", id, timesSum, cfg.group, rewardNum))

        end
    end
end

--- 绑定活动
function ConfigChecker:CfgBindActive(cfgs)
    g_curBindActiveId = nil
    g_curBindActiveCloseTime = nil
    g_nextBindActiveOpenTime = nil

    for id, cfg in pairs(cfgs) do
        LogTable(cfg, 'ConfigChecker:CfgBindActive cfg')

        table.sort(cfg.bindTypes)

        cfg.nStartTime = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
        local isInRange = GLogicCheck:IsInRange(cfg.nStartTime, cfg.nEndTime, CURRENT_TIME, true)
        if isInRange and not g_curBindActiveId then
            g_curBindActiveId = cfg.id
            g_curBindActiveCloseTime = cfg.nEndTime
        else
            if cfg.nStartTime > CURRENT_TIME then
                if g_nextBindActiveOpenTime then
                    if cfg.nStartTime < g_nextBindActiveOpenTime then
                        g_nextBindActiveOpenTime = cfg.nStartTime
                    end
                else
                    g_nextBindActiveOpenTime = cfg.nStartTime
                end
            end
        end

        for _, info in pairs(cfg.infos) do
            -- LogTable(info, 'ConfigChecker:CfgBindActive')
            info.teskGetLimit = {}
            for _, limit in ipairs(info.taskRewardLimit) do
                local resetType, id, num = limit[1], limit[2], limit[3]
                if resetType then
                    local limitInfo = GCalHelp:GetTb(info.teskGetLimit, resetType)
                    GCalHelp:Add(limitInfo, id, num)
                end
            end
        end
    end
end

function ConfigChecker:DungeonGroup(cfgs)
    g_CalGroupStarIxs = {}

    for id, cfg in pairs(cfgs) do
        if cfg.group == 11001 then
            -- 乱序演习词条数量检查
            local buffnum = cfg.buffNum
            if buffnum ~= #cfg.Num then
                ASSERT(false, string.format('乱序演习关卡组表，词条池数量buffNum(%s)与选择数量Num长度(%s)对不上 ', buffnum, #cfg.Num))
            end

            for i = 1, buffnum do
                local buffPond = cfg['buffPond' .. i]
                if not buffPond then
                    ASSERT(false, string.format('乱序演习关卡组表，词条池数量buffNum为(%s)，但没有配置第%s词条池 ', buffnum, i))
                end

                if cfg.Num[i] > #buffPond then
                    ASSERT(
                            false,
                            string.format('乱序演习关卡组表，第%s词条池词条数量（%s）不足以随机词条，至少需要的词条数量：%s ', i, #buffPond, cfg.Num[i])
                    )
                end
            end
        end
        
        if cfg.perPoint and cfg.openTime then
            cfg.nOpenTime = GCalHelp:GetTimeStampBySplit(cfg.openTime, cfg)
        end

        if cfg.begTime then
            cfg.nBegTime = GCalHelp:GetTimeStampBySplit(cfg.begTime, cfg)
        end

        if cfg.endTime then
            cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
        end


        if cfg.starIx then
            local arr = GCalHelp:GetTb(g_CalGroupStarIxs, cfg.starIx, {})
            table.insert(arr, id)
        end
    end
end

function ConfigChecker:CfgTotalBattle(cfgs)
    for _, cfg in pairs(cfgs) do
        if cfg.infos then
            for _, v in pairs(cfg.infos) do
                if v.begTime then
                    v.nBegTime = GCalHelp:GetTimeStampBySplit(v.begTime, v)
                end
                if v.endTime then
                    v.nEndTime = GCalHelp:GetTimeStampBySplit(v.endTime, v)
                end
            end
        end
    end
end

function ConfigChecker:CfgTrials(cfgs)
    for _, cfg in pairs(cfgs) do
        if cfg.infos then
            for _, v in pairs(cfg.infos) do
                if v.begTime then
                    v.nBegTime = GCalHelp:GetTimeStampBySplit(v.begTime, v)
                end
                if v.endTime then
                    v.nEndTime = GCalHelp:GetTimeStampBySplit(v.endTime, v)
                end
            end
        end
    end
end

function ConfigChecker:CfgRogueBuff(cfgs)
    for _, cfg in pairs(cfgs) do
        if not cfg.skillId and not cfg.buffId then
            assert(false, string.format("词条表，CfgRogueBuff id:%s 没有配对应的技能或BUFF", cfg.id))
        end

        if cfg.lifeType == 2 then
            assert(cfg.lifeValue, string.format("词条表，CfgRogueBuff id:%s 没有配对应的词条生命参数", cfg.id))
        end

        if cfg.target == 3 or cfg.target == 4 then
            -- 我方随机或敌方随机，需要配对应的随机个数
            assert(cfg.targetValue, string.format("词条表，CfgRogueBuff id:%s 没有配对应的对象参数", cfg.id))
        end

        if cfg.preConditions then
            assert(cfg.preConditionsValue, string.format("词条表，CfgRogueBuff id:%s 没有配对应的前置条件参数", cfg.id))
        end

        if not cfg.probability then
            assert(false, string.format("词条表，CfgRogueBuff id:%s 没有配出现概率", cfg.id))
        end

    end
end

function ConfigChecker:CfgDateParagraph(cfgs)
    gChapterNodeNums = {}
    for _, cfg in pairs(cfgs) do
        gChapterNodeNums[cfg.group] = gChapterNodeNums[cfg.group] or 0
        local curNum = gChapterNodeNums[cfg.group]
        gChapterNodeNums[cfg.group] = curNum + 1
    end
end

function ConfigChecker:Section(cfgs)
    for _, cfg in pairs(cfgs) do
        if cfg.data then
            cfg.resetTime = GCalHelp:GetTimeStampBySplit(cfg.data, cfg)
        end
    end
end


function ConfigChecker:CfgSplitTime(cfgs)
    for _, cfg in pairs(cfgs) do
        if cfg.infos then
            for _, info in pairs(cfg.infos) do
                if info.begTime then
                    info.nBegTime = GCalHelp:GetTimeStampBySplit(info.begTime, info)
                end
                if info.endTime then
                    info.nEndTime = GCalHelp:GetTimeStampBySplit(info.endTime, info)
                end
            end
        end
    end
end

function ConfigChecker:CfgDateChat(cfgs)
    for _, cfg in pairs(cfgs) do
        if cfg.nextChatID and #cfg.nextChatID > 0 then
            for _, id in ipairs(cfg.nextChatID) do
                if cfgs[id] then
                    if cfg.type == 2 or cfg.type == 3 then --选项设置
                        cfgs[id].isOption = 1
                    end
                    if cfg.talkRoleEmblem~=nil and cfgs[id].talkRoleEmblem~=nil then --隐藏头像
                        cfgs[id].isHideIcon = 1
                    end
                end
            end
        end
    end
end

function ConfigChecker:cfgColosseum(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end
    for _, cfg in pairs(cfgs) do
        cfg.nBegTime = GCalHelp:GetTimeStampBySplit(cfg.begTime, cfg)
        cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
        cfg.nRewardTime = GCalHelp:GetTimeStampBySplit(cfg.rewardTime, cfg)


        cfg.randRefreshList = cfg.randRefreshList or {}
        for k,v in ipairs(cfg.randomRefresh or {}) do
            local lastRefresh = cfg.randRefreshList[k - 1] or cfg.nBegTime
            local refreshTime = lastRefresh + v * TimerHelper.cDaySeconds
            table.insert(cfg.randRefreshList,refreshTime)
        end
        table.insert(cfg.randRefreshList,cfg.nEndTime)
        cfg.selectRefreshList = cfg.selectRefreshList or {}
        for k,v in ipairs(cfg.optionalRefresh or {}) do
            local lastRefresh = cfg.selectRefreshList[k - 1] or cfg.nBegTime
            local refreshTime = lastRefresh + v * TimerHelper.cDaySeconds
            table.insert(cfg.selectRefreshList,refreshTime)
        end
        table.insert(cfg.selectRefreshList,cfg.nEndTime)
    end
end

-- function ConfigChecker:cfgColosseumEquip(cfgs)
--     for _, cfg in pairs(cfgs) do
--         -- GCalHelp:CalArrWeight(cfg.infos, 'weight', 'sumWeight')
--         local sumWeight = 0
--         for _, info in pairs(cfg.infos) do
--             local weight = info.weight
--             info.sumWeight = weight + sumWeight
--             sumWeight = sumWeight + info.weight
--         end
--     end
-- end

function ConfigChecker:CfgTowerDeep(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.begTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
        assert(cfg.nStart < cfg.nEnd, "开放时间范围有误")
    end
end
function ConfigChecker:cfgGlobalBoss(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.nBeginTime = GCalHelp:GetTimeStampBySplit(cfg.nBeginTime, cfg)
        cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.nEndTime, cfg)
        cfg.BossDeathTime = GCalHelp:GetTimeStampBySplit(cfg.BossDeathTime, cfg)
        assert(cfg.nBeginTime < cfg.nEndTime, "boss开启时间范围有误")
    end
end

function ConfigChecker:CfgRankTeam(cfgs)
    -- 按章节分排行榜
    g_rank_section = {}
    -- 十二宫的排行榜
    g_star_group = {}
    -- 统计同活动的 commonSettle 榜数量（精简版限制只能1个）
    local commonCntByActive = {}

    for _, cfg in pairs(cfgs) do
        if cfg.sectionID then
            g_rank_section[cfg.sectionID] = cfg.id
        end
        if cfg.rankType and cfg.rankType == eRankType.STAR then
            table.insert(g_star_group, cfg.id)
        end
        -- 通用结算仅服务端使用，客户端导表可能不含 activityID 等字段
        if not IS_CLIENT and tonumber(cfg.isCommonSettle) == 1 then
            local activeId = tonumber(cfg.activityID) or 0
            ASSERT(activeId > 0, string.format(
                "CfgRankTeam id=%s 配置 isCommonSettle=1 时，activityID 必须有效，当前 activityID=%s, isCommonSettle=%s",
                tostring(cfg.id), tostring(cfg.activityID), tostring(cfg.isCommonSettle)
            ))

            commonCntByActive[activeId] = (commonCntByActive[activeId] or 0) + 1
            ASSERT(commonCntByActive[activeId] <= 1, string.format(
                "CfgRankTeam activityID=%s 存在多个 isCommonSettle=1（当前 rankId=%s）",
                tostring(activeId), tostring(cfg.id)
            ))

            local rewardCfg = CfgRankTeamReward and CfgRankTeamReward[cfg.id]
            ASSERT(rewardCfg and rewardCfg.infos and #rewardCfg.infos > 0, string.format(
                "CfgRankTeam id=%s 的通用结算缺少有效奖励配置 CfgRankTeamReward", tostring(cfg.id)
            ))

            for _, rw in pairs(rewardCfg.infos or {}) do
                ASSERT(tonumber(rw.sub) and tonumber(rw.up), string.format(
                    "CfgRankTeam id=%s 奖励段 sub/up 必须有效，当前 sub=%s up=%s",
                    tostring(cfg.id), tostring(rw.sub), tostring(rw.up)
                ))
                ASSERT(rw.mailId and rw.mailId > 0, string.format(
                    "CfgRankTeam id=%s 奖励段缺少合法 mailId，当前 mailId=%s",
                    tostring(cfg.id), tostring(rw.mailId)
                ))
            end
        end
    end
end

function ConfigChecker:CfgPuzzleBase(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.nBeginTime = GCalHelp:GetTimeStampBySplit(cfg.begTime, cfg)
        cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
        assert(cfg.nBeginTime < cfg.nEndTime, "拼图玩法活动开启时间范围有误")
    end
end

function ConfigChecker:CfgPuzzleReward(cfgs)
    for _, cfg in pairs(cfgs) do
        for id,info in pairs(cfg.infos or {}) do
            if not info.grids or table.empty(info.grids) then
                cfg.finalRwdId = id
                break
            end
        end
    end
end

function ConfigChecker:cfgQuestions(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.nBeginTime = GCalHelp:GetTimeStampBySplit(cfg.begTime, cfg)
        cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
    end

end

function ConfigChecker:cfgQuestionsGroup(cfgs)
    g_questions_group = {}
    for _, cfg in pairs(cfgs) do
        for _, info in pairs(cfg.infos) do
            if info.isright then
                cfg.answerIndex = info.index
            end
        end
        if not cfg.group then
            LogE(string.format("cfgQuestionsGroup:%s 缺少group", cfg.id))
        end
        if not g_questions_group[cfg.group] then
            g_questions_group[cfg.group] = { group = {} }
        end
        table.insert(g_questions_group[cfg.group].group, { id = cfg.id, weight = cfg.weight })
        g_questions_group[cfg.group].totalWeight = (g_questions_group[cfg.group].totalWeight or 0) + cfg.weight
    end
end


function ConfigChecker:CfgPet(cfgs)
    for _, cfg in pairs(cfgs) do
        local feedCfg = CfgPetFeedReward[cfg.feedReward]
        local feedMax = 0
        ASSERT(feedCfg, "该宠物(id:%s)对应的养成奖励没有配置，养成奖励表ID：", cfg.id, cfg.feedReward)
        for _, v in pairs(feedCfg.infos) do
            if feedMax < v.feedNum then
                feedMax = v.feedNum
            end
        end
        ASSERT(feedMax ~= 0, "该宠物(id:%s)对应的养成值有问题,最大值为0", cfg.id)
        cfg.feedMax = feedMax
    end
end

function ConfigChecker:CfgMultiteamBattle(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.nBeginTime = GCalHelp:GetTimeStampBySplit(cfg.begTime, cfg)
        cfg.nSettleTime = GCalHelp:GetTimeStampBySplit(cfg.settlementTime, cfg)
        cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
        assert(cfg.nBeginTime < cfg.nEndTime, "多队玩法活动开启时间范围有误")
    end
end



function ConfigChecker:CfgCoffeeMain(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.nBeginTime = GCalHelp:GetTimeStampBySplit(cfg.begTime, cfg)
        cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
        assert(cfg.nBeginTime < cfg.nEndTime, "女仆咖啡活动开启时间范围有误")
    end
end

function ConfigChecker:CfgPvpSeason(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.nBeg = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
    end
end

function ConfigChecker:cfgPopupPackCondition(cfgs)
    g_popupPack = {}
    for _, cfg in pairs(cfgs) do
        if g_popupPack[cfg.popupPack] then
            LogError(string.format("cfgPopupPackCondition id:%s popupPack:%s 存在重复", cfg.id, cfg.popupPack))
        end
        g_popupPack[cfg.popupPack] = cfg.id
    end
end


function ConfigChecker:CfgDateSection(cfgs)
    g_shopToChapter = {}
    for _, cfg in pairs(cfgs) do
       if cfg.shopId then
            g_shopToChapter[cfg.shopId] = cfg.id
       end
    end
end

function ConfigChecker:CfgPvpRobot(cfgs)
    if not GCalHelp then
        return
    end

    for _, cfg in pairs(cfgs) do
        if cfg.nScore then
            cfg.nRankLv = GCalHelp:CalFreeMatchRankLv(cfg.nScore)
        end
    end
end

function ConfigChecker:CfgChristMain(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.nBeginTime = GCalHelp:GetTimeStampBySplit(cfg.begTime, cfg)
        cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
        assert(cfg.nBeginTime < cfg.nEndTime, "圣诞签到活动开启时间范围有误")
    end
end

function ConfigChecker:cfgMonopoly(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.nStartTime = GCalHelp:GetTimeStampBySplit(cfg.openTime, cfg)
        cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.closeTime, cfg)
        assert(cfg.nStartTime < cfg.nEndTime, "大富翁活动开启时间范围有误")
    end
end

-- v5.0 实物抽奖表配置检查
function ConfigChecker:cfgPhysicalReward(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.nBeginTime = GCalHelp:GetTimeStampBySplit(cfg.beginTime, cfg)
        cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
        assert(cfg.nBeginTime < cfg.nEndTime, "实物抽奖活动开启时间范围有误")

        cfg.poolIdMap = {}
        for k, poolId in ipairs(cfg.rewardPoolId) do
            local poolCfg = CfgCardPool[poolId]
            ASSERT(poolCfg, string.format("卡池配置表没有相应的ID:%s",poolId))
            cfg.poolIdMap[poolId] = true
        end

        local minTime = cfg.nBeginTime
        local maxTime = cfg.nEndTime
        -- 某个时间段时 实物奖励总投放数量
        local totalNums = {}
        cfg.rewardNums = {}
        for index, v in ipairs(cfg.infos) do

            totalNums[index] = {}

            for k, num in pairs(v.rewardNum) do
                local preNum = 0
                if totalNums[index - 1] and totalNums[index - 1][k] then
                    preNum = totalNums[index - 1][k]
                end
                totalNums[index][k] = preNum + num
                cfg.rewardNums[k] = (cfg.rewardNums[k] or 0) + num
            end
            v.nBTime = GCalHelp:GetTimeStampBySplit(v.bTime, v)
            v.nETime = GCalHelp:GetTimeStampBySplit(v.eTime, v)
            ASSERT(v.nBTime < v.nETime, string.format("实物抽奖活动开启时间范围有误,活动id%s,下标%s",cfg.id, v.index))
            ASSERT(minTime <= v.nBTime, string.format("实物抽奖活动开启时间范围有误,活动id%s,下标%s, 开启时间%s",cfg.id, v.index, v.nBTime))
            ASSERT(maxTime >= v.nETime, string.format("实物抽奖活动开启时间范围有误,活动id%s,下标%s, 结束时间%s",cfg.id, v.index, v.nETime))
        end
        cfg.totalNums = totalNums
    end
end

-- v5.0 宿舍宠物配置检查
function ConfigChecker:CfgDormPet(cfgs)
    for id, cfg in pairs(cfgs) do
        ASSERT(cfg.item_id, string.format('宿舍宠物id:%s无对应的的物品id,配置不对', id))
    end
end

-- v4.6 资源补给配置检查
function ConfigChecker:CfgResupply(cfgs)
    for id, cfg in pairs(cfgs) do
        cfg.nstartTime = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
    end
end

-- v5.0 大富翁
function ConfigChecker:cfgMonopolyGrid(cfgs)
    g_RichManGrid = {}
    for id, cfg in pairs(cfgs) do
        for _,info in pairs(cfg.infos or {}) do
            g_RichManGrid[id] = g_RichManGrid[id] or {}
            g_RichManGrid[id][info.sort] = info
            local oldNum = g_RichManGrid[id].gridNum or 0
            g_RichManGrid[id].gridNum = oldNum + 1
        end
    end
end

--v4.4 世界boss优化
function ConfigChecker:cfgGlobalBossHpLevel(cfgs)
    local maxId
    local minId
    for id, cfg in pairs(cfgs) do
        maxId = maxId or id
        minId = minId or id
        if id < minId then
            minId = id
        end
        if id > maxId then
            maxId = id
        end
    end
    cfgs.tLimit = {maxHpLv = maxId,minHpLv = minId}
end
--v5.2 小额付费
function ConfigChecker:CfgMicroPayment(cfgs)
    g_SmallPayMapItemToAct = {}
    for id, cfg in pairs(cfgs) do
        cfg.startTime = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.endTime = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
        cfg.mapConInfo = cfg.mapConInfo or {}
        for _,itemId in ipairs(cfg.shopItem or {}) do
            g_SmallPayMapItemToAct[itemId] = cfg.id
            local mCfg = CfgMicroCondtion[itemId] 
            for i,v in ipairs(mCfg and mCfg.conditiontype or {}) do
                local num1 = mCfg.conditionnum1 and mCfg.conditionnum1[i]
                local num2 = mCfg.conditionnum2 and mCfg.conditionnum2[i]
                if not num2 then
                    cfg.mapConInfo[v] = num1
                else
                    cfg.mapConInfo[v] = cfg.mapConInfo[v] or {}
                    cfg.mapConInfo[v][num1] = num2
                end
            end
        end
    end
end

-- v 5.2  历战试炼-连锁战线
function ConfigChecker:CfgChain(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.begTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
        assert(cfg.nStart < cfg.nEnd, "开放时间范围有误")
    end
end

-- v 5.1  早餐卡
function ConfigChecker:CfgBreakfastCard(cfgs)
    g_BreakfastMapItemToAct = {}
    for _, cfg in pairs(cfgs) do
        g_BreakfastMapItemToAct[cfg.itemid] = cfg.id
        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
        cfg.nLastBuyTime = GCalHelp:GetTimeStampBySplit(cfg.openTime, cfg)
        assert(cfg.nStart < cfg.nEnd, "开放时间范围有误")
        assert(cfg.nLastBuyTime <= cfg.nEnd, "开通截止时间有误")
        local rwdCfg = CfgBreakfastReward[cfg.rewardgroup]
        for _,rCfg in pairs(rwdCfg and rwdCfg.infos or {}) do
            g_BreakfastMapItemToAct[rCfg.goodsId] = cfg.id
        end
        cfg.mapDayBuy = {}
        local rwdCfg = CfgBreakfastReward[cfg.rewardgroup]
        for _,mCfg in ipairs(rwdCfg and rwdCfg.infos or {}) do
            cfg.mapDayBuy[mCfg.index] = mCfg.goodsId
        end
    end
end

-- v 5.4  连续累充
function ConfigChecker:CfgGoldenRebate(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.nBeginTime = GCalHelp:GetTimeStampBySplit(cfg.begTime, cfg)
        cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
    end
end

-- v 5.6 角色培养引导
function ConfigChecker:CfgRoleTrainGuide(cfgs)
    if IS_CLIENT then
        return
    end

    local cfgName = cTaskCfgNames[eTaskType.RoleTrainGuild]
    local tasksCfg = Cfgs[cfgName]

    for _, cfg in pairs(cfgs) do
        cfg.nBeginTime = GCalHelp:GetTimeStampBySplit(cfg.openTime, cfg)
        cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.closeTime, cfg)

        if cfg.taskGroup then
            local taskCfgArr = tasksCfg:GetGroup(cfg.taskGroup)
            for _, taskCfg in ipairs(taskCfgArr or {}) do
                taskCfg.roleTrainGuildId = cfg.id
            end            
        end
        
        local buyLimits = {}
        for ix, puductId in ipairs(cfg.puductIds or {}) do
            buyLimits[puductId] = cfg.buyLimitTaskCnt[ix]

            local productCfg = CfgCommodity[puductId]
            ASSERT(productCfg.nType == CommodityItemType.RoleTrainGuide, "角色引导培养商品的类型 nType 需要填为 CommodityItemType.RoleTrainGuide:" .. productCfg.nType)

            productCfg.roleTrainGuideId = cfg.id
        end

        cfg.buyLimits = buyLimits
    end

end

-- v 5.6 角色培养引导
function ConfigChecker:CfgRoleTrainGuideTask(cfgs)
    if IS_CLIENT then
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.RoleTrainGuild)
end
-- v 5.7 虚数天灾
function ConfigChecker:CfgVirtualCataclysmEntrance(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end
    CommCalCfgTasks(cfgs, eTaskType.CrossBoss)
end
function ConfigChecker:CfgVirtualCataclysm(cfgs)
    for _, cfg in pairs(cfgs) do
        if cfg.startTime then
            cfg.nStartTime = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        end
        if cfg.endTime then
            cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
        end
    end
end
function ConfigChecker:CfgBuffVirtualCataclysm(cfgs)
    g_CrossBossBuffMap = {}
    for _, cfg in pairs(cfgs) do
        if cfg.BuffGroup then
			g_CrossBossBuffMap[cfg.BuffGroup] = g_CrossBossBuffMap[cfg.BuffGroup] or {}
            table.insert(g_CrossBossBuffMap[cfg.BuffGroup],cfg.id)
        end
    end
end
