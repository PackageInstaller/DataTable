local txtContent = nil;

function Awake()       
    txtContent = ComUtil.GetCom(content,"Text");
end

function OnInit()
    
end

function InitListener()
   
end


function OnOpen()
    if(data ~= nil)then
        local teamId = data.winTeamId;
        local localTeamId = TeamUtil:ToClient(teamId);
        local isEnemy = TeamUtil:IsEnemy(localTeamId);
        txtContent.text = isEnemy and "你输了" or "你赢了";
    end
end


--回到战棋场景
function OnClickBtnOK() 
    FightClient:Clean();
 
    if(DungeonMgr:IsCurrDungeonComplete())then       
        --副本结束
    else
       
        --未结束
        local dungeonId = DungeonMgr:GetCurrId();
        if(dungeonId)then
            DungeonMgr:ApplyEnter(dungeonId);
            return;
        end
    end
  
    DungeonMgr:Quit();
end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
content=nil;
view=nil;
end
----#End#----