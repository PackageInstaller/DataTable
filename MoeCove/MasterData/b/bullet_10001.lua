
local acMgr = AutoChessManager.instance()

local base = require("Bullet_Default")

---@class Bullet_10001:Bullet_Default
local Bullet = class("Bullet_10001", base)

---@param bullet AutoChessBullet
function Bullet:OnUpdate(bullet, dt)
   base.OnUpdate(self, bullet, dt)

   if bullet.attackId == nil then
      return 
   end
   if bullet.isDead then
      return
   end
   local dis = acMgr:GetEnitytDistance(bullet:GetUID(), bullet.attackId)
   if dis < 0 then
      return
   end
   local cfg = bullet.bulletCfg
   local chechDis = cfg.scriptParam.dis
   if dis > chechDis then
      return 
   end
   ---是否母子弹药
   bullet:SetDead()
   local bulletId = cfg.scriptParam.bulletId
   local childBullet = acMgr:CreateBullet(bulletId, bullet.data.owner, bullet.data.skillId)
   if childBullet == nil then
      return
   end
   childBullet:SetPosition(bullet:GetPosition())
end

return Bullet


