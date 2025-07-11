---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/6/21 17:53
---
local UIBattleShowRound = BaseClass("UIBattleShowRound",UIBaseView)
local this = UIBattleShowRound
local base = UIBaseView

local batPrefab = PathUtil.Path_UIBattleEffects.."Battle.prefab"

function this.OnCreate(self)
    base.OnCreate(self)
    GameObjectPool:GetInstance():CoPreLoadGameObjectAsync(batPrefab)

    self.battle1 = ResourcesManager:GetInstance():CoLoadAsync(PathUtil.Path_UIBattleEffects.."Battle1"..".mat", typeof(Material)) 
    self.battle2 = ResourcesManager:GetInstance():CoLoadAsync(PathUtil.Path_UIBattleEffects.."Battle2"..".mat", typeof(Material))
    self.battle3 = ResourcesManager:GetInstance():CoLoadAsync(PathUtil.Path_UIBattleEffects.."Battle3"..".mat", typeof(Material))
end

function this.OnEnable(self)
    base.OnEnable(self)
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.ShowTxt(self, txt, func)
    coroutine.start(function ()
        coroutine.waitforframes(1)
        func()
        coroutine.waitforframes(2)
        local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(batPrefab)
        table.csenu(efx:GetComponentsInChildren(typeof(Transform)),function (v)
            v.gameObject.layer = LayerMask.NameToLayer("UI")
        end)
        table.csenu(efx:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystemRenderer)),function (smr)
            smr.sortingOrder = self.canvas.unity_canvas.sortingOrder + 1
        end)
        efx.transform:SetParent(self.gameObject.transform, false)
        if tonumber(txt) == 1 then
            efx.transform:GetChild(0):GetComponent(typeof(CS.UnityEngine.ParticleSystemRenderer)).material = self.battle1
        elseif tonumber(txt) == 2 then
            efx.transform:GetChild(0):GetComponent(typeof(CS.UnityEngine.ParticleSystemRenderer)).material = self.battle2
        elseif tonumber(txt) == 3 then
            efx.transform:GetChild(0):GetComponent(typeof(CS.UnityEngine.ParticleSystemRenderer)).material = self.battle3
        end
        Game.Scene:GetComponent("SoundComponent"):CoPlay(CommonSoundPath.battleStartSound)
        coroutine.waitforseconds(3)
        GameObjectPool:GetInstance():RecycleGameObject(batPrefab, efx)
    end)
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end

return this