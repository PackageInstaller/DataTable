function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetReds)

    UIUtil:AddTop2("RogueMain", gameObject, function()
        view:Close()
    end, nil, {})
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    -- red 
    SetReds()
end

function SetReds()
    UIUtil:SetRedPoint(btn3, RogueTMgr:IsRed(), 404, 120, 0)
    UIUtil:SetRedPoint(btn1, RogueMgr:IsRed(), 404, 120, 0)
    UIUtil:SetRedPoint(btn2, RogueSMgr:IsRed(), 404, 120, 0)
end

function OnClick1()
    CSAPI.OpenView("RogueView")
end

function OnClick2()
    CSAPI.OpenView("RogueSView")
end

function OnClick3()
    CSAPI.OpenView("RogueTView")
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
