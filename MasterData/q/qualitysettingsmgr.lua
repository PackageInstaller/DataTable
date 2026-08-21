---@class QualitySettingsMgr
local QualitySettingsMgr = class("QualitySettingsMgr", function (...)
    return QualitySettingsManager.Instance
end)

ClassExtend(QualitySettingsMgr, "QualitySettingsMgrGPUSetting")

local cjson = require "cjson"
local SystemInfo = UnityEngine.SystemInfo
local PlayerPrefs = UnityEngine.PlayerPrefs

function QualitySettingsMgr:ctor()
    self.isInitByRecommend = false
    self.isRecorded = false
end

function QualitySettingsMgr:Clear()
end

function QualitySettingsMgr:RecordRecommendedQuality()
    if self.isInitByRecommend and not self.isRecorded then
        --埋点
            local tips = {
            [GE.GraphicsQualityType.Low] = "低",
            [GE.GraphicsQualityType.Medium] = "中",
            [GE.GraphicsQualityType.High] = "高",
            [GE.GraphicsQualityType.VeryHigh] = "超高",
            [GE.GraphicsQualityType.Custom] = "自定义",
        }
        local data = {
            qualityLevel = tips[self.qualitySettingsLevel],
        }
        ClientData:sendDailyLogMessage(data)
        self.isRecorded = true
    end
end

function QualitySettingsMgr:Init()
    self:memoryQualitySettings()
    local recommendedQuality = self:getRecommendedGraphicsQuality()
    LuaLogger.ds("QualitySettingsMgr:Init()",recommendedQuality)
    if not PlayerPrefs then
        LuaLogger.w("QualitySettingsMgr:Init() - PlayerPrefs is not available.")
        self.qualitySettingsLevel = recommendedQuality
        self.qualitySettingsData = self:getSettingDataByLevel(self.qualitySettingsLevel)
        self:resetQualitySettings()
		return
	end
    --判断是否初始化过
    local recordedQualityLevel = PlayerPrefs.GetInt(GE.LocalCustomDataKey.QualitySettingsLevel, -1)
    if recordedQualityLevel == -1 then
        self.isInitByRecommend = true
    end
    
    local qualitySettingsLevel = PlayerPrefs.GetInt(GE.LocalCustomDataKey.QualitySettingsLevel, recommendedQuality)
    if type(qualitySettingsLevel) ~= "number" or qualitySettingsLevel < GE.GraphicsQualityType.Low or qualitySettingsLevel > GE.GraphicsQualityType.Custom then
        qualitySettingsLevel = recommendedQuality
    end
    self.qualitySettingsLevel = qualitySettingsLevel

    self.qualitySettingsData = self:getSettingDataByLevel(qualitySettingsLevel)
    if not self.qualitySettingsData.waterQuality then
        self.qualitySettingsData.waterQuality = GE.WaterQualityType.Medium
    end
    if not self.qualitySettingsData.sceneOutline then
        self.qualitySettingsData.sceneOutline = 1
    end
    self:resetQualitySettings()
end

function QualitySettingsMgr:resetQualitySettings()
    if not self.qualitySettingsData then
        return
    end

    if not GV.IsEditor then
        --高于设备配置的参数限制
        local currentResolution = self:GetNativeResolution()
        local currentRefreshRate = self:GetCurrentRefreshRate()
        if self.qualitySettingsData.resolution > currentResolution.y then
            self.qualitySettingsData.resolution = GE.ResolutionType.Origin
        end
        if self.qualitySettingsData.frameRate > currentRefreshRate then
            local frameRateValue = currentRefreshRate >= GE.FrameRateType.FPS90 and GE.FrameRateType.FPS90 or
                                (currentRefreshRate >= GE.FrameRateType.FPS60 and GE.FrameRateType.FPS60 or
                                GE.FrameRateType.FPS30)
            self.qualitySettingsData.frameRate = frameRateValue
        end
    end


    self:SetResolutionLevel(self.qualitySettingsData.renderScale)
    self:SetFrameRate(self.qualitySettingsData.frameRate)
    self:SetAntiAliasing(self.qualitySettingsData.antiAliasing == 1)
    self:SetShadowResolution(self.qualitySettingsData.shadowResolution)
    self:SetTextureQuality(self.qualitySettingsData.textureQuality)
    self:SetPostProcessing(self.qualitySettingsData.postProcessing == 1)
    self:SetSceneOutline(self.qualitySettingsData.sceneOutline == 1)
    self:SetWaterQuality(self.qualitySettingsData.waterQuality)
end

function QualitySettingsMgr:changeSettingLevel(level)
    self.qualitySettingsLevel = level
    self.qualitySettingsData = self:getSettingDataByLevel(level)
    PlayerPrefs.SetInt(GE.LocalCustomDataKey.QualitySettingsLevel, self.qualitySettingsLevel)
    self:resetQualitySettings()
end

function QualitySettingsMgr:changeSettingData(name, value)
    if not self.qualitySettingsData then
        self.qualitySettingsData = {}
    end

    if type(name) ~= "string" or not value then
        LuaLogger.w("QualitySettingsMgr:changeSetting() - name is nil or empty.")
        return
    end

    if self.qualitySettingsLevel ~= GE.GraphicsQualityType.Custom then
        self.qualitySettingsLevel = GE.GraphicsQualityType.Custom
    end

    self.qualitySettingsData[name] = value

    -- 保存到PlayerPrefs
    PlayerPrefs.SetInt(GE.LocalCustomDataKey.QualitySettingsLevel, self.qualitySettingsLevel)
    local qualitySettingsDataStr = cjson.encode(self.qualitySettingsData)
    PlayerPrefs.SetString(GE.LocalCustomDataKey.QualitySettingsData, qualitySettingsDataStr)
end

function QualitySettingsMgr:getSettingDataByLevel(level)
    local data = {}
    if level == GE.GraphicsQualityType.Low then --低
        data = {
            renderScale = GE.RenderScaleType.VeryLow,
            frameRate = GE.FrameRateType.FPS30,
            resolution = GE.ResolutionType.HD,
            antiAliasing = 0,
            shadowResolution = GE.ShadowResolution.None,
            textureQuality = GE.TextureQualityType.Low,
            postProcessing = 0,
            waterQuality = 0,
            sceneOutline = 0
        }
    elseif level == GE.GraphicsQualityType.Medium then --中
        data = {
            renderScale = GE.RenderScaleType.Medium,
            frameRate = GE.FrameRateType.FPS30,
            resolution = GE.ResolutionType.FHD,
            antiAliasing = 1,
            shadowResolution = GE.ShadowResolution.Medium,
            textureQuality = GE.TextureQualityType.Medium,
            postProcessing = 1,
            waterQuality = 0,
            sceneOutline = 1
        }
    elseif level == GE.GraphicsQualityType.High then --高
        data = {
            renderScale = GE.RenderScaleType.High,
            frameRate = GE.FrameRateType.FPS30,
            resolution = GE.ResolutionType.FHD,
            antiAliasing = 1,
            shadowResolution = GE.ShadowResolution.High,
            textureQuality = GE.TextureQualityType.High,
            postProcessing = 1,
            waterQuality = 2,
            sceneOutline = 1
        }
    elseif level == GE.GraphicsQualityType.VeryHigh then --极高
        data = {
            renderScale = GE.RenderScaleType.VeryHigh,
            frameRate = GE.FrameRateType.FPS30,
            resolution = GE.ResolutionType.Origin,
            antiAliasing = 1,
            shadowResolution = GE.ShadowResolution.VeryHigh,
            textureQuality = GE.TextureQualityType.High,
            postProcessing = 1,
            waterQuality = 2,
            sceneOutline = 1
        }
    else --自定义
        local qualitySettingsData = PlayerPrefs.GetString(GE.LocalCustomDataKey.QualitySettingsData, "")
        if qualitySettingsData then
            if qualitySettingsData ~= "" then
                data = cjson.decode(qualitySettingsData)
            end
        end

        if not next(data) then
            data = {
                renderScale = GE.RenderScaleType.Medium,
                frameRate = GE.FrameRateType.FPS30,
                resolution = GE.ResolutionType.FHD,
                antiAliasing = 1,
                shadowResolution = GE.ShadowResolution.Medium,
                textureQuality = GE.TextureQualityType.Medium,
                postProcessing = 1,
                waterQuality = 1,
                sceneOutline = 1
            }
        end
    end
    return data
end

function QualitySettingsMgr:getQualityData()
    return self.qualitySettingsData
end

function QualitySettingsMgr:getQualityLevel()
    return self.qualitySettingsLevel
end

function QualitySettingsMgr:memoryQualitySettings()
    local systemMemory = SystemInfo.systemMemorySize
    -- 如果内存大于等于4.5GB，允许UI缓存，以及YooAsset缓存
    if systemMemory >= (4.5 * 1024) then
        UIMgr.autoRemoveWhenClose=false
        LuaMgr.Instance:UseYooAssetExperimental(false)
    else
        UIMgr.autoRemoveWhenClose=true
        LuaMgr.Instance:UseYooAssetExperimental(true)
    end
end

-- 获取推荐的移动设备画质等级
function QualitySettingsMgr:getRecommendedGraphicsQuality()
    -- 核心性能指标
    local gpuShaderLevel = SystemInfo.graphicsShaderLevel
    local systemMemory = SystemInfo.systemMemorySize
    local cpuCount = SystemInfo.processorCount
    local gpuName = SystemInfo.graphicsDeviceName:lower()
    LuaLogger.ds("gpuShaderLevel:", gpuShaderLevel, "systemMemory:", systemMemory, "cpuCount:", cpuCount, "gpuName:", gpuName)

    -- 综合性能评分
    -- local score = self:calculateSystemScore(gpuShaderLevel, systemMemory, cpuCount, gpuName);
    -- return self:getQualityFromScore(score);
    -- 根据8g内存，确定一个默认值
    local defaultQualityLevel = QualitySettingsMgr.getDefaultQualityLevel()

    local recommand = QualitySettingsMgr.getQualityLevelByGPU(defaultQualityLevel)

    LuaLogger.ds("recommand GraphicsQualityLevel:", recommand)

    return recommand
end

-- 计算综合性能评分
function QualitySettingsMgr:calculateSystemScore(gpuShaderLevel, systemMemory, cpuCount, gpuName)
    local score = 0

    -- GPU显存评分 (权重最高)
    if (gpuShaderLevel >= 50) then score = score + 4       -- 3GB+ 高端
    elseif (gpuShaderLevel >= 45) then score = score + 3   -- 2GB 中高端
    elseif (gpuShaderLevel >= 35) then score = score + 2   -- 1GB 中端
    else score = score + 1 end                          -- 1GB以下 低端

    -- 系统内存评分
    if (systemMemory >= 8192) then score = score + 3            -- 8GB+
    elseif (systemMemory >= 6144) then score = score + 2        -- 6GB
    elseif (systemMemory >= 4096) then score = score + 1 end    -- 4GB

    -- CPU核心数评分
    if (cpuCount >= 8) then score = score + 2           -- 8核+
    elseif (cpuCount >= 6) then score = score + 1 end   -- 6核

    -- GPU架构加成
    if (self:isHighEndGPU(gpuName)) then score = score + 2
    elseif (self:isMidRangeGPU(gpuName)) then score = score + 1 end

    return score
end

-- 判断是否为高端GPU
function QualitySettingsMgr:isHighEndGPU(gpuName)
    gpuName = gpuName:lower()
    -- Adreno 7系列/650/660
    local isAdreno = gpuName:find("adreno", 1, true)
    local isAdreno7 = isAdreno and (gpuName:find("7", 1, true) or gpuName:find("650", 1, true) or gpuName:find("660", 1, true))

    -- Mali 高端系列：G7xx/G8xx/G9xx/G610/G710/Immortalis
    -- 覆盖近三年(2022-2025)所有高端型号：G78/G610/G710/G720/G820/G925/G925 Immortalis
    local isMali = gpuName:find("mali", 1, true)
    local isMaliG7 = isMali and (
        gpuName:find("g7", 1, true) or      -- 匹配 G7xx系列（G71/G72/G76/G77/G78/G710/G720等）
        gpuName:find("g8", 1, true) or      -- 匹配 G8xx系列（G820等）
        gpuName:find("g9", 1, true) or      -- 匹配 G9xx系列（G925等）
        gpuName:find("g610", 1, true) or    -- G610 (2023) 需要单独匹配（包含g6但属于高端）
        gpuName:find("immortalis", 1, true)  -- Immortalis 系列（G925 Immortalis等）
    )

    -- Apple GPU
    local isAppleGPU = gpuName:find("apple", 1, true) and gpuName:find("gpu", 1, true)

    return isAdreno7 or isMaliG7 or isAppleGPU
end

function QualitySettingsMgr:isMidRangeGPU(gpuName)
    gpuName = gpuName:lower()
    -- Adreno 6系列/5系列
    local isAdreno = gpuName:find("adreno", 1, true)
    local isAdreno6 = isAdreno and (gpuName:find("6", 1, true) or gpuName:find("5", 1, true))

    -- Mali G5系列/G52/G57
    local isMali = gpuName:find("mali", 1, true)
    local isMaliG5 = isMali and (
        gpuName:find("g5", 1, true) or
        gpuName:find("g52", 1, true) or
        gpuName:find("g57", 1, true)
    )

    return isAdreno6 or isMaliG5
end

function QualitySettingsMgr:getQualityFromScore(score)
    LuaLogger.ds("Device Performance Score: " .. score)
    if (score >= 11) then return GE.GraphicsQualityType.VeryHigh         -- 高端设备
    elseif (score >= 9) then return GE.GraphicsQualityType.High         -- 高端设备
    elseif (score >= 6) then return GE.GraphicsQualityType.Medium   -- 中端设备
    else return GE.GraphicsQualityType.Low end                      -- 低端设备
end

function QualitySettingsMgr:SetResolutionLevel(scaleLevel)
    local Screen = UnityEngine.Screen
    -- 1080P
    local resolutionHight = Screen.currentResolution.height
    local ScaleFor3D = 1

    local baseHightOf1080 = UIMgr.MaxResolutionHeight
    if scaleLevel == GE.RenderScaleType.VeryHigh then
        -- 保持设备分辨率
        resolutionHight = baseHightOf1080 * 1
        ScaleFor3D = 1
    elseif scaleLevel == GE.RenderScaleType.High then
        resolutionHight = baseHightOf1080 * 0.9
        ScaleFor3D = 1
    elseif scaleLevel == GE.RenderScaleType.Medium then
        resolutionHight = baseHightOf1080 * 0.9
        ScaleFor3D = (baseHightOf1080 * 0.8) / resolutionHight
    elseif scaleLevel == GE.RenderScaleType.Low then
        resolutionHight = baseHightOf1080 * 0.8
        ScaleFor3D = (baseHightOf1080 * 0.7) / resolutionHight
    elseif scaleLevel == GE.RenderScaleType.VeryLow then
        resolutionHight = baseHightOf1080 * 0.7
        ScaleFor3D = (baseHightOf1080 * 0.6) / resolutionHight
    end

    self:SetRenderScale(ScaleFor3D)
    self:SetResolution(resolutionHight)                   -- 低端设备
end

function QualitySettingsMgr:GetURPRenderScale()
    return self:GetPipelineRenderScale()
end
function QualitySettingsMgr:SetURPRenderScale(scale)
    self:SetPipelineRenderScale(scale)
end

return QualitySettingsMgr