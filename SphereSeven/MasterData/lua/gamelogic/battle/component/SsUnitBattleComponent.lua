local SsUnitBattleComponent = BaseClass("SsUnitBattleComponent", Component)
local base = Component

if UnitBattleState == nil then
    UnitBattleState = 
    {
        ActStart = 101,--行动
        ForwardMoveStart = 102, --前跳开始
        AtkStart = 103,--攻击 
        AtkEndCheck = 104, --攻击结束检测
        AtkEnd = 105, --攻击结束
        BackwardMoveStart = 106, --后跳开始
        ActEnd = 107, --行动结束
    }
end

if EnemyPosType == nil then
    EnemyPosType = 
    {
        EffectiveCenter = 1,
        GroupCenter = 2,
        ForwardPos = 3,
    }
end

local function Awake(self)
    base.Awake(self)
    
    require("GameLogic.Battle.Component.SsUnitBattleComponentLogic")
    require("GameLogic.Battle.Component.SsUnitBattleComponentNumeric")
    
    self.BatchTurnNum = 0  --一波的回合数
    self.TotalTurnNum = 0  --总回合数
    
    self.battle_component = Game.Scene:GetComponent("BattleComponent")
    self.battle_ui_component = Game.Scene:GetComponent("BattleUIComponent")
    self.battle_camera_component = Game.Scene:GetComponent("BattleCameraComponent")
    self.matrix_component = Game.Scene:GetComponent("MatrixComponent")

    self.unit_ui_component = self.__entity:GetComponent("SsUnitUIComponent")
    self.character_component = self.__entity:GetComponent("CharacterComponent")
    self.unit_matrix_component = self.__entity:GetComponent("SsUnitMatrixComponent")
    self.unit_move_component = self.__entity:GetComponent("SsUnitMoveComponent")
    self.unit_animator_component = self.__entity:GetComponent("SsUnitAnimatorComponent")
    self.unit_sound_component = self.__entity:GetComponent("SsUnitSoundComponent")
    self.unit_voice_component = self.__entity:GetComponent("SsUnitVoiceComponent")
    self.unit_effect_component = self.__entity:GetComponent("SsUnitEffectComponent")
    self.numeric_component = self.__entity:GetComponent("NumericComponent")
    self.buff_component = self.__entity:GetComponent("BuffComponent")
    self.skill_component = self.__entity:GetComponent("SkillComponent")
    
    self.cur_act_forward_dest_pos = nil --前跳目标位置
    self.cur_act_move_speed = 0 --移动速度
    self.cur_act_move_time = 0 --移动时间
    
    self.is_hurt = 0 --受伤
    self.is_pry = 0
    self.IsCac = false --是否反击
    self.CacUnit = nil -- 反击单位

    self.IgnoreExtraSkillActTypeLimit = false   -- 忽略额外技能释放限制
    self.IsProcesingExtraSkill = false          -- 额外技能
    self.ExtraSkill = nil                       -- 额外技能
    self.ExtraSkillTarget = nil                 -- 额外技能目标

    self.IsCamCon=false
    self.IsCamEnd=false
    self.old_pos=self.__entity:GetPosition()
    local cc = self.__entity.GameObject:GetComponent(typeof(CS.UnityEngine.CapsuleCollider))
    self.radius = math.ceil(cc.radius)
    
    self.hudList = {}

    self.moveSpeed = 24
    self.flySpeed = 10
    self.downTime = 0.1
    self.jumpHigh = 0.3

    self.fsm = FsmMachine:New()
    self.fsm:AddState(require "GameLogic.Battle.UnitState.ActStart")
    self.fsm:AddState(require "GameLogic.Battle.UnitState.ForwardMoveStart")
    self.fsm:AddState(require "GameLogic.Battle.UnitState.AtkStart")
    self.fsm:AddState(require "GameLogic.Battle.UnitState.AtkEndCheck")
    self.fsm:AddState(require "GameLogic.Battle.UnitState.AtkEnd")
    self.fsm:AddState(require "GameLogic.Battle.UnitState.ActEnd")
end

-- 设置觉醒层
local function SsUnit2AwakenLayer(self)
    table.csenu(self.__entity.GameObject:GetComponentsInChildren(typeof(Transform)),function (v)
            v.gameObject.layer = self.battle_component.AwakenLayer
    end)
end

-- 设置单位层
local function Awaken2SsUnitLayer(self,isAwaken)
    if isAwaken == 1 then
        table.csenu(self.__entity.GameObject:GetComponentsInChildren(typeof(Transform)),function (v)
                v.gameObject.layer = self.battle_component.SsUnitLayer
        end)
    end
end

-- 获取多个单位的中心点
local function GetCenterPos(self, type, targetUnits, startOrAtkSpell, isPos)
    assert(targetUnits ~= nil and table.count(targetUnits) > 0)
    local pos = Vector3.New(0, 0, 0)
    for _, v in pairs(targetUnits) do
        pos = pos + v:GetPosition()
        local offset = isPos and v.ZSsUnit.HitPosOffset or v.ZSsUnit.OnHurtCameraOffset -- 修格斯
        if not startOrAtkSpell and #offset > 0 then
            local leftOrRight = type == CameraType.Right and 1 or -1
            pos = pos + Vector3.New(offset[1] * leftOrRight, offset[2] ,offset[3])
        end
    end
    return pos / table.count(targetUnits)
end

-- 摄像机看向某个点，不跟随
local function SwitchCameraByPos(self, type, startOrAtkSpell, units, duration)
    assert(units ~= nil and table.count(units) > 0)
    local delay
    local zSkill = self:CurActZSkill()
    local pos = GetCenterPos(self, type, units, startOrAtkSpell)

    if zSkill ~= nil and startOrAtkSpell ~= nil then
        delay = startOrAtkSpell == true and zSkill.SpellCameraDelay or zSkill.HurtCameraDelay -- SpellCameraDelay只有赵构   HurtCameraDelay乾隆 俾斯麦 黑龙 扎尔
        local offset = startOrAtkSpell == true and zSkill.SpellCameraOffset or zSkill.HurtCameraOffset -- 李自成 彼得 火龙 黑龙 修格斯 刘彻
        if #offset == 3 then
            local leftOrRight = type == CameraType.Right and 1 or -1
            pos = pos + Vector3.New(offset[1] * leftOrRight, offset[2], offset[3]) 
        end
    end
    self.battle_camera_component:SwitchCameraByPos(type, pos, delay, duration)
end

-- 是否是同一阵营
local function IsSameGroup(self, unit)
    return unit:GetComponent("SsUnitMatrixComponent").Group == self.unit_matrix_component.Group
end

-- 初始化技能效果
local function CameraCon(self,zskill)
    local yy = loadtable(zskill.CameraCon)
    self.IsCamCon = false
    self.IsCamEnd = false
    self.IsNotMove = false
    self.yyid = 1
    self.yytime = 0
    self.yy = nil
    self.atktime = 0
    if yy == nil then return end
    if yy[1] == nil then return end
    self.yy = yy
    self.IsCamCon = true
end

local function DoConfig(self, config)
    if self.battle_component.CurActSkill.ZSkill.IsAwaken ~= 1 then
        return
    end
    if config.target == 1001 then -- 自己
        SwitchCameraByPos(self, self.__entity.IsPlayer and CameraType.Right or CameraType.Left, true, {self.__entity})
    elseif config.target == 1002 then -- 己方
        local tb = table.choose(self.battle_component.CurActSkill.TargetUnits,function (k,v)
            return IsSameGroup(self, v) and v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
        end)
        SwitchCameraByPos(self, self.__entity.IsPlayer and CameraType.Right or CameraType.Left, true, tb)
    elseif config.target == 1003 then -- 自己_近战跟随
        self.battle_camera_component:SwitchCameraByTnf(self.__entity.IsPlayer and CameraType.Right or CameraType.Left, self.__entity.GameObject.transform)
    elseif config.target == 1004 then -- 敌方
        local tb = table.choose(self.battle_component.CurActSkill.TargetUnits,function (k,v)
            return not IsSameGroup(self, v) and v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
        end)

        if tb == nil or table.count(tb) <= 0 then
            Logger.LogError(string.format("unexpect targets for unit: %s, skill: %d", self.__entity.Name, self.battle_component.CurActSkill.SkillId))
        end

        SwitchCameraByPos(self, self.__entity.IsPlayer and CameraType.Left or CameraType.Right, true, tb, config.seconds)
    elseif config.target == 1005 then -- 切换自己并隐藏敌方
        local tb = table.choose(self.battle_component.CurActSkill.TargetUnits,function (k,v)
            return IsSameGroup(self, v) and v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
        end)
        SwitchCameraByPos(self, self.__entity.IsPlayer and CameraType.Right or CameraType.Left, true, tb)
        Awaken2SsUnitLayer(self, 1)
        self.battle_component:RangeView(self.__entity.IsPlayer)
    elseif config.target == 1006 then -- 切换敌方并隐藏我方
        local tb = table.choose(self.battle_component.CurActSkill.TargetUnits,function (k,v)
            return not IsSameGroup(self, v) and v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
        end)
        SwitchCameraByPos(self, self.__entity.IsPlayer and CameraType.Left or CameraType.Right, true, tb)
        Awaken2SsUnitLayer(self, 1)
        self.battle_component:RangeView(not self.__entity.IsPlayer)
    elseif config.target == 1007 then -- 切换中远相机并所有显隐
        self.battle_camera_component:SwitchCameraByPos(CameraType.Center)
        self.battle_component:DeRangeView()
    else if config.target == 0 then -- 切换中间远相机
        self.battle_camera_component:SwitchCameraByPos(CameraType.Center)
    elseif config.target==5 then -- 启用觉醒相机
        SsUnit2AwakenLayer(self)
        self.battle_camera_component:LeftAwakeSet()
        self.battle_camera_component:RightAwakeSet()
        SwitchCameraByPos(self, CameraType.Awake, true, {self.__entity})
    elseif config.target==9 then -- 相机抖动
        self.battle_camera_component:ShakeCurCamera(config.duration,config.strength)
    elseif config.target==91 then -- 相机相对施法者移动
        if not self.__entity.IsPlayer then
            config.offset.x= config.offset.x*-1
        end
        local a = self.__entity:GetPosition() + config.offset
        self.battle_camera_component:SetCurCameraPos(a, config.seconds)
    elseif config.target==92 then -- 相机相对自身移动
        if not self.__entity.IsPlayer then
            config.offset.x= config.offset.x*-1
        end
        local cam = self.battle_camera_component:GetCamera(CameraType.CurCamera)
        local a = cam.transform.position + config.offset
        self.battle_camera_component:SetCurCameraPos(a, config.seconds)
    elseif config.target==96 then -- 相机相对自身移动
        if not self.__entity.IsPlayer then
            config.offset.x= config.offset.x*-1
        end
        local cam = self.battle_camera_component:GetCamera(CameraType.CurCamera)
        local x = cam.transform.localPosition.x + config.offset.x
        local y = cam.transform.localPosition.y + config.offset.y
        local z = cam.transform.localPosition.z + config.offset.z
        local a = Vector3.New(x, y, z)
        self.battle_camera_component:SetCurCameraLocalPos(a, config.seconds)
    elseif config.target==93 then -- 相机视角
        self.battle_camera_component:SetCurCameraField(config.offset.x, config.seconds)
    elseif config.target==95 then -- 相机旋转角度
        if not self.__entity.IsPlayer then
            config.offset.y= config.offset.y*-1
            config.offset.z= config.offset.z*-1
        end
        self.battle_camera_component:SetCurCameraRot(config.offset,config.seconds)
    elseif config.target==10 then -- 相机从觉醒恢复
        self.battle_camera_component:DeLeftAwakeSet()
        self.battle_camera_component:DeRightAwakeSet()
        Awaken2SsUnitLayer(self,1)
    elseif config.target==6 then  -- 结束技能回合
        self.battle_component:TargetsShow()
        self.battle_camera_component:DeLeftAwakeSet()
        self.battle_camera_component:DeRightAwakeSet()
        Awaken2SsUnitLayer(self,1)
        coroutine.start(function () 
            coroutine.waituntil(function () return self.IsCamEnd end)
            self.IsCamCon = false
            if self.fsm.curState.stateName == UnitBattleState.AtkEnd or self.fsm.curState.stateName == UnitBattleState.ActEnd then
                Logger.Log("self.fsm.curState == "..self.fsm.curState.stateName.." cannot switch fsm")
                return
            end
            self.battle_component.CurActSkill.ExpectCompleteNum = 0
            self.fsm:Switch(UnitBattleState.AtkEndCheck,true)
        end)
    elseif config.target==66 then --强制结束技能回合
        self.battle_component:TargetsShow()
        self.battle_camera_component:DeLeftAwakeSet()
        self.battle_camera_component:DeRightAwakeSet()
        Awaken2SsUnitLayer(self,1)
        self.IsCamCon=false
        if self.fsm.curState.stateName == UnitBattleState.AtkEnd or self.fsm.curState.stateName == UnitBattleState.ActEnd then
            Logger.Log("self.fsm.curState == "..self.fsm.curState.stateName.." cannot switch fsm")
            return
        end
        self.battle_component.CurActSkill.ExpectCompleteNum = 0
        self.fsm:Switch(UnitBattleState.AtkEndCheck,true)
    elseif config.target==11 then--隐藏敌方
        self.battle_component:RangeView(self.__entity.IsPlayer)
    elseif config.target==12 then--隐藏我方
        self.battle_component:RangeView(not self.__entity.IsPlayer)
    elseif config.target==13 then--所有显隐
        self.battle_component:DeRangeView()
    elseif config.target==14 then--所有隐藏
        self.battle_component:TargetsHide({})
    elseif config.target==111 then --隐藏非技能相关对象
        local ts = {}
        table.walk(self.battle_component.CurActSkill.TargetUnits, function (k, v)
            table.insert(ts, v)
        end)
        table.insert(ts,self.__entity)
        self.battle_component:TargetsHide(ts)
    elseif config.target==131 then --显示非技能相关对象
        self.battle_component:TargetsShow()
    elseif config.target==113 then --隐藏自己
        self.battle_component:TargetHide(self.__entity)
    elseif config.target==133 then --显示自己
        self.battle_component:TargetShow(self.__entity)
    elseif config.target==112 then --隐藏指定目标单位
        self.battle_component:TargetHide(self.battle_component.CurTargetUnit)
    elseif config.target==132 then --显示指定目标单位
        self.battle_component:TargetShow(self.battle_component.CurTargetUnit)
    elseif config.target==15 then--给自己位置释放特效 cutin特效用觉醒层
        coroutine.start(function ()
            self.unit_effect_component:CoPlaySpell2(config.efx_name,self.__entity:GetPosition())
        end)
    elseif config.target==151 then --给自己位置放挂点1特效
        coroutine.start(function ()
            self.unit_effect_component:CoPlayHandle(config.efx_name,self.__entity.HandleTrans,config.seconds)
        end)
    elseif config.target==152 then --给自己位置放挂点2特效
        coroutine.start(function ()
            self.unit_effect_component:CoPlayHandle(config.efx_name,self.__entity.Handle2Trans,config.seconds)
        end)
    elseif config.target==153 then --给自己位置放挂点3特效
        coroutine.start(function ()
            self.unit_effect_component:CoPlayHandle(config.efx_name,self.__entity.Handle3Trans,config.seconds)
        end)
    elseif config.target==154 then --给自己位置放挂点4特效
        coroutine.start(function ()
            self.unit_effect_component:CoPlayHandle(config.efx_name,self.__entity.Handle4Trans,config.seconds)
        end)
    elseif config.target==155 then --给自己位置放挂点5特效
        coroutine.start(function ()
            self.unit_effect_component:CoPlayHandle(config.efx_name,self.__entity.Handle5Trans,config.seconds)
        end)
    elseif config.target==156 then --给自己位置放挂点6特效
        coroutine.start(function ()
            self.unit_effect_component:CoPlayHandle(config.efx_name,self.__entity.Handle6Trans,config.seconds)
        end)
    elseif config.target==157 then --给自己位置放挂点7特效
        coroutine.start(function ()
            self.unit_effect_component:CoPlayHandle(config.efx_name,self.__entity.Handle7Trans,config.seconds)
        end)
    elseif config.target==158 then --给自己位置放Cutin特效
        coroutine.start(function ()
            self.battle_camera_component:CutinCameraON(999)
            self.unit_effect_component:CoPlayCutIn(config.efx_name)
            coroutine.waitforseconds(5)
            self.battle_camera_component:CutinCameraOFF()
        end)
    elseif config.target==16 then--释放特效位置选择  type==0 当前单位
        coroutine.start(function ()
            if self.battle_component.CurTargetUnit~=nil then
                self.unit_effect_component:CoPlaySpell2(config.efx_name,self.battle_component.CurTargetUnit:GetPosition(),config.delayDestroySeconds)
            end
        end)
    elseif config.target==18 then--给所有己方释放特效
        coroutine.start(function ()
            local group = self.__entity:GetComponent("SsUnitMatrixComponent").Group --获取行动单位阵营
            local uunits = self.battle_component:GetGroupUnits(group)
            for k,v in pairs(uunits) do
                if not v:GetComponent("CharacterComponent").IsDead then
                    self.unit_effect_component:CoPlaySpell2(config.efx_name,v:GetPosition())
                end
            end
        end)
    elseif config.target==161 then--释放特效位置选择
        coroutine.start(function ()
            local tb = table.choose(self.battle_component.CurActSkill.TargetUnits,function (k,v)
                return not IsSameGroup(self, v) and v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
            end)
            local camType = self.__entity.IsPlayer and CameraType.Left or CameraType.Right
            local pos = GetCenterPos(self, camType, tb, false, true)
            pos.y = 0
            self.unit_effect_component:CoPlaySpell2(config.efx_name, pos)
        end)
    elseif config.target==162 then--给要移动到的点释放特效
        coroutine.start(function ()
            self.unit_effect_component:CoPlaySpell2(config.efx_name,self.cur_act_forward_dest_pos)
        end)
    elseif config.target==164 then--特效移动到近战点
        self.unit_effect_component:ChangeExfPos(config.efx_name,self.cur_act_forward_dest_pos,config.offset)
    elseif config.target==166 then--特效移动到敌方中心
        local tb = table.choose(self.battle_component.CurActSkill.TargetUnits,function (k,v)
            return not IsSameGroup(self, v) and v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
        end)
        local camType = self.__entity.IsPlayer and CameraType.Left or CameraType.Right
        local pos = GetCenterPos(self, camType, tb, false, true)
        pos.y = 0
        self.unit_effect_component:ChangeExfPos(config.efx_name,pos)
    elseif config.target==165 then--特效移动到技能单位
        self.unit_effect_component:ChangeExfPos(config.efx_name,self.__entity:GetPosition(),config.offset)
    elseif config.target==167 then--特效隐藏
        self.unit_effect_component:ChangeExfShow(config.efx_name,false)
    elseif config.target==168 then--特效显示
        self.unit_effect_component:ChangeExfShow(config.efx_name,true)
    elseif config.target==19 then--给所有敌人释放特效
        coroutine.start(function ()
            local group = self.__entity:GetComponent("SsUnitMatrixComponent").Group --获取行动单位阵营
            local enemyUnits = self.battle_component:GetEnemyGroupUnits(group)
            for k,v in pairs(enemyUnits) do
                if not v:GetComponent("CharacterComponent").IsDead then
                    self.unit_effect_component:CoPlaySpell2(config.efx_name,v:GetPosition())
                end
            end
        end)
    elseif config.target==17 then--如果双倍伤害是释放特效
        coroutine.start(function ()
            if self.battle_component.CurActSkill ~= nil then
                local skill = self.battle_component.CurActSkill
                if skill ~= nil and skill.IsDoubleHurt then
                    self.unit_effect_component:CoPlaySpell2(config.efx_name2,self.battle_component.CurTargetUnit:GetPosition())
                else
                    self.unit_effect_component:CoPlaySpell2(config.efx_name,self.battle_component.CurTargetUnit:GetPosition())
                end
            end
        end)
    elseif config.target==171 then--特殊效果黑洞吸入
        if self.battle_component.CurTargetUnit~=nil then
            local cc = self.battle_component.CurTargetUnit:GetComponent("SsUnitAnimatorComponent")
            cc:SetBlackHole()
        end
    elseif config.target==172 then--特殊效果设置受伤动作保持
        if self.battle_component.CurTargetUnit~=nil then
            local cc = self.battle_component.CurTargetUnit:GetComponent("SsUnitAnimatorComponent")
            cc.keepHit = true
            cc:Play(SsUnitMotionType.Hit) --播放受击动作
        end
    elseif config.target==173 then--特殊效果设置受伤动作保持
        if self.battle_component.CurTargetUnit~=nil then
            local cc = self.battle_component.CurTargetUnit:GetComponent("SsUnitAnimatorComponent")
            cc.keepHit = false
            cc:OnHit()
        end
    elseif config.target==311 then--播发音效
        coroutine.start(function ()
            self.unit_voice_component:CoPlayAtk()
        end)
    elseif config.target==312 then--播发音效
        coroutine.start(function ()
            self.unit_voice_component:CoPlaySkl1()
        end)
    elseif config.target==313 then--播发音效
        coroutine.start(function ()
            self.unit_voice_component:CoPlaySkl2()
        end)
    elseif config.target==314 then--播发音效
        coroutine.start(function ()
            self.unit_voice_component:CoPlaySkl3()
        end)
    elseif config.target==315 then--播发音效
        coroutine.start(function ()
            self.unit_voice_component:CoPlay(config.voice_name)
        end)
    elseif config.target==21 then--移动到目标点
        self.__entity:SetPosition(self.cur_act_forward_dest_pos)
    elseif config.target==25 then--远程单位移动到近战攻击点(勾践1技能)
        local ctu = self.battle_component.CurTargetUnit --目标单位
        local curActForwardDestPos = Vector3.zero --前跳目标位置
        local zSkill = self.battle_component.CurActSkill.ZSkill
        local xOffset = 0
        local zOffset = 0
        xOffset = xOffset + self.__entity.CloseAtkOffset.x
        zOffset = zOffset + self.__entity.CloseAtkOffset.z
        if ctu ~= nil then
            xOffset = xOffset + ctu.ZSsUnit.HitPosOffset[1]
            zOffset = zOffset + ctu.ZSsUnit.HitPosOffset[3]
        end
        if self.IsCac or zSkill.EnemyRange == EnemyRange.Single then
            curActForwardDestPos.x = ctu:GetPosition().x
            curActForwardDestPos.z = ctu:GetPosition().z
        end
        xOffset = self.__entity.IsPlayer and xOffset or -xOffset
        curActForwardDestPos.x = curActForwardDestPos.x + xOffset
        curActForwardDestPos.z = curActForwardDestPos.z + zOffset
        self.__entity.GameObject.transform:DOMove(curActForwardDestPos, config.seconds or 0)
    elseif config.target==23 then--移动到敌方中心
        local tb = table.choose(self.battle_component.CurActSkill.TargetUnits,function (k,v)
            return not IsSameGroup(self, v) and v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
        end)
        local camType = self.__entity.IsPlayer and CameraType.Left or CameraType.Right
        local pos = GetCenterPos(self, camType, tb)
        --因为有碰撞不能放一起左右位移5
        --if self.__entity.IsPlayer then
        --    --pos=self.matrix_component.LMM.transform.position
        --    pos.x=pos.x+0.5
        --else
        --    --pos=self.matrix_component.RMM.transform.position
        --    pos.x=pos.x-0.5
        --end
        self.__entity:SetPosition(pos)
    elseif config.target==24 then--移动到选中单位
        --因为有碰撞不能放一起左右位移5
        local pos=self.battle_component.CurTargetUnit:GetPosition()
        if self.__entity.IsPlayer then
            pos.x=pos.x+5
        else
            pos.x=pos.x-5
        end
        self.__entity:SetPosition(pos)
    elseif config.target==22 then--移动到自身位置偏移的点
        local pos=self.__entity:GetPosition()
        if self.__entity.IsPlayer then
            pos.x= pos.x+config.x
        else
            pos.x= pos.x-config.x
        end
        pos.y= pos.y+config.y
        pos.z= pos.z+config.z
        self.__entity:SetPosition(pos)
    elseif config.target==28 then--移动还原自身位置
        self.__entity.GameObject.transform:DOMove(self.old_pos, config.seconds or 0)
        --self.__entity:SetPosition(self.old_pos)
    elseif config.target==291 then--动作暂停
        self.unit_animator_component:PauseAnimator()
    elseif config.target==292 then--动作继续
        self.unit_animator_component:ResumeAnimator()
    elseif config.target==293 then--技能特写
        coroutine.start(function()
            if not self.battle_component.BattleSkip then
                Time.timeScale = config.strength * self.battle_component.BattleSpeed
                coroutine.waitforseconds(config.seconds)
                if not self.battle_component.BattleSkip then
                    Time.timeScale = self.battle_component.BattleSpeed
                end
            end
        end)
    elseif config.target==294 then--技能对象浮空
        if not self.__entity.IsPlayer then
            config.offset.x= config.offset.x*-1
        end
        table.walk(self.battle_component.CurActSkill.TargetUnits, function (k, v)
            local a = v.GameObject.transform.localPosition + config.offset
            v.GameObject.transform:DOLocalMove(a, config.seconds)
        end)
    elseif config.target==295 then--技能对象落地
        if not self.__entity.IsPlayer then
            config.offset.x= config.offset.x*-1
        end
        table.walk(self.battle_component.CurActSkill.TargetUnits, function (k, v)
            local a = v.GameObject.transform.localPosition + config.offset
            v.GameObject.transform:DOLocalMove(a, config.seconds)
        end)
    elseif config.target==298 then--技能单位相对自身移动
        if not self.__entity.IsPlayer then
            config.offset.x= config.offset.x*-1
        end
        local a = self.__entity.GameObject.transform.localPosition + config.offset
        self.__entity.GameObject.transform:DOLocalMove(a, config.seconds)
    elseif config.target==299 then--技能单位相对敌人位置
        local tb = table.choose(self.battle_component.CurActSkill.TargetUnits,function (k,v)
            return not IsSameGroup(self, v) and v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
        end)
        local camType = self.__entity.IsPlayer and CameraType.Left or CameraType.Right
        if not self.__entity.IsPlayer then
            config.offset.x= config.offset.x*-1
        end
        local pos = GetCenterPos(self, camType, tb) + config.offset
        self.__entity:SetPosition(pos)
    elseif config.target==296 then--技能对象觉醒层
        table.walk(self.battle_component.CurActSkill.TargetUnits, function (k, v)
            table.csenu(v.GameObject:GetComponentsInChildren(typeof(Transform)),function (val)
                val.gameObject.layer = self.battle_component.AwakenLayer
            end)
        end)
    elseif config.target==297 then--技能对象单位层
        table.walk(self.battle_component.CurActSkill.TargetUnits, function (k, v)
            table.csenu(v.GameObject:GetComponentsInChildren(typeof(Transform)),function (val)
                val.gameObject.layer = self.battle_component.SsUnitLayer
            end)
        end)
    elseif config.target==502 then--触发OnDamage
        self.OnDamage(self,2)
    elseif config.target==501 then--触发OnDamage
        self.OnDamage(self,1)
    elseif config.target==51 then--技能触发己方buff
        coroutine.start(function ()
            self.battle_component.CurActSkill:OnBuff()
        end)
    --elseif config.target == 350 then -- 隐藏血条
    --    if not self.__entity.IsPlayer and not self.__entity.IsMonster then
    --        self.unit_ui_component:SetHpBar(false)
    --    end
    --elseif config.target == 351 then -- 显示血条
    --    if not self.__entity.IsPlayer and not self.__entity.IsMonster then
    --        self.unit_ui_component:SetHpBar(true)
    --    end
    elseif config.target == 352 then -- 显示血条
        local hp = self.battle_component.CurActSkill.UnitResults[self.__entity.UID].ReduceHp
        hp = math.modf(hp)
        self:ReduceHp(hp)
        self:GenHUDText(hp, HUDTextType.Grey, HUDTextType.Dmg)
    end
    end
end

-- 时间检测
local function OnRun(self,time)
    self.fsm:Update()
    if self.battle_component.CurActUnit ~= nil and self.battle_component.CurActUnit.UID == self.__entity.UID then
        if self.atktime ~= nil then
            self.atktime = self.atktime + time
            -- AtkStart开始同步 --
            if self.yy == nil or self.IsCamCon == nil then return end
            if self.yyid > #self.yy then return end
            local y = self.yy[self.yyid]
            if self.atktime >= self.yytime + y.time then
                self.yytime = self.yytime + y.time
                self.yyid = self.yyid + 1
                local configs = {}
                table.insert(configs, y)
                while self.yyid <= #self.yy and self.yy[self.yyid].time == 0 do
                    table.insert(configs, self.yy[self.yyid])
                    self.yyid = self.yyid + 1
                end
                for _,v in pairs(configs) do
                    DoConfig(self, v)
                end
            end
        end
    end
    if self.unit_effect_component ~= nil then
        self.unit_effect_component:Update()
    end
end

-- 弹导移动
local function MissileMove(self,efxPath,efx,destUnit,missileSpeed)
    local missileMoveTime = Vector3.Distance(efx.transform.position,destUnit.HitPosPosition) / missileSpeed --移动时间
    --efx.transform:LookAt(destUnit.HitPosPosition)
    --efx.transform:Rotate(0, -90, 0) --调整特效方向为指向目标
    DOTween.Sequence()
        :Append(efx.transform:DOMove(destUnit.HitPosPosition,missileMoveTime):SetEase(Ease.Linear)) --特效移动
        :AppendCallback(function () --到达目标位置调用
            self.unit_effect_component:RecycleEfx(efxPath,efx) --回收特效
            coroutine.start(function ()
                coroutine.waitforseconds(self:CurActZSkill().DelayHurtDuration) --伤害延时
                self.battle_component:OnHurtEffect(self.__entity, destUnit)
            end)
        end)
    return missileMoveTime --返回移动时间
end

-- 导弹事件帧触发
local function OnMissile(self)
    if self.atkEnd then return end
    
    --当前技能
    local skill = self.battle_component.CurActSkill
    --当前技能配置
    local zSkill = self:CurActZSkill()
    
    -- 导弹攻击
    coroutine.start(function ()
        -- 对敌人随机导弹攻击
        local atkEnemy = function(units)
            local missileMoveTime = 0
            table.walk(skill.TargetUnits,function (k,v)
                local efxPath, efx = self.unit_effect_component:CoPlayMissile(zSkill.MissileEfx, zSkill.MissileInitIndex)
                local _missileMoveTime = MissileMove(self, efxPath, efx, v, zSkill.MoveSpeed)
                self.unit_sound_component:CoPlaySkl(zSkill.MissileSound)
                missileMoveTime = _missileMoveTime
            end)
            if not self.atkEnemy then
                self.atkEnemy = true
                -- 避免施法2和施法1同时出现
                if zSkill.HideSpell1 == 1 then
                    self.unit_effect_component:RecycleSpell1()
                end
                if zSkill.MissileNotDelay ~= 1 then
                    coroutine.waitforseconds(missileMoveTime / 2)
                end
                if not self.IsCamCon and zSkill.IsAwaken == 1 then
                    SwitchCameraByPos(self, self.__entity.IsPlayer and CameraType.Left or CameraType.Right, false, units)
                end
            end
        end
        
        -- 对友方自己 大禹
        local friendSelf = function(units)
            skill.ExpectCompleteNum = skill.ExpectCompleteNum + 1
            if zSkill.IsTargetEnemy == 0 then
                if not self.IsCamCon and zSkill.IsAwaken == 1 then
                    SwitchCameraByPos(self, self.__entity.IsPlayer and CameraType.Right or CameraType.Left, false, units)
                end
                self.unit_effect_component:CoPlaySpell2(zSkill.Spell2Efx, self.__entity:GetPosition())
            end
            self.battle_component:OnHurtEffect(self.__entity, self.__entity)
        end
        
        if zSkill.IsTargetEnemy == 1 then
            if zSkill.EnemyRange == EnemyRange.Single or 
                    zSkill.EnemyRange == EnemyRange.Random  or 
                    zSkill.EnemyRange == EnemyRange.Row or 
                    zSkill.EnemyRange == EnemyRange.Line then --单体或随机单位或整排
                local units = table.choose(skill.TargetUnits, function (_, v) return not IsSameGroup(self, v) end)
                atkEnemy(units)
            end
        end

        -- 很特殊的情况，俾斯麦  大禹
        if zSkill.IsTargetFriend == 1 then 
            if zSkill.FriendRange == FriendRange.Self then
                local units = table.choose(skill.TargetUnits, function (_, v) return IsSameGroup(self, v) end)
                friendSelf(units)
            end
        end

        if not self.IsCamCon then
            if zSkill.IsAwaken == 1 then
                self.battle_component:AwakeView(skill.TargetUnits,skill.SrcUnit)
            elseif zSkill.Distance == AtkDistance.Range and zSkill.HideEm == 1 then
                coroutine.start(function () 
                    coroutine.waitforseconds(zSkill.HurtCameraDelay)
                    self.battle_component:RangeView(not self.__entity.IsPlayer) -- 如果是敌方就切镜头，切左镜头
                end)
            else
                self.battle_component:DeRangeView()
            end
        end
        if self.fsm.curState.stateName == UnitBattleState.AtkEnd or self.fsm.curState.stateName == UnitBattleState.ActEnd then
            Logger.Log("self.fsm.curState == "..self.fsm.curState.stateName.." cannot switch fsm")
            return
        end
        self.fsm:Switch(UnitBattleState.AtkEndCheck)
    end)
end

-- 动画播放到了攻击事件帧
local function OnDamage(self, type) --施法阶段
    if self.atkEnd then
        print("OnDamage: AtkEnd")
        return 
    end
    local skill = self.battle_component.CurActSkill
    local zSkill = skill.ZSkill

    coroutine.start(function ()
            -- 攻击敌方
        local atkEnemy = function (units)
            if not self.atkEnemy then
                if zSkill.Distance == AtkDistance.Range or zSkill.IsAwaken == 1 or zSkill.Distance == AtkDistance.Close then
                    self.atkEnemy = true
                    local camType = self.__entity.IsPlayer and CameraType.Left or CameraType.Right
                    local pos = GetCenterPos(self, camType, units)
                    -- 受击位置偏移
                    local pos2 = GetCenterPos(self, camType, units, true)
                    if not self.IsCamCon then
                        local duration = zSkill.Distance == AtkDistance.Close and 0.1 or nil
                        if zSkill.CenterCamera == 1 then
                            self.battle_camera_component:SwitchCameraByPos(CameraType.Center)
                        else
                            if zSkill.IsAwaken == 1 then
                                SwitchCameraByPos(self, camType, false, units, duration)
                            end
                        end
                        if zSkill.IsAwaken == 1 or zSkill.PlayAsAwaken == 1 then
                            if self.__entity.IsPlayer then
                                self.battle_camera_component:LeftAwakeSet()
                            else
                                self.battle_camera_component:RightAwakeSet()
                            end
                            if zSkill.ShowSelfOnAwaken == 1 then
                                table.insert(units, self.__entity)
                            end
                            self.battle_component:TargetsHide(units)
                        end
                    end
                    if zSkill.IsMoveToTargetRow == 1 then
                        local selfPos = self.__entity.GameObject.transform.position
                        self.__entity.GameObject.transform:DOMove(Vector3.New(selfPos.x, selfPos.y, pos.z), 0)
                    end
                    if zSkill.IsSpell1MoveToTargetRow == 1 then
                        self.unit_effect_component:MoveSpell1Z(pos)
                    end
                    -- 避免施法2和施法1同时出现
                    if zSkill.HideSpell1 == 1 then
                        self.unit_effect_component:RecycleSpell1()
                    end
                    -- 攻击敌人但施法2是给自己的
                    if zSkill.IsSelfSpell2 then
                        pos2 = self.__entity.GameObject.transform.position
                    end
                    self.unit_effect_component:CoPlaySpell2(zSkill.Spell2Efx, pos2)
                    self.unit_sound_component:CoPlaySkl(zSkill.Spell2Sound)
                end
            end
        end

        -- 目标是己方
        local atkFriend = function (units)
            if not self.atkFriend then
                if zSkill.IsTargetEnemy == 0 then
                    self.atkFriend = true
                    local camType = self.__entity.IsPlayer and CameraType.Right or CameraType.Left
                    local pos = GetCenterPos(self, camType, units)
                    if not self.IsCamCon then
                        if zSkill.IsAwaken == 1 then
                            SwitchCameraByPos(self, camType, false, units)
                        end
                        if zSkill.IsAwaken == 1 or zSkill.PlayAsAwaken == 1 then
                            if self.__entity.IsPlayer then
                                self.battle_camera_component:RightAwakeSet()
                            else
                                self.battle_camera_component:LeftAwakeSet()
                            end
                            self.battle_component:TargetsHide(units)
                        end
                    end
                    self.unit_effect_component:CoPlaySpell2(zSkill.Spell2Efx, pos)
                    self.unit_sound_component:CoPlaySkl(zSkill.Spell2Sound)
                end
            end
        end

        local enemyTargets = function ()
            local targets = table.choose(skill.TargetUnits, function (_, v) return not IsSameGroup(self, v) end)
            return targets
        end

        local friendTargets = function()
            local targets = table.choose(skill.TargetUnits, function (_, v) return IsSameGroup(self, v) end)
            return targets
        end

        local targets = {}

        -- 同一帧可以攻击敌方和己方
        if type == nil or type == 0 then
            if zSkill.IsTargetEnemy == 1 or zSkill.ExtraEnemyRange ~=0  then
                local t = enemyTargets()
                table.merge(targets, t)
                atkEnemy(t)
            end
            if zSkill.IsTargetFriend == 1 or zSkill.ExtraFriendRange ~= 0 then
                local tar = friendTargets()
                table.merge(targets, tar)
                atkFriend(tar)
            end
            -- 只能攻击敌方
        elseif type == 1 then
            local t = enemyTargets()
            table.merge(targets, t)
            atkEnemy(t)
            -- 只能攻击己方
        elseif type == 2 then
            local tar = friendTargets()
            table.merge(targets, tar)
            atkFriend(tar)
        end

        if not self.IsCamCon then
            if zSkill.Distance == AtkDistance.Range and zSkill.HideEm == 1 then
                if zSkill.HurtCameraDelay <= 0 then
                    self.battle_component:RangeView(not self.__entity.IsPlayer) -- 如果是敌方就切镜头，切左镜头
                else
                    coroutine.start(function ()
                        coroutine.waitforseconds(zSkill.HurtCameraDelay)
                        self.battle_component:RangeView(not self.__entity.IsPlayer) -- 如果是敌方就切镜头，切左镜头
                    end)
                end
            end
        end

        -- 以下是伤害计算 以及攻击结束检测 每次攻击事件帧检测
        if not self.battle_component.BattleSkip then
            -- 伤害延时
            if zSkill.DelayHurtDuration > 0 then
                coroutine.waitforseconds(zSkill.DelayHurtDuration)
            end
            -- 所有目标对象受伤行为
            table.walk(targets,function (k,v)
                coroutine.waitforframes(1)
                -- 延迟受击时长，被攻击对象暂停在受击动画 (乾隆 修格斯 浮士德 哈斯塔)
                if zSkill.KeepHit == 1 then
                    if type ~= 2 then
                        v:GetComponent("SsUnitAnimatorComponent").keepHit = true
                        v:GetComponent("SsUnitAnimatorComponent"):Play(SsUnitMotionType.Hit)
                    end

                end
                self.battle_component:OnHurtEffect(self.__entity, v)
            end)
        else
            -- 所有目标对象受伤行为
            table.walk(targets,function (k,v)
                self.battle_component:OnHurtEffect(self.__entity, v)
            end)
        end

        if self.IsCamCon then
            if type == nil or type == 0 then
                if self.fsm.curState.stateName == UnitBattleState.AtkEnd or self.fsm.curState.stateName == UnitBattleState.ActEnd then
                    Logger.Log("self.fsm.curState == "..self.fsm.curState.stateName.." cannot switch fsm")
                    return
                end
                self.fsm:Switch(UnitBattleState.AtkEndCheck)
            end
        else
            if self.fsm.curState.stateName == UnitBattleState.AtkEnd or self.fsm.curState.stateName == UnitBattleState.ActEnd then
                Logger.Log("self.fsm.curState == "..self.fsm.curState.stateName.." cannot switch fsm")
                return
            end
            self.fsm:Switch(UnitBattleState.AtkEndCheck)
        end
    end)
end


local function HighlightCurActOn(self)
   self.__entity.ChooseTargetFlag:SetActive(true)
end
local function HighlightCurActOff(self)
   self.__entity.ChooseTargetFlag:SetActive(false)
end
local function HighlightSelectedOn(self)
    self.__entity.TargetChooseRing:SetActive(true)
    self.unit_ui_component:OnChoose(true)
end

-- 关闭本单位的选择描边
local function HighlightSelectedOff(self)
    self.__entity.TargetChooseRing:SetActive(false)
    self.unit_ui_component:OnChoose(false)
end
local function HighlightScopeOn(self)
   self.__entity.CurActUnitFlag:SetActive(true)
end
local function HighlightScopeOff(self)
   self.__entity.CurActUnitFlag:SetActive(false)
end

---当前技能类型
local function CurActIsSkill(self, activeSkillType)
    -- 可能是被动技能
    if self.battle_component.CurActSkill == nil then
        return false
    end
    local skillComponent = self.__entity:GetComponent("SkillComponent")
    if activeSkillType == ActiveSkillType.GeneralAtk then
        return self.battle_component.CurActSkill.SkillId == skillComponent.GeneralAtkId
    elseif activeSkillType == ActiveSkillType.Skill1 then
        return self.battle_component.CurActSkill.SkillId == skillComponent.Skill1Id
    elseif activeSkillType == ActiveSkillType.Skill2 then
        return self.battle_component.CurActSkill.SkillId == skillComponent.Skill2Id
    elseif activeSkillType == ActiveSkillType.Awaken then
        return self.battle_component.CurActSkill.SkillId == skillComponent.Skill2Id
    end
    return false
end

local function PlayAsAwaken(self)
    -- 可能是被动技能
    if self.battle_component.CurActSkill == nil then
        return false
    end
    local config = self.battle_component.CurActSkill.ZSkill
    return config.PlayAsAwaken == 1
end

---当前技能ID
local function CurActSkillIdIs(self,skillId)
    return self.battle_component.CurActSkill ~= nil and self.battle_component.CurActSkill.SkillId == skillId
end
---当前技能是否是普攻
local function CurActSkillIsGeneralAtk(self)
    return self:CurActSkillIdIs(self.__entity:GetComponent("SkillComponent").GeneralAtkId)
end
---获取当前技能的配置
local function CurActZSkill(self)
    return self.battle_component.CurActSkill.ZSkill
end

---显示一个UI文本  同时记录所有的伤害显示
local function GenHUDText(self, text, hudTextType, hudTextType2)
    local isSelf = self.battle_component.CurActUnit ~= nil and self.battle_component.CurActUnit == self.__entity
    local hudTextTask = HUDTextTask.New(text, hudTextType, hudTextType2, isSelf)
    -- 技能触发伤害显示才有
    if self.battle_component.fsm.curState.stateName == BattleState.UnitAct then
        if hudTextTask.HudTextType2 == HUDTextType.Tip then
            local hud = table.first(self.hudList, function (v) return v.Text == text and v.HudTextType == hudTextType and v.HudTextType2 == hudTextType2 and v.IsSelf == isSelf end)
            if not hud then
                table.insert(self.hudList, hudTextTask)
            end
        else -- 伤害
            local hud = table.first(self.hudList, function (v) return v.HudTextType == hudTextType and v.HudTextType2 == hudTextType2 and v.IsSelf == isSelf end)
            if hud then
                hud.Text = tonumber(hud.Text) + tonumber(text)
            else
                table.insert(self.hudList, hudTextTask)
            end
        end
    end
    self.unit_ui_component:CoGenHUDText(hudTextTask)
end
local function OnActEnd(self)
    local damages = table.choose(self.battle_component.IdUnits, function (k, v) 
        local unit_battle_component = v:GetComponent("SsUnitBattleComponent")
        return table.any(unit_battle_component.hudList, function (val) return val.HudTextType2 == HUDTextType.Dmg end)
    end)
    coroutine.start(function () 
        coroutine.waitforframes(1)
        table.walk(self.hudList, function (k, v)
            if v.HudTextType2 == HUDTextType.Dmg then
                v.HudTextType2 = table.count(damages) <= 1 and HUDTextType.Total or HUDTextType.Single
            end
            if v.Text == LangUtil.GetSysLang(24) or
                    v.Text == LangUtil.GetSysLang(35) or
                    v.Text == LangUtil.GetSysLang(25) or
                    v.Text == LangUtil.GetSysLang(26) or
                    v.Text == LangUtil.GetSysLang(27) then
                -- 行动tip不能在结束后显示
            else
                self.unit_ui_component:CoGenHUDText(v)
            end
        end)
        self.hudList = {}
    end)
end
---显示头顶特效文本
local function BuffEffect(self, text, isBuff)
    self.unit_effect_component:CoEffText(text, isBuff)
end
----buff
--local function GetHasDebuff(self)
--    local bfc=self.__entity:GetComponent("BuffComponent")
--    return bfc:AnyBuff(true)
--end

local function Dispose(self)
    base.Dispose(self)
    self.hudList = {}
end

local function OnHideChange(self, isHide)
    if isHide then
        self:SetUnitColorAlpha(0.3)
    else
        self:SetUnitColorAlpha(1)
    end
end

local function ClearExtraMove(self)
    self.IsCac = false
    self.CacUnit = nil
    self:ClearExtraSkill()
end

local function SetExtraSkill(self, skill, target, ignoreExtraSkillActTypeLimit)
    self.ExtraSkill = skill
    self.ExtraSkillTarget = target
    self.IgnoreExtraSkillActTypeLimit = ignoreExtraSkillActTypeLimit
end

local function ClearExtraSkill(self)
    self.ExtraSkill = nil
    self.ExtraSkillTarget = nil
    self.IgnoreExtraSkillActTypeLimit = false
end

SsUnitBattleComponent.Awake = Awake
SsUnitBattleComponent.CameraCon = CameraCon
SsUnitBattleComponent.SsUnit2AwakenLayer = SsUnit2AwakenLayer
SsUnitBattleComponent.Awaken2SsUnitLayer = Awaken2SsUnitLayer
SsUnitBattleComponent.SwitchCameraByPos = SwitchCameraByPos
SsUnitBattleComponent.IsSameGroup = IsSameGroup
SsUnitBattleComponent.HighlightCurActOn = HighlightCurActOn
SsUnitBattleComponent.HighlightCurActOff = HighlightCurActOff
SsUnitBattleComponent.HighlightSelectedOn = HighlightSelectedOn
SsUnitBattleComponent.HighlightSelectedOff = HighlightSelectedOff
SsUnitBattleComponent.HighlightScopeOn = HighlightScopeOn
SsUnitBattleComponent.HighlightScopeOff = HighlightScopeOff
SsUnitBattleComponent.CurActIsSkill = CurActIsSkill
SsUnitBattleComponent.CurActSkillIdIs = CurActSkillIdIs
SsUnitBattleComponent.CurActSkillIsGeneralAtk = CurActSkillIsGeneralAtk
SsUnitBattleComponent.CurActZSkill = CurActZSkill
SsUnitBattleComponent.OnMissile = OnMissile
SsUnitBattleComponent.OnDamage = OnDamage
SsUnitBattleComponent.GenHUDText = GenHUDText
SsUnitBattleComponent.BuffEffect=BuffEffect
SsUnitBattleComponent.Dispose = Dispose
--SsUnitBattleComponent.GetHasDebuff=GetHasDebuff
SsUnitBattleComponent.OnRun=OnRun
SsUnitBattleComponent.PlayAsAwaken=PlayAsAwaken
SsUnitBattleComponent.OnActEnd=OnActEnd
SsUnitBattleComponent.OnHideChange = OnHideChange

SsUnitBattleComponent.ClearExtraMove = ClearExtraMove
SsUnitBattleComponent.SetExtraSkill = SetExtraSkill
SsUnitBattleComponent.ClearExtraSkill = ClearExtraSkill


return SsUnitBattleComponent