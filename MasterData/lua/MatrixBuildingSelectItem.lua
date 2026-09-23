function Awake()
    cg_node = ComUtil.GetCom(clickNode, "CanvasGroup")
end
function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _curIndex)
    data = _data
    isSelect = index == _curIndex
    isRoom = data.data == nil -- 是宿舍
    local sName = isRoom and LanguageMgr:GetByID(32065) or data:GetBuildingName()
    local sName2 = isRoom and LanguageMgr:GetByType(32065, 4) or data:GetBuildingName(true)
    CSAPI.SetText(txtName, sName)
    CSAPI.SetText(txtName2, sName2)
    -- icon
    local icon_small = isRoom and "btn_36_01" or data:SetBaseCfg().icon_small
    ResUtil.MatrixIcon:Load(icon, icon_small)

    -- red
    local isRed = false
    if (not isRoom) then
        isRed = data:CheckIsRed()
    end
    UIUtil:SetRedPoint(redPoint, isRed)
    -- 
    cg_node.alpha = isSelect and 1 or 0.5
end

function OnClick()
    if (not isSelect and cb) then
        cb(index)
        --view:Close()
    end
end
