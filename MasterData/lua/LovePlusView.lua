local layout = nil
local curIndex = 1
local curDatas = {}
local isJumpToPlot = false

function Awake()
    layout = ComUtil.GetCom(hsv,"UIInfinite")
    layout:Init("UIs/LovePlus/LovePlusItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.LovePlus_Data_Update,SetItems)
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetItems)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data)
    end
end

function OnItemClickCB(_data)
    local elseData = openSetting
    openSetting = nil
    if _data then
        EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="lovePlus_enterView",time=5000,
        timeOutCallBack=function()
            Tips.ShowTips("获取数据超时！！！")
        end})
        LovePlusProto:GetChapterData(_data:GetID(),function ()
            EventMgr.Dispatch(EventType.Net_Msg_Getted,"lovePlus_enterView")
            CSAPI.OpenView("LovePlusListView", _data, elseData)        
        end)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("LovePlusView", topParent, function()
        view:Close()
    end, nil, {})
end

function OnOpen()
    CheckStoryInfo()
    SetDatas()
    SetPos()
    SetItems()
    SetTime()
end

function SetDatas()
    curDatas = LovePlusMgr:GetArr()
end

function SetPos()
    if #curDatas > 0 then
        if #curDatas == 1 then
            CSAPI.SetLocalPos(hsv,44 + 565 + 55,-28)
        elseif #curDatas == 2 then
            CSAPI.SetLocalPos(hsv,44 + 565 / 2 + 55,-28)
        else
            CSAPI.SetLocalPos(hsv,0,-28)
        end
    end
end

function SetJump()
    if data and data.id and #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            if v:GetID() == data.id then
                curIndex = i
            end
        end
    end
end

function SetItems()
    layout:IEShowList(#curDatas,OnLoadSuccess,curIndex)
end

function OnLoadSuccess()
    if openSetting and not isJumpToPlot then
        local lua = layout:GetItemLua(curIndex)
        if lua then
            lua.OnClick()
        end
    end
end

function SetTime()
    local _, id = ActivityMgr:IsOpenByType(ActivityListType.LovePlus)
    local alData = ActivityMgr:GetALData(id)
    if alData then
        local tab = TimeUtil:GetTimeTab(alData:GetEndTime() - TimeUtil:GetTime())
        LanguageMgr:SetText(txtTime,73013,tab[1],tab[2],tab[3])
    end
end

function CheckStoryInfo()
    local info = LovePlusMgr:GetStorySaveInfo()
    isJumpToPlot = info ~= nil
    if isJumpToPlot then
        local dialogData = {}
        dialogData.content = "返回剧情"
        dialogData.okCallBack = function()
            LovePlusMgr:CheckStortInfo(info)
            EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="lovePlus_enterView",time=5000,
            timeOutCallBack=function()
                Tips.ShowTips("获取数据超时！！！")
                CheckStoryInfo()
            end})
            local sData = LovePlusMgr:GetData(info.sid)
            LovePlusProto:GetChapterData(sData:GetID(),function ()
                EventMgr.Dispatch(EventType.Net_Msg_Getted,"lovePlus_enterView")
                LovePlusMgr:ClearStorySaveInfo()
                CSAPI.OpenView("LovePlusListView", sData, {type = 2,id = info.nid,storyID = info.nid,talkID = info.ids[#info.ids]})        
            end)
        end
        dialogData.cancelCallBack = function()
            LovePlusMgr:ClearStorySaveInfo()
            LovePlusMgr:ExitPlot(info.sid,info.nid)
        end
        CSAPI.OpenView("Dialog",dialogData)
    end
end

