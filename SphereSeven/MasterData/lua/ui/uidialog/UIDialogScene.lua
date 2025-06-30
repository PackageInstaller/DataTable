local this = require "UI.UIDialog.UIDialogView"

function this.OnSceneEnable(self)
    self.currentBg = nil
end

function this.OnSceneDisable(self)
    if self.doSceneShake ~= nil then
        self.doSceneShake:Kill()
        self.doSceneShake = nil
    end
end

-- 切换场景
function this.ChangeScene(self, path, fadeTime)
    -- 背景不切换
    if path == self.currentBg then
        return
    end

    if string.IsNullOrEmpty(fadeTime) then -- ** 默认场景切换 0.1秒
        fadeTime = 0.1
    end

    if self.bgs[path] == nil then
        return
    end

    self.bgs[path]:SetActive(true)
    self.bgs[path].transform:SetAsFirstSibling()
    self.bgs[path].transform:GetComponent("Image"):DOFade(1, 0)
    self.bgs[path].transform:DOLocalMove(Vector3.New(0, 0, 0), 0)
    self.bgs[path].transform:DOScale(Vector3.New(1, 1, 1), 0)
    if self.currentBg ~= nil then
        local cur = self.currentBg
        self.bgs[cur].transform:GetComponent("Image"):DOFade(0, fadeTime).onComplete = function () self.bgs[cur].transform:GetComponent("Image").material = nil end
    end
    self.currentBg = path
end

----------------------------------- 特殊效果--------------------------------------------
function this.SceneShake(self, strength, duration, delay)
    if self.currentBg == nil then
        return
    end
    strength = strength or 100
    duration = duration or 1
    delay = delay or 0

    if tonumber(delay) > 0 then
        coroutine.start(function ()
            coroutine.waitforseconds(tonumber(delay))
            if duration == "loop" then
                self.doSceneShake = self.bgs[self.currentBg].transform:DOShakePosition(1, tonumber(strength), 10, 90, false, false):SetLoops(-1, LoopType.Incremental)
            else
                self.doSceneShake = self.bgs[self.currentBg].transform:DOShakePosition(tonumber(duration), tonumber(strength))
            end
        end)
    else
        if duration == "loop" then
            self.doSceneShake = self.bgs[self.currentBg].transform:DOShakePosition(1, tonumber(strength), 10, 90, false, false):SetLoops(-1, LoopType.Incremental)
        else
            self.doSceneShake = self.bgs[self.currentBg].transform:DOShakePosition(tonumber(duration), tonumber(strength))
        end
    end
end

function this.SceneRemoveShake(self)
    if self.doSceneShake ~= nil then
        self.doSceneShake:Kill()
    end
end

function this.SceneBlur(self, strength)
    if self.currentBg == nil then
        return
    end
    self.bgs[self.currentBg]:GetComponent("Image").material = self.blurMtrl
end

function this.SceneRadialBlur(self, strength)
    if self.currentBg == nil then
        return
    end
    self.bgs[self.currentBg]:GetComponent("Image").material = self.radialBlurMtrl
end

function this.SceneRemoveBlur(self)
    if self.currentBg == nil then
        return
    end
    self.bgs[self.currentBg]:GetComponent("Image").material = nil
end

function this.SceneGrey(self)
    if self.currentBg == nil then
        return
    end
    self.bgs[self.currentBg]:GetComponent("Image").material = self.greyMtrl
end

function this.SceneRemoveGrey(self)
    if self.currentBg == nil then
        return
    end
    self.bgs[self.currentBg]:GetComponent("Image").material = nil
end

function this.SceneIce(self, strength, delay)
    if self.currentBg == nil then
        return
    end
    delay = delay or 0
    strength = strength or 1
    coroutine.start(function ()
        coroutine.waitforseconds(tonumber(delay))
        self.iceMtrl:SetFloat("_StatueDegree", 1)
        self.iceMtrl:SetFloat("_Brightness", tonumber(strength))
        self.bgs[self.currentBg]:GetComponent("Image").material = self.iceMtrl
    end)
end

function this.SceneWaveEffect(self)
    local camera = CS.UnityEngine.GameObject.Find("UICamera")
    local effect = camera:GetComponent("WaterWaveEffect");
    if effect == nil then
        return
    end
    effect.enabled = true
    coroutine.start(function ()
        coroutine.waitforseconds(5)
        effect.enabled = false
    end)
end

function this.SceneBlink(self, times)
    self.blink:SetActive(true)
    times = times or 1
    local img = self.blink:GetComponent("Image")
    coroutine.start(function ()
        local val = 0.6
        for index = 1, tonumber(times) - 1 do
            for i = 1, 19 do
                val = val - 0.03
                img.material:SetVector("_Param", Vector4.New(0.5, val, 1, 1))
                coroutine.waitforframes(1)
            end
            for i = 1, 19 do
                val = val + 0.03
                img.material:SetVector("_Param", Vector4.New(0.5, val, 1, 1))
                coroutine.waitforframes(1)
            end
            coroutine.waitforseconds(0.3)
        end

        for i = 1, 19 do
            val = val - 0.03
            img.material:SetVector("_Param", Vector4.New(0.5, val, 1, 1))
            coroutine.waitforframes(1)
        end
        for i = 1, 40 do
            val = val + 0.03
            if val > 0.6 then
                img.material:SetVector("_Param", Vector4.New(0.5 + val * 0.03, val, 1, 1))
            else
                img.material:SetVector("_Param", Vector4.New(0.5, val, 1, 1))
            end
            coroutine.waitforframes(1)
        end
        for i = 1, 40 do
            val = val + 0.05
            img.material:SetVector("_Param", Vector4.New(val, val, 1, 1))
            coroutine.waitforframes(1)
        end
        self.blink:SetActive(false)
    end)
end

function this.SceneBlinkOpen(self)
    self.blink:SetActive(true)
    local m = self.blink:GetComponent("Image").material
    m:SetVector("_Param", Vector4.New(0, 0, 1, 1))
    coroutine.start(function ()
        local val = 0
        for i = 1, 40 do
            val = val + 0.025
            m:SetVector("_Param", Vector4.New(val, val, 1, 1))
            coroutine.waitforframes(1)
        end
        for i = 1, 40 do
            val = val + 0.05
            m:SetVector("_Param", Vector4.New(val, val, 1, 1))
            coroutine.waitforframes(1)
        end
        self.blink:SetActive(false)
    end)
end

function this.SceneScale(self, value, duration)
    if self.currentBg == nil then
        return
    end
    value = value or 1
    duration = duration or 1
    self.bgs[self.currentBg].transform:DOScale(tonumber(value), tonumber(duration))
end

function this.SceneMoveY(self, value, duration)
    if self.currentBg == nil then
        return
    end
    value = value or 1
    duration = duration or 1
    self.bgs[self.currentBg].transform:DOLocalMoveY(tonumber(value), tonumber(duration))
end

function this.SceneMoveX(self, value, duration)
    if self.currentBg == nil then
        return
    end
    value = value or 1
    duration = duration or 1
    self.bgs[self.currentBg].transform:DOLocalMoveX(tonumber(value), tonumber(duration))
end

return this