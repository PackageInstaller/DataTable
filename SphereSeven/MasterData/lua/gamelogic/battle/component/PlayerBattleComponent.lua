local PlayerBattleComponent = BaseClass("PlayerBattleComponent", Component)
local base = Component

if PlayerAnim == nil then
    PlayerAnim = 
    {
        Idle = "Idle",
        Atk1 = "Atk1",
        Atk2 = "Atk2",
        Hit1 = "Hit1",
        Hit2 = "Hit2",
        Storm = "Storm",
        Faith = "Faith",
        Death = "Death",
        FnJmp = "FnJmp",
        FnJmpDown = "FnJmpDown",
        BkJmp = "BkJmp",
        BkJmpDown = "BkJmpDown",
        Buff = "Buff",
        Failure = "Failure",
        Victory = "Victory",
        Resurrected = "Resurrected"
    }
end

local worldpos=Vector4.New(0,0,0,0)
local projdir = Vector4.New(-2.55, 7.4, -6.33, 0.0)
local planePos = Vector4.New(0.0, -1.5, 0.0, 0.1)
local FadeParams = Vector4.New(1.73, 0.67, 0.51, 28.9)
local Falloff = 1.35

local function Awake(self)
    base.Awake(self)
    self.pos = Vector3.New(8.01, 0, 1.34)
    local templateId = 1000
    local stage = 1
    --local cardComponent = Game.Scene.Player:GetComponent("CardComponent")
    --self.go = cardComponent:CreatUnitByCard({TemplateId = templateId},true) -- 战斗和UI的动画控制器设置
    self.MatUpdateTime=0
    self.MatList={}
    
    local zSsUnit = Z_SsUnit:GetConfig(templateId) -- 单位的配置文件
    local path
    local unitName -- 单位的名字：旧资源会有前面编号  新资源没有编号
    local unitSplits = string.split(zSsUnit.AbDir, "_")
    unitName = unitSplits[#unitSplits]..stage
    path = zSsUnit.AbDir.."/"..unitName.."/Model/"..unitName..".prefab"

    self.go = GameObjectPool:GetInstance():CoGetGameObjectAsync(path)
    local animator = self.go:GetComponent(typeof(CS.UnityEngine.Animator))
    if animator == nil then return end
    if animator.runtimeAnimatorController == nil then
        local resPath = zSsUnit.AbDir.."/"..unitName.."/Battle/"..unitName..".controller"
        local asset = ResourcesManager:GetInstance():CoLoadAsync(resPath,typeof(RuntimeAnimatorController))
        animator.runtimeAnimatorController=asset
    end
    
    self.battle_component = Game.Scene:GetComponent("BattleComponent")
    self.go.transform:SetParent(self.battle_component.ssUnit_root, false) --设置模型父节点
    self.go.transform.position = self.pos
    local flag = GameObjectPool:GetInstance():CoGetGameObjectAsync("SsUnit/Common/CurActUnitFlag.prefab") --行动标记
    flag.transform:SetParent(self.go.transform,false)
    flag:SetActive(false)
    local ring = GameObjectPool:GetInstance():CoGetGameObjectAsync("SsUnit/Common/TargetChooseRing.prefab") --被选光圈
    ring.transform:SetParent(self.go.transform,false)
    ring:SetActive(false)
    --local zCard = Z_Card[templateId] --角色配置：excel配置
    --local zSsUnit = Z_SsUnit:GetConfig(zCard.SsUnitId) --单位配置：单位编辑器
    if zSsUnit.UnitScale > 0 then
        local scale = Vector3.New(zSsUnit.UnitScale,zSsUnit.UnitScale,zSsUnit.UnitScale)
        self.go.transform:DOScale(scale,0)
        ring.transform.localScale = ring.transform.localScale/zSsUnit.UnitScale
    end

    self.stormBone = self.go.transform:FindChildByName("Bone005") --帝王风暴挂点
    
    --local animator = self.go:GetComponent(typeof(CS.UnityEngine.Animator)) --获取单位的animator组件
    if animator == nil then return end
    if animator.runtimeAnimatorController == nil then return end
    if animator.runtimeAnimatorController.animationClips == nil then return end
    self.animator = animator

    table.csenu(self.go:GetComponentsInChildren(typeof(SkinnedMeshRenderer)),function (smr)
        table.insert(self.MatList,smr.material)
        CSUtil.MatSetVector(smr.material,"_ShadowProjDir", projdir)
        CSUtil.MatSetVector(smr.material,"_ShadowPlane", planePos)
        CSUtil.MatSetVector(smr.material,"_ShadowFadeParams", FadeParams)
        CSUtil.MatSetFloat(smr.material,"_ShadowFalloff", Falloff)
    end)
    
    self:Show()
    self.go:SetActive(false)
end

local function Update(self)
    self.MatUpdateTime = self.MatUpdateTime + 1
    if self.MatUpdateTime % 7==0 then
        if self.MatList ~=nil then
            local pos= self.go.transform.position
            worldpos.x=pos.x
            worldpos.y=pos.y
            worldpos.z=pos.z
            table.walk(self.MatList,function(_,v)
                CSUtil.MatSetVector(v,"_WorldPos", worldpos)
            end)
        end
    end
end

local function PlayAnim(self, animType)
    self.animator:SetTrigger(animType)
    if animType == PlayerAnim.Storm then
        self:CoPlayHandle("000_NanZhuJue_Handle1", self.stormBone)
    elseif animType == PlayerAnim.Faith then
        self:CoPlayHandle("000_NanZhuJue_Handle1", self.stormBone)
        self:CoPlayHandle("Gain1", self.stormBone)
    end
end

local function ToLayer(self,efx,layer) --修改特效层级
    if self.battle_component.CurActUnit == nil then return end
    local battle_component = self.battle_component.CurActUnit:GetComponent("SsUnitBattleComponent")
    if battle_component:CurActIsSkill(ActiveSkillType.Awaken) or layer == self.battle_component.CutInLayer or battle_component:PlayAsAwaken() then
        if efx.layer == layer then
            return
        end
        table.csenu(efx:GetComponentsInChildren(typeof(Transform)),function (v)
            v.gameObject.layer = layer
        end)
    end
end

local function CoPlayHandle(self,handleEfxName,handleTrans,delayDestroySeconds) --播放挂点特效
    if not string.IsNullOrEmpty(handleEfxName) then
        local efxPath = "SsUnit/000_NanZhuJue/Effects/"..handleEfxName..".prefab"
        local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(efxPath)
        efx.transform:SetParent(handleTrans, false)
        local particles = efx:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystem))
        table.csenu(particles, function (v)
            v:Play()
        end)
        ToLayer(self, efx, self.go.layer)
        coroutine.start(function ()
            coroutine.waitforseconds(delayDestroySeconds or 10)
            GameObjectPool:GetInstance():RecycleGameObject(efxPath,efx)
        end)
    end
end

local function Hide(self)
    table.csenu(self.go:GetComponentsInChildren(typeof(Transform)),function (go)
        go.gameObject.layer = self.battle_component.HideLayer
    end)
end

local function Show(self)
    table.csenu(self.go:GetComponentsInChildren(typeof(Transform)),function (go)
        go.gameObject.layer = self.battle_component.SsUnitLayer
    end)
end

local function Dispose(self)
    base.Dispose(self)
    CS.UnityEngine.Object.Destroy(self.go)
end

PlayerBattleComponent.Awake = Awake
PlayerBattleComponent.PlayAnim = PlayAnim
PlayerBattleComponent.CoPlayHandle = CoPlayHandle
PlayerBattleComponent.Hide = Hide
PlayerBattleComponent.Show = Show
PlayerBattleComponent.Update = Update 
PlayerBattleComponent.Dispose = Dispose 

return PlayerBattleComponent