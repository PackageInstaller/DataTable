local flyTime = nil
local timeCD = nil
local anim_obj
local anim_img

function Awake()
    anim_obj = ComUtil.GetCom(Obj, "Animator")
    anim_img = ComUtil.GetCom(img, "Animator")
end

function Refresh(_cfg)
    RefreshPanel(_cfg)
    anim_obj:SetBool("pp", true)
end

function RefreshPanel(_cfg)
    cfg = _cfg
    -- icon 
    CSAPI.LoadImg(img, "UIs/MerryChristmas/" .. cfg.icon .. ".png", true, nil, true)
end

function GetData()
    return cfg
end

------------------------------------------------ 

function SetRecycle(_cb)
    cb = _cb
end

-- 复制副本
function Refresh2(_cfg, _isR)
    RefreshPanel(_cfg)
    flyTime = Time.time + 1.5
    CSAPI.SetGOActive(actionL, not _isR)
    CSAPI.SetGOActive(actionR, _isR)
end

function SetCool(_timeCD)
    timeCD = Time.time + _timeCD
    anim_obj:SetBool("pp", false)
    anim_img:Play("Item_damage", 0, 0)
    CSAPI.SetGOActive(cool, true)
end

function Update()
    if (flyTime and Time.time >= flyTime) then
        flyTime = nil
        CSAPI.SetGOActive(actionL, false)
        CSAPI.SetGOActive(actionR, false)
        cb()
    end
    if (timeCD and Time.time >= timeCD) then
        timeCD = nil
        anim_obj:SetBool("pp", true)
    end
end
