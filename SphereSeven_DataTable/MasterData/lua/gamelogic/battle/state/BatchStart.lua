local state = BaseState:New(BattleState.BatchStart)

---初始化敌方单位
local function CoGenBatchMonsters(battleComp)
     if battleComp.against_component.LevelType == LevelType.LevelTypeArena then
          return
     end
     
     local batch --当前批次怪物明细
     if battleComp.BatchNum == 1 then
          batch = battleComp.against_component:LoadBatch(battleComp.ZBattleLevel.Batch1)
     elseif battleComp.BatchNum == 2 then
          batch = battleComp.against_component:LoadBatch(battleComp.ZBattleLevel.Batch2)
     elseif battleComp.BatchNum == 3 then
          batch = battleComp.against_component:LoadBatch(battleComp.ZBattleLevel.Batch3)
     end

     if batch == nil then 
          Logger.LogError("error: CoGenBatchMonsters in batch: "..battleComp.BatchNum)
          return
     end

     local recordIds = {}
     for _, monster in pairs(batch.Monsters) do
          table.insert(recordIds,monster.Id)
          local zSsUnit = Z_SsUnit:GetConfig(monster.CardConfig.SsUnitId)
          if #zSsUnit.CenterOffset == 3 then
               Game.Scene:GetComponent("BattleCameraComponent"):SetCenterCameraOffset(zSsUnit.CenterOffset)
          else
               Game.Scene:GetComponent("BattleCameraComponent"):SetCenterCameraOffset()
          end
     end

     for posId, monster in pairs(batch.Monsters) do
          local unitData = {}
          unitData.isMonster = true
          unitData.monster = monster
          unitData.batchNum = battleComp.BatchNum
          BattleUtil.GenSsUnit(battleComp, unitData, false)          
     end
end


local function GetSpeedVal(ssUnit)
     return ssUnit:GetComponent("NumericComponent"):Get(NumericType.Speed)
end

-- 随便找个单位播放战斗开始音乐，和BGM
local function RandomPlayBattleSound(battleComp)
     coroutine.start(function ()
          local batchNum = state.battleComp.BatchNum
          if not string.IsNullOrEmpty(battleComp.ZBattleLevel.Bgm) then
               local bgm = battleComp.ZBattleLevel.Bgm
               local batchBgm = ""
               local batchBgms = string.split(bgm, ",")
               if state.battleComp.BatchNum == 1 then
                    batchBgm = batchBgms[1]
               elseif batchBgms[batchNum] ~= nil and batchBgms[batchNum] ~= batchBgms[batchNum - 1] then
                    batchBgm = batchBgms[batchNum]
               end
               if not string.IsNullOrEmpty(batchBgm) then
                    if battleComp.ZBattleLevel.bgmType == nil then
                         Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.Battle, batchBgm) --播放bgm
                    else
                         Game.Scene:GetComponent("BgmComponent"):CoPlay(battleComp.ZBattleLevel.bgmType, batchBgm) --播放bgm
                    end
               end
          end
          if batchNum == 1 then
               local uu = table.randget(table.values(table.choose(battleComp.IdUnits,function (k,v)
                    local matrix = v:GetComponent("SsUnitMatrixComponent")
                    return matrix ~= nil and matrix.Group == MatrixGroup.Friend
               end)))
               uu:GetComponent("SsUnitVoiceComponent"):CoPlayBattleStart()
          end
     end)
end

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     state.cameraComp = Game.Scene:GetComponent("BattleCameraComponent")
     
     -- 打开批次界面，不允许加速 --
     state.battleComp:SetBattleSpeed(state.battleComp.BattleSpeed)
     Time.timeScale = 1
     
     -- 深渊模式 --
     local isLoaded = false
     state.battleComp.battle_ui_component:TransiRound(true, state.battleComp.BatchNum, function ()
          -- 加载怪物 --
          CoGenBatchMonsters(state.battleComp)
          isLoaded = true
     end)
     state.battleComp.battle_ui_component:SetBattleText(state.battleComp.BatchNum.."/".. state.battleComp.TotalBatch)

     -- 切换场景位置 --
     local Config = Game.Scene:GetComponent("AgainstComponent"):GetZSection()
     local ZScene = Z_Scene[Config.SceneId]
     state.battleComp.scene_root.transform:DOLocalMoveX(-ZScene.BattlePos[state.battleComp.BatchNum], 0)
     
     -- 加载完 --
     coroutine.start(function()
          coroutine.waituntil(function () return isLoaded end)
          coroutine.waitforseconds(2)
          -- 每个批次战斗，敌人会更新，不是友方单位执行以下
          table.walksort(state.battleComp.IdUnits,function (a,b)
               return GetSpeedVal(state.battleComp.IdUnits[a]) < GetSpeedVal(state.battleComp.IdUnits[b])
          end,function(k,v)
               v:GetComponent("SsUnitUIComponent"):BuildSrAvatar()
          end)
          
          -- 关闭批次界面 --
          state.battleComp.battle_ui_component:TransiRound(false)
          
          -- 战斗前展示 --
          local camPrepared = false
          local bossEfxPrepared = false
          if state.battleComp.BatchNum == 1 then
               state.cameraComp:Show(function () camPrepared = true end)
          else
               state.cameraComp:SwitchCameraByPos(CameraType.Center)
               camPrepared = true
          end
          
          -- 如果有boss，优先播放boss特效 --
          state.battleComp.battle_ui_component:PlayBossEfx(function () bossEfxPrepared = true end)

          -- 如果是第一回合，播放音效
          RandomPlayBattleSound(state.battleComp)
          
          -- 关闭批次界面
          state.battleComp.battle_ui_component:PlayBossEfx()
          
          local updateHp = function()
               table.walk(table.filter(state.battleComp.IdUnits,function (k,v) return v.IsPlayer end),function (k,v)
                    v:InitHp()
                    v:GetComponent("SsUnitUIComponent"):UpdateHpBar()
               end)
               if state.battleComp.BatchNum == 1 then
                    table.walk(table.choose(state.battleComp.IdUnits,function (k,v) return v.IsPlayer end),function (k,v)
                         v:InitHp()
                         v:GetComponent("SsUnitUIComponent"):UpdateHpBar()
                    end)
               end
               table.walk(table.filter(state.battleComp.IdUnits,function (k,v) return v.IsPlayer end),function (k,v)
                    if v.IsBoss == 1 then
                         v:GetComponent("SsUnitUIComponent"):BossHpBar()
                    end
               end)
          end

          updateHp()
          
          -- 摄像机和boss特效都结束才开始战斗 --
          coroutine.waituntil(function () return camPrepared and bossEfxPrepared end)

          --第一次进入剧情11帝王风暴教程
          local guideList = state.battleComp.GuideComponent.GuideList
          local guideStep = table.first(guideList,function (v) return v.Id==12001  end)
          if state.battleComp.ZBattleLevel.Id == 1011 and  (guideStep == nil or guideStep.Step < 8) and state.battleComp.against_component.LevelType == LevelType.LevelTypeStory then
               state.battleComp:SetAutoBattle(0)
               state.battleComp.GuideComponent:CheckStart(11,0)
          end

          state.battleComp:SetBattleSpeed(state.battleComp.BattleSpeed)

          if state.battleComp.BatchNum == 1 then
               state.battleComp:OnBattleStart()
          end
          state.battleComp:OnBatchStart()

          updateHp()
          
          coroutine.waitforseconds(0.5)
          state.battleComp.RoundNum = 0
          state.battleComp.fsm:Switch(BattleState.RoundStart)
          --新手引导
          local GuideComplete,GuideStep,run = state.battleComp.GuideComponent:GetCurrentData()
          if GuideStep==3 and GuideComplete==0  and run then
               if UIManager:GetInstance():GetWindow(UIWindowNames.UINoviceGuide)== nil  then
                    UIManager:GetInstance():OpenWindow(UIWindowNames.UINoviceGuide)
               end
               local uiGuide = UIManager:GetInstance():GetWindow(UIWindowNames.UINoviceGuide)
               coroutine.waituntil(function() 
                    uiGuide = UIManager:GetInstance():GetWindow(UIWindowNames.UINoviceGuide)
                    return uiGuide.View.transform ~= nil   
               end)
               uiGuide.View.mask_bc.transform.parent.gameObject:SetActive(true)
               state.battleComp.GuideComponent:AutoGuide()
          elseif run and GuideComplete==0  and GuideStep<24 then
               if  UIManager:GetInstance():GetWindow(UIWindowNames.UINoviceGuide) == nil  then
                    UIManager:GetInstance():OpenWindow(UIWindowNames.UINoviceGuide)
               end
               local uiGuide = UIManager:GetInstance():GetWindow(UIWindowNames.UINoviceGuide)
               coroutine.waituntil(function()
                    uiGuide = UIManager:GetInstance():GetWindow(UIWindowNames.UINoviceGuide)
                    return uiGuide.View.transform ~= nil   
               end)
               uiGuide.View.mask_bc.transform.parent.gameObject:SetActive(true)
          end
     end)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state