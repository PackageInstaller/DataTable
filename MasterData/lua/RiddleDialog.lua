local eventMgr=nil;
local list={};
local btnList={};
local ids={80005,80006,80007}
local canClick=true;
local fixedTime=1;
local timer=0;
local curTime=fixedTime;
local animator=nil;
local isPlay=false;
local curLangID=nil;
local isTure=false;
local isFirst=true;
local currHistory={};

function Awake()
    animator=ComUtil.GetCom(Result_scale,"Animator");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Riddle_Draw_Ret,OnDrawRet);
end

function OnDestroy()
    currHistory={};
    eventMgr:ClearListener();
    if isTure and data then --答对时清空计时器
        local acvtivityData=data:GetActivityData();
        if acvtivityData then
            RiddleMgr:SetTimer(acvtivityData:GetID(),0)
        end
    end
end

--data:RiddleInfo
function OnOpen()
    Refresh();
end

function OnDrawRet(proto)
    if proto then
        isTure=proto.res;
        table.insert(currHistory,proto.answerIndex);
    end
    if data then
        local acvtivityData=data:GetActivityData();
        if acvtivityData then
            data=acvtivityData:GetQuestionByDay(data:GetDay());
        end
        -- LogError(data)
    end
    Refresh();
end

function Refresh()
    if data then
        local acvtivityData=data:GetActivityData();
        if acvtivityData and acvtivityData:GetTargetTimeStamp()~=0 and acvtivityData:GetTargetTimeStamp()>TimeUtil:GetTime()   then
            timer=acvtivityData:GetTargetTimeStamp();
        end
        CSAPI.SetText(txtContent,data:GetContent());
        local cfg=data:GetCfg();
        --初始化答题按钮
        list={};
        for k, v in ipairs(data:GetAnswers()) do
            if cfg and cfg.infos and cfg.infos[v] then
                table.insert(list,cfg.infos[v]);
            end
        end
        CSAPI.SetText(txtTitle,LanguageMgr:GetByID(80004,data:GetDay()));
        if timer and timer==0 then
            local index=1;--1：未选择，2：答对3：答错
            local history=data:GetAnswerHistorys();
            if data:IsTure() then
                index=2;
            elseif history~=nil and next(history)~=nil then
                index=3;
            end
            CSAPI.SetText(txtResult,LanguageMgr:GetByID(ids[index]));
            PlayBoxAnima(ids[index]);
        end
        ItemUtil.AddItems("Riddle/RiddleBtn", btnList, list, layout,nil,1,{question=data,isCD=timer~=0,isFirst=isFirst,history=currHistory})
        isFirst=false;
    end
end

function PlayBoxAnima(lID)
    if isPlay or IsNil(animator) or lID==curLangID then
        do return end
    end
    curLangID=lID;
    animator.enabled=true;
    animator:Play("Result_entry",-1,0);
    isPlay=true;
    FuncUtil:Call(function()
        isPlay=false;
        if IsNil(animator)~=true then
            animator.enabled=false;
        end
    end,nil,255);
end

function UpdateInfo()
    --计算时间戳
    if data then
        local num=0;
        if timer then
            num=math.floor(timer-TimeUtil:GetTime()+0.5);
        end
        if num>0 then
            --更新对话框状态
            local lID=nil;
            if data:IsTure() then
                CSAPI.SetText(txtResult,LanguageMgr:GetByID(80006,num));
                lID=80006
            else
                CSAPI.SetText(txtResult,LanguageMgr:GetByID(80009,num));
                lID=80009
            end
            PlayBoxAnima(lID)
        else
            timer=0;
            if data:IsTure() then
                OnClickClose()
            else
                Refresh();
            end
        end
    end
end

function Update()
    if timer~=0 then
        curTime=curTime+Time.deltaTime;
        if curTime>=fixedTime then
            UpdateInfo()
            curTime=0;
        end
    end
end

function  OnClickClose()
    view:Close();
end

function OnClickMask()
    view:Close();
end