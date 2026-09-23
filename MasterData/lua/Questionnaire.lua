function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Menu_Questionnaire, RefreshPanel)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    RefreshPanel()
end

function RefreshPanel()
    local datas = QuestionnaireMgr:GetDatas()
    items = items or {}
    ItemUtil.AddItems("Questionnaire/QuestionnaireItem", items, datas, Content, RefreshPanel)
end


function OnClickClose()
    view:Close()
end