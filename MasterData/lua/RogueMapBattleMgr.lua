RogueMapBattleMgr = {}
local this = RogueMapBattleMgr
-- 开场角色加载loading界面控制用的key
local loading_weight_key = "rogueMap_battle_init";

------------------------------------初始化------------------------------------
function this:Reset()
    self.isInited = nil
    self.isStart = nil
    self.disableInputTime = nil
    self.cacheDatas = self.datas;
    self.datas = {}
    self.battleData = nil
    self.currData = nil
    self.isFighting = nil
    self.battling = nil
    self.dungeonSetting = nil
    self.needApplyComplete = nil
    self.bIsNewWave = nil
    self.isReverted = nil
    self.isReverting = nil
    self.dontAutoTriggerGuide = nil
    self.ctrlState = nil
    self.moveCtrlTargetId = nil
    self.triggerFight = nil
    self.lastCtrlId = nil
    self.isPlayerAction = nil
    self.lastGridId = nil
    self:SetMistDis();

    self.loadingComplete = nil;
    self.loadingApply = nil;
    self.loadingViewClosed = nil;
    self.currPaths = nil
    self.recordPaths = nil
    self.isRollEffect  = false

    if (self.ground) then
        self.ground.Remove();
    end
    self.ground = nil
    self.closeInputStates = nil
    self:UpdateCtrlState(false);
    BattleCharacterMgr:Reset();
    if (self.isInitedListener == nil) then
        self.isInitedListener = 1;
        self:InitListener();
    end
    self:UpdateActionTurn();
end

function this:InitListener()
    EventMgr.AddListener(EventType.RogueMap_Ground_Inited, self.OnBattleGroundInited)
    EventMgr.AddListener(EventType.Loading_Complete, self.OnLoadingComplete);
    EventMgr.AddListener(EventType.Loading_View_Close, self.OnLoadingViewClose);
    EventMgr.AddListener(EventType.Loading_Start, this.OnLoadingStart);
end

function this.OnBattleGroundInited(battleGround)
    this:SetBattleGround(battleGround)
    this:ApplyStart();

    EventMgr.Dispatch(EventType.Replay_BGM); -- 重播场景背景音乐    
end

function this.OnLoadingComplete()
    this:LoadingComplete()
end

function this:LoadingComplete()
    self.loadingComplete = 1;

    FuncUtil:Call(self.UpdateInputState, self, 500);

    if (not self.dontAutoTriggerGuide) then
        self:TriggerGuide();
    end

    local ctrlTargetId = self.moveCtrlTargetId;
    self:SetMoveCtrlTarget();
    FuncUtil:Call(self.SetMoveCtrlTarget, self, 200, ctrlTargetId);

    if (self.isReverting) then
        self:RevertComplete();
    end
    self:UpdateInputState("RogueMapBattleMgr");

    if (GuideMgr:HasGuide("RogueMapBattle")) then
        self:UpdateInputState("guide", true);
    end
    if (self.disableInputTime) then
        self.disableInputTime = nil;
        -- CSAPI.DisableInput(3000);   
    end

    -- self:LoadingViewClose();
end

function this.OnLoadingViewClose()
    this:LoadingViewClose()
end

function this:LoadingViewClose()
    -- if (self.loadingViewClosed) then
    --     return;
    -- end
    -- self.loadingViewClosed = 1;

    self:TryShowSupport()

    self:TryShowPass()

    self:TryShowTeamInfoView()

    self:TryShowBuffSelect()
end

function this.OnLoadingStart()
    if (not this.loadingApply) then
        this.loadingApply = 1;
        EventMgr.Dispatch(EventType.Loading_Weight_Apply, loading_weight_key);
        FuncUtil:Call(this.ApplyLoadComplete, this, 3000, true); -- 3秒保护

        EventMgr.Dispatch(EventType.Loading_View_Delay_Close, 200);
    end
end

------------------------------------场景控制------------------------------------
function this:SetBattleGround(battleGround)
    self.ground = battleGround
    self:UpdateInputState("RogueMapBattleMgr", false);
end

-- 获取镜头
function this:GetCamera()
    return self.ground.GetCamera();
end

function this:UpdateInputState(key, state)
    self.closeInputStates = self.closeInputStates or {};
    if (key) then
        self.closeInputStates[key] = state;
    end

    for _, closeInputState in pairs(self.closeInputStates) do
        if (closeInputState) then
            self:SetInputState(false);
            return;
        end
    end
    self:SetInputState(true);
end

function this:SetInputState(state)
    if (self.ground) then
        self.ground.SetInputState(state);
    end
end

-- 创建一组角色
function this:CreateCharacters(datas)
    if (datas == nil) then
        return;
    end
    local characterParentGo = self:GetCharacterParentGO();

    -- 只需创建第一队
    BattleCharacterMgr:ApplyCreate(datas[1], characterParentGo);
end

-- 更新角色
function this:UpdateCharacter(data)
    -- LogError("更新战棋角色数据==============");
    -- LogError(data);

    if (not self.ground or IsNil(self.ground.gameObject)) then
        return;
    end

    local character = BattleCharacterMgr:GetCharacter(data.oid);
    if (character) then
        character.SetMoveStep(data.nStep);
        character.UpdateData(data);
        self:RefreshCharacterMoveRange();
        self:UpdateCharacterStepShow(data.nStep)
    end

    self:ApplyComplete();
end

function this:GetCharacterParentGO()
    return self.ground.GetCharacterParentGO();
end

-- 更新控制状态
function this:UpdateCtrlState(state, noEff)
    self.ctrlState = state;

    if (self.ctrlState) then
        local defaultCtrlId = self:GetDefaultCtrlId();
        self:SetMoveCtrlTarget(defaultCtrlId, noEff);
    else
        self:SetMoveCtrlTarget(nil);
    end
end

function this:GetDefaultCtrlId()
    local defaultCtrlId = nil;

    local lastCtrlCharacter = self.lastCtrlId and BattleCharacterMgr:GetCharacter(self.lastCtrlId);
    if (lastCtrlCharacter and not lastCtrlCharacter.IsDead()) then
        defaultCtrlId = self.lastCtrlId;
    end

    if (defaultCtrlId == nil) then
        local allCharacters = BattleCharacterMgr:GetAll();
        if (allCharacters) then
            for id, character in pairs(allCharacters) do
                if (character.GetType() == eDungeonCharType.MyCard and not character.IsDead()) then
                    defaultCtrlId = id;
                    break
                end
            end
        end
    end
    return defaultCtrlId;
end

-- 设置移动控制目标
function this:SetMoveCtrlTarget(id, noEff)
    -- LogError("设置移动目标" .. tostring(id));

    if (id and self.moveCtrlTargetId == id) then
        return;
    end

    if (id) then
        local lastCharacter = self:GetCtrlCharacter();
        if (lastCharacter) then
            lastCharacter.SetSelectState(false);
        end
    end

    self.moveCtrlTargetId = id;

    if (not self.loadingComplete) then
        return;
    end

    if (id) then
        local character = self:GetCtrlCharacter();
        if character == nil or character.IsDead() then
            local allCharacters = BattleCharacterMgr:GetAll();
            -- 获取当前我方队员信息
            if (allCharacters) then
                for _, tmpCharacter in pairs(allCharacters) do
                    if (tmpCharacter.data.type == eDungeonCharType.MyCard and id ~= tmpCharacter.GetId() and
                        tmpCharacter.IsDead() == false) then
                        character = tmpCharacter;
                    end
                end
            end
        end
        if (character) then
            character.SetSelectState(true);
            self:SetFollow(character.gameObject);
            -- if(character.IsFighting())then
            --     self:ShowCharacterMoveRange();
            -- else
            self:ShowCharacterMoveRange(character);
            -- CSAPI.DisableInput(1000);
            -- end
            if (not noEff) then
                self:CreateEff("Grid_VFX_2Op_Indicator_Teammate", character.GetCurrGridId());
            end
        end
        EventMgr.Dispatch(EventType.RogueMap_Battle_Character_Ctrl_Changed, character);

        -- 记录上一个有效的控制目标ID
        self.lastCtrlId = id;

        self:UpdateActionTurn(true);
    end

    -- self:UpdateCharactersMistState();
end

-- 获取控制的角色
function this:GetCtrlCharacter()
    if (self.moveCtrlTargetId == nil) then
        return;
    end

    local character = BattleCharacterMgr:GetCharacter(self.moveCtrlTargetId);
    return character;
end

function this:GetCtrlGridId()
    local character = self:GetCtrlCharacter()
    if not character then
        return
    end
    return character.GetCurrGridId()
end

function this:GetMyCharacterGridId()
    local character = BattleCharacterMgr:GetCharacter(self:GetDefaultCtrlId()) or self:GetCtrlCharacter()
    if character then
        return character.GetCurrGridId()
    end
end

function this:SetFollow(go)
    if (not self.ground) then
        return;
    end
    -- 已触发战斗不可改变追随目标
    if (self.triggerFight) then
        return;
    end
    self.ground.SetFollow(go);
end

-- 创建副本特效
function this:CreateEff(effName, gridId, callBack)
    if (not effName) then
        return;
    end

    effName = "battle/" .. effName;
    local grid = self:GetGrid(gridId);
    ResUtil:CreateEffect(effName, 0, 0.5, 0, grid.gameObject, callBack);

    -- self.aiMoveList = nil;
end

-- 刷新当前控制的角色可行动范围
function this:RefreshCharacterMoveRange()
    self:ShowPathLine()

    local character = self:GetCtrlCharacter();
    if character == nil then
        return
    end
    if self:IsMoveSetting() then
        self:ShowTargetMoveRange(character, self.currPaths[#self.currPaths], self:GetRealCost(character), self.currPaths)
    else
        self:ShowCharacterMoveRange(character);
    end
end

-- 显示角色移动范围
function this:ShowCharacterMoveRange(character)
    if (not self.ground) then
        return;
    end
    self.ground.SetLightRange(character);
end

-- 显示指定地点可移动范围
function this:ShowTargetMoveRange(character, targetId, customCost, customGridList)
    if (not self.ground) then
        return;
    end
    self.ground.SetTargetLightRange(targetId, customCost, customGridList)
end

-- 显示路径模型
function this:ShowPathLine()
    if (not self.ground) then
        return;
    end
    self.ground.SetPoint(self.currPaths)
end

function this:UpdateActionTurn(isPlayerAction)
    if (isPlayerAction ~= nil and self:IsCloseInput()) then
        return;
    end

    if (self.isPlayerAction == isPlayerAction) then
        return;
    end
    self.isPlayerAction = isPlayerAction;

    if (isPlayerAction ~= nil) then
        -- EventMgr.Dispatch(EventType.Battle_Turn_Changed,isPlayerAction);    
        -- LogError(isPlayerAction and "玩家行动回合" or "敌方行动");
    end
end

function this:IsCloseInput()
    if (not self.closeInputStates) then
        return false;
    end
    for _, closeInputState in pairs(self.closeInputStates) do
        if (closeInputState) then
            return true;
        end
    end

    return false;
end

function this:IsInMist(gridId, mistGridId)
    return false
end

-- 获取格子（新）
function this:GetGrid(gridId)
    return self.ground and self.ground.GetGrid(gridId);
end

-- 获取寻路时格子禁用状态
function this:GetGridBans(mainCharacter)
    local passBans = {}; -- 不可通过格子
    local targetBans = {}; -- 不可作为目标格子

    -- 地图单位（友军，怪物，道具）
    local characters = BattleCharacterMgr:GetAll();
    if (characters) then
        for id, character in pairs(characters) do
            if (not character.IsDead()) then
                local characterType = character.GetType();
                local characterGridId = character.GetCurrGridId();

                local canPass = self:IsCanPass(mainCharacter, character);
                if (not canPass) then
                    passBans[characterGridId] = 1;
                end

                if (characterType == eDungeonCharType.MyCard) then
                    -- 不可与友军单位重叠
                    targetBans[characterGridId] = 1;
                elseif (characterType == eDungeonCharType.Prop) then

                    -- 不可穿过道具
                    if (character.IsBlockCharacter(mainCharacter)) then
                        targetBans[characterGridId] = 1;
                    elseif (character.IsOneWay()) then
                        targetBans[characterGridId] = 1;
                    end
                end
            end
        end
    end

    local holeGrids = self:GetHoleGrids();
    if (holeGrids) then
        for _, grid in ipairs(holeGrids) do
            local holeType = grid.GetHoleType();
            if (holeType == eMapGridHoleType.Deep or (holeType == eMapGridHoleType.Shallow and not grid.IsHoleActive())) then
                local gridId = grid.GetID();
                passBans[gridId] = 1;
                targetBans[gridId] = 1;
            end
        end
    end

    return passBans, targetBans;
end

-- 获取坑洞格子
function this:GetHoleGrids()
    if (self.ground) then
        return self.ground.GetHoleGrids();
    end
end

function this:GetGridByGO(go)
    return self.ground and self.ground.GetGridByGO(go);
end

-- 是否可以穿过
function this:IsCanPass(character1, character2)
    local type1 = character1.GetType();
    local type2 = character2.GetType();

    -- 目标隐身，显示可以通过
    if (character2.IsInviside and character2.IsInviside()) then
        return true;
    end

    if (self.passArr == nil) then
        self.passArr = {};
        self.passArr[eDungeonCharType.MyCard] = {
            [eDungeonCharType.MyCard] = 1
        };
        -- self.passArr[eDungeonCharType.MyCard] = {[eDungeonCharType.MyCard] = 1,[eDungeonCharType.NpcCard] = 1};
        -- self.passArr[eDungeonCharType.NpcCard] = {[eDungeonCharType.MyCard] = 1,[eDungeonCharType.NpcCard] = 1};
        self.passArr[eDungeonCharType.MonsterGroup] = {
            [eDungeonCharType.MonsterGroup] = 1
        };
    end

    if (type2 == eDungeonCharType.Prop) then -- 可穿过的道具       
        if (character2.IsCanPass(character1)) then
            -- LogError(character2.cfg);
            if (not character2.IsBlockCharacter(character1)) then
                return true;
            end
        end
    end

    if (self.passArr[type1] and self.passArr[type1][type2]) then
        return true;
    end

    return false;
end

-- 设置地图操作模式 
function this:SetMapState(state)
    self.dungeonMapState = state;
end

function this:GetMapState()
    return self.dungeonMapState and self.dungeonMapState or eDungeonMapState.Normal;
end

function this:CheckClickGridTime()
    self.clickGridTime = self.clickGridTime or 0;

    local currTime = CSAPI.GetTime();
    local isCheck = math.abs(currTime - self.clickGridTime) >= 0.1;

    if (isCheck) then
        self.clickGridTime = currTime;
    end
    -- LogError(tostring(isCheck));
    return isCheck;
end

-- 获取目标格子上的单位列表
function this:GetUnitOnGrid(targetGridId, unitType)
    local allCharacters = BattleCharacterMgr:GetAll();
    if (allCharacters) then
        for _, tmpCharacter in pairs(allCharacters) do
            local gridId = tmpCharacter.GetCurrGridId();

            if (gridId == targetGridId) then
                if (tmpCharacter.GetType() == unitType) then
                    return tmpCharacter;
                end
            end
        end
    end
end

-- 寻找实际路径 isDrop:拖动寻路计算
function this:FindRealPathIDs(targetId, customCost, customIgnoreGridType, isDrop)
    local character = self:GetCtrlCharacter()
    local path = nil
    local pathIDs = {}
    local startId = self:IsMoveSetting() and self.currPaths[#self.currPaths] or character.GetCurrGridId();
    local removeIndex = 0
    if self.currPaths then
        for i, v in ipairs(self.currPaths) do
            if v == targetId and not isDrop then
                removeIndex = i
                break
            end
            table.insert(pathIDs, v)
            if v == targetId and isDrop then
                removeIndex = i
                break
            end
        end
    end
    if removeIndex == 0 then -- 目标不在路径中
        local bans = self:GetGridBans(character);
        local cost = self:GetRealCost(character, customCost)
        local height = character.GetJumpStep();
        local ignoreWaterCost = character.IsIgonreWaterCost();
        local ignoreGridType = customIgnoreGridType or character.GetType() == eDungeonCharType.MonsterGroup;
        path = self.ground.FindPath(startId, targetId, bans, cost, height, ignoreWaterCost, ignoreGridType);
        if #pathIDs > 0 then -- 去除起点
            table.remove(path, 1)
        end
    end
    if (path) then
        for _, grid in ipairs(path) do
            table.insert(pathIDs, grid.GetID());
        end
    end
    return pathIDs
end

-- 获取剩余的步数
function this:GetRealCost(character, customCost)
    character = character or self:GetCtrlCharacter()
    local cost = customCost or character.GetMoveStep()
    local realCost = cost
    if self.currPaths and #self.currPaths > 1 then
        realCost = cost - (#self.currPaths - 1) >= 0 and cost - (#self.currPaths - 1) or 0
    end
    return realCost
end

-- 寻找路径（用于给服务器寻路）
function this:FindPathNew(character, customCost, customIgnoreGridType)
    if not self:IsMoveSetting() then
        return
    end
    local bans = self:GetGridBans(character);
    local cost = customCost or character.GetMoveStep();
    local height = character.GetJumpStep();
    local ignoreWaterCost = character.IsIgonreWaterCost();
    local ignoreGridType = customIgnoreGridType or character.GetType() == eDungeonCharType.MonsterGroup;
    local path = nil
    local paths = {}
    for i, startId in ipairs(self.currPaths) do
        if i + 1 <= #self.currPaths then
            path = self.ground.FindPath(startId, self.currPaths[i + 1], bans, cost, height, ignoreWaterCost,
                ignoreGridType);
            if i ~= 1 then
                table.remove(path, 1)
            end
            if path then
                for k, m in ipairs(path) do
                    table.insert(paths, m)
                end
            end
        end
    end
    return paths
end

-- 移动角色
function this:AskMoveTo(proto)
    --    LogError("执行移动==========");
    --    LogError( data);
    -- if(not self:GetAIMoveState())then
    --     CSAPI.DisableInput(3000);
    -- end
    if proto.path then -- 按照服务器的路径
        self.recordPaths = {} -- 记录下来的路径
        local paths = {}
        for i, gridId in ipairs(proto.path) do
            table.insert(paths, gridId)
            self.recordPaths[gridId] = #proto.path - i
        end
        self.currPaths = paths
    end

    if not proto.arrChar or not proto.arrChar[1] then
        LogError("没有移动角色数据")
        return
    end

    local data = proto.arrChar[1]
    local character = BattleCharacterMgr:GetCharacter(data.oid);

    if (character == nil) then
        LogError("移动战棋目标失败！！！找不到目标");
        LogError(data);
        self:ApplyComplete();
        return;
    end
    if (data.state) then
        character.UpdateState(data.state);
    end
    self.moveData = data;

    self:SetMoveCtrlTarget(nil);
    self:UpdateCharacterState()
    self.ground.ApplyMove(character, data.pos, data.specialMove);
    self:SetFollow(character.gameObject);
    self:CleanMovePaths()
    self:ApplyComplete();
end

function this:MoveComplete()
    CSAPI.DisableInput(50);

    self:ApplyComplete();

    FightProto:RogueMapMoveEnd() -- 移动结束协议
end

-- 停止时触发的事件
function this:MoveEndTrigger(proto)
    self.recordPaths = nil
    self:UpdateCharactersMistState();
    -- LogError(self.currData);
    local moveData = self.moveData;
    self.moveData = nil;
    -- LogError("移动完成==========");
    -- LogError(moveData);

    if (moveData == nil) then
        return;
    end

    self:UpdateCharacter(moveData)

    self:UpdateMistGridEvent(moveData.pos,proto.ty, proto.tParam, proto.canFight)

    self.lastGridId = nil
    self:UpdateBossGridState(moveData.pos)

    self:UpdateCharacterState(true)

    self:UpdateCtrlState(self.ctrlState, true);

    if proto then
        self:ShowGirdEventContent(proto.ty, proto.tParam)
    end

    self:ApplyComplete();
end

-- 更新格子
function this:UpdateCharactersMistState(gridId)
    if self.ground == nil then
        return
    end
    self.ground.SetMist(gridId)
    local num = self.recordPaths and self.recordPaths[gridId] or nil
    if num then
        self:UpdateCharacterStepShow(num)
    end
    self:UpdateBossGridState(gridId,true)
end

-- 更新角色显示步数
function this:UpdateCharacterStepShow(num)
    EventMgr.Dispatch(EventType.RogueMap_Battle_Step_Refresh, num)
end

--更新boss格子的状态
function this:UpdateBossGridState(gridId,isMoving)
    if not gridId then
        return
    end
    EventMgr.Dispatch(EventType.RogueMap_Boss_Grid_State_Update,{gridId = gridId,isMoving = isMoving,lastGridId = self.lastGridId})
    self.lastGridId = gridId
end

--更新角色站位的状态
function this:UpdateCharacterState(isChange)
    local playerCharacter = BattleCharacterMgr:GetCharacter(self:GetDefaultCtrlId())
    if playerCharacter then
        if not isChange then
            CSAPI.SetAngle(playerCharacter.posNode.gameObject,0,0,0)
            CSAPI.SetLocalPos(playerCharacter.posNode.gameObject,0,0,0)
        elseif self.mistDis and self.mistDis[playerCharacter:GetCurrGridId()] and self.mistDis[playerCharacter:GetCurrGridId()].state == eDungeonCharState.Active then
            if (self.mistDis[playerCharacter:GetCurrGridId()].type == eRogueMapPosType.Boss or (self.mistDis[playerCharacter:GetCurrGridId()].type == eRogueMapPosType.SpecialBoss
                and self.mistDis[playerCharacter:GetCurrGridId()].specTime and self.mistDis[playerCharacter:GetCurrGridId()].specTime > TimeUtil:GetTime())) then
                local z,x =0,0
                local _,y = CSAPI.GetAngle(playerCharacter.gameObject)
                if (y > 45 and y <= 135) then -- y == 90
                    x = self:HasTimeShow(playerCharacter:GetCurrGridId()) and -0.25 or 0
                    z = -0.35
                elseif (y > 135 and y <= 225) then -- y == 180
                    x = 0.35
                    z = self:HasTimeShow(playerCharacter:GetCurrGridId()) and -0.25 or 0
                elseif (y > 225 and y <= 315) then --y == 270
                    z = 0.35
                    x = self:HasTimeShow(playerCharacter:GetCurrGridId()) and 0.25 or 0
                elseif (y <= 45 or y > 315) then -- y == 0
                    z = self:HasTimeShow(playerCharacter:GetCurrGridId()) and 0.25 or 0
                    x = -0.35
                end
                CSAPI.SetLocalPos(playerCharacter.posNode.gameObject,x, 0, z)
            end
        end
    end
end

function this:CheckBossTimeEnd()
    local playerCharacter = BattleCharacterMgr:GetCharacter(self:GetDefaultCtrlId())
    if playerCharacter then
        local dis = self.mistDis[playerCharacter:GetCurrGridId()]
        if dis and dis.state == eDungeonCharState.Active and dis.specTime then
            if dis.specTime <= TimeUtil:GetTime() then
                self:UpdateCharacterState()
            end
        end
    end
end

-- 处理停留格子的事件
function this:UpdateMistGridEvent(gridId,ty,param,isCanFight)
    if not self.mistDis or not self.mistDis[gridId] or not self.mistDis[gridId].type then
        return
    end
    
    local state = self.mistDis[gridId].state
    if state == eDungeonCharState.Death then
        return
    end

    if ty then --内容更新
        if ty == eRogueMapPosType.Buff and param then
            self.mistDis[gridId].buffId = param.buffid
            self.mistDis[gridId].buffRound = param.round
            self.mistDis[gridId].buffType = param.ty
        elseif ty == eRogueMapPosType.SpecialBoss and param then
            self.mistDis[gridId].specTime = param.nBossExpireTime
            self.mistDis[gridId].specGroupId = param.monsterGroupId
        end
    end

    local type = self.mistDis[gridId].type
    ----[[
    local typeStr = {"小怪", "BOSS", "特殊BOSS", "奖励", "地图道具", "行动资源", "BUFF"}
    Log(string.format("当前格子id:%s,触发格子事件:%s", gridId, typeStr[type]) ..
            table.tostring(self.mistDis[gridId]), "ffc146")
    -- ]]
    if not self:IsBattleGrid(gridId) then
        self.mistDis[gridId].state = eDungeonCharState.Death
    else
        self.mistDis[gridId].state = eDungeonCharState.Active
        if not isCanFight then --不能触发
            return
        end
    end
    EventMgr.Dispatch(EventType.RogueMap_Battle_GridEvent_Trigger, self.mistDis[gridId])
end

-- 显示格子事件内容
function this:ShowGirdEventContent(type, info)
    if not type or type < 1 or not info then
        return
    end
    Log("显示格子事件内容！类型：" .. type .. table.tostring(info), "ffffff")
    if type == eRogueMapPosType.Buff then
        -- EventMgr.Dispatch(EventType.RogueMap_Battle_FloatFont_Show, {
        --     content = RogueMapMgr:GetFloatFont(info.buffid)
        -- })
    elseif type == eRogueMapPosType.Prop then
        self:TryTriggerPropGridEvent(info)
    elseif type == eRogueMapPosType.Reward or type == eRogueMapPosType.Action then
        UIUtil:OpenReward(info)
    -- elseif type == eRogueMapPosType.Action then
    --     UIUtil:OpenReward(info)
    end
end

--触发道具格事件
function this:TryTriggerPropGridEvent(info)
    if info.ty == eRogueMapPropType.UnlockSingleBoss or info.ty == eRogueMapPropType.UnlockAllBoss then
        if info.posList and self.mistDis then
            for _, posId in pairs(info.posList) do
                if self.mistDis[posId] then
                    self.mistDis[posId].isUnLock = true
                end
            end
            EventMgr.Dispatch(EventType.RogueMap_Battle_Mist_Refresh)
            Log("触发透视Boss事件！！！类型：" .. (info.ty == eRogueMapPropType.UnlockSingleBoss and "单个透视" or "全部透视") .. table.tostring(info.posList))
        end
    end
end

--移动限制提示
function this:ShowMoveTips()
    if RogueMapMgr:IsCanRoll() then
        LanguageMgr:ShowTips(50005)
    else
        Tips.ShowTips(LanguageMgr:GetByID(1074))
    end
end

-- 移动路径
function this:UpdateMoveList(targetGridId, character, isDrop)
    character = character or self:GetCtrlCharacter();
    local id = character.GetId();
    if (character == nil) then
        LogError("申请移动战棋目标失败！！！找不到目标");
        LogError(id);

        return;
    end
    local startId = character.GetCurrGridId();
    if (startId == nil) then
        LogError("无法移动战棋目标，目标不在棋盘中" .. id);
    end

    if RogueMapMgr:IsCanRoll() and startId == targetGridId then --触发脚下的格子(因为有遮罩暂时无用)
        self:UpdateMistGridEvent(targetGridId)
        return
    end

    self.currPaths = self:FindRealPathIDs(targetGridId, 100, nil, isDrop);
    if (self.currPaths == nil) then
        -- LogError("不存在路径");
        return;
    end
    self:ShowCharacterStep(character)

    EventMgr.Dispatch(EventType.RogueMap_Battle_Grid_Click)

    self:RefreshCharacterMoveRange()

    -- LogTable(self.currPaths, "当前路径显示")
end

function this:SendToMove()
    if not self:IsMoveSetting() then
        LogError("缺少路径！！！！")
        return
    end
    -- 限制连续发送
    local sendTime = CSAPI.GetTime();
    -- LogError("self.lastSendTime：" .. tostring(self.lastSendTime) .."，self.sendTime：" .. tostring(sendTime));
    local isSend = not self.lastSendTime or sendTime > self.lastSendTime + 1;
    if (not isSend and not force) then
        return;
    end
    self.lastSendTime = sendTime;

    FightProto:RogueMapMove(self.currPaths)
end

function this:CleanMovePaths()
    self.currPaths = nil
    self:RefreshCharacterMoveRange()
    self:ShowCharacterStep()
    EventMgr.Dispatch(EventType.RogueMap_Battle_Grid_Click)
end

-- 是否有路径设置
function this:IsMoveSetting()
    return self.currPaths and #self.currPaths > 1
end

-- 设置格子状态
function this:UpdateMistViewDis()
    local mapList = self.battleData.map
    local dis = nil
    if mapList and #mapList > 0 then
        dis = {}
        local exData = nil
        for i, v in ipairs(mapList) do
            exData = v.exData or {}
            dis[v.pos] = {
                id = v.pos,
                type = v.ty,
                state = v.state,
                level = exData.level,
                times = exData.tNextFightTime,
                hp = exData.hpPer,
                supTime = exData.f_time,
                supIndex = exData.s_ix,
                --显示buff
                buffId = exData.buffid,
                buffRound = exData.round,
                buffType = exData.ty,
                --boss倒计时
                specTime = exData.nBossExpireTime,
                specGroupId = exData.monsterGroupId,
            }
        end
    end
    local unLockList = self.battleData.unlockPos
    if unLockList and #unLockList > 0 then
        dis = dis or {}
        for i, v in ipairs(unLockList) do
            dis[v] = dis[v] or {}
            dis[v].isUnLock = true
        end
    end

    self:SetMistDis(dis);
    self:UpdateCharactersMistState();
    EventMgr.Dispatch(EventType.RogueMap_Battle_GridInfo_Create)
end

function this:UpdateMistDis(proto)
    self.mistDis = self.mistDis or {}
    local exData = nil
    local isUnLock = false
    for i, v in ipairs(proto.changePos) do
        exData = v.exData or {}
        isUnLock = self.mistDis[v.pos] and self.mistDis[v.pos].isUnLock or false
        self.mistDis[v.pos] = {
            id = v.pos,
            type = v.ty,
            state = v.state,
            isUnLock = isUnLock,
            level = exData.level,
            times = exData.tNextFightTime,
            hp = exData.hpPer,
            supTime = exData.f_time,
            supIndex = exData.s_ix,
            --显示buff
            buffId = exData.buffid,
            buffRound = exData.round,
            buffType = exData.ty,
            --boss倒计时
            specTime = exData.nBossExpireTime,
            specGroupId = exData.monsterGroupId,
        }
    end
    EventMgr.Dispatch(EventType.RogueMap_Battle_Mist_Refresh)
    self:ApplyComplete()
end

function this:SetMistDis(mistDis)
    self.mistDis = mistDis;
end

function this:GetMistDis()
    return self.mistDis
end

function this:GetCtrlMistDis()
    local gridId = self:GetCtrlGridId()
    if gridId and self.mistDis then
        return self.mistDis[gridId]
    end
end

function this:ShowCharacterStep(character)
    character = character or self:GetCtrlCharacter()
    if not character then
        return
    end
    if self.currPaths and #self.currPaths > 1 then
        self:UpdateCharacterStepShow(character.GetMoveStep() - (#self.currPaths - 1))
    else
        self:UpdateCharacterStepShow(character.GetMoveStep())
    end
end

-- 场上有支援存在
function this:IsGridHasSupport(id)
    if self.mistDis then
        for k, v in pairs(self.mistDis) do
            if v.id == id and v.supTime and v.supTime - TimeUtil:GetTime() > 0 then
                return true
            end
        end
    end
    return false
end

-- 快速战斗格子
function this:IsGridFastFight(id)
    if not RogueMapMgr:IsCanRoll() then
        return
    end
    
    local dis = self.mistDis and self.mistDis[id]
    if dis and dis.isUnLock and dis.type ~= nil 
        and (dis.type == eRogueMapPosType.Boss or dis.type == eRogueMapPosType.SpecialBoss) 
        and dis.state ~= eDungeonCharState.Death then
        return dis.times and (dis.times[1] > 0 or dis.times[2] > 0)
    end
    return false
end

function this:IsGridFight(id)
    local dis = self.mistDis and self.mistDis[id]
    if dis and dis.isUnLock and (dis.type == eRogueMapPosType.Boss or dis.type == eRogueMapPosType.SpecialBoss) 
    and dis.state ~= eDungeonCharState.Death then
        return true
    end
end

function this:IsGridShowBuff(id)
    local dis = self.mistDis and self.mistDis[id]
    if dis and dis.isUnLock and dis.type == eRogueMapPosType.Buff and dis.state ~= eDungeonCharState.Death then
        return true
    end
    return false
end

function this:UpdateSupportInfo(proto)
    if proto and proto.pos and proto.info then
        if self.mistDis and self.mistDis[proto.pos] then
            self.mistDis[proto.pos].supTime = proto.info.f_time
            self.mistDis[proto.pos].supIndex = proto.info.s_ix
        end
    end
    EventMgr.Dispatch(EventType.RogueMap_Battle_Mist_Refresh)

    self:ApplyComplete()
end

-- 显示求援界面
function this:TryShowSupport()
    if RogueMapMgr:IsShowSupportView() then
        EventMgr.Dispatch(EventType.RogueMap_Battle_Support_Show)
    end
end

--通关界面
function this:TryShowPass()
    EventMgr.Dispatch(EventType.RogueMap_Battle_Pass_Show)
end

--编队界面
function this:TryShowTeamInfoView()
    if RogueMapMgr:IsShowSupportView() then
        return
    end
    if not self.battleData.canFight then --不可触发战斗
        return
    end
    if RogueMapMgr:GetIsDirll() then --上一场战斗是模拟
        RogueMapMgr:SetIsDirll(false)
        EventMgr.Dispatch(EventType.RogueMap_Battle_GridEvent_Trigger,self:GetCtrlMistDis())
    elseif self:IsGridFight(self:GetCtrlGridId()) then --站在boss格子上
        EventMgr.Dispatch(EventType.RogueMap_Battle_GridEvent_Trigger,self:GetCtrlMistDis())
    end
end

--buff选择界面
function this:TryShowBuffSelect()
    if self:IsGridShowBuff(self:GetCtrlGridId()) then
        EventMgr.Dispatch(EventType.RogueMap_Battle_GridEvent_Trigger,self:GetCtrlMistDis())
    end
end

-- 显示骰子动效
function this:ShowRollEffect(proto)
    local step = proto and proto.nStep or 1
    local func = function()
        self:UpdateCharacter(proto)
        EventMgr.Dispatch(EventType.RogueMap_Battle_View_Update)
        self:ApplyComplete()
    end
    self.isRollEffect = true
    CSAPI.OpenView("RogueMapVideo", {
        name = "richman_throw_normal_" .. step,
        time = 4000
    }, func)
end

function this:IsRollEffect()
    return self.isRollEffect
end

function this:SetRollEffect(b)
    self.isRollEffect = b
end

function this:IsBattleGrid(gridId)
    if self.mistDis and self.mistDis[gridId] and self.mistDis[gridId].type then
        local type = self.mistDis[gridId].type
        return type == eRogueMapPosType.SpecialBoss or type == eRogueMapPosType.Monster or type == eRogueMapPosType.Boss
    end
    return false
end

--时间显示
function this:HasTimeShow(gridId)
    if self.mistDis and self.mistDis[gridId] and self.mistDis[gridId].type and self.mistDis[gridId].type == eRogueMapPosType.SpecialBoss then
        if self.mistDis[gridId].supTime and TimeUtil:GetTime() < self.mistDis[gridId].supTime then
            return true
        elseif self.mistDis[gridId].times then
            if self.mistDis[gridId].times[1] > TimeUtil:GetTime() then
                return true
            elseif self.mistDis[gridId].times[2] > TimeUtil:GetTime() then
                return true
            end
        end
    end
    return false
end
------------------------------------流程------------------------------------
-- 启动
function this:ApplyStart()
    self.isStart = 1;

    self:ApplyLoadComplete();

    self:HandleCacheData();

    self:ApplyNext();

    self.disableInputTime = 1;
end

-- 处理下一个
function this:ApplyNext()
    if (self.isStart == nil) then
        return false;
    end
    if (self.currData) then
        return false;
    end
    if (self.isFighting) then
        return false;
    end

    if (#self.datas == 0) then
        -- LogError("副本数据处理完毕");
        -- self:TryOpenFightFormationView();
        -- CSAPI.DisableInput(100);
        self:SetInputState(true);
        return false;
    end
    -- CSAPI.DisableInput(3000);
    self:SetInputState(false);
    self.currData = table.remove(self.datas, 1);
    -- LogError("应用副本数据" .. table.tostring(self.currData));
    self.currData.func(self, self.currData.data);

    return true;
end

function this:GetCurrData()
    return self.currData;
end

function this:ApplyComplete(data)
    -- LogError("副本操作完成" .. table.tostring(self.currData));
    self.currData = nil;
    self:ApplyNext();
end

-- 添加数据
function this:PushData(data, func)
    self.datas = self.datas or {};
    -- LogError("副本数据入列" .. table.tostring(data));
    table.insert(self.datas, {
        data = data,
        func = func
    });
    self:ApplyNext();
end

-- 还原
function this:Revert(data)
    -- LogError( "还原副本系统=====================");
    -- LogError( data);

    self.isInited = 1;
    self.battleData = data;
    self.dungeonSetting = self:GetDungeonSetting(data.nDuplicateID);
    self:CreateCharacters(data.arrChar);

    self:ApplyLoadComplete();
    self.isReverting = 1;
    FuncUtil:Call(self.RevertComplete, self, 2000);
    -- self:ApplyComplete();    

    self:TryPlayBGM();
end

function this:RevertComplete()
    if (not self.isReverting) then
        return;
    end
    self.isReverted = 1;
    self.isReverting = nil;
    FuncUtil:Call(self.ApplyComplete, self, 800);
end

------------------------------------加载------------------------------------
function this:ApplyLoadComplete(isForce)
    if (not isForce) then
        if (not self.isStart or not self.isInited) then
            return;
        end
    end
    -- 关闭loading界面
    EventMgr.Dispatch(EventType.Loading_Weight_Update, loading_weight_key);
end

------------------------------------缓存------------------------------------
-- 处理缓存数据
function this:HandleCacheData()
    if (not self.cacheDatas or #self.cacheDatas == 0) then
        return;
    end
    --    LogError("未处理副本数据");
    --    LogError(self.cacheDatas);

    if (not self.battleData) then
        self.cacheDatas = nil;
        LogError("无副本数据缓存，无法复原副本旧副本数据！将直接用新数据构造副本");
        return;
    end

    local count = #self.cacheDatas;
    for i = 1, count do
        local cacheData = self.cacheDatas[count - i + 1];
        table.insert(self.datas, 1, cacheData);
    end

    table.insert(self.datas, 1, {
        data = self.battleData,
        func = self.Revert
    });
end

------------------------------------方法------------------------------------
-- 初始化
function this:Init(data)
    --    LogError( "进入副本系统=====================");
    --    LogError( data);
    -- 进入副本前，释放声音资源
    if (SceneMgr and SceneMgr:IsMajorCity()) then
        ReleaseMgr:ReleaseSound();
    end

    self.isInited = 1;
    self.battling = 1;
    self.battleData = data;
    self.dungeonSetting = self:GetDungeonSetting(data.nDuplicateID);
    self:CreateCharacters(data.arrChar);
    self:UpdateMistViewDis();

    self:UpdateCharacterState(true)
    -- self:HideNewMonsters();

    self:ApplyLoadComplete();

    -- if(self:NeedShowThunderWarning())then
    --      self.needApplyComplete = 1;
    -- else
    self:ApplyComplete();
    -- end

    self:TryPlayBGM();

    -- self.bIsNewWave = data.bIsNewWave and not self.isReverted;

    -- if(self:HasPlot() or self:NeedShowExplore())then
    --     self.dontAutoTriggerGuide = 1;  
    -- end

    self:TryPlayPlot0();

    self:ShowBattleView();

    -- if(not self.bIsNewWave)then
    self:UpdateCtrlState(true);
    -- end
end

function this:GetDungeonSetting(id)
    self.dungeonSettings = self.dungeonSettings or {};
    if (self.dungeonSettings[id] == nil) then
        self.dungeonSettings[id] = Loader:Require("Dungeon_" .. id);
    end

    return self.dungeonSettings[id];
end

function this:TryPlayBGM()
    local currId = RogueMapMgr:GetDungeonId();
    local cfgDungeon = Cfgs.MainLine:GetByID(currId);
    if (cfgDungeon) then
        EventMgr.Dispatch(EventType.Play_BGM, cfgDungeon.bgm);
    end
end

-- 尝试播放副本开头剧情
function this:TryPlayPlot0()
    local currId = RogueMapMgr:GetDungeonId();
    local cfgDungeon = Cfgs.MainLine:GetByID(currId);

    local plotState = PlotMgr:TryPlay(cfgDungeon.storyID0, self.OnPlayPlot0Complete, self);
    if (plotState) then
        self:UpdateInputState("plot0", true);
        FuncUtil:Call(EventMgr.Dispatch, nil, 50, EventType.Plot_Close_Delay, 500);
    end
    return plotState;
end

function this:OnPlayPlot0Complete()
    -- self:ApplyExploreAfterLoadingViewClosed();
    self:UpdateInputState("plot0");
end

function this:ShowBattleView()
    EventMgr.Dispatch(EventType.RogueMap_Battle_View_Show);
end

function this:TriggerGuide()
    local cfgScene = SceneMgr:GetCurrScene();
    if (not cfgScene or cfgScene.key ~= "RogueMap") then
        return;
    end

    if (self.loadingComplete) then
        if (GuideMgr:HasGuide("RogueMapBattle")) then
            FuncUtil:Call(self.EnableGuideInputState, self, 3000);
        else
            self:EnableGuideInputState();
        end
        -- LogError("引导")
        EventMgr.Dispatch(EventType.Guide_Trigger, "RogueMapBattle");
    end
end

function this:EnableGuideInputState()
    self:UpdateInputState("guide");
end

function this:IsBatting()
    return self.battling;
end

return this
