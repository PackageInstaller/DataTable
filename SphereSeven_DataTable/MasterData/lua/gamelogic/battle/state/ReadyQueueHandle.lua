local state = BaseState:New(BattleState.ReadyQueueHandle)

local function GetSpeedVal(ssUnit)
     return ssUnit:GetComponent("NumericComponent"):Get(NumericType.Speed)
end

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

-- 连击：
-- 反击：被攻击后进行反击
-- 索命：对下个将要行动的敌人自动进行一次普通攻击。
-- 霸者雄心被动，拿破仑战魂 ：每回合开始时对随机1名敌人进行一次普通攻击
-- boss buff:
-- 神行：每回合连续行动2次。当前行动是自己，那下一次必须是自己
-- 强袭：每回合开始时必定第一个行动，如果有获得相同效果的角色则按速度属性来决定行动顺序。
-- 竞速：优先级最低

-- 获取行动对象控制当前回合的行动单位
function state:OnEnter()
     coroutine.start(function ()
          -- 前面几个优先级是强制攻击，不给操作机会
          if state.battleComp.CacQueue:size() > 0 then -- 反击
               state.battleComp.CurActType = ActType.Cac
               local unit = state.battleComp.CacQueue:dequeue() 
               state.battleComp:SetCurAct(unit, nil)
               state.battleComp:SetCurActSkill(state.battleComp.CurActUnit:GetComponent("SkillComponent"):GetActiveSkill(), true)
               unit:GetComponent("SsUnitBattleComponent").IsCac = true
               state.battleComp:DoSkillForce(unit:GetComponent("SsUnitBattleComponent").CacUnit)
               return
          elseif state.battleComp.ExtraSkillQueue:size() > 0 then -- 额外技能
               state.battleComp.CurActType = ActType.ExtraSkill
               local unit = state.battleComp.ExtraSkillQueue:dequeue()
               state.battleComp:SetCurAct(unit, nil)
               local ssUnitBattleComponent = unit:GetComponent("SsUnitBattleComponent")
               state.battleComp:SetCurActSkill(ssUnitBattleComponent.ExtraSkill, true)
               ssUnitBattleComponent.IsProcesingExtraSkill = true
               state.battleComp:DoSkillForce(ssUnitBattleComponent.ExtraSkillTarget)
          elseif state.battleComp.SuoLifeQueue:size() > 0 then -- 自动普攻技能 索命
               state.battleComp.CurActType = ActType.SuoLife
               state.battleComp:SetCurAct(state.battleComp.SuoLifeQueue:dequeue(), nil)
               state.battleComp:SetCurActSkill(state.battleComp.CurActUnit:GetComponent("SkillComponent"):GetActiveSkill(), true)
               local target
               if state.battleComp.ExpectTargetUnitId ~= nil then
                    target = state.battleComp.IdUnits[state.battleComp.ExpectTargetUnitId]
               else
                    target = state.battleComp:GetAITarget(state.battleComp.CurActSkill.ZSkill)
               end
               -- 全体技能获取不到目标
               if state.battleComp.CurActSkill.ZSkill.IsNeedChoose ~= 1 and target == nil then
                    state.battleComp:DoSkill(target)
               else
                    state.battleComp:DoSkillForce(target)
               end
               return
          elseif state.battleComp.AutoGAtkQueue:size() > 0 then -- 自动普攻技能 索命
               state.battleComp.CurActType = ActType.GAtk
               state.battleComp:SetCurAct(state.battleComp.AutoGAtkQueue:dequeue(), nil)
               state.battleComp:SetCurActSkill(state.battleComp.CurActUnit:GetComponent("SkillComponent"):GetActiveSkill(), true)
               local target
               if state.battleComp.ExpectTargetUnitId ~= nil then
                    target = state.battleComp.IdUnits[state.battleComp.ExpectTargetUnitId]
               else
                    target = state.battleComp:GetAITarget(state.battleComp.CurActSkill.ZSkill)
               end
               -- 全体技能获取不到目标
               if state.battleComp.CurActSkill.ZSkill.IsNeedChoose ~= 1 and target == nil then
                    state.battleComp:DoSkill(target)
               else
                    state.battleComp:DoSkillForce(target)
               end
               return
          elseif state.battleComp.TempSaveQueue:size() > 0 then -- 战阵和信条缓存的行动，boss每回合默认行动两次
               state.battleComp:SetCurAct(state.battleComp.TempSaveQueue:dequeue(), nil)
               state.battleComp.CurActUnit:GetComponent("SsUnitUIComponent"):OnReAct()
          elseif state.battleComp.SuoLifeTempSaveQueue:size() > 0 then -- 竞速行动角色被索命缓存
               local unit = state.battleComp.SuoLifeTempSaveQueue:dequeue()
               state.battleComp.CurActType = unit.SuoActType
               state.battleComp:SetCurAct(unit, nil)
               state.battleComp.CurActUnit:GetComponent("SsUnitUIComponent"):OnReAct()
          elseif state.battleComp.HighReadyQueue:size() > 0 then -- 神行
               state.battleComp.CurActType = ActType.Sinhaeng
               state.battleComp:SetCurAct(state.battleComp.HighReadyQueue:dequeue(), nil)
               state.battleComp.CurActUnit:GetComponent("SsUnitUIComponent"):OnReAct()
          elseif #state.battleComp.MediumReadyList > 0 then -- 强袭
               state.battleComp.CurActType = ActType.Storm
               local unit = table.sortedfirst(state.battleComp.MediumReadyList,function (lv,rv) return GetSpeedVal(lv) > GetSpeedVal(rv) end) --设置第一个单位为当前行动单位
               state.battleComp:SetCurAct(unit, nil)
               table.removeall(state.battleComp.MediumReadyList,function (v) return v.UID == state.battleComp.CurActUnit.UID end) --将此单位从队列中删除
               state.battleComp.CurActUnit:GetComponent("SsUnitUIComponent"):OnReAct()
          elseif state.battleComp.LowReadyQueue:size() > 0 then -- 竞速
               state.battleComp.CurActType = ActType.Speed
               state.battleComp:SetCurAct(state.battleComp.LowReadyQueue:dequeue(), nil)
          end

          -- if not state.battleComp:IsCurActUnitEnableAct() then
          --      state.battleComp.fsm:Switch(BattleState.UnitActEnd)
          --      return
          -- end
          
          -- 索命
          -- local group = state.battleComp.CurActUnit:GetComponent("SsUnitMatrixComponent").Group --获取行动单位阵营
          -- local enemyUnits = state.battleComp:GetEnemyGroupUnits(group)
          -- local isPush = false
          -- for k,v in pairs(enemyUnits) do
          --      if v:GetComponent("CharacterComponent").IsSuoLife then
          --           state.battleComp.SuoLifeQueue:enqueue(v)
          --           v:GetComponent("CharacterComponent").IsSuoLife = false
          --           if not isPush then
          --                isPush = true
          --                -- 缓存被索命的角色和被索命的行动
          --                state.battleComp.SuoLifeTempSaveQueue:enqueue(state.battleComp.CurActUnit)
          --                state.battleComp.CurActUnit.SuoActType = state.battleComp.CurActType
          --                -- 索命的对象
          --                state.battleComp.ExpectTargetUnitId = state.battleComp.CurActUnit.UID
          --           end
          --      end
          -- end
          -- if isPush then state.battleComp.fsm:Switch(BattleState.ReadyQueueHandle) return end

          -- 无索命效果
          state.battleComp.ExpectTargetUnitId = nil

          if state.battleComp:IsUnitTurnStart() then
               state.battleComp.fsm:Switch(BattleState.UnitTurnStart)
          else
               state.battleComp.fsm:Switch(BattleState.SpeedRace)
          end
     end)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state