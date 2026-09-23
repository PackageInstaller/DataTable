local MatrixCompoundData = require "MatrixCompoundData"
local mDatas1 = {} -- 已选择的物品
local count = 1 -- 数量
local maxCount = 0 -- 可购买的最大数量
local oldLen = 1

function Awake()
    UIUtil:AddTop2("MatrixCompoundDetail", gameObject, function()
        view:Close()
    end, nil, {ITEM_ID.GOLD})

    cg_btnS = ComUtil.GetCom(btnS, "CanvasGroup")
    --cv_middle = ComUtil.GetCom(middle, "Canvas")

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Dorm_SetRoleList, RefreshPanel)
    eventMgr:AddListener(EventType.Matrix_Compound_Success, function(proto)
        RefreshPanel()
        ShowRewardPanel(proto)
    end)
    -- 物品更新
    eventMgr:AddListener(EventType.Bag_Update, RefreshPanel)
    
    -- 界面打开关闭
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end

function OnDestroy()
    eventMgr:ClearListener()
end

-- data MatrixCompoundData
function OnOpen()
    buildingData = MatrixMgr:GetBuildingDataByType(BuildsType.Compound)
    table.insert(mDatas1, data)
    RefreshPanel()
end

function RefreshPanel()
    curData = mDatas1[#mDatas1]
    -- 计算最大数量
    CalMaxCount()
    -- 重置数量
    if (oldID == nil or oldID ~= curData:GetID()) then
        count = 1
        oldID = curData:GetID()
    end

    -- left 
    SetLeft()
    -- middle
    SetMiddle()
    -- right 
    SerRight()
end

function SetLeft()
    -- role 
    local roleIDs = buildingData:GetRoles()
    cRoleInfo = roleIDs[1] and CRoleMgr:GetData(roleIDs[1]) or nil
    CSAPI.SetGOActive(imgEmptyRole, cRoleInfo == nil)
    if (cRoleInfo) then
        if (not roleItem) then
            ResUtil:CreateUIGOAsync("CRoleItem/CRoleItem", rolePoint, function(go)
                roleItem = ComUtil.GetLuaTable(go)
                roleItem.Refresh2(cRoleInfo)
                roleItem.SetClickCB(ItemClickCB)
                SetRoleItemAnim()
            end)
        else
            roleItem.Refresh2(cRoleInfo)
            CSAPI.SetGOActive(roleItem.gameObject, true)
            SetRoleItemAnim()
        end
    else
        if (roleItem) then
            CSAPI.SetGOActive(roleItem.gameObject, false)
        end
    end
    -- 概率 
    local num1 = 0
    if (cRoleInfo) then
        num1 = curData:GetCfg().baseSupRewardPer
    end
    local num2 = buildingData:GetCompoundNum(curData:GetCfg().group)
    local str2 = num2 > 0 and StringUtil:SetByColor("+" .. num2 .. "%", "ffc146") or ""
    CSAPI.SetText(txtRate, num1 .. "%" .. str2)
    -- desc  
    local desc = LanguageMgr:GetByID(10432)
    if (cRoleInfo) then
        local cfg = cRoleInfo:GetAbilityCurCfg()
        desc = cfg and cfg.desc or ""
    end
    CSAPI.SetText(txtSkillDesc, desc)
end

function SetRoleItemAnim()
    local curID = roleItem.curData:GetID()
    if (oldID1 == nil or oldID1 ~= curID) then
        UIUtil:SetObjFade(roleItem.gameObject, 0, 1, nil, 300, 1, 0)
    end
    oldID1 = curID
end

function ItemClickCB()
    CSAPI.OpenView("DormSetRoleList", {buildingData:GetID()})
end

function SetMiddle()
    -- top
    mItems1 = mItems1 or {}
    mDatas1 = mDatas1 or {}
    ItemUtil.AddItems("Compound/MatrixCompoundDetailItem", mItems1, mDatas1, mGrids1, MItem1CB, 1, {oldLen, #mDatas1})
    oldLen = #mDatas1
    -- get 
    SetGetCount()
    -- pay 
    payItems = payItems or {}
    ResUtil:CreateCfgRewardGrids(payItems, curData:GetMat3(), mGrids2, PayItemClickCB, SetDownCount)
end

function PayItemClickCB(tab)
    if (not tab or not tab.data) then
        return
    end
    local id = tab.data:GetID()
    local _cfg = Cfgs.CfgBCompoundOrder:GetByID(id)
    if (_cfg) then
        for k, v in ipairs(mDatas1) do
            if (_cfg.id == v:GetID()) then
                LanguageMgr:ShowTips(2306)
                return
            end
        end
        local _data = MatrixCompoundData.New()
        _data:SetData(_cfg)
        table.insert(mDatas1, _data)
        RefreshPanel()
    else
        GridRewardGridFunc(tab)
    end
end

function SetGetCount()
    local rewardData = curData:GetFakeRewardData()
    if (not rewardItem) then
        local go, _rewardItem = ResUtil:CreateGridItem(middle.transform)
        rewardItem = _rewardItem
    end
    rewardItem.Refresh(rewardData)
    rewardItem.SetCount(curData:GetRewarCount(count))
    rewardItem.SetClickCB(GridClickFunc.OpenInfo)
end

function SetDownCount()
    local _mats = curData:GetCfg().materials
    for k, v in ipairs(payItems) do
        if (v.data) then
            local need = _mats[k][2] * count -- v.data:GetCount() * count
            local had = BagMgr:GetCount(v.data:GetID())
            local str = UIUtil:GetDownStr(had, need)
            v.SetDownCount(str)
        end
    end
end

function MItem1CB(index)
    local len = #mDatas1
    for k = len, 1, -1 do
        if (k > index) then
            table.remove(mDatas1, len)
        end
    end
    RefreshPanel()
end

function SerRight()
    -- count
    CSAPI.SetText(txtCount, count .. "")
    -- spends 1
    ResUtil.Face:Load(imgIcon1, "face1")
    if (cRoleInfo) then
        local need1 = math.abs(curData:GetCfg().tiredVal * count)
        local had1 = cRoleInfo:GetCurRealTv()
        local str1 = need1 > had1 and StringUtil:SetByColor(need1, "ff6565") or need1
        CSAPI.SetText(txtNum1, str1 .. "")
        -- tips
        if (not tipsStr) then
            tipsStr = LanguageMgr:GetByID(10425)
            CSAPI.SetText(txtTips, "            " .. tipsStr)
        end
        CSAPI.SetGOActive(txtTips, need1 > had1)
    else
        CSAPI.SetText(txtNum1, "0")
        CSAPI.SetGOActive(txtTips, false)
    end
    -- spends 2
    local id = curData:GetCfg().cost[1][1]
    local _cfg = Cfgs.ItemInfo:GetByID(id)
    ResUtil.IconGoods:Load(imgIcon2, _cfg.icon .. "_1")

    local need = curData:GetPriceNum() * count
    local max = BagMgr:GetCount(id)
    local str = need > max and StringUtil:SetByColor(need, "ff6565") or need
    CSAPI.SetText(txtNum2, str .. "")
    -- btn
    cg_btnS.alpha = count <= maxCount and 1 or 0.3
end

-- 计算最大可合成数量
function CalMaxCount()
    local maxCount1 = curData:CalMatMaxCount()
    local maxCount2 = curData:CalCostMaxCount()
    maxCount = maxCount1 < maxCount2 and maxCount1 or maxCount2
end

function OnClickRolePoint()
    CSAPI.OpenView("DormSetRoleList", {buildingData:GetID()})
end

function CountChange()
    SetGetCount()
    SetDownCount()
    SerRight()
end

function OnClickMin()
    if (count ~= 1) then
        count = 1
        CountChange()
    else
        LanguageMgr:ShowTips(2309)
    end
end

function OnClickRemove()
    if (count > 1) then
        count = count - 1
        CountChange()
    else
        LanguageMgr:ShowTips(2309)
    end
end

function OnClickAdd()
    if (count < maxCount) then
        count = count + 1
        CountChange()
    else
        LanguageMgr:ShowTips(2308)
    end
end

function OnClickMax()
    if (maxCount > 0 and count ~= maxCount) then
        count = maxCount
        CountChange()
    else
        LanguageMgr:ShowTips(2308)
    end
end

function OnClickS()
    if (count <= maxCount) then
        BuildingProto:Combine(buildingData:GetID(), curData:GetID(), count)
    end
end
-- 合成成功奖励回调
function ShowRewardPanel(proto)
    if (proto.sub_rewards and #proto.sub_rewards > 0) then
        CSAPI.OpenView("MatrixCompoundReward", proto)
    elseif (proto.rewards and #proto.rewards > 0) then
        UIUtil:OpenReward({proto.rewards})
    end
end

function OnViewOpened(viewKey)
    if (viewKey == "RewardPanel" or viewKey == "GoodsFullInfo" or viewKey == "GoodsFullInfo2" or viewKey=="MatrixResPanel" or "MatrixCompoundReward") then
        --cv_middle.overrideSorting = false
        CSAPI.SetGOActive(objTx, false)
    end
end

function OnViewClosed(viewKey)
    if(CSAPI.IsViewOpen("MatrixResPanel")) then 
        return
    end 
    if (viewKey == "RewardPanel" or viewKey == "GoodsFullInfo" or viewKey == "GoodsFullInfo2" or viewKey=="MatrixResPanel" or "MatrixCompoundReward") then
        --cv_middle.overrideSorting = true
        CSAPI.SetGOActive(objTx, true)
    end
end
