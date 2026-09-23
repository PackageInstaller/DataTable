-- 改造列表item
local costId = 10011
local panelType = 1 -- 1:未选择  2：已选择  3：改造中/完成

local runTime = false
local needTime = 0
local selectData = nil
local timer = 0
local buildRun = false

function Update()
    if (buildRun and runTime) then
        if (Time.time > timer) then
            timer = Time.time + 0.1
            SetTime()
        end
    end
end

function SetEmpty(_data)
    CSAPI.SetGOActive(empty, true)
    CSAPI.SetGOActive(entity, false)
    LanguageMgr:SetText(txtEmpty, 10301, _data.lockID)
end

function Refresh(_index, _data, _buildingData, _cb)
    CSAPI.SetGOActive(empty, false)
    CSAPI.SetGOActive(entity, true)

    index = _index
    data = _data.slot ~= nil and _data or nil
    buildingData = _buildingData
    cb = _cb

    if (data) then
        selectData = nil
    end
    buildRun = buildingData:GetData().running
    RefreshPanel()
end

-- 设置选中的装备
function SetSelectData(_data)
    selectData = _data
    RefreshPanel()
end

function RefreshPanel()
    SetType()
    SetBaseTime()
    SetTime()
    SetPanels()
end

function SetType()
    panelType = 1
    if (data ~= nil) then
        panelType = 3
    elseif (selectData ~= nil) then
        panelType = 2
    end
end

function SetBaseTime()
    timeMul, openTime, oldLen = buildingData:GetTimeMul()
    runTime = false
    needTime = 0
end

function SetTime()
    if (data) then
        if (not buildRun and data.tLeft and data.tLeft > 0) then
            needTime = data.tLeft
        else
            --local runLen = oldLen + (TimeUtil:GetTime() - openTime) * timeMul
            -- needTime = data.num - data.tCur - runLen
            needTime = data.tf - TimeUtil:GetTime()
            needTime = needTime > 0 and needTime or 0
            runTime = needTime > 0
        end
    elseif (selectData) then
        local _count, _needTime = GetPoolCfgInfo(buildingData:GetCfg().poolId, selectData:GetQuality())
        needTime = _needTime
    end
    if (needTime <= 0) then
        needTime = 0
        runTime = false
        -- SetPanels()  由服务器推送刷新
    end
    CSAPI.SetText(txtTime32, TimeUtil:GetTimeStr(needTime))
end

function SetPanels()
    SetItem1()
    SetPanel1()
    SetPanel2()
    SetPanel3()
end

function SetItem1()
    if (item1Grid == nil) then
        local go, item = ResUtil:CreateEquipItem(item1.transform)
        CSAPI.SetScale(go, 0.8, 0.8, 0.8);
        item1Grid = item
    end
    local data1, elseData1 = GetItem1Datas()
    item1Grid.Refresh(data1, elseData1)
    item1Grid.SetCount(0)
    -- 改造时，隐藏部位图标
    if (panelType == 3) then
        item1Grid.SetSlot(nil)
    end
    LanguageMgr:SetText(txtGo1, 10302)
    CSAPI.SetGOActive(txtGo1, panelType == 2)
end

function GetItem1Datas()
    local data1 = nil
    local elseData1 = {
        isClick = false
    }
    if (panelType == 2) then
        data1 = selectData
    elseif (panelType == 3) then
        data1 = EquipMgr:GetFakeData(data.equipId)
        local cfg = data1:GetCfg()
        data1.cfg = table.copy(cfg)
        data1:GetCfg().nQuality = data1:GetCfg().nQuality + 1 -- 品质增加1 
    else
        elseData1.plus = true
    end
    return data1, elseData1
end

function GetItem3Datas()
    local data3 = nil
    local elseData3 = {
        isClick = false
    }
    data3 = EquipMgr:GetFakeData(selectData:GetCfgID())
    local cfg = data3:GetCfg()
    data3.cfg = table.copy(cfg)
    data3:GetCfg().nQuality = data3:GetCfg().nQuality + 1 -- 品质增加1 	
    return data3, elseData3
end

function SetPanel1()
    CSAPI.SetGOActive(panel1, panelType == 1)
end

function SetPanel2()
    CSAPI.SetGOActive(panel2, panelType == 2)
    if (panelType == 2) then
        -- 2
        local curData = BagMgr:GetFakeData(costId)
        if (item2Grid == nil) then
            item2Grid = ResUtil:CreateRewardByData(curData, item2.transform)
            CSAPI.SetScale(item2Grid.gameObject, 0.8, 0.8, 0.8);
        else
            item2Grid.Refresh(curData)
        end
        item2Grid.SetClickCB(GridClickFunc.OpenInfo)
        item2Grid.SetCount(0)

        local num = BagMgr:GetCount(costId)
        local need, needTime = GetPoolCfgInfo(buildingData:GetCfg().poolId, selectData:GetQuality())
        local str = need > num and StringUtil:SetByColor(num, "ff8790") or num
        item2Grid.SetDownCount(str .. "/" .. need)

        CSAPI.SetText(txtTime22, TimeUtil:GetTimeStr(needTime))

        -- 3
        local data3, elseData3 = GetItem3Datas()
        if (item3Grid == nil) then
            local go, item = ResUtil:CreateEquipItem(item3.transform)
            CSAPI.SetScale(go, 0.8, 0.8, 0.8);
            item3Grid = item
        end
        item3Grid.Refresh(data3, elseData3)
        item3Grid.SetCount(0)
        -- 改造时，隐藏部位图标
        item3Grid.SetSlot(nil)
    end
end

function SetPanel3()
    CSAPI.SetGOActive(panel3, panelType == 3)
    if (panelType == 3) then
        CSAPI.SetGOActive(txtTime31, runTime)
        CSAPI.SetGOActive(txtTime32, runTime)
        CSAPI.SetGOActive(run, runTime)
        CSAPI.SetGOActive(success, not runTime)
    end
end

-- costs:num  needTime
function GetPoolCfgInfo(_poolId, _poolIndex)
    local cfg = Cfgs.CfgBRemouldPool:GetByID(_poolId)
    local curCfg = cfg.arr[_poolIndex]
    local costs = curCfg and curCfg.costs or nil
    local cost = costs and costs[1] or nil

    local num = cost[2]
    local ability1 = buildingData:GetAbilityVale(RoleAbilityType.OptimizeDev) -- 减少材料的能力 
    if (ability1 and ability1.vals[1]) then
        num = math.ceil(num + num * ability1.vals[1] / 100)
    end

    local needTime = curCfg.needTime
    local ability2 = buildingData:GetAbilityVale(RoleAbilityType.Artisan) -- 减少时间的能力 
    if (ability2 and ability2.vals[1]) then
        needTime = math.ceil(needTime - needTime * ability2.vals[1] / 100)
    end

    return num, needTime
end

function OnClick1()
    if (data) then
        return
    end
    if (selectData) then
        SetSelectData(nil)
        if (cb) then
            cb(index, true)
        end
    else
        if (cb) then
            cb(index)
        end
    end
end

function OnClickRemould()
    if (selectData) then
        local quality = selectData:GetQuality()
        local id = selectData:GetID()
        BuildingProto:Remould(buildingData:GetId(), quality, id, index)
        if (cb) then
            cb(index, true)
        end
    end
end

function OnClickSuccess()
    if (data and not runTime) then
        BuildingProto:RemouldFinish(buildingData:GetId(), data.id, data.type)
    end
end
