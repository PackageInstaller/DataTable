--宠物运动
local pet=nil;
local curScene=1;
local curTime=0;
local sportInfoList=nil;
local sportInfo=nil;
local isSporting=false;
local slider=nil;
local endTime=0;
local fixedTime=1;
local upTime=0;
local tween=nil;
local eventMgr=nil;
local inviteTime=0;

function Awake()
    slider=ComUtil.GetCom(infoBar,"Slider");
    tween=ComUtil.GetCom(infoNode,"ActionFadeCurve");
    sportInfoList=PetActivityMgr:GetAllSportInfos();
    InitScenesInfo();
    CSAPI.SetText(txtS1,LanguageMgr:GetByID(62025));
    CSAPI.SetText(txtS2,LanguageMgr:GetByID(62026));
    CSAPI.AddSliderCallBack(infoBar,OnSliderChange);
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.PetActivity_Sport_Ret,OnSportRet);
    eventMgr:AddListener(EventType.PetActivity_Exit_Sport,Refresh)
end

function OnDestroy()
    CSAPI.RemoveSliderCallBack(infoBar,OnSliderChange);
    eventMgr:ClearListener();
end

function OnSliderChange(val)
    SetSliderVal(val);
end

function Init()
    EventMgr.Dispatch(EventType.PetActivity_SetLine_State,{state=false});
    CleanCache();
    Refresh();
end

function Refresh()
    pet=PetActivityMgr:GetCurrPetInfo();
    isSporting=false;
    CSAPI.SetImgColorByCode(scene1,curScene==1 and "AF3636" or "DECAB5");
    CSAPI.SetImgColorByCode(scene2,curScene==2 and "AF3636" or "DECAB5");
    if sportInfoList and #sportInfoList>=curScene then
        sportInfo=sportInfoList[curScene]
        --显示描述内容
        CSAPI.SetText(txtTitle,sportInfo:GetName());
        CSAPI.SetText(txtDesc,sportInfo:GetDesc());
        SetArrow(arrow1,sportInfo:GetHappyChange(1)>0);
        SetArrow(arrow2,sportInfo:GetFoodChange(1)>0);
        SetArrow(arrow3,sportInfo:GetWashChange(1)>0);
        inviteTime=sportInfo:GetIntervalTime() or 0;
        slider.minValue=sportInfo:GetMinTime();
        slider.maxValue=sportInfo:GetMaxTime();
    end
    if pet and (pet:GetCurrAction()==PetTweenType.sport or pet:GetCurrAction()==PetTweenType.walk) then --运动中
        isSporting=true;
        --显示剩余运动时间
        -- local sTime=pet:GetCurrSportStartTime();
        -- local kTime=pet:GetKeepTime();
        -- if sTime~=0 and kTime~=0 then
        --     local time=TimeUtil:GetTime()-sTime;
        --     endTime=kTime-time;
        -- end
        endTime=pet:GetKeepTime();
        RefreshDownTime()
        -- if pet:GetCurrAction()==PetTweenType.sport then
        --     CSAPI.SetText(txtS1,LanguageMgr:GetByID(62025));
        --     CSAPI.SetText(txtS2,LanguageMgr:GetByID(62033));
        -- elseif pet:GetCurrAction()==PetTweenType.walk then
        --     CSAPI.SetText(txtS1,LanguageMgr:GetByID(62033));
        --     CSAPI.SetText(txtS2,LanguageMgr:GetByID(62026));
        -- else
            -- CSAPI.SetText(txtS1,LanguageMgr:GetByID(62025));
            -- CSAPI.SetText(txtS2,LanguageMgr:GetByID(62026));
        -- end
    else  --初始化选择运动时间
        SetSliderVal(slider.value)
    end
    CSAPI.SetGOActive(btnS1,not isSporting);
    CSAPI.SetGOActive(btnS2,not isSporting);
    CSAPI.SetGOActive(btnS3,isSporting);
    CSAPI.SetGOActive(infoNode,not isSporting);
    CSAPI.SetGOActive(infoNode2,isSporting);
end

function SetArrow(go,isUp)
    CSAPI.SetImgColorByCode(go,isUp and "6EA848" or "AF3636")
    CSAPI.SetScale(go,1,isUp and 1 or -1,1);
end

function InitScenesInfo()
    if sportInfoList and #sportInfoList>0 then
        for k,v in ipairs(sportInfoList) do
            CSAPI.LoadImg(this["sIcon"..k],"UIs/Pet/"..v:GetIcon()..".png",true,nil,true);
        end
    end
end

function Show()
    if IsNil(gameObject) then
        do return end
    end
    CSAPI.SetAnchor(gameObject,0,0);
    CSAPI.SetGOActive(enterTween,true);
end

function Hide()
    if IsNil(gameObject) then
        do return end
    end
    CSAPI.SetAnchor(gameObject,10000,10000);
    CSAPI.SetGOActive(enterTween,false);
end

function SetSliderVal(val)
    if inviteTime then
        curTime=math.floor((val-val%inviteTime)/60);
        CSAPI.SetText(txtTime,tostring(curTime));
    end
end

function OnClickScene(key)
    if pet and (pet:GetCurrAction()==PetTweenType.sport or pet:GetCurrAction()==PetTweenType.walk) then
        Log("正在运动中...");
        do return end;
    end
    if tween then
        tween:Play();
    end
    if curScene~=key then
        curScene=key;
        SetSliderVal(0);
        Refresh();
    end
end

function OnClickScene1()
    OnClickScene(1)
end

function OnClickScene2()
    OnClickScene(2)
end

function RefreshDownTime()
    --设置时分秒
    if pet then
        CSAPI.SetText(txtTime2,tostring(math.floor(endTime/60)));
        CSAPI.SetText(txtTimeS2,tostring(endTime%60));
    end
end

function Update()
    upTime=upTime+Time.deltaTime;
    if upTime>=fixedTime then
        if endTime and endTime>0 then
            endTime=pet:GetKeepTime();
            if endTime==0 then--改变状态并刷新界面
                Refresh();
            end
            RefreshDownTime();
        end
        upTime=0;
    end
end

--散步
function OnClickS1()
    SendAction(PetTweenType.walk,PetSportType.Move)
end

--运动
function OnClickS2()
    SendAction(PetTweenType.sport,PetSportType.Run)
end

--停止
function OnClickS3()
    SendAction(PetTweenType.sport,PetSportType.Stop)
end

function SendAction(actionType,sportType)
    if pet==nil or actionType==nil or sportType==nil then
        do return end;
    end
    local time=curTime*60;
    if pet:GetCurrAction()==actionType then --运动中
        --发送停止
        SummerProto:PetSport(PetSportType.Stop,time,sportInfo:GetID());
    else
        --判定消耗是否足够！
        if PetActivityMgr:CheckCanSport(pet:GetID(),sportInfo,sportType) then
            --发送运动时长
            SummerProto:PetSport(sportType,time,sportInfo:GetID());
        end
    end
end

function OnSportRet()
    Refresh();
end

function CleanCache()
    curScene=1;
    curTime=0;
    pet=nil;
    endTime=0;
end