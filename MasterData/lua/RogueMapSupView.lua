local layout = nil
local curDatas = nil
local isCanGet = false

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RogueMap_Assist_Refresh, RefreshPanel)
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRed)

    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/RogueMap/RogueMapAssistItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data,true)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    RefreshPanel()
end

function RefreshPanel()
    SetData()
    SetEmpty()
    SetItems()
    SetRewardBtnState()
end

function SetData()
    curDatas = RogueMapMgr:GetSupportArr()
end

function SetItems()
    layout:IEShowList(#curDatas)
end

function SetRewardBtnState()
    isCanGet = false
    if curDatas and #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            if v:IsFinish() then
                isCanGet = true
                break
            end
        end
    end
    CSAPI.SetGOAlpha(btnAllGet,isCanGet and 1 or 0.5)
end

function SetEmpty()
    CSAPI.SetGOActive(txt_empty, curDatas == nil or #curDatas <= 0)
end

function SetRed()
    UIUtil:SetRedPoint(redParent,RogueMapMgr:CheckLogRed())
end

function OnClickAllGet()
    if not isCanGet then
        return
    end
    FightProto:RogueMapRequireGainReward(2,nil,OnRewardRefresh)
end

function OnRewardRefresh(proto)
    if proto and proto.s_ixs then
        for i, v in ipairs(proto.s_ixs) do
            RogueMapMgr:RemoveSupportData(v)
        end
    end
    RogueMapMgr:SetRewardRed(false)
    RedPointMgr:ApplyRefresh()
    RefreshPanel()
end

function OnClickHistory()
    CSAPI.OpenView("RogueMapLog")
end

function OnClickClose()
    view:Close()
end
