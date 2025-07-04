---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/29 21:28
---
local SsUnitEffectComponent = BaseClass("SsUnitEffectComponent",Component);
local base = Component
local zOffset = -0.3

local friendDeathEfxPath = PathUtil.Path_BattleCommonEffects.."Dark_Death.prefab" --我方死亡特效
--local enemyDeathEfxPath = PathUtil.Path_BattleCommonEffects.."Dark_Death.prefab" --敌方死亡特效
local bossDeathEfxPath = PathUtil.Path_BattleCommonEffects.."Big_Death.prefab" --boss死亡特效
local textEfxPath = PathUtil.Path_UIBattleCommonPrefab.."State.prefab"
local reviveEfxPath = PathUtil.Path_BattleCommonEffects.."Resurrected.prefab" --复活特效

local function Awake(self)
    base.Awake(self)

    self.particle_root = GameObject.Find("Particle") --获取特效根节点
    self.battle_component = Game.Scene:GetComponent("BattleComponent") --获取战斗组件
    self.textEffects = {}
    self.textQueue = Queue.New()
    self.DefaultLayer = LayerMask.NameToLayer("Default")
    self.HideLayer = LayerMask.NameToLayer("Hide")
    
    self.continueEfx = nil
end

local function GenEfxPath(self,efxName)
    if self.__entity.ZSsUnit.NewRes == 1 then
        return self.__entity.ZSsUnit.AbDir.."/Effects/"..efxName..".prefab" --获取特效完整路径
    else
        return self.__entity.ZSsUnit.AbDir.."/Battle/Effects/"..efxName..".prefab" --获取特效完整路径
    end
end

-- 检测特效是否有问题
local function CheckEfx(efx)
end

local function RecycleEfx(self,efxPath,efx) --清除特效
    efx.transform.rotation = Quaternion.identity
    GameObjectPool:GetInstance():RecycleGameObject(efxPath,efx)
end

local function ToLayer(self,efx,layer) --修改特效层级
    if self.battle_component.CurActUnit == nil then return end
    if IsNull(efx) then return end
    if efx.layer == layer then return end
    local battle_component = self.battle_component.CurActUnit:GetComponent("SsUnitBattleComponent")
    if battle_component:CurActIsSkill(ActiveSkillType.Awaken) or layer == self.battle_component.CutInLayer or battle_component:PlayAsAwaken() then
        table.csenu(efx:GetComponentsInChildren(typeof(Transform)),function (v)
            v.gameObject.layer = layer
        end)
    end
end

local function HideDir(self,efx)
    table.csenu(efx:GetComponentsInChildren(typeof(Transform)),function (v)
        if efx.transform.localScale.x<0 then
            if  string.endswith(v.gameObject.name,"_right") then
                v.gameObject.layer=self.HideLayer
            end
        else
            if  string.endswith(v.gameObject.name,"_left") then
                v.gameObject.layer=self.HideLayer
            end
        end
    end)
end

local function MirrorEfx(self, efx, mirror)
    if mirror then
        efx.transform.rotation = Quaternion.Euler(0, 180, 0)
    end
    --local xx = efx.transform.localScale
    --xx.x = mirror and xx.x * -1 or math.abs(xx.x)
    --efx.transform.localScale = xx
end

local function CoPlaySpell(self,efxName,delayDestroySeconds) --播放施法特效
    if not string.IsNullOrEmpty(efxName) then
        local splits = string.split(efxName, ";")
        if #splits <= 0 then
            Logger.LogError("error: CoPlaySpell"..efxName)
            return
        end
        if #splits == 1 then
            efxName = splits[1]
        else
            --local skinId = self.__entity.BattleCharacter.SkinId == 0 and 1 or self.__entity.BattleCharacter.SkinId

            local skinId = tonumber( string.sub( tostring(self.__entity.BattleCharacter.SkinId) , -1, -1))
            ---这边潜规则 取最后一位来决定皮肤
            if splits[skinId] == nil then
                Logger.LogError("error: CoPlaySpell in skinId:"..skinId)
                efxName = splits[1]
            else
                efxName = splits[skinId]
            end
        end

        self:RecycleSpell1()

        self.spell1EfxPath = GenEfxPath(self,efxName)
        self.spell1Efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(self.spell1EfxPath)
        CheckEfx(self.spell1Efx)
        self.spell1Efx.transform:SetParent(self.particle_root.transform, false)
        self.spell1Efx.transform.position = self.__entity:GetPosition() + Vector3.New(0,0,zOffset)
        --if not self.__entity.IsPlayer and not self.__entity.IsMonster then
        if self.__entity.BattleCharacter.IsSpecial then
            MirrorEfx(self, self.spell1Efx, true)
        end

        ToLayer(self, self.spell1Efx, self.__entity.GameObject.layer)
        HideDir(self, self.spell1Efx)
    end
end

local function RecycleSpell1(self)
    if self.spell1Efx ~= nil and self.spell1EfxPath ~= nil then
        self.spell1Efx.transform.rotation = Quaternion.identity
        MirrorEfx(self, self.spell1Efx, false)
        GameObjectPool:GetInstance():RecycleGameObject(self.spell1EfxPath, self.spell1Efx)
        self.spell1Efx = nil
        self.spell1EfxPath = nil
    end
end

local function MoveSpell1Z(self, pos)
    if self.spell1Efx ~= nil then
        self.spell1Efx.transform:DOMoveZ(pos.z, 0)
    end
end

local function CoPlaySpell2(self,efxName,position,delayDestroySeconds) --播放施法2特效
    if not string.IsNullOrEmpty(efxName) then
        local splits = string.split(efxName, ";")
        if #splits <= 0 then
            Logger.LogError("error: CoPlaySpell2"..efxName)
            return
        end
        if #splits == 1 then
            efxName = splits[1]
        else
            --local skinId = self.__entity.BattleCharacter.SkinId == 0 and 1 or self.__entity.BattleCharacter.SkinId
            local skinId = tonumber( string.sub( tostring(self.__entity.BattleCharacter.SkinId) , -1, -1))
            ---这边潜规则 取最后一位来决定皮肤
            if splits[skinId] == nil then
                Logger.LogError("error: CoPlaySpell2 in skinId:"..skinId)
                efxName = splits[1]
            else
                efxName = splits[skinId]
            end
        end
        local efxPath = GenEfxPath(self,efxName)
        local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(efxPath)
        CheckEfx(efx)
        efx.transform:SetParent(self.particle_root.transform, false)
        efx.transform.position = position + Vector3.New(0,0,zOffset)
        --if not self.__entity.IsPlayer and not self.__entity.IsMonster then
        if self.__entity.BattleCharacter.IsSpecial then
            MirrorEfx(self, efx, true)
        end
        ToLayer(self,efx, self.battle_component.AwakenLayer)
        HideDir(self,efx)

        coroutine.start(function ()
            coroutine.waitforseconds(delayDestroySeconds or 25)
            if not IsNull(efx) then
                efx.transform.rotation = Quaternion.identity
                MirrorEfx(self, efx, false)
                self.Spell2Efx = nil
                GameObjectPool:GetInstance():RecycleGameObject(efxPath,efx)
            end
        end)
    end
end

local function CoText(self, exfInfo)
    if self.__entity:GetComponent("CharacterComponent").IsDead or exfInfo == nil then
        return
    end
    local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(textEfxPath)
    efx.transform:SetParent(self.__entity.GameObject.transform, false)
    table.insert(self.textEffects, 1, efx)

    local rc = efx:GetComponent(typeof(ReferenceCollector))
    local buffObj = rc:GetObject("Buff")
    local debuffObj = rc:GetObject("Debuff")
    LangUtil.BindText(buffObj)
    LangUtil.BindText(debuffObj)
    buffObj:SetActive(false)
    debuffObj:SetActive(false)
    local obj = exfInfo.IsBuff and buffObj or debuffObj
    obj:SetActive(true)
    local txt = obj:GetComponent("Text")
    txt.text = exfInfo.Text
    table.csenu(efx:GetComponentsInChildren(typeof(Transform)),function (v)
        v.gameObject.layer = self.__entity.GameObject.layer
    end)

    local scale = 1 / self.__entity.GameObject.transform.localScale.y
    local scaleX = 1 / self.__entity.GameObject.transform.localScale.x
    local targetHeight = self.__entity:GetHeight(2)
    local moveDis = (exfInfo.IsBuff and -1 or 1)
    efx.transform:DOMoveY(self.__entity:GetPosition().y + targetHeight + moveDis, 0)
    efx.transform:DOScale(scale, 0)
    DOTween.Sequence():
    Append(efx.transform:DOMoveY(targetHeight + moveDis * 0.25, 0.2)):
    Insert(efx.transform:DOScaleX(scaleX * 1.5, 0.2)):
    Insert(efx.transform:DOScaleY(scale * 1.5, 0.2)):
    Insert(efx.transform:DOScaleZ(scale * 1.5, 0.2)):
    AppendCallback(function ()
        for i = 1, #self.textEffects do
            self.textEffects[i].transform:DOKill()
            self.textEffects[i].transform:DOMoveY(self.__entity:GetHeight(2) + 0.35 * (i - 1), 0.2)
        end
    end)
    DOTween.Sequence():
    AppendInterval(0.2):
    Append(efx.transform:DOScaleX(scaleX, 0.2)):
    Insert(efx.transform:DOScaleY(scale, 0.2)):
    Insert(efx.transform:DOScaleZ(scale, 0.2)):
    AppendInterval(3.5):
    AppendCallback(function ()
        table.removeall(self.textEffects, function(val) return val == efx end)
        GameObjectPool:GetInstance():RecycleGameObject(textEfxPath, efx)
        GameObjectPool:GetInstance():DestroyGameObjectByPath(textEfxPath)
    end)
end

local function CoEffText(self, text, isBuff)
    local exfInfo = { Text = text, IsBuff = isBuff}
    self.textQueue:enqueue(exfInfo)
end

local function Update(self)
    xpcall(function ()
        if self.textQueue:size() <= 0 then return end
        if self.isBusy then return end
        self.isBusy = true
        coroutine.start(function()
            coroutine.waitforendofframe()
            CoText(self, self.textQueue:dequeue())
            coroutine.waitforseconds(0.2)
            self.isBusy = false
        end)
    end, function(msg)
        Logger.LogError("SsUnitEffectComponent.Update: "..msg)
    end)
end

local function OnBatchEnd(self)
    table.walk(self.textEffects, function (k, v) GameObjectPool:GetInstance():RecycleGameObject(textEfxPath, v) end)
    self.textEffects = {}
    self.isBusy = false
    self.textQueue:clear()
end

-- 持续性特效在吕洞宾 奈亚等觉醒技能显示有问题
local function SetContinueEfx(self, isShow)
    if self.continueEfx == nil then
        return
    end
    local layer = isShow and self.battle_component.SsUnitLayer or self.battle_component.HideLayer
    table.csenu(self.continueEfx:GetComponentsInChildren(typeof(Transform)),function (v)
        v.gameObject.layer = layer
    end)
    --ToLayer(self, self.continueEfx, isShow and self.battle_component.SsUnitLayer or self.battle_component.HideLayer)
end

--切换特效点位置
local function ChangeExfPos(self,efxName,position,offset)
    local tf=self.particle_root.transform
    for i = 0,tf.childCount -1 do
        local t = tf:GetChild(i);
        if string.startswith(t.name,efxName) then
            if offset~=nil then
                position.x=position.x+offset.x
                position.y=position.y+offset.y
                position.z=position.z+offset.z
            end
            t.position=position
        end
    end
end
--
local function ChangeExfShow(self,efxName,isshow)
    local tf=self.particle_root.transform
    for i = 0,tf.childCount -1 do
        local t = tf:GetChild(i);
        local layer=self.battle_component.HideLayer
        if isshow then layer=self.battle_component.DefaultLayer end
        if string.startswith(t.name,efxName) then
            table.csenu(t.gameObject:GetComponentsInChildren(typeof(Transform)),function (v)
                v.gameObject.layer = layer
            end)
        end
    end
end
-- 播放弹导特效
local function CoPlayMissile(self,efxName,missileInitIndex)
    assert(not string.IsNullOrEmpty(efxName))
    local efxPath = GenEfxPath(self,efxName)
    local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(efxPath)
    efx.transform:SetParent(self.particle_root.transform, false)
    if self.__entity.IsPlayer then
        efx.transform.position = self.__entity:GetPosition() + Vector3.New(missileInitIndex[1],missileInitIndex[2],missileInitIndex[3]) + Vector3.New(0,0,zOffset)
    else
        efx.transform.position = self.__entity:GetPosition() + Vector3.New(-missileInitIndex[1],missileInitIndex[2],missileInitIndex[3])+ Vector3.New(0,0,zOffset)
    end
    if not self.__entity.IsPlayer and not self.__entity.IsMonster then
        efx.transform:DOLocalRotate(Vector3.New(0, 180, 0), 0)
    else
        efx.transform:DOLocalRotate(Vector3.New(0, 0, 0), 0)
    end
    ToLayer(self,efx,self.battle_component.AwakenLayer)
    return efxPath,efx
end

local function CoPlayHurt(self,efxName,position,delayDestroySeconds) --播放受击特效
    if not string.IsNullOrEmpty(efxName) then
        coroutine.start(function ()
            local efxPath
            if string.startswith(efxName,"Common:") then
                local hurtKind = string.split(efxName,":")[2]
                if hurtKind == "Hurt_xx" then
                    local numarr = {90,45,135,180}
                    local i = ss.WeightRandHit({0.1,0.4,0.4,0.1})
                    efxPath = PathUtil.Path_BattleCommonEffects.."Hurt_"..numarr[i]..".prefab"
                else
                    efxPath = PathUtil.Path_BattleCommonEffects..hurtKind..".prefab"
                end
            else
                efxPath = GenEfxPath(self,efxName)
            end
            local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(efxPath)
            efx.transform:SetParent(self.particle_root.transform, false)
            efx.transform.position = position + Vector3.New(0,0,zOffset)
            coroutine.waitforseconds(delayDestroySeconds or 5)
            if not IsNull(efx) then
                efx.transform.rotation = Quaternion.identity
                GameObjectPool:GetInstance():RecycleGameObject(efxPath,efx)
            end
        end)
    end
end

-- 播放觉醒技能是得把其他角色的这个特效隐藏掉，否则觉醒看到的
local function CoPlayHurtEffect(self,efxName,position)
    if not string.IsNullOrEmpty(efxName) then
        local efxPath
        if string.startswith(efxName,"Common:") then
            local hurtKind = string.split(efxName,":")[2]
            if hurtKind == "Hurt_xx" then
                local numarr = {90,45,135,180}
                local i = ss.WeightRandHit({0.1,0.4,0.4,0.1})
                efxPath = PathUtil.Path_BattleCommonEffects.."Hurt_"..numarr[i]..".prefab"
            else
                efxPath = PathUtil.Path_BattleCommonEffects..hurtKind..".prefab"
            end
        elseif string.startswith(efxName,"FightSoul:") then
            local hurtKind = string.split(efxName,":")[2]
            efxPath = PathUtil.Path_BattleCommonFightSoul..hurtKind..".prefab"
        else
            efxPath = GenEfxPath(self,efxName)
        end
        self.continueEfx = GameObjectPool:GetInstance():CoGetGameObjectAsync(efxPath)
        self.continueEfx.transform:SetParent(self.particle_root.transform, false)
        self.continueEfx.transform.position = position + Vector3.New(0,0,zOffset)
        return self.continueEfx
    end
end

local function RecycleHurtEffect(self, efxName, efx)
    local efxPath
    if string.startswith(efxName,"Common:") then
        local hurtKind = string.split(efxName,":")[2]
        if hurtKind == "Hurt_xx" then
            local numarr = {90,45,135,180}
            local i = ss.WeightRandHit({0.1,0.4,0.4,0.1})
            efxPath = PathUtil.Path_BattleCommonEffects.."Hurt_"..numarr[i]..".prefab"
        else
            efxPath = PathUtil.Path_BattleCommonEffects..hurtKind..".prefab"
        end
    else
        efxPath = GenEfxPath(self,efxName)
    end
    efx.transform.rotation = Quaternion.identity
    self.continueEfx = nil
    GameObjectPool:GetInstance():RecycleGameObject(efxPath,efx)
end

local function CoPlayHandle(self,handleEfxName,handleTrans,delayDestroySeconds) --播放挂点特效
    if not string.IsNullOrEmpty(handleEfxName) then
        local efxPath = GenEfxPath(self,handleEfxName)
        if string.endswith(handleEfxName,"Loop") then--同名的loop删除
            table.csenu(handleTrans:GetComponentsInChildren(typeof(Transform)),function (t)
                if string.startswith(t.name,handleEfxName) then
                    GameObjectPool:GetInstance():RecycleGameObject(efxPath,t.gameObject)
                end
            end)
        end
        local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(efxPath)
        efx.transform:SetParent(handleTrans, false)
        local particles = efx:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystem))
        table.csenu(particles, function (v)
            v:Play()
        end)
        ToLayer(self,efx, self.__entity.GameObject.layer)

        --loop的不用自动删除
        if string.endswith(handleEfxName,"Loop") then
            return
        end
        coroutine.start(function ()
            coroutine.waitforseconds(delayDestroySeconds or 10)
            GameObjectPool:GetInstance():RecycleGameObject(efxPath,efx)
        end)
    end
end

local function CoPlayHandles(self,zSkill,delayDestroySeconds) --播放挂点1和挂点2特效
    CoPlayHandle(self,zSkill.HandleEfx,self.__entity.HandleTrans,delayDestroySeconds)
    CoPlayHandle(self,zSkill.Handle2Efx,self.__entity.Handle2Trans,delayDestroySeconds)
    CoPlayHandle(self,zSkill.Handle3Efx,self.__entity.Handle3Trans,delayDestroySeconds)
    CoPlayHandle(self,zSkill.Handle4Efx,self.__entity.Handle4Trans,delayDestroySeconds)
    CoPlayHandle(self,zSkill.Handle5Efx,self.__entity.Handle5Trans,delayDestroySeconds)
    CoPlayHandle(self,zSkill.Handle6Efx,self.__entity.Handle6Trans,delayDestroySeconds)
    CoPlayHandle(self,zSkill.Handle7Efx,self.__entity.Handle7Trans,delayDestroySeconds)
end

local function RecycleHandle(self,handleEfxName,handleTrans) --清除挂点特效
    if not string.IsNullOrEmpty(handleEfxName) then
        local efxPath = GenEfxPath(self,handleEfxName)
        local efx = handleTrans:Find(handleEfxName.."(Clone)").gameObject
        GameObjectPool:GetInstance():RecycleGameObject(efxPath,efx)
    end
end

local function RecycleHandles(self,zSkill) --清除所有挂点特效
    RecycleHandle(self,zSkill.HandleEfx,self.__entity.HandleTrans)
    RecycleHandle(self,zSkill.Handle2Efx,self.__entity.Handle2Trans)
    RecycleHandle(self,zSkill.Handle3Efx,self.__entity.Handle3Trans)
    RecycleHandle(self,zSkill.Handle4Efx,self.__entity.Handle4Trans)
    RecycleHandle(self,zSkill.Handle5Efx,self.__entity.Handle5Trans)
    RecycleHandle(self,zSkill.Handle6Efx,self.__entity.Handle6Trans)
    RecycleHandle(self,zSkill.Handle7Efx,self.__entity.Handle7Trans)
end

local function CoPlayCutIn(self, efxName, delayDestroySeconds) --播放CutIn特效
    if not string.IsNullOrEmpty(efxName) then
        coroutine.start(function ()
            local battleUIComponent = Game.Scene:GetComponent("BattleUIComponent")
            battleUIComponent:ShowAwakenSkill(true)
            coroutine.waitforseconds(2.5)
            battleUIComponent:ShowAwakenSkill(false)
        end)
        local skinId = self.__entity.BattleCharacter.FigureAssetConfig.Id
        -- 战斗模型不跟皮肤挂钩：有的角色不同阶段共用战斗模型
        local skinConfig = Z_Skin[skinId]

        local stageId = skinConfig.ModelStage

        local suf = stageId..skinConfig.CutIn -- 阶段 + 是否和谐
        local name = efxName..suf -- 特效名字
        local unitSplits = string.split(self.__entity.ZSsUnit.AbDir, "_")
        local unitName = unitSplits[#unitSplits]..suf
        local efxPath = self.__entity.ZSsUnit.AbDir.."/"..unitName.."/Battle/"..name..".prefab"
        --local efxPath = GenEfxPath(self, name)
        local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(efxPath)
        if efx == nil then
            Logger.LogError("cannot find:"..efxPath)
            return
        end
        efx.transform:SetParent(self.particle_root.transform, false)
        efx.transform.position = Vector3.New(0, 0, 0)
        if not self.__entity.IsPlayer and not self.__entity.IsMonster then
            MirrorEfx(self, efx, true)
        end
        ToLayer(self,efx, self.battle_component.CutInLayer)
        coroutine.start(function ()
            coroutine.waitforseconds(delayDestroySeconds or 5) -- 觉醒的cut没有回收，接着放觉醒
            efx.transform.rotation = Quaternion.identity
            MirrorEfx(self, efx, false)
            GameObjectPool:GetInstance():RecycleGameObject(efxPath,efx)
        end)
    end
end

local function CoPlayBeforeCutIn(self, efxName, delayDestroySeconds)
    if not string.IsNullOrEmpty(efxName) then
        local efxPath = GenEfxPath(self, efxName)
        local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(efxPath)
        if efx == nil then
            Logger.LogError("cannot find:"..efxPath)
            return
        end
        efx.transform:SetParent(self.particle_root.transform, false)
        efx.transform.position = self.__entity:GetPosition() + Vector3.New(0,0,zOffset)
        if not self.__entity.IsPlayer and not self.__entity.IsMonster then
            MirrorEfx(self, efx, true)
        end
        ToLayer(self,efx, self.battle_component.CutInLayer)
        coroutine.start(function ()
            coroutine.waitforseconds(delayDestroySeconds or 25)
            efx.transform.rotation = Quaternion.identity
            MirrorEfx(self, efx, false)
            GameObjectPool:GetInstance():RecycleGameObject(efxPath,efx)
        end)
    end
end

-- 大禹特效的奇葩情况
local function OnBattleStart(self)
    if self.__entity.ZCard.Id == 1018 then -- Idle 特殊情况在这里处理
        CoPlayHandle(self, "018_Yu_Idle_Handle_Loop", self.__entity.HandleTrans)
    end
end

local function OnAtkStart(self)
    if self.__entity.ZCard.Id == 1018 then -- Idle 特殊情况在这里处理
        if string.endswith("018_Yu_Idle_Handle_Loop","Loop") then--同名的loop删除
            table.csenu(self.__entity.HandleTrans:GetComponentsInChildren(typeof(Transform)),function (t)
                if string.startswith(t.name, "018_Yu_Idle_Handle_Loop") then
                    local efxPath = GenEfxPath(self, "018_Yu_Idle_Handle_Loop")
                    GameObjectPool:GetInstance():RecycleGameObject(efxPath, t.gameObject)
                end
            end)
        end
    end
end

local function OnActEnd(self)
    self:RecycleSpell1()
    if self.__entity.ZCard.Id == 1018 then -- Idle 特殊情况在这里处理
        CoPlayHandle(self, "018_Yu_Idle_Handle_Loop", self.__entity.HandleTrans)
    end
end

local function OnDead(self, delayDestroySeconds) --播放死亡特效
    table.walk(self.textEffects, function (k, v) GameObjectPool:GetInstance():RecycleGameObject(textEfxPath, v) end)
    self.textEffects = {}
    local deathEfxPath = friendDeathEfxPath
    if self.__entity.ZCard.IsBigMonster == 1 then
        deathEfxPath = bossDeathEfxPath
    end
    local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(deathEfxPath)
    efx.transform:SetParent(self.particle_root.transform, false)
    efx.transform.position = self.__entity:GetCenterPos() + Vector3.New(0,0,zOffset)
    coroutine.start(function ()
        --coroutine.waitforseconds(delayDestroySeconds or 3)
        coroutine.waitforseconds(1)
        GameObjectPool:GetInstance():RecycleGameObject(deathEfxPath,efx)
    end)
end

local function OnRevive(self, delayDestroySeconds)
    local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(reviveEfxPath)
    efx.transform:SetParent(self.particle_root.transform, false)
    efx.transform.position = self.__entity:GetFootPos() + Vector3.New(0,0, zOffset)
    coroutine.start(function ()
        coroutine.waitforseconds(delayDestroySeconds or 3)
        GameObjectPool:GetInstance():RecycleGameObject(reviveEfxPath, efx)
    end)
end

local function GenBuffEfxPath(self,kind,efx) --获取buff特效完整路径
    local efxDir
    if kind == 1 then
        efxDir = "TurnBuff"
    elseif kind == 2 then
        efxDir = "OnceBuff"
    elseif kind == 3 then
        efxDir = "TurnDeBuff"
    end
    return PathUtil.Path_BattleCommonBuff..efxDir.."/"..efx..".prefab"
end

local function CoPlayBuff(self,kind,efx,delayTime) --播放buff特效
    if not string.IsNullOrEmpty(efx) then
        coroutine.start(function () local isLoop = false
            local efxName = efx
            if string.endswith(efx,"_Loop") then
                isLoop =  true
                efxName = string.split(efxName,"_")[1]
            end
            local efxPath = GenBuffEfxPath(self,kind,efxName)
            coroutine.waitforseconds(delayTime)
            local efxGo = GameObjectPool:GetInstance():CoGetGameObjectAsync(efxPath)
            ToLayer(self, efxGo, self.__entity.GameObject.layer)
            efxGo.transform:SetParent(self.__entity.GameObject.transform, false)
            if isLoop == nil or not isLoop then
                coroutine.waitforseconds(3)
                GameObjectPool:GetInstance():RecycleGameObject(efxPath,efxGo)
            end
        end)
    end
end

local function RecycleBuff(self,kind,efx) --清除buff特效
    if not string.IsNullOrEmpty(efx) and string.endswith(efx,"_Loop") then
        local efxName = string.split(efx,"_")[1]
        local efxPath = GenBuffEfxPath(self,kind,efxName)
        if not IsNull(self.__entity) and not IsNull(self.__entity.GameObject) then
            local efx = self.__entity.GameObject.transform:Find(efxName.."(Clone)")
            if not IsNull(efx) then
                local efxGo = self.__entity.GameObject.transform:Find(efxName.."(Clone)").gameObject
                GameObjectPool:GetInstance():RecycleGameObject(efxPath,efxGo)
            end
        end
    end
end

local function CoPlayBuffHandle(self,kind,efx,handle) --播放buff特效
    if not string.IsNullOrEmpty(efx) then
        local isLoop = false
        local efxName = efx
        if string.endswith(efx,"_Loop") then
            isLoop =  true
            efxName = string.split(efxName,"_")[1]
        end
        local efxPath = GenBuffEfxPath(self,kind,efxName)
        local efxGo = GameObjectPool:GetInstance():CoGetGameObjectAsync(efxPath)
        ToLayer(self, efxGo, self.__entity.GameObject.layer)
        efxGo.transform:SetParent(handle, false)
        if isLoop == nil or not isLoop then
            coroutine.start(function ()
                coroutine.waitforseconds(2)
                GameObjectPool:GetInstance():RecycleGameObject(efxPath,efxGo)
            end)
        end
    end
end

local function RecycleBuffHandle(self,kind,efx,handle) --清除buff特效
    if not string.IsNullOrEmpty(efx) and string.endswith(efx,"_Loop") then
        local efxName = string.split(efx,"_")[1]
        local efxPath = GenBuffEfxPath(self,kind,efxName)
        local efxGo = handle:Find(efxName.."(Clone)").gameObject
        GameObjectPool:GetInstance():RecycleGameObject(efxPath,efxGo)
    end
end

local function Dispose(self)
    base.Dispose(self)
end

SsUnitEffectComponent.Awake = Awake
SsUnitEffectComponent.RecycleEfx = RecycleEfx
SsUnitEffectComponent.MoveSpell1Z = MoveSpell1Z
SsUnitEffectComponent.CoPlaySpell = CoPlaySpell
SsUnitEffectComponent.RecycleSpell1 = RecycleSpell1
SsUnitEffectComponent.CoPlaySpell2 = CoPlaySpell2
SsUnitEffectComponent.CoPlayMissile = CoPlayMissile
SsUnitEffectComponent.CoPlayHurt = CoPlayHurt
SsUnitEffectComponent.CoPlayHandle = CoPlayHandle
SsUnitEffectComponent.CoPlayHandles = CoPlayHandles
SsUnitEffectComponent.RecycleHandle = RecycleHandle
SsUnitEffectComponent.RecycleHandles = RecycleHandles
SsUnitEffectComponent.CoPlayCutIn = CoPlayCutIn
SsUnitEffectComponent.CoPlayBeforeCutIn = CoPlayBeforeCutIn
SsUnitEffectComponent.OnDead = OnDead
SsUnitEffectComponent.CoPlayBuff = CoPlayBuff
SsUnitEffectComponent.RecycleBuff = RecycleBuff
SsUnitEffectComponent.CoPlayBuffHandle = CoPlayBuffHandle
SsUnitEffectComponent.RecycleBuffHandle = RecycleBuffHandle
SsUnitEffectComponent.ChangeExfPos=ChangeExfPos
SsUnitEffectComponent.ChangeExfShow=ChangeExfShow
SsUnitEffectComponent.CoEffText=CoEffText
SsUnitEffectComponent.SetContinueEfx=SetContinueEfx
SsUnitEffectComponent.Dispose = Dispose
SsUnitEffectComponent.Update = Update
SsUnitEffectComponent.OnBatchEnd = OnBatchEnd
SsUnitEffectComponent.OnBattleStart = OnBattleStart 
SsUnitEffectComponent.OnActEnd = OnActEnd 
SsUnitEffectComponent.OnAtkStart = OnAtkStart 
SsUnitEffectComponent.CoPlayHurtEffect = CoPlayHurtEffect
SsUnitEffectComponent.RecycleHurtEffect = RecycleHurtEffect
SsUnitEffectComponent.OnRevive = OnRevive

return SsUnitEffectComponent