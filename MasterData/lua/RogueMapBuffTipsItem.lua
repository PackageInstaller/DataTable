local data = nil
local cfg = nil
local image = nil

function Awake()
    SetSelect(false)
    image = ComUtil.GetCom(gameObject,"Image")
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    isSel = b
    CSAPI.SetGOActive(selImg,b)
end

function Refresh(_data,isClick)
    data = _data
    if not IsNil(image) then
        image.raycastTarget = isClick
    end
    if data then
        cfg = Cfgs.BufferConfig:GetByID(data.id)
        SetIcon()
        SetName()
        SetDesc()
        SetRound()
    else
        SetEmpty()
    end
end

function SetIcon()
    if cfg.icon then
        ResUtil.RogueMapBuff:Load(icon,cfg.icon)
    end
    if cfg.icon_Type then
        ResUtil.RogueBuff:Load(iconBg,cfg.icon_Type)
    end
end

function SetName()
    CSAPI.SetText(txtName,cfg.name)
end

function SetDesc()
    CSAPI.SetText(txtDesc,cfg.desc)
end

function SetRound()
    CSAPI.SetGOActive(txtRound,true)
    CSAPI.SetText(txtRound,data.num  .. "")
end

function SetEmpty()
    CSAPI.SetGOActive(txtRound,false)
    LanguageMgr:SetText(txtName,76071)
end

function OnClick()
    if cb then
        cb(this)
    end
end