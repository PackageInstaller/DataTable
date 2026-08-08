
local acMgr = AutoChessManager.instance()

local base = require("Skill_Default")
---@class Skill_10001:Skill_Default
local Skill = class("Skill_10001", base)


---@param skill AutoChessSkill
function Skill:OnStart(skill)
   base.OnStart(self, skill)
   
end


---@param skill AutoChessSkill
function Skill:OnExecuteSkillEffect(skill)

   base.OnExecuteSkillEffect(self, skill)
   ---获取创建的飞机
   local planeBullet = skill.bulletIds[1]
   if planeBullet == nil then
      return 
   end
   ---@type AutoChessBullet
   local summon = acMgr:GetEntity(planeBullet)
   if summon == nil then
      return 
   end

   ---设置飞机位置
   local attackId = skill.targetId
   local attackEntity = acMgr:GetEntity(attackId)
   if attackEntity == nil then
      return
   end


   local handParam = skill.skillCfg.scriptParam
   if handParam == nil or true then
      handParam = {
         0,       ---偏移x
         0.5,       ---偏移x
         0,       ---偏移x
      }
   end
   local ownPos = skill.owner:GetPosition()
   local startPos = Vector3.New(ownPos.x + handParam[1], ownPos.y + handParam[2], ownPos.z + handParam[3])
   summon:SetPosition(startPos)
   local targetPos = attackEntity:GetPosition()
   local dir = targetPos - startPos
   dir.y = 0
   dir:SetNormalize()
   local len = Vector3.Distance(startPos, targetPos)
   local summonMovePos = startPos + dir * (len + 5)
   summonMovePos.y = 2
   summon:SetTargetPos(summonMovePos)
end
return Skill
