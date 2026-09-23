function Awake()	   
end

function OnInit()
	
end

function InitListener()
	
end


function OnOpen()
	local content = data and data.content;
    if(content)then
	    CSAPI.SetText(Text, content);
    else
        OnClickBack();
    end
end


--回到战棋场景
function OnClickBack()
	view:Close();
	
	local dirllId = FightClient:GetDirll();
	if(dirllId) then
--		SceneLoader:Load("MajorCity", function()
--			local card = RoleMgr:GetData(dirllId);
--			--要打开列表
--			CSAPI.OpenView("RoleListNormal", card, 3)  --3 =>试玩，会触发打开该卡牌详情界面
--		end)
        FightClient:QuitDirll();
		return;
	end
	
	
    local fightIds = PlayerClient:GetNewPlayerFightIDs();
	local fightId = fightIds and fightIds[1];
	cfg = Cfgs.MonsterGroup:GetByID(fightId);
	
	if(cfg and cfg.storyID2) then
		PlotMgr:TryPlay(cfg.storyID2, DungeonMgr.Quit, DungeonMgr);
		--FightActionMgr:Push(FightActionMgr:Apply(FightActionType.Plot, {storyID = cfg.storyID2}));
	else
		DungeonMgr:Quit();
	end	
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
Text=nil;
view=nil;
end
----#End#----