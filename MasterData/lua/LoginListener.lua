function Awake()
    EventMgr.AddListener(EventType.Login_Success,OnLogin);

    EventMgr.AddListener(EventType.Dungeon_Data_Setted,OnDungeonSetted);
    EventMgr.AddListener(EventType.Team_Data_Setted,OnTeamSetted);
end

--登录成功
function OnLogin()
    dungeonSetted = nil;
    teamSetted = nil;
end

function OnDungeonSetted()
    if(dungeonSetted)then
        return;
    end
    dungeonSetted = 1;
    TryEnter()
end

function OnTeamSetted()
    if(teamSetted)then
        return;
    end
    teamSetted = 1;
    TryEnter()
end

function TryEnter()
    if(dungeonSetted and teamSetted)then
        PlayerClient:SwitchEnter();
    end
end