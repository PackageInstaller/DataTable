local id

function Awake()
    cg_icon = ComUtil.GetCom(icon, "CanvasGroup")
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(cfg, curSelectDatas)
    id = cfg.id

    -- select
    isSelect = false
    for k, v in ipairs(curSelectDatas) do
        if (id == v) then
            isSelect = true
            break
        end
    end
    -- bg 
    local bgName = isSelect and "btn_01_02.png" or "btn_01_01.png"
    CSAPI.LoadImg(bg, "UIs/Sort/" .. bgName, false, nil, true)
    -- icon 
    local isShowName = true
    if (cfg.sortIcon) then
        local sortIcon = cfg.sortIcon[1] -- json 
        isShowName = sortIcon[1] == 1
        CSAPI.LoadImg(icon, "UIs/Icons/" .. sortIcon[2] .. ".png", true, nil, false)
        CSAPI.SetGOActive(iconParent, true)
        CSAPI.SetScale(icon, sortIcon[3], sortIcon[3], sortIcon[3])
        cg_icon.alpha = isSelect and 1 or sortIcon[4]
    else
        CSAPI.SetGOActive(iconParent, false)
    end
    -- text 
    CSAPI.SetGOActive(txtName, isShowName)
    if (isShowName) then
        CSAPI.SetText(txtName, cfg.sName)
        local code1 = isSelect and "ffc146" or "929296"
        CSAPI.SetTextColorByCode(txtName, code1)
    end
end

function OnClick()
    cb(id)
end

