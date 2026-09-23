local timer = nil

function Awake()
    anim_node = ComUtil.GetCom(node, "Animator")
end

function Refresh(_foodCfg, _cb)
    foodCfg = _foodCfg
    cb = _cb
    if (not foodCfg) then
        timer = 0
        return
    end
    CSAPI.PlayTempSound("cafe_effects_02")

    -- icon 
    ResUtil.Coffee:Load(icon, foodCfg.icon)
    CSAPI.SetGOActive(node, true)
    timer = Time.time + 1
end

function Update()
    if (timer and Time.time > timer) then
        timer = nil
        CSAPI.SetGOActive(node, false)
        cb(this)
    end
end

