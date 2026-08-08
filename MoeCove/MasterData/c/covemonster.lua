
local CoveBase = require "CoveBase"

---@class CoveMonster:CoveBase
local CoveMonster = class("CoveMonster", CoveBase)
function CoveMonster:ctor(data)
	self.id = data.id
	---@type MonsterTable
	self.monsterCfg = Config.GetMonsterInfo(self.id)
	self.coveType = CoveType.Monster
end

---获得预制体路径
function CoveMonster:GetCoveContainerName()
	return Config.PrefabPath.CoveMonster
end

---获得模型路径
---@return string?
function CoveMonster:GetCoveModelPath()
	local monsterCfg = Config.GetMonsterInfo(self.id)
	if monsterCfg == nil then
		LuaLogger.es("创建怪物错误 id:" .. tostring(self.id))
		return nil
	end
	local skinId = monsterCfg.baseSkinID
	local skinCfg = Config.GetCharacterSkinInfo(skinId)
	if skinCfg == nil then
		LuaLogger.es("创建怪物错误 Skin id:" .. tostring(skinId))
		return nil
	end
	self.skinCfg = skinCfg
	return skinCfg.modelKey
end

---加载模型完成
function CoveMonster:OnModelLoadFinish()
	CoveBase.OnModelLoadFinish(self)

	local val = math.random(20, 50)
	self._roleCont:SetAgentPriority(val)
	self:CreateEffect(1107)
	self:SetEffectActive(1107, false)
	self:CreateEffect(3000)
	self:SetEffectActive(3000, false)
	
	GameMsgMgr:sendEvent(GameMsgType.Add3DMark, self, CoveManager.instance().camera, 1)

	self:GotoBattle()
end



---获得血条显示位置
---@return Vector3?
function CoveMonster:GetHeadPosition()
	if not self.modelLoadFinish then
		return nil
	end
	if IsNull(self._roleObj) then
		local a = 0
	end
	if self.skinCfg == nil then
		return nil
	end
	if self.hpBarPos == nil then
		self.hpBarPos = Vector3.New()
	end
	local pos = self:GetPosition()
	self.hpBarPos:Set(pos.x, pos.y + self.skinCfg.HpBarOffset + 1, pos.z)
	return self.hpBarPos
end

function CoveMonster:GetHeadIconPath()
	return "Sprite/homemoods/battle_img_bossicon.png"
end

---角色是否可以点击
---@return boolean
function CoveMonster:RoleCanTouch()
	return true
end

function CoveMonster:Destroy()
	CoveBase.Destroy(self)
	GameMsgMgr:sendEvent(GameMsgType.Remove3DMark, self)
end

function CoveMonster:OnClick()
	LuaLogger.ds("点击怪物==>>" .. tostring(self:GetID()))
	CoveBattleMgr.instance():SetForceAttackTarget(self)
end

function CoveMonster:GotoBattle()
	local monsterCfg = Config.GetMonsterInfo(self.id)
	if monsterCfg == nil then
		return	
	end

	self.skillCtrl:ResetSkill(monsterCfg.homeFightAtk)

	self.maxHp = monsterCfg.homeFightHp
	self.maxMp = monsterCfg.homeFightMp
	local fightInfo = CoveBattleMgr.instance():GetSaveFightingInfo(self)
	if fightInfo == nil then
		LuaLogger.es("未找到战斗怪物数据")
		return
	end

	local fightPoint, fightDir = fightInfo.pos, fightInfo.defDir
	
	local pos = Vector3.New(fightPoint.x / 100, fightPoint.y / 100, fightPoint.z / 100) 
	self._roleCont:SetPositionImm(pos)
	self._roleCont:SetDirection(fightDir/ 100, 0.5, nil)

	local hp = fightInfo.hp or self.maxHp
	local mp = fightInfo.mp or self.maxMp
	self:SetResourceVal(HeroAttributeType.Hp, hp)
	self:SetResourceVal(HeroAttributeType.Mp, mp)
	
	self:SetCoveModelState(1)
	--设置移动速度
	self.moveSpeed = monsterCfg.homeFightSpeed
	self._roleCont:SetSpeed(monsterCfg.homeFightSpeed)
	self:SetAttackRange(monsterCfg.homeFightRange)

	---@type CoveBattleMonsterAI
	self.aiTree = require('CoveBattleMonsterAI'):new(self)
	self:SetEnableUpdate(true)
end


function CoveMonster:GetEnemyAwayDis()
	if self.monsterCfg == nil then
		return 0
	end
	return self.monsterCfg.enemyAway
end


function CoveMonster:GetFriendAwayDis()
	if self.monsterCfg == nil then
		return 0
	end
	return self.monsterCfg.partnerAway
end



function CoveMonster:CanDead()
	local isAllReady = self:IsAllReady(CovePlayerReadyType.Deading)
	if not isAllReady then
		return false
	end

	local hp = self:GetResourceVal(HeroAttributeType.Hp)
	return hp <= 0
end

function CoveMonster:GotoDead()

	self:SetReady(CovePlayerReadyType.Deading)
	self._model:PlayAnim(RoleModelAnimEnum.Die, function() 

	end)
	self.isDead = true
	local audioData = self.skinCfg.battleDie
	if audioData then
		--BattleShowManager.instanceOf:PlayBattleAudio(self.skinCfg, audioData, data.roleName)
	end
	local effectId = self.skinCfg and self.skinCfg.dieEff or 1000
	CoveBattleMgr.instance():playEffect( self:GetUID(), effectId,  Vector3.zero)
	self._model:FadeOut()
	self:AddTimeWait(2, function()
		CoveBattleMgr.instance():DeleteCoveMonster(self)
		CoveRoleManager.instance():RemoveMonster(self)
	end)
end





return CoveMonster