local DialogComponent = BaseClass("DialogComponent", Component)
local base = Component
local this = DialogComponent

if StoryMode == nil then
    StoryMode =
    {
        BattleBefore = 1,
        BattleAfter = 2,
        BattleTeach = 3
    }
end

local TitleName = "Title"
local ChooseName = "Choose"
local SpeakerName = "Speaker"
local DialogName = "Dialog"

if TitleType == nil then
    TitleType =
    {
        Id = "Id",
        Scene = "Scene",
        Bgm = "Bgm",
        Se = "Se",
        SpecialEffect = "SpecialEffect",
        ParticleEffect = "ParticleEffect",
        Image = "Image",
        LeftDrawing = "LeftDrawing",
        MiddleDrawing = "MiddleDrawing",
        RightDrawing = "RightDrawing",
        AssistDrawing = "AssistDrawing",
        SpeakDrawing = "SpeakDrawing",
        NextDelay = "NextDelay",
        DialogPicture = "DialogPicture",
        StoryId = "StoryId",
        StoryMode = "StoryMode",
        Title = TitleName,
        Choose = ChooseName,
        Speaker = SpeakerName,
        Dialog = DialogName,
    }
end

local ScenePath = "UI/StoryBg/"
local SceneSuf = ".jpg"

local sePath = "Sound/Story/"
local seSuf = ".mp3"

local bgmPath = "Bgm/Story/"
local bgmSuf = ".mp3"

local effectPath = "UI/Effects/Story/"
local effectSuf = ".prefab"

local cgPath = "UI/StoryCg/"

local drawingPath = "UI/StoryCard/"
local drawingPathSuf = ".png"
local facePath = "UI/StoryFace/"
local facePathSuf = ".png"

local DialogPicturePath = "UI/StoryFace/"
local DialogPictureSuf = ".png"

local z_config = {}

-- 打开剧情模式
-- config为一章的配置  chapter表示该章的第几话
function this.OpenDialog(self, chapterId, storyId, storyMode, callback, battleLast)
    if string.IsNullOrEmpty(storyId) then
        if callback ~= nil then callback() end
        local againstComponent = Game.Scene:GetComponent("AgainstComponent")
        local bgmCom = Game.Scene:GetComponent("BgmComponent")
        if againstComponent.LevelType == LevelType.LevelTypeStory and bgmCom:GetClipName() ~= "Main" then
            coroutine.start(function()
                coroutine.waitforframes(2)
                Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI, "Home")
            end)
        end
        return
    end
    
    -- 综合考虑  多语言因素和代码效率
    local path = "Z_Dialog_"..chapterId
    --if z_config[path] ~= nil then
    --    package.loaded["Config/Excel/"..path] = nil
    --end
    if z_config[path] == nil then
        z_config[path] = require("Config/Excel/"..path) --LangUtil.LangRequire()
    end
    TitleType.Title = TitleName.."_"..LangUtil.GetLangType()
    TitleType.Choose = ChooseName.."_"..LangUtil.GetLangType()
    TitleType.Speaker = SpeakerName.."_"..LangUtil.GetLangType()
    TitleType.Dialog = DialogName.."_"..LangUtil.GetLangType()

    if z_config[path] == nil then print("z_config[path] = nil") return  end 
    
    self.dialogConf = table.filter(z_config[path], function (k, v)
        return v[TitleType.StoryId] ~= tonumber(storyId)
        --return false -- 显示全部话
    end)
    
    self:CheckExcelConfig()
    
    -- 判断剧情之后是否有战斗
    self.battleLast = battleLast
    
    self.dialogConf = table.filter(self.dialogConf, function (k, v)
        return storyMode ~= nil and v[TitleType.StoryMode] ~= tonumber(storyMode)
    end)

    if table.count(self.dialogConf) <= 0 then
        if callback ~= nil then callback() end
        coroutine.start(function()
            coroutine.waitforframes(3)
            Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI, "Home")
        end)
        return
    end
    
    self.waitForClick = 0 -- 点击跳转下一步

    Game.Scene:GetComponent("SoundComponent"):CardStop()
    Game.Scene:GetComponent("BgmComponent"):Stop()
    
    self.callback = callback
    -- 防止编号不连续
    self.steps = table.keys(self.dialogConf)
    table.sort(self.steps, function (a, b) return a < b end)
    self.currentStep = 0

    self.ShowDialog = true
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIDialog)
end

-- 直接播放全部
function this.OpenDialogOnly(self, chapterId, storyId,callback)
    if string.IsNullOrEmpty(storyId) then
        if callback ~= nil then callback() end
        return
    end

    local path = "Z_Dialog_"..chapterId
    --if z_config[path] ~= nil then
    --    package.loaded["Config/Excel/"..path] = nil
    --end
    if z_config[path] == nil then
        z_config[path] = require("Config/Excel/"..path) --LangUtil.LangRequire()
    end
    TitleType.Title = TitleName.."_"..LangUtil.GetLangType()
    TitleType.Choose = ChooseName.."_"..LangUtil.GetLangType()
    TitleType.Speaker = SpeakerName.."_"..LangUtil.GetLangType()
    TitleType.Dialog = DialogName.."_"..LangUtil.GetLangType()

    if z_config[path] == nil then print("z_config[path] = nil") return  end

    self.dialogConf = table.filter(z_config[path], function (k, v)
        return v[TitleType.StoryId] ~= tonumber(storyId)
        --return false
    end)

    if table.count(self.dialogConf) <= 0 then
        return
    end

    self.callback = callback
    self.battleLast = false

    self.waitForClick = 0 -- 点击跳转下一步
    
    Game.Scene:GetComponent("SoundComponent"):CardStop()
    Game.Scene:GetComponent("BgmComponent"):Stop()

    -- 防止编号不连续
    self.steps = table.keys(self.dialogConf)
    table.sort(self.steps, function (a, b) return a < b end)
    self.currentStep = 0

    self.ShowDialog = true
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIDialog)
end

-- 播放完毕
function this.PlayEnd(self)
    if self.callback ~= nil then
        self.callback()
        self.callback = nil
    end

    coroutine.start(function () 
        coroutine.waitforseconds(0.1)
        self.ShowDialog = false
        if not self.battleLast then
            Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI, "Home")
            UIManager:GetInstance():CloseWindow(UIWindowNames.UIDialog)
        end
    end)
end

-- 检查资源配置问题
function this.CheckExcelConfig(self)
    ---- 检查是否配置错误：（有对话或者选择时，不允许自动下一步）
    --table.walk(self.dialogConf, function (k, v)
    --    if not string.IsNullOrEmpty(v[TitleType.Speaker]) or not string.IsNullOrEmpty(v[TitleType.Dialog]) or not string.IsNullOrEmpty(v[TitleType.Choose]) then
    --        if not string.IsNullOrEmpty(v[TitleType.NextDelay]) then
    --            Logger.LogError("有对话或者选择时，不允许自动下一步:"..k)
    --        end
    --    end
    --end)
    ---- 检查是否配置错误：（预加载场景不能自动下一步）
    --table.walk(self.dialogConf, function (k, v)
    --    if v[TitleType.SpecialEffect] == "Scene:Preload" then
    --        if not string.IsNullOrEmpty(v[TitleType.NextDelay]) then
    --            Logger.LogError("预加载场景不能自动下一步:"..k)
    --        end
    --    end
    --end)
    ---- 检查是否配置错误：（是否存在没有配置哪一话的）
    --table.walk(self.dialogConf, function (k, v)
    --    local val1 = v[TitleType.StoryId]
    --    local val2 = v[TitleType.StoryMode]
    --    if val1 <= 0 or val2 <= 0 then
    --        Logger.LogError("是否存在没有配置哪一话的:"..k)
    --    end
    --end)
    ---- 检查是否配置错误：（沒有對話內容）
    --table.walk(self.dialogConf, function (k, v)
    --    local val1 = v[TitleType.Speaker]
    --    local val2 = v[TitleType.Dialog]
    --    if not string.IsNullOrEmpty(val1) and string.IsNullOrEmpty(val2) then
    --        Logger.LogError("沒有對話內容:"..k)
    --    end
    --end)
    ---- 检查是否配置错误：（没有配置编号）
    --table.walk(self.dialogConf, function (k, v)
    --    if string.IsNullOrEmpty(tostring(v[TitleType.Id])) then
    --        Logger.LogError("没有配置编号:"..k)
    --    end
    --end)
    ---- 检查是否配置错误：（音效播放时间）
    --table.walk(self.dialogConf, function (k, v)
    --    if not string.IsNullOrEmpty(tostring(v[TitleType.Se])) then
    --        local seConfig = string.split(v[TitleType.Se], ";")
    --        local playAudios = {}
    --        for i = 1, #seConfig do
    --            local splits = string.split(seConfig[i], ":")
    --            local times = 1
    --            if string.IsNullOrEmpty(splits[2]) then
    --                times = 1
    --            elseif string.lower(splits[2]) == "loop" then
    --                times = "loop"
    --            else
    --                times = tonumber(splits[2])
    --            end
    --            playAudios[sePath..splits[1]..seSuf] = times
    --        end
    --        table.walk(playAudios, function (key, val)
    --            coroutine.start(function()
    --                local asset = ResourcesManager:GetInstance():CoLoadAsync(key, typeof(AudioClip))
    --                if asset == nil then
    --                    Logger.LogError(key)
    --                end
    --                if not string.IsNullOrEmpty(v[TitleType.NextDelay]) then
    --                    local num = tonumber(v[TitleType.NextDelay])
    --                    if asset.length > num then
    --                        Logger.LogError(k..":"..key..":".."("..asset.length..","..num..")")
    --                    end
    --                end
    --            end)
    --        end)
    --    end
    --end)
end
-- 按顺序执行
function this.PlayNextStep(self)
    self.currentStep = self.currentStep + 1
    self:PlayStep()
end

-- 跳转执行
function this.JumpNextStep(self, id)
    table.walk(self.steps, function (k, v)
        if v == tonumber(id) then self.currentStep = k end
    end)
    self:PlayStep()
end

-- 执行
function this.PlayStep(self)

    -- 播完收工
    if self.currentStep > #self.steps then
        self:PlayEnd()
        return
    end

    local key = self.steps[self.currentStep]
    local step = self.dialogConf[key]

    UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:OnChangeStep(key)

    -- 自动下一步或跳转, 如果是0秒 则只是跳转，下面无需执行
    if self:AutoNextStep(step) then
        return
    end

    -- 切换场景 显示标题的时候预加载所有场景
    self:ChangeScene(step)
    Logger.Log("-----------==========----------" .. step.Id)
    -- 播放Bgm
    self:ChangeBgm(step)

    -- 播放Se
    self:PlaySoundEffect(step)

    -- 粒子特效
    self:PlayParticleEffect(step)

    -- 播放Cg
    self:ShowCg(step)

    -- 显示立绘
    self:ShowDrawing(step)

    -- 以下同级关系，只能三选一
    -- 判断是不是标题
    if not string.IsNullOrEmpty(step[TitleType.Title]) then
        self:ShowTitle(step)
    elseif not string.IsNullOrEmpty(step[TitleType.Choose]) then
        self:ChangeChoose(step)
    elseif not string.IsNullOrEmpty(step[TitleType.Dialog]) then
        self:ChangeDialog(step)
    else
        UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:HideContent()
    end
    
    -- 特殊效果
    self:SpecialEffect(step)
end

-- 自动下一步
function this.AutoNextStep(self, step)
    if not string.IsNullOrEmpty(step[TitleType.NextDelay]) then
        local splits = string.split(step[TitleType.NextDelay], ":") -- 前面是延时，后面是跳转行
        local time = tonumber(splits[1])
        if time < 0 then
            coroutine.start(function () 
                coroutine.waitforendofframe()
                self.waitForClick = time
            end)
            return false
        end
        coroutine.start(function ()
            local delay = time + 0.1
            coroutine.waitforseconds(delay)
            if splits[2] == nil or string.lower(splits[2]) == "default" then
                self:PlayNextStep()
            else
                self:JumpNextStep(tonumber(splits[2]))
            end
        end)
        return tonumber(splits[1]) == 0
    end
    return false
end

-- 

-- 切换场景
function this.ChangeScene(self, step)
    if string.IsNullOrEmpty(step[TitleType.Scene]) then
        return
    end
    local splits = string.split(step[TitleType.Scene], ":")
    local sceneName = DialogMapping.Scene[splits[1]] or splits[1]
    UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:ChangeScene(ScenePath..sceneName..SceneSuf, splits[2])
end

function this.Preload(self)
    local scenePaths = {}
    local headPaths = {}
    local drawingPaths = {}
    local audioPaths = {}
    local bgmPaths = {}
    table.walk(self.dialogConf, function (k, val)
        if not string.IsNullOrEmpty(val[TitleType.Title]) then return end
        if not string.IsNullOrEmpty(val[TitleType.Scene]) then
            local splits = string.split(val[TitleType.Scene], ":")
            local sceneName = DialogMapping.Scene[splits[1]] or splits[1]
            local path = ScenePath..sceneName..SceneSuf
            if not table.any(scenePaths, function (v) return v == path end) then
                table.insert(scenePaths, path)
            end
        end
        if not string.IsNullOrEmpty(val[TitleType.DialogPicture]) then
            local faceName = val[TitleType.DialogPicture]
            local path = DialogPicturePath..faceName..DialogPictureSuf
            if not table.any(headPaths, function (v) return v == path end) then
                table.insert(headPaths, path)
            end
        end
        if not string.IsNullOrEmpty(val[TitleType.LeftDrawing]) then
            local splits = string.split(val[TitleType.LeftDrawing], ":")
            local drawPath = drawingPath..splits[1]..drawingPathSuf
            if not table.any(drawingPaths, function (v) return v == drawPath end) then
                table.insert(drawingPaths, drawPath)
            end
            if splits[2] ~= nil then
                local name = splits[2]
                local path = DialogPicturePath..name..DialogPictureSuf
                if not table.any(headPaths, function (v) return v == path end) then
                    table.insert(headPaths, path)
                end
            end
        end
        if not string.IsNullOrEmpty(val[TitleType.MiddleDrawing]) then
            local splits = string.split(val[TitleType.MiddleDrawing], ":")
            local drawPath = drawingPath..splits[1]..drawingPathSuf
            if not table.any(drawingPaths, function (v) return v == drawPath end) then
                table.insert(drawingPaths, drawPath)
            end
            if splits[2] ~= nil then
                local name = splits[2]
                local path = DialogPicturePath..name..DialogPictureSuf
                if not table.any(headPaths, function (v) return v == path end) then
                    table.insert(headPaths, path)
                end
            end
        end
        if not string.IsNullOrEmpty(val[TitleType.RightDrawing]) then
            local splits = string.split(val[TitleType.RightDrawing], ":")
            local drawPath = drawingPath..splits[1]..drawingPathSuf
            if not table.any(drawingPaths, function (v) return v == drawPath end) then
                table.insert(drawingPaths, drawPath)
            end
            if splits[2] ~= nil then
                local name = splits[2]
                local path = DialogPicturePath..name..DialogPictureSuf
                if not table.any(headPaths, function (v) return v == path end) then
                    table.insert(headPaths, path)
                end
            end
        end
        if not string.IsNullOrEmpty(val[TitleType.AssistDrawing]) then
            local splits = string.split(val[TitleType.AssistDrawing], ":")
            local drawPath = drawingPath..splits[1]..drawingPathSuf
            if not table.any(drawingPaths, function (v) return v == drawPath end) then
                table.insert(drawingPaths, drawPath)
            end
            if splits[2] ~= nil then
                local name = splits[2]
                local path = DialogPicturePath..name..DialogPictureSuf
                if not table.any(headPaths, function (v) return v == path end) then
                    table.insert(headPaths, path)
                end
            end
        end
        if not string.IsNullOrEmpty(val[TitleType.Se]) then
            local seConfig = string.split(val[TitleType.Se], ";")
            for i = 1, #seConfig do
                local splits = string.split(seConfig[i], ":")
                local audioName = DialogMapping.Audio[splits[1]] or splits[1]
                local audioPath = sePath..audioName..seSuf
                if not table.any(audioPaths, function (v) return v == audioPath end) then
                    table.insert(audioPaths, audioPath)
                end
            end
        end
        if not string.IsNullOrEmpty(val[TitleType.SpecialEffect]) then
            local splits = string.split(val[TitleType.SpecialEffect], ";")
            for i = 1, #splits do
                local operation = string.split(splits[i], ":")
                if operation[2] == nil then
                    return
                end
                local title, args = operation[1], string.split(operation[2], ",")
                local funcName, arg1, arg2, arg3, arg4 = args[1], args[2], args[3], args[4], args[5]
                if title == TitleType.Se then
                    if funcName == "PlayEffect" then
                        local audioName = DialogMapping.Audio[arg1] or arg1
                        local audioPath = sePath..audioName..seSuf
                        if not table.any(audioPaths, function (v) return v == audioPath end) then
                            table.insert(audioPaths, audioPath)
                        end
                    end
                end
            end
        end
        if not string.IsNullOrEmpty(val[TitleType.Bgm]) then
            local bgmFullPath = bgmPath..val[TitleType.Bgm]..bgmSuf
            if not table.any(bgmPaths, function (v) return v == bgmFullPath end) then
                table.insert(bgmPaths, bgmFullPath)
            end
        end
    end)
    UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:PreloadScene(scenePaths, headPaths, drawingPaths, audioPaths, bgmPaths)
end

-- 切换BGM
function this.ChangeBgm(self, step)
    if string.IsNullOrEmpty(step[TitleType.Bgm]) then
        UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:PlayBgm()
        return
    end
    local bgmFullPath = bgmPath..step[TitleType.Bgm]..bgmSuf
    UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:PlayBgm(step[TitleType.Bgm], bgmFullPath)
end

-- 播放音效
function this.PlaySoundEffect(self, step)
    if string.IsNullOrEmpty(step[TitleType.Se]) then
        UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:PlayAudioSource()
        return
    end

    local seConfig = string.split(step[TitleType.Se], ";")
    local playAudios = {}
    for i = 1, #seConfig do
        local splits = string.split(seConfig[i], ":")
        local times = 1
        if string.IsNullOrEmpty(splits[2]) then
            times = 1
        elseif string.lower(splits[2]) == "loop" then
            times = "loop"
        else
            times = tonumber(splits[2])
        end
        local audioName = DialogMapping.Audio[splits[1]] or splits[1]
        playAudios[sePath..audioName..seSuf] = times
    end
    UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:PlayAudioSource(playAudios)
end

function this.PlayParticleEffect(self, step)
    if string.IsNullOrEmpty(step[TitleType.ParticleEffect]) then
        return
    end
    local peConfig = string.split(step[TitleType.ParticleEffect], ";")
    for i = 1, #peConfig do
        local splits = string.split(peConfig[i], ",")
        UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:PlayParticleEffect(effectPath..splits[1]..effectSuf, splits[2])
    end
end

-- 播放Cg
function this.ShowCg(self, step)
    local splits = string.split(step[TitleType.Image], ":")
    local cgName = DialogMapping.CG[splits[1]] or splits[1]
    local path = cgPath..cgName
    if string.IsNullOrEmpty(cgName) then
        path = nil
    end
    UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:ShowCg(path, splits[2])
end

-- 显示立绘
function this.ShowDrawing(self, step)
    local speakDrawing = {}
    if not string.IsNullOrEmpty(step[TitleType.SpeakDrawing]) then
        local splits = string.split(step[TitleType.SpeakDrawing], ",")
        table.walk(splits, function (k, v)
            if v == "0" then
                table.insert(speakDrawing, TitleType.LeftDrawing)
            elseif v == "1" then
                table.insert(speakDrawing, TitleType.MiddleDrawing)
            elseif v == "2" then
                table.insert(speakDrawing, TitleType.RightDrawing)
            elseif v == "3" then
                table.insert(speakDrawing, TitleType.AssistDrawing)
            end
        end)
    end
    
    if string.IsNullOrEmpty(step[TitleType.LeftDrawing]) then
        UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:ShowDrawing(TitleType.LeftDrawing)
    else
        local splits = string.split(step[TitleType.LeftDrawing], ":")
        local faceFullPath
        if splits[2] == nil then
            faceFullPath = nil
        else
            local name = splits[2]
            faceFullPath = facePath..name..facePathSuf
        end
        UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:ShowDrawing(TitleType.LeftDrawing, drawingPath..splits[1]..drawingPathSuf, splits[1], faceFullPath, speakDrawing)
    end
    
    if string.IsNullOrEmpty(step[TitleType.MiddleDrawing]) then
        UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:ShowDrawing(TitleType.MiddleDrawing)
    else
        local splits = string.split(step[TitleType.MiddleDrawing], ":")
        local faceFullPath
        if splits[2] == nil then
            faceFullPath = nil
        else
            local name = splits[2]
            faceFullPath = facePath..name..facePathSuf
        end
        UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:ShowDrawing(TitleType.MiddleDrawing, drawingPath..splits[1]..drawingPathSuf, splits[1], faceFullPath, speakDrawing)
    end
    
    if string.IsNullOrEmpty(step[TitleType.RightDrawing]) then
        UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:ShowDrawing(TitleType.RightDrawing)
    else
        local splits = string.split(step[TitleType.RightDrawing], ":")
        local faceFullPath
        if splits[2] == nil then
            faceFullPath = nil
        else
            local name = splits[2]
            faceFullPath = facePath..name..facePathSuf
        end
        UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:ShowDrawing(TitleType.RightDrawing, drawingPath..splits[1]..drawingPathSuf, splits[1], faceFullPath, speakDrawing)
    end

    if string.IsNullOrEmpty(step[TitleType.AssistDrawing]) then
        UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:ShowDrawing(TitleType.AssistDrawing)
    else
        local splits = string.split(step[TitleType.AssistDrawing], ":")
        local faceFullPath
        if splits[2] == nil then
            faceFullPath = nil
        else
            local name = splits[2]
            faceFullPath = facePath..name..facePathSuf
        end
        UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:ShowDrawing(TitleType.AssistDrawing, drawingPath..splits[1]..drawingPathSuf, splits[1], faceFullPath, speakDrawing)
    end
end

-- 显示标题
function this.ShowTitle(self, step)
    UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:ShowTitle(step[TitleType.StoryId], step[TitleType.Title])
end

-- 显示选择
function this.ChangeChoose(self, step)
    local chooses = string.split(step[TitleType.Choose], ";")
    if #chooses <= 0 then
        Logger.LogError("choose is empty")
        return
    end

    local activeChooses = {}
    local activeJumps = {}
    for i = 1, #chooses do
        local splits = string.split(chooses[i], ":")
        local id = splits[2]
        local nextId = (string.IsNullOrEmpty(id) or string.lower(id) == "default") and self.steps[self.currentStep + 1] or id
        if not table.contains(table.values(self.steps), tonumber(nextId)) then
            Logger.LogError("cannot find JumpStep："..nextId)
            return
        end
        activeChooses[i] = splits[1]
        activeJumps[i] = nextId
    end

    UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:ChangeChoose(activeChooses, activeJumps)
end

-- 播放对话
function this.ChangeDialog(self, step)
    local name = step[TitleType.DialogPicture]
    local path = DialogPicturePath..name..DialogPictureSuf
    if step[TitleType.DialogPicture] == nil or string.IsNullOrEmpty(step[TitleType.DialogPicture]) then
        path = nil
    end
    UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:ChangeDialog(step[TitleType.Speaker], step[TitleType.Dialog], path)
end

function this.SpecialEffect(self, step)
    if string.IsNullOrEmpty(step[TitleType.SpecialEffect]) then
        return
    end
    local splits = string.split(step[TitleType.SpecialEffect], ";")
    for i = 1, #splits do
        local operation = string.split(splits[i], ":")
        if operation[2] == nil then
            Logger.LogError("error"..step[TitleType.Id])
            return
        end
        local title, args = operation[1], string.split(operation[2], ",")
        local funcName, arg1, arg2, arg3, arg4 = args[1], args[2], args[3], args[4], args[5]
        if title == TitleType.Scene then
            if funcName == "Preload" then
                self:Preload()
            elseif funcName == "Shake" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneShake(arg1, arg2, arg3)
            elseif funcName == "RemoveShake" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneRemoveShake(arg1, arg2, arg3)
            elseif funcName == "Scale" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneScale(arg1, arg2, arg3)
            elseif funcName == "MoveX" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneMoveX(arg1, arg2, arg3)
            elseif funcName == "MoveY" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneMoveY(arg1, arg2, arg3)
            elseif funcName == "Blur" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneBlur(arg1, arg2, arg3)
            elseif funcName == "RadialBlur" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneRadialBlur(arg1, arg2, arg3)
            elseif funcName == "RemoveBlur" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneRemoveBlur(arg1, arg2, arg3)
            elseif funcName == "Grey" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneGrey(arg1, arg2, arg3)
            elseif funcName == "RemoveGrey" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneRemoveGrey(arg1, arg2, arg3)
            elseif funcName == "Blink" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneBlink(arg1, arg2, arg3)
            elseif funcName == "BlinkOpen" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneBlinkOpen(arg1, arg2, arg3)
            elseif funcName == "Ice" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneIce(arg1, arg2, arg3)
            elseif funcName == "WaveEffect" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SceneWaveEffect(arg1, arg2, arg3)
            end
        elseif title == TitleType.LeftDrawing or title == TitleType.MiddleDrawing or title == TitleType.RightDrawing or title == TitleType.AssistDrawing then
            if funcName == "MoveX" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingMoveX(title, arg1, arg2, arg3)
            elseif funcName == "MoveY" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingMoveY(title, arg1, arg2, arg3)
            elseif funcName == "Shake" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingShake(title, arg1, arg2, arg3)
            elseif funcName == "Scale" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingScale(title, arg1, arg2, arg3)
            elseif funcName == "ScaleX" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingScaleX(title, arg1, arg2, arg3)
            elseif funcName == "Grey" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingGrey(title, arg1, arg2, arg3)
            elseif funcName == "Petrifaction" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingPetrifaction(title, arg1, arg2, arg3)
            elseif funcName == "Fade" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingFade(title, arg1, arg2, arg3)
            elseif funcName == "Black" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingBlack(title, arg1, arg2, arg3)
            elseif funcName == "White" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingWhite(title, arg1, arg2, arg3)
            elseif funcName == "SetAsFirstSibling" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:SetAsFirstSibling(title, arg1, arg2, arg3)
            elseif funcName == "RemoveShake" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:RemoveDrawingShake(title, arg1, arg2, arg3)
            elseif funcName == "Particle" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingParticle(title, effectPath..arg1..effectSuf, arg2, arg3)
            elseif funcName == "Ice" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingIce(title, arg1, arg2, arg3)
            elseif funcName == "RemoveMaterial" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingRemoveMaterial(title, arg1, arg2, arg3)
            elseif funcName == "SonPicture" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DrawingRemoveMaterial(title, arg1, arg2, arg3)
            end
        elseif title == TitleType.Dialog then
            if funcName == "FontSize" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:FontSize(arg1, arg2, arg3)
            elseif funcName == "Shake" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DialogShake(arg1, arg2, arg3)
            end
        elseif title == TitleType.Se then
            if funcName == "PlayEffect" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:PlayEffect(sePath..DialogMapping.Audio[arg1]..seSuf, arg2, arg3)
            end
        elseif title == TitleType.DialogPicture then
            if funcName == "Green" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DialogPictureGreen()
            elseif funcName == "RemoveColor" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:DialogPictureRemoveColor()
            end
        elseif title == TitleType.ParticleEffect then
            if funcName == "Particle" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:PlayParticle(effectPath..arg1..effectSuf, arg2, arg3, arg4)
            elseif funcName == "StopLoop" then
                UIManager:GetInstance():GetWindow(UIWindowNames.UIDialog).View:StopLoop(effectPath..arg1..effectSuf)
            end
        end
    end
end

function this.Dispose(self)
    base.Dispose(self)
end

return this