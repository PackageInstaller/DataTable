-- 拿起时的格子
local isGreen = true
local planeType = 1

-- 闪烁
local isFlicker = false
local count = 7
local interval = 0.3
local timer = 0
local curCount = 0

function OnRecycle()
	CSAPI.SetGOActive(gameObject, true)
end

function Awake()
    -- grid_sr = ComUtil.GetCom(grid, "Renderer")
    red_sr = ComUtil.GetCom(red, "Renderer")
    green_sr = ComUtil.GetCom(green, "Renderer")
end

function Update()
    if (isFlicker and curCount < count) then
        timer = timer + Time.deltaTime
        if (timer > interval) then
            timer = 0
            curCount = curCount + 1
            CSAPI.SetGOActive(node, not node.activeSelf)
        end
    end
end

-- 家具
function Init(cfgID,_isGreen)
	InitFlicker()
    CSAPI.SetLocalPos(gameObject, 0, 0, 0)
    cfg = Cfgs.CfgFurniture:GetByID(cfgID)
    local isHangings = cfg.sType == DormFurnitureType.hangings
    local scale = cfg.scale or {1, 1, 1}
    -- size
    local width = isHangings and scale[2] or scale[1]
    local height = isHangings and scale[3] or scale[3]
    -- pos
    if (isHangings) then
        CSAPI.SetLocalPos(node, scale[1] / 2 - 0.01, 0, 0)
    else
        CSAPI.SetLocalPos(node, 0, 0.01, 0)
    end
    -- node
    angleZ = isHangings and 90 or 0
    CSAPI.SetAngle(node, 0, 0, angleZ)
    -- grid
    -- grid_sr.size = UnityEngine.Vector2(3 + width - 1, 3 + height - 1)
    -- red
    GetRed_sr().size = UnityEngine.Vector2(width, height)
    -- green 
    GetGreen_sr().size = UnityEngine.Vector2(width, height)
    SetRed(_isGreen)
end

-- 角色
function Init2(id,_isGreen)
	InitFlicker()
    CSAPI.SetLocalPos(gameObject, 0, 0, 0)
    -- size
    local width = 1
    local height = 1
    -- pos
    CSAPI.SetLocalPos(node, 0, -1.99, 0)
    -- node
    CSAPI.SetAngle(node, 0, 0, 0)
    -- grid
    -- grid_sr.size = UnityEngine.Vector2(3 + width - 1, 3 + height - 1)
    -- red
    GetRed_sr().size = UnityEngine.Vector2(width, height)
    -- green 
    GetGreen_sr().size = UnityEngine.Vector2(width, height)
    SetRed(_isGreen)
end

function SetRed(_isGreen)
    isGreen = _isGreen == nil and isGreen or _isGreen
    CSAPI.SetGOActive(red, not isGreen)
    CSAPI.SetGOActive(green, isGreen)

    -- local code = _isGreen and "00FFBF" or "FF0040"
    -- CSAPI.SetImgColorByCode2(grid, code)
end

function InitFlicker()
    isFlicker = false 
	CSAPI.SetGOActive(node, true)
end

function SetFlicker()
    timer = 0
    curCount = 3
    isFlicker = true
end


function GetRed_sr()
    if(not red_sr) then 
        red_sr = ComUtil.GetCom(red, "Renderer")
    end 
    return red_sr
end

function GetGreen_sr()
    if(not green_sr) then 
        green_sr = ComUtil.GetCom(green, "Renderer")
    end 
    return green_sr
end