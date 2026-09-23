local data=nil;
local elseData=nil;
local clickImg=nil
local animator=nil;
local state=1;
function Awake()
    clickImg=ComUtil.GetCom(bg,"Image");
    animator=ComUtil.GetCom(gameObject,"Animator");
end

function Refresh(_data,_elseData)
    data=_data;
    elseData=_elseData;
    if elseData==nil or elseData.activityData==nil then
        LogError("猜谜活动未获取到对应活动数据!");
        do return end;
    end
    local day=elseData and elseData.day or 0;
    local question=nil;
    if day>1 then
        question=elseData.activityData:GetQuestionByDay(day-1)
    end
    if data and data:IsTure()~=true and (question==nil or (question~=nil and question:IsTure())) then
        state=1;
    elseif elseData and elseData.activityData and elseData.activityData:GetOpenDays()>=day and (data==nil or (data and data:IsTure())) then
        state=3;
    else
        state=2;
    end
    SetState(state)
    if elseData and elseData.index then
        FuncUtil:Call(SetAnima,nil,60*elseData.index);
    end
end

function SetAnima()
    if not IsNil(gameObject) and not IsNil(animator) then
        animator.enabled=true;
    end
end

function SetState(state)
    local img="img_03_01"
    -- 
    if state==2 then
        CSAPI.SetGOActive(lockObj,true);
        CSAPI.SetGOActive(overObj,false);
        CSAPI.SetGOActive(Darken,false);
        CSAPI.SetGOActive(effect,false);
         img="img_03_02"
        --  clickImg.raycastTarget=false;
    elseif state==3 then
        CSAPI.SetGOActive(overObj,true);
        CSAPI.SetGOActive(lockObj,false);
        CSAPI.SetGOActive(Darken,true);
        CSAPI.SetGOActive(effect,false);
         img="img_03_02"
        --  clickImg.raycastTarget=false;
    else
        CSAPI.SetGOActive(lockObj,false);
        CSAPI.SetGOActive(overObj,false);
        CSAPI.SetGOActive(Darken,false);
        CSAPI.SetGOActive(effect,true);
        -- clickImg.raycastTarget=true;
    end
    CSAPI.LoadImg(bg,"UIs/Riddle/"..img..".png",true,nil,true)
end

function OnClick()
    local day=elseData and elseData.day or 0;
    if state==1 then
        CSAPI.OpenView("RiddleDialog",data);
    elseif state==2 then
        local num=day-elseData.activityData:GetOpenDays()
        if num>0 then
            Tips.ShowTips(LanguageMgr:GetTips(52001,num));
        else
            Tips.ShowTips(LanguageMgr:GetTips(52002));
        end
    elseif state==3 and data and data:IsTure()~=true then
        Tips.ShowTips(LanguageMgr:GetTips(52002));
    end
end