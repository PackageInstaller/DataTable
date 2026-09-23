--特殊buff控制


function Awake()
    InitListener();
end

function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Scene_Mask_Changed,OnSceneMaskChanged);    
end

function OnSceneMaskChanged(state) 
     CSAPI.SetGOActive(effNode,not state);
end

function SetCharacter(character)
    if(not character)then
        return;
    end

    local teamId = character.GetTeam();
    local enemyTeamId = TeamUtil:GetOpponent(teamId); 
    local x,y,z = FightGroundMgr:GetCenter(enemyTeamId); 
    
    CSAPI.SetParent(effNode,nil);
    CSAPI.SetPos(effNode,x,y,z);
end

function Remove()
   
    if(IsNil(gameObject))then
        CSAPI.RemoveGO(effNode);
    else
        CSAPI.SetParent(effNode,gameObject);
    end    
end

function OnDestroy()
    CSAPI.RemoveGO(effNode);

    eventMgr:ClearListener();
end
function OnRecycle()
     CSAPI.SetParent(effNode,gameObject);
     eventMgr:ClearListener();
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
effNode=nil;
end
----#End#----