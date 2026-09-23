function SetClickCB(_cb)
    cb = _cb
end
function Refresh(_data)
    data = _data
    --
    CSAPI.SetText(txtTitle, data.name)
    --
    local time = TimeUtil:GetTimeStr2(data.closeTime, true)
    LanguageMgr:SetText(txtTime, 2031, time)
    --
    SetGrids(data.reward)
    --
    SetBtn()
end

-- 1050 已完成  6011 待领取   6012 前往
function SetBtn()
    local lanID = 6012
    if (data.getStatus and data.getStatus ~= 0) then
        lanID = data.getStatus == 1 and 6011 or 1050
    end
    CSAPI.SetGOActive(btnS, lanID ~= 1050)
    CSAPI.SetGOActive(success, lanID == 1050)
    if (lanID ~= 1050) then
        LanguageMgr:SetText(txtS1, lanID)
        LanguageMgr:SetEnText(txtS2, lanID)
        CSAPI.SetGOActive(imgBtn1, lanID == 6011)
        CSAPI.SetGOActive(imgBtn2, lanID ~= 6011)
    end
    -- red 
    local isRed = lanID ~= 1050
    UIUtil:SetRedPoint(btnS, isRed, 109.5, 31.7, 0)
end

-- 设置物品
function SetGrids(rewards)
    local gridDatas = GridUtil.GetGridObjectDatas(rewards)
    items = items or {}
    ItemUtil.AddItems("Grid/GridItem", items, gridDatas, Content, GridClickFunc.OpenInfoSmiple)
end

function OnClickS()
    if (data.getStatus == 1) then
        QuestionnaireProto:GetReward(data.id, cb)
    elseif (data.getStatus ~= 2) then
        ShiryuSDK.OpenWebView(data.nTransferPath)
        QuestionnaireProto:Jump(data.id, cb)
    end
end
