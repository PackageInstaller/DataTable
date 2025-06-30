local this = require "UI.UIDialog.UIDialogView"

function this.OnPreloadEnable(self)
    self.preloaded = false
    -- 预加载
    self.bgs = {}
    self.drawings = {}
    self.faces = {}
    self.audios = {}
    self.bgmRes = {}
end

function this.OnPreloadDisable(self)
    ListChildPool:GetInstance():ClearContent(self.bgContent)
    table.walk(self.audios, function (k, v) 
        GameObject.Destroy(v)
    end)
    table.walk(self.bgmRes, function (k, v)
        GameObject.Destroy(v)
    end)
    -- 剔除引用，便于清资源
    self.bgs = {}
    self.drawings = {}
    self.faces = {}
    self.audios = {}
    self.bgmRes = {}
end

function this.UpdateLoading(self, allRes, curRes)
    --self.loadingSlider.value = curRes / allRes
    if allRes == curRes then
        --coroutine.start(function () 
        --    coroutine.waitforseconds(0.2)
        --    self.contentType = nil
        --    self.loadingSlider.gameObject:SetActive(false)
        --    Game.Scene:GetComponent("DialogComponent"):PlayNextStep()
        --end)
        self.contentType = nil
        --self.loadingSlider.gameObject:SetActive(false)
        Game.Scene:GetComponent("DialogComponent"):PlayNextStep()
    end
end

-- 预加载该话所有场景
function this.PreloadScene(self, bgPaths, headPaths, drawingPaths, audioPaths, bgmPaths)
    if self.preloaded then
        coroutine.start(function ()
            coroutine.waitforseconds(0.5) -- 先等场景切换好
            Game.Scene:GetComponent("DialogComponent"):PlayNextStep()
        end)
        return
    end
    self:OnPreloadDisable() -- 主要是清一下标题音效
    self.preloaded = true

    local allRes = #bgPaths + #headPaths + #drawingPaths + #audioPaths + #bgmPaths + 1
    local curRes = 0

    coroutine.start(function ()
        self.greyMtrl = ResourcesManager:GetInstance():CoLoadAsync("UI/Materials/UI-GreyDefault.mat", typeof(Material))
        self.blurMtrl = ResourcesManager:GetInstance():CoLoadAsync("UI/Materials/GaussianBlur.mat", typeof(Material))
        self.radialBlurMtrl = ResourcesManager:GetInstance():CoLoadAsync("UI/Materials/RadialBlur.mat", typeof(Material))
        self.petrifactionMtrl = ResourcesManager:GetInstance():CoLoadAsync("UI/Materials/Petrifaction.mat", typeof(Material))
        self.iceMtrl = ResourcesManager:GetInstance():CoLoadAsync("UI/Materials/Ice.mat", typeof(Material))
        curRes = curRes + 1
        self:UpdateLoading(allRes, curRes)
    end)

    coroutine.start(function ()
        self.bgs = {}
        ListChildPool:GetInstance():ClearContent(self.bgContent)
        table.walk(bgPaths, function (k, val)
            if self.bgs[val] == nil then
                ListChildPool:GetInstance():GetChild("BackgroundItem", self.bgContent, function(go)
                    go:SetActive(false)
                    self.bgs[val] = go
                    local img = go:GetComponent("Image")
                    if string.contains(val, "BlackScreen") then
                        img.color = Color.New(0, 0, 0, 1)
                        img.sprite = nil
                        return
                    end
                    img.color = Color.New(1, 1, 1, 1)
                    if string.contains(val, "WhiteScreen") then
                        img.sprite = nil
                        return
                    end
                    go:GetComponent("Image").sprite = AtlasManager:GetInstance():CoLoadImageAsync(val)
                end)
            end
            curRes = curRes + 1
            self:UpdateLoading(allRes, curRes)
        end)
    end)

    coroutine.start(function ()
        self.faces = {}
        table.walk(headPaths, function (k, val)
            self.faces[val] = self.faces[val] or AtlasManager:GetInstance():CoLoadImageAsync(val)
            if self.faces[val] == nil then
                Logger.LogError("not find "..val)
            end
            curRes = curRes + 1
            self:UpdateLoading(allRes, curRes)
        end)
    end)

    coroutine.start(function ()
        self.drawings = {}
        table.walk(drawingPaths, function (k, val)
            self.drawings[val] = self.drawings[val] or AtlasManager:GetInstance():CoLoadImageAsync(val)
            if self.drawings[val] == nil then
                Logger.LogError("not find "..val)
            end
            curRes = curRes + 1
            self:UpdateLoading(allRes, curRes)
        end)
    end)

    coroutine.start(function ()
        self.audios = {}
        table.walk(audioPaths, function (k, val)
            if self.audios[val] == nil or self.audios[val].clip == nil then
                local asset = ResourcesManager:GetInstance():CoLoadAsync(val, typeof(AudioClip))
                local audioSource = self.se:AddComponent(typeof(AudioSource))
                audioSource.clip = asset
                self.audios[val] = audioSource
                if asset == nil then
                    Logger.LogError("not find "..val)
                end
            end
            curRes = curRes + 1
            self:UpdateLoading(allRes, curRes)
        end)
    end)

    coroutine.start(function ()
        self.bgmRes = {}
        table.walk(bgmPaths, function (k, val)
            if self.bgmRes[val] == nil or self.bgmRes[val].clip == nil then
                local asset = ResourcesManager:GetInstance():CoLoadAsync(val, typeof(AudioClip))
                local audioSource = self.bgmGo:AddComponent(typeof(AudioSource))
                audioSource.clip = asset
                self.bgmRes[val] = audioSource
            end
            curRes = curRes + 1
            self:UpdateLoading(allRes, curRes)
        end)
    end)
end
return this