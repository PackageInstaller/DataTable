local cfg = nil
local isEmpty = false
local ids = {380077,380078,380079,380050}
local textMove = nil

function Awake()
    textMove = ComUtil.GetCom(ImageName,"TextMove")
    InitAnim()
    SetSelect(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    CSAPI.SetGOActive(selImg,b)
    CSAPI.SetGOActive(selImg2,b and not isEmpty)
    if b then
        SetDesc()
    end
end

function Refresh(_data)
    cfg = _data
    if cfg then
        isEmpty = cfg.isEmpty
        SetIcon()
        SetBuff()
        SetReward()
    end
end

function SetIcon()
    local iconName = "icon_05_0" .. index
    if isEmpty then
        iconName = "icon_05_00"
    end
    ResUtil.VirCat:Load(icon,iconName)
end

function SetBuff()
    CSAPI.SetGOActive(txtBg,not isEmpty)
    if not isEmpty then
        CSAPI.SetText(txtBuff,cfg.name)
        -- if not IsNil(textMove) then
        --     textMove:SetText(cfg.name)
        -- end
    end
end

function SetReward()
    LanguageMgr:SetText(txtReward,ids[index])
end

function SetDesc()
    CSAPI.SetText(txtDesc, cfg.desc)
end

function OnClick()
    if cb then
        cb(this)
    end
end

function GetBuffID()
    return cfg and cfg.id or 0
end

local anim = nil
function InitAnim()
    anim = ComUtil.GetCom(node,"Animator")
end

function PlayAnim(str)
    if not IsNil(anim) then
        anim:Play(str)
    end
end

function SetSelAnim(b)
    SetSelect(b)
    if b then
        PlayAnim("item_sel")
    else
        PlayAnim("item_Nsel")
    end
end
