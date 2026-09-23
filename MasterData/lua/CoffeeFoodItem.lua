local isStop = true
local cd = nil
local holdTime = 0.2;
local holdDownTime = 0;

function SetClickCB(_cb)
    cb = _cb
end

function Awake()
    image_fill = ComUtil.GetCom(fill, "Image")
    image_fill.fillAmount = 1

    drag_node = ComUtil.GetCom(node, "DragCallLua")
    drag_node.dragGO = node

    press_node = ComUtil.GetCom(node, "PressCallLua")

    anim_node = ComUtil.GetCom(node, "Animator")

    CSAPI.SetGOActive(node, false)
end

function Refresh(_foodCfg)
    foodCfg = _foodCfg
    --
    cd = foodCfg.cd
    -- 
    SetFood()
    -- 
    SetMask()
end

function Update()
    if (isStop) then
        return
    end
    if (cd) then
        cd = cd - Time.deltaTime
        image_fill.fillAmount = cd / foodCfg.cd
        CSAPI.SetText(txtTime, math.ceil(cd) .. "s")
        if (cd <= 0) then
            cd = nil
            SetMask()
        end
    end
end

function SetFood()
    ResUtil.Coffee:Load(icon, foodCfg.icon)
    ResUtil.Coffee:Load(fillBg, foodCfg.timeImg)
    ResUtil.Coffee:Load(fill, foodCfg.timeImg)
end

function SetMask()
    CSAPI.SetGOActive(mask, cd ~= nil)
    drag_node.enabled = cd == nil
    press_node.enabled = cd == nil
end

function OnBeginDragXY()
    holdDownTime = Time.unscaledTime
    ---anim_node:SetBool("sel", true)
end

function OnEndDragXY()
    cb(this)
    --
    CSAPI.SetAnchor(node, 0, 0, 0)
    --anim_node:SetBool("sel", false)
end

function SetUse()
    cd = foodCfg.cd
    SetMask()
end

function SetStop(b)
    isStop = b
end

function ToStart()
    isStop = false
    CSAPI.SetGOActive(node, true)
end

function OnPressDown(isDragging, clickTime)
    holdDownTime = Time.unscaledTime;
end

function OnPressUp(isDragging, clickTime)
    if not isDragging then
        if Time.unscaledTime - holdDownTime < holdTime then
            CSAPI.PlayTempSound("cafe_effects_01")
            CSAPI.OpenView("CoffeeFoodDetail", {foodCfg, gameObject})
        end
    end
end

