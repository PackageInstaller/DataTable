local this = MgrRegister("RichManMgr")

--大富翁活动不会同时开启多个
function this:Init()
    self:Clear()
    -- self:SetData({
    --     cfgId=1001,
    --     sort=6,
    --     mapId=1005,
    --     eventList={},
    --     throwCnt=9;
    -- });
end

function this:InitData()
    OperateActiveProto:GetRichManData();
end

function this:SetData(proto)
    if proto~=nil then
        if self.curData==nil then
            self.curData=RichManInfo.New();
        end
        self.curData:SetData(proto);
        self:CheckRed()
    end
end

function this:OnThrowRet(proto)
    if self.curData~=nil and proto then
        self:UpdateActionList(proto);
        --判定是否冲过终点，有的话需要判定步数达成圈数的条件是否完成
        self.curData:UpdateData(proto);
        EventMgr.Dispatch(EventType.RichMan_data_Update);
    end
end

--更新播放序列
function this:UpdateActionList(proto)
    --从当前位置到投掷位置的检测，检测格子触发事件
    if proto==nil or self.curData==nil then
        LogError("更新播放序列时出现异常！"..table.tostring(self.curData).."\t"..table.tostring(proto));
        do return end
    end
    if proto.point==nil or proto.point<=0 then --非投掷回合，跳过
        do return end
    end
    local curGrid=self.curData:GetCurPosGridInfo()
    local startSort=curGrid:GetSort();
    local mapData=self.curData:GetMapInfo();--活动数据
    --添加骰子动画事件
    -- LogError("抛出点数："..tostring(proto.point));
    self:PushStateAction(RichManAction.RandTween,proto)
    self:BuildActionList(startSort,proto.stepCnt,mapData,proto);
    -- LogError(proto)
end

--构建行动序列
function this:BuildActionList(startSort,stepCount,mapData,proto)
    --对比数据并更新玩家行动序列
    local moveGrids={};
    -- LogError("BuildActionList:"..tostring(startSort).."\t"..tostring(proto.point).."\t"..tostring(proto.index))
    local curSort=startSort;
    for step=1,stepCount do
        curSort=curSort+1;
        if curSort>mapData:GetMaxStepNum() then
            mapData=self:GetMapInfo(proto.mapId);--更新地图数据
            curSort=1;
        end
        local gridInfo=mapData:GetGridBySort(curSort);
        if gridInfo==nil then--检测是否触发
            LogError("未找到指定步数："..tostring(curSort).."的格子信息！");
            break;
        end
        local hasEvent=false;
        --触发的格子效果
        if gridInfo:GetTriggerType()==RichManEnum.TriggerType.Press  or (step==stepCount and gridInfo:GetTriggerType()~=RichManEnum.TriggerType.None) then
            hasEvent=true;
        end
        table.insert(moveGrids,gridInfo);
        -- LogError(tostring(curSort).."\t"..tostring(hasEvent).."\t"..tostring(#moveGrids).."\t"..tostring(gridInfo:GetTriggerType()).."\t"..tostring(gridInfo:GetSort()))
        if step==stepCount or hasEvent then --移动行为
            self:PushStateAction(RichManAction.Move,moveGrids,mapData,mapData:GetGridBySort(startSort),self:GetAutoState());
            moveGrids={};
        end
        if hasEvent then--处理触发的格子事件
            self:HandleGridEvent(gridInfo,proto);
            startSort=curSort;
        end
    end
end

--格子触发效果的事件处理 girdInfo:RichManGridInfo  proto:当前
function this:HandleGridEvent(gridInfo,proto)
    if gridInfo==nil then
        do return end
    end
    if gridInfo:GetType()==RichManEnum.GridType.Start then --起点/跑完一圈
        --获取当前的活动投掷数据并+1
        local throwCnt=self:GetCurData():GetThrowCnt()+1
        self:PushStateAction(RichManAction.FullRound,gridInfo,proto,throwCnt,self:GetAutoState())
    elseif gridInfo:GetType()==RichManEnum.GridType.RandReward then --随机奖励
        self:PushStateAction(RichManAction.Award,gridInfo,proto,self:GetAutoState())
    elseif gridInfo:GetType()==RichManEnum.GridType.RandEvent then  --随机事件
        self:PushStateAction(RichManAction.RandEvent,gridInfo,proto,self:GetAutoState())
    elseif gridInfo:GetType()==RichManEnum.GridType.Move then --移动
        local mapData=self:GetMapInfo(gridInfo:GetTempID());
        self:BuildActionList(gridInfo:GetSort(),gridInfo:GetValue1()[1],mapData,proto);
        --测试代码
        -- LogError("往前再移动："..tostring(gridInfo:GetValue1()[1]).."步");
        local point=gridInfo:GetValue1()[1]
        local index=(gridInfo:GetSort()+point)%32==0 and 32 or (gridInfo:GetSort()+point)%32;
        proto.index=index;
    elseif gridInfo:GetType()==RichManEnum.GridType.TP then --传送,传送无法跨圈
        self:PushStateAction(RichManAction.TP,gridInfo);
    end
end

--推出行动事件
function this:PushStateAction(_actionType,...)
    -- LogError("PushStateAction:"..tostring(_actionType));
    local action=nil;
    --记录当前的骰子数量，因为背包更新事件和表现是异步的，但是骰子数量变更需要在特定时间之后
    local nDice=self:GetCurData():GetNormalDice()
    local sDice=self:GetCurData():GetSpecialDice();
    local sDiceNum=sDice==nil and 0 or sDice:GetCount()
    local nDiceNum=nDice==nil and 0 or nDice:GetCount()
    if _actionType==RichManAction.Move then
        action=RichManMoveAction();
        action:Init({grids=select(1,...),mapData=select(2,...),startGrid=select(3,...),isAuto=select(4,...)});
    elseif _actionType==RichManAction.FullRound then
        action=RichManFullRoundAction();
        action:Init({gridInfo=select(1,...),proto=select(2,...),sDiceNum=sDiceNum,nDiceNum=nDiceNum,throwCnt=select(3,...),isAuto=select(4,...)});
    elseif _actionType==RichManAction.Award then --奖励事件
        action=RichManRandRewardAction();
        action:Init({gridInfo=select(1,...),proto=select(2,...),sDiceNum=sDiceNum,nDiceNum=nDiceNum,isAuto=select(3,...)});
    elseif _actionType==RichManAction.RandEvent then  
        action=RichManRandEventAction();
        action:Init({gridInfo=select(1,...),proto=select(2,...),sDiceNum=sDiceNum,nDiceNum=nDiceNum,isAuto=select(3,...)});
    elseif _actionType==RichManAction.TP then  
        action=RichManTpAction();
        action:Init({gridInfo=select(1,...)});
    elseif _actionType==RichManAction.RandTween then
        action=RichManRandTweenAction();
        action:Init(select(1,...));
    end
    --抛出事件
    EventMgr.Dispatch(EventType.RichMan_ActionQueue_Push,action)
end

-- 返回大富翁的地图数据
function this:GetMapInfo(mapId)
    if mapId == nil then
        LogError("查询地图信息时mapId格式有误！" .. tostring(mapId));
        do
            return
        end
    end
    local mapInfo=RichManMapInfo.New();
    mapInfo:InitCfg(mapId);
    return mapInfo;
end

function this:CheckRed()
    local isRed=false;
    if self:GetCurData()~=nil then
        isRed=MissionMgr:CheckRed2(eTaskType.RichMan,self:GetCurData():GetTaskGroup())
    end
    RedPointMgr:UpdateData(RedPointType.RichMan, isRed);
end

function this:GetCurData()
    return self.curData;
end

function this:SetMapView(mapView)
    self.mapView=mapView;
end

function this:GetMapView()
    return self.mapView;
end

function this:SetAutoState(isAuto)
    self.auto=isAuto;
end

function this:GetAutoState()
    return self.auto;
end

--记录自动过程中的随机奖励
function this:RecordAutoReward(rewards)
    if rewards then
        self.autoRewards=self.autoRewards or {};
        for i, v in ipairs(rewards) do
            table.insert(self.autoRewards,v);
        end
    end
end

function this:ClearAutoReward()
    self.autoRewards=nil
end

--返回当前活动的关卡配置信息
function this:GetCurSceneCfg()
    if self.curData~=nil then
        local sceneID=self.curData:GetSceneID();
        if sceneID==nil then
            LogError("大富翁活动："..tostring(self:GetID()).."未配置场景ID！");
            do return end
        end
        local cfg=Cfgs.scene:GetByID(sceneID);
        return cfg;
    end
    return nil;
end

function this:PlayAutoReward()
    if self.autoRewards~=nil then
        UIUtil:OpenReward({
            self.autoRewards,
            closeCallBack = function()
                self.autoRewards=nil; --清理数据
                EventMgr.Dispatch(EventType.RichMan_AutoThrow_RewardOver)
            end,
            caller = self
        });
    end
end

function this:Clear()
    self.curData=nil;
    self.mapView=nil;
    self.auto=nil;
    self.autoRewards=nil
end

function this:MenuLTime()
    local begTime,endTime
    local curData=self:GetCurData();
    if curData~=nil then
        begTime=curData:GetOpenTimeStamp();
        endTime=curData:GetCloseTimeStamp();
    end
    return begTime,endTime
end

return this;