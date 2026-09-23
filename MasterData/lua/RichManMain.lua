local top=nil;
local eventMgr=nil;
local child=nil;
local curData=nil;
local curCfg=nil;
local criMovie=nil;
local loadingObj=nil;
local loadingAnimator=nil;
local queueIsPlay=false;

function Awake()
    top=UIUtil:AddTop2("RichManMain",topNode,OnClickClose);
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RichMan_PlayRand_Begin,OnPlayRandBegin);
    eventMgr:AddListener(EventType.Loading_Complete, LoadingComplete)
    eventMgr:AddListener(EventType.RichMan_Map_Update,OnMapLoad)
    eventMgr:AddListener(EventType.RichMan_Mask_Changed,SetMask)
    eventMgr:AddListener(EventType.RichMan_ActionQueue_Start,OnQueueStart)
    eventMgr:AddListener(EventType.RichMan_ActionQueue_End,OnQueueEnd)
    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed);
    eventMgr:AddListener(EventType.RichMan_AutoThrow_Reward,OnAutoRewardRet)
    eventMgr:AddListener(EventType.RichMan_AutoThrow_RewardOver,Refresh)
    CSAPI.SetGOActive(RandNode,false);
    CSAPI.SetGOActive(loadingNode,false);
end

function OnDestroy()
    EventMgr.Dispatch(EventType.Replay_BGM);
    eventMgr:ClearListener();
 end

function OnOpen()
    curData=RichManMgr:GetCurData();
    PlayBGM();
    if child==nil then
        ResUtil:CreateUIGOAsync(string.format("%s/RichManNode",curCfg.view),AdaptiveScreen,function(go)
            child=ComUtil.GetLuaTable(go);
            CSAPI.SetGOActive(go,false)
        end);
    end
end

function PlayBGM(disChangeBGM)
    if curData==nil then
        LogError("未获取到活动数据！");
        do return end
    end
    curCfg=curData:GetCfg();
    --播放BGM
    if curCfg~=nil and curCfg.bgm~=nil and disChangeBGM~=true then
       local bgmName=CSAPI.PlayBGM(curCfg.bgm)
    end
end

function Refresh()
    --等待加载完播放动画
    if child~=nil then
        child.Refresh();
    end
end

function LoadingComplete()
    FuncUtil:Call(function()
        if child~=nil then
            CSAPI.SetGOActive(child.gameObject,true)
        end
        SetMask(false);
        Refresh();
    end,nil,100)
end

function OnClickClose()
    if child.Exit~=nil and child.Exit() then
        RichManMgr:SetAutoState(false)
        do return end;
    end
    EventMgr.Dispatch(EventType.Scene_Load, "MajorCity");
end

function OnPlayRandBegin(eventData)
    if eventData~=nil then
        PlayRandom(eventData.point,eventData.isFixed,RichManMgr:GetAutoState());
    end
end

function PlayRandom(index,isFixed,isAuto)
    if criMovie~=nil then
        do return end
    end
    local vName=isFixed and "richman_throw_fixed_"..index or "richman_throw_normal_"..index 
    criMovie=ResUtil:PlayVideo(vName,RandNode)
    CSAPI.SetGOActive(RandNode,true);
    CSAPI.PlaySound("temp/temp.acb","Monopoly_Effects_01");
    criMovie.playSpeed=isAuto and 1.5 or 1;
    criMovie:AddCompleteEvent(OnPlayOver)
end

function OnPlayOver()
    criMovie = nil
    CSAPI.SetGOActive(RandNode,false);
    EventMgr.Dispatch(EventType.RichMan_PlayRand_Over)
    -- if RichManMgr:GetAutoState()~=true then --改为播放完所有动作才能继续投，此处逻辑去除
    --     EventMgr.Dispatch(EventType.RichMan_Mask_Changed,false)
    -- end
end

function OnAutoRewardRet(reward)
    RichManMgr:RecordAutoReward(reward);
    if queueIsPlay~=true then
        RichManMgr:PlayAutoReward();
    end
end

function OnQueueStart()
    SetMask(true);
    queueIsPlay=true;
end

function OnQueueEnd()
    SetMask(false);
    queueIsPlay=false;
end

function SetMask(isShow)
    CSAPI.SetGOActive(mask,isShow==true);
end

function OnClickSkip()
    -- if RichManMgr:GetAutoState() then --自动无法跳过
    --     do return end
    -- end
    if criMovie~=nil then
        criMovie:Remove();
        CSAPI.StopTargetSound("temp/temp.acb","Monopoly_Effects_01")
        OnPlayOver();
    end
    CSAPI.SetGOActive(RandNode,false);
end

--播放加载动效
function OnMapLoad(eventData)
    if loadingObj==nil then
        ResUtil:CreateUIGOAsync("RichMan/Loading",loadingNode,function(go)
            loadingObj=go;
            loadingAnimator=ComUtil.GetComInChildren(go,"Animator");
            CSAPI.SetGOActive(loadingNode,true);
            FuncUtil:Call(function()
                if eventData.action then
                    eventData.action:SetState(3);
                end
                CSAPI.SetGOActive(loadingNode,false);
            end,nil,1400)
        end);
    else
        CSAPI.SetGOActive(loadingNode,true);
        if loadingAnimator~=nil then
             loadingAnimator:Play("Loading_entry",-1,0); 
        end
        FuncUtil:Call(function()
            if eventData.action then
                eventData.action:SetState(3);
            end
            CSAPI.SetGOActive(loadingNode,false);
        end,nil,1400)
    end
end

function OnViewClosed(viewKey)
    if viewKey=="ShopView" then
        FuncUtil:Call(PlayBGM,nil,150)
    end
end

------------------------------------------------------------------------------
---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if  top.OnClickBack then
        top.OnClickBack();
    end
end