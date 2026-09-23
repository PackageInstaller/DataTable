--集合按钮
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
    -- icon 
    local isShowName = true
    local cfg=Cfgs.CfgSkinSetInfo:GetByID(id)
    if (cfg) then
        ResUtil.SkinSetIcon:Load(icon, cfg.icon.."_w")
        CSAPI.SetGOActive(icon, true)
    else
        CSAPI.SetGOActive(icon, false)
    end
    CSAPI.SetGOAlpha(node,isSelect and 1 or 0.5)
    -- text 
    if (isShowName) then
        CSAPI.SetText(txt_name, cfg.name)
    end
end

function OnClickSelf()
    cb(id)
end

