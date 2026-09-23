local isClose = false

function OnOpen()
    local info = ActivityMgr:GetWindowInfo("AcitivtyEntryWindow_" .. eAEShowType.Anniversary)
    isClose = info.isClose or false
    SetShow()
    SetItems()
end

function SetShow()
    CSAPI.SetGOActive(ok,isClose)
    CSAPI.SetGOActive(cancel,not isClose)
    -- CSAPI.SetTextColorByCode(txt_show,isClose and "ffc146" or "838383")
end

function SetItems()
    local signData = SignInMgr:GetDataByALType(1024)
    if signData then
        local signDayDatas = SignInMgr:GetDayInfos(signData:GetKey())
        if signDayDatas and signDayDatas[1] then
            local rewards = signDayDatas[1]:GetRewards()
            if rewards and #rewards > 0 then
               local curDatas = GridUtil.GetGridObjectDatas2(rewards)
                if curDatas and #curDatas > 0 then
                    for i, v in ipairs(curDatas) do
                        CSAPI.SetText(this["txtName" .. i].gameObject,v:GetName())
                    end
                end
            end
        end
    end
end

function OnClickJump()
    CSAPI.OpenView("AnniversaryView")
    view:Close()
end

function OnClickShow()
    isClose = not isClose
    ActivityMgr:SaveWindowInfos("AcitivtyEntryWindow_" .. eAEShowType.Anniversary,isClose)
    SetShow()
end

function OnClickItem(go)
    if curDatas and #curDatas>0 then
        for i, v in ipairs(curDatas) do
            if go.name == "item" .. i then
                UIUtil:OpenGoodsInfo(v, 3);
                break
            end
        end
    end
end

function OnClickBack()
    view:Close()
end