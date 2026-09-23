-- 波塞冬
local isOver = false
local results = {{0.5, 0, 8}, {0.3, 0.7, 9}, {0.1, 0.4, 10}, {0, 0.4, 11}, {0.3, 0.4, 13}}
local timer = nil

function Awake()
    CSAPI.SetGOActive(btnBack, false)
    timer = Time.time + 1.5
end

function Update()
    if (timer and Time.time >= timer) then
        timer = nil
        CSAPI.SetGOActive(btnBack, true)
    end
end

function Refresh(_CardLive2DItem)
    CardLive2DItem = _CardLive2DItem
end

function CheckToPlay()
    if (isOver) then
        return
    end
    local index = 12
    local i1 = GetMulDataProgress(14)
    local i2 = GetMulDataProgress(15)
    for k, v in pairs(results) do
        if (i1 == v[1] and i2 == v[2]) then
            index = v[3]
            break
        end
    end
    CardLive2DItem.PlayByIndex(index)
    if (index == 11) then
        results[4][3] = 18
    end
end

function GetMulDataProgress(index)
    local mulData = CardLive2DItem.GetSpineTools():GetMulData(index)
    if (mulData) then
        return mulData._progress or 0
    end
    return 0
end

function Click(index)
    if (isOver) then
        return
    end
    if (not CardLive2DItem.IsIdle() or CardLive2DItem.CheckMulIsPlay(index)) then
        return
    end
    CardLive2DItem.PlayByIndex(index)
end

function OnClickL()
    Click(14)
end

function OnClickR()
    Click(15)
end

function OnClickOK()
    if (not CardLive2DItem.IsIdle() or CardLive2DItem.CheckMulIsPlay(14) or CardLive2DItem.CheckMulIsPlay(15)) then
        return
    end
    CheckToPlay()
end

function OnClickBack()
    if (isOver) then
        return
    end
    if (not isOver) then
        isOver = true
        CardLive2DItem.PlayByIndex(16, nil, false, true)
    end
end
