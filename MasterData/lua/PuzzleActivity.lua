--拼图活动界面
local puzzleNode=nil;
local puzzleInfo=nil;
local layout=nil;
local curDatas=nil;
local eventMgr=nil;
local curId=nil;
local rLs=nil;--已解锁未领取的数据

function Awake()
    UIUtil:AddQuestionItem("PuzzleActivity", gameObject, quest)
	layout = ComUtil.GetCom(vsv, "UISV")
    layout:Init("UIs/PuzzleActivity/PuzzleMissionItem",LayoutCallBack,true)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Puzzle_Data_Ret, Refresh);
    -- eventMgr:AddListener(EventType.Puzzle_Buy_Ret,Refresh)
    eventMgr:AddListener(EventType.Puzzle_GetReward_Ret,Refresh)
    eventMgr:AddListener(EventType.Mission_List,Refresh);
    eventMgr:AddListener(EventType.Puzzle_Item_TweenBegin,OnTweenBegin)
    eventMgr:AddListener(EventType.Puzzle_Unlock_Ret,OnUnlockRet)
    eventMgr:AddListener(EventType.Mission_RewardRet,OnMissionRwdRet)
    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClose);
end

function OnDestroy()
   eventMgr:ClearListener();
end

function OnOpen()
    Refresh(true);
end

function Refresh(isCheck)
    --获取拼图数据
    if data then
        puzzleInfo=PuzzleMgr:GetData(tonumber(data))
    else
        puzzleInfo=PuzzleMgr:GetDataByType(openSetting)
    end
    if puzzleInfo==nil or (puzzleInfo and puzzleInfo:GetData()==nil) then
        LogError("未获取到拼图信息！");
        do return end;
    end
    local st= TimeUtil:GetTimeStampBySplit(puzzleInfo:GetBeginTime())
    local et=TimeUtil:GetTimeStampBySplit(puzzleInfo:GetEndTime())
    local sTime=TimeUtil:GetTimeStr2(st)
    local eTime=TimeUtil:GetTimeStr2(et)
    if isCheck then
        rLs=ChecekReviceList();
    else
        rLs=nil;
    end
    --初始化开始/结束时间
    CSAPI.SetText(txtTime,LanguageMgr:GetByID(74002,sTime,eTime));
    --初始化拼图信息
    CreateNode();
    --显示任务信息
    InitCurDatas();
    layout:IEShowList(#curDatas);
    if puzzleInfo:GetType()==ePuzzleType.Type2 then
        RedPointMgr:SetDayRedToday(RedPointDayOnceType.PuzzleActivity2)
        CSAPI.SetGOActive(moneyObj,false);
        CSAPI.SetGOActive(taskTipsObj,false)
        CSAPI.SetText(txtC1,LanguageMgr:GetByID(74016));
        local buyCfg=puzzleInfo:GetBuyCfg();
        if buyCfg and (buyCfg.begTime or buyCfg.endTime) then
            local beginTime=TimeUtil:GetTimeStampBySplit(buyCfg.begTime);
            local endTime=TimeUtil:GetTimeStampBySplit(buyCfg.endTime);
            local currTime = TimeUtil:GetTime()
            local canBuy=true;
            if (beginTime ~= 0 and currTime < beginTime) or
            (endTime ~= 0 and currTime >= endTime) then canBuy = false end
            CSAPI.SetGOActive(btnJump,canBuy);
        else
            CSAPI.SetGOActive(btnJump,true);
        end
    else
        RedPointMgr:SetDayRedToday(RedPointDayOnceType.PuzzleActivity1)
        CSAPI.SetGOActive(taskTipsObj,true)
        CSAPI.SetGOActive(moneyObj,true);
        local cfg=puzzleInfo:GetDrawCfg();
        if cfg and cfg.item then
            local num=BagMgr:GetCount(cfg.item[1].id);
            CSAPI.SetText(txtHasNum,tostring(num));
        end
        CSAPI.SetText(txtC1,LanguageMgr:GetByID(74010));
    end
    PuzzleMgr:RefreshRedInfo(puzzleInfo:GetType());
end

function InitCurDatas()
    curDatas=MissionMgr:GetActivityDatas(eTaskType.Puzzle,puzzleInfo:GetTaskType());
    if puzzleInfo:GetType()==ePuzzleType.Type2 and curDatas then--判断是否解锁对应格子，解锁则改变任务状态
        for k,v in ipairs(curDatas) do
            local cfg=v:GetCfg();
            if cfg and cfg.gridIdx and puzzleInfo:IsGridRevice(cfg.gridIdx) then
                curDatas[k].is_get = BoolType.Yes
                curDatas[k].state = eTaskState.Finish
                curDatas[k]:Refresh();
            end
        end
    end
    table.sort(curDatas, function(a, b)
        if (a:GetSortIndex() == b:GetSortIndex()) then
            return a:GetCfgID() < b:GetCfgID()
        else
            return a:GetSortIndex() > b:GetSortIndex()
        end
    end)
end

function ChecekReviceList()
    local ids=nil;
    if puzzleInfo:GetType()==ePuzzleType.Type2 then
        local list=puzzleInfo:GetFragments(true);
        if list then
            for k,v in ipairs(list) do --获取可以解锁的id
                if v:IsUnlock() then
                    ids=ids or {}
                    table.insert(ids,v:GetIdx());
                end
            end
        end
    end
    return ids;
end

function LayoutCallBack(index)
	local _data = curDatas[index]
	local grid=layout:GetItemLua(index);
	grid.Refresh(_data,puzzleInfo:GetType());
end

function CreateNode()
    if puzzleNode==nil then
        ResUtil:CreateUIGOAsync("PuzzleActivity/PuzzleNode",node,function(go)
            puzzleNode=ComUtil.GetLuaTable(go);
            puzzleNode.Init(puzzleInfo);
            puzzleNode.Refresh(rLs);
            if rLs and #rLs>=1 then
                FuncUtil:Call(SendGetProto,nil,300,rLs);
            end
        end);
    else
        puzzleNode.Refresh(rLs);
        if rLs and #rLs>=1 then
            FuncUtil:Call(SendGetProto,nil,300,rLs);
        end
    end
end

function OnTweenBegin(eventData)
    if eventData and puzzleInfo and puzzleInfo:GetID()==eventData.id then
        if puzzleInfo:GetType()==ePuzzleType.Type2 and eventData.unlockGrids then
            Refresh(true)
        else
            FuncUtil:Call(OnTweenOver,nil,300,eventData);
        end
    end
end

function OnMissionRwdRet(eventData)
    if eventData and eventData[1]==eTaskType.Puzzle then
        if puzzleInfo:GetType()==ePuzzleType.Type2 then
            Refresh(true)
        else
            FuncUtil:Call(OnTweenOver,nil,300);
        end
    end
end

function SendGetProto(ids)
    if puzzleInfo and puzzleInfo:GetType()==ePuzzleType.Type2 and ids then
        ActivePuzzleProto:UnlockGrid(puzzleInfo:GetID(),ids);
    end
end

function OnTweenOver(eventData) --发送协议领取
    if puzzleInfo then
        puzzleInfo=PuzzleMgr:GetData(puzzleInfo:GetID());
        if puzzleInfo:GetType()==ePuzzleType.Type2 then
            local ids=ChecekReviceList();
            SendGetProto(ids);
        elseif eventData and eventData.gets then
            UIUtil:OpenReward({eventData.gets});
        end
    end
end

--解锁完成
function OnUnlockRet(eventData)
    if eventData and eventData.gets then
        UIUtil:OpenReward({eventData.gets});
    end
    Refresh();
end

function OnViewClose(viewName)
    if viewName=="PuzzlePool" then
        Refresh(true);
    end
end

function OnClickClose()
    view:Close();
end

function OnClickMoney()
    if puzzleInfo and puzzleInfo:GetType()~=ePuzzleType.Type2 then
        local cfg=puzzleInfo:GetDrawCfg();
        if cfg and cfg.item then
            local item=BagMgr:GetFakeData(cfg.item[1].id);
            CSAPI.OpenView("GoodsFullInfo",{data=item});
        end
    end
end

function OnClickJump()
    if puzzleInfo then
        if puzzleInfo:HasOverReward()~=true then
            if puzzleInfo:GetFragmentsWay()==PuzzleEnum.GetWayType.Draw then
                CSAPI.OpenView("PuzzlePool",puzzleInfo);
            elseif puzzleInfo:GetFragmentsWay()==PuzzleEnum.GetWayType.Buy then
                CSAPI.OpenView("PuzzlePool",puzzleInfo);
            end
        else
            Tips.ShowTips(LanguageMgr:GetByID(74020));
        end
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
