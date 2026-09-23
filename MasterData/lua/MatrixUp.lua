local noEnoughData = {}
local isEnough = true
local grids = {}
local tipStr = ""
-- function Awake()
--     cg_btnR = ComUtil.GetCom(btnR, "CanvasGroup")
-- end

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
    ShowInfo()
end

function ShowInfo()
    cfg = data:GetCfg()
    baseCfg = data:SetBaseCfg()
    nextCfg = data:GetNextCfg()
    -- icon
    SetIcon()
    -- desc
    CSAPI.SetText(txtDesc, baseCfg.explanation)
    local width = CSAPI.GetTextWidth(txtDesc, 30, baseCfg.explanation) -- 字体长度
    if (width < 1056) then
        CSAPI.ChangeChildControlWidth(descBg, true)
    end
    -- lv
    CSAPI.SetText(txtLv2, "" .. cfg.id)
    CSAPI.SetText(txtLv4, "" .. nextCfg.id)
    -- items
    SetItems()
    -- 升级消耗
    SetMaterials()
    -- 耗时
    CSAPI.SetText(txtTime, TimeUtil:GetTimeStr(cfg.upTime or 0))
    -- btn 
    --cg_btnR.alpha = isEnough and 1 or 0.3
end

function SetItems()
    -- datas
    local datas = {}
    -- 耐久
    -- if (cfg.maxHp) then
    --     table.insert(datas, {10049, cfg.maxHp, nextCfg.maxHp})
    -- end
    -- 电力
    local _id = cfg.powerVal > 0 and 10050 or 10051
    table.insert(datas, {_id, cfg.powerVal, nextCfg.powerVal})
    -- 驻员
    table.insert(datas, {10052, cfg.roleLimit, nextCfg.roleLimit})
    -- 订单
    if (data:GetType() == BuildsType.TradingCenter) then
        table.insert(datas, {10053, cfg.orderNumLimit, nextCfg.orderNumLimit})
    elseif (data:GetType() == BuildsType.ProductionCenter) then -- 生产中心
        table.insert(datas, {10453, cfg.desc2, nextCfg.desc2})
    end
    items = items or {}
    ItemUtil.AddItems("Matrix/MatrixUpItem", items, datas, grid)
end

function SetIcon()
    local iconName = baseCfg.icon
    if (iconName) then
        ResUtil.MatrixBuilding:Load(icon, iconName, true)
    end
end

-- 设置素材 
function SetMaterials()
    noEnoughData = {}
    isEnough = true
    grids = grids or {}
    for i, v in ipairs(grids) do
        CSAPI.SetGOActive(v.gameObject, false)
    end
    local costs = cfg.upCosts
    if (costs) then
        local count = 1
        for i, v in ipairs(costs) do
            -- 过滤金币
            if (v[1] ~= ITEM_ID.GOLD) then
                local item = nil
                if (count <= #grids) then
                    item = grids[count]
                    CSAPI.SetGOActive(item.gameObject, true)
                else
                    local go, _item = ResUtil:CreateGridItem(materialList.transform)
                    item = _item
                    table.insert(grids, item)
                end
                local num = BagMgr:GetCount(v[1])
                local fodderData = BagMgr:GetFakeData(v[1], num)
                item.Refresh(fodderData)
                item.SetClickCB(GridClickFunc.OpenInfo);

                local str = ""
                if (v[2] > num) then
                    str = StringUtil:SetByColor(num, "FF381E")
                    noEnoughData[1] = v[1]
                    noEnoughData[2] = v[2] - num
                    isEnough = false
                else
                    str = StringUtil:SetByColor(num, "65ffb1")
                end
                item.SetDownCount(str .. "/" .. v[2])
                count = count + 1
            else
                goldCount = v[2]
                local max = BagMgr:GetCount(ITEM_ID.GOLD)
                local str = StringUtil:SetByColor(v[2], v[2] <= max and "FFFFFF" or "FF381E")
                CSAPI.SetText(txtSpend2, str)
                if (goldCount > max) then
                    if(isEnough)then 
                        noEnoughData[1] = ITEM_ID.GOLD
                        noEnoughData[2] = goldCount - max
                    end 
                    isEnough = false
                end
            end
        end
    end

    -- 玩家等级 
    local b, lv = data:CheckPlayerLv()
    local lanId = 10043
    if (b) then
        -- 指挥塔等级 
        lanId = 10044
        b, lv = data:CheckUpLv()
    end
    CSAPI.SetGOActive(needLv, lv ~= nil)
    if (lv ~= nil) then
        tipStr = LanguageMgr:GetByID(lanId, lv)
        CSAPI.SetText(txtNeedLv, tipStr)  
        --LanguageMgr:SetText(txtNeedLv, lanId, lv)
        local code = b and "00ffbf" or "ff8790"
        -- CSAPI.SetImgColorByCode(needLv, code)
        CSAPI.SetTextColorByCode(txtNeedLv, code)
    end
    if (not b) then
        isEnough = false
    end
end

function OnClickR()
    if (not isEnough) then
        if (noEnoughData[1] ~= nil) then
            local goodsData = BagMgr:GetFakeData(noEnoughData[1])
            UIUtil:OpenGoodsInfo(goodsData, nil, noEnoughData[2])
        else 
            Tips.ShowTips(tipStr)
        end
        return
    end
    BuildingProto:Upgrade(data:GetId())
    view:Close()
end

function OnClickL()
    view:Close()
end
