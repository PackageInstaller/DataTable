function Awake()
    EventMgr.AddListener(EventType.Scene_Load,OnSceneLoad);
    EventMgr.AddListener(EventType.Scene_Load_Start,OnSceneLoadStart);
    EventMgr.AddListener(EventType.Scene_Load_Complete,OnSceneLoadComplete);
    EventMgr.AddListener(EventType.Fight_Boss,OnFightBoss);
    EventMgr.AddListener(EventType.Play_BGM,PlayBGM);
    EventMgr.AddListener(EventType.Play_BGM_New,NewPlayBGM);
    EventMgr.AddListener(EventType.Replay_BGM,ReplayBGM);
    
    EventMgr.AddListener(EventType.Scene_Fight_Load,OnSceneFightLoad);
end
--场景加载
function OnSceneFightLoad(param)
    CSAPI.LoadScene(param,"HideLoading");
   
    CameraMgr:ApplyCommonAction(nil,"default_camera");

end

--场景加载
function OnSceneLoad(param)
    CSAPI.LoadScene(param);
   
    CameraMgr:ApplyCommonAction(nil,"default_camera");

end

--场景开始加载
function OnSceneLoadStart(param)
    cfgScene = Cfgs.scene:GetByID(param);

    if(cfgScene and cfgScene.bgm)then
        --PlayBGM(cfgScene.bgm);
        OnSceneLoadStart_PlayBGM(cfgScene)
    end
    
    if(cfgScene and SceneMgr)then     
        SceneMgr:SetCurrScene(cfgScene);        
    end
end

function OnSceneLoadStart_PlayBGM(cfgScene)
    if(cfgScene.key=="MajorCity") then 
        --主城音乐走音乐表
        local cfg = BGMMgr:GetMajorCityMusicCfg()
        PlayBGM(cfg.cue_name_2)
    else 
        PlayBGM(cfgScene.bgm)
    end
end

--释放资源
function Release() 
    if(not ReleaseMgr)then
        return;
    end
    --LogError("ss");
    if(SceneMgr and SceneMgr:IsMajorCity())then
        ReleaseMgr:ReleaseSound();
        ReleaseMgr:FightRelease();
        
        FuncUtil:Call(BattleMgr.ApplyFightAuto,BattleMgr,5000);
    else        
        ReleaseMgr:UIRelease();
    end
end


--场景加载完成
function OnSceneLoadComplete(param)

    cfgScene = Cfgs.scene:GetByID(param);

    if(cfgScene and SceneMgr)then
        SceneMgr:SetCurrScene(cfgScene,true);
    end

    local xluaCamera = CameraMgr:GetXLuaCamera();
    if(xluaCamera)then
        xluaCamera.SetSceneCameraFarState(cfgScene and cfgScene.far_camera);   
    end 

    Release();

    ComUtil.FixLuaTables();
    collectgarbage("collect");

    ThinkingAnalyticsMgr:Flush();
end

function OnFightBoss()
    if(cfgScene and cfgScene.bgm_boss)then
        PlayBGM(cfgScene.bgm_boss);
    end
end

function PlayBGM(bgm,fadeTime)   
    if(StringUtil:IsEmpty(bgm))then
        return;
    end 
    lastBGM = bgm;
    CSAPI.PlayBGM(bgm,fadeTime or 1500);
end
function NewPlayBGM(data)
    if(not data)then
        return;
    end

    local bgm = data.bgm;   
    if(StringUtil:IsEmpty(bgm))then
        return;
    end

    lastBGM = bgm;
    CSAPI.PlayBGM(bgm,data.fadeTime or 1500);
end

function ReplayBGM(fadeTime)
    --LogError("重播背景音乐" .. tostring(lastBGM));
    if(lastBGM)then
        PlayBGM(lastBGM,fadeTime)
    end
end