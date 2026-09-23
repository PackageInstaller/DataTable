local data = nil
local curDatas = nil
local isGet = false
local isFinish = false
local items = nil

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data,_elseData)
    data = _data
    SetTitle(_elseData and _elseData.title1)
    if data then
        isGet = data:IsGet()
        isFinish = data:IsFinish()
        SetNum()
        SetDesc()
        SetReach()
        SetItems()
        SetRed()
    end
end

function SetTitle(str1)
    if str1 then
        CSAPI.SetText(txt_title1,str1)
    end
end

function SetNum()
    local idx = data:GetCfg() and data:GetCfg().index or 0
    CSAPI.SetText(txtNum,idx.."")
end

function SetDesc()
    CSAPI.SetText(txtDesc,data:GetDesc())
end

function SetReach()
    CSAPI.SetGOActive(reachObj,isFinish)
end

function SetItems()
    curDatas = data:GetJAwardId()
    items = items or {}
    ItemUtil.AddItems("Mission2/MissionRewardItem2",items,curDatas,itemParent,nil,1,{isGet = isGet})
end

function SetRed()
    UIUtil:SetRedPoint(redParent,isFinish and not isGet)
end

function GetData()
    return data
end

function OnClick()
    if cb then
        cb(this)
    end
end