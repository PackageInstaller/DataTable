function Awake()
    clickNode_cg = ComUtil.GetCom(clickNode, "CanvasGroup")
    as = ComUtil.GetCom(select,"ActionScale")
    af = ComUtil.GetCom(select,"ActionFade")
end

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

-- CfgMenuBg
function Refresh(_data, _curID,_useID)
    data = _data
    local cfg = data:GetCfg()
    -- icon 
    if (cfg and cfg.icon) then
        ResUtil.BGIcon:Load(icon, cfg.icon, true)
    end
    -- name 
    CSAPI.SetText(txtName, cfg.sName)
    -- select 
    CSAPI.SetGOActive(select, cfg.id == _curID)
    -- use 
    CSAPI.SetGOActive(use, cfg.id == _useID)
    -- lock 
    CSAPI.SetGOActive(lock, not data:IsGet())
    -- 
    clickNode_cg.alpha = data:IsGet() and 1 or 0.5
end

function Anim()
    as:ToPlay()
    af:ToPlay()
end

function OnClick()
    Anim()
    if (cb) then
        cb(data)
    end
end
