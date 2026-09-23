-- OPENDEBUG()
GCalHelp = {}

-------------------------------------------------------------------------------------------------------------------
-- 加上某个值
function GCalHelp:Add(tb, key, val)
    if not val then
        return
    end

    local orignVal = tb[key] or 0
    local curVal = orignVal + val
    tb[key] = curVal

    -- LogDebug("GCalHelp:Add( key:%s : %s + %s = %s)", key, orignVal, val, curVal)
    return curVal, orignVal
end

-- 乘以某个值
function GCalHelp:Multi(tb, key, val)
    if not val then
        return
    end

    local orignVal = tb[key] or 1
    local curVal = orignVal * val
    tb[key] = curVal
    -- LogDebug("GCalHelp:Multi( %s : %s * %s = %s)", key, orignVal, val, curVal)
    return curVal, orignVal
end

-------------------------------------------------------------------------------------------------------------------
-- 获取表格
-- wkv : 是否设置弱引用 传入 'k', 'v', 'kv'
function GCalHelp:GetTb(tb, key, def, wkv)
    if not key then
        return nil
    end

    -- LogTrace()
    local t = tb[key]
    if not t then
        ASSERT(def == nil or type(def) == 'table')

        tb[key] = def or {}
        t = tb[key]

        if wkv then
            setmetatable(t, {__mode = wkv})
        end
    end

    return t
end

-------------------------------------------------------------------------------------------------------------------
--
function GCalHelp:GetVal(tb, key, def)
    local t = tb[key]
    if t == nil and def ~= nil then
        tb[key] = def
        t = def
    end

    return t
end

-------------------------------------------------------------------------------------------------------------------
-- 获取二级索引的值，没有返回默认值
function GCalHelp:GetTbValeByKey(tb, index, key, def)
    local info = tb[index]
    if not info then
        -- LogWarning('Can not get by index:%s, key: %s, use def val, %s', index, key, def)
        return def
    end

    local val = info[key]
    if not val then
        -- LogWarning('Can not get by index:%s, key: %s, use def val, %s', index, key, def)
        return def
    end

    return val
end

-------------------------------------------------------------------------------------------------------------------
function GCalHelp:CheckGetVal(tb, def, ...)
    if not tb then
        return def
    end

    local tv = nil
    local ntb = tb
    local args = {...}
    -- LogDebug("===================================================================================")
    -- LogTable(args, "GCalHelp:CheckGetVal")
    -- LogDebug("===================================================================================")
    for _, k in ipairs(args) do
        tv = ntb[k]
        if tv == nil then
            return def
        end
        ntb = tv
    end

    return tv
end

-------------------------------------------------------------------------------------------------------------------
-- GetTimeStampBySplit
-- sDate : 以字符分割的数字时间（顺序 年 月 日 时 分 秒）， 如：2018-11-12 10:30:18
-- ret
-- -- 配置为空 返回0
-- -- 格式有错，返回nil
function GCalHelp:GetTimeStampBySplit(sDate, tModule)
    if not sDate or sDate == '' then
        return 0
    end

    if type(sDate) ~= 'string' then
        LogError('sDate %s type not string!!!!!!:', sDate)
        if tModule then
            LogTable(tModule, 'GetTimeStampBySplit() from:')
        end
        return
    end

    local rt = {}
    string.gsub(
        sDate,
        '%d+',
        function(w)
            table.insert(rt, w)
        end
    )

    local len = #rt
    if len == 3 then
        return rt[1] * 3600 + rt[2] * 60 + rt[3]
    elseif len == 6 then
        local parm = {year = rt[1], month = rt[2], day = rt[3], hour = rt[4], min = rt[5], sec = rt[6]}
        local isOk, dt = pcall(os.time, parm)
        ASSERT(isOk, table.Encode({ errMsg = dt, parm = parm, sDate = sDate, tModule = tModule }))
        return dt
    else
        LogError('sDate %s split error!!!!!!!', sDate)
        LogTable(rt, 'GCalHelp:GetTimeStampBySplit():')
        if tModule then
            LogTable(tModule, 'GetTimeStampBySplit() from:')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- 输入： [1001, 1, 1002, 2]
-- 返回：{ { id =1001, num =1 }, { id =1002, num =2 }]
-- 输入： [1001, 1, 1, 1002, 2, 2]
-- 返回：{ { id =1001, num =1, type =1 }, { id =1002, num =2, type =2 }]
function GCalHelp:ArrToIdNumTb(arr, numMulti)
    numMulti = numMulti or 1

    local len = #arr
    local ret = {}
    if len % 2 == 0 then
        for i = 1, len, 2 do
            table.insert(ret, {id = arr[i], num = math.ceil(arr[i + 1] * numMulti), type = RandRewardType.ITEM})
        end
    elseif len % 3 == 0 then
        for i = 1, len, 3 do
            table.insert(
                ret,
                {id = arr[i], num = math.ceil(arr[i + 1] * numMulti), type = arr[i + 2] or RandRewardType.ITEM}
            )
        end
    end

    return ret
end

-------------------------------------------------------------------------------------------------------------------
-- 输入：[[1001, 1, 1], [1002, 2, 2]]
-- 返回：{ { id =1001, num =1, type =1 }, { id =1002, num =2, type =2 }]
function GCalHelp:IdNumArrToTb(arr, numMulti, numAdd, ret)
    numAdd = numAdd or 0
    numMulti = numMulti or 1

    ret = ret or {}
    for _, v in ipairs(arr) do
        local num = v[2]
        if v[4] then
            -- 有第四个值，为随机值，那么
            num = math.ceil(math.random(num, v[4]))
        end

        -- 向上取整
        table.insert(ret, {id = v[1], num = math.ceil(num * numMulti) + numAdd, type = v[3] or RandRewardType.ITEM})
    end

    return ret
end

function GCalHelp:TbToIdNumArr(arr)
    local ret = {}
    for _, v in ipairs(arr) do
        table.insert(ret, {v.id, v.num, v.type})
    end
    return ret
end

----------------------------------------------------------------------------------
-- 计算处理权重值
function GCalHelp:CalArrWeight(arr, field, sumField)
    if not arr then
        return
    end

    local sumWeight = 0
    for _, info in ipairs(arr) do
        local orign = info[field]
        if not orign then
            LogError('GCalHelp:CalArrWeight not field %s', field)
        end
        info[sumField] = orign + sumWeight
        sumWeight = sumWeight + orign
    end
end

----------------------------------------------------------------------------------
-- 使用预先计算的权重来取值
-- 返回 arr[i], i
function GCalHelp:GetByWeight(arrTb, weightField)
    -- LogDebug("GCalHelp:GetByWeight weightField: %s", weightField)
    -- LogTable(arrTb, "GCalHelp:GetByWeight arrTb:")
    local r = math.random(arrTb[#arrTb][weightField])
    -- 末尾已经是计算好的总权重值
    for i, v in ipairs(arrTb) do
        if r <= v[weightField] then
            return v, i
        end
    end

    return nil, nil
end

----------------------------------------------------------------------------------
-- 使用没有预先计算的权重来取值
function GCalHelp:GetByCalWeight(arrTb, weightField)
    -- LogDebug("GCalHelp:GetByCalWeight weightField: %s", weightField)
    -- LogTable(arrTb, "GCalHelp:GetByCalWeight arrTb:")
    local weight = 0
    for _, v in ipairs(arrTb) do
        weight = weight + v[weightField]
    end

    local r = math.random(weight)
    for i, v in ipairs(arrTb) do
        if r <= v[weightField] then
            return v, i
        else
            r = r - v[weightField]
        end
    end
end

-----------------------------------------------------------------------------------------------------------------
-- 生成 20 位的兑换码
-- -- 2：平台 -- 6：id -- 12 -- 随机码--
-- val: 十进制
-- len: 需要的字符长度，小于前边补0
function GCalHelp:GetStrByNum(val, len)
    local retVal = string.format('%0' .. len .. 'X', val)
    -- LogDebug("GetStrByNum retVal: %s", retVal)
    return retVal
end

local exchagneCodeArr = {
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    -- "I", -- 去掉
    'J',
    'K',
    'L',
    'M',
    'N',
    -- "O", -- 去掉
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
}

local exchangeCodeSep = '-'
local exchagneCodeArrLen = table.size(exchagneCodeArr)

-- 从 exchagneCodeArr 随机一个码数来
function GCalHelp:GetStrCode(len)
    local randArr = {}

    -- 随机数组
    for i = 1, len, 1 do
        local index = math.random(exchagneCodeArrLen)
        table.insert(randArr, exchagneCodeArr[index])
    end

    -- 连接
    local retStr = table.concat(randArr)

    -- LogDebug("GetStrCode retVal: %s", retStr)
    return retStr
end

----------------------------------------------------------------------------------
--
-- 类型
-- plat : 1 ~ 255 最大值
-- id   ：1 ~ ‭16777215‬ 最大值
function GCalHelp:GetExchangeCodePre(plat, id)
    local partA = self:GetStrByNum(plat, 2)
    local partB = self:GetStrByNum(id, 6)

    -- 在第四个空字符后面添加空格
    local retStr = partA .. string.sub(partB, 1, 2) .. exchangeCodeSep .. string.sub(partB, 3, -1)

    -- LogDebug("GetExchangeCodePre retVal: %s", retStr)
    return retStr
end

----------------------------------------------------------------------------------
--
function GCalHelp:GetExchangeCodeSub()
    local len = 4
    local retStr =
        self:GetStrCode(len) .. exchangeCodeSep .. self:GetStrCode(len) .. exchangeCodeSep .. self:GetStrCode(len)
    -- console.log("GetExchangeCodeSub:", retStr)
    return retStr
end

----------------------------------------------------------------------------------
-- 根据时间返回服务器活动的当天，月份，天数
-- args:
---- isYearDay: 是否按一年第几天返回，false, 则返回当月第几天
---- osDate：os.date("*t", os.time()） 返回的今天时间信息的结构体
---- osTime 当前时间戳
-- return:
---- month(1~12), day(1~31)
function GCalHelp:GetActiveUseDay(isYearDay, osDate, osTime)
    if not osTime then
        osTime = CURRENT_TIME
    end

    if not osDate then
        osDate = os.date('*t', osTime)
    end

    -- LogTable(osDate, "osDate:")
    -- 如果没过特定的时间点，算前一天
    if osDate.hour < g_ActivityDiffDayTime then
        osTime = osTime - 86400 -- 86400 等于(24 x 60 x 60)一天多少秒
        osDate = os.date('*t', osTime)
    end

    local useDay = osDate.day
    if isYearDay then
        useDay = osDate.yday
    end

    return osDate.month, useDay
end

----------------------------------------------------------------------------------
--
function GCalHelp:NumkeyToStr(map)
    for k, v in pairs(map) do
        map[k] = nil
        map[tostring(v)] = v
    end
end

----------------------------------------------------------------------------------
--
function GCalHelp:StrkeyToNum(map)
    for k, v in pairs(map) do
        map[k] = nil
        map[tonumber(v)] = v
    end
end

----------------------------------------------------------------------------------
-- 根据时间差，返回过了多少周期，还有剩余多少时间没算进去
-- 已过周期，剩余时间（不足一个周期）
function GCalHelp:GetPeriodCnt(preTime, needDiff, curTime)
    local periodCnt = 0
    local leftTime = 0

    if preTime <= 0 then
        return periodCnt, leftTime
    end

    curTime = curTime or CURRENT_TIME
    local diff = curTime - preTime

    if diff > 0 then
        periodCnt = math.floor(diff / needDiff)
        leftTime = diff % needDiff
    end

    LogDebug(
        'GCalHelp:GetPeriodCnt() preTime: %s, needDiff: %s, curTime: %s, diff: %s, periodCnt:%s, reduceTime:%s',
        preTime,
        needDiff,
        curTime,
        diff,
        periodCnt,
        leftTime
    )
    return periodCnt, leftTime
end

----------------------------------------------------------------------------------------------------------------------------------------------
--
function GCalHelp:GetArmyRobotTeams(uid, teamIds, formatId, teamType)
    local sgk, _ = _G.next(CfgPlrSkillGroup)

    local ret = {
        uid = uid,
        is_robot = BoolType.Yes,
        performance = 0,
        team = {
            leader = 0
            , index = teamType
            , skill_group_id = sgk
            , skill_group_lv = 1
            , data = {
                card_info = {}
            }
        }
    }

    -- 计算队伍的站位信息
    local formation = MonsterFormation[formatId]
    if formatId and formation then
        for i, mid in ipairs(teamIds) do
            local mCfg = MonsterData[mid]
            if mCfg then
                if not ret.team.leader then
                    ret.team.leader = mCfg.card_id
                end

                local pos = formation.coordinate[i]
                table.insert(
                    ret.team.data,
                    {
                        cid = mCfg.card_id,
                        index = i,
                        row = pos[1],
                        col = pos[2],
                        card_info = {
                            cid = mCfg.card_id,
                            cfgid = mCfg.card_id,
                            level = mCfg.level,
                            break_level = mCfg.break_level,
                            name = mCfg.name
                        }
                    }
                )
            end
        end
    end

    -- LogTable(ret, "GCalHelp:GetArmyRobotTeams:")
    return ret
end

----------------------------------------------------------------------------------------------------------------------------------------------
-- 
function GCalHelp:GetArmyRobotSimpleTeams(uid, teamIds)
    local ret = {
        uid = uid,
        is_robot = BoolType.Yes,
        team = {}
    }

    for _, mid in ipairs(teamIds) do
        local mCfg = MonsterData[mid]
        if mCfg then
            local robotCard = {
                cfgid = mCfg.card_id,
                level = mCfg.level,
                break_level = mCfg.break_level,
                name = mCfg.name,
                skin = 0,
            }
            table.insert(ret.team, robotCard)
        end
    end

    return ret
end

----------------------------------------------------------------------------------------------------------------------------------------------
--
function GCalHelp:GetFreeArmyRobotSimpleTeams(robotCfgId)
    local ret = {
        uid = robotCfgId,
        is_robot = BoolType.Yes,
        teams = {}
    }

    local robotCfg = CfgPvpRobot[robotCfgId]

    for i, groupId in ipairs(robotCfg.aTeamIds) do
        local gCfg = MonsterGroup[groupId]
        local stage = gCfg.stage[1]
        local robotInfo = self:GetArmyRobotTeams(robotCfgId, stage.monsters, stage.formation, i)
        table.insert(ret.teams, robotInfo.team)
    end

    return ret
end

----------------------------------------------------------------------------------------------------------------------------------------------
--
function GCalHelp:GetFreeArmy3RobotSimpleTeams(robotCfgId)
    local ret = {
        uid = robotCfgId,
        is_robot = BoolType.Yes,
        teams = {}
    }

    local robotCfg = CfgPvp3Robot[robotCfgId]

    local teamIx = eTeamType.PVP3

    for i, groupId in ipairs(robotCfg.aTeamIds) do
        local gCfg = MonsterGroup[groupId]
        local stage = gCfg.stage[1]
        local robotInfo = self:GetArmyRobotTeams(robotCfgId, stage.monsters, stage.formation, teamIx)
        ret.teams[i] = robotInfo.team
        teamIx = teamIx + 1
    end

    return ret
end

-------------------------------------------------------------------------------------
-- 获取被动buff属性
-- 33	增加物品获得数量	add_get_item_num
-- 34	增加物品获得百分比	add_get_item_pct
function GCalHelp:GetIsPassivBuf(liftBufCfg)
    if liftBufCfg.jValiTime or liftBufCfg.jOpenDups then
        return true
    end

    return false
end

-- -- 33	增加物品获得数量	add_get_item_num
-- -- 34	增加物品获得百分比	add_get_item_pct
function GCalHelp:GetBufIsUseKeyVals(liftBufCfg)
    if liftBufCfg.nType == 33 or liftBufCfg.nType == 34 then
        return true
    end

    return false
end

----------------------------------------------------------------------------------------------------------------------------------------------
--
function GCalHelp:GetBufsTypeFromName(nameArr)
    local bTypes = {}
    local cardFieldToIndex = GobalCfg:Get('cardFieldToIndex')

    for _, n in ipairs(nameArr) do
        table.insert(bTypes, cardFieldToIndex[n])
    end

    table.sort(bTypes)

    return bTypes
end

----------------------------------------------------------------------------------------------------------------------------------------------
--
function GCalHelp:GetPassivBuf(passivBufIds, cfgMainLine, nameArr, ret)
    -- LogTable(passivBufIds, "LifeBuffMgr:GetPassivBuf() passivBufIds:")

    local bTypes = self:GetBufsTypeFromName(nameArr)

    ret = ret or {}

    for _, id in ipairs(passivBufIds) do
        local liftBufCfg = CfgLifeBuffer[id]
        if liftBufCfg and self:GetIsPassivBuf(liftBufCfg) then
            if table.empty(bTypes) or GCalHelp:Bsearch(bTypes, liftBufCfg.nType) then
                -- 判断有效期，和有效性
                local isInRange = true
                if liftBufCfg.jValiTime then
                    isInRange = false

                    for _, timeRange in ipairs(liftBufCfg.jValiTime) do
                        if TimerHelper:CurTimeIsInRange(timeRange[1], timeRange[2]) then
                            isInRange = true
                        end
                    end
                end

                if isInRange then
                    local isInDup = true
                    if liftBufCfg.jOpenDups then
                        isInDup = false

                        local dupIds = liftBufCfg.jOpenDups[1]
                        if #dupIds > 0 then
                            local isFind, index, val = GCalHelp:Bsearch(dupIds, cfgMainLine.id)
                            -- LogDebug("GCalHelp:GetPassivBuf() cfgMainLine.id:%s, find:%s", cfgMainLine.id, isFind)
                            -- LogTable(dupIds, "dupIds:")
                            isInDup = isFind
                        else
                            if
                                cfgMainLine.type == liftBufCfg.jOpenDups[2] and
                                    cfgMainLine.group == liftBufCfg.jOpenDups[3]
                             then
                                isInDup = true
                            end
                        end
                    end

                    if isInDup then
                        local isUseVal = true
                        if GCalHelp:GetBufIsUseKeyVals(liftBufCfg) then
                            isUseVal = false
                        end

                        local fInfo = ret[liftBufCfg.sFieldName]
                        if not fInfo then
                            fInfo = {val = 0, vals = {}}
                            ret[liftBufCfg.sFieldName] = fInfo
                        end

                        -- LogTable(liftBufCfg, "liftBufCfg:")
                        if liftBufCfg.bIsAdd then
                            if isUseVal then
                                GCalHelp:Add(fInfo, 'val', liftBufCfg.jValMap[1])
                            else
                                -- 暂时被动buf, 的第一个都是id值
                                local vals = GCalHelp:GetTb(fInfo, 'vals', {})
                                for k, arr in pairs(liftBufCfg.jValMap) do
                                    if vals[k] then
                                        vals[k][2] = vals[k][2] + arr[2]
                                    else
                                        vals[k] = table.copy(arr)
                                    end
                                end
                            end
                        else
                            if isUseVal then
                                fInfo.val = liftBufCfg.jValMap[1]
                            else
                                fInfo.vals = table.copy(liftBufCfg.jValMap)
                            end
                        end
                    end
                end
            else
                -- 没有选入，表示 nameArr 参数没有获取要求
                -- LogError("GCalHelp:GetPassivBuf, buff id:%s, nType:%s(%s) not find in nameArr", id, liftBufCfg.nType, CfgCardPropertyEnum[liftBufCfg.nType].sFieldName)
            end
        end
    end

    -- LogTable(ret, "GCalHelp:GetPassivBuf ret:")
    return ret
end

----------------------------------------------------------------------------------------------------------------------------------------------
-- passivBufReward：保存被动buf添加的
function GCalHelp:CalAddDupItems(orignReward, buffArr, passivBufReward)
    passivBufReward = {} or passivBufReward

    local addItemBufNames = {'add_get_item_num', 'add_get_item_pct'}

    -- LogTable(buffArr, 'GCalHelp:CalAddDupItems:')
    -- 合并两个被动buf，玩家和卡牌的
    -- plrBufs passivBufAdds
    local addItemBufs = {}
    for _, n in ipairs(addItemBufNames) do
        for _, tb in ipairs(buffArr) do
            local info = tb[n]
            if info then
                local curInfo = self:GetTb(addItemBufs, n, {})
                if info.val then
                    self:Add(curInfo, 'val', info.val)
                end

                if info.vals then
                    local vals = self:GetTb(curInfo, 'vals', {})
                    for k, arr in pairs(info.vals) do
                        -- vals[1] 是掉落的物品id
                        if vals[k] then
                            vals[k][2] = vals[k][2] + arr[2]
                        else
                            vals[k] = table.copy(arr)
                        end
                    end
                end
            end
        end
    end

    local addItemNumList = addItemBufs['add_get_item_num']
    local addItemPctList = addItemBufs['add_get_item_pct']

    -- LogTable(addItemNumList, 'addItemNumList:')
    -- LogTable(addItemPctList, 'addItemPctList:')
    -- LogTable(orignReward, 'orignReward:')

    if addItemPctList or addItemNumList then
        for _, rItem in pairs(orignReward) do
            if addItemNumList then
                local addInfo = addItemNumList.vals[rItem.id]
                if addInfo then
                    -- 这里只添加额外的，不包含原来的
                    local add = table.copy(rItem)
                    add.num = addInfo[2]
                    table.insert(passivBufReward, add)
                end
            end

            if addItemPctList then
                local addInfo = addItemPctList.vals[rItem.id]
                if addInfo then
                    -- 这里只添加额外的，不包含原来的
                    local add = table.copy(rItem)
                    add.num = math.floor(add.num * addInfo[2])
                    table.insert(passivBufReward, add)
                end
            end
        end
    end

    -- LogTable(passivBufReward, 'GCalHelp:CalAddDupItems passivBufReward:')
    return passivBufReward
end

----------------------------------------------------------------------------------------------------------------------------------------------
-- number: 身份证号码
--
-- return: accType, accIndex, age
-- accType： 玩家/游客
-- accIndex：对应类型的配置索引
-- age：计算的年龄
function GCalHelp:CalAccType(number, curTime)
    if not number then
        return AccType.Guest, 1, 0
    end

    if number:len() < 18 then
        return AccType.Guest, 1, 0
    end

    local sStr = number:sub(7, 14)
    local info = {
        year = tonumber(sStr:sub(1, 4)),
        month = tonumber(sStr:sub(5, 6)),
        day = tonumber(sStr:sub(7, 8))
    }

    -- LogTable(info, "GCalHelp:CalAccType:")
    return self:CalAccTypeByInfo(info, curTime)
end

----------------------------------------------------------------------------------------------------------------------------------------------
--
function GCalHelp:CalAccTypeByInfo(info, curTime)
    if info.year < 1900 or info.month < 1 or info.month > 12 or info.day < 1 or info.day > 31 then
        return AccType.Guest, 1, 0
    end

    local curInfo = os.date('*t', curTime)
    local age = curInfo.year - info.year
    if curInfo.month <= info.month then
        if curInfo.month < info.month then
            age = age - 1
        else
            if curInfo.day <= info.day then
                age = age - 1
            end
        end
    end

    -- LogInfo("GCalHelp:CalAccTypeByInfo age:%s", age)
    local cfgs = CfgAccTypeLimit[AccType.Plr]
    -- LogTable(CfgAccTypeLimit, "CfgAccTypeLimit:")
    -- LogTable(cfgs, "cfgs:")
    for index, cfg in pairs(cfgs.infos) do
        if GLogicCheck:IsInRange(cfg.ageLimitA, cfg.ageLimitB, age) then
            LogDebug('GCalHelp:CalAccTypeByInfo cfg.id: %s, index: %s, age: %s', AccType.Plr, index, age)
            return AccType.Plr, index, age
        end
    end

    return AccType.Guest, 1, age
end

----------------------------------------------------------------------------------------------------------------------------------------------
--
function GCalHelp:IsLimitLoginTime(antiInfo)
    -- LogTable(antiInfo, "GCalHelp:IsLimitLoginTime antiInfo:")
    local accType = AccType.Guest
    local subType = 1
    if antiInfo and antiInfo.accType then
        accType = antiInfo.accType
        subType = antiInfo.subType
    end

    local accTypeCfg = CfgAccTypeLimit[accType]
    if accTypeCfg then
        local subCfg = accTypeCfg.infos[subType]
        if subCfg and subCfg.canLoginTimeRange then
            local arr = subCfg.canLoginTimeRange
            -- 因为这里取当前 小时 作为判断后边的分是不计算的，例如填[8, 10]小时可以登陆，所以这里要减掉1小时，符合配置要求
            if not GLogicCheck:IsInRange(arr[1], arr[2] - 1, CommDataMgr:GetCurHour()) then
                return true, arr, subCfg
            end
        end
    end

    return false
end

----------------------------------------------------------------------------------------------------------------------------------------------
-- args:
-- 	timeArr: [年，月，日，时，分，秒]， -1 表示忽略
-- 	curTime : 当前时间， 秒数时间戳
-- return:
-- 	返回开始的时间戳
function GCalHelp:CalTimeByArr(timeArr, curTime)
    if not timeArr then
        return nil
    end

    local tmp = os.date('*t', curTime)
    local year, month, day, hour, min, sec = timeArr[1], timeArr[2], timeArr[3], timeArr[4], timeArr[5], timeArr[6]

    if year and year > -1 then
        tmp.year = year
    end

    if month and month > -1 then
        tmp.month = month
    end

    if day and day > -1 then
        tmp.day = day
    end

    if hour and hour > -1 then
        tmp.hour = hour
    end

    if min and min > -1 then
        tmp.min = min
    end

    if sec and sec > -1 then
        tmp.sec = sec
    end

    local t = os.time(tmp)
    return t
end

----------------------------------------------------------------------------------------------------------------------------------------------
-- 把奖励列表合并
function GCalHelp:MergeRewards(rewards)
    local ret = {}

    local mapByType = {
        [RandRewardType.ITEM] = {}
        -- [RandRewardType.CARD] = {},
        -- [RandRewardType.EQUIP] = {}
    }
    -- LogTable(mapByType, "GCalHelp:MergeRewards mapByType:")
    for _, reward in ipairs(rewards) do
        if not reward.type then
            reward.type = RandRewardType.ITEM
        end

        -- LogTable(reward, "GCalHelp:MergeRewards reward:")
        local list = mapByType[reward.type]
        if list then
            local info = list[reward.id]
            if not info then
                list[reward.id] = table.copy(reward)
            else
                info.num = info.num + reward.num
            end
        else
            table.insert(ret, reward)
        end
    end

    for _, list in pairs(mapByType) do
        for _, v in pairs(list) do
            table.insert(ret, v)
        end
    end

    return ret
end

----------------------------------------------------------------------------------------------------------------------------------------------
--
function GCalHelp:ForRank(arr, begRank, endRank, fun, maxLen)
    maxLen = maxLen or 50
    local endIndex = #arr

    LogDebug("GCalHelp:ForRank() begRank:%s, endRank:%s, arr len:%s, maxLen:%s", begRank, endRank, endIndex, maxLen)

    if endIndex == 0 then
        LogWarning("GCalHelp:ForRank() arr len is 0!")
        return
    end

    if endIndex > endRank then
        endIndex = endRank
    end

    local begIndex = begRank
    if begIndex < 1 or begIndex > endIndex then
        ASSERT(false)
    end

    if endIndex - begIndex > maxLen then
        ASSERT(false)
    end

    for i = begIndex, endIndex, 1 do
        fun(i, arr[i])
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------
-- 返回数组中第一个比val 大的值， 如果没有，就返回第一个
-- args:
-- vals: 从小到大排序的数组
-- val: 检测的值
-- return 第一个比val大的值 是否是从头开始
function GCalHelp:GetFirstBigger(vals, val)
    for ix, h in ipairs(vals) do
        if h > val then
            return h, false, ix
        end
    end

    return vals[1], true, 1
end

----------------------------------------------------------------------------------------------------------------------------------------------
-- 检测是否到刷新的时间
-- return
-- bool 是否刷新
-- int next hour
-- bool isNext(是已经超过末尾否从头来过)
function GCalHelp:IsHourFlush(hours, preHour, curHour)
    if preHour < hours[1] then
        preHour = hours[1]
    end

    local isFind, index, val = false, nil, nil
    for i = preHour, curHour, 1 do
        isFind, index, val = GCalHelp:Bsearch(hours, i)
        if isFind then
            break
        end
    end

    return isFind, self:GetFirstBigger(hours, curHour)
end

function CalIsFlushHourDiffIx(flushHours, curYDay, maxIx, lastYDay, canIndex)
    local diffDot = 1
    if maxIx == 0 then
        return diffDot
    end

    canIndex = canIndex or 1

    if lastYDay == 0 then
        diffDot = canIndex
    else
        local diffDay = curYDay - lastYDay
        if diffDay < 2 then
            diffDay = 0
        end

        if maxIx >= canIndex then
            diffDot = diffDay * #flushHours + canIndex
        else
            diffDot = diffDay * #flushHours + canIndex - maxIx
        end
    end

    LogDebug(
        'CalIsFlushHourDiffIx() curYDay:%s, maxIx:%s, lastYDay:%s, canIndex:%s, diffDot:%s',
        curYDay,
        maxIx,
        lastYDay,
        canIndex,
        diffDot
    )
    return diffDot
end

----------------------------------------------------------------------------------------------------------------------------------------------
-- args:
-- flushHours: 刷新的时间点 [ 0, 1, 3 ~ 23], 需要已经从小到大排序
-- recoreds: 已经刷新过的记录（Tips: 这个table会被修改）
-- -- -- -- {
-- -- -- -- 	[刷新时间点] = yday(一年中的第几天)
-- -- -- -- }
-- curHour:
-- curYDay:
-- return:
-- bool : 是否刷新
-- int  ：下次刷新时间 flushHours 的下标
-- bool : isNextDay, 下次刷新时间, 是否是隔天
-- diffDot: 间隔了多少个刷新点
-- Tips: recoreds 使用 flushHours 的下标作为索引，因为更新时间有0小时，所以不能用flushHours，包含的小时来做索引
function GCalHelp:GetIsFlushHour(flushHours, recoreds, curHour, curYDay)
    -- LogDebug('')
    -- LogTrace("GCalHelp:GetIsFlushHour")
    local isNextDay = false
    if table.empty(flushHours) then
        return false
    end

    LogDebug('curHour:%s, curYDay:%s', curHour, curYDay)
    LogTable(flushHours, 'GCalHelp:GetIsFlushHour() flushHours：')
    LogTable(recoreds, 'GCalHelp:GetIsFlushHour() recoreds:')

    local canIndex = nil -- 最大可更新的下标
    local maxIx = 0
    local lastYDay = 0
    local fLen = #flushHours
    for i = fLen, 1, -1 do
        local v = flushHours[i]
        if not canIndex then
            if curHour >= v then
                canIndex = i
            end
        end

        local recordVal = recoreds[i]
        LogDebug('GetIsFlushHour() i:%s, v:%s, recordVal %s', i, v, recordVal)
        if recordVal and recordVal > lastYDay then
            LogDebug('GetIsFlushHour() use i:%s, recordVal:%s', i, recordVal)
            maxIx = i
            lastYDay = recordVal
        end
    end

    -- 刷新一次昨天的记录
    if not canIndex then
        local lastIx = #flushHours
        if table.empty(recoreds) then
            recoreds[lastIx] = curYDay - 1
            return true, 1, isNextDay, 0
        else
            -- 还没到第一个的刷新时间， 那么看看最后一个, 这个就是间隔了一两天没上的情况
            if not recoreds[lastIx] or curYDay - recoreds[lastIx] > 1 then
                recoreds[lastIx] = curYDay - 1
                local diffDot = CalIsFlushHourDiffIx(flushHours, curYDay, maxIx, lastYDay, canIndex)
                -- LogTable(recoreds, 'recoreds:')
                -- LogDebug(
                --     'GCalHelp:GetIsFlushHour return isFlush:%s, nextIx:%s, isNextDay:%s, diffDot:%s',
                --     true,
                --     1,
                --     isNextDay,
                --     diffDot
                -- )
                return true, 1, isNextDay, diffDot
            end
        end
    end

    local diffDot = CalIsFlushHourDiffIx(flushHours, curYDay, maxIx, lastYDay, canIndex)

    -- 还没到第二天的第一个刷新时间
    if not canIndex then
        -- LogDebug(
        --     'GCalHelp:GetIsFlushHour return isFlush:%s, nextIx:%s, isNextDay:%s, diffDot:%s',
        --     false,
        --     1,
        --     isNextDay,
        --     diffDot
        -- )
        return false, 1, isNextDay, diffDot
    end

    local nextIx = canIndex + 1
    if nextIx > #flushHours then
        nextIx = 1
        isNextDay = true
    end

    local preYDay = recoreds[canIndex]
    if preYDay and preYDay == curYDay then
        -- LogDebug(
        --     'GCalHelp:GetIsFlushHour return isFlush:%s, nextIx:%s, isNextDay:%s, diffDot:%s',
        --     false,
        --     nextIx,
        --     isNextDay,
        --     diffDot
        -- )
        return false, nextIx, isNextDay, diffDot
    end

    recoreds[canIndex] = curYDay
    -- LogTable(recoreds, 'recoreds:')
    -- LogDebug(
    --     'GCalHelp:GetIsFlushHour return isFlush:%s, nextIx:%s, isNextDay:%s, diffDot:%s',
    --     true,
    --     nextIx,
    --     isNextDay,
    --     diffDot
    -- )

    return true, nextIx, isNextDay, diffDot
end

function GCalHelp:CalNextFlushtTime(zeroTime, hour)
    return zeroTime + TimerHelper.cHourSeconds * hour
end

function GCalHelp:GetMonsterGroupHp(groupId)
    local useHp = 0

    local monsterCfg = MonsterGroup[groupId]
    local stage1 = monsterCfg.stage[1]

    for _, mId in ipairs(stage1.monsters) do
        local mCfg = MonsterData[mId]
        useHp = mCfg.maxhp + useHp
    end

    return useHp
end

------------------------------------------------------------------------------------------------------------
-- 基地远征使用
-- subId : CfgExpeditionTaskSub 表的 ids
-- subIndex : CfgExpeditionTaskSub 表的 index
function GCalHelp:CombineEdnTaskId(subId, subIndex)
    local retVal = subId * 100000 + subIndex
    -- LogDebug("ret: %s, subId: %s, subIx: %s", retVal, subId, subIndex)
    return retVal
end

function GCalHelp:SplitEdnTaskId(taskId)
    local subId = math.floor(taskId / 100000)
    local subIndex = taskId % 100000

    -- LogDebug("GCalHelp:SplitEdnTaskId(taskId:%s) subId:%s, subIndex:%s", taskId, subId, subIndex)
    return subId, subIndex
end

------------------------------------------------------------------------------------------------------------
--
function GCalHelp:IsHoliday(curDate, CfgHolidays)
    -- LogTable(curDate, "TodayIsHoliday curDate:")
    -- LogTable(CfgHolidays, "TodayIsHoliday CfgHolidays:")
    -- 不是周末的话，看看是不是法定假期
    local cfg = CfgHolidays[curDate.year]
    if cfg then
        local mCfg = cfg.holidays[curDate.month]
        if mCfg then
            return GCalHelp:Bsearch(mCfg.holidayArr, curDate.day)
        end
    end

    return false
end

------------------------------------------------------------------------------------------------------------
--
function GCalHelp:GetChatTbName(chatTypeName)
    local cacheName = 'chatLog' .. chatTypeName
    -- LogInfo("ChatMgr:GetCacheTbName: %s", cacheName)
    return cacheName
end

----------------------------------------------------------------------------------------------------------------------------------------------
-- 返回卡牌中止能添加多少热值
-- maxHot: 卡牌最大热值
-- curHot：当前热值
-- start_time：开始冷却时间
-- end_time：冷却完成时间
-- curTime：当前时间
function GCalHelp:GetCardCoolPauseAddHot(maxHot, curHot, start_time, end_time, curTime)
    local difHot = maxHot - curHot
    local difTime = end_time - start_time

    local addHot = 0
    local leftTime = end_time - curTime
    if leftTime <= 0 then
        addHot = difHot
    else
        addHot = math.floor(((difTime - leftTime) / difTime) * difHot)
    end

    return addHot
end

----------------------------------------------------------------------------------------------------------------------------------------------
-- 获取连续数值范围
-- args:
-- -- idArr : id数组
-- return:
-- sids : 单个id
-- rangs : 范围id
function GCalHelp:GetRangNum(idArr)
    -- LogEx({"GetRangNum input", idArr})

    idArr = idArr or {}

    table.sort(idArr)

    local sids = {}
    local rangs = {}

    local sIx = 1
    local eIx = sIx + 1
    local lIx = #idArr

    while sIx <= lIx do
        while eIx <= lIx do
            if idArr[eIx] - idArr[eIx - 1] == 1 then
                eIx = eIx + 1
            else
                eIx = eIx - 1
                break
            end
        end

        if eIx > lIx then
            eIx = lIx
        end

        if eIx - sIx >= 1 then
            table.insert(rangs, {idArr[sIx], idArr[eIx]})
            sIx = eIx + 1
        else
            table.insert(sids, idArr[sIx])
            sIx = sIx + 1
        end

        eIx = sIx + 1
    end

    -- LogEx({"GetRangNum output", { sids = sids, rangs = rangs}})
    return sids, rangs
end

-- args
-- -- arr: 数值数组
-- -- rangArr ： 数值范围数组 [ [1, 3], [5,100] ]
-- return
-- -- arr: 将范围数值，还原成id，插入 arr 中然后返回
function GCalHelp:RangNumToArr(arr, rangArr)
    arr = arr or {}
    rangArr = rangArr or {}

    for _, range in ipairs(rangArr) do
        local ib, ie = range[1], range[2]
        while ib <= ie do
            table.insert(arr, ib)
            ib = ib + 1
        end
    end

    return arr
end

----------------------------------------------------------------------------------------------------------------------------------------------
-- 宿舍相关
function GCalHelp:GetDormId(cfgId, index)
    return cfgId * 100 + index
end

function GCalHelp:GetDormCfgId(id)
    local cfgId = math.floor(id / 100)
    local index = math.floor(id % 100)
    return cfgId, index
end

-- 获取宿舍家具id
-- cfgId: 配置表愿你选哪个id
-- incId: 自增id
function GCalHelp:GetDormFurId(cfgId, incId)
    return cfgId * 10000 + incId
end

-- 获取宿舍家具cfgId
function GCalHelp:GetDormFurCfgId(id)
    local cfgId = math.floor(id / 10000)
    local incId = math.floor(id % 10000)
    return cfgId, incId
end

-- 计算宿舍舒适度添加疲劳值恢复百分比
-- 参数：
-- comfort 舒适度
--
-- 返回值:
-- 1: 添加的百分比
function GCalHelp:DormTiredAddPerent(comfort)
    return math.floor(comfort / 20)
end

-- 区分是宿舍id 还是建筑id
function GCalHelp:IsDormId(id)
    return id > 0 and id < 10000
end

----------------------------------------------------------------------------------------------------------------------------------------------
--
-- arg:
-- -- cfgId
-- return
-- baseCfgId : 一级的id
-- lv: 该技能的等级
function GCalHelp:GetEquipBaseIdAndLv(cfgId)
    local lv = cfgId % 100
    local baseCfgId = cfgId - lv + 1
    return baseCfgId, lv
end

----------------------------------------------------------------------------------------------------------------------------------------------
-- 计算生产中心，建筑的效益百分比值
-- local vals = {
-- 	-- 建筑的
-- 	build.perBenefit,
-- 	build.perHpBenefit,
-- 	build.perRoleTiredBenefit,
-- 	build.perRoleAbilityBenefit,
-- 	-- 全局的
-- 	mdata.power.perBenefit,
-- 	mdata.perRoleAbilityBenefit
-- }
-- 返回值：百分比(0 ~ 1) / (0, 1]
function GCalHelp:GetBuildProductBenefit(vals, buildRoleCnt)
    local retVal = 1
    for _, val in ipairs(vals) do
        if val then
            if val <= 0 then
                retVal = 0
                break
            end
            retVal = retVal * (val / 100)
        end
    end

    if g_BuildNotRoleBenefit and buildRoleCnt < 1 then
        retVal = retVal * (g_BuildNotRoleBenefit / 100)
    end

    -- LogTable(vals, "BuildsMgr:GetBenefit vals:")
    -- LogDebug("BuildsMgr:GetBenefit ret :%s", retVal)
    return retVal
end

-- 生成斐波那契数组
function GCalHelp:GenFiboSeries(n)
    local arr = {1}
    local sum = 1
    local preIx = 1
    local preVal = 0
    while sum < n do
        local preIxVal = arr[preIx]
        local val = preVal + preIxVal
        if sum + val > n then
            val = n - sum
        end

        preIx = preIx + 1

        arr[preIx] = val

        sum = sum + val
        preVal = preIxVal
    end

    -- LogTable(arr, "GCalHelp:GenFiboSeries(n) " .. n .. " :")
    return arr
end

-- 获取明天活动时间重置点
function GCalHelp:GetNextActiveZeroTime()
    return self:CalNextZeroTime(g_ActivityDiffDayTime)
end

-- zeroHour: 重置的小时
function GCalHelp:CalNextZeroTime(zeroHour)
    local oneHour = 60 * 60
    local curTimeStmap = os.time()

    -- 获取当天的0点时间
    local timeTable = os.date('*t', curTimeStmap)
    timeTable.hour = 0
    timeTable.min = 0
    timeTable.sec = 0
    local zeroTimeStmap = os.time(timeTable)

    local todyActiveTime = zeroTimeStmap + oneHour * zeroHour
    if curTimeStmap <= todyActiveTime then
        return todyActiveTime
    end

    local nextActiveTime = todyActiveTime + (24 * oneHour)
    -- LogDebug("GCalHelp:GetNextActiveZeroTime() netTime：%s", netTime)
    return nextActiveTime
end

-- 获取周期起始点
-- 2021-11-1 这一天刚好是每月的第一天与周一，符合当前游戏月与周重置的起始要求，所以以这天为起始点
-- Return:
-- 1:起始时间点：cycleTime
-- 2:起始时间点结构：cycleDate
function GCalHelp:GetCycleStartTime()
    -- 测试天
    -- local useDate = {year = 2022, month = 6, day = 25, hour = 0, min = 0, sec = 0}
    --
    -- 测试周
    -- local useDate = {year = 2022, month = 6, day = 20, hour = 0, min = 0, sec = 0}
    --
    -- 测试月
    -- local useDate = {year = 2021, month = 5, day = 1, hour = 0, min = 0, sec = 0}
    -- local useDate = {year = 2022, month = 5, day = 1, hour = 0, min = 0, sec = 0}
    -- local useDate = {year = 2022, month = 6, day = 1, hour = 0, min = 0, sec = 0}
    local useDate = {year = 2021, month = 11, day = 1, hour = 0, min = 0, sec = 0}
    local cycleStartTime = os.time(useDate)

    -- LogTable(useDate, "GetCycleStartTime cycleStartDate:" .. cycleStartTime)
    return cycleStartTime, useDate
end

-- Args:
-- cycleType： 配置表周期类型
-- cycleVal： 配置表周期值
-- curTime：当前时间戳
-- cycleStartTime: 周期时间点，不传，将自动调用 GetCycleStartTime() 返回
-- cycleStartDate: 周期时间点数据结构，不传，将自动调用 GetCycleStartTime() 返回
-- Ret:
-- 返回下次重置的时间戳
function GCalHelp:GetCycleResetTime(cycleType, cycleVal, curTime, cycleStartTime, cycleStartDate)
    if not cycleStartTime or not cycleStartDate then
        cycleStartTime, cycleStartDate = self:GetCycleStartTime()
    end

    if cycleVal < 1 then
        return 0
    end

    local resetTime = 0
    if cycleType == PeriodType.None then
        resetTime = 0
    elseif cycleType == PeriodType.Day then
        resetTime = self:GetDayCycle(curTime, cycleVal, cycleStartTime)
    elseif cycleType == PeriodType.Week then
        resetTime = self:GetWeekCycle(curTime, cycleVal, cycleStartTime)
    elseif cycleType == PeriodType.Month then
        resetTime = self:GetMonthCycle(curTime, cycleVal, cycleStartDate)
    else
        LogError('GCalHelp:GetCycleStartTime() unknow cycleType:%s', cycleType)
    end

    return resetTime
end

function GCalHelp:GetDayCycle(curTime, cycleVal, cycleStartTime)
    -- 周期间隔时间
    -- 86400: 一天的秒数
    local cycleTime = cycleVal * 86400
    -- LogDebug('GCalHelp:GetDayCycle() cycleTime:%s = cycleVal:%s * TimerHelper.cDaySeconds:%s', cycleTime, cycleVal, cycleTime)
    -- 取它的下一个周期
    local diffA = (curTime - cycleStartTime) / cycleTime
    local diffCycle = math.floor(diffA) + 1
    -- LogDebug('GCalHelp:GetDayCycle() curTime:%s, cycleStartTime:%s, diffA：%s, diffCycle:%s', curTime, cycleStartTime, diffA, diffCycle)
    -- 返回时间
    local ret = cycleStartTime + diffCycle * cycleTime
    -- LogTable(os.date('*t', ret), 'GCalHelp:GetDayCycle() cycleVal: ' .. cycleVal)
    -- LogDebug('GCalHelp:GetDayCycle() ret:%s\n', ret)
    return ret
end

--获取星期开始时间，每周一早上凌晨为重置点时间
function GCalHelp:GetWeekCycle(curTime, cycleVal, cycleStartTime)
    -- 周期间隔时间
    -- 86400: 一天的秒数
    local cycleTime = cycleVal * 7 * 86400

    -- 取它的下一个周期
    local diffCycle = math.floor((curTime - cycleStartTime) / cycleTime) + 1

    -- 返回时间
    local ret = cycleStartTime + diffCycle * cycleTime
    -- LogTable(os.date("*t", ret), "GCalHelp:GetWeekCycle() cycleVal: " .. cycleVal)
    return ret
end

--获取月开始时间，每个月1号起始零点（凌晨）
function GCalHelp:GetMonthCycle(curTime, cycleVal, cycleStartDate)
    local curDate = os.date('*t', curTime)

    -- 两个时间相差的年
    local diffYears = curDate.year - cycleStartDate.year

    -- 计算两个时间相隔几个月
    local difMonth = 0
    if diffYears > 0 then
        difMonth = (diffYears - 1) * 12 + (12 - cycleStartDate.month) + curDate.month
    else
        difMonth = curDate.month - cycleStartDate.month
    end

    -- 计算这个重置月处于第几个周期
    local diffCycle = math.floor(difMonth / cycleVal) + 1

    -- 算出这个周期共过去多少个月
    local addMonth = diffCycle * cycleVal

    -- 这个周期过去多少年
    local addYear = math.floor(addMonth / 12)

    -- 余下不满一年的月份
    addMonth = addMonth % 12

    -- LogDebug("diffCycle:%s, difMonth:%s, cycleVal:%s, addMonth:%s", diffCycle, difMonth, cycleVal, addMonth)
    -- 添加年份(不能使用curDate.year，因为 cycleStartDate.year + addYear 是可能大于curDate.year的)
    local yearNumber = cycleStartDate.year + addYear

    -- 增加余下的月份
    local monthNumber = cycleStartDate.month

    for i = 1, addMonth, 1 do
        monthNumber = monthNumber + 1
        if monthNumber > 12 then
            yearNumber = yearNumber + 1
            monthNumber = 1
        end
    end

    local ret = os.time({year = yearNumber, month = monthNumber, day = 1, hour = 0, min = 0, sec = 0})

    -- LogTable(os.date("*t", ret), "GCalHelp:GetMonthCycle() cycleVal: " .. cycleVal)
    -- LogDebug("")
    return ret
end

----------------------------------------------------------------------------------------------------------------------------------------------
-- 计算卡牌核心升级提升还需要多少个核心碎片
-- args：
-- -- cfgid: 卡牌配置id
-- -- curCl: 当前核心等级
-- -- skills: 卡牌技能列表 { [id] = {lv =xx, exp =xx, type = xxx} }
-- ret:
-- -- 返回需要多少个核心材料，生满级
function GCalHelp:GetCardNeedCoreItemCnt(cfgid, curCl, skills)
    local cCfg = CardData[cfgid]
    local coreLvCfg = CfgCardCoreLv[cCfg.quality]

    local lcnt = 0
    local sumNeed = 0

    -- LogTable(skills, "cfgid:" .. cfgid .. ", curCl:" .. curCl)
    -- 突破等级计算
    local info = coreLvCfg.infos[curCl]
    while info and info.costNum do
        sumNeed = sumNeed + info.costNum

        curCl = curCl + 1
        info = coreLvCfg.infos[curCl]

        lcnt = lcnt + 1
        if lcnt >= 100 then
            ASSERT(false)
            break
        end
    end

    -- LogDebug("GetCardNeedCoreItemCnt() cfgid:%s, curCl:%s, sumNeed:%s", cfgid, curCl, sumNeed)
    -- 天赋所需计算
    local mainTalentLv = 1
    for _, sinfo in pairs(skills) do
        if sinfo.type == SkillMainType.CardTalent then
            local skillCfg = skill[sinfo.id]
            mainTalentLv = skillCfg.lv
        end
    end

    -- LogDebug("GetCardNeedCoreItemCnt() cfgid:%s, mainTalentLv:%s", cfgid, mainTalentLv)
    local cmtuCfg = CfgMainTalentSkillUpgrade[cCfg.quality]
    info = cmtuCfg.infos[mainTalentLv]
    while info and info.costNum do
        sumNeed = sumNeed + info.costNum

        mainTalentLv = mainTalentLv + 1
        info = cmtuCfg.infos[mainTalentLv]

        lcnt = lcnt + 1
        if lcnt >= 100 then
            ASSERT(false)
            break
        end
    end

    -- LogDebug("GetCardNeedCoreItemCnt() sumNeed:%s", sumNeed)
    return sumNeed
end

function GCalHelp:GetTaskCfg(taskType, taskCfgid)
    local cfgName = cTaskCfgNames[taskType]
    local cfgs = _G[cfgName]
    if cfgs == nil then
        LogWarning("GCalHelp:GetTaskCfg() cfgName:%s, taskType:%s, taskCfgid:%s", cfgName, taskType, taskCfgid)
    end
    return cfgs[taskCfgid]
end

function GCalHelp:CheckFirstPassRewardInfo(retData)
    -- 首次通关卡牌给的延伸物品，不放在首次通关的数组里面
    local dupCfg = MainLine[retData.id]
    if not dupCfg then
        return
    end

    local inCfg = {}
    if dupCfg.fisrtPassReward then
        for _, arr in ipairs(dupCfg.fisrtPassReward) do
            local itype = arr[3]
            if not itype or itype == RandRewardType.ITEM then
                local iCfg = ItemInfo[arr[1]]
                if iCfg.type == ITEM_TYPE.CARD then
                    inCfg[iCfg.dy_value1] = 1
                else
                    inCfg[arr[1]] = 1
                end
            else
                inCfg[arr[1]] = 1
            end
        end
    end

    -- LogTable(dupCfg.fisrtPassReward, 'dupCfg.fisrtPassReward:')
    -- LogTable(inCfg, 'inCfg:')
    GCalHelp:GetTb(retData, 'reward')

    local fisrtPassReward = GCalHelp:GetTb(retData, 'fisrtPassReward')
    retData.fisrtPassReward = {}

    for _, item in pairs(fisrtPassReward) do
        if inCfg[item.id] then
            table.insert(retData.fisrtPassReward, item)
        else
            table.insert(retData.reward, item)
        end
    end

    return retData
end

-- GCalHelp:CalCardCoreElemByCfg()
-- args:
-- cfg: 卡牌配置信息，CardData[cfgid]
-- getCnt: 卡牌获取次数
-- ret:
-- { {id=1, num=1, type=1}, {id=1, num=1, type=1}}
function GCalHelp:CalCardCoreElemByCfg(cfg, getCnt, gets, from, cardPoolId)
    gets = gets or {}

    if not cfg or not cfg.coreItemId then
        -- LogError("CalCardCoreElemByCfg() not coreItemId from:%s", from)
        return gets
    end

    local elemCfg = CfgCardElem[cfg.quality]
    if not elemCfg then
        -- LogError("CalCardCoreElemByCfg() not elemCfg from:%s", from)
        return gets
    end

    -- LogTable(elemCfg, "elemCfg:")
    local useCfg = nil
    for _, info in pairs(elemCfg.infos) do
        if GLogicCheck:IsInRange(info.minGetCnt, info.maxGetCnt, getCnt) then
            useCfg = info
        end
    end

    if not useCfg then
        return gets
    end

    -- LogTable(gets, "========================================gets:")
    -- LogTable(useCfg.reward, "useCfg.reward:")
    local reward = useCfg.reward
    local elemNum = useCfg.elemNum
    
    if cardPoolId then
        local cardPoolCfg = CfgCardPool[cardPoolId]
        if cardPoolCfg and cardPoolCfg.nType == CardPoolType.SelfChoice then
            reward = useCfg.reward1
            elemNum = useCfg.elemNum1
        end
    end

    -- 先看下，核心原件满了没, {核心} { 通用 } { 额外} 写入顺序是这样的, 不能修改添加的顺序，不然前端会显示异常
    if elemNum and elemNum > 0 then
        -- LogDebug("CreateCardCoreElemByCfg() Add %s %s", cfg.coreItemId, canAddNum)
        table.insert(gets, {id = cfg.coreItemId, num = elemNum})
    end

    if reward then
        GCalHelp:IdNumArrToTb(reward, nil, nil, gets)
    end

    return gets
end

--------------------------------------------------------------------------------------------------------------------------------------
--
-- 返回一个副本的来源标志
-- return: [pre]-dupType_[副本类型]-dupGroup_[副本分组]-id_[副本id]
function GCalHelp:GetDupFrom(dupCfg, pre)
    return pre .. '-dupType_' .. dupCfg.type .. '-dupGroup_' .. dupCfg.group .. '-id_' .. dupCfg.id
end

--------------------------------------------------------------------------------------------------------------------------------------
--
-- args:
-- -- arr: 排序的数组
-- -- val: 查找的值

-- return :
-- -- bool：是否找到
-- -- index：所在的下标
-- -- val：查找到的值

function GCalHelp:Bsearch(arr, val)
    local left = 1
    local right = #arr
    local sumLen = right
    if left > right then
        return false
    end

    -- LogDebug("")
    -- LogTable(arr, "find table:")

    local rv, mid = 0, 0

    local loopCnt = 0
    while left <= right do
        mid = math.ceil((left + right) / 2)
        rv = arr[mid]
        -- LogDebug("mid:%s, l:%s, r:%s, rv:%s, val:%s", mid, left, right, rv, val)

        if rv == val then
            break
        elseif rv < val then
            left = mid + 1
        else
            right = mid - 1
        end

        -- LogDebug("mid:%s, l:%s, r:%s, rv:%s, val:%s", mid, left, right, rv, val)

        loopCnt = loopCnt + 1
        if loopCnt > sumLen then
            -- 防止死循环保护
            LogError(
                'GCalHelp:Bsearch() sum len: %s, loop: %s had error! table find: %s info is: %s',
                sumLen,
                loopCnt,
                val,
                table.tostring(arr)
            )
            break
        end
    end

    return val == rv, mid, rv
end

-- attackScore: 攻击方分数
-- defenseScore: 防御方分数
function GCalHelp:GetArmyAddScore(attackScore, defenseScore)
    local changeScore = 0
    local diffScore = defenseScore - attackScore
    for _, cfg in ipairs(CfgPracticeScore) do
        if diffScore >= cfg.nDiffMin and diffScore < cfg.nDiffMax then
            changeScore = cfg.nGetScore
            break
        end
    end

    return changeScore
end

function GCalHelp:GetDupTypeName(dupCfg)
    local dupTypeName = eDuplicateTypeName[dupCfg.type]
    --LogDebug("dupTypeName:%s", dupTypeName)
    if dupTypeName then
        dupTypeName = eDuplicateTypeChName[dupTypeName]
    end
    --LogDebug("dupTypeName:%s", dupTypeName)

    dupTypeName = (dupTypeName or ' ') .. (dupCfg.chapterID or ' ')

    return dupTypeName
end

function GCalHelp:GetCardPoolSelectId(cardPoolCfg)
    if cardPoolCfg.sel_quality_type then
        return cardPoolCfg.sel_quality_type
    end

    return cardPoolCfg.id
end


-- isCpuClock: 是否只算占用CPU的时间，线程挂起睡眠不算
function GCalHelp:Clock(isCpuClock)
    -- CUP 占用时间，线程挂起不算
    -- isCpuClock = true
    if isCpuClock then
        return math.floor(os.clock() * 1000)
    else
        return GameApp:GetTickCount()
    end
end

function GCalHelp:FindObjArrByKey(arr, key, val)
    for ix, info in ipairs(arr) do
        if info[key] == val then
            return info, ix
        end
    end

    return nil
end

function GCalHelp:FindArrByFor(arr, val)
    if not arr or type(arr) ~= 'table' then
        return nil
    end

    for _, aVal in ipairs(arr) do
        if aVal == val then
            return aVal
        end
    end

    return nil
end

function GCalHelp:GetCanModifyCfgFieldInfo(cfgName, fieldName)
    local canModifyCfg = CfgDySetOpenCfgs[cfgName]

    local canModifyFieldCfg = GCalHelp:FindObjArrByKey(canModifyCfg.fields, 'field', fieldName)
    return canModifyFieldCfg
end

-- 在加载完配置表之后, 再调用
function GCalHelp:DyModifyCfgs(modifysArr)
    local showDebug = false
    if showDebug then
        LogTable(modifysArr, 'GCalHelp:DyModifyCfgs() modifysArr:')
    end

    if not next(modifysArr) then
        return
    end

    -- 统计需要重新加载的配置表
    local oldCfgs = {}
    local loadCfgs = {}
    local allModifCfg = {}

    local idTypeInfos = {}

    -- 加载需要的表
    for _, modifyInfo in ipairs(modifysArr) do
        if showDebug then
            LogTable(modifyInfo, 'GCalHelp:DyModifyCfgs() modifyInfo:')
        end

        local cfgName = modifyInfo.name
        local cfgs = _G[cfgName]
        allModifCfg[cfgName] = cfgs

        if modifyInfo.is_del then
            if not loadCfgs[cfgName] then
                -- 保存一下内存的表格
                oldCfgs[cfgName] = cfgs

                -- 记载一次表格
                local isCallOk = xpcall(ConfigParser.ReadOneConfig, XpcallCB, ConfigParser, cfgName)
                if isCallOk then
                    loadCfgs[cfgName] = _G[cfgName]
                end

                -- 还回去
                _G[cfgName] = oldCfgs[cfgName]
            end
        end

        local k, _ = next(cfgs)
        local canModifyFieldCfg = self:GetCanModifyCfgFieldInfo(modifyInfo.name, modifyInfo.field)

        idTypeInfos[cfgName] = {
            idType = type(k),
            subIdType = canModifyFieldCfg.sub_index_type
        }
    end

    -- 设置修改
    for _, modifyInfo in ipairs(modifysArr) do
        local canModifyFieldCfg = self:GetCanModifyCfgFieldInfo(modifyInfo.name, modifyInfo.field)

        local cfgName = modifyInfo.name

        -- 设置主键的值
        local idInfo = idTypeInfos[cfgName]
        local rowId = modifyInfo.row_id
        if idInfo.idType ~= 'string' then
            rowId = tonumber(rowId)
        end

        local subId = modifyInfo.sub_id
        if idInfo.subIdType ~= 'string' then
            subId = tonumber(subId)
        end

        if modifyInfo.is_del then
            -- 删除的要还原, 原来的配置
            local oldCfg = oldCfgs[cfgName][rowId]
            local loadCfg = loadCfgs[cfgName][rowId]

            if canModifyFieldCfg.sub_tb then
                local tb = GCalHelp:CheckGetVal(loadCfg, nil, canModifyFieldCfg.sub_tb, subId)
                if tb then
                    local loadlVal = tb[canModifyFieldCfg.field]
                    oldCfg[canModifyFieldCfg.sub_tb][subId][canModifyFieldCfg.field] = loadlVal
                end
            else
                local loadlVal = loadCfg[canModifyFieldCfg.field]
                oldCfg[canModifyFieldCfg.field] = loadlVal
            end
        else
            local cfgs = _G[cfgName]
            local cfg = cfgs[rowId]

            local val = modifyInfo.val
            if canModifyFieldCfg.field_type == 'number' then
                val = tonumber(val)
            elseif canModifyFieldCfg.field_type == 'bool' then
                if val == 'true' then
                    val = true
                elseif val == 'false' then
                    val = false
                else
                    local tmpVal = tonumber(val)
                    -- LogDebug('val:%s, tmpVal:%s', val, tmpVal)
                    if tmpVal and tmpVal > 0 then
                        val = true
                    else
                        val = false
                    end
                end
            elseif canModifyFieldCfg.field_type == 'json' then
                val = Json.Decode(val)
            end

            if canModifyFieldCfg.sub_tb then
                local tb = GCalHelp:CheckGetVal(cfg, nil, canModifyFieldCfg.sub_tb, subId)
                if tb then
                    tb[canModifyFieldCfg.field] = val
                end
            else
                cfg[canModifyFieldCfg.field] = val
            end
        end
    end

    for cfgName, _ in pairs(allModifCfg) do
        if ConfigChecker[cfgName] then
            local result, errmsg = pcall(ConfigChecker[cfgName], ConfigChecker, _G[cfgName])
            if errmsg then
                if LogError then
                    LogError("GCalHelp:DyModifyCfgs() ConfigChecker[%s], result:%s, errmsg:%s", cfgName, result, errmsg)
                else
                    print(result, errmsg)
                end
                ASSERT(false, '配置表出错' .. cfgName)
            end
        end
    end

    -- 调试打印
    if showDebug then
        local hadShowLog = {}
        for _, modifyInfo in ipairs(modifysArr) do
            local cfgName = modifyInfo.name
            local cfgs = _G[cfgName]

            local idInfo = idTypeInfos[cfgName]
            local rowId = modifyInfo.row_id

            local tmpId = cfgName .. rowId
            if not hadShowLog[tmpId] then
                hadShowLog[tmpId] = 1
                if idInfo.idType ~= 'string' then
                    rowId = tonumber(rowId)
                end

                local cfg = cfgs[rowId]
                LogTable(cfg, 'GCalHelp:DyModifyCfgs(), ' .. cfgName .. ' after chagne:')
            end
        end
    end
end

-- sk : save key
function GCalHelp:MapToArr(o, sk)
    local arr = {}
    for k, v in pairs(o) do
        if sk then
            table.insert(arr, {k, v})
        else
            table.insert(arr, v)
        end
    end
    return arr
end

function GCalHelp:ArrToMap(arr, keyIndex)
    local map = {}
    for _, v in ipairs(arr) do
        map[v[keyIndex]] = v
    end

    return map
end

function GCalHelp:CopyTbData(src, cpy)
    if type(src) ~= 'table' then
        return nil
    end

    cpy = cpy or {}

    for i, v in pairs(src) do
        local vtyp = type(v)
        if (vtyp == 'table') then
            if rawget(v, '__class') then
                -- 类不拷贝类
            else
                cpy[i] = self:CopyTbData(v)
            end
        elseif (vtyp == 'function') then
            -- 函数不拷贝
        else
            cpy[i] = v
        end
    end

    return cpy
end

-- CheckItemExpirys() 会计算当前物品的剩余数量，会删除 itemGets 中已经过期的数据
-- args:
---- hadNum：当前拥有总量
---- itemGets: 分批次获取的物品信息
---- curTime: 当前时间[秒]
-- ret:
---- leftNum: 返回剩余的数量
function GCalHelp:CheckSubItemExpirys(hadNum, itemGets, curTime, exiprySubs, isDelExpiry)
    local leftNum = hadNum
    local sumRemove = 0

    -- 数组末尾的先过期
    for ix = #itemGets, 1, -1 do
        -- statements
        local info = itemGets[ix]
        local num, expiry, cfgId = info[1], info[2], info[3]
        if curTime >= expiry then
            -- LogDebug('GCalHelp:CheckSubItemExpirys() leftNum:%s, remove ix:%s, num:%s, expiry:%s', leftNum, ix, num, expiry)
            if isDelExpiry then
                -- 删除过期的部分
                table.remove(itemGets, ix)
            end

            leftNum = leftNum - num
            sumRemove = sumRemove + num
            if exiprySubs then
                table.insert(exiprySubs, {id = cfgId, num = num})
            end
        else
            break
        end
    end

    return leftNum, sumRemove
end

--警告 主角真实数据不能用这个方法，因为主角解限，机神数据不是读表的，而是通过服务器发
-- 获取卡牌id（机神、同调、形切的卡牌id） 如果没有，说明不是此类卡牌
function GCalHelp:GetElseCfgID(baseCfgID)
    local cfg = CardData[baseCfgID]
    if (not cfg) then
        return nil
    end
    if (cfg.fit_result) then
        return cfg.fit_result
    elseif (cfg.tTransfo) then
        return cfg.tTransfo[1]
    elseif (cfg.summon) then
        local cardCfg = MonsterData[cfg.summon]
        return cardCfg.card_id
    end
    return nil
end

-- 获取生效中的乱序演习词条
function GCalHelp:GetRogueEffectingBuff(arrSelectBuffs, nRound)
    local effectingBuffs = {}
    local buffArr = {}
    local mapSelectBuffs = {}
    for roundIdx, rogueBuff in pairs(arrSelectBuffs) do
        mapSelectBuffs[rogueBuff] = true
    end

    for roundIdx, rogueBuff in pairs(arrSelectBuffs) do
        local cfg = CfgRogueBuff[rogueBuff]
        if cfg.preConditions == 1 then
            -- 前置条件参数
            if mapSelectBuffs[cfg.preConditionsValue] then
                buffArr[rogueBuff] = roundIdx
            end
        else
            buffArr[rogueBuff] = roundIdx
        end
    end

    for rogueBuffID, idx in pairs(buffArr) do
        local cfg = CfgRogueBuff[rogueBuffID]
        -- 判断战斗外生效次数，根据选取时的回合数判断是否还生效
        if cfg.lifeType == 2 then
            if idx + cfg.lifeValue > nRound then
                table.insert(effectingBuffs, rogueBuffID)
            end
        else
            table.insert(effectingBuffs, rogueBuffID)
        end
    end

    return effectingBuffs
end

-- 肉鸽词条转换成技能跟buff，传入战斗
function GCalHelp:GetRogueExdata(buffs, exData, cardData)
    exData.tExBuff = {}         -- 我方buff 数组
    exData.tMonsterBuff = {}    -- 怪物buff 数组​
    exData.tAllBuff = {}        -- 双方buff 数组​
    exData.tRandBuff = {}       -- 随机buff 格式给我方三个人加buff, 敌方1个人加buff
    if buffs and next(buffs) then        
        for _, rouguBuff in ipairs(buffs) do
            local cfg = CfgRogueBuff[rouguBuff]
            if cfg.target == RogueBuffTarget.TeamAll then
                -- 我方全体
                table.merge(exData.tExBuff, cfg.buffId)
                if cfg.skillId and next(cfg.skillId) then
                    for k, v in pairs(cardData) do
                        table.merge(v.data.skills, cfg.skillId)
                    end
                end
            elseif cfg.target == RogueBuffTarget.MonsterAll then
                -- 敌方全体
                table.merge(exData.tMonsterBuff, cfg.buffId)
            elseif cfg.target == RogueBuffTarget.BothAll then
                -- 敌我全体
                table.merge(exData.tAllBuff, cfg.buffId)
                if cfg.skillId and next(cfg.skillId) then
                    for k, v in pairs(cardData) do
                        table.merge(v.data.skills, cfg.skillId)
                    end
                end
            elseif cfg.target == RogueBuffTarget.TeamRandom then
                -- 我方随机
                table.insert(exData.tRandBuff, {
                    teamID = 1,
                    count = cfg.targetValue,
                    buff = table.copy(cfg.buffId)
                })
    
                local roleNum = #cardData
                if roleNum <= cfg.targetValue then
                    -- 上阵角色数少于随机数，全部角色加技能
                    if cfg.skillId and next(cfg.skillId) then
                        for idx, v in pairs(cardData) do
                            table.merge(v.data.skills, cfg.skillId)
                        end
                    end
                else
                    -- 从上阵角色里面随机N个角色出来加上词条技能
                    local arr = {}
                    for i = 1, roleNum do
                        table.insert(arr, i)
                    end
    
                    local effectRoles = {}
                    for i = 1, cfg.targetValue do
                        local r = math.random(1, #arr)
                        effectRoles[arr[r]] = true
                        table.remove(arr, r)
                    end
    
                    if cfg.skillId and next(cfg.skillId) then
                        for idx, v in pairs(cardData) do
                            if effectRoles[idx] then
                                table.merge(v.data.skills, cfg.skillId)
                            end
                        end
                    end
                end
    
    
            elseif cfg.target == RogueBuffTarget.MonsterRandom then
                -- 敌方随机
                table.insert(exData.tRandBuff, {
                    teamID = 2,
                    count = cfg.targetValue,
                    buff = table.copy(cfg.buffId)
                })
            end
        end
    end
end

--通过技能id获取怪物的基础模型
function GCalHelp:GetBaseModelBySkillID(skillID)
    local cfg = skill[skillID]
    local arg = SkillEffect[cfg.DoSkill[1]].arg

    local strs = SplipLine(arg, ',')
    local monsterID = tonumber(strs[1])
    if monsterID then
        local monsterCfg = MonsterData[monsterID]
        if not monsterCfg.card_id then
            LogError("GCalHelp:GetBaseModelBySkillID() skillID:%s monsterID:%s not set card_id in cfg MonsterData", skillID, monsterID)
        end

        local cardCfg = CardData[monsterCfg.card_id]
        if not cardCfg then
            LogError(
                "GCalHelp:GetBaseModelBySkillID() skillID:%s monsterID:%s card_id:%s not find data from cfg CardData"
                , skillID
                , monsterID
                , monsterCfg.card_id)
        end

        return CardData[monsterCfg.card_id].model, monsterID
    else
        LogError("GCalHelp:GetBaseModelBySkillID() skillID:%s not find data from MonsterData", skillID)
    end

    return nil, monsterID
end

-- 接受一个数x和两个区间端点min和max作为参数
-- 然后返回x在[min, max]区间内的值。
-- 如果x小于min，则返回min；如果x大于max，则返回max；否则，直接返回x。
function GCalHelp:MathClamp(x, min, max)
    x = math.max(x, min)
    x = math.min(x, max)
    return x
end

--计算当前宠物基本属性值，如果在运动中的话也计算运动中的变化
---comment
---@param pet table 宠物
function GCalHelp:CalPetAbility(pet, curTime)
    local cfg = CfgPet[pet.id]
    local happy_sub = cfg.happyDown
    local food_sub = cfg.foodDown
    local wash_sub = cfg.washDown
    local interval = cfg.interval
    curTime = curTime or CURRENT_TIME
    -- 计算宠物基本属性扣除，随时间扣除

    local cnt = math.floor((curTime - pet.last_time) / interval)

    local states = self:GetPetStates(pet)
    for k, state in pairs(states) do
        local stateCfg = CfgPetState[state]
        local effect = stateCfg.effect
        if stateCfg and stateCfg.stateType == 3 then
            -- 宠物处于某种状态下，会受到影响
            -- 3：心情值降低速度加快，每个时间间隔多扣effect[1]
            happy_sub = happy_sub + (effect[1] or 0)
        end
    end

    local food_diff = food_sub * cnt
    local wash_diff = wash_sub * cnt
    local happy_diff = happy_sub * cnt

    -- 计算最新值，并且更新时间
    pet.happy = math.max(pet.happy - happy_diff, 0)
    pet.food = math.max(pet.food - food_diff, 0)
    pet.wash = math.max(pet.wash - wash_diff, 0)
    pet.last_time = pet.last_time + (cnt * interval)

    -- 如果宠物在运动中，算上运动的属性变动
    if pet.sport == 0 or pet.scene == 0 then
        return pet
    end

    local sportCfg = CfgPetSport[pet.scene]
    if not sportCfg then
        return pet
    end

    local subcfg = sportCfg.infos[pet.sport]
    local happychange = subcfg.happyChange
    local foodchange = subcfg.foodChange
    local washchange = subcfg.washChange
    local sport_interval = sportCfg.interval

    local end_time = pet.start_time + pet.keep_time

    -- 计算变动次数,算出属性最新值跟最新时间
    local periodCnt , reduceTime = GCalHelp:GetPeriodCnt(pet.start_time, sport_interval, math.min(end_time, curTime))
    if periodCnt > 0 then
        for i = 1, periodCnt do
            pet.happy = GCalHelp:MathClamp(pet.happy + (happychange), 0, cfg.happyMax)
            pet.food = GCalHelp:MathClamp(pet.food + ( foodchange), 0, cfg.foodMax)
            pet.wash = GCalHelp:MathClamp(pet.wash + ( washchange), 0, cfg.washMax)
            local timediff = sport_interval
            pet.start_time = pet.start_time + timediff
            pet.keep_time = math.max(pet.keep_time - timediff, 0)
            local feedCfg = CfgPetFeedReward[cfg.feedReward].infos
            pet.feed = math.min(feedCfg[#feedCfg].feedNum, pet.feed + subcfg.feedChange)

            -- 属性值不足，中断运动
            if pet.wash == 0 or pet.food == 0 then
                pet.sport = 0
                pet.scene = 0
                pet.keep_time = 0
                pet.start_time = 0
                return pet, true
            end
        end
    end

    if end_time < curTime then
        -- 运动结束了
        pet.sport = 0
        pet.scene = 0
        pet.keep_time = 0
        pet.start_time = 0
    end
    return pet
end

--计算出当前宠物处于哪些状态
---comment
---@param pet table 宠物
---@return table 宠物所处状态的数组
function GCalHelp:GetPetStates(pet)
    local state = {}
    local petCfg = CfgPet[pet.id]
    if not petCfg then
        return state
    end
    if CfgPetState and next(CfgPetState) then
        for id, cfg in ipairs(CfgPetState) do
            local passNum = 0
            for _, ty in ipairs(cfg.attribute) do
                local abi = pet[ePetAbilityType[ty]]
                local max = petCfg[ePetAbilityType[ty].."Max"]
                abi = math.floor(abi / max * 100)
                if cfg.judge == 1 then
                    -- 大于
                    if abi > cfg.value then
                        passNum = passNum + 1
                    end
                elseif cfg.judge == 2 then
                    -- 大于等于
                    if abi >= cfg.value then
                        passNum = passNum + 1
                    end
                elseif cfg.judge == 3 then
                    -- 等于
                    if abi == cfg.value then
                        passNum = passNum + 1
                    end
                elseif cfg.judge == 4 then
                    -- 小于等于
                    if abi <= cfg.value then
                        passNum = passNum + 1
                    end
                elseif cfg.judge == 5 then
                    -- 小于
                    if abi < cfg.value then
                        passNum = passNum + 1
                    end
                end
            end
            if passNum == #cfg.attribute then
                table.insert(state, id)
            end
        end
    end

    return state
end

------------------------------------------------------------------------------------------
-- args:
-- -- cfgSection： Section 表的配置信息
-- -- returnAdd ：回归增加

-- ret:
-- -- 返回增加的倍数[掉落倍数]
-- -- 返回多倍最大次数，
-- -- 目前是否无限多倍次数
-- -- 是否启用了限时多倍掉落
function GCalHelp:GetMultiDropMaxCnt(cfgSection, returnAdd)
    returnAdd = returnAdd or 0

    local sumMulti = 0
    local sumMaxCnt = 0

    local notDelCnt = false
    local isAddReturnAdd = false

    -- LogTable(cfgSection, "GCalHelp:GetMultiDropMaxCnt() cfgSection:")
    
    if cfgSection.multiId then
        local dropMultiCfg = CfgDupDropMulti[cfgSection.multiId]
        if dropMultiCfg and dropMultiCfg.dropAdd then
            local dropMulti, dropCnt = dropMultiCfg.dropAdd[1], dropMultiCfg.dropAdd[2]
            sumMulti = sumMulti + dropMulti
            if dropCnt > 0 then
                sumMaxCnt = sumMaxCnt + dropCnt
                isAddReturnAdd = true
            else
                notDelCnt = true
            end
        end        
    end

    local isUseSpecialMulti = false
    if cfgSection.specialMultiIds and g_SpecialMultiId then
        -- Tips: 这里是因为 cfgSection.specialMultiIds 只会填一两个值，所以直接用遍历
        if self:FindArrByFor(cfgSection.specialMultiIds, g_SpecialMultiId) then
            local specialDropMultiCfg = CfgDupDropMulti[g_SpecialMultiId]
            if specialDropMultiCfg and specialDropMultiCfg.dropAdd then
                local specialDropMulti, specialDropCnt = specialDropMultiCfg.dropAdd[1], specialDropMultiCfg.dropAdd[2]

                isUseSpecialMulti = true
                sumMulti = sumMulti + specialDropMulti
                if specialDropCnt > 0 then
                    sumMaxCnt = sumMaxCnt + specialDropCnt
                    isAddReturnAdd = true
                else
                    notDelCnt = true
                end
            end
        end
    end

    if isAddReturnAdd then
        sumMaxCnt = sumMaxCnt + returnAdd + g_AddDupMultiCnt
    end

    -- LogTrace("GCalHelp:GetMultiDropMaxCnt()")
    LogDebug("g_SpecialMultiId:%s, sumMulti:%s, sumMaxCnt:%s, notDelCnt:%s, isUseSpecialMulti:%s, returnAdd:%s", g_SpecialMultiId, sumMulti, sumMaxCnt, notDelCnt, isUseSpecialMulti, returnAdd)
    return sumMulti, sumMaxCnt, notDelCnt, isUseSpecialMulti
end

-- 检查两个时间戳是否处于同个月份
--- func desc
---@param time number 传入的时间A
---@param curTime number 时间B，不传默认当前时间
---@return boolean true 同个月份， false 不同月份
function GCalHelp:CheckSameMonth(time, curTime)
    if not time or time == 0 then
        return false
    end
    curTime = CURRENT_TIME or curTime
    local zero1 = self:GetActiveResetTime(PeriodType.Month, 1, time)
    local zero2 = self:GetActiveResetTime(PeriodType.Month, 1, curTime)
    if zero1 ~= zero2 then
        return false
    end
    return true
end

function GCalHelp:GetActiveResetTime(setType, diff, curTime)
    curTime = curTime or CURRENT_TIME
    local dayDiffs = g_ActivityDiffDayTime * 3600

    return GCalHelp:GetCycleResetTime(setType, diff, curTime - dayDiffs) + dayDiffs
end


function GCalHelp:GetTimestampByTime(hour, minute, second)
    -- 获取当前日期
    local current_date = os.date("*t")

    -- 构造特定时间
    current_date.hour = hour
    current_date.min = minute
    current_date.sec = second

    -- 转换为时间戳
    local timestamp = os.time(current_date)

    return timestamp
end

function GCalHelp:CalMailFrom(baseFrom, acc, logId)
    if not acc and not logId then
        return baseFrom
    end
    
    return string.format("%s_acc[%s]_logId[%s]", baseFrom, acc, logId)
end

-- 能力测验特殊处理
-- 2025年2月不刷新，所以跳过
function GCalHelp:GetRogueTNextMonth(curTime)
    curTime = curTime or CURRENT_TIME
    local nextMonthTime = self:GetActiveResetTime(PeriodType.Month, 1, curTime)
    local date = os.date("*t", nextMonthTime)
    if date.year == 2025 and date.month == 2 then
        date.month = date.month + 1
    end
    return os.time{year = date.year, month = date.month, day = date.day, hour = date.hour, min = 0, sec = 0}
end

-- 获取爱相随商店套装价格
-- suitPrice:套装原折扣价
-- totalPrice:单项售价总价
-- subPrice:已拥有的单项售价和
function GCalHelp:GetLovePlusShopSuitPrice(suitPrice,totalPrice,subPrice)
    local rtPrice = suitPrice - subPrice * suitPrice / totalPrice
    LogInfo(string.format("<<<<<GCalHelp:GetLovePlusShopSuitPrice>>>>>%s - %s * %s / %s = %s",suitPrice,subPrice,suitPrice,totalPrice,rtPrice))
    return rtPrice
end


function GCalHelp:GetExchangeCodePlats(plat, plats)
    local canUsePlats = nil
    if not plats or table.empty(plats) then
        canUsePlats = { [plat] = 1 }
        if plat == ChannelType.Normal then
            canUsePlats[ChannelType.TapTap] = 1
        end
    else
        canUsePlats = plats
    end

    return canUsePlats
end

-- 拼图活动获取已解锁的奖励id集合
-- id:活动id
-- mapGrids:已解锁格子数据
function GCalHelp:GetActivePuzzleUnlockRwd(id,mapGrids)
    ASSERT(id and mapGrids)
    local baseCfg = CfgPuzzleBase[id]
    if not baseCfg or not mapGrids then
        return
    end
    local rwdCfg = CfgPuzzleReward[baseCfg.rewardId]
    if not rwdCfg then
        return
    end
    local mapIds = {}
    for _,cfg in ipairs(rwdCfg.infos) do
        local canGet = true
        if cfg.grids and not table.empty(cfg.grids) then
            for _,idx in ipairs(cfg.grids) do
                if not mapGrids[idx] then
                    canGet = false
                    break
                end
            end
        else
            local gridCfg = CfgPuzzleGrid[baseCfg.gridCfgId]
            if not gridCfg then
                canGet = false
            else
                for gId,_ in ipairs(gridCfg.infos) do
                    if not mapGrids[gId] then
                        canGet = false
                        break
                    end
                end
            end
        end
        
        if canGet then
            mapIds[cfg.rewardId] = true
        end
    end
    return mapIds
end

-- 检测积分战斗选中词条是否正确
function GCalHelp:CheckBuffBattle(buffs, duplicateId)

    if not duplicateId then
        return false
    end

    --全部词条
    local buffsMap = {}
    --全部前置词条
    local preidMap = {}
    --全部冲突词条
    local conflictidMap = {}
    --全部分组
    local groupMap = {}


    -- 检测词条与关卡冲突

    local dupCfg = MainLine[duplicateId]
    local dungeonGroup = dupCfg.dungeonGroup
    local dungeonGroupCfg = DungeonGroup[dungeonGroup]

    --可以选中的词条组
    local canSelectBuffIdMap = {}

    -- 是否需要检测章节可以选中的词条组
    local checkBuffGroup = true
    if not dungeonGroupCfg.buffgroup or table.empty(dungeonGroupCfg.buffgroup) then
        checkBuffGroup = false
    else
        for _, canSelectGroup in pairs(dungeonGroupCfg.buffgroup) do
            canSelectBuffIdMap[canSelectGroup] = true
        end
    end

    if buffs then
        for _, buffBattleBuffId in ipairs(buffs) do
            buffsMap[buffBattleBuffId] = true
            local cfg = CfgBuffBattle[buffBattleBuffId]

            if cfg then
                if cfg.preid then
                    table.insert(preidMap, cfg.preid)
                end

                if cfg.conflictid then
                    for _, buffConflictid in ipairs(cfg.conflictid) do
                        table.insert(conflictidMap, buffConflictid)
                    end
                end

                if cfg.group then
                    groupMap[cfg.group] = true

                    if checkBuffGroup and not canSelectBuffIdMap[cfg.group] then
                        return false, string.format("选中词条%s 属于不可选关卡组：%s 未选中", buffBattleBuffId, cfg.group)
                    end
                end
            end
        end
    end

    -- 检测词条冲突
    for _, preid in ipairs(preidMap) do
        if not buffsMap[preid] then
            return false, string.format("前置词条id：%s 未选中", preid)
        end
    end

    for _, conflictid in ipairs(conflictidMap) do
        if buffsMap[conflictid] then
            return false, string.format("冲突词条id：%s 被选中", conflictid)
        end
    end

    return true

end

-- 积分战斗转换成技能跟buff，传入战斗
function GCalHelp:GetBuffBattleExdata(buffs, exData, cardData)
    exData.tExBuff = {}         -- 我方buff 数组
    exData.tMonsterBuff = {}    -- 怪物buff 数组​
    exData.tAllBuff = {}        -- 双方buff 数组​
    exData.tRandBuff = {}       -- 随机buff 格式给我方三个人加buff, 敌方1个人加buff
    if buffs and next(buffs) then
        for _, rouguBuff in ipairs(buffs) do
            local cfg = CfgBuffBattle[rouguBuff]
            if cfg.target == RogueBuffTarget.TeamAll then
                -- 我方全体
                table.merge(exData.tExBuff, cfg.buffId)
                if cfg.skillId and next(cfg.skillId) then
                    for k, v in pairs(cardData) do
                        table.merge(v.data.skills, cfg.skillId)
                    end
                end
            elseif cfg.target == RogueBuffTarget.MonsterAll then
                -- 敌方全体
                table.merge(exData.tMonsterBuff, cfg.buffId)
            elseif cfg.target == RogueBuffTarget.BothAll then
                -- 敌我全体
                table.merge(exData.tAllBuff, cfg.buffId)
                if cfg.skillId and next(cfg.skillId) then
                    for k, v in pairs(cardData) do
                        table.merge(v.data.skills, cfg.skillId)
                    end
                end
            elseif cfg.target == RogueBuffTarget.TeamRandom then
                -- 我方随机
                table.insert(exData.tRandBuff, {
                    teamID = 1,
                    count = cfg.targetValue,
                    buff = table.copy(cfg.buffId)
                })

                local roleNum = #cardData
                if roleNum <= cfg.targetValue then
                    -- 上阵角色数少于随机数，全部角色加技能
                    if cfg.skillId and next(cfg.skillId) then
                        for idx, v in pairs(cardData) do
                            table.merge(v.data.skills, cfg.skillId)
                        end
                    end
                else
                    -- 从上阵角色里面随机N个角色出来加上词条技能
                    local arr = {}
                    for i = 1, roleNum do
                        table.insert(arr, i)
                    end

                    local effectRoles = {}
                    for i = 1, cfg.targetValue do
                        local r = math.random(1, #arr)
                        effectRoles[arr[r]] = true
                        table.remove(arr, r)
                    end

                    if cfg.skillId and next(cfg.skillId) then
                        for idx, v in pairs(cardData) do
                            if effectRoles[idx] then
                                table.merge(v.data.skills, cfg.skillId)
                            end
                        end
                    end
                end


            elseif cfg.target == RogueBuffTarget.MonsterRandom then
                -- 敌方随机
                table.insert(exData.tRandBuff, {
                    teamID = 2,
                    count = cfg.targetValue,
                    buff = table.copy(cfg.buffId)
                })
            end
        end
    end
end

-- 获取选中词条的积分，不传入duplicateId只计算buff分，不计算关卡基础分
function GCalHelp:GetCheckBuffBattlePoint(buffs, duplicateId)
    local points = 0

    if duplicateId then
        local dupCfg = MainLine[duplicateId]
        local dungeonGroup = dupCfg.dungeonGroup
        local dungeonGroupCfg = DungeonGroup[dungeonGroup]

        points = dungeonGroupCfg and dungeonGroupCfg.points or 0
    end

    buffs = buffs or {  }

    for _, buffId in ipairs(buffs) do
        local buffBattle = CfgBuffBattle[buffId]
        if buffBattle then
            points = points + (buffBattle.points or 0)
        end
    end

    return points
end


-- 装备洗练随机词条
-- equipData = {cfgId = 装备id,skills = 词条id数组},lockSkills = {skillId1,skillId2...}
-- cntData = {[libId1] = cnt1,[libId2] = cnt2}
function GCalHelp:DoEquipRefresh(equipData,lockSkills,cntData,isLockSlot,gmLibId)
    if not equipData then
        return
    end
    local eCfg = CfgEquip[equipData.cfgId]
    if not eCfg or eCfg.nType == EquipType.Material then
        return
    end
    local libId = gmLibId or eCfg.refreshLibId or 0
    local randCfg = CfgEquipRefreshLib[libId]
    local randPool = randCfg and randCfg.infos
    if not randPool then
        LogError("EquipMgr:EquipRefresh,get randPool error ：%s,%s,%s",eCfg.suitId,eCfg.nQuality,libId)
        return
    end
    local refreshNum = cntData and cntData[libId] or 0
    local minShowRare = randCfg.showRareCnt or 0
    local oldSkills = equipData.skills
    local equipBySuitCfg = g_EquipBySuit[eCfg.suitId] --GobalCfg:GetCfgVal('CfgEquipBySuit', eCfg.suitId)
    local equipPool = equipBySuitCfg and equipBySuitCfg[eCfg.nQuality]
    if not equipPool then
        LogError("EquipMgr:EquipRefresh,get equipPool error ：%s,%,%s",eCfg.suitId,eCfg.nQuality,libId)
        return
    end
    local newEquipId = eCfg.id
    -- local baseVal = eCfg.nBase1
    -- 随机部位
    if not isLockSlot then
        local poolSize = #equipPool
        if poolSize > 0 then
            local r = math.random(poolSize)
            local tmpCfg = equipPool[r]
            newEquipId = tmpCfg and tmpCfg.id or 0
            -- baseVal = tmpCfg.nBase1
        end
    end
    -- 随机词条
    local mapRare = randCfg.mapRare or {}
    local newSkills = {oldSkills[1]}
    local rareNum = 0
    local function getOrignSkillId(skillId)
        local oldSkillCfg = CfgEquipSkill[skillId] 
        local oldSkillLv = oldSkillCfg.nLv
        local ogSkillId = skillId - oldSkillLv + 1
        return ogSkillId
    end
    local mpGetSkills = {}
    local mpLock = {}
    for _,sId in ipairs(lockSkills or {}) do
        mpLock[sId] = true
        local ogId = getOrignSkillId(sId)
        mpGetSkills[ogId] = true
        if mapRare[ogId] then
            rareNum = rareNum + 1
        end
    end
    local function checkCanGetRare(skillId)
        if not mapRare[skillId] then
            return true
        end
        if rareNum + 1 >= randCfg.rareCnt and refreshNum < minShowRare then
            return false
        end
       return true
    end
    for i=2,#oldSkills do
        local oldSkillId = oldSkills[i]
        if oldSkillId then
            if mpLock[oldSkillId] then
                newSkills[i] = oldSkillId
                local ogSkillId = getOrignSkillId(oldSkillId)
                mpGetSkills[ogSkillId] = true

            else
                local useCfg, ix = GCalHelp:GetByWeight(randPool, 'sumWeight')
                local orignSkillId = useCfg and useCfg.skillId
                if mpGetSkills[orignSkillId] or not checkCanGetRare(orignSkillId) then
                    local randArr = {}
                    for _, info in ipairs(randPool) do
                        if not mpGetSkills[info.skillId] and info.skillId ~= orignSkillId then 
                            table.insert(randArr, info)
                        end
                    end
                    -- LogTable(randArr,">>>>>>>randPool")
                    local tUseCfg, _ = GCalHelp:GetByCalWeight(randArr, 'weight')
                    if tUseCfg then
                        orignSkillId = tUseCfg.skillId
                    end
                end
                if orignSkillId then
                    local oldSkillCfg = CfgEquipSkill[oldSkillId] 
                    local oldSkillLv = oldSkillCfg.nLv
                    local useSkillId = orignSkillId + oldSkillLv - 1
                    mpGetSkills[orignSkillId] = true
                    newSkills[i] = useSkillId
                end
            end
        end
    end
    return newEquipId,newSkills
end


-- 根据模型ID获取该角色ID
function GCalHelp:GetCidByModel(model)
    if not model then
        return nil
    end
    local cfg = character[model]

    if cfg and cfg.role_id then
        return cfg.role_id
    end
    return nil
end


-- 根据经验获取小地图探索危险等级
function GCalHelp:GetRogueMapDangerLevel(exp)
    local level = 1

    if not exp then
        return level
    end
    for k, v in ipairs(CfgRogueMapLevel) do
        if v.num and exp < v.num then
            break
        end
        level = k + 1
    end
    return math.min(level, #CfgRogueMapLevel)
end


-- 获取其他战斗周目怪物总血量
function GCalHelp:GetLeftStageHp(stage,mstGroup,isCalPoint)
    if not stage then
        return 0
    end
    local lHp = 0
    local mgCfg = MonsterGroup[mstGroup]
    local cfgs = mgCfg and mgCfg.stage or {}
    local totalHp = 0
    local mSize = #cfgs
    local nxStage = stage + 1
    if nxStage <= mSize then
        for i = nxStage,mSize,1 do
            local stg = cfgs[i]
            for j, mstId in ipairs(stg.monsters or {}) do
                local mcfg = MonsterData[mstId]
                if not isCalPoint or (mcfg and mcfg.isPoints) then
                    local mstMaxHp = mcfg and mcfg.maxhp or 0
                    lHp = lHp + mstMaxHp
                end
            end
        end
    end
    return lHp
end

-- 深塔计划获取其他战斗周目怪物总血量
function GCalHelp:TowerDeepGetLeftStageHp(stage,mstGroup,isCalPoint)
    if not stage then
        return 0
    end
    local lHp = 0
    local mgCfg = MonsterGroup[mstGroup]
    local cfgs = mgCfg and mgCfg.stage or {}
    local totalHp = 0
    local mSize = #cfgs
    local nxStage = stage + 1
    if nxStage <= mSize then
        for i = nxStage,mSize,1 do
            local stg = cfgs[i]
            for j, mstId in ipairs(stg.monsters or {}) do
                local mcfg = MonsterData[mstId]
                if not isCalPoint or (mcfg and mcfg.isPoints) then
                    local mstMaxHp = mcfg and mcfg.maxhp or 0
                    if mcfg.tTransfo and #mcfg.tTransfo > 0 then
                        mstMaxHp = mstMaxHp * 2
                    end
                    lHp = lHp + mstMaxHp
                end
            end
        end
    end
    return lHp
end

-- 多队玩法获取战斗分数
--[[                 
winner:1赢 2输
maxDupScore：关卡最大分数
curScore：当前关卡已获得分数
totalDamage：已造成总伤害
totalMaxHp：怪物总Hp
hpinfo：怪物血量数据
]]
function GCalHelp:MultTeamGetFightRetData(winner,maxDupScore,curScore,oldTotalHp,totalMaxHp,hpinfo,mstGroup)
    LogDebugEx("GCalHelp:MultTeamGetFightRetData,winner,maxDupScore,curScore,oldTotalHp,hpinfo,totalMaxHp",winner,maxDupScore,curScore,oldTotalHp,hpinfo,totalMaxHp,mstGroup)
    local score = 0
    local totalHp = 0
    local leftScore = math.max(maxDupScore - curScore,0)
    if winner == 1 then
        score = leftScore
    else
        if hpinfo then
            local leftHp = 0
            for _,val in ipairs(hpinfo.data or {}) do
               leftHp = leftHp + math.max(0, val or 0)
            end 
            totalHp = leftHp + self:GetLeftStageHp(hpinfo.stage,mstGroup)
        end
        totalHp = math.max(0, totalHp)
        local subVal = math.max(0,oldTotalHp - totalHp)
        if totalMaxHp and totalMaxHp > 0 then
            score = math.floor((subVal/totalMaxHp)*maxDupScore)
        end
    end
    LogDebugEx("GCalHelp:MultTeamGetFightRetData,score,totalHp",score,totalHp)
    score = math.min(leftScore,score)
    return score,math.max(0,totalHp)
end

--4.0 扭蛋机优化 判断是否只剩无限跟关键奖励，如果池子里只剩这两个类型的奖励的话，不给他抽
---@param drawArr 已抽取的数组
---@return boolean true 已售罄，不可抽取， false 可抽取
function GCalHelp:ItemPoolControlSoldOut(rewardCfg, drawArr)
    if not rewardCfg or not next(rewardCfg) or not drawArr then
        return
    end
    local arr = {}
    for k, v in pairs(rewardCfg.pool) do
        local num = v.rewardnum
        if drawArr[v.index] then
            -- 扣除已抽取的数量
            num = num - drawArr[v.index]
        end
        if num > 0 then
            table.insert(arr, v)
        end
    end

    if not next(arr) then
        -- 池子空的，已售罄
        return true
    end

    for _, v in ipairs(arr) do
        if not v.iskeyreward and not v.isInfinite then
            -- 池子不止关键奖励跟无限奖励，未售罄
            return false
        end
    end

    -- 池子只剩关键奖励跟无限奖励，已售罄
    return true
end

-----------------------------------------------------------------------------------------------------------
-- 计算自由军演，段位
function GCalHelp:CalFreeMatchRankLv(score)
    for _, cfg in ipairs(CfgPvpRankLevel) do
        -- LogDebug("score:%s <= cfg.nScore:%s", score, cfg.nScore)
        if score < cfg.nScore then
            return cfg.id
        end
    end

    return CfgPvpRankLevel[#CfgPvpRankLevel].id
end


-----------------------------------------------------------------------------------------------------------
-- 计算自由军演，继承分数
-- args:
---- preScore: 上次分数
---- preRankLv: 上一次段位（没有传nil, 函数自己算）
---- preCfgid: 上次赛季配置id
---- curCfgId: 当前赛季配置id
-- ret:
---- score: 继承的分数
---- rankLv: 继承的段位
function GCalHelp:CalFreeMatchInheritScore(preScore, preRankLv)
    if not preRankLv then
        preRankLv = self:CalFreeMatchRankLv(preScore)
    end

    -- 修改分数
    local curRankLv = preRankLv - 2
    if curRankLv < 2 then
        return 0, 1
    end

    local curRlCfg = CfgPvpRankLevel[curRankLv-1]
    return curRlCfg.nScore, curRankLv
end


-----------------------------------------------------------------------------------------------------------
-- v 4.3 返回自由匹配，增减的分数
function GCalHelp:FreeMatchArmyChangeSocreCfg(diffScore)
    local scoreCfg = nil
    for _, cfg in ipairs(CfgPvpScore) do
        if diffScore >= cfg.nDiffMin and diffScore < cfg.nDiffMax then
            scoreCfg = cfg
            break
        end
    end

    LogDebug("GCalHelp:FreeMatchArmyChangeSocreCfg() diffScore:%s", diffScore)
    LogTable(scoreCfg, "FreeMatchArmyChangeSocreCfg()")
    return scoreCfg
end

-- dif_val_a: uids[1] - uids[2] 的分数差
-- dif_val_b: uids[2] - uids[1] 的分数差
function GCalHelp:CalFreeMatchChangeScore(winderIx, uids, difScores)
    local ret = {}
    for ix, uid in ipairs(uids) do
        local difScore = difScores[ix]
        local useCfg = self:FreeMatchArmyChangeSocreCfg(difScore)
        if ix == winderIx then
            ret[uid] = useCfg.nGetScore
        else
            ret[uid] = useCfg.nLoseScore
        end
    end

    return ret
end


-- 数组合并
local function TableMerge(src, cpy)
    src = src or {}
    cpy = cpy or {}
    for i, v in ipairs(cpy) do
        table.insert(src, v)
    end
    return src
end

-- 虚数天灾词条转化传入战斗
function GCalHelp:GetCrossBossExdata(buffs, exData, cardData)
    if not buffs then
        return
    end
    exData.tExBuff = {}         -- 我方buff 数组
    exData.tMonsterBuff = {}    -- 怪物buff 数组​
    exData.tAllBuff = {}        -- 双方buff 数组​
    exData.tRandBuff = {}       -- 随机buff 格式给我方三个人加buff, 敌方1个人加buff
    if buffs and next(buffs) then
        for _, id in ipairs(buffs) do
            local cfg = CfgBuffVirtualCataclysm[id]
            if cfg.target == RogueBuffTarget.TeamAll then
                -- 我方全体
                TableMerge(exData.tExBuff, cfg.buffId)
                if cfg.skillId and next(cfg.skillId) then
                    for k, v in pairs(cardData) do
                        TableMerge(v.data.skills, cfg.skillId)
                    end
                end
            elseif cfg.target == RogueBuffTarget.MonsterAll then
                -- 敌方全体
                TableMerge(exData.tMonsterBuff, cfg.buffId)
            elseif cfg.target == RogueBuffTarget.BothAll then
                -- 敌我全体
                TableMerge(exData.tAllBuff, cfg.buffId)
                if cfg.skillId and next(cfg.skillId) then
                    for k, v in pairs(cardData) do
                        TableMerge(v.data.skills, cfg.skillId)
                    end
                end
            elseif cfg.target == RogueBuffTarget.TeamRandom then
                -- 我方随机
                table.insert(exData.tRandBuff, {
                    teamID = 1,
                    count = cfg.targetValue,
                    buff = table.copy(cfg.buffId)
                })

                local roleNum = #cardData
                if roleNum <= cfg.targetValue then
                    -- 上阵角色数少于随机数，全部角色加技能
                    if cfg.skillId and next(cfg.skillId) then
                        for idx, v in pairs(cardData) do
                            TableMerge(v.data.skills, cfg.skillId)
                        end
                    end
                else
                    -- 从上阵角色里面随机N个角色出来加上词条技能
                    local arr = {}
                    for i = 1, roleNum do
                        table.insert(arr, i)
                    end

                    local effectRoles = {}
                    for i = 1, cfg.targetValue do
                        local r = math.random(1, #arr)
                        effectRoles[arr[r]] = true
                        table.remove(arr, r)
                    end

                    if cfg.skillId and next(cfg.skillId) then
                        for idx, v in pairs(cardData) do
                            if effectRoles[idx] then
                                TableMerge(v.data.skills, cfg.skillId)
                            end
                        end
                    end
                end


            elseif cfg.target == RogueBuffTarget.MonsterRandom then
                -- 敌方随机
                table.insert(exData.tRandBuff, {
                    teamID = 2,
                    count = cfg.targetValue,
                    buff = table.copy(cfg.buffId)
                })
            end
        end
    end
end


-- 新世界boss词条转化传入战斗
function GCalHelp:GetGlobalBossExdata(buffs, exData, cardData)
    if not buffs then
        return
    end
    exData.tExBuff = {}         -- 我方buff 数组
    exData.tMonsterBuff = {}    -- 怪物buff 数组​
    exData.tAllBuff = {}        -- 双方buff 数组​
    exData.tRandBuff = {}       -- 随机buff 格式给我方三个人加buff, 敌方1个人加buff
    if buffs and next(buffs) then
        for _, id in ipairs(buffs) do
            local cfg = cfgGlobalBossBuffBattle[id]
            if cfg.target == RogueBuffTarget.TeamAll then
                -- 我方全体
                TableMerge(exData.tExBuff, cfg.buffId)
                if cfg.skillId and next(cfg.skillId) then
                    for k, v in pairs(cardData) do
                        TableMerge(v.data.skills, cfg.skillId)
                    end
                end
            elseif cfg.target == RogueBuffTarget.MonsterAll then
                -- 敌方全体
                TableMerge(exData.tMonsterBuff, cfg.buffId)
            elseif cfg.target == RogueBuffTarget.BothAll then
                -- 敌我全体
                TableMerge(exData.tAllBuff, cfg.buffId)
                if cfg.skillId and next(cfg.skillId) then
                    for k, v in pairs(cardData) do
                        TableMerge(v.data.skills, cfg.skillId)
                    end
                end
            elseif cfg.target == RogueBuffTarget.TeamRandom then
                -- 我方随机
                table.insert(exData.tRandBuff, {
                    teamID = 1,
                    count = cfg.targetValue,
                    buff = table.copy(cfg.buffId)
                })

                local roleNum = #cardData
                if roleNum <= cfg.targetValue then
                    -- 上阵角色数少于随机数，全部角色加技能
                    if cfg.skillId and next(cfg.skillId) then
                        for idx, v in pairs(cardData) do
                            TableMerge(v.data.skills, cfg.skillId)
                        end
                    end
                else
                    -- 从上阵角色里面随机N个角色出来加上词条技能
                    local arr = {}
                    for i = 1, roleNum do
                        table.insert(arr, i)
                    end

                    local effectRoles = {}
                    for i = 1, cfg.targetValue do
                        local r = math.random(1, #arr)
                        effectRoles[arr[r]] = true
                        table.remove(arr, r)
                    end

                    if cfg.skillId and next(cfg.skillId) then
                        for idx, v in pairs(cardData) do
                            if effectRoles[idx] then
                                TableMerge(v.data.skills, cfg.skillId)
                            end
                        end
                    end
                end


            elseif cfg.target == RogueBuffTarget.MonsterRandom then
                -- 敌方随机
                table.insert(exData.tRandBuff, {
                    teamID = 2,
                    count = cfg.targetValue,
                    buff = table.copy(cfg.buffId)
                })
            end
        end
    end
end

function GCalHelp:GetGlobalBossAddSkill(boss,bossId)
    function ArrToMap(arr)
        local map = {}
        for _, v in ipairs(arr) do
            map[v] = true
        end
        return map
    end
    local cfg = cfgGlobalBoss[bossId]
    if cfg and cfg.skillId then
        local mpSkills = ArrToMap(boss.skills)
        local mpTfSkills = ArrToMap(boss.tfSkills)
        for _,sId in ipairs(cfg.skillId or {}) do
            if not mpSkills[sId] then
                table.insert(boss.skills,sId)
                mpSkills[sId] = true
            end   
            if not mpTfSkills[sId] then
                table.insert(boss.tfSkills,sId)     
                mpTfSkills[sId] = true
            end
        end
    end
end

-- 计算连锁战线关卡分数
--[[                 
winner:1赢 2输
-- 局内分数 = 基础分/4*（1-使用总操作数/操作数上限）+基础分*3/4*（1-怪物剩余血量/关卡怪物总血量）*（1+ 存活人数*5%）
]]
function GCalHelp:CalcChainFrontDupScore(winner,dupId,aliveNum,stepCnt,exData,roundNum,plr)
    local dupCfg = MainLine[dupId]
    local dupGroupId = dupCfg and dupCfg.dungeonGroup or 0
    local DupGroupCfg = DungeonGroup[dupGroupId]
    local mstgCfg = MonsterGroup[dupCfg.nGroupID or 0]
    local score = 0
    if dupCfg and DupGroupCfg and mstgCfg then
        local tmpVal = 0
        local mstMaxHp = 0  -- 怪物总血量
        local mstLeftHp = 0  -- 怪物剩余总血量
        local cfgs = mstgCfg and mstgCfg.stage or {}
        for i, stage in ipairs(cfgs) do
            for j, mstId in ipairs(stage.monsters or {}) do
                local mcfg = MonsterData[mstId]
                if mcfg and mcfg.isChainPoints then
                    mstMaxHp = mstMaxHp + (mcfg and mcfg.maxhp or 0)
                end
            end
        end
        local hpInfo = exData.validMstHpInfo
        local tbVal = {15,25,30}
        local stepLimit = roundNum and tbVal[roundNum]
        if dupCfg.type == eDuplicateType.TaoFa then
            stepLimit = 100
        end
        if hpInfo and hpInfo.leftHp then
            mstLeftHp = math.max(hpInfo.leftHp,0) + self:GetLeftStageHp(hpInfo.stage,dupCfg.nGroupID,true)
        end
        local mstGroupCfg = MonsterGroup[dupCfg.nGroupID]
        local basePoint = dupCfg.basePoint or 0
        local tmpVal = mstMaxHp > 0 and mstLeftHp/mstMaxHp or 1
        score = basePoint/4*(1-stepCnt/stepLimit)+basePoint*3/4*(1-tmpVal)*(1+aliveNum*6/100)
        -- score = math.ceil(hpScore/2*(1-stepCnt/100)*(1+aliveNum*8/100) + hpScore/2)
        -- LogDebug(string.format("<><>GCalHelp:CalcChainFrontDupScore,总分(%s),关卡基础分（%s) 怪物剩余血量(%s) 怪物总血量(%s) 总操作数(%s) 操作数上限值(%s) 存活人数(%s)  ",score,basePoint,mstLeftHp,mstMaxHp,stepCnt,stepLimit,aliveNum))
        -- if plr then
        --     local tipStr = string.format("连锁战线关卡局内分数计算,总分(%s),关卡基础分(%s) 怪物剩余血量(%s) 怪物总血量(%s) 总操作数(%s) 操作数上限值(%s) 存活人数(%s)  ",score,basePoint,mstLeftHp,mstMaxHp,stepCnt,stepLimit,aliveNum)
        --     plr:SendTips(tipStr)   
        -- end
    end
    return score
end

-- 深塔战斗获取关卡分数
--[[                 
winner:1赢 2输
aliveNum：我方队伍存活人数
stepCnt：总操作数
dupId：关卡id
hpinfo：怪物血量数据
]]
function GCalHelp:CalcTowerDeepDupScore(winner,dupId,aliveNum,stepCnt,hpinfo)
    local dupCfg = MainLine[dupId]
    local dupGroupId = dupCfg and dupCfg.dungeonGroup or 0
    local DupGroupCfg = DungeonGroup[dupGroupId]
    local mstgCfg = MonsterGroup[dupCfg.nGroupID or 0]
    local score = 0
    if dupCfg and DupGroupCfg and mstgCfg then
        local tmpVal = 0
        local mstMaxHp = 0  -- 怪物总血量
        local mstLeftHp = 0  -- 怪物剩余总血量
        local cfgs = mstgCfg and mstgCfg.stage or {}
        for i, stage in ipairs(cfgs) do
            for j, mstId in ipairs(stage.monsters or {}) do
                local mcfg = MonsterData[mstId]
                if mcfg and mcfg.isPoints then
                    local addMaxHp = mcfg and mcfg.maxhp or 0
                    if mcfg.tTransfo and #mcfg.tTransfo > 0 then
                        addMaxHp = addMaxHp * 2
                    end
                    mstMaxHp = mstMaxHp + addMaxHp
                end
            end
        end
        if hpinfo then
            mstLeftHp = hpinfo.leftHp + self:TowerDeepGetLeftStageHp(hpinfo.stage,dupCfg.nGroupID,true)
        end
        tmpVal = mstLeftHp > 0 and (1 - mstLeftHp/mstMaxHp) or 1
        -- 血量分=关卡基础分*（1-怪物剩余血量/关卡怪物总血量）
        local hpScore = math.ceil(dupCfg.point * tmpVal)
        -- 实际积分=血量分/2*（1-使用总操作数/100）*（1+ 存活人数*8%）+血量分/2
        -- score = math.ceil(hpScore/2*(1-stepCnt/100)*(1+aliveNum*8/100) + hpScore/2)
        score = hpScore
        LogDebug(string.format("<><>GCalHelp:CalcTowerNewDupScore,总分(%s),关卡基础分（%s) 怪物剩余血量(%s) 怪物总血量(%s) 血量分(%s) 总操作数(%s) 存活人数(%s)  ",score,dupCfg.point,mstLeftHp,mstMaxHp,hpScore,stepCnt,aliveNum))
    end
    return score
end

-- 深塔战斗判断关卡组是否解锁
--[[            
groupId：关卡组id
totalScore:累计分数
]]

function GCalHelp:isTowerDeepDupGroupUnlock(groupId,totalScore)
    local groupCfg = DungeonGroup[groupId]
    if not groupCfg then
        return
    end
    -- 判断是否达到关卡组解锁条件
    if not groupCfg.perPoint or groupCfg.perPoint > totalScore then
        -- LogDebug(string.format("GCalHelp:isTowerDeepDupGroupUnlock score not enougth,groupId(%s),totalScore(%s),needScore(%s)",groupId,totalScore,groupCfg.perPoint))
        return
    end

    if groupCfg.nOpenTime and CURRENT_TIME < groupCfg.nOpenTime then
        -- LogDebug(string.format("GCalHelp:isTowerDeepDupGroukpUnlock,not in open time,groupId(%s),openTime(%s)",groupId,groupCfg.nOpenTime))
        return
    end
    return true
end

-----------------------------------------------------------------------------------------------------------
-- 数值返回35进制字符( 4 位的 35 进制最大可表示 1,500,625 个可能值)
function GCalHelp:DecToBase35(number, minLen)
    -- local base36str = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" -- 36进制的 0 和 O 有时候不好区分，所以去掉O 就是35进制
    local base35str = "0123456789ABCDEFGHIJKLMNPQRSTUVWXYZ"
    local result = ""
    
    while number > 0 do
        -- 取余数得到当前位的36进制值
        local remainder = number % 35
        -- 将余数转换为对应的36进制字符并添加到结果字符串的开头
        result = base35str:sub(remainder + 1, remainder + 1) .. result
        -- 更新number为除以36的商，继续循环直到number为0
        number = math.floor(number / 35)
    end
    
    -- 如果结果为空，说明输入的数字为0
    while result:len() < minLen do
        result = "0" .. result
    end

    return result
end


-----------------------------------------------------------------------------------------------------------
-- 计算自由军演，段位
function GCalHelp:CalFreeMatch3RankLv(score)
    for _, cfg in ipairs(CfgPvp3RankLevel) do
        -- LogDebug("score:%s <= cfg.nScore:%s", score, cfg.nScore)
        if score < cfg.nScore then
            return cfg.id
        end
    end

    return CfgPvp3RankLevel[#CfgPvp3RankLevel].id
end


-----------------------------------------------------------------------------------------------------------
-- 计算自由军演，继承分数
-- args:
---- preScore: 上次分数
---- preRankLv: 上一次段位（没有传nil, 函数自己算）
---- preCfgid: 上次赛季配置id
---- curCfgId: 当前赛季配置id
-- ret:
---- score: 继承的分数
---- rankLv: 继承的段位
function GCalHelp:CalFreeMatch3InheritScore(preScore, preRankLv)
    if not preRankLv then
        preRankLv = self:CalFreeMatch3RankLv(preScore)
    end

    -- 修改分数
    local curRankLv = preRankLv - 2
    if curRankLv < 2 then
        return 0, 1
    end

    local curRlCfg = CfgPvp3RankLevel[curRankLv-1]
    return curRlCfg.nScore, curRankLv
end


-----------------------------------------------------------------------------------------------------------
-- v 4.3 返回自由匹配，增减的分数
function GCalHelp:FreeMatch3ArmyChangeSocreCfg(diffScore)
    local scoreCfg = nil
    for _, cfg in ipairs(CfgPvp3Score) do
        if diffScore >= cfg.nDiffMin and diffScore < cfg.nDiffMax then
            scoreCfg = cfg
            break
        end
    end

    LogDebug("GCalHelp:FreeMatch3ArmyChangeSocreCfg() diffScore:%s", diffScore)
    LogTable(scoreCfg, "FreeMatch3ArmyChangeSocreCfg()")
    return scoreCfg
end

-- dif_val_a: uids[1] - uids[2] 的分数差
-- dif_val_b: uids[2] - uids[1] 的分数差
function GCalHelp:CalFreeMatch3ChangeScore(winderIx, uids, difScores)
    local ret = {}
    for ix, uid in ipairs(uids) do
        local difScore = difScores[ix]
        local useCfg = self:FreeMatch3ArmyChangeSocreCfg(difScore)
        if ix == winderIx then
            ret[uid] = useCfg.nGetScore
        else
            ret[uid] = useCfg.nLoseScore
        end
    end

    return ret
end

--------------------------------------------------------------------------------------------
-- 添加装备互斥技能
function GCalHelp:RegisterExcludeSkill(cid, equipFightSkills, excludeSkills)
    -- LogDebug("GCalHelp:RegisterExcludeSkill cid:%s", cid)
    -- LogTable(equipFightSkills, "GCalHelp:RegisterExcludeSkill equipFightSkills:")

    local rInfo = {}

    local isChange = false
    for _, skillId in ipairs(equipFightSkills or {}) do
        local cfg = g_CalExcludeSkillIds[skillId]
        if cfg then
            isChange = true
            table.insert(rInfo, cfg) -- cfg:{nExcludeId = cfg.nExcludeId, nEquipSkillId = id, nSkillId = cfg.nGetSkillId}
        end
    end

    -- 保存互斥技能数组
    if isChange then
        excludeSkills[cid] = rInfo
    else
        -- 当前卡牌已无互斥技能时清理旧缓存，避免后续错误删技能
        excludeSkills[cid] = nil
    end
end

--------------------------------------------------------------------------------------------
-- 去掉装备互斥技能
-- cardDataArrs: 
function GCalHelp:RemoveExcludeSkill(cardDataArrs, excludeSkills)
   -- LogDebug("=================================================================================================")
    -- LogTable(cardDataArrs, "GCalHelp:RemoveExcludeSkill cardDataArrs:")
    LogTable(excludeSkills, "GCalHelp:RemoveExcludeSkill excludeSkills:")
    -- 根据卡牌id分类
    local cardDatas = {}

    -- 按照互斥id分类
    local excludeIdMap = {}

    -- 遍历卡牌数据，取出所有卡牌的互斥技能信息
    for _, fightData in ipairs(cardDataArrs) do
        local cardData = fightData.data
        local cid = cardData.real_cid or cardData.cid or fightData.cid
        if cid then
            cardDatas[cid] = cardData

            local rInfo = excludeSkills[cid]
            if rInfo then
                -- 如果这个卡牌存在互斥技能
                -- LogTable(rInfo, "Card "..cid.." exclude info:")
                for _, cfg in ipairs(rInfo) do
                    -- 加入
                    local arr = GCalHelp:GetTb(excludeIdMap, cfg.nExcludeId)
                    table.insert(arr, {cid = cid, skillId = cfg.nSkillId})
                end
            end
        else
            LogWarning("GCalHelp:RemoveExcludeSkill had none card not real_cid")
            -- LogTable(fightData, "GCalHelp:RemoveExcludeSkill() fightData")
        end
    end

    local CfgSkills = _G['skill']

    -- LogTable(CfgSkills, "CfgSkills:")
    -- LogTable(cardDatas, "cardDatas:")
    -- LogTable(cardDataArrs, "cardDataArrs:")
    LogTable(excludeIdMap, "GCalHelp:RemoveExcludeSkill:")

    for excludeId, infos in pairs(excludeIdMap) do
        local len = #infos
        -- 如果互斥数组大于1，那么表示存在互斥
        if len > 1 then
            -- 根据技能等级，从大到小排序
            table.sort(
                infos,
                function(rhs, lhs)
                    local rCfg = CfgSkills[rhs.skillId]
                    local lCfg = CfgSkills[lhs.skillId]
                    return rCfg.lv > lCfg.lv
                end
            )
            -- 倒序删除，保留等级最大的那个，其余的删掉
            for i = len, 2, -1 do
                local info = infos[i]
                local cardData = cardDatas[info.cid]

                local sLen = #cardData.skills
                LogTable(cardData.skills, string.format("GCalHelp:RemoveExcludeSkill card cfgid:%s before", cardData.cfgid))
                for si = sLen, 1, -1 do
                    if cardData.skills[si] == info.skillId then
                        table.remove(cardData.skills, si)
                    end
                end
                LogTable(cardData.skills, string.format("GCalHelp:RemoveExcludeSkill card cfgid:%s after", cardData.cfgid))
            end
        end
    end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 连锁战线转化传入战斗
function GCalHelp:GetChainFrontExdata(buffs, exData, cardData)
    if not buffs then
        return
    end
    exData.tExBuff = {}         -- 我方buff 数组
    exData.tMonsterBuff = {}    -- 怪物buff 数组​
    exData.tAllBuff = {}        -- 双方buff 数组​
    exData.tRandBuff = {}       -- 随机buff 格式给我方三个人加buff, 敌方1个人加buff
    for _,bfs in ipairs(buffs) do
        local cfgs = CfgBuffChain
        if bfs.type == 2 then
            cfgs = CfgBossBuffChain
        end
        local cfg = cfgs and cfgs[bfs.id]
        if cfg then
            if cfg.target == RogueBuffTarget.TeamAll then
                -- 我方全体
                TableMerge(exData.tExBuff, cfg.buffId)
                if cfg.skillId and next(cfg.skillId) then
                    for k, v in pairs(cardData) do
                        TableMerge(v.data.skills, cfg.skillId)
                    end
                end
            elseif cfg.target == RogueBuffTarget.MonsterAll then
                -- 敌方全体
                TableMerge(exData.tMonsterBuff, cfg.buffId)
            elseif cfg.target == RogueBuffTarget.BothAll then
                -- 敌我全体
                TableMerge(exData.tAllBuff, cfg.buffId)
                if cfg.skillId and next(cfg.skillId) then
                    for k, v in pairs(cardData) do
                        TableMerge(v.data.skills, cfg.skillId)
                    end
                end
            elseif cfg.target == RogueBuffTarget.TeamRandom then
                -- 我方随机
                table.insert(exData.tRandBuff, {
                    teamID = 1,
                    count = cfg.targetValue,
                    buff = table.copy(cfg.buffId)
                })

                local roleNum = #cardData
                if roleNum <= cfg.targetValue then
                    -- 上阵角色数少于随机数，全部角色加技能
                    if cfg.skillId and next(cfg.skillId) then
                        for idx, v in pairs(cardData) do
                            TableMerge(v.data.skills, cfg.skillId)
                        end
                    end
                else
                    -- 从上阵角色里面随机N个角色出来加上词条技能
                    local arr = {}
                    for i = 1, roleNum do
                        table.insert(arr, i)
                    end

                    local effectRoles = {}
                    for i = 1, cfg.targetValue do
                        local r = math.random(1, #arr)
                        effectRoles[arr[r]] = true
                        table.remove(arr, r)
                    end

                    if cfg.skillId and next(cfg.skillId) then
                        for idx, v in pairs(cardData) do
                            if effectRoles[idx] then
                                TableMerge(v.data.skills, cfg.skillId)
                            end
                        end
                    end
                end
            elseif cfg.target == RogueBuffTarget.MonsterRandom then
                -- 敌方随机
                table.insert(exData.tRandBuff, {
                    teamID = 2,
                    count = cfg.targetValue,
                    buff = table.copy(cfg.buffId)
                })
            end
        end
    end
end


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 处理消耗体力特殊掉落奖励
function GCalHelp:HandleSpeicalReward(plr,id,addHotVal)
    local specialDropsCfg = CfgSpecialDrops[id]
    if not specialDropsCfg then
        return
    end
    if not TimerHelper:CurTimeIsInRange(specialDropsCfg.nStartTime,specialDropsCfg.nEndTime) then
        return
    end
    plr:AddModHot(addHotVal, CURRENT_TIME,nil,true)
    if TimerHelper:CurTimeIsInRange(specialDropsCfg.nStartTime,specialDropsCfg.nEndTime) then
        if specialDropsCfg.DropID and specialDropsCfg.proportions then
            local hot = plr:GetMix('modHot', 0)
            LogD("HandleSpeicalReward,%s:  出现掉落hot:%s,specialDropsCfg.proportions:%s", plr:Get('uid'), hot, specialDropsCfg.proportions)
            if hot > 0 and specialDropsCfg.proportions and hot >= specialDropsCfg.proportions then
                --双倍掉落
                local multiNum = 1
                local remainder = hot % specialDropsCfg.proportions -- 求余数
                --掉落的数量
                local numMulti = (hot - remainder) / specialDropsCfg.proportions
                plr:CheckSpecialDropsInfo()
                local specialDropsInfo = PlrRecord:GetSpecialDropsInfo(plr)
                local reward = {}
                for _, v in pairs(specialDropsCfg.DropID) do
                    local dropCfg = CfgDropItem[v]
                    --LogTable(dropCfg,"dropCfg")
                    if dropCfg and dropCfg.DropItemID and dropCfg.DropNum then
                        local dorpMin = dropCfg.DropNum[1] or 0
                        local dorpMax = dropCfg.DropNum[2] or 0
                        local dorpCount = math.random(dorpMin, dorpMax) * numMulti * multiNum

                        if not specialDropsInfo[2] then
                            specialDropsInfo[2] = {}
                        end

                        if not specialDropsInfo[2][dropCfg.DropItemID] then
                            specialDropsInfo[2][dropCfg.DropItemID] = 0
                        end
                        if dropCfg.DropMax then
                            if dorpCount + specialDropsInfo[2][dropCfg.DropItemID] > dropCfg.DropMax then
                                dorpCount = dropCfg.DropMax - specialDropsInfo[2][dropCfg.DropItemID]
                            end
                        end
                        specialDropsInfo[2][dropCfg.DropItemID] = specialDropsInfo[2][dropCfg.DropItemID] + dorpCount
                        local r = {}
                        r[1] = dropCfg.DropItemID
                        r[2] = dorpCount
                        table.insert(reward, r)
                    end
                end
                if not table.empty(reward) then
                    plr:SetMix('modHot', remainder)
                    PlrRecord:UpdateSpecialDropsInfo(plr, specialDropsInfo)
                    local ret = GCalHelp:IdNumArrToTb(reward, 1, nil, nil)
                    plr:GetSpecialDropsInfo()
                    plr:AddItemList(ret, "GCalHelp:HandleSpeicalReward", true, false, true)
                    return ret
                end
            end
        end
    end
end


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 周期BOSS轮换时间
-- cfg[i] = { loopTime = X, duringTime = Y }  loopTime=轮换周期(分), duringTime=可持续挑战时间(分)
-- 返回: 每个活动的绝对时间信息列表
-- 返回: 绝对周期BOSS数，已经过BOSS数
---@return table|nil { [1]={idx,startTime,endTime,enterStart,enterEnd}, ... }
---@return number 绝对周期BOSS数，已经过BOSS数
function GCalHelp:GetPeriodicBossTimes(curTime)
    curTime = curTime or CURRENT_TIME
    local baseTime = GCalHelp:GetTimeStampBySplit(g_PeriodicBossOpenTime)
    local cfg = CfgPeriodicBoss
    if not cfg or not next(cfg) or curTime < baseTime then
        return nil
    end

    local n = #cfg

    -- 总周期时长（秒）
    local totalLoop = 0
    for k, v in ipairs(cfg) do
        totalLoop = totalLoop + v.loopTime * 60
    end

    -- 当前周期起点（向下取整到周期边界）
    local elapsed = (curTime - baseTime) % totalLoop
    local cycleStart = curTime - elapsed

    -- 计算每个活动在最近周期的偏移
    local offsets = {}
    local acc = 0
    for i = 1, n do
        offsets[i] = acc
        acc = acc + cfg[i].loopTime * 60
    end

    -- 构建返回列表
    local list = {}
    for i = 1, n do
        local startTime = cycleStart + offsets[i]          -- 本周期的开始时间
        if startTime + cfg[i].loopTime * 60 < curTime then
            -- 已过期：取下一周期
            startTime = startTime + totalLoop
        end
        list[i] = {
            idx = cfg[i].id,
            startTime = startTime,                         -- 轮换开始时间戳
            endTime = startTime + cfg[i].loopTime * 60,    -- 轮换结束时间戳
            enterStart = startTime,                        -- 可进入开始（与startTime相同）
            enterEnd = startTime + cfg[i].duringTime * 60, -- 可进入结束
        }
    end

    -- 绝对周期BOSS数，已经过BOSS数
    local absBossNum = math.floor((curTime - baseTime) / (totalLoop / n))

    return list, absBossNum
end


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 根据词条表ID添加BUFF
function GCalHelp:GetExdataFromBuffs(cfgs, buffs, exData, cardData)
    if not buffs or not next(buffs) then
        return
    end
    ASSERT(exData, "GCalHelp:GetExdataFromBuffs not exData")
    ASSERT(cardData, "GCalHelp:GetExdataFromBuffs not cardData")

    exData.tExBuff = {}         -- 我方buff 数组
    exData.tMonsterBuff = {}    -- 怪物buff 数组​
    exData.tAllBuff = {}        -- 双方buff 数组​
    exData.tRandBuff = {}       -- 随机buff 格式给我方三个人加buff, 敌方1个人加buff
    for _, id in ipairs(buffs) do
        local cfg = cfgs and cfgs[id]
        if cfg then
            if cfg.target == RogueBuffTarget.TeamAll then
                -- 我方全体
                TableMerge(exData.tExBuff, cfg.buffId)
                if cfg.skillId and next(cfg.skillId) then
                    for k, v in pairs(cardData) do
                        TableMerge(v.data.skills, cfg.skillId)
                    end
                end
            elseif cfg.target == RogueBuffTarget.MonsterAll then
                -- 敌方全体
                TableMerge(exData.tMonsterBuff, cfg.buffId)
            elseif cfg.target == RogueBuffTarget.BothAll then
                -- 敌我全体
                TableMerge(exData.tAllBuff, cfg.buffId)
                if cfg.skillId and next(cfg.skillId) then
                    for k, v in pairs(cardData) do
                        TableMerge(v.data.skills, cfg.skillId)
                    end
                end
            elseif cfg.target == RogueBuffTarget.TeamRandom then
                -- 我方随机
                table.insert(exData.tRandBuff, {
                    teamID = 1,
                    count = cfg.targetValue,
                    buff = table.copy(cfg.buffId)
                })

                local roleNum = #cardData
                if roleNum <= cfg.targetValue then
                    -- 上阵角色数少于随机数，全部角色加技能
                    if cfg.skillId and next(cfg.skillId) then
                        for idx, v in pairs(cardData) do
                            TableMerge(v.data.skills, cfg.skillId)
                        end
                    end
                else
                    -- 从上阵角色里面随机N个角色出来加上词条技能
                    local arr = {}
                    for i = 1, roleNum do
                        table.insert(arr, i)
                    end

                    local effectRoles = {}
                    for i = 1, cfg.targetValue do
                        local r = math.random(1, #arr)
                        effectRoles[arr[r]] = true
                        table.remove(arr, r)
                    end

                    if cfg.skillId and next(cfg.skillId) then
                        for idx, v in pairs(cardData) do
                            if effectRoles[idx] then
                                TableMerge(v.data.skills, cfg.skillId)
                            end
                        end
                    end
                end
            elseif cfg.target == RogueBuffTarget.MonsterRandom then
                -- 敌方随机
                table.insert(exData.tRandBuff, {
                    teamID = 2,
                    count = cfg.targetValue,
                    buff = table.copy(cfg.buffId)
                })
            end
        end
    end
end
