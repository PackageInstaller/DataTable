function Awake()
    sd_slider = ComUtil.GetCom(sd, "Slider")
end
function Refresh(_AccuChargeData, _cb)
    data = _AccuChargeData
    cb = _cb
    -- desc
    CSAPI.SetText(txtMoney, math.floor(data:GetCfg().money / 100) .. "")
    -- slider 
    local cur, max = data:GetNums()
    sd_slider.value = cur / max
    CSAPI.SetText(txtSlider, string.format("%s/%s", cur, max))
    -- btns 
    sortType = data:GetSortType()
    CSAPI.SetGOActive(objSuccess, sortType == 0)
    CSAPI.SetGOActive(btnFinish, sortType == 2)
    CSAPI.SetGOActive(btnGo, sortType == 1)
    CSAPI.SetGOActive(mask, sortType == 0)
    -- items 
    items = items or {}
    -- if (item) then
    --     item.Refresh(data:GetCfg().jAwardId[1])
    -- else
    --     ResUtil:CreateUIGOAsync("AccuCharge/AccuChargeGridItem", itemParent, function(go)
    --         item = ComUtil.GetLuaTable(go)
    --         item.Refresh(data:GetCfg().jAwardId[1])
    --     end)
    -- end
    local datas = data:GetCfg().jAwardId
    ItemUtil.AddItems("AccuCharge/AccuChargeGridItem", items, datas, itemParent)
    -- red 
    UIUtil:SetRedPoint(node, sortType == 2, 458, 76, 0)
end

function OnClickFinish()
    if (sortType == 2 and cb) then
        CSAPI.SetGOActive(btnFinish, false)
        cb(this)
    end
end

function OnClickGO()
    JumpMgr:Jump(140004)
end
