local state = BaseState:New(BattleState.BatchEnd)

function state:OnInit()
     state.battleComp=Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     coroutine.start(function ()
          -- 战斗过程中是可以打开buff窗口，所以自动战斗批次完了需要关闭掉
          local buffGlances = UIManager:GetInstance():GetWindow(UIWindowNames.UIBuffGlances)
          if UIManager:GetInstance():GetWindow(UIWindowNames.UIBuffGlances) ~= nil then
               buffGlances.View:ShutDown()
          end
          if UIManager:GetInstance():GetWindow(UIWindowNames.UIBuffDetails) ~= nil then
               UIManager:GetInstance():CloseWindow(UIWindowNames.UIBuffDetails)
          end
          if UIManager:GetInstance():GetWindow(UIWindowNames.UIDetail) ~= nil then
               UIManager:GetInstance():CloseWindow(UIWindowNames.UIDetail)
          end
          
          state.battleComp:OnBatchEnd()
          --玩家所有单位死亡
          local isPlayerAllDead = table.all(table.choose( state.battleComp.IdUnits,function (k,v) return v:GetComponent("SsUnitMatrixComponent").Group == MatrixGroup.Friend end),
                  function (v) return v:GetComponent("CharacterComponent").IsDead end)
          if not isPlayerAllDead and  state.battleComp.BatchNum <  state.battleComp.TotalBatch then --玩家有存活单位并且批次不是最后一批
               state.battleComp.CacQueue:clear() --清空反击队列
               state.battleComp.ExtraSkillQueue:clear() --清空额外技能队列
               state.battleComp.SuoLifeQueue:clear()
               state.battleComp.AutoGAtkQueue:clear() --清空连击队列
               state.battleComp.BattleArraySkillQueue:clear() --清空战阵技能队列
               state.battleComp.TempSaveQueue:clear() --清空暂存单位行动队列
               state.battleComp.SuoLifeTempSaveQueue:clear() --清空暂存单位行动队列
               state.battleComp.HighReadyQueue:clear() --清空高优先级队列
               state.battleComp.MediumReadyList = {} --中优先级
               state.battleComp.LowReadyQueue:clear() --低优先级

               table.walk(state.battleComp.IdUnits,function(k,v) --遍历所有单位
                    if v.IsPlayer then --玩家单位
                         v:GetComponent("SsUnitUIComponent"):DestroySrAvatar() -- 清除竞速头像
                         local sbc = v:GetComponent("SsUnitBattleComponent")
                         -- 重置反击和额外技能
                         sbc:ClearExtraMove()
                    else --敌方单位
                         v:Dispose() --销毁敌方单位
                         state.battleComp.IdUnits[k] = nil
                    end
               end)
               state.battleComp.BatchNum = state.battleComp.BatchNum + 1 --批次+1
               --设置为批次开始
               state.battleComp.fsm:Switch(BattleState.BatchStart)
          else--战斗结束
               state.battleComp.fsm:Switch(BattleState.BattleEnd)
          end
     end)
end

function state:OnUpdate()

end

function state:OnLeave()

end
return state