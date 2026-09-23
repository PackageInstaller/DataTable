-- 建造卡池详情
local qualityDatasArr = {}
local ids = {}

function Awake()
    CSAPI.PlayUISound("ui_window_open_load")
end

function Refresh(_data)
    data = _data
    SetDatas()
    SetItems()

    SetItems0()
end

function SetDatas()
    qualityDatas = {}
    local rID = data:GetRewardCfgID()
    if (not rID) then
        return
    end
    local rCfg = Cfgs.RewardInfo:GetByID(rID)
    for i, v in ipairs(rCfg.item) do
        AddDatas1(v.id)
    end
    -- arr 
    qualityDatasArr = {}
    local count = 0
    for k, v in pairs(qualityDatas) do
        table.insert(qualityDatasArr, {k, v})
        count = count + 1
    end

    if (count > 1) then
        table.sort(qualityDatasArr, function(a, b)
            return a[1] > b[1]
        end)
    end
    qualityDatas = nil
end

function AddDatas1(id)
    local oCfg = Cfgs.RewardInfo:GetByID(id)
    if (oCfg.quality) then
        qualityDatas[oCfg.quality] = qualityDatas[oCfg.quality] or {}
        for k, v in pairs(oCfg.item) do
            if (v.type == 1) then
                -- 模板
                AddDatas1(v.id)
            elseif (v.type == 3) then
                -- 处理卡牌
                if (tonumber(v.s_probability) ~= 0) then
                    -- 是否检查开启时间
                    if (not oCfg.bIsLimit or not v.openTimes or CheckInTime(v.openTimes)) then
                        local isRemove = false
                        if (ids[v.id]) then
                            if (not oCfg.isPublicUse) then
                                for p, q in ipairs(qualityDatas[oCfg.quality]) do
                                    if (q.id == v.id) then
                                        table.remove(qualityDatas[oCfg.quality], p)
                                        break
                                    end
                                end
                                table.insert(qualityDatas[oCfg.quality], v)
                            end
                        else
                            ids[v.id] = 1
                            table.insert(qualityDatas[oCfg.quality], v)
                        end
                    end
                end
            end
        end
    else
        -- 模板
        for i, v in ipairs(oCfg.item) do
            AddDatas1(v.id)
        end
    end
end
-- function AddDatas2(datas, item, bIsLimit)
--     for p, q in ipairs(item) do
--         if (tonumber(q.s_probability) ~= 0) then
--             -- 是否检查开启时间
--             if (not bIsLimit or not q.openTimes or CheckInTime(q.openTimes)) then
--                 table.insert(datas, q)
--             end
--         end
--     end
-- end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("Create/CreateInfoItem", items, qualityDatasArr, Content, nil, 1, data:IsSelectPool())
end

function SetItems0()
    -- datas 
    local hadUP, datas0, isChoise = GetItem0Datas()
    if (not hadUP) then
        if (item0) then
            CSAPI.SetGOActive(item0.gameObject, false)
        end
        return
    end
    -- item 
    if (not item0) then
        ResUtil:CreateUIGOAsync("Create/CreateInfoItem0", Content, function(go)
            item0 = ComUtil.GetLuaTable(go)
            item0.Refresh(datas0, isChoise)
            go.transform:SetAsFirstSibling()
        end)
    else
        CSAPI.SetGOActive(item0.gameObject, true)
        item0.Refresh(datas0, isChoise)
    end
end

function CheckInTime(openTimes)
    local curTime = TimeUtil:GetTime()
    if (openTimes[1] and curTime < TimeUtil:GetTimeStampBySplit(openTimes[1])) then
        return false
    end
    if (openTimes[2] and curTime > TimeUtil:GetTimeStampBySplit(openTimes[2])) then
        return false
    end
    return true
end

function GetItem0Datas()
    local hadUP, datas0, isChoise = false, {}, false
    if (data:IsSelectPool()) then
        if (data:IsSelectRole()) then
            hadUP = true
            isChoise = true
            local ids = data:GetChoiceCids()
            datas0[6] = {}
            for k = 1, 2 do
                local id = ids[k]
                for p, q in pairs(qualityDatasArr) do
                    if (q[1] == 6) then
                        for p1, q1 in pairs(q[2]) do
                            if (q1.id == id) then
                                table.insert(datas0[6], q1)
                                break
                            end
                        end
                        break
                    end
                end
            end
            datas0[5] = {}
            for k = 3, 5 do
                local id = ids[k]
                for p, q in pairs(qualityDatasArr) do
                    if (q[1] == 5) then
                        for p1, q1 in pairs(q[2]) do
                            if (q1.id == id) then
                                table.insert(datas0[5], q1)
                                break
                            end
                        end
                        break
                    end
                end
            end
        end
    else
        for k, v in pairs(qualityDatasArr) do
            datas0[v[1]] = {}
            for p, q in pairs(v[2]) do
                if (q.s_up_probability) then
                    table.insert(datas0[v[1]], q)
                    hadUP = true
                end
            end
        end
    end
    return hadUP, datas0, isChoise
end
