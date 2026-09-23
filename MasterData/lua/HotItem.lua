local calTime = false
local endTimer = 0
local timer = 0

function Awake()
    btns_cg = ComUtil.GetCom(btnS, "CanvasGroup")
end

function SetIndex(_index)
    index = _index
end

function Update()
    if (calTime and Time.time > timer) then
        timer = Time.time + 1
        SetTime()
    end
end

function Refresh(_id)
    calTime = false
    endTimer = 0

    id = _id
    count = BagMgr:GetCount(id)
    bagData = BagMgr:GetFakeData(id)
    -- icon,count
    CSAPI.SetGOActive(countObj, index ~= 1)
    if (index ~= 1) then
        ResUtil.IconGoods:Load(icon, bagData:GetIcon())
        CSAPI.SetText(txt_count, count .. "")
    end
    -- name
    SetName()
    -- desc
    CSAPI.SetText(txtDesc, bagData:GetDesc())
    -- time
    if (index ~= 1) then
        endTimer = 0 -- todo 过期时间
        if (endTimer ~= 0 and endTimer <= TimeUtil:GetTime()) then
            CSAPI.SetGOActive(gameObject, false)
            return
        end
    end
    calTime = endTimer > TimeUtil:GetTime() and true or false
    CSAPI.SetGOActive(txtTime, calTime)
    CSAPI.SetGOActive(objTime, calTime)
    -- btn
    if (index == 1) then
        SetBtn1()
    else
        SetBtn2()
    end
end

function SetName()
    local str1, str2, str3 = "", "", ""
    if (index == 1) then
        buyCur, buyMax = PlayerClient:HotBuyCnt()
        str1 = LanguageMgr:GetByID(35004)
        str2 = LanguageMgr:GetByID(35005, buyCur, buyMax)
        local costCfg = PlayerClient:GetHotCostCfg()
        str3 = StringUtil:SetByColor("+" .. costCfg.hot, "ffc146") .. LanguageMgr:GetByID(35018)
    else
        str1 = bagData:GetName()
        str2 = bagData:GetDesc()
    end
    CSAPI.SetText(txtName, str)
    CSAPI.SetText(txtDesc1, str2)
    CSAPI.SetText(txtDesc2, str3)
end

-- 限时道具
function SetTime()
    local needTime = endTimer - TimeUtil:GetTime()
    if (needTime <= 0) then
        calTime = false
        CSAPI.SetGOActive(gameObject, false)
        return
    end

    local timeStr = ""
    if (needTime <= 3600) then
        timeStr = math.ceil(needTime / 60) .. LanguageMgr:GetByID(11011)
    elseif (needTime <= 86400) then
        timeStr = math.ceil(needTime / 3600) .. LanguageMgr:GetByID(11009)
    else
        timeStr = math.ceil(needTime / 86400) .. LanguageMgr:GetByID(11010)
    end
    local str1 = LanguageMgr:GetByID(17000)
    CSAPI.SetText(txtTime, str1 .. "  " .. timeStr)
end

-- 购买
function SetBtn1()

    local b = true
    local curHot = PlayerClient:Hot()
    local maxHot1, maxHot2 = PlayerClient:MaxHot()
    if (curHot < maxHot2) then
    end
    LanguageMgr:SetText(txtS1, 1007)
    LanguageMgr:SetEnText(txtS2, 1007)
    btns_cg.alpha = buyCur >= buyMax and 0.3 or 1
end

-- 使用
function SetBtn2()
    LanguageMgr:SetText(txtS1, 1032)
    LanguageMgr:SetEnText(txtS2, 1032)

    btns_cg.alpha = count <= 0 and 0.3 or 1
end

function OnClickSure()
    if (index == 1) then
        if (buyCur >= buyMax) then
            LanguageMgr:ShowTips(23001) -- 已达到本日购买上限，无法继续购买
        else
            CSAPI.OpenView("HotBuyPanel") -- 购买体能界面
        end
    else
        -- CSAPI.OpenView("HotUsePanel", bagData) --体能使用界面
        if(count <= 0) then 
            LanguageMgr:ShowTips(8006)
        else 
            UIUtil:OpenGoodsInfo(bagData)
        end 
    end
end
