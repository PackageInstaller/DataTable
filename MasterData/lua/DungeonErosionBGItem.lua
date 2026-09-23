local cfg = nil
local isShowTest = false

function Awake()
    SetImg()
end

function SetImg()
    CSAPI.SetGOActive(testImg,isShowTest)
end

function Refresh(_cfg)
    cfg = _cfg
    if cfg then
        SetPos()
    end
end

function SetPos()
    if cfg.pos then
        CSAPI.SetLocalPos(gameObject,cfg.pos[1],cfg.pos[2])
        gameObject.name = cfg.pos[1] .. " " .. cfg.pos[2]
    end
end

function GetPos()
    local x,y = CSAPI.GetLocalPos(gameObject)
    return -x,-y
end

function GetMapLevel()
    return cfg and cfg.level or 1
end