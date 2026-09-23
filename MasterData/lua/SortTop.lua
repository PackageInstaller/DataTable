local id, cb = nil, nil

function Init(_id, _cb)
    id = _id
    cb = _cb

    Refresh()
end

function OnDestroy()
    SortMgr:ClearData(id)
end

function Refresh()
    data = SortMgr:GetData(id)
    -- L 
    local lCfg = Cfgs.CfgSortInfo:GetByID(data.SortId)
    CSAPI.LoadImg(imgL, "UIs/Sort/" .. lCfg.icon .. ".png", false, nil, true)
    CSAPI.SetText(txtL, lCfg.sName)
    -- ud 
    SetUD()
    -- R
    CSAPI.SetGOActive(btnR, data.Filter ~= nil)
    if (data.Filter) then
        local isFilter = SortMgr:CheckIsFilter(id)
        local imgName = isFilter and "btn_01_03.png" or "btn_01_01.png"
        CSAPI.LoadImg(btnR, "UIs/Sort/" .. imgName, false, nil, true)
        local code = isFilter and "000000" or "ffffff"
        CSAPI.SetImgColorByCode(imgR, code, true)
        CSAPI.SetTextColorByCode(txtR, code)
        local id = isFilter and 43002 or 43001
        LanguageMgr:SetText(txtR, id)
    end
    -- btnL位置 
    local x = data.Filter ~= nil and -114 or 114
    CSAPI.SetAnchor(btnL, x, 0, 0)
end

function SetUD()
    local imgName = data.UD == 1 and "btn_01_05.png" or "btn_01_04.png"
    CSAPI.LoadImg(arrow, "UIs/Sort/" .. imgName, false, nil, true)
end

function OnClickL()
    CSAPI.OpenView("SortPanel", this)
end

function OnClickR()
    CSAPI.OpenView("SortFilterPanel", this)
end

function OnClickUD()
    data.UD = data.UD == 1 and 2 or 1
    SetUD()
    if (cb) then
        cb()
    end
end

-- 获取 CfgSortFilter 的id 
function GetID()
    return id
end

-- 排序 筛选 回调
function SelectCB()
    Refresh()
    if (cb) then
        cb()
    end
end
