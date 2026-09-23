local top=nil;
local eventMgr=nil;
local items={};
local sBar=nil;
local btnDatas={};
local btnItems={};
local curData=nil;
local timer=0
local curTime=0;
local fixedTime=1;
local animator1=nil;
local animator2=nil;

function Awake()
    top=UIUtil:AddTop2("RiddleMain",gameObject,OnClickClose);
    sBar=ComUtil.GetCom(slider,"Slider");
    animator1=ComUtil.GetCom(root,"Animator");
    animator2=ComUtil.GetCom(slider,"Animator");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Riddle_Data_Ret,OnDataRet);
    eventMgr:AddListener(EventType.Riddle_Draw_Ret,OnDrawRet);
    eventMgr:AddListener(EventType.Riddle_Reward_Ret,OnRewardRet)
end

function OnDestroy()
    eventMgr:ClearListener();
 end

 --data：活动ID
function OnOpen()
    --获取活动数据
    OperateActiveProto:GetQuestionInfo(openSetting);
    FuncUtil:Call(SetAnima,nil,400)
end

function SetAnima()
    if not IsNil(gameObject) and not IsNil(animator1) then
        animator1.enabled=true
    end
    if not IsNil(gameObject) and not IsNil(animator2) then
        animator2.enabled=true
    end
end

function OnDataRet()
    curData=RiddleMgr:GetData(openSetting);
    Refresh()
end

function SetTime()
    if curData==nil then
        do return end
    end
    local eTime=curData:GetEndTime();
    local time=TimeUtil:GetTime();
    if eTime then
        local eTime2=TimeUtil:GetTimeStampBySplit(eTime);
        timer=eTime2-time;
        local tab = TimeUtil:GetTimeTab(timer)
        LanguageMgr:SetText(txtTime,80008,tab[1],tab[2],tab[3])
    end
    if timer<=0 then
        HandlerOver()
    end
end

function Refresh()
    if curData==nil then
        do return end
    end
    --设置猜对的数量
    local num=curData:GetAnswerCnt();
    local maxNum=curData:GetQuestionMaxNum();
    CSAPI.SetText(txtRewardNum,string.format("<size=120>%s</size>/%s",num,maxNum));
    InitRewardBtns()
    InitItems();
    SetTime();
end

function InitRewardBtns(rewardID)
    -- 初始化奖励按钮
    local rewardCfg = curData:GetRewardCfgs();
    if rewardCfg ~= nil then
        btnDatas = rewardCfg.item;
    end
    ItemUtil.AddItems("Riddle/RiddleRewardItem", btnItems, btnDatas, sliderNode, nil, 1, {activityData=curData,curIdx=rewardID},function()
        --获取对应位置的百分比
        if curData then
            local num=curData:GetAnswerCnt();
            if not IsNil(sBar) and not IsNil(btnItems[num]) then
                -- sBar.value=num/maxNum
                sBar.value=btnItems[num].GetProgress()
            else
                sBar.value=0;
            end
        end
    end)
end


function InitItems()
    local maxNum=curData:GetQuestionMaxNum();
    for i = 1,maxNum  do
        local day=curData:GetQuestionOpenTimeByIndex(i);
        local itemData=curData:GetQuestionByDay(i);
        if #items >= i then
            CSAPI.SetGOActive(items[i].gameObject, true);
            items[i].Refresh(itemData,{activityData=curData,day=day,index=i});
        else
            local go = ResUtil:CreateUIGO("Riddle/RiddleItem", this["item" .. i].transform);
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh(itemData,{activityData=curData,day=day,index=i});
            table.insert(items, lua)
        end
    end
    if maxNum>#items then
        for i=maxNum,#items do
            CSAPI.SetGOActive(items[i].gameObject,false);
        end
    end
end

-- 活动结束
function HandlerOver()
    CSAPI.CloseAllOpenned();
    FuncUtil:Call(function()
        Tips.ShowTips(LanguageMgr:GetTips(24001));
    end, nil, 100);
end

function OnClickClose()
    view:Close();
end

function OnDrawRet(proto)
    Refresh();
    if proto and proto.gets~=nil and next(proto.gets) then
        UIUtil:OpenReward({proto.gets})
    end
end

function Update()
    if timer>0 then 
        curTime=curTime+Time.deltaTime;
        if curTime>=fixedTime then
            curTime=0;
            SetTime();
        end
    end
end

function OnRewardRet(proto)
    if proto==nil then
        do return end;
    end
    if proto.gets then
        UIUtil:OpenReward({proto.gets})
    end
    local rewardNext=nil;
    if proto.reward then
        rewardNext=proto.reward[#proto.reward]
    end
    curData=RiddleMgr:GetData(proto.id);
    InitRewardBtns(rewardNext);--最后一个即是最新领取的那个
end