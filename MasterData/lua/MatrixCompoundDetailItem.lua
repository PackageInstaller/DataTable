function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end

-- data=> MatrixCompoundData
function Refresh(_data, _elseData)
    data = _data
    oldLen = _elseData[1]
    len = _elseData[2]

    isSelect = index == len

    -- item 
    item = item
    local rewardData = data:GetFakeRewardData()
    if (not rewardItem) then
        local go, _rewardItem = ResUtil:CreateGridItem(itemPoint.transform)
        rewardItem = _rewardItem
    end
    rewardItem.Refresh(rewardData, {
        isClick = false
    })
    rewardItem.SetCount(0)

    -- select
    SetSelect()
    -- arrowR
    CSAPI.SetGOActive(arrowR, index < len)
    -- arrowD 
    CSAPI.SetGOActive(arrowD, index == len)
end

function SetSelect()
    CSAPI.SetGOActive(selectObj, isSelect)
    if (isSelect and oldLen ~= len) then
        local x1 = -(len - oldLen) * 165
        UIUtil:SetPObjMove(selectObj, x1, 0, 0, 0, 0, 0, nil, 300)
    end
end

function OnClick()
    cb(index)
end
