local this = require "UI.UIDialog.UIDialogView"

function this.OnAudioEnable(self)
end

function this.OnAudioDisable(self)
end

-- 获取SE播放组件
function this.PlayAudioSource(self, audios)
    -- 该步骤没有音效，则把之前的音效全部停止
    if audios == nil then
        table.walk(self.audios, function (k, v)
            if v.isPlaying then
                v.loop = false
                v:Stop()
            end
        end)
        return
    end

    -- 该步骤有音效要播放，把上一步不需要再播放的关掉
    table.walk(audios, function (key, val)
        for k, v in pairs(self.audios) do
            if k == key then return end
        end
        if self.audios[key] ~= nil then
            self.audios[key].loop = false
            self.audios[key]:Stop()
        end
    end)

    -- 有音效要播放
    table.walk(audios, function (key, val)
        if self.audios[key] == nil then
            local asset = ResourcesManager:GetInstance():CoLoadAsync(key, typeof(AudioClip))
            local audioSource = self.se:AddComponent(typeof(AudioSource))
            audioSource.clip = asset
            self.audios[key] = audioSource
        end

        if val == "loop" then
            if self.audios[key].isPlaying then
                self.audios[key].loop = true
            else
                self.audios[key].loop = true
                self.audios[key].volume = ClientData:GetInstance():GetVolume("BgmVolume")
                self.audios[key]:Play()
            end
        elseif val == 1 then
            if self.audios[key].isPlaying then
                if self.audios[key].loop then
                    self.audios[key].loop = false
                else
                    self.audios[key]:Stop()
                    self.audios[key].loop = false
                    self.audios[key].volume = ClientData:GetInstance():GetVolume("BgmVolume")
                    self.audios[key]:Play()
                end
            else
                self.audios[key].loop = false
                self.audios[key].volume = ClientData:GetInstance():GetVolume("BgmVolume")
                self.audios[key]:Play()
            end
        else
            local as = self.audios[key]
            if as.isPlaying then
                as:Stop()
            end
            as.loop = true
            as.volume = ClientData:GetInstance():GetVolume("BgmVolume")
            as:Play()
            coroutine.start(function ()
                coroutine.waitforseconds(as.clip.length * val)
                if as == nil then return end
                as.loop = false
                as:Stop()
            end)
        end
    end)
end

-- 特殊效果 --
function this.PlayEffect(self, path, delay)
    delay = delay or 0
    coroutine.start(function ()
        coroutine.waitforseconds(tonumber(delay))
        if self.audios[path] == nil then return end
        self.audios[path].loop = false
        self.audios[path].volume = ClientData:GetInstance():GetVolume("BgmVolume")
        self.audios[path]:Play()
    end)
end

return this