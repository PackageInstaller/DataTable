local  weight_key = "Loading";
local currKey=nil;
local currCfg=nil;
local currIdx=0;--当前显示的loading图下标

function Awake()
   
    if SceneMgr and SceneMgr:IsLoginLoading() then
        CSAPI.SetGOActive(bg,false);
        CSAPI.SetGOActive(movieRoot,true);
        UIUtil:AddLoginMovie(movieObj);
    else
        CSAPI.SetGOActive(movieRoot,false);
        CSAPI.SetGOActive(bg,true);
    end
    if(loadPercent)then
        txtPercent = ComUtil.GetCom(loadPercent,"Text");
    end
end

function OnSceneLoad(param)
    --设置loading背景图
    if param~=currKey then
        currCfg=Cfgs.scene:GetByKey(param);   
        currIdx=0;
        ChangeBG();
        currKey=param;
    end
end

function OnClickBG()
    ChangeBG();
end

function ChangeBG()
    if currCfg and currCfg.loading_bg then
        local bgs=currCfg.loading_bg;
        local isRand=currCfg.loading_player and currCfg.loading_player==2 or false;
        if #bgs>1 and isRand then
            local rand=math.random(1,#bgs);
            if rand==currIdx then --重复则id+1或重置
                currIdx=rand+1>#bgs and 1 or rand+1;
            else
                currIdx=rand;
            end
        elseif #bgs>1 then
            currIdx=currIdx+1>#bgs and 1 or currIdx+1;
        else
            currIdx=1;
        end
        ResUtil:LoadBigImg2(bg,"UIs/BGs/"..bgs[currIdx].."/bg",false);
    else
        ---CSAPI.LoadImg(bg,"UIs/Loading/bg.png",false,nil,true);
    end
end

function OnInit()
     bar = ComUtil.GetCom(goBar,"BarBase");     
     bar:AddCallBack(OnComplete);    
     list = {};
     OnWeightApply(weight_key);
          
     FuncUtil:Call(OnWeightUpdate,nil,500,weight_key);

     InitListener();

    EventMgr.Dispatch(EventType.Loading_Start);    

end


function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Loading_Weight_Apply,OnWeightApply); 
    eventMgr:AddListener(EventType.Loading_Weight_Update,OnWeightUpdate);
    eventMgr:AddListener(EventType.Loading_View_Delay_Close,OnDelayClose);
    eventMgr:AddListener(EventType.Scene_Load,OnSceneLoad);
end
function OnDestroy()
    eventMgr:ClearListener();
    
    EventMgr.Dispatch(EventType.Loading_View_Close);    
end
   
function OnDelayClose(time)
    delayCloseTime = time;
    --LogError(delayCloseTime);
end

function RefreshLoadContent()
    local str = "";
    for k,v in pairs(list)do
        str = k .. ":" .. v .. "\n";
    end
    CSAPI.SetText(loadContent,str);
end

function OnWeightApply(name)   
    list[name] = 0;
    --RefreshLoadContent();
    --LogError(list);
end

function OnWeightUpdate(name)
    list[name] = 1;
    --RefreshLoadContent();
    --LogError(list);
    local count = 0;
    local max = 0;
    for _,v in pairs(list)do
        max = max + 1;
        if(v == 1)then
            count = count + 1;
        end
    end
    --LogError("加载进度：" .. count .. "/" .. max);
    bar:SetFullProgress(count,max);
end

function Update()
    if(txtPercent)then
        txtPercent.text = string.format(math.ceil(bar.currFillProgress*100)).."%";
    end
end

function OnComplete()
    --LogError("加载完成===========================");
    if blackTween then --播放变黑动画
        CSAPI.SetGOActive(blackTween,true);
        FuncUtil:Call(OnCompleteFunc,nil,300);
    else
        OnCompleteFunc();
    end
end

function OnCompleteFunc()
    EventMgr.Dispatch(EventType.Loading_Complete);

    --if(CSAPI.GetPlatform() == )
    --移除登陆动画
    if SceneMgr and SceneMgr:IsLoginLoading() then
        SceneMgr:SetLoginLoaded(false);
        UIUtil:RemoveLoginMovie();
    end
    ApplyClose();

     --加载完成，尝试触发引导
    EventMgr.Dispatch(EventType.Guide_Trigger, "Loaded");
end

function ApplyClose()
    if(delayCloseTime)then
        FuncUtil:Call(Close,nil,delayCloseTime);
    else
        Close()
    end
end
function Close()    
    --LogError("close loading view");
    if(view and view.Close) then		   
        view:Close(); 
        view = nil; 

        CSAPI.DisableInput(500);
    end
end

function OnClick()
    CSAPI.SetGOActive(loadContent,true);
    CSAPI.SetText(loadContent,table.tostring(list));     
end