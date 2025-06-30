local state = BaseState:New(BattleState.BattleEnd)



-- 随便找个单位播放通关音乐，播放组件在单位身上
local function RandomPlayBattleWin(battleComp)
    local uu = table.randget(table.values(table.choose(battleComp.IdUnits,function (k,v)
        return v:GetComponent("SsUnitMatrixComponent").Group == MatrixGroup.Friend  and not v:GetComponent("CharacterComponent").IsDead
    end)))
    if uu == nil then
        Logger.LogError("RandomPlayBattleWin??")
        return 
    end
    uu:GetComponent("SsUnitVoiceComponent"):CoPlayBattleWin()
end

local function CompetitionSettlement(battleComp)
    local battle_result
    if battleComp:GetBattleResult() == BattleResultType.BattleResultGiveUp then
        battle_result = BattleResultType.BattleResultGiveUp
    elseif table.all(table.choose(battleComp.IdUnits,function (k,v) return v:GetComponent("SsUnitMatrixComponent").Group == MatrixGroup.Friend end),
    function (v) return v:GetComponent("CharacterComponent").IsDead end) then
        battle_result = BattleResultType.BattleResultFailure
    else
        battle_result = BattleResultType.BattleResultWin
    end
    coroutine.start(function ()
        local req = {
            battle_id = battleComp.against_component.BattleData.BattleId,
            battle_result = battle_result,
            reached_goals = {}
        }
        local rsp = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
                PROTOCOL.BattleFinishReq, req)
        UIUtil.OpenBattleSettleWindow(req, rsp)            
    end)    
end

-- 总力战结算
local function BossraidSettlement(battleComp)

    local totalPlayerMovementCount = 0
    local monsterRecord = {}

    local battle_result = BattleResultType.BattleResultFailure

    table.walk(battleComp.IdUnits,function(unitId, unit)
        local record = battleComp:GetUnitRecord(unitId)
        -- 记录残余血量
        record:RecordRemainHp(unit:GetComponent("NumericComponent"):Get(NumericType.Hp))
    
        -- todo 用战斗结束条件判断
        if unit.IsBoss == 1 and unit:GetComponent("CharacterComponent").IsDead then
            battle_result = BattleResultType.BattleResultWin
        end

        if record:Group() == MatrixGroup.Friend then
            totalPlayerMovementCount = totalPlayerMovementCount + record:MovementCount()
        else
            table.insert(monsterRecord, record:SerializeToBossraidMonsterDesc())
        end
   end)

   coroutine.start(function ()
    local req = {
        battle_id = battleComp.against_component.BattleData.BattleId,
        battle_result = battle_result,
        reached_goals = {},
        battle_data =
        {
            bossraid_desc = 
            {
                monster = monsterRecord,
                player_move = totalPlayerMovementCount,
            }
        },
    }

    local rsp = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            PROTOCOL.BattleFinishReq, req)
    UIUtil.OpenBattleSettleWindow(req, rsp)
end)

end

local function BattleSettlement(battleComp)
    Time.timeScale = 1;

    if battleComp.against_component.LevelType == LevelType.LevelTypeTest then
        coroutine.start(function ()
            coroutine.waitforseconds(2)
            Game.Scene:GetComponent("BattleComponent").fsm:Switch(BattleState.LeaveScene)
        end)
        return
    end
    --争霸模式结算
    if battleComp.against_component.LevelType == LevelType.LevelTypeArena then
        CompetitionSettlement(battleComp)
        return
    elseif battleComp.against_component.LevelType == LevelType.LevelTypeBossraid then
        BossraidSettlement(battleComp)
        return
    end

    -- 通用战斗放弃
    if battleComp:GetBattleResult() == BattleResultType.BattleResultGiveUp then
        coroutine.start(function ()
            local req = {
                battle_id = battleComp.against_component.BattleData.BattleId,
                battle_result = BattleResultType.BattleResultGiveUp,
            }
            coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            PROTOCOL.BattleFinishReq, req)

            Game.Scene:GetComponent("BattleComponent").fsm:Switch(BattleState.LeaveScene)
        end)

        return
    end

    -- todo tm的战斗结算一坨屎我真不知道怎么改好

    -- 玩家全部死了，弹出复活窗口
    --if battleComp.cond_rewards[1].cond == 1 then --正常通关条件，玩家角色都死了，就是战斗失败
        if table.all(table.choose(battleComp.IdUnits,function (k,v) return v:GetComponent("SsUnitMatrixComponent").Group == MatrixGroup.Friend end),
                function (v) return v:GetComponent("CharacterComponent").IsDead end) then
            local req = {
                battle_id = battleComp.against_component.BattleData.BattleId,
                battle_result = BattleResultType.BattleResultFailure
            }
            local confirmFinishCallback = function()
                coroutine.start(function()
                    local rsp = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
                            PROTOCOL.BattleFinishReq, req)
                    UIUtil.OpenBattleSettleWindow(req,rsp)
                end)
            end
            if battleComp.reviveTimes > 0 then
                local data = {}
                data.confirmFinishCallback = confirmFinishCallback
                UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattleRevive, data)
            else
                confirmFinishCallback()                                
            end
            return
        end
    --end
    coroutine.start(function () 
        coroutine.waitforseconds(2)
        Game.Scene:GetComponent("PlayerBattleComponent"):PlayAnim(PlayerAnim.Victory)
    end)
    Game.Scene:GetComponent("AgainstComponent").BattleWin = true
    RandomPlayBattleWin(battleComp)
    --通关星级检测-------------------------------------------------------------------------------------------------

    if battleComp.against_component.LevelType == LevelType.LevelTypeStory 
        or battleComp.against_component.LevelType == LevelType.LevelTypeGameEvent  then
        local GuideComplete, GuideStep ,run = Game.Scene:GetComponent("BattleComponent").GuideComponent:GetCurrentData()
        if run then
            Game.Scene:GetComponent("BattleComponent").GuideComponent:EndGuide()
        end
    end

    if CommonSettleBattleType[battleComp.against_component.LevelType] then
        local reachedGoals = {}
        if battleComp.ZBattleLevel.PerfectConditions ~= nil then
            for _, condition in pairs(battleComp.ZBattleLevel.PerfectConditions) do
                local z_Condition = Z_BattleEndCondition[condition]
                if z_Condition.Type == BattleEndConditionType.KillAll then
                    if table.all(table.choose(battleComp.IdUnits,function (k,v) return v:GetComponent("SsUnitMatrixComponent").Group == MatrixGroup.Enemy end),
                            function (v) return v:GetComponent("CharacterComponent").IsDead end) then
                        table.insert(reachedGoals, condition)
                    end
                elseif z_Condition.Type == BattleEndConditionType.Turn then
                    if table.all(table.choose(battleComp.IdUnits,function (k,v) return v:GetComponent("SsUnitMatrixComponent").Group == MatrixGroup.Enemy end),
                            function (v) return v:GetComponent("CharacterComponent").IsDead end) and 
                            battleComp.OverallTurnNum <= z_Condition.Params[1] then
                        table.insert(reachedGoals, condition)
                    end
                elseif z_Condition.Type == BattleEndConditionType.DeadCount then
                    local count = table.count(table.choose(battleComp.IdUnits,function (k,v)
                        return v:GetComponent("SsUnitMatrixComponent").Group == MatrixGroup.Friend and v:GetComponent("CharacterComponent").IsDead
                    end))
                    if count <= z_Condition.Params[1] then
                        table.insert(reachedGoals, condition)
                    end
                end
            end
        end
        
        local battleData = {}
        battleData.statistics = {}
        battleData.statistics.enemy_records = {}
        for k, v in pairs(battleComp.Statistics.EnemyRecords) do
            local record = {
                enemy_id = k,
                eliminate_count = v,
            }
            table.insert(battleData.statistics.enemy_records, record)
        end
        coroutine.start(function ()
            local req = {
                battle_id = battleComp.against_component.BattleData.BattleId,
                battle_result = BattleResultType.BattleResultWin,
                reached_goals = reachedGoals,
                battle_data = battleData,
            }
            local rsp = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
                    PROTOCOL.BattleFinishReq, req)
            UIUtil.OpenBattleSettleWindow(req, rsp)            
        end)        
    end

    if battleComp.against_component.LevelType == LevelType.LevelTypeGuide then
        print("battleComp.against_component.LevelType == LevelType.LevelTypeGuide")

        local reqData1={}
        -- local GuideList = table.first(Game.Scene:GetComponent("BattleComponent").GuideComponent.GuideList,function(a) return a.Id==1001  end)
        -- if GuideList~=nil then
        --     local step = 26 - GuideList.Step
        --     if step <= 0 then
        --         reqData1 = {Type = 1,Id=1001}
        --     else
        --         reqData1 = {Type = step,Id=1001}
        --     end
        -- else
            reqData1 = {Type = BattleGuideEndStep,Id=BattleGuideId}
        -- end
        
        local reachedGoals = {}
        if battleComp.ZBattleLevel.PerfectConditions ~= nil then
            for _, condition in pairs(battleComp.ZBattleLevel.PerfectConditions) do
                local z_Condition = Z_BattleEndCondition[condition]
                if z_Condition.Type == BattleEndConditionType.KillAll then
                    if table.all(table.choose(battleComp.IdUnits,function (k,v) return v:GetComponent("SsUnitMatrixComponent").Group == MatrixGroup.Enemy end),
                            function (v) return v:GetComponent("CharacterComponent").IsDead end) then
                        table.insert(reachedGoals, condition)
                    end
                elseif z_Condition.Type == BattleEndConditionType.Turn then
                    if table.all(table.choose(battleComp.IdUnits,function (k,v) return v:GetComponent("SsUnitMatrixComponent").Group == MatrixGroup.Enemy end),
                            function (v) return v:GetComponent("CharacterComponent").IsDead end) and 
                            battleComp.OverallTurnNum <= z_Condition.Params[1] then
                        table.insert(reachedGoals, condition)
                    end
                elseif z_Condition.Type == BattleEndConditionType.DeadCount then
                    local count = table.count(table.choose(battleComp.IdUnits,function (k,v)
                        return v:GetComponent("SsUnitMatrixComponent").Group == MatrixGroup.Friend and v:GetComponent("CharacterComponent").IsDead
                    end))
                    if count <= z_Condition.Params[1] then
                        table.insert(reachedGoals, condition)
                    end
                end
            end
        end

        Game.Scene:GetComponent("BattleComponent").GuideComponent:ChooseDate(reqData1)
        Game.Scene:GetComponent("BattleComponent").GuideComponent:EndGuide()

        coroutine.start(function ()
            local req = {
                battle_id = battleComp.against_component.BattleData.BattleId,
                battle_result = BattleResultType.BattleResultWin,
                reached_goals = reachedGoals
            }
            local rsp = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
                    PROTOCOL.BattleFinishReq, req)
            UIUtil.OpenBattleSettleWindow(req, rsp)             
        end)

    end
    
end

function state:OnInit()
    state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
    if state.battleComp == nil or state.battleComp.__entity == nil then
        print("BattleEnd:OnEnter:state.battleComp == nil or state.battleComp.__entity == nil")
        return
    end
    local camera = state.battleComp.__entity:GetComponent("BattleCameraComponent")
    if camera == nil then
        print("BattlseEnd:OnEnter:camera == nil")
        return
    end
    coroutine.start(function ()
        coroutine.waitforseconds(1)
        camera:SwitchCameraByPos(CameraType.Center)
    end)
    BattleSettlement(state.battleComp)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state