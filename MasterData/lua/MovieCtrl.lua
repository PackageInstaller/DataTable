
function Awake()
    InitListener();
end

function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Fight_Skill_Skip_Complete,OnSkipComplete);
end
function OnDestroy()
    eventMgr:ClearListener();
end

function OnSkipComplete()
    if(not IsNil(gameObject))then
        CSAPI.SetScale(gameObject,0,0,0);
    end
end