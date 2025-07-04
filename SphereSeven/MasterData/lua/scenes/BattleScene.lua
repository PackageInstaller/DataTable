---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/14 22:27
---
local BattleScene = BaseClass("BattleScene", BaseScene)
local base = BaseScene

-- 创建：准备预加载资源
local function OnEnter(self)
    base.OnEnter(self)
    local uiGuide = UIManager:GetInstance():GetWindow(UIWindowNames.UINoviceGuide)
    if uiGuide ~= nil then
        uiGuide.View.mask_bc.transform.parent.gameObject:SetActive(false)
    end
    -- 调试技能测试用
    RefreshSkillEfx()
    
    --添加游戏战斗组件
    self.battle_component = Game.Scene:AddComponent("BattleComponent")
    --资源预加载
    self.battle_component:StartFsm(self)
end

-- 准备工作
local function OnComplete(self)
    base.OnComplete(self)
    coroutine.start(function ()
        coroutine.waitforframes(3)
        Game.Scene:GetComponent("BgmComponent"):Stop()
    end)
    self.battle_component.fsm:Switch(BattleState.InitScene)
end

-- 离开场景
local function OnLeave(self)
    base.OnLeave(self)
    
    Game.Scene:RemoveComponent("BattleComponent")

    self.preload_resources = {}
    self.preload_prefab = {}
    self.preload_ab = {}
end

BattleScene.OnEnter = OnEnter
BattleScene.OnComplete = OnComplete
BattleScene.OnLeave = OnLeave

return BattleScene