local isClick = false
local recycleCB = nil
local action1, action2 = nil, nil
local timer = 0
local maxTime = 2
local isEnd = false
local minScale = 0.2
local maxScale = 1.35
local minY = -1850

function Awake()
    rect = ComUtil.GetCom(gameObject, "RectTransform")
end

function SetRecycle(cb)
    recycleCB = cb
end

function Update()
    if (isEnd) then
        return
    end
    timer = timer + Time.deltaTime
    local progress = timer / maxTime
    progress = progress > 1 and 1 or progress
    CSAPI.SetAnchor(gameObject, 0, minY * progress, 0)
    local scale = (maxScale - minScale) * progress
    CSAPI.SetScale(gameObject, scale, scale, 1)
    if (progress >= 1) then
        Recyclse()
    end
end

function Refresh()
    timer = 0
    CSAPI.SetScale(gameObject, minScale, minScale, 1)
    isEnd = false
    local num = CSAPI.RandomInt(1, 2)
    CSAPI.LoadImg(icon, "UIs/Spine/70400_skin_LycorisRadiata03a_spine/img_02_0" .. num .. ".png", true, nil, true)
end

function Recyclse()
    if (isEnd) then
        return
    end
    isEnd = true
    if (recycleCB) then
        recycleCB(this)
    end
end

