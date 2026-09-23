
local bossEnter = "boss_enter";

function Awake()
    CSAPI.StopBGM();
    CSAPI.SetBGMLock(bossEnter);
end

function OnDestroy()
    CSAPI.SetBGMLock();
    EventMgr.Dispatch(EventType.Replay_BGM);
end