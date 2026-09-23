local id

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
    CSAPI.SetGOActive(imgOn,isSelect)
    -- icon 
    local isShowName = true
    if (cfg.sortIcon) then
        local sortIcon = cfg.sortIcon[1] -- json 
        isShowName = sortIcon[1] == 1
        CSAPI.LoadImg(imgIcon, "UIs/Icons/" .. sortIcon[2] .. ".png", true, nil, false)
        CSAPI.SetGOActive(iconNode, true)
        CSAPI.SetScale(imgIcon, sortIcon[3], sortIcon[3], sortIcon[3])
    else
        CSAPI.SetGOActive(iconNode, false)
    end
    CSAPI.SetGOActive(txtAll,isShowName);
    -- text 
    if (isShowName) then
        CSAPI.SetImgColorByCode(imgIcon,isSelect and "1f1f1f" or "ffffff")
        CSAPI.SetText(txtAll, cfg.sName)
        local code1 =isSelect and "1f1f1f" or "ffffff"
        CSAPI.SetTextColorByCode(txtAll, code1)
    end
end

function OnClick()
    cb(id)
end

