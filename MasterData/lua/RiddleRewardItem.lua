local eventMgr=nil;
local isOver=false;
local canReivce=false;
local fakeData=nil;
local elseData=nil;
local animator=nil;
local progress=0;--当前点位的百分比
local x=nil;
local clickImg=nil;

function Awake()
    animator=ComUtil.GetCom(gameObject,"Animator");
    clickImg=ComUtil.GetCom(bg,"Image")
    eventMgr = ViewEvent.New();
end

function OnDestroy()
    eventMgr:ClearListener();
end

function Refresh(cfg,_elseData)
    elseData=_elseData;
    if cfg then
        if elseData then
            isOver=elseData.activityData:IsReivce(cfg.index); 
            if not isOver then
                canReivce=elseData.activityData:GetAnswerCnt()>=cfg.count;
            else
                canReivce=false;
            end
        end
        clickImg.raycastTarget=not isOver
        -- CSAPI.LoadImg(bg,canReivce and "UIs/Riddle/img_02_03.png" or "UIs/Riddle/img_02_02.png",true,nil,true)
        CSAPI.SetGOActive(overObj,isOver);
        CSAPI.SetGOActive(Glow,canReivce);
        fakeData=BagMgr:GetFakeData(cfg.reward[1][1]);
        if fakeData then
            fakeData:GetIconLoader():Load(icon,fakeData:GetIcon());
        end
        CSAPI.SetImgColor(icon,255,255,255,isOver and 122 or 255);
        CSAPI.SetText(txtCount,tostring(cfg.reward[1][2]));
        CSAPI.SetText(txtNum,tostring(cfg.count));

    end
    if this.index then
        CountPos();
        FuncUtil:Call(SetAnima,nil,400+120*this.index);
    end
end

function SetIndex(idx)
    this.index=idx;
end

--计算位置
function CountPos()
    if elseData==nil or this.index==nil then
        do return end
    end
    local maxNum=elseData.activityData:GetRewardsNum();
    x=maxNum==0 and 0 or this.index * (720/maxNum);
    progress=x/720;
    -- LogError(tostring(x).."\t"..tostring(progress).."\t"..tostring(maxNum))
    CSAPI.SetAnchor(gameObject,x,0);
end

function GetProgress()
    return progress;
end

function SetAnima()
    if not IsNil(gameObject) and not IsNil(animator) then
        animator.enabled=true;
    end
end

function OnClick()
    if canReivce then
        if elseData and elseData.activityData then
            OperateActiveProto:TakeQuestionReward(elseData.activityData:GetID(),this.index)
        end
    elseif fakeData then
        CSAPI.OpenView("GoodsFullInfo",{data=fakeData});
    end
end