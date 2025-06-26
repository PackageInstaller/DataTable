local state = BaseState:New(UnitBattleState.AtkStart)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     if state.battleComp.CurActUnit == nil then return end
     local actUnit = state.battleComp.CurActUnit:GetComponent("SsUnitBattleComponent")

     if state.battleComp.CurActType == ActType.Cac then
          actUnit:GenHUDText(LangUtil.GetSysLang(24), HUDTextType.Brown, HUDTextType.Tip)
     elseif state.battleComp.CurActType == ActType.Continue then
          actUnit:GenHUDText(LangUtil.GetSysLang(27), HUDTextType.Brown, HUDTextType.Tip)
     elseif state.battleComp.CurActType == ActType.GAtk then
          --Logger.Log(state.battleComp.CurActType)
     elseif state.battleComp.CurActType == ActType.Temp then
          --Logger.Log(state.battleComp.CurActType)
     else
          --Logger.Log(state.battleComp.CurActType)
     end
     
     -- 实现普攻多样性时，改变了下面的值
     SsUnitMotionType = {
          None="None",
          Idle="Idle",
          FnJmp="FnJmp",
          FnJmpDown="FnJmpDown",
          BkJmp="BkJmp",
          BkJmpDown="BkJmpDown",
          Atk="Atk",
          Skl01="Skl01",
          Skl02="Skl02",
          Skl03="Skl03",
          Hit="Hit",
          ExType="ExType",
          Die = "Die",
     }
     coroutine.start(function ()
          state.battleComp:OnAtkStart()
          
          -- 获取技能配置
          local zSkill = state.battleComp.CurActSkill.ZSkill
          
          -- 如果有前置动画 -- 玉藻前特例
          if zSkill ~= nil and #zSkill.CutInEfx > 0 then
               -- 播放cutin音效
               if not string.IsNullOrEmpty(zSkill.CutInSound) then
                    local splits = string.split(zSkill.CutInSound,":")
                    local delay = splits[2] or 0
                    coroutine.start(function ()
                         coroutine.waitforseconds(delay)
                         actUnit.unit_voice_component:CoPlayCutInEffect(splits[1])
                    end)
               end
               -- 播放cutin特效 只显示自己
               local tb = table.choose(state.battleComp.CurActSkill.TargetUnits,function (k,v)
                    return v ~= actUnit.__entity and v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
               end)
               table.walk(tb, function (k, val)
                    table.csenu(val.GameObject:GetComponentsInChildren(typeof(Transform)),function (v) -- 设置模型层级
                         v.gameObject.layer = state.battleComp.HideLayer
                    end)
               end)
               Game.Scene:GetComponent("PlayerBattleComponent"):Hide()

               local cs = string.split(zSkill.CutInEfx,",")
               UIManager:GetInstance():OpenWindow(UIWindowNames.UISkillSkip)
               actUnit.battle_camera_component:CutinCameraON()
               for i = 1, #cs, 1 do
                    local config = string.split(cs[i],":")
                    local n = config[1]
                    local s = tonumber(config[2])
                    if s == nil then
                         s = 2
                    end
                    actUnit.unit_effect_component:CoPlayBeforeCutIn(n, s)
                    coroutine.waitforseconds(s)
               end
               table.walk(tb, function (k, val)
                    table.csenu(val.GameObject:GetComponentsInChildren(typeof(Transform)),function (v) -- 设置模型层级
                         v.gameObject.layer = state.battleComp.SsUnitLayer
                    end)
               end)

               if zSkill.IsAwaken == 1 then
                    actUnit:SsUnit2AwakenLayer()
                    actUnit:SwitchCameraByPos(CameraType.Awake, true, {actUnit.__entity})
               end
               actUnit.battle_camera_component:CutinCameraOFF()
          end
          
          -- 获取技能编辑器数据， 从这里开始技能编辑器开始执行，普通技能不允许使用技能编辑器了
          actUnit:CameraCon(zSkill)
          -- 避免OnDamage多次触发
          actUnit.atkEnemy = false
          actUnit.atkFriend = false
          actUnit.atkEnd = false

          -- 初始化摄像机位置：1.觉醒的话直接开启觉醒相机， 2.近战技能开启跟随相机， 3.远程开启左边或右边相机， 4.如果是近战并且无前跳，不管， 5.普通技能当作觉醒播放
          if zSkill.IsAwaken == 1 then
               actUnit:SsUnit2AwakenLayer()
               local skipWnd = UIManager:GetInstance():GetWindow(UIWindowNames.UISkillSkip)
               if skipWnd == nil or not skipWnd.Active then
                    UIManager:GetInstance():OpenWindow(UIWindowNames.UISkillSkip)
               end
               if not actUnit.IsCamCon then
                    actUnit:SwitchCameraByPos(CameraType.Awake, true, {actUnit.__entity})
               end
               actUnit.battle_ui_component:HideBattleUIOnAwaken(actUnit)
          elseif zSkill.Distance == AtkDistance.Range then
               if not actUnit.IsCamCon then
                    -- actUnit:SwitchCameraByPos(actUnit.__entity.IsPlayer and CameraType.Right or CameraType.Left, true, {actUnit.__entity})
               end
               if zSkill.HideEm == 1 then
                    -- actUnit.battle_component:RangeView(actUnit.__entity.IsPlayer)
               end
          end
          if zSkill.PlayAsAwaken == 1 then
               actUnit:SsUnit2AwakenLayer()
               actUnit:SwitchCameraByPos(CameraType.Awake, true, {actUnit.__entity})
          end
          
          -- 需要完成的有效攻击
          state.battleComp.CurActSkill.ExpectCompleteNum = state.battleComp.CurActSkill.ExpectCompleteNum + #state.battleComp.CurActSkill.TargetUnits * state.battleComp.CurActSkill.MultistageNum

          state.battleComp:NumericHurt()
          
          -- 播放技能动画并开启人物音效，触发事件帧
          if actUnit:CurActIsSkill(ActiveSkillType.GeneralAtk) then
               actUnit.unit_voice_component:CoPlayAtk()
               actUnit.unit_voice_component:CoPlayAtkEffect()
               state.battleComp.CurActUnit:GetComponent("AnimatorEventHandleComponent"):StartRecordSkillEfx()
               actUnit.unit_animator_component:Play(SsUnitMotionType.Atk)
               actUnit.battle_ui_component:ShowSkillEfx(state.battleComp.CurActSkill.Name)
          elseif actUnit:CurActIsSkill(ActiveSkillType.Skill1) then
               actUnit.unit_voice_component:CoPlaySkl1()
               actUnit.unit_voice_component:CoPlaySkl1Effect()
               state.battleComp.CurActUnit:GetComponent("AnimatorEventHandleComponent"):StartRecordSkillEfx()
               actUnit.unit_animator_component:Play(SsUnitMotionType.Skl01)
               actUnit.battle_ui_component:ShowSkillEfx(state.battleComp.CurActSkill.Name)
          elseif actUnit:CurActIsSkill(ActiveSkillType.Skill2) then
               actUnit.unit_voice_component:CoPlaySkl2()
               actUnit.unit_voice_component:CoPlaySkl2Effect()
               state.battleComp.CurActUnit:GetComponent("AnimatorEventHandleComponent"):StartRecordSkillEfx()
               actUnit.unit_animator_component:Play(SsUnitMotionType.Skl02)
               actUnit.battle_ui_component:ShowSkillEfx(state.battleComp.CurActSkill.Name)
          elseif actUnit:CurActIsSkill(ActiveSkillType.Awaken) then
               actUnit.unit_voice_component:CoPlaySkl2()
               actUnit.unit_voice_component:CoPlaySkl2Effect()
               state.battleComp.CurActUnit:GetComponent("AnimatorEventHandleComponent"):StartRecordSkillEfx()
               actUnit.unit_animator_component:Play(SsUnitMotionType.Skl02)
               Game.Scene:GetComponent("PlayerBattleComponent"):Hide()
          end

          -- CutIn特效
          if zSkill ~= nil and zSkill.CutIn ~= nil and #zSkill.CutIn > 0 then
               actUnit.battle_camera_component:CutinCameraON(actUnit.__entity:GetPosition())
               local config = string.split(zSkill.CutIn,":")
               local n = config[1]
               local s = tonumber(config[2])
               if s == nil then s = 0 end
               coroutine.start(function ()
                    coroutine.waitforseconds(s)
                    actUnit.unit_effect_component:CoPlayCutIn(n, 5)
                    coroutine.waitforseconds(5)
                    actUnit.battle_camera_component:CutinCameraOFF()
               end)
          end
          
          -- 不是普攻并且不是敌人则使用技能次数 + 1
          if not actUnit:CurActIsSkill(ActiveSkillType.GeneralAtk) and actUnit.__entity.IsPlayer then
               actUnit.battle_component.UseSkillCount = actUnit.battle_component.UseSkillCount + 1
          end
     end)
end
function  state:OnUpdate()

end
function   state:OnLeave()

end
return  state