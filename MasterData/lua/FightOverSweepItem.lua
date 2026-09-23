local data =nil
local layout = nil
local curDatas = {}
local animTime = 0.2 --0.2秒播完一条动效
local isAnimEnd = false
local anims ={}

function Update()
    if gameObject.activeSelf == false or isAnimEnd then
        return
    end

    if animTime> 0 then
        animTime = animTime - Time.deltaTime
    else
        isAnimEnd = true
    end
end

function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/FightOver/FightOverSweepGrid", LayoutCallBack, true)

    local actions = ComUtil.GetComsInChildren(gameObject, "ActionBase")
    for i = 0, actions.Length - 1 do
        table.insert(anims, actions[i])
    end
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end

function SetNum(cur,max)
    index = cur
    CSAPI.SetText(txtNum, cur.."/"..max )
end

function Refresh(_data)
    curDatas = _data
    if curDatas then
        layout:IEShowList(#curDatas)
    end
end

function IsAnimEnd()
    return isAnimEnd
end

function JumpToAnimEnd()
    if #anims > 0 then -- 动效跳过
        for i, v in ipairs(anims) do
            if v.gameObject.activeSelf == true then
                v:SetComplete(true)
            end
        end
    end
end