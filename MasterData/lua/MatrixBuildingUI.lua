-- 建造或者升级
local runTime = false
local timer = 0
local needTime = 0
local baseTime = 0
local maxTime = 1 -- 建造或

function SetClickCB(_cb)
    cb = _cb 
end

function Awake()
    outlineBar = ComUtil.GetCom(hp, "OutlineBar")
end

function Update()
    if (runTime) then
        timer = timer - Time.deltaTime
        if (timer < 0) then
            timer = 0.2
            SetTime()
        end
    end
    -- if (animTimer and Time.time > animTimer) then
    --     animTimer = nil
    --     CSAPI.SetGOActive(animObj, false)
    -- end
end

--
function Refresh(_cfg)
    cfg = _cfg ~= nil and _cfg or cfg
    data = MatrixMgr:GetBuildingDataByType(cfg.type)
    buildingState = nil
    baseTime = nil
    if (data) then
        buildingState, baseTime = data:GetState()
    end

    SetLv()
    SetHP()
    SetTips()
    SetName()
    SetRole()
    SetTimeBase()
    SetItems()
    -- SetRepair()
    -- SetWarning()
    SetActive()
    SetImgGridsPos()
end

function SetImgGridsPos()
    local x = -190
    if (cfg.type == BuildsType.TradingCenter or cfg.type == BuildsType.Expedition) then
        x = 190
    end
    CSAPI.SetAnchor(itemGrids, x, 0, 0)
end

function SetLv()
    -- txtlv
    local isShow = false
    if (buildingState and buildingState ~= MatrixBuildingType.Create) then
        isShow = true
        CSAPI.SetText(txtLv, data:GetLv() .. "")
    end
    CSAPI.SetGOActive(lv, isShow)
    -- imglv
    CSAPI.SetGOActive(imgLv, not isShow)
    if (not isShow) then
        if (buildingState) then
            ResUtil.MatrixIcon:Load(imgLv, "building")
        else
            ResUtil.MatrixIcon:Load(imgLv, cfg.icon_small)
        end
    end
end

function SetHP()
    local isShow = false
    if (buildingState and outlineBar~=nil) then
        isShow = true
        local cur, max = data:GetHP()
        if (buildingState == MatrixBuildingType.Create) then
            max = 0
        end
        outlineBar:SetProgress(max == 0 and 1 or cur / max)
    end
    CSAPI.SetGOActive(hp, isShow)
end

function SetTips()
    local langID, color = nil, nil
    if (buildingState) then
        if (buildingState == MatrixBuildingType.Create) then
            langID = 10094
            color = "ffffff"
        end
    else
        langID = 10095
        color = "c3c3c8"
    end
    CSAPI.SetGOActive(txtTips, langID ~= nil)
    if (langID ~= nil) then
        local str = LanguageMgr:GetByID(langID)
        StringUtil:SetColorByName(txtTips, str, color)
    end
end

function SetName()
    -- local str = ""
    -- if (buildingState) then
    --     str = StringUtil:SetByColor(cfg.name, "ffc146")
    -- else
    --     str = StringUtil:SetByColor(cfg.name, "c3c3c8")
    -- end
    CSAPI.SetText(txtName, cfg.name)
end

function SetRole()
    local isShow = true
    if (buildingState == nil or buildingState == MatrixBuildingType.Create) then
        isShow = false
    end
    CSAPI.SetGOActive(role, isShow)
    if (isShow) then
        local cur, max = data:GetRoleCnt()
        if (data:SetBaseCfg().id == Dorm_CfgID) then
            cur, max = DormMgr:GetRoleCnt()
        end
        CSAPI.SetText(txtRole1, cur .. "")
        CSAPI.SetText(txtRole2, "/" .. max)
    end
end
function SetTimeBase()
    runTime = false
    if (buildingState) then
        local curLv, maxLv = data:GetLv()
        if (curLv < maxLv) then
            if (buildingState == MatrixBuildingType.Upgrage) then
                -- 升级中
                maxTime = data:GetCfg().upTime
                SetTime()
            elseif (buildingState == MatrixBuildingType.Create) then
                -- 建造中
                maxTime = data:SetBaseCfg().buildTime
                SetTime()
            end
        end
    end
    CSAPI.SetGOActive(timeObj, runTime)
    SetDown()
end

function SetTime()
    if (baseTime > 0) then
        needTime = baseTime - TimeUtil:GetTime()
    else
        needTime = -1
    end
    runTime = needTime >= -0.1
    CSAPI.SetText(txtUpTime, runTime and TimeUtil:GetTimeStr7(needTime) or "")
    if (not runTime) then
        CSAPI.SetGOActive(timeObj, runTime)
        SetDown()
    end
end

function SetDown()
    local imgName = runTime and "copy4" or "copy3"
    CSAPI.LoadImg(imgDown, "UIs/Matrix/" .. imgName .. ".png", true, nil, true)
    -- pos 
    local pos = MatrixMgr:GetPointPosByBuildType(cfg.type)
    pos[2] = runTime and (pos[2] - 30) or pos[2]
    CSAPI.SetAnchor(imgDown, pos[1], pos[2], 0)
end

function SetItems()
    CSAPI.SetGOActive(itemParent, buildingState ~= nil)
    if (not buildingState) then
        return
    end
    rwItems = rwItems or {}
    for i, v in pairs(rwItems) do
        CSAPI.SetGOActive(v.gameObject, false)
    end
    -- 生产中心
    if (cfg.type == BuildsType.ProductionCenter) then
        local isShow = false
        arrGifts = data:GetMaterials()
        local limits = data:GetCfg().rewardLimits
        local limitsDic = {}
        for k, v in pairs(limits) do
            limitsDic[v[1]] = v[2]
        end
        --local max = tonumber(data:GetCfg().desc2)
        for i, v in ipairs(arrGifts) do
            local item = nil
            if (i <= #rwItems) then
                item = rwItems[i]
                CSAPI.SetGOActive(item.gameObject, true)
            else
                local go = ResUtil:CreateUIGO("Grid/MatrixBuildingUIRwItem", itemParent.transform)
                item = ComUtil.GetLuaTable(go)
                item.SetItemCB(OnClickReward)
                table.insert(rwItems, item)
            end
            local max = limitsDic[v.id]
            item.Refresh1(v, max)
        end
    else
        local cur, max = data:GetCurMax()
        if (cur > 0) then
            local str = ""
            local isShow = false
            if (cfg.type == BuildsType.TradingCenter) then
                local giftsEx = data:GetData().giftsEx or {}
                for i, v in ipairs(giftsEx) do
                    if (v.bcnt > 0) then
                        isShow = true
                        break
                    end
                end
                -- str = "max"
            else
                isShow = true
                -- str = string.format("%s/%s", cur, max)
            end
            str = string.format("%s/%s", cur, max)

            if (not isShow) then
                return
            end
            local cfg = data:SetBaseCfg()
            local isRed = cfg.type ~= BuildsType.ProductionCenter and true or false
            if cfg.type == BuildsType.TradingCenter then -- 交易中心可支付才显示红点
                isRed = CheckTradingCenterRed()
            end
            local item = nil
            if (#rwItems > 0) then
                item = rwItems[1]
                CSAPI.SetGOActive(item.gameObject, true)
            else
                local go = ResUtil:CreateUIGO("Grid/MatrixBuildingUIRwItem", itemParent.transform)
                item = ComUtil.GetLuaTable(go)
                item.SetItemCB(OnClickReward)
                table.insert(rwItems, item)
            end
            item.Refresh2(str, cfg.res_icon, isRed)
        end
    end
end

-- 交易中心可支付
function CheckTradingCenterRed()
    local giftsEx = data:GetData().giftsEx
    for i, v in pairs(giftsEx) do
        if (v.bcnt > 0) then
            local cfg = Cfgs.CfgBTradeOrder:GetByID(v.id)
            if cfg then
                local cost = cfg.costs[1]
                local needCount = cost[2]
                local hadNum = BagMgr:GetCount(cost[1])
                if hadNum >= needCount then -- 可支付才会加入计算
                    return true
                end
            end
        end
    end
    return false
end

function SetRepair()
    _isAnim = _isAnim == nil and false or _isAnim
    if (buildingState ~= MatrixBuildingType.Create) then
        local cur, max = data:GetHP()
        outlineBar:SetProgress(max == 0 and 1 or cur / max)
        CSAPI.SetGOActive(hp, true)
        -- CSAPI.SetGOActive(btnRepair, cur < max)   --本次屏蔽/10月
    else
        CSAPI.SetGOActive(hp, false)
        -- CSAPI.SetGOActive(btnRepair, false)  --本次屏蔽/10月
    end
end

function SetWarning()
    local isShow = false
    if (MatrixAssualtTool:CheckIsRun()) then
        monSterIndexs = MatrixAssualtTool:GetMonSterIndexs(data:GetId())
        if (monSterIndexs and #monSterIndexs > 0) then
            CSAPI.SetText(txtWarningNum, string.format("x%s", #monSterIndexs))
            isShow = true
        end
    end
    -- CSAPI.SetGOActive(warningObj, isShow) --本次屏蔽/10月
end

-- 显隐
function SetActive()
    -- 气泡
    CSAPI.SetGOActive(itemGrids, MatrixMgr:ShowQP())
    -- 驻员
    CSAPI.SetGOActive(roleParent, MatrixMgr:ShowRole())
    -- 血量
    CSAPI.SetGOActive(hpParent, MatrixMgr:ShowHP())
end

function OnClickReward()
    if (cfg.type == BuildsType.TradingCenter) then
        CSAPI.OpenView("MatrixTrading")
    else
        BuildingProto:GetRewards({data:GetId()})
    end
end

-- 修理
function OnClickRepair()
    MatrixMgr:Repair(data)
end

-- 袭击
function OnClickWarning()
    if (MatrixAssualtTool:CheckIsRun()) then
        local monSterIndexs = MatrixAssualtTool:GetMonSterIndexs(data:GetId())
        if (monSterIndexs and #monSterIndexs > 0) then
            MatrixAssualtTool:Attack(data:GetId(), monSterIndexs[1])
        end
    end
end

function EnterAnim()
    CSAPI.SetGOActive(animObj, false)
    CSAPI.SetGOActive(animObj, true)
    -- animTimer = Time.time + 0.6
    -- animTimer = Time.time + 2
end

function OnClick()
    if(cb)then 
        cb(cfg.id,data,buildingState)
    end 
    -- cfgId = cfg.id
    -- if (cfgId == Dorm_CfgID) then
    --     CSAPI.OpenView("DormRoom") -- todo 需要后端加入建造
    -- else
    --     if (data) then
    --         -- 已建造/建造中
    --         if (buildingState == nil or buildingState ~= MatrixBuildingType.Create) then
    --             EventMgr.Dispatch(EventType.Matrix_Indoor_Change, {"MatrixBuilding", data})
    --         end
    --     else
    --         -- 未建造
    --         local isOpen, str = MatrixMgr:CheckCreate(cfgId)
    --         if (isOpen) then
    --             CSAPI.OpenView("MatrixCreateInfo", cfgId)
    --         else
    --             if (str) then
    --                 Tips.ShowTips(str)
    --             end
    --         end
    --     end
    -- end
end
