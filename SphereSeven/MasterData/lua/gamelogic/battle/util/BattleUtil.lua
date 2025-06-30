
local BattleUtil = {}
local this = BattleUtil

local function CreateUnit(cardId, figureAssetId)
    local modelName = Z_FigureAsset[figureAssetId].SsUnitName
    
    local zCard = Z_Card[cardId]
    local zSsUnit = Z_SsUnit:GetConfig(zCard.SsUnitId) -- 单位的配置文件
    local isNewBattleSpine = Z_FigureAsset[figureAssetId].IsNewBattleSpine

    local path
    local unitName -- 单位的名字：旧资源会有前面编号  新资源没有编号
    if isNewBattleSpine == 1 then
        unitName = modelName
        path = zSsUnit.AbDir.."/"..unitName.."/BattleSpine/"..unitName..".prefab"
    else
        if zSsUnit.NewRes == 1 then
            local unitSplits = string.split(zSsUnit.AbDir, "_")
            unitName = modelName--unitSplits[#unitSplits]..stage
            path = zSsUnit.AbDir.."/"..unitName.."/Model/"..unitName..".prefab"
        else
            local unitSplits = string.split(zSsUnit.AbDir, "/")
            unitName = unitSplits[#unitSplits]
            path = zSsUnit.AbDir.."/Model/"..unitName..".prefab"
        end
    end
    
    local go = GameObjectPool:GetInstance():CoGetGameObjectAsync(path)
    
    
    local animator = go:GetComponent(typeof(CS.UnityEngine.Animator))
    if animator == nil then return end
    if animator.runtimeAnimatorController == nil then
        local resPath
        if zSsUnit.NewRes == 1 then
            resPath = zSsUnit.AbDir.."/"..unitName.."/Battle/"..unitName..".controller"
        elseif isNewBattleSpine == 1 then
            resPath = zSsUnit.AbDir.."/"..unitName.."/BattleSpine/"..unitName..".controller"
        else
            resPath = zSsUnit.AbDir.. "/Battle/SsUnitAnimator"..".controller"
        end
        local asset = ResourcesManager:GetInstance():CoLoadAsync(resPath,typeof(RuntimeAnimatorController))
        animator.runtimeAnimatorController=asset
    end
    
    
    return go    
end

local function GenSsUnit(battleComponent, unitData, isPlayer)
    local matrixRootTrans = Game.Scene:GetComponent("MatrixComponent").MatrixRoot.transform
    local ssUnit = Game.Registry:NewObject("SsUnit",battleComponent:GenNextSsUnitId())
    battleComponent.IdUnits[ssUnit.UID] = ssUnit

    local battlecharacter = Game.Registry:NewObject("BattleCharacter")

    local battleUnitComponent = battlecharacter:AddComponent("BattleUnitComponent")
    local buc = ssUnit:AddComponent("BattleUnitComponent")

    local posId = 0
    local configId = 0
    if unitData.isMonster then
        configId = unitData.monster.Id
        battleUnitComponent:InitForMonster(unitData.monster.Id)
        buc:InitForMonster(unitData.monster.Id)
        posId = unitData.monster.PosId
        buc.PosId = posId
    else
        configId = unitData.character_id
        battleUnitComponent:InitForCard(unitData.unit)
        buc:InitForCard(unitData.unit)
        posId = unitData.unit.formation_postion
    end
    local isSpecial = false
    if isPlayer == false and unitData.isMonster == false then
        isSpecial = true
    end
    battlecharacter:SetFromBattleUnitComponent(isSpecial)
    battlecharacter:InitComponent()
    
    local zSsUnit = Z_SsUnit:GetConfig(battleUnitComponent.CardConfig.SsUnitId) --单位配置：单位编辑器

    battleComponent.IdUnits[ssUnit.UID] = ssUnit
    ssUnit.ZSsUnit = zSsUnit
    ssUnit.BattleCharacter = battlecharacter
    ssUnit.ZCard = battleUnitComponent.CardConfig
    ssUnit.Name = LangUtil.GetConfLang(ssUnit.ZCard,"Name")
    ssUnit.GameObject = CreateUnit(battleUnitComponent.CardConfig.Id, battleUnitComponent.FigureAssetConfig.Id)
    ssUnit.GameObject.transform:SetParent(battleComponent.ssUnit_root, false) --设置模型父节点
    if unitData.isMonster and unitData.monster.Config.IsBoss == 1 then
        ssUnit.IsBoss = 1
    end

    -- 我方位置在右边，位置信息对应Z_Matrix表里10加位置索引
    -- 敌方位置在左边，位置信息对应Z_Matrix表里20加位置索引
    local matrixId = isPlayer and posId + 10 or posId + 20
    local zMatrix = Z_Matrix[matrixId]
    local pos = matrixRootTrans:Find(zMatrix.GameObject).transform.position -- 站位的位置
    local xMultiple = isPlayer and 1 or -1
    if #zSsUnit.Position > 1 then
        ssUnit:SetPosition(Vector3.New(pos.x + xMultiple * zSsUnit.Position[1] ,pos.y + zSsUnit.Position[2],pos.z + zSsUnit.Position[3]))
    else
        ssUnit:SetPosition(pos)
    end

    -- Feixiao
    local rotationXTable = {15,15,15}
    local rotationX = rotationXTable[(posId - 1) % 3 + 1]
    ssUnit.GameObject.transform.localEulerAngles = Vector3.New(rotationX,0,0)
    if battlecharacter.CardConfig.IsMonster == 0 and not isPlayer then
        ssUnit.GameObject.transform.localScale = Vector3.New(-1, 1, 1)
    end

    ssUnit.CurActUnitFlag = GameObjectPool:GetInstance():CoGetGameObjectAsync("SsUnit/Common/CurActUnitFlag.prefab") --行动标记
    ssUnit.CurActUnitFlag.transform:SetParent(ssUnit.GameObject.transform,false)
    ssUnit.CurActUnitFlag:SetActive(false)
    ssUnit.ChooseTargetFlag = GameObjectPool:GetInstance():CoGetGameObjectAsync("SsUnit/Common/ChooseTargetFlag.prefab") --被选标记
    ssUnit.ChooseTargetFlag.transform:DOMoveY(ssUnit:GetHeight(1), 0)
    ssUnit.ChooseTargetFlag.transform:SetParent(ssUnit.GameObject.transform,false)
    ssUnit.ChooseTargetFlag:SetActive(false)
    ssUnit.TargetChooseRing = GameObjectPool:GetInstance():CoGetGameObjectAsync("SsUnit/Common/TargetChooseRing.prefab") --被选光圈
    ssUnit.TargetChooseRing.transform:SetParent(ssUnit.GameObject.transform,false)
    ssUnit.TargetChooseRing:SetActive(false)
    ssUnit.Scale=ssUnit.GameObject.transform.localScale
    ssUnit.Pos=ssUnit.GameObject.transform.position

    local isNewBattleSpine = Z_FigureAsset[battleUnitComponent.Skin].IsNewBattleSpine
    local scale = 0--Z_SsUnit:GetConfig(ssUnitId).UnitScale

    if isNewBattleSpine == 1 then
        scale = Z_FigureAsset[battleUnitComponent.Skin].UnitScale
    else
        if Z_FigureAsset[battleUnitComponent.Skin].UnitScale ~= 0 then
            scale = Z_FigureAsset[battleUnitComponent.Skin].UnitScale
        else
            scale = Z_SsUnit:GetConfig(battleUnitComponent.CardConfig.SsUnitId).UnitScale
        end
    end


    if scale > 0 then
        ssUnit.Scale=Vector3.New(ssUnit.GameObject.transform.localScale.x*scale,scale,scale)
        ssUnit.GameObject.transform:DOScale(ssUnit.Scale,0)
        -- ssUnit.UnitShadow.transform.localScale = ssUnit.UnitShadow.transform.localScale/scale
        ssUnit.TargetChooseRing.transform.localScale = ssUnit.TargetChooseRing.transform.localScale/scale
    end

    ssUnit.GameObject:AddComponent(typeof(CS.UnityEngine.SphereCollider)).enabled = false --关闭碰撞体
    ssUnit.IsPlayer = isPlayer  --为我方单位
    ssUnit.IsMonster = unitData.isMonster  --是否是怪物
    ssUnit.CloseAtkOffset = Vector3.New(zSsUnit.CloseAtkOffset[1],zSsUnit.CloseAtkOffset[2],zSsUnit.CloseAtkOffset[3]) --近战攻击偏移
    ssUnit.HitPosPosition = ssUnit:GetPosition() + Vector3.New(zSsUnit.HitPosOffset[1],zSsUnit.HitPosOffset[2],zSsUnit.HitPosOffset[3]) --受击位置偏移
    if not string.IsNullOrEmpty(zSsUnit.HandleBones[1]) then
        ssUnit.HandleTrans = ssUnit.GameObject.transform:FindChildByName(zSsUnit.HandleBones[1]) --挂点1
    end
    if not string.IsNullOrEmpty(zSsUnit.HandleBones[2]) then
        ssUnit.Handle2Trans = ssUnit.GameObject.transform:FindChildByName(zSsUnit.HandleBones[2]) --挂点2
    end
    if not string.IsNullOrEmpty(zSsUnit.HandleBones[3]) then
        ssUnit.Handle3Trans = ssUnit.GameObject.transform:FindChildByName(zSsUnit.HandleBones[3]) --挂点3
    end
    if not string.IsNullOrEmpty(zSsUnit.HandleBones[4]) then
        ssUnit.Handle4Trans = ssUnit.GameObject.transform:FindChildByName(zSsUnit.HandleBones[4]) --挂点4
    end
    if not string.IsNullOrEmpty(zSsUnit.HandleBones[5]) then
        ssUnit.Handle5Trans = ssUnit.GameObject.transform:FindChildByName(zSsUnit.HandleBones[5]) --挂点5
    end
    if not string.IsNullOrEmpty(zSsUnit.HandleBones[6]) then
        ssUnit.Handle6Trans = ssUnit.GameObject.transform:FindChildByName(zSsUnit.HandleBones[6]) --挂点6
    end
    if not string.IsNullOrEmpty(zSsUnit.HandleBones[7]) then
        ssUnit.Handle7Trans = ssUnit.GameObject.transform:FindChildByName(zSsUnit.HandleBones[7]) --挂点7
    end
    ssUnit.BuffHandleTrans = ssUnit.GameObject.transform:FindChildByName("Bip001 L Toe0") -- buff的挂点
    table.csenu(ssUnit.GameObject:GetComponentsInChildren(typeof(Transform)),function (v) -- 设置模型层级
        v.gameObject.layer = battleComponent.SsUnitLayer
    end)
    ssUnit:AddComponent("SsUnitAnimatorComponent") --添加动作组件
    ssUnit:AddComponent("SsUnitMoveComponent") --添加移动组件
    ssUnit:AddComponent("SsUnitSoundComponent") --添加音效组件
    ssUnit:AddComponent("SsUnitVoiceComponent") --添加人声组件
    ssUnit:AddComponent("SsUnitEffectComponent") --添加特效组件
    ssUnit:AddComponent("SsUnitMatrixComponent",zMatrix) --添加站位组件

    ssUnit:AddComponent("NumericComponent") --添加数值组件
    ssUnit:AddComponent("CharacterComponent") --添加特性组件
    ssUnit:AddComponent("SsUnitUIComponent") --添加UI组件
    ssUnit:AddComponent("SsUnitBattleComponent") --添加战斗流程组件
    ssUnit:AddComponent("AnimatorEventHandleComponent") --添加动作事件组件
    ssUnit:AddComponent("BuffComponent") --添加buff组件
    ssUnit:AddComponent("SkillComponent") --添加技能组件

    local unitExtraProperty = battleComponent.against_component:GetUnitExtraProperty(zMatrix.Group, unitData.batchNum, posId)
    if unitExtraProperty ~= nil then
        ssUnit:SetExtendHp(unitExtraProperty.remain_hp)
    end

    battleComponent:AddUnitRecord(ssUnit, unitData.batchNum, posId, configId)

    return ssUnit
end

local function GetRandomFloat(min, max)
    return min + (max - min) * math.random()
end

-- 获取最xx的一个单位
---@param units SsUnit[]
---@param valueFunc function(unit:SsUnit):number @比较值取值函数
---@param isMax boolean
---@vararg function(unit:SsUnit):boolean @predicate, 筛选函数
---@return SsUnit
local function GetExtremeTarget(units, valueFunc, isMax, predicate)
    local targetUnit = nil
    local value = isMax and -99999999 or 99999999
    for _, unit in pairs(units) do
        if predicate and not predicate(unit) then
            goto continue
        end
        local attrValue = valueFunc(unit)
        if isMax then
            if attrValue > value then
                value = attrValue
                targetUnit = unit
            end
        else
            if attrValue < value then
                value = attrValue
                targetUnit = unit
            end
        end
        ::continue::
    end
    return targetUnit
end

local function GetExtremeAttrTarget(units, numericType, isMax, predicate)
    local attrFunc = function(unit)
        return unit:GetComponent("NumericComponent"):Get(numericType)
    end

    return GetExtremeTarget(units, attrFunc, isMax, predicate)
    -- local targetUnit = nil
    -- local value = isMax and -99999999 or 99999999
    -- for _, unit in pairs(units) do
    --     if predicate and not predicate(unit) then
    --         goto continue
    --     end
    --     local attrValue = unit:GetComponent("NumericComponent"):Get(numericType)
    --     if isMax then
    --         if attrValue > value then
    --             value = attrValue
    --             targetUnit = unit
    --         end
    --     else
    --         if attrValue < value then
    --             value = attrValue
    --             targetUnit = unit
    --         end
    --     end
    --     ::continue::
    -- end
    -- return targetUnit
end

local function GetHpPct(unit)
    local nc = unit:GetComponent("NumericComponent")
    local hp = nc:Get(NumericType.Hp)
    local maxHp = nc:Get(NumericType.MaxHp)
    return hp / maxHp
end

local function GetHealHpScale(srcUnit, targetUnit)
    local healScale = srcUnit:GetComponent("NumericComponent"):Get(NumericType.HealEffect) / 100 - 1
    local healRecScale = targetUnit:GetComponent("NumericComponent"):Get(NumericType.HealRecEffect) / 100 - 1
    local scale = 1 + healScale + healRecScale
    if scale < 0 then
        scale = 0
    end
    return scale
end

local function IsPctProbHit(pctProb)
    return ss.IsRandHit(pctProb / 100)
end

local function IsFriend(unit1, unit2)
    return unit1:GetComponent("SsUnitMatrixComponent").Group == unit2:GetComponent("SsUnitMatrixComponent").Group
end

local function HasShield(unit)
    local buffComponent = unit:GetComponent("BuffComponent")
    return buffComponent:HasBuffId(BattleBuffType.PhyShield)
        or buffComponent:HasBuffId(BattleBuffType.MagicShield)
        or buffComponent:HasBuffId(BattleBuffType.UniversalShield)
end

local function IsShieldBuff(buffId)
    return buffId == BattleBuffType.PhyShield or buffId == BattleBuffType.MagicShield or buffId == BattleBuffType.UniversalShield
end

local function GetGroupByServerTeamSide(side)
    if side == 1 then
        return MatrixGroup.Friend
    elseif side == 2 then
        return MatrixGroup.Enemy
    else
        return nil
    end
end

local function IsSingleActiveSkill(activeSkill)
    if activeSkill.ZSkill == nil then
        Logger.LogError(string.format("skill: %d is not a active skill", activeSkill.SkillId))
        return nil
    end

    local range = activeSkill.ZSkill.EnemyRange

    if range == EnemyRange.Single then
        return true
    -- random target has config problem
    -- elseif range == EnemyRange.Random and skill.ZSkill.
    end
    
    return false
end

BattleUtil.GenSsUnit = GenSsUnit
BattleUtil.CreateUnit = CreateUnit
BattleUtil.GetRandomFloat = GetRandomFloat
BattleUtil.GetExtremeAttrTarget = GetExtremeAttrTarget
BattleUtil.GetExtremeTarget = GetExtremeTarget
BattleUtil.GetHpPct = GetHpPct
BattleUtil.GetHealHpScale = GetHealHpScale
BattleUtil.IsPctProbHit = IsPctProbHit
BattleUtil.IsFriend = IsFriend
BattleUtil.HasShield = HasShield
BattleUtil.IsShieldBuff = IsShieldBuff
BattleUtil.GetGroupByServerTeamSide = GetGroupByServerTeamSide
BattleUtil.IsSingleActiveSkill = IsSingleActiveSkill

return BattleUtil