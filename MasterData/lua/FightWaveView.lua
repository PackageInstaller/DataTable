--回合切换界面

function OnOpen()
    CSAPI.DisableInput(2000);

--    local effName = "wave_cameraEff_" .. math.min(3,(data and data or 1)) .. "_" .. math.min(3,FightClient:GetTotalWave());
--    PlayEff(effName);
    
    FuncUtil:Call(PlayWaveAni,nil,500);

    FuncUtil:Call(Close,nil,3000);

    CSAPI.PlayUISound("ui_battle_switch_level");

    FightClient:SetPauseState(false);
end


function PlayWaveAni()
    ResUtil:CreateUIGOAsync("FightAction/FightPauseOrCut", aniNode, function(go)
        local content = string.format(LanguageMgr:GetByID(25011),data or 1,FightClient:GetTotalWave() or 1);
		local panel = ComUtil.GetLuaTable(go);
		panel.Init({content}, nil, true);

        FuncUtil:Call(panel.ExitTween,nil,1500);
	end)
end

--function PlayEff(effName)
--    local xluaCamera = CameraMgr:GetXLuaCamera();
--    if(xluaCamera)then
--        cameraEffs = {{res = effName}};
--        xluaCamera.CreateCameraEffs(cameraEffs);             
--    end 
--end

function Close()
    if(view)then
        view:Close();
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
aniNode=nil;
view=nil;
end
----#End#----