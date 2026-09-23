--战棋探索界面
local panel = nil
function Awake()
	
end

function OnOpen()
	local cfgDungeon = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
	local title1 = openSetting == (BattleEnterType.Start and cfgDungeon.chapterID) and {cfgDungeon.name, "STAGE " .. cfgDungeon.chapterID} or {LanguageMgr:GetByID(15128)}
    --LogError(title1);
    if(openSetting == BattleEnterType.Start)then
        ResUtil:CreateUIGOAsync("FightAction/FightPauseOrCut", node.gameObject, function(go)
		    panel = ComUtil.GetLuaTable(go)
		    panel.Init(title1, nil, false)
		    NextAction()
		    EventMgr.Dispatch(EventType.Battle_UI_BlackShow);
	    end)         
    else
        FuncUtil:Call(BattleMgr.ExploreNextWave,BattleMgr,500);
        --BattleMgr:ExploreNextWave();
        EventMgr.Dispatch(EventType.Battle_UI_BlackShow);
        --Close();	
        FuncUtil:Call(Close,nil,1000);	    
    end
end


function NextAction()
	FuncUtil:Call(function()
		panel.ExitTween(function()
			panel.Close()
			Close();
		end)
	end, nil, 1700)
    FuncUtil:Call(BattleMgr.ExploreCallBack,BattleMgr,1600);
end

function Close()
	--BattleMgr:ExploreCallBack();
	EventMgr.Dispatch(EventType.Battle_View_Show_Changed, true);
	if(IsNil(view) == false) then
		view:Close();
	end
end 