function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_cfg, lv1, s1, _nType)
    cfg = _cfg
    nType = _nType

    local isGet = lv1 >= index
    local isSuccess = cfg.points <= s1

    local id = cfg.reward[1][1]
    itemData = BagMgr:GetFakeData(id, BagMgr:GetCount(id))

    alpha = 0.5
    if (isSuccess and not isGet) then
        alpha = 1
    end
    CSAPI.SetGOAlpha(iconBg, alpha)
    -- frame
    local frameName = alpha == 1 and "img_17_02.png" or "img_17_01.png"
    CSAPI.LoadImg(frame, "UIs/RogueT/" .. frameName, true, nil, true)
    -- iconbg
    ResUtil.IconGoods:Load(iconBg, GridFrame[itemData:GetQuality() or 1])
    -- icon
    itemData:GetIconLoader():Load(icon,itemData:GetIcon())
    -- ResUtil.IconGoods:Load(icon, itemData:GetIcon())
    -- count 
    CSAPI.SetText(txt_count, cfg.reward[1][2] .. "")
    -- num
    if (nType == 1) then
        CSAPI.SetText(txtNum, index .. "")
    else
        CSAPI.SetText(txtNum, cfg.points .. "")
    end
    -- success
    CSAPI.SetGOActive(success1, isGet)
    CSAPI.SetGOActive(success2, isSuccess)
    -- red
    UIUtil:SetRedPoint(parent, alpha, 85.5, 89.5, 0)
    --
    local frameName = alpha == 1 and "img_18_02.png" or "img_18_01.png"
    CSAPI.LoadImg(down, "UIs/RogueT/" .. frameName, true, nil, true)
    --
    CSAPI.SetGOActive(bezel, alpha == 1)
end

function OnClick()
    if (nType == 1) then
        cb(alpha,index)
    else
        if (alpha == 1) then
            cb()
        else
            GridRewardGridFunc({
                data = itemData
            })
        end
    end
end
