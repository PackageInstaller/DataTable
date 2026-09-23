function Awake()
    cg_node = ComUtil.GetCom(clickNode, "CanvasGroup")
end
function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

-- {v.id, q, isSelect}
function Refresh(_data)
    data = _data
    childCfg = data[2]
    isSelect = data[3]
    fid = data[4]
    local sName = LanguageMgr:GetByID(32002) .. childCfg.roomName
    local sName2 = LanguageMgr:GetByType(32002, 4)
    CSAPI.SetText(txtName, sName)
    CSAPI.SetText(txtName2, sName2)
    -- icon
    ResUtil.MatrixIcon:Load(icon, "btn_2_21")
    -- 
    cg_node.alpha = isSelect and 1 or 0.5

    -- 
    isRed = false
    if (not fid and data[1] == 2 and DormMgr:CheckNewRoomRedNum()) then
        isRed = true
    end
    UIUtil:SetRedPoint(clickNode, isRed, 103, 25, 0)
end

function OnClick()
    if (isRed) then
        DormMgr:SetNewRoomRedNum()
    end
    if (not isSelect and cb) then
        cb(index)
    end
end
