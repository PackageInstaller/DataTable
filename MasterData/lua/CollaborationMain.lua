--回归绑定主界面
local currActivty=nil;
local isBindView=true; --是否显示绑定页面
local isForceSwitch=false;--是否强制切换
local bLGrid=nil;
local bRGrid=nil;
local bLGrid2=nil;
local bRGrid2=nil;
local bPlrInfo=nil;--绑定的玩家信息
local currTaskLevel=0;--当前任务等级，最高为7
local pointImgName="pointImg";
local tabs={};
local originTabData={
    {id=1,desc=61032},
    {id=2,desc=61005},
    {id=3,desc=61034},
    {id=4,desc=61033},
};
local tabDatas=nil;
local currTabIdx=1;
local eventMgr=nil;
local top=nil;
local leftPanel=nil;
local leftInfos={};
curIndex1, curIndex2 = 1, 1;
local endTime=0;
local fixedTime=1;
local upTime=0;
local layout=nil;
local types={eTaskType.Main,eTaskType.Sub,eTaskType.Daily,eTaskType.Weekly}
local curDatas=nil;
local stageInfo=nil;
local sSlider=nil;
local stagGrid=nil;
local readyEndTime=0;
local applyResetTime=0;
local isAnim = false
local tlua=nil;
local isMainIn=false;--是否从主界面进入

function Awake()
    top=UIUtil:AddTop2("CollaborationMain",gameObject,OnClickClose);
    bLGrid= CreateGridItem(nil,bLNode);
    bRGrid=CreateGridItem(nil,bRNode,OnClickHead);
    bLGrid2=CreateGridItem(nil,bLNode2);
    bRGrid2=CreateGridItem(nil,bRNode2,OnClickHead);
    sSlider=ComUtil.GetCom(stageSlider,"Slider")
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/Collaboration/CollaborationMissionItem",LayoutCallBack,true);
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Collaboration_TaskTab_Change, OnTabChange);
    eventMgr:AddListener(EventType.Collaboration_BindInvite_Ret, OnBindOver);
    eventMgr:AddListener(EventType.Collaboration_BindReward_Ret,OnBindRewardRet);
    eventMgr:AddListener(EventType.Collaboration_Info_Update,OnInfoUpdate);
    eventMgr:AddListener(EventType.Collaboration_InviteOption_Ret,OnBindRet);
    eventMgr:AddListener(EventType.Mission_List,OnTaskRefresh);
    eventMgr:AddListener(EventType.Collaboration_StageTaskInfo_Ret,OnStageTaskRet);
    eventMgr:AddListener(EventType.Bag_Update,OnCoinUpdate);
end

function InitLeft()
    if isMainIn then
        if (leftPanel ==nil) then
            local go = ResUtil:CreateUIGO("Common/LeftPanel", leftNode.transform)
            leftPanel = ComUtil.GetLuaTable(go)
            local leftDatas = {{61000, "Collaboration/btn_04_01"}}
            leftPanel.Init(this, leftDatas)
        end
        leftPanel.Anim();
    end
end

function OnDestroy()
   eventMgr:ClearListener();
end

function CreateGridItem(data,parent,callBack)
   local go= ResUtil:CreateUIGO("Collaboration/CollaborationHeadGrid",parent.transform); 
   local grid=ComUtil.GetLuaTable(go);
   grid.Refresh(data,callBack);
   return grid;
end

--从主界面进入时
function OnOpen()
    isMainIn=true;
    InitLeft();
    RegressionProto:PlrBindStageTaskInfo()
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
    currActivty=CollaborationMgr:GetCurrInfo();
    RefreshPanel();
    if CollaborationMgr:GetRecordInvitRet() then
        CSAPI.OpenView("CollaborationBindingSuccess");
    end
end

--从活动面板进入时
function Refresh(_data,_elseData)
    isMainIn=false;
    currActivty=CollaborationMgr:GetCurrInfo();
    RegressionProto:PlrBindStageTaskInfo()
    RefreshPanel();
    if CollaborationMgr:GetRecordInvitRet() then
        CSAPI.OpenView("CollaborationBindingSuccess");
    end
end

function RefreshPanel()
    if isMainIn then
        SetRedInfo()
    end
    if currActivty then
        if isForceSwitch~=true then
            isBindView=not currActivty:IsBindOver()  --获取绑定状态
        end
        isForceSwitch=false;
        local time=currActivty:GetEndTime();
        if time then
            endTime=TimeUtil:GetTimeStampBySplit(time)-TimeUtil:GetTime();
        else
            endTime=0;
        end
        CSAPI.SetGOActive(contentNode,not isBindView);
        CSAPI.SetGOActive(contentNode2,isBindView);
        if isBindView then--设置展示主物体
            local aTime=currActivty:GetApplyResetTime();
            local curTime=TimeUtil:GetTime();
            if aTime~=0 and aTime<=curTime then --重新获取活动信息
                CollaborationMgr:CleanCache();
                RegressionProto:PlrBindInfo();
            elseif aTime~=0 and aTime>curTime then
                applyResetTime=curTime-aTime
            else
                applyResetTime=0
            end
            InitContentNode2();
        else
            InitContentNode();
        end     
    end
end

function InitContentNode2()
    if currActivty==nil then
        do return end
    end
    --初始化协同码
    CSAPI.SetText(txtCode,currActivty:GetCodeDesc());
    --初始化绑定说明
    local lStr=61001;
    if currActivty:GetPlrType()==eBindActivePlrType.Return then
        lStr=LanguageMgr:GetByID(61001,LanguageMgr:GetByID(61028),LanguageMgr:GetByID(61029))
    elseif currActivty:GetPlrType()==eBindActivePlrType.Acitve then
        lStr=LanguageMgr:GetByID(61001,LanguageMgr:GetByID(61029),LanguageMgr:GetByID(61028))
    end
    CSAPI.SetText(txtBindingTips,lStr);
    CSAPI.SetText(txtDesc2,currActivty:GetDesc());
    local timeStr=LanguageMgr:GetByID(61006)
    local sStr=TimeUtil:GetTimeStr2(currActivty:GetStartTimeStamp(),false);
    local eStr=TimeUtil:GetTimeStr2(currActivty:GetEndTimeStamp(),false);
    timeStr=timeStr..string.format("%s-%s",sStr,eStr);
    CSAPI.SetText(txtTime2,timeStr);
    --初始化绑定奖励
    local rewardInfo=currActivty:GetBindReward();
    if rewardInfo~=nil then
        local rInfo=GridUtil.GetGridObjectDatas2(rewardInfo)[1];
        rInfo:GetIconLoader():Load(preGoodsIcon,rInfo:GetIcon(),true);
    end 
    --设置红点
    -- UIUtil:SetRedPoint(staticGridNode,currActivty:GetStageCanRevice(),48,48,0);
    --初始化玩家头像格子
    bLGrid2.Refresh(PlayerClient:GetHeadFrameInfo());
    local binds=currActivty:GetBindPlayers();
    if binds~=nil then
        bPlrInfo=binds[1]
    else
        bPlrInfo=nil
    end
    local clickFunc=bPlrInfo~=nil and nil or OnClickHead
    bRGrid2.Refresh(bPlrInfo,clickFunc);
    SetLimitObj(shopCostIcon2,txtShopDesc2,txtPointNum2);
end

function InitTabs()
    --刷新tab显示物体
    tabDatas={};
    for k,v in ipairs(types) do
        local list=MissionMgr:GetCollaborationData(eTaskType.RegressionBind,v);
        if list==nil or (list and #list>0) then
            table.insert(tabDatas,originTabData[k])
        end
    end
    ItemUtil.AddItems("Collaboration/CollaborationTaskTab", tabs, tabDatas, tabNode,nil,1,currTabIdx)
end

function InitContentNode()
    --创建tab列表
    -- ItemUtil.AddItems("Collaboration/CollaborationTaskTab", tabs, tabDatas, tabNode,nil,1,currTabIdx)
    InitTabs();
    --设置描述
    if currActivty==nil then
        do return end
    end
    --初始化绑定说明
    local lStr=61001;
    if currActivty:GetPlrType()==eBindActivePlrType.Return then
        -- lStr=LanguageMgr:GetByID(61001,"<color=\'#ffc148\'>"..LanguageMgr:GetByID(61028).."</color>","<color=\'#ffc148\'>"..LanguageMgr:GetByID(61029).."</color>")
        lStr=LanguageMgr:GetByID(61001,LanguageMgr:GetByID(61028),LanguageMgr:GetByID(61029))
    elseif currActivty:GetPlrType()==eBindActivePlrType.Acitve then
        -- lStr=LanguageMgr:GetByID(61001,"<color=\'#ffc148\'>"..LanguageMgr:GetByID(61029).."</color>","<color=\'#ffc148\'>"..LanguageMgr:GetByID(61028).."</color>")
        lStr=LanguageMgr:GetByID(61001,LanguageMgr:GetByID(61029),LanguageMgr:GetByID(61028))
    end
    CSAPI.SetText(txtDesc,lStr);
    local timeStr=LanguageMgr:GetByID(61006)
    local sStr=TimeUtil:GetTimeStr2(currActivty:GetStartTimeStamp(),false);
    local eStr=TimeUtil:GetTimeStr2(currActivty:GetEndTimeStamp(),false);
    timeStr=timeStr..string.format("%s-%s",sStr,eStr);
    CSAPI.SetText(txtTime,timeStr);
    --设置代币数量
    SetLimitObj(shopCostIcon,txtShopDesc,txtPointNum);
    InitStageObj();
    --判断是否准备期
    if currActivty:IsReadyTime() then
        readyEndTime=currActivty:GetPreTimeStamp()-TimeUtil:GetTime();
        --设置准备中状态
        SetEmpty(true,currActivty:GetPreTimeDesc());
    else
        --判断是否绑定
        if currActivty:IsBindOver() then
            SetEmpty(false);
        else
            SetEmpty(true,LanguageMgr:GetByID(61026));
        end
        SetTaskList();
    end
    if currActivty:IsBindOver() then --已绑定则隐藏前往绑定按钮
        CSAPI.SetGOActive(bindingNode,true)
        CSAPI.SetGOActive(btnBinding,false);
        CSAPI.SetAnchor(btnShop,-494,-280);
        --初始化玩家头像格子
        if bLGrid then
            bLGrid.Refresh(PlayerClient:GetHeadFrameInfo())
        else
            bLGrid=CreateGridItem(PlayerClient:GetHeadFrameInfo(),bLNode)
        end
        local plrs=currActivty:GetBindPlayers();
        if plrs==nil or next(plrs)==nil then
            do return end;
        end
        if bRGrid then
            bRGrid.Refresh(plrs[1])
        else
            bRGrid=CreateGridItem(plrs[1],bRNode)
        end
    else
        CSAPI.SetGOActive(bindingNode,false)
        CSAPI.SetGOActive(btnBinding,true);
        CSAPI.SetAnchor(btnShop,-494,-76);
    end

end

function InitStageObj()
    if currActivty==nil then
        do return end
    end
     --初始化任务进度条和描述
     local stageInfo=currActivty:GetCurrStageCfg();
     if stageInfo then
         local currTaskNum=currActivty:GetStageTaskNum();
         local totalNum=stageInfo.nCount or 0
         CSAPI.SetText(txtTotal,currTaskNum.."/"..totalNum);
         sSlider.value=currTaskNum/totalNum;
    else
        CSAPI.SetText(txtTotal,"");
        sSlider.value=0;
    end
     --初始化物品框
     if stageInfo and stageInfo.jAwardId then
         local info=stageInfo.jAwardId[1];
         local rData=GridUtil.RandRewardConvertToGridObjectData({id=info[1],num=info[2],type=info[3]});
         if stagGrid then
            --  stagGrid.Refresh(rData);
            stagGrid.Clean();
             stagGrid.LoadIconByLoader(ResUtil.IconGoods,stageInfo.sIcon);
         else
             ResUtil:CreateUIGOAsync("Grid/GridItem",staticGridNode,function(go)
                 stagGrid=ComUtil.GetLuaTable(go)
                --  stagGrid.Refresh(rData);
                stagGrid.Clean();
                stagGrid.LoadIconByLoader(ResUtil.IconGoods,stageInfo.sIcon);
                 CSAPI.SetScale(go,0.5,0.5);
                 stagGrid.SetClickCB(OnClickReward);
             end)
         end
     end
      --设置阶段奖励 (待添加) 
      for i=1,7 do
         CSAPI.SetGOActive(this[pointImgName..i],i<currActivty:GetStage());
     end
     if currActivty and currActivty:GetStageCanRevice() then
        --显示红点
        UIUtil:SetRedPoint(staticGridNode, true, 40, 40, 0)
    else
        UIUtil:SetRedPoint(staticGridNode, false, 40, 40, 0)
    end
end

function SetEmpty(isEmpty,desc)
    if isEmpty then
        if currActivty==nil or (currActivty and  currActivty:IsReadyTime())  then
            CSAPI.SetGOActive(mask,isEmpty);
            CSAPI.SetGOActive(mask2,not isEmpty);
            CSAPI.SetGOActive(vsv,not isEmpty);
        else
            CSAPI.SetGOActive(mask,not isEmpty);
            CSAPI.SetGOActive(mask2,isEmpty);
            CSAPI.SetGOActive(vsv,true);
        end
    else
        CSAPI.SetGOActive(mask,false);
        CSAPI.SetGOActive(mask2,false);
        CSAPI.SetGOActive(vsv,true);
    end
    
    if desc then
        CSAPI.SetText(txtMaskTips,desc);
        CSAPI.SetText(txtMaskTips2,desc)
    end
end

function SetTaskList()
    curDatas=MissionMgr:GetCollaborationData(eTaskType.RegressionBind,types[currTabIdx]);
    if curDatas==nil or #curDatas==0 then
        if currActivty and currActivty:IsReadyTime()~=true then
            LogError("未获取到任务列表数据！！")
        end
        do return end
    end
    if tlua then
        tlua:AnimAgain()
        AnimStart()
    end
    layout:IEShowList(#curDatas,AnimEnd);
end

function AnimStart()
    isAnim = true
    CSAPI.SetGOActive(clickMask, true)
end

function  AnimEnd()
    isAnim = false
    CSAPI.SetGOActive(clickMask, false)
end

function LayoutCallBack(index)
    local data=curDatas[index];
    local item=layout:GetItemLua(index);
    if item then
        item.Refresh(data,false)
    end
end

--点击Tab
function OnTabChange(idx)
    if idx~=currTabIdx then
        currTabIdx=idx;
        InitContentNode();
    end
end

--设置限制描述
function SetLimitObj(icon,txtLimit,txtNum)
    if currActivty==nil or icon ==nil or txtLimit==nil or txtNum==nil then
        do return end
    end
    local limitInfos=currActivty:GetLimitInfo()
    if limitInfos==nil then
        do return end
    end
    local limitInfo=limitInfos[1];
    --第一个为0的情况下，为不限制，且数量必须为-1
    local typeStr=""
    local strNum=""
    local num=0;
    if limitInfo[1]==eBindLimitType.UnLimit then
        -- typeStr=LanguageMgr:GetByID(61037);
        strNum="%s";
        num=BagMgr:GetCount(limitInfo[2]);
    elseif limitInfo[1]==eBindLimitType.Day then
        typeStr=LanguageMgr:GetByID(61036);
        strNum="%s/"..tostring(limitInfo[3] or 0);
        num=currActivty:GetLimitGoodsNum(limitInfo[2]);
    elseif limitInfo[1]==eBindLimitType.Week then
        typeStr=LanguageMgr:GetByID(61035);
        strNum="%s/"..tostring(limitInfo[3] or 0);
        num=currActivty:GetLimitGoodsNum(limitInfo[2]);
    end
    strNum=string.format(strNum,num);
    local goods=GoodsData();
    goods:Init({id=limitInfo[2]})
    if goods then
        goods:GetIconLoader():Load(icon,goods:GetIcon().."_1");
        CSAPI.SetRTSize(icon,65,65);
    end
    CSAPI.SetText(txtLimit,typeStr);
    CSAPI.SetText(txtNum,strNum);
end

function OnCoinUpdate()
    SetLimitObj(shopCostIcon2,txtShopDesc2,txtPointNum2);
    SetLimitObj(shopCostIcon,txtShopDesc,txtPointNum);
end

--查看奖励
function OnClickRevice()
    CSAPI.OpenView("CollaborationPreview");
end

--兑换商店
function OnClickShop()
    if currActivty then
        currActivty:GoShop();
    end
end

--前往绑定
function OnClickBinding()
    isBindView=true;
    isForceSwitch=true;
    RefreshPanel();
end

--行动档案
function OnClickDoc()
    isBindView=false;
    isForceSwitch=true;
    RefreshPanel();
end

--复制邀请码
function OnClickCopy()
    if currActivty then
        CS.UnityEngine.GUIUtility.systemCopyBuffer =currActivty:GetCode();
    end
end

--点击邀请框
function OnClickHead()
    CSAPI.OpenView("CollaborationConfirm");
end

function Update()
    upTime=upTime+Time.deltaTime;
    if upTime>=fixedTime then
        if endTime and endTime>0 then
            endTime=endTime-fixedTime;
            RefreshDownTime();
        end
        if readyEndTime and readyEndTime>0 then
            readyEndTime=readyEndTime-fixedTime;
            if readyEndTime<=0 then
                InitContentNode();
                readyEndTime=0;
            end
        end
        if applyResetTime and applyResetTime>0 then
            applyResetTime=applyResetTime-fixedTime;
            if applyResetTime<=0 then
                CollaborationMgr:CleanCache();
                RegressionProto:PlrBindInfo();
                applyResetTime=0;
            end
        end
        upTime=0;
    end
end

function RefreshDownTime()
    if endTime<=0 then--回到主界面并提示
        HandlerOver();
    end
end

--活动结束
function HandlerOver()
    CSAPI.CloseAllOpenned();
    FuncUtil:Call(function()
        Tips.ShowTips(LanguageMgr:GetTips(24001));
    end,nil,100);      
end

function OnClickClose()
    view:Close();
end

--绑定结果返回
function OnBindOver(_d)
    -- LogError("OnBindOver-------------------->");
    if _d and _d.data.isOk then
        if  _d.isMine then
            LanguageMgr:ShowTips(40003);
            -- Tips.ShowTips("已发送绑定邀请...");
        else
            currActivty=CollaborationMgr:GetCurrInfo();
            RefreshPanel();
            CSAPI.OpenView("CollaborationBindingSuccess");
        end
    end
    -- currActivty=CollaborationMgr:GetCurrInfo();
    -- RefreshPanel();
end

--获取阶段奖励返回
function OnBindRewardRet()
    currActivty=CollaborationMgr:GetCurrInfo();
    RefreshPanel();
end

function OnTaskRefresh(eventData)
    if eventData and eventData[1]==eTaskType.RegressionBind  then
        UIUtil:OpenReward({eventData[2]},{isNoShrink=true});
    end
    -- InitTabs();
    -- SetTaskList();
    InitContentNode();
end

function OnInfoUpdate()
    currActivty=CollaborationMgr:GetCurrInfo();
    RefreshPanel();
end

function OnClickReward(lua)
    --判断是否可以领取
    if currActivty and currActivty:GetStageCanRevice() then
        --发送请求协议
        RegressionProto:PlrBindGainReward();
    else
        OnClickRevice();
    end
end

function OnBindRet(proto)
    -- LogError(proto)
    if proto and proto.success and proto.isOk then
        currActivty=CollaborationMgr:GetCurrInfo();
        RefreshPanel();
        CSAPI.OpenView("CollaborationBindingSuccess");
    end
end

function OnStageTaskRet()
    currActivty=CollaborationMgr:GetCurrInfo();
    --刷新阶段性物体
    InitStageObj();
end

function SetRedInfo()
    local redInfo=RedPointMgr:GetData(RedPointType.Collaboration);
    local isRed=false;
    if redInfo and redInfo.bind==1 then
        isRed=true
    end
    UIUtil:SetRedPoint(bindingNode2,isRed,250,80);
    for k,v in ipairs(leftPanel.leftItems) do
        if k==1 then
            local isRed=false;
            if redInfo and redInfo.bind==1 then
                isRed=true
            end
            v.SetRed(isRed);
        end
    end
end