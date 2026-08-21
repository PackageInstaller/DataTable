local this = require "UI.UIDialog.UIDialogView"

function this.OnBgmEnable(self)
    self.currentBgm = nil
    self.bgmTweeners = {}
end

function this.OnBgmDisable(self)
    table.walk(self.bgmTweeners, function (k, v)
        if v ~= nil then
            v:Kill()
        end
    end)
end

-- 播放BGM
function this.PlayBgm(self, name, path)
    -- 当前步骤播放BGM和上一步相同时
    if self.currentBgm == path then return end

    if self.bgmTweeners == nil then
        self.bgmTweeners = {}
    end

    local func = function(bgmPath)
        -- 这个BGM还没有完全停止，又要播放了
        if self.bgmTweeners[bgmPath] ~= nil then
            self.bgmTweeners[bgmPath]:Kill()
            self.bgmRes[bgmPath]:Stop()
            self.bgmTweeners[bgmPath] = nil
        end
        self.currentBgm = bgmPath
        self.bgmRes[bgmPath].volume = ClientData:GetInstance():GetVolume("BgmVolume")
        self.bgmRes[bgmPath].loop = true
        self.bgmRes[bgmPath]:Play()
    end

    -- 如果当前没有BGM
    if self.currentBgm == nil and string.IsNullOrEmpty(name) then
        return
    end

    if self.currentBgm == nil and not string.IsNullOrEmpty(name) then
        func(path)
        return
    end

    if self.currentBgm ~= nil then
        local bgmCur = self.currentBgm
        table.walk(self.bgmRes, function (k, v)
            if v.isPlaying then
                local t = self.bgmRes[bgmCur]:DOFade(0, 0.5)
                self.bgmTweeners[bgmCur] = t
                t.onComplete = function()
                    self.bgmRes[bgmCur]:Stop()
                    self.bgmTweeners[bgmCur] = nil
                end
            end
        end)
        self.currentBgm = nil
        if not string.IsNullOrEmpty(name) then
            func(path)
        end
    end
end

return this