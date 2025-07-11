---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/10/10 11:22

local PlayerBuffComponent = BaseClass("PlayerBuffComponent", Component)
local base = Component
local this = PlayerBuffComponent

function this.Awake(self)
    base.Awake(self)
    self.MaxHpPct = 0
    self.AtkPct = 0
    self.DefPct = 0
    self.SpeedPct = 0
    self.HitAdd = 0
    self.PryAdd = 0 
    self.BlkAdd = 0 
    self.StmAdd = 0
    self.CriAdd = 0 
    self.CacAdd = 0
    self.AccAdd = 0
    
    self.IsMHSZ = false --梅花圣杖buff是否开启
    self.MHSZTimeStamp = 0 --梅花圣杖buff截止时间
    
    self.IsInfiniteEnergy = false --是否体力无限
    self.InfiniteEnergyStamp = 0 --体力无限截止时间
    
    self.HasLevelBuff = false -- 是否有关卡buff
end

function this.Set(self)
    local player = Game.Scene.Player
    self.MHSZTimeStamp = player.AddHaftPrTime
    self.InfiniteEnergyStamp = player.UnlimitedEnergyTime
end

function this.Update(self)
    -- 梅花圣杖
    if self.MHSZTimeStamp == 0 or self.MHSZTimeStamp <= TimeUtil.OSTime() then
        self.IsMHSZ = false
    else
        self.IsMHSZ = false
    end
    -- 无限体力
    if self.InfiniteEnergyStamp == 0 or self.InfiniteEnergyStamp <= TimeUtil.OSTime() then
        self.IsInfiniteEnergy = false
    else
        self.IsInfiniteEnergy = true
    end
end

function this.GetAllAttrAdd(self) --全属性加成
    local allAttrAdd = 0
    return allAttrAdd
end

-- 进关卡前设置是否有关卡buff
function this.SetLevelBuff(self, hasBuff)
    self.HasLevelBuff = hasBuff
end

function this.GetLevelBuff(self)
    return self.HasLevelBuff and 50 or 0
end

return this