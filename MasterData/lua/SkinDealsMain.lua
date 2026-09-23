local eventMgr=nil;
local items={};
local record=nil; --领取记录
local ActivityData=require "ActivityData"
local roleItem=nil;
function Awake()
    UIUtil:AddTop2("SkinDealsMain",gameObject,OnClickClose)
    -- UIUtil:AddQuestionItem("PuzzleActivity", gameObject, quest)
    CSAPI.SetGOActive(btnShop1,false)
    roleItem = RoleTool.AddRole(imgNode, nil, nil, false)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
    eventMgr:AddListener(EventType.SkinDeals_Update,Refresh)
end

function OnDestroy()
    eventMgr:ClearListener();
end

--data:ActivityData
function OnOpen()
    -- data=ActivityData.New();
    -- data:Init(Cfgs.CfgActiveList:GetByID(1044));
    data=ActivityMgr:GetALData(ActivityListType.SkinDeals);
    -- record={
    --     dailyReward=true,
    --     nums={
    --         1,3
    --     }
    -- }
    Refresh();
end

function FormatTime(num)
    if num==nil then
        return "00"
    end
    if num>9 then
        return tostring(num)
    else
        return "0"..tostring(num)
    end
end

function Refresh()
    record=SkinDealsMgr:GetData();
    if data~=nil then
        --加载人物立绘
        local info=data:GetInfo();
        local modelId=info.modelId;
        if (modelId) then
            -- if info.type==1 then
            --     -- 初始化立绘
                roleItem.Refresh(modelId, LoadImgType.Main, nil, false, false)
            -- elseif info.type==2 then
            --     roleItem.Refresh(modelId, LoadImgType.Main, nil, false, false)
            -- end
        end
        --设置时间
        local sTime=TimeUtil:GetTimeHMS(data:GetStartTime(),"*t");
        local eTime=TimeUtil:GetTimeHMS(data:GetEndTime(),"*t");
        CSAPI.SetText(txtTime,string.format(LanguageMgr:GetByID(45033),sTime.month,sTime.day,FormatTime(sTime.hour),FormatTime(sTime.min),FormatTime(sTime.sec),eTime.month,eTime.day,FormatTime(eTime.hour),FormatTime(eTime.min),FormatTime(eTime.sec)));
        local str=LanguageMgr:GetByID(18052)
        if info and info.languageId then
            str=LanguageMgr:GetByID(info.languageId)
        end
        CSAPI.SetText(txtShop2,str)
        --初始化奖励格子
        local num=0;
        if info.ids~=nil and #info.ids>0 then
            num=#info.ids;
            CSAPI.SetGOActive(task2,num>1)
            CSAPI.SetRTSize(taskBg,710,num>1 and 386 or 220)
            for i, v in ipairs(info.ids) do
                local tab=nil;
                if i>#items then
                    local go=ResUtil:CreateUIGO("SkinDeals/SkinDealsGrid",this["taskNode"..i].transform);
                    tab=ComUtil.GetLuaTable(go)
                    table.insert(items,tab);
                else
                    tab=items[i]
                end
                local num=0;
                local rNum=0;--领取数量
                if info.nums~=nil and i<=#info.nums then
                    num=info.nums[i]
                end
                if record~=nil and record.nums~=nil and i<=#record.nums then
                    rNum=record.nums[i]
                end
                if tab then
                    tab.Refresh({id=v,num=num,rNum=rNum});
                end
            end
        end
        for i=(num+1), #items do
            CSAPI.SetGOActive(items[i].gameObject,false);
        end
        --初始化每日奖励状态
        local isReward=record~=nil and record.dailyReward==true or false;
        CSAPI.SetGOAlpha(rewardOn,isReward and 0.4 or 1);
        -- CSAPI.SetGOActive(rewardOn,isReward~=true);
        CSAPI.SetGOActive(rewardOver,isReward);
        SetRedInfo()
    end
end

function SetRedInfo()
    local redInfo=RedPointMgr:GetData(RedPointType.SkinDeals);
    UIUtil:SetRedPoint(redNode,redInfo==true);
end

function OnClickReward()
    --领取每日奖励
    local isReward=record~=nil and record.dailyReward==true or false;
    if isReward~=true then
        OperateActiveProto:GetSkinDiscountDaily();
    elseif data~=nil then
        --显示物品信息
        local info=data:GetInfo();
        if info.signReward~=nil then
            local goods=GridUtil.GetGridObjectDatas2(info.signReward);
            if goods~=nil then
                CSAPI.OpenView("GoodsFullInfo",{data=goods[1]});
            end
        end
    end
end

function OnClickShop2()
    --跳转商城
    local info=data:GetInfo();
    if info and info.jumpId then
        JumpMgr:Jump(info.jumpId);
    else
        JumpMgr:Jump(140008);
    end
end

function OnClickShop()
    JumpMgr:Jump(140002);
end

function OnClickClose()
    if IsNil(gameObject) or IsNil(view) then
        return;
    end
    view:Close();
end

------------------------------------------------------------------------------
---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    OnClickClose();
end