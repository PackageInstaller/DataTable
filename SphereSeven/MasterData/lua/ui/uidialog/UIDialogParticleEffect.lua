local this = require "UI.UIDialog.UIDialogView"

function this.OnParticleEffectEnable(self)
    self.particleCache = {}
end

function this.OnParticleEffectDisable(self)
    table.walk(self.particleCache, function (k, v)
        self:Recycle(v.efx, v.path)
    end)
    self.particleCache = {}
end

function this.LoadEfxAutoDestroy(self, path, parent, time)
    local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(path)
    table.insert(self.particleCache, {efx = efx, path = path})
    efx.transform:SetParent(parent.transform, false)
    table.csenu(efx:GetComponentsInChildren(typeof(Transform)),function (v)
        v.gameObject.layer = LayerMask.NameToLayer("UI")
    end)
    local particleSystem = efx.transform:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystemRenderer))
    local canvas = parent.transform.parent:GetComponent("Canvas")
    if not IsNull(canvas) then
        table.csenu(particleSystem, function(v)
            v.sortingOrder = canvas.sortingOrder
        end)
    end
    time = time or 0
    if time ~= -1 then
        coroutine.waitforseconds(time)
        self:Recycle(efx)
    end
    return efx
end

function this.Recycle(self, efx, path)
    local tab = table.choose(self.particleCache, function (k, v)
        return v.efx == efx or v.path == path
    end)
    table.walk(tab, function (k, v)
        GameObjectPool:GetInstance():RecycleGameObject(v.path, v.efx)
        self.particleCache[k] = nil
    end)
end

-- 加载特效
function this.PlayParticleEffect(self, path, delay)
    delay = delay or 0
    coroutine.start(function ()
        coroutine.waitforseconds(tonumber(delay))
        self:LoadEfxAutoDestroy(path, self.particle, 20)
    end)
end

-- 给立绘释放特效
function this.DrawingParticle(self, drawingType, path, delay)
    local drawingGo = self:GetDrawingGo(drawingType)
    delay = delay or 0
    coroutine.start(function ()
        coroutine.waitforseconds(tonumber(delay))
        self:LoadEfxAutoDestroy(path, drawingGo, 15)
    end)
end

-- 
function this.PlayParticle(self, path, duration, delay, layer)
    duration = duration or 0
    delay = delay or 0
    coroutine.start(function ()
        coroutine.waitforseconds(tonumber(delay))
        local parent = self.particle
        if tonumber(layer or 0) == 0 then
            parent = self.bgParticle
        end
        if duration ~= "loop" then
            self:LoadEfxAutoDestroy(path, parent, 20)
            --local efx = self:LoadEfxAutoDestroy(path, parent, 20)
            --local particleSystem = efx.transform:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystem))
            --table.csenu(particleSystem, function(v)
            --    v.main.loop = true
            --end)
        else -- 循环特效才缓存起来
            self:LoadEfxAutoDestroy(path, parent, -1)
        end
    end)
end

-- 回收这个path的特效
function this.StopLoop(self, path)
    coroutine.start(function ()
        --local tab = table.choose(self.particleCache, function (k, v)
        --    return v.path == path
        --end)
        --table.walk(tab, function (k, v)
        --    local particleSystem = v.efx.transform:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystem))
        --    table.csenu(particleSystem, function(particle)
        --        particle.main.loop = false
        --    end)
        --end)
        self:Recycle(nil, path)
    end)
end

return this