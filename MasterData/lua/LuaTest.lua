--测试用


function Awake() 
    Log( "启动测试脚本");
    LogWarning("创建测试用对象,正式版记得屏蔽");    

    EventMgr.AddListener(EventType.Character_FightInfo_Log,OnLogCharacterInfo);
end

--输出角色信息
function OnLogCharacterInfo(id)
    if(g_FightMgr)then
        g_FightMgr:ClientPrintCardInfo(id, bt)
    end
end

local GetKey = CS.UnityEngine.Input.GetKey;
local GetKeyDown = CS.UnityEngine.Input.GetKeyDown;
local KeyCode = CS.UnityEngine.KeyCode;
local gameSpeed = 1;

function Update()
    if(GetKey(KeyCode.RightControl) and GetKeyDown(KeyCode.UpArrow))then        
        gameSpeed = gameSpeed * 2;
        CSAPI.SetTimeScale(gameSpeed);
    end
    if(GetKey(KeyCode.RightControl) and GetKeyDown(KeyCode.DownArrow))then        
        gameSpeed = gameSpeed * 0.5;
        CSAPI.SetTimeScale(gameSpeed);
    end
    if(GetKey(KeyCode.RightControl) and (GetKeyDown(KeyCode.RightArrow) or GetKeyDown(KeyCode.LeftArrow)))then        
        gameSpeed = 1;
        CSAPI.SetTimeScale(gameSpeed);
    end       

    if(GetKey(KeyCode.RightControl) and GetKeyDown(KeyCode.G))then        
        _G.testFlip = not _G.testFlip;
        Log(_G.testFlip and "启动镜像翻转战斗" or "取消镜像翻转战斗","eeee55");
    end

    if(GetKeyDown(KeyCode.F12))then
        local cmdStr = "overFight";
        if GMCmd(cmdStr) then return end
        local proto = {"ClientProto:GmCmd", {cmd = cmdStr}};
	    NetMgr.net:Send(proto);
    end

    if(GetKeyDown(KeyCode.F1))then
        _G.lock_fight_camera = not _G.lock_fight_camera;
        _G.no_float_font = 1;
        _G.no_fight_skill_skip = 1;
    end

--    if(GetKeyDown(KeyCode.E))then
--        FightRecordMgr:Read();
--    end
--    if(GetKeyDown(KeyCode.N))then
--        FightRecordMgr:Step();
--    end
--    if(GetKeyDown(KeyCode.F))then    
--        SoundMgr:SetAllLanguageCVs("cn");
--    end
--    if(GetKeyDown(KeyCode.G))then    
--        SoundMgr:ResetAllLanguageCV();
--    end

    if(GetKeyDown(KeyCode.F8) or (GetKey(KeyCode.RightControl) and GetKeyDown(KeyCode.J)))then
        Log("跳过全部引导，并退出副本！");
        FightClient:Reset();
        PlayerClient:SetNewPlayerFightStateKey(4);
        GuideMgr:SkipAll();
        DungeonMgr:Quit(true);
    end 
end

function AA(p)
    LogError(p);
end



function GetCmdID(str)
	local r = SplitString(str, " ")
	return r[1], r[2], r[3], r[4], r[5], r[6]
end
function GMCmd(str)
	-- if not DEBUG and player:GetUserID() ~= GM_USER_ID then return end
	local id, p1, p2, p3, p4, p5 = GetCmdID(str)

	if id == nil then
		return
	end

	if id == "overFight" then
		if not g_FightMgrServer then return end
		if p1 == "2" then
			g_FightMgrServer:Over(1, 2)
		else
			g_FightMgrServer:Over(1, 1)
		end
	else
		return
	end

	return true
end
