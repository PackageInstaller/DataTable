
function Awake()
    EventMgr.AddListener(EventType.Fight_Action_Push,OnFightActionPush);
end

--行为入列
function OnFightActionPush(param)
    --Log(param);
    FightActionMgr:Push(param);
end



