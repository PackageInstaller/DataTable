function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/Grid/GridItem", LayoutCallBack, true, 0.5)
end
function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetClickCB(GridRewardGridFunc)
        lua.Refresh(_data)
        lua.SetCount(0)
    end
end

-- AllGameplayCfg
function Refresh(_cfg)
    cfg = _cfg
    CSAPI.SetText(txtName1, cfg.name)
    CSAPI.SetText(txtName2, cfg.enName)
    CSAPI.SetText(txtDesc, cfg.desc)
    CSAPI.LoadImg(icon, "UIs/AllGameplay/" .. cfg.icon .. ".png", true, nil, true)
    -- btn
    CSAPI.SetGOActive(btnS, cfg.jumpID ~= nil)

    curDatas = GridUtil.GetGridObjectDatas2(cfg.rewards)
    layout:IEShowList(#curDatas)
end

function OnClickGO()
    if (cfg.jumpID) then
        JumpMgr:Jump(cfg.jumpID)
    end
end
