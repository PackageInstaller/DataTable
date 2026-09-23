--宠物活动主界面
local stateView=nil;
local leftViews=nil;
local tabList={};
local oTabDatas={
    {id=PetViewType.Bag,idx=1,path="Pet/PetBag"},
    {id=PetViewType.Store,idx=2,path="Pet/PetShop",condId=3},
    {id=PetViewType.Sport,idx=3,path="Pet/PetSport",condId=4},
    {id=PetViewType.Book,idx=4,path="Pet/PetBook",condId=5},
    {id=PetViewType.Pet,idx=5,path="Pet/PetSwitch",condId=6},
}
local tabDatas={};
local eventMgr=nil;
local currTab=1;
local childs={};
local currChild=nil;
local stateObj=nil;
local bSliders={};
local currPet=nil;
local actionSlider=nil;
local pc=nil;
local actionTime=0;
local actionRunTime=0;
local actionBarIsShow=false;
local preView=nil;
local isRed=false;
local runTime=0;
local hasReward=false;
local moneyInfo=nil;
local lastBGM=nil;
local overTime=0;

function Awake()
    actionSlider=ComUtil.GetCom(actionBar,"Slider");
    local bar1=ComUtil.GetCom(expBar1,"Image");
    local bar2=ComUtil.GetCom(expBar2,"Image");
    local bar3=ComUtil.GetCom(expBar3,"Image");
    local bar4=ComUtil.GetCom(expBar4,"Image");
    local cfg=Cfgs.view:GetByKey("PetMain");
    if cfg then
        moneyInfo=cfg.Show_CurrencyType;
    end
    bSliders={bar1,bar2,bar3,bar4}
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.PetActivity_Tab_Click, OnTabClick);
    eventMgr:AddListener(EventType.PetActivity_SetLine_State,SetLineState)
    eventMgr:AddListener(EventType.PetActivity_UseItem_Ret,OnUseItem)
    eventMgr:AddListener(EventType.PetActivity_UpdatePet_Ret,OnPetUpdate)
    eventMgr:AddListener(EventType.PetActivity_BestiaryReward_Ret,SetReward)
    eventMgr:AddListener(EventType.PetActivity_ActionBar_Set,OnActionBarSet)
    eventMgr:AddListener(EventType.PetActivity_AttrCount_Ret,OnPetAttrUpdate)
    eventMgr:AddListener(EventType.PetActivity_Switch_Ret,Refresh)
    eventMgr:AddListener(EventType.PetActivity_SportScene_Check,OnSportSceneCheck)
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
    eventMgr:AddListener(EventType.PetActivity_GainReward_Ret,OnRewardRet)
    eventMgr:AddListener(EventType.Bag_Update, SetMoney);
    -- eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened) 
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed) 
end

function OnDestroy()
    EventMgr.Dispatch(EventType.PetActivity_TimeStamp_Change,0);--立即检查一次宠物状态
    eventMgr:ClearListener();
    DisBGM()
    PetActivityMgr:SaveUnLockList();
end

function DisBGM()
    FuncUtil:Call(function ()
        if lastBGM ~= nil then
            CSAPI.ReplayBGM(lastBGM)
        else
            EventMgr.Dispatch(EventType.Replay_BGM, 50);
        end
    end,this,300)
end

function PlayBGM()
    if g_PetBGM then
        lastBGM=CSAPI.PlayBGM(g_PetBGM,1000);
     end
end

-- function OnViewOpened(viewKey)
--     if viewKey=="DungeonSummer" then
--         EventMgr.Dispatch(EventType.Replay_BGM, 50);
--     end
-- end

function OnViewClosed(viewKey)
    if viewKey=="DungeonSummer" then
        PlayBGM();
    end
end

function OnOpen()
    InitTabDatas()
    Refresh();
    PlayBGM()
end

--检测状态
function InitTabDatas()
    if oTabDatas then
        tabDatas={};
        for k,v in ipairs(oTabDatas) do
            local unLock=true;
            if v.condId then
                local cfg=Cfgs.CfgPetOpenConditionMore:GetByID(v.condId);
                if cfg then
                    unLock=MenuMgr:CheckConditionIsOK(cfg.conditions);
                end
            end
            if unLock then
                table.insert(tabDatas,v);
            end
        end
    end
end

function Refresh(isJump)
    currPet=PetActivityMgr:GetCurrPetInfo();
    if currPet==nil then
        do return end;
    end
    local cfg=Cfgs.CfgActiveEntry:GetByID(16);--获取宠物活动信息
    local str=""
    if cfg and cfg.endTime~=nil then
        local timestamp= TimeUtil:GetTimeStampBySplit(cfg.endTime);
        str=TimeUtil:GetTimeHMS(timestamp, "%Y-%m-%d %H:%M")
    end
    CSAPI.SetText(t2,str);
    PetActivityMgr:CountPetAttr(currPet:GetID());
    SetTabs();
    SetStateObj();
    SetBottomBar();
    SetReward();
    SetLeft();
    SetPet();
end

function Update();
    SetActionBar();
    runTime=runTime+Time.deltaTime;
    if runTime>1 then
        runTime=0;
        if PetActivityMgr:GetNextRewardTime()~=0 and TimeUtil:GetTime()>=PetActivityMgr:GetNextRewardTime() and hasReward~=true then
            SetReward();
            PetActivityMgr:ChecekRedInfo();
        end
        if PetActivityMgr:IsOver() then--活动结束，回到主界面
                CSAPI.CloseAllOpenned();
                FuncUtil:Call(function()
                    Tips.ShowTips(LanguageMgr:GetTips(24001));
                end, nil, 100);
        end
    end
end

function SetLineState(eventData)
    if eventData then
        CSAPI.SetGOActive(lineObj,eventData.state==true);
        if eventData.pos then
            CSAPI.SetAnchor(lineObj,eventData.pos[1],eventData.pos[2]);
        else
            CSAPI.SetAnchor(lineObj,-9.24,-341.6);
        end
    end
end

--宠物
function SetPet()
    if currPet==nil then
        do return end
    end
    --初始化场景
    if currPet:GetSceneName()~=nil then
        ResUtil:LoadBigImg(scene, "UIs/BGs/" ..currPet:GetSceneName() .. "/bg", false)
    end
    
    --初始化宠物控制
    if pc==nil then
        ResUtil:CreateUIGOAsync("Pet/PetController",petNode,function(go)
            pc=ComUtil.GetLuaTable(go);
            pc.Refresh(currPet);
        end);
    else
        pc.Refresh(currPet);
    end
end

function SetReward()
    hasReward=PetActivityMgr:HasRandReward();
    if hasReward~=true and PetActivityMgr:GetNextRewardTime()>0 then
        hasReward=TimeUtil:GetTime()>=PetActivityMgr:GetNextRewardTime();
    end
    CSAPI.SetGOActive(btnReward,hasReward);
    CSAPI.SetGOActive(rewardShowTween,hasReward);
    CSAPI.SetGOActive(rewardHideTween,not hasReward);
end

--设置行动条
function SetActionBar()
    if actionTime and actionRunTime and actionTime>0 and actionRunTime<=actionTime then
        if actionBarIsShow~=true then
            CSAPI.SetGOActive(actionObj,true);
        end
        actionBarIsShow=true;
        actionRunTime=actionRunTime+Time.deltaTime;
        actionSlider.value=actionRunTime/actionTime;
    elseif actionBarIsShow==true then
        actionBarIsShow=false;
        CSAPI.SetGOActive(actionObj,false);
    end
end

--养成值阶段
function SetBottomBar()
    if currPet then
        local maxStage=currPet:GetMaxStage();
        for i=1,#bSliders do
            local isShow=i<=maxStage;
            CSAPI.SetGOActive(this["bar"..i],isShow);
            if isShow then
                local val=currPet:GetStagePercent(i);
                local path="UIs/Pet/"
                local state=1; 
                if val>=1 then
                    local isRevice=currPet:IsStageRevice(i);
                    path= isRevice and path.."btn_02_01.png" or path.."btn_02_02.png"
                    state=isRevice and 3 or 2;
                else
                    path=path.."btn_02_03.png"
                end
                bSliders[i].fillAmount=val;
                CSAPI.LoadImg(this["expState"..i],path,true,nil,true);
                UIUtil:SetRedPoint(this["expBtn"..i],state==2,30,30);
                CSAPI.SetGOActive(this["expTips"..i],state~=3);
                CSAPI.SetText(this["txtExpTips"..i],currPet:GetStageTips(i));
            end
        end
    end
end

function OnClickStageReward(stage)
    if stage and currPet then
        local isRevice=currPet:IsStageRevice(stage);
        local percent=currPet:GetStagePercent(stage);
        local posX,posY=CSAPI.GetPos(this["expBtn"..stage]);
        local pos=AdaptiveScreen.transform:InverseTransformPoint(UnityEngine.Vector3(posX, posY, gameObject.transform.position.z))
        if isRevice or percent<1 then
            --打开预览界面
            if preView==nil then
                ResUtil:CreateUIGOAsync("Pet/PetStagePreview",AdaptiveScreen,function(go)
                    preView=ComUtil.GetLuaTable(go);
                    preView.Show(currPet:GetStageReward(stage),pos.x,pos.y);
                end);
            else
                preView.Show(currPet:GetStageReward(stage),pos.x,pos.y);
            end
        else
            --领取奖励
            SummerProto:PetGainReward();
        end
    end
end

function OnClickStageReward1()
    OnClickStageReward(1)
end
function OnClickStageReward2()
    OnClickStageReward(2)
end
function OnClickStageReward3()
    OnClickStageReward(3)
end
function OnClickStageReward4()
    OnClickStageReward(4)
end

function SetStateObj()
    if stateObj then
        stateObj.Refresh();
    else
        ResUtil:CreateUIGOAsync("Pet/PetState",stateNode,function(go)
            stateObj=ComUtil.GetLuaTable(go);
            stateObj.Refresh();
        end)
    end
end

function SetMoney()
    --初始化钱币显示
    if moneyInfo then
        for i=1,2 do
            if #moneyInfo>=i then
                SetMoneyItem(this["icon"..i],this["txtMoney"..i],moneyInfo[i][1])
            end
        end
    end
end

function SetLeft()
    SetMoney();
    local info=nil;
    if tabDatas and #tabDatas>=currTab then
        info=tabDatas[currTab];
        if currChild then
            currChild.Hide();
        end
        if childs and childs[info.id] then
            currChild=childs[info.id];
            currChild.Init();
            currChild.Show();
        else
            ResUtil:CreateUIGOAsync(info.path, childNode, function(go)
                local lua=ComUtil.GetLuaTable(go)
                lua.Init();
                -- lua.Show();
                childs[info.id]=lua;
                currChild=lua;
            end)
        end
    end
end

function SetMoneyItem(_icon,_txt,_mId)
    if _icon and _txt and _mId then
        local cfg = Cfgs.ItemInfo:GetByID(_mId)
        local num = BagMgr:GetCount(_mId)
        CSAPI.SetText(_txt,tostring(num));
        if cfg==nil then
            LogError("ItemInfo中未找到配置信息："..tostring(_mId));
            do return end
        end
        ResUtil.IconGoods:Load(_icon, cfg.icon .. "_1")
        CSAPI.SetRTSize(_icon,40,40);
    end
end

function SetTabs()
    local currIdx=tabDatas[currTab] and tabDatas[currTab].idx or nil; 
    local redInfo=RedPointMgr:GetData(RedPointType.ActiveEntry16);
    if tabDatas then
        for k,v in ipairs(tabDatas) do
            if redInfo~=nil then
                if v.id==PetViewType.Book then
                    tabDatas[k].isRed=redInfo.hasBook;
                elseif v.id==PetViewType.Pet then
                    tabDatas[k].isRed=redInfo.newPets~=nil;
                end
            else
                tabDatas[k].isRed=false
            end
        end
    end
    ItemUtil.AddItems("Pet/PetTagObj",tabList,tabDatas,tagNode,nil,1,currIdx);
end

function OnTabClick(idx)
    if currTab and idx and currTab~=idx and tabDatas and #tabDatas>=currTab then
        -- local  info=tabDatas[currTab];
        -- if childs and childs[info.id] then
        --     childs[info.id].Hide();
        -- end
        currTab=idx
        Refresh();
    end
end

--领取奖励
function OnClickReward()
    SummerProto:GainRandomGift();
end

function OnClickReturn()
    if IsNil(gameObject) or IsNil(view) then
        do return end
    end
    view:Close();
end

function OnClickHome()
    UIUtil:ToHome();
end

function OnClickQuestion()
    local cfg=Cfgs.CfgModuleInfo:GetByID("PetMain");
    if cfg then
        CSAPI.OpenView("ModuleInfoView", cfg)
    end
end

--使用了物品，根据物品类型播放动效、对话
function OnUseItem(proto)
    if proto and proto.info and currPet then
        local id= proto.info.id;
        if id==nil then
            LogError("使用物品时未返回使用数据！");
            do return end
        end
        --获取宠物物品类型
        local goodInfo=BagMgr:GetFakeData(id);
        if goodInfo and goodInfo:GetDyVal1()==PROP_TYPE.PetItem then--宠物道具使用
            local petItem=PetItemData.New();
            petItem:InitCfg(goodInfo:GetDyVal2());
            local state=petItem:GetUseAnimaName();
            if state then
                EventMgr.Dispatch(EventType.PetActivity_FSMState_Change,{id=currPet:GetID(),state=state,autoChange=true})
            end
            EventMgr.Dispatch(EventType.PetActivity_EmojiCond_Trigger,{id=currPet:GetID()})
        end
    end
end

function OnPetUpdate(proto)
    if proto and proto.info and proto.info.id==currPet:GetID() then
        SetStateObj();
    end
end

function OnPetAttrUpdate(eventData)
    if eventData and eventData.id==currPet:GetID() then
        SetStateObj();
    end
end

--eventData:持续时间
function OnActionBarSet(_eventData)
    if _eventData and _eventData.id==currPet:GetID() then
        actionTime=_eventData.time or 0;
        actionRunTime=0;
    end
end

function OnSportSceneCheck(eventData)
    -- LogError("OnSportSceneCheck----------------->")
    if currPet and eventData and eventData.id==currPet:GetID() then
        --初始化场景
        -- LogError(currPet:GetSceneName())
        if currPet:GetSceneName()~=nil then
            ResUtil:LoadBigImg(scene, "UIs/BGs/" ..currPet:GetSceneName() .. "/bg", false)
        end
    end
end

function SetRedInfo()
	local redInfo=RedPointMgr:GetData(RedPointType.ActiveEntry16);
	isRed=redInfo~=nil;
	SetBottomBar();
    SetTabs();
end

function OnClickM1()
    OnClickMoney(1);
end

function OnClickM2()
    OnClickMoney(2);
end

function OnClickMoney(idx)
    if moneyInfo and moneyInfo[idx] then
        if  #moneyInfo[idx]>1 then
            JumpMgr:Jump(moneyInfo[idx][2]);
        else
            local goods=BagMgr:GetFakeData(moneyInfo[idx][1]);
            if goods then
                CSAPI.OpenView("GoodsFullInfo",{data=goods});
            end
        end
    end
end

function OnRewardRet()
    SetReward();
    SetBottomBar();
end