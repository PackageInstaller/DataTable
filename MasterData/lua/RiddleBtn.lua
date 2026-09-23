
local data=nil;
local elseData=nil;
local  index=1;
local animator=nil;
local clickImg=nil;
local canvasGroup=nil;
local state=1;

function Awake()
    animator=ComUtil.GetCom(gameObject,"Animator")
    clickImg=ComUtil.GetCom(gameObject,"Image");
    canvasGroup=ComUtil.GetCom(node,"CanvasGroup");
end

function Refresh(_d,_ed)
    data=_d;
    elseData=_ed;
    if data and elseData then
        -- local list=elseData.question:GetAnswerHistorys();
        if elseData.history then
            for k, v in ipairs(elseData.history) do
                if v==data.index then
                    state=data.isright and 2 or 3;
                    break;
                end
            end
        end
        if state==3 then
            CSAPI.LoadImg(img,"UIs/Riddle/img_07_02.png",true,nil,true);
            CSAPI.LoadImg(resultImg,"UIs/Riddle/img_04_03.png",true,nil,true);
            CSAPI.SetScale(resultImg,1.33,1.33,1.33)
            CSAPI.SetAnchor(resultImg,-4.5,-16.5);
        elseif state==2 then
            CSAPI.LoadImg(img,"UIs/Riddle/img_07_01.png",true,nil,true);
            CSAPI.LoadImg(resultImg,"UIs/Riddle/img_04_01.png",true,nil,true);
            CSAPI.SetScale(resultImg,1,1,1)
            CSAPI.SetAnchor(resultImg,-4.5,0);
        end
        CSAPI.SetText(txtContent,_d.answer);
        CSAPI.SetGOActive(resultImg,state~=1)
        CSAPI.SetGOActive(img1,state==2)
        CSAPI.SetGOActive(img2,state==3)
        clickImg.raycastTarget=elseData.isCD~=true;
        canvasGroup.alpha=elseData.isCD~=true and 1 or 0.5;
        if not IsNil(animator) then
            animator.enabled=state~=1;
        end
    end
end

function SetIndex(i)
    index=i;
    CSAPI.LoadImg(img3,"UIs/Riddle/img_06_0"..i..".png",true,nil,true);
end

function OnClickClose()
    if data and elseData then
        local activityData=elseData.question:GetActivityData();
        if activityData and state==1 then
            OperateActiveProto:AnswerQuestion(activityData:GetID(),elseData.question:GetID(),data.index)
        end
    end
end