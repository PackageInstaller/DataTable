-- 点击地块时的入口
function Awake()
    cg_btnR = ComUtil.GetCom(btnR, "CanvasGroup")
end

function OnInit()
    UIUtil:AddTop2("MatrixCreateInfo", gameObject, function()
        view:Close()
    end, nil, {ITEM_ID.GOLD})
    
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Bag_Update, function()
        ShowInfo()
    end)
end
function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    cfg = Cfgs.CfgBuidingBase:GetByID(data)
    ShowInfo()
end

function ShowInfo()
    -- icon
    SetIcon()
    -- desc 
    CSAPI.SetText(txtDesc, cfg.explanation)
    local width = CSAPI.GetTextWidth(txtDesc, 30, cfg.explanation) -- 字体长度
    if (width < 1688) then
        CSAPI.ChangeChildControlWidth(descBg, true)
    end
    -- 耗时
    CSAPI.SetText(txtTime2, TimeUtil:GetTimeStr(cfg.buildTime or 0))
    -- 金币
    isEnough = true

    local max = BagMgr:GetCount(ITEM_ID.GOLD)
    local goldCount = cfg.costs ~= nil and cfg.costs[1][2] or 0
    isEnough = max >= goldCount
    local str = StringUtil:SetByColor(goldCount, isEnough and "FFFFFF" or "FF381E")
    CSAPI.SetText(txtSpend2, str)

    -- 指挥塔等级，玩家等级 
    local b, str1 = MatrixMgr:CheckCreate(data)
    CSAPI.SetGOActive(needLv, str1 ~= "")
    if (str1 ~= "") then
        CSAPI.SetText(txtNeedLv, str1)
        local code = b and "00ffbf" or "ff8790"
        -- CSAPI.SetImgColorByCode(needLv, code)
        CSAPI.SetTextColorByCode(txtNeedLv, code)
    end
    if (not b) then
        isEnough = false
    end
    -- bnt 
    cg_btnR.alpha = isEnough and 1 or 0.3
end

function SetIcon()
    local iconName = cfg.icon
    if (iconName) then
        ResUtil.MatrixBuilding:Load(icon, iconName, true)
    end
end

function OnClickL()
    view:Close()
end

function OnClickR()
    if (isEnough) then
        BuildingProto:BuildCreate(cfg.id, {0, 0})
        view:Close()
    end
end

