-- 点线段
local width = nil

function Awake()
    actionWH = ComUtil.GetCom(gameObject, "ActionWH")
    actionWH.enabled = false
end

function SetAction(time, call)
    CSAPI.SetRectSize(gameObject,0,20)   
    actionWH.time = time
    actionWH.scaleW = width
    actionWH.enabled = true
    if call then
        actionWH:Play(call)
    end
end

function SetWidth(_width)
    width = _width
end