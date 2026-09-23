local cfgInfo = nil
local data = nil
local info = nil
local isGet1,isGet2 = false,false
local isFinish = false
local items1,items2 = nil,nil

function Awake()
    CSAPI.SetGOActive(itemLock1, false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_info, elseData)
    info = _info
    cfgInfo = elseData and elseData.cfgInfo
    data = elseData and elseData.data
    InitImg()
    if info then
        isFinish = data:GetLv() >= info.level
        isGet1,isGet2 = data:IsRewardGet(index)
        SetItem()
        SetText()
        SetState()
    end
end

function SetItem()
    if info.reward then
        items1 = items1 or {}
        GridAddRewards(items1, info.reward, itemParent1)
    end
    if info.fullReward then
        items2 = items2 or {}
        GridAddRewards(items2, info.fullReward, itemParent2)
    end
end

function SetText()
    CSAPI.SetText(txtIndex, index .. "")
end

function SetState()
    CSAPI.SetGOActive(point2, isFinish)
    --免费奖励
    CSAPI.SetGOActive(clickMask1, isFinish and not isGet1)
    CSAPI.SetGOActive(getImg1, isGet1)
    CSAPI.SetGOActive(finishImg1, isFinish and not isGet1)
    CSAPI.SetGOAlpha(itemParent1, isGet1 and 0.5 or 1)
     --付费奖励
    local isBuy = data:IsBuy()
    CSAPI.SetGOActive(itemLock2, not isBuy)
    CSAPI.SetGOActive(clickMask2,isBuy and isFinish and not isGet2)
    CSAPI.SetGOActive(getImg2, isGet2)
    CSAPI.SetGOActive(finishImg2,isBuy and isFinish and not isGet2)
    CSAPI.SetGOAlpha(itemParent2, isGet2 and 0.5 or 1)
end

function OnClick(go)
    if go.name == "clickMask1" and (isGet1 or not isFinish) then
        return
    end
    if go.name == "clickMask2" and (isGet2 or not isFinish) then
        return
    end
    if cb then
        cb(this)
    end
end
----------------------------------------------------图标加载----------------------------------------------------
function InitImg()
    if isLoadImg or not cfgInfo then
        return
    end
    isLoadImg = true

    for k, v in pairs(cfgInfo) do
        if this[tostring(k)] and not IsNil(this[tostring(k)].gameObject) then
            LoadImg(this[tostring(k)].gameObject, tostring(v))
        end
    end
end

function LoadImg(go, iconName)
    if IsNil(go) or (not iconName or iconName == "") or (not cfgInfo) then
        return
    end
    CSAPI.LoadImg(go, "UIs/SkinPass" .. cfgInfo.id .. "/" .. iconName .. ".png", false, nil, true)
    if go.name == "itemLock1" or go.name == "itemLock2" then
        CSAPI.SetImgColor(go, 255, 255, 255, 153)
    else
        CSAPI.SetImgColor(go, 255, 255, 255, 255)
    end
end
