local top = nil;
local eventMgr = nil;
local currData = nil;
local layout = nil;
local layout2 = nil;
local layout3 = nil;
local curTaskDatas = {};
local curCommGets={};
local bar = nil;
local buyClicker=nil;
local redInfo=nil;
local endTime=0;
local fixedTime=1;
local upTime=0;
function Awake()
    top = UIUtil:AddTop2("CharacterRaising", gameObject, OnClickClose);
    layout = ComUtil.GetCom(vsv, "UISV");
    layout:Init("UIs/CharacterRaising/CharacterRaisingTab", LayoutCallBack, true, 1)
    layout2 = ComUtil.GetCom(vsv2, "UISV");
    layout2:Init("UIs/CharacterRaising/CharacterRaisingMissionItem", LayoutCallBack2, true, 1)
    layout3 = ComUtil.GetCom(hsv, "UISV");
    layout3:Init("UIs/CharacterRaising/CharacterRaisingGrid", LayoutCallBack3, true, 1)
    bar = ComUtil.GetCom(expBar, "Slider");
    buyClicker = ComUtil.GetCom(btnBuy, "Image");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.CharacterRaising_Tab_Click, OnTabClick);
    eventMgr:AddListener(EventType.CharacterRaising_Update, Refresh);
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRedPoint);
    eventMgr:AddListener(EventType.Mission_List,OnMissionListRefresh)
    eventMgr:AddListener(EventType.CharacterRaising_Reward_Update,OnRewardUpdate);
end

function OnDestroy()
    eventMgr:ClearListener();
    CharacterRaisingMgr:RecordNewInfo();
    CharacterRaisingMgr:CheckNewInfo()
    CharacterRaisingMgr:RecordRedInfo(redInfo);
    CharacterRaisingMgr:CheckRed()
end

function OnOpen()
    Refresh();
end

function Refresh()
    data = CharacterRaisingMgr:GetDatas();
    if data == nil then
        LogError("未获取到活动数据！");
        do
            return;
        end
    end
    redInfo=RedPointMgr:GetData(RedPointType.CharacterRaising);
    if data~=nil and currData==nil then
        currData = data[1];
    end
    InitContent();
end

function InitContent()
    if #data>1 then
        layout:IEShowList(#data);
    end
    CSAPI.SetGOActive(vsv, #data>1);
    if currData == nil then
        return
    end
    local et=currData:GetEndTimeStamp();
    endTime=et-TimeUtil:GetTime();
    -- 初始化立绘
    local card = currData:GetCard();
    if card==nil then
        LogError("卡牌不存在！培养引导活动id："..currData:GetID().."的cardId："..tostring(currData.cfg.cardId));
    else
        CSAPI.SetText(txtTips, LanguageMgr:GetByID(341002, card:GetName()));
        ResUtil.ImgCharacter:Load(cImg, card:GetDrawImg());
    end
    local offset=currData:GetOffset() or {0,0,1}
    local scale=(offset and #offset>=3) and offset[3] or 1;
    CSAPI.SetAnchor(cNode,offset[1],offset[2]);
    CSAPI.SetScale(cNode,scale,scale,scale)
    -- 初始化售卖道具
    local reward,isLock,idx = currData:GetCurrStageReward();
    if reward then
        -- CSAPI.SetText(txtTopTitle, comm:GetName());
        local currBuyNum = currData:GetBuyLimitByIndex(idx);
        CSAPI.SetText(txtTopTips, LanguageMgr:GetByID(341001, currBuyNum));
        CSAPI.SetText(txtTopNum, currData:GetFinishCount() .. "/" .. tostring(currBuyNum))
        bar.value = currBuyNum > 0 and currData:GetFinishCount() / currBuyNum or 0;
        curCommGets={};
        for k, v in ipairs(reward.item) do
            local goods=GridUtil.RandRewardConvertToGridObjectData({id=v.id,num=v.count,type=v.type});
            table.insert(curCommGets, goods);
        end
    else
        curCommGets={};
        LogError("未获取到培养引导活动id：" .. currData:GetID() ..
                     "的售卖商品信息，当前完成任务数量：" .. tostring(currData:GetFinishCount()));
    end
    RefreshDownTime()
    local showBuyRed=false;
    local isRevice=currData:IsRevice(reward.id);
    if not isLock and isRevice~=true and redInfo and redInfo[currData:GetID()] and redInfo[currData:GetID()].commBuy then
        showBuyRed=true;
    end
    local canBuy=isLock~=true and isRevice~=true or false;
    UIUtil:SetRedPoint(btnBuy, showBuyRed, 110, 45, 0)
    CSAPI.SetGrey(btnBuy,not canBuy,true)
    CSAPI.SetGOAlpha(btnBuy,not canBuy and 0.5 or 1);
    CSAPI.SetText(txt_free,isRevice and LanguageMgr:GetByID(341006) or LanguageMgr:GetByID(6011));
    buyClicker.raycastTarget=canBuy;
    -- 设置任务列表
    curTaskDatas = currData:GetTaskList();
    layout2:IEShowList(#curTaskDatas);
    layout3:IEShowList(#curCommGets);
end

function SetRedPoint()
    redInfo=RedPointMgr:GetData(RedPointType.CharacterRaising);
    InitContent();
end

function LayoutCallBack(index)
    local _data = data[index]
    local grid = layout:GetItemLua(index);
    local isRed=false;
    if redInfo and redInfo[_data:GetID()] then
        isRed=true;
    end
    grid.Refresh(_data, {
        id = currData and currData:GetID() or nil,
        isRed=isRed;
    });
end

function LayoutCallBack2(index)
    local _data = curTaskDatas[index]
    local item = layout2:GetItemLua(index);
    item.Refresh(_data);
end

function LayoutCallBack3(index)
    local _data = curCommGets[index];
    local grid = layout3:GetItemLua(index);
    grid.Refresh(_data);
end

function OnTabClick(_eventData)
    if _eventData and currData~=_eventData then
        currData = _eventData;
        InitContent();
    end
end

function OnClickBuy()
    local reward,isLock = currData:GetCurrStageReward();
    if redInfo and redInfo[currData:GetID()] and redInfo[currData:GetID()].commBuy then
        CharacterRaisingMgr:RecordRedInfo(redInfo,currData:GetID());
        CharacterRaisingMgr:CheckRed()
    end
    if not isLock and reward and currData:IsRevice(reward.id)~=true then
        -- ShopCommFunc.OpenPayView(comm)
        --发送领取
        TaskProto:GetRoleGuideReward(currData:GetID())
    end
end

function OnClickClose()
    if not IsNil(view) then
        view:Close();
    end
end

function OnMissionListRefresh(eventData)
    if eventData and eventData[1]==eTaskType.RoleTrainGuild  then
        UIUtil:OpenReward({eventData[2]});
    end
    data = CharacterRaisingMgr:GetDatas();
    if data~=nil then
        for k, v in ipairs(data) do
            if currData and currData:GetID()==v:GetID() then
                currData=v;
                break;
            end
        end
    end
    Refresh()
end

--检测活动是否过期
function Update()
    if endTime and endTime>0 then
        upTime=upTime+Time.deltaTime;
        if upTime>=fixedTime then
            endTime=endTime-fixedTime;
            RefreshDownTime();
            upTime=0;
        end
    end
end

--领取奖励返回
function OnRewardUpdate(proto)
    if proto and proto.gets then
        UIUtil:OpenReward({proto.gets});
    end
end

function RefreshDownTime()
    if currData then
        local t=currData:GetEndTimeStamp();
        local count=TimeUtil:GetDiffHMS(t,TimeUtil.GetTime());
        if count.day>=0 and (count.hour>0 or count.minute>0 or count.second>=0) then
            CSAPI.SetText(txtTime,string.format(LanguageMgr:GetByID(341008),count.day or 0,count.hour>9 and count.hour or "0"..count.hour));
        -- elseif count.day==0 and (count.hour>0 or count.minute>0 or count.second>60) then
        else
            CSAPI.SetText(txtTime,string.format(LanguageMgr:GetByID(341008),0,"00","00"));
        end
    end
    if endTime<=0 then--回到主界面并提示
        HandlerOver();
    end
end

function HandlerOver()
    CSAPI.CloseAllOpenned();
    FuncUtil:Call(function()
        Tips.ShowTips(LanguageMgr:GetTips(24001));
    end,nil,100);      
end