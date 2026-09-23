function Awake()
    -- 记录
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/ResRecovery/ResRecoveryItem", LayoutCallBack, true)

    -- eventMgr = ViewEvent.New()
    -- eventMgr:AddListener(EventType.HuiGui_Res_Recovery, function()
    --     isGain = RegressionMgr:CheckResRecoveryIsGain()
    --     CSAPI.SetGOAlpha(btnS, isGain and 0.3 or 1)
    -- end)
end

-- function OnDestroy()
--     eventMgr:ClearListener()
-- end

local elseData = {}
function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data, elseData)
    end
end

function OnOpen()
    --
    isGain = RegressionMgr:CheckResRecoveryIsGain()
    -- 
    local leaveDay = RegressionMgr:LeaveDay()
    cfg = Cfgs.CfgResourcesRecovery:GetByID(leaveDay)
    if (not cfg) then
        view:Close()
        return
    end
    cost = cfg.cost
    SetItems()
    -- txtDesc2
    itemCfg = Cfgs.ItemInfo:GetByID(cost[1])
    LanguageMgr:SetText(txtDesc2, 22037, itemCfg.name)
    -- 折扣
    ResUtil.IconGoods:Load(icon, itemCfg.icon)
    CSAPI.SetGOActive(imgNum, cfg.discount ~= nil)
    
    if (cfg.discount ~= nil) then
        local tens = math.floor(cfg.discount / 10)
        local ones = cfg.discount % 10
        CSAPI.SetText(txtCount, cost[2] .. "")
        local imgName1 = "img_05_0" ..tens 
        CSAPI.LoadImg(imgNum1, "UIs/ResRecovery/" .. imgName1 .. ".png", true, nil, true)
        local imgName2 = "img_05_0" ..ones 
        CSAPI.LoadImg(imgNum2, "UIs/ResRecovery/" .. imgName2 .. ".png", true, nil, true)
    end
    -- btn 
    CSAPI.SetGOAlpha(btnS, isGain and 0.3 or 1)
end

function SetItems()
    items = items or {}
    -- local rewardCfg = Cfgs.RewardInfo:GetByID(cfg.rewards)
    curDatas = cfg.rewards -- rewardCfg.item
    layout:IEShowList(#curDatas)
end

function OnClickMask()
    -- view:Close()
end

function OnClickS()
    if (not isGain) then
        local str = string.format("%s%s", cost[2], itemCfg.name)
        local content = LanguageMgr:GetByID(22041, str)
        UIUtil:OpenDialog(content, function()
            local proto = {"RegressionProto:ResourcesRecoveryGain"}
            NetMgr.net:Send(proto)
            view:Close()
        end)
    end
end

function OnClickClose()
    view:Close()
end

function OnClickVirtualkeysClose()
    view:Close()
end
