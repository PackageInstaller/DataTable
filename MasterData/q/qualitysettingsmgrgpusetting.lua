local function extend(QualitySettingsMgr)

local gpu_adreno = {
    ["825"] = 291,
    ["750"] = 548,
    ["740"] = 552,
    ["725"] = 558,
    ["722"] = 562,
    ["735"] = 565,
    ["732"] = 568,
    ["730"] = 569,
    ["720"] = 572,
    ["660"] = 591,
    ["650"] = 610,
    ["810"] = 799,
    ["644"] = 801,
    ["643"] = 802,
    ["642"] = 803,
    ["642L"] = 806,
    ["710"] = 807,
    ["640"] = 808,
    ["630"] = 810,
    ["540"] = 816,
    ["530"] = 861,
    ["430"] = 919,
    ["420"] = 991,
    ["620"] = 992,
    ["418"] = 1015,
    ["619"] = 1016,
    ["619L"] = 1017,
    ["618"] = 1018,
    ["616"] = 1022,
    ["613"] = 1100,
    ["612"] = 1101,
    ["610"] = 1102,
    ["512"] = 1103,
    ["510"] = 1104,
    ["330"] = 1105,
    ["509"] = 1151,
    ["508"] = 1152,
    ["506"] = 1153,
    ["505"] = 1155,
    ["504"] = 1156,
    ["405"] = 1174,
    ["320"] = 1204,
    ["308"] = 1236,
    ["306"] = 1237,
    ["305"] = 1238,
    ["304"] = 1239,
    ["302"] = 1242,
    ["225"] = 1250,
    ["220"] = 1255,
    ["205"] = 1263,
    ["203"] = 1264,
    ["200"] = 1270,
}

-- ====================== 3. ARM Mali（精简型号key）
-- ====================== Mali G 系列 (G开头)
local gpu_mali_g = {
    ["G720 MP12"] = 553,
    ["G715 MP11"] = 554,
    ["G720 MP8"] = 563,
    ["G720 MP7"] = 564,
    ["G715 MP7"] = 570,
    ["G615 MP6"] = 571,
    ["G710 MP10"] = 573,
    ["G78 MP24"] = 592,
    ["G710 MP7"] = 593,
    ["G78 MP22"] = 594,
    ["G78 MP20"] = 611,
    ["G78 MP14"] = 612,
    ["G77 MP11"] = 792,
    ["G77 MP9"] = 795,
    ["G76 MP16"] = 796,
    ["G610 MP6"] = 797,
    ["G610 MP4"] = 798,
    ["G610 MP3"] = 804,
    ["G615 MP2"] = 805,
    ["G76 MP12"] = 811,
    ["G76 MP10"] = 812,
    ["G68 MP5"] = 813,
    ["G57 MP6"] = 814,
    ["G57 MP5"] = 815,
    ["G72 MP18"] = 817,
    ["G71 MP20"] = 818,
    ["G72 MP12"] = 819,
    ["G71 MP8"] = 820,
    ["G76 MP4"] = 866,
    ["G71 MP2"] = 916,
    ["G72 MP3"] = 940,
    ["G68 MP4"] = 942,
    ["G52 MP6"] = 944,
    ["G68 MP2"] = 945,
    ["G52 MP2"] = 946,
    ["G52 MP1"] = 947,
    ["G57 MP4"] = 994,
    ["G57 MP3"] = 995,
    ["G57 MP2"] = 1019,
    ["G57 MP1"] = 1020,
    ["G51 MP4"] = 1024,
}

-- ====================== Mali T 系列 (T开头)
local gpu_mali_t = {
    ["T880 MP12"] = 865,
    ["T760 MP8"] = 915,
    ["T880 MP4"] = 943,
    ["T760 MP6"] = 979,
    ["T880 MP2"] = 980,
    ["T628 MP6"] = 1110,
    ["T760 MP4"] = 1111,
    ["T628 MP4"] = 1150,
    ["T860 MP2"] = 1160,
    ["T830 MP3"] = 1161,
    ["T604 MP4"] = 1167,
    ["T830 MP2"] = 1175,
    ["T624"] = 1203,
    ["T760 MP2"] = 1205,
    ["T720 MP4"] = 1209,
    ["T830 MP1"] = 1211,
    ["T720 MP2"] = 1234,
    ["T720"] = 1240,
}

-- ====================== 4. Samsung Xclipse（仅型号后缀key）
local gpu_samsung = {
    ["950"] = 550,
    ["940"] = 551,
    ["920"] = 590,
    ["540"] = 793,
    ["530"] = 794,
}

-- ====================== 5. PowerVR（仅保留型号key）
local gpu_pvr = {
    ["GM9446"] = 860,
    ["GXA6850"] = 862,
    ["GX6450"] = 990,
    ["G6430"] = 1106,
    ["GX6250"] = 1107,
    ["G6400"] = 1108,
    ["SGX554MP4"] = 1149,
    ["GE8322"] = 1154,
    ["G6200"] = 1173,
    ["SGX543MP4"] = 1202,
    ["GE8320"] = 1206,
    ["GE8300"] = 1207,
    ["GE8100"] = 1208,
    ["SGX543MP3"] = 1219,
    ["SGX543MP2"] = 1229,
    ["SGX545"] = 1232,
    ["SGX544MP2"] = 1233,
    ["SGX544"] = 1235,
    ["SGX540"] = 1261,
    ["SGX535"] = 1267,
    ["SGX531"] = 1268,
    ["SGX530"] = 1269,
}

    -- graphicsDeviceName 精确匹配分数表（分数越高性能越好）
    local gpu_scores = {
    -- 第一部分
    ["Mali G1-Ultra MP12"] = 306.5,
    ["Adreno (TM) 840"] = 305.9,
    ["Immortalis-G925 MP16"] = 273.3,
    ["Immortalis-G925 MP12"] = 261.6,
    ["Adreno (TM) 830"] = 259,
    ["Adreno (TM) 829"] = 240,
    ["A19 Pro GPU"] = 232.4,
    ["A19 GPU"] = 212.7,
    ["Adreno (TM) 825"] = 206.5,
    ["Adreno (TM) 750"] = 202,
    ["Immortalis-G720 MP12"] = 192.5,
    ["Xclipse 950"] = 189,
    ["A18 Pro GPU"] = 180.1,
    ["Mali-G720 MP8"] = 163,
    ["Xclipse 940"] = 161,
    ["Immortalis-G720 MP7"] = 153,
    ["A18 GPU"] = 150.7,
    ["Adreno (TM) 740"] = 147.5,
    ["PowerVR DXT-48-1536"] = 138.5,
    ["Adreno (TM) 735"] = 137.6,

    -- 第二部分
    ["Adreno (TM) 732"] = 129.3,
    ["A17 Pro GPU"] = 124.7,
    ["Mali-G615 MP6"] = 124,
    ["Immortalis-G715 MP11"] = 123.5,
    ["A16 GPU"] = 123.1,
    ["A15 GPU"] = 112,
    ["Mali-G715 MP7"] = 108.5,
    ["A16 GPU"] = 104.1,
    ["A15 GPU"] = 104,
    ["Adreno (TM) 730"] = 103,
    ["Mali-G710 MP10"] = 100.6,
    ["A14 Bionic GPU"] = 89,
    ["Adreno (TM) 722"] = 86,
    ["Adreno (TM) 725"] = 83.1,
    ["A13 Bionic GPU"] = 78,
    ["Mali-G710 MP7"] = 71,
    ["Xclipse 550"] = 70,
    ["Adreno (TM) 660"] = 69,
    ["Mali-G610 MP6"] = 68,
    ["Xclipse 920"] = 65,
    ["Mali-G78 MP20"] = 63.5,
    ["Adreno (TM) 720"] = 61.5,

    -- 第三部分
    ["Mali-G78 MP14"] = 60.7,
    ["Xclipse 540"] = 59,
    ["Mali-G77 MP11"] = 56.0,
    ["A12 Bionic GPU"] = 56,
    ["Adreno (TM) 650"] = 55,
    ["Mali-G610 MP4"] = 53.5,
    ["Mali-G77 MP9"] = 52.7,
    ["Adreno (TM) 810"] = 52,
    ["Adreno (TM) 642"] = 50,
    ["Mali-G76 MP16"] = 49.5,
    ["Xclipse 530"] = 49,
    ["Adreno (TM) 644"] = 46,
    ["Mali-G76 MP12"] = 43.8,
    ["Adreno (TM) 640"] = 40.6,
    ["Mali-G615 MP2"] = 39.6,
    ["Adreno (TM) 642L"] = 36.5,
    ["Adreno (TM) 630"] = 35.2,
    ["Mali-G68 MP5"] = 34,
    ["Adreno (TM) 710"] = 33.4,
    ["Mali-G76 MP10"] = 33.2,
    ["Mali-G610 MP3"] = 32,
    ["Mali-G57 MP5"] = 32,

    -- 第四部分
    ["Mali-G72 MP18"] = 31,
    ["PowerVR GT7600 Plus"] = 30,
    ["A11 Bionic GPU"] = 28,
    ["Mali-G68 MP4"] = 27.6,
    ["Adreno (TM) 540"] = 25.6,
    ["Mali-G72 MP12"] = 23,
    ["Mali-G57 MP4"] = 22,
    ["Adreno (TM) 620"] = 21.5,
    ["Mali-G52 MP6"] = 21,
    ["Mali-G71 MP20"] = 20.3,
    ["IMG BXM-8-256"] = 20.1,
    ["Mali-G76 MP4"] = 20.1,
    ["Adreno (TM) 619"] = 20,
    ["Mali-G57 MP3"] = 19.4,
    ["Adreno (TM) 618"] = 18.1,
    ["Adreno (TM) 530"] = 17.7,
    ["Mali-G68 MP2"] = 16,
    ["PowerVR GT7600"] = 15.8,
    ["Mali-T880 MP12"] = 15.7,
    ["Adreno (TM) 619L"] = 15.5,
    ["Mali-G57 MP2"] = 14.8,
    ["Adreno (TM) 616"] = 13.6,
    ["Mali-G52 MP2"] = 12.7,

    -- 第五部分
    ["Adreno (TM) 613"] = 12.0,
    ["Mali-G71 MP8"] = 11.5,
    ["Adreno (TM) 430"] = 11.1,
    ["Mali-T760 MP8"] = 10.5,
    ["Adreno (TM) 612"] = 9.4,
    ["Mali-G52 MP2"] = 9.1,
    ["Adreno (TM) 512"] = 8.6,
    ["Mali-G72 MP3"] = 8.5,
    ["Adreno (TM) 610"] = 8.3,
    ["PowerVR GX6450"] = 7.5,
    ["Mali-T880 MP4"] = 7,
    ["Mali-G51 MP4"] = 6.5,
    ["IMG BXM-4-64"] = 6.3,
    ["Adreno (TM) 420"] = 6.0,
    ["Adreno (TM) 509"] = 5.9,
    ["Mali-G57 MP1"] = 5.6,
    ["Adreno (TM) 418"] = 5.5,
    ["Adreno (TM) 510"] = 5.4,
    ["Adreno (TM) 508"] = 5.3,
    ["Mali-T760 MP6"] = 5.2,
    ["PowerVR G6430"] = 5.1,
    ["Adreno (TM) 330"] = 5.0,

    -- 第六部分
    ["Adreno (TM) 304"] = 4.5,
    ["Adreno (TM) 306"] = 4.4,
    ["Adreno (TM) 305"] = 4.3,
    ["Adreno (TM) 302"] = 4.2,
}

    -- gpu_scores 分数阈值（分数越高性能越好，自行调整）
    -- 参考: VeryHigh ≥150 → Immortalis-G720 MP7(153); High ≥85 → Adreno 722(86); Medium ≥33 → Adreno 710(33.4); Low ≥12 → Adreno 613(12.0)
    local GPU_SCORE_VERY_HIGH = 55
    local GPU_SCORE_HIGH = 46
    local GPU_SCORE_MEDIUM = 33
    local GPU_SCORE_LOW = 12

    -- 分数在GPU A650 左右的
    local VERY_HIGH_Adreno = 650    -- 这里是型号
    local VERY_HIGH_Samsung = 920    -- 这里是型号
    local VERY_HIGH_Mali_G = 78    -- 这里是型号
    -- VERY_HIGH_Adreno
    -- 以下是分数排名
    local VERY_HIGH_RANK = 610  
    local HIGH_RANK = 710
    local M_RANK = 810
    local LOW_RANK = 910


    function QualitySettingsMgr.compareToThreshold(rank)
    
        if rank < VERY_HIGH_RANK then
            return GE.GraphicsQualityType.VeryHigh
        elseif rank < HIGH_RANK then
            return GE.GraphicsQualityType.High
        elseif rank < M_RANK then
            return GE.GraphicsQualityType.Medium
        elseif rank < LOW_RANK then
            return GE.GraphicsQualityType.Low   
        end

        return GE.GraphicsQualityType.High
    end

    function QualitySettingsMgr.compareScoreToQuality(score)
        if score >= GPU_SCORE_VERY_HIGH then
            return GE.GraphicsQualityType.VeryHigh
        elseif score >= GPU_SCORE_HIGH then
            return GE.GraphicsQualityType.High
        elseif score >= GPU_SCORE_MEDIUM then
            return GE.GraphicsQualityType.Medium
        -- elseif score >= GPU_SCORE_LOW then
        --     return GE.GraphicsQualityType.Low
        end

        return GE.GraphicsQualityType.Low
    end

    -- Unity 返回的 graphicsDeviceName 与 gpu_scores key 可能存在前缀差异
    -- 例: "PowerVR D-Series DXT-48-1536" -> "PowerVR DXT-48-1536"
    local function normalizeGraphicsDeviceName(name)
        if not name or name == "" then
            return name
        end
        name = name:gsub("PowerVR D%-Series ", "PowerVR ")
        name = name:gsub("PowerVR B%-Series ", "PowerVR ")
        -- BXM 系列在配置里使用 IMG 前缀
        name = name:gsub("^PowerVR BXM%-", "IMG BXM%-")
        return name
    end

    -- 按前缀在分数表中取最低分（保守估计）
    local function lookupScoreByPrefix(scoreTable, prefix)
        if not prefix then
            return nil, nil
        end
        local minScore = nil
        local matchedKey = nil
        for key, score in pairs(scoreTable) do
            if key:sub(1, #prefix) == prefix then
                if minScore == nil or score < minScore then
                    minScore = score
                    matchedKey = key
                end
            end
        end
        return minScore, matchedKey
    end

    -- 按关键字/token 包含匹配，取最低分
    local function lookupScoreByContains(scoreTable, modelToken, keyFilter)
        if not modelToken then
            return nil, nil
        end
        local minScore = nil
        local matchedKey = nil
        for key, score in pairs(scoreTable) do
            if key:find(modelToken, 1, true) and (keyFilter == nil or keyFilter(key)) then
                if minScore == nil or score < minScore then
                    minScore = score
                    matchedKey = key
                end
            end
        end
        return minScore, matchedKey
    end

    -- 按关键字/token 在 rank 表中匹配，取最高 rank（最保守）
    local function lookupRankByContains(rankTable, modelToken, keyFilter)
        if not modelToken then
            return nil, nil
        end
        local maxRank = nil
        local matchedKey = nil
        for key, rank in pairs(rankTable) do
            if key:find(modelToken, 1, true) and (keyFilter == nil or keyFilter(key)) then
                if maxRank == nil or rank > maxRank then
                    maxRank = rank
                    matchedKey = key
                end
            end
        end
        return maxRank, matchedKey
    end

    local function isPowerVRScoreKey(key)
        return key:find("PowerVR") or key:find("^IMG ")
    end

    -- 从 Mali/Immortalis GPU 名提取型号前缀，只关心 G/T 系列主型号，忽略 MP/MC 等后缀
    -- 例: "Mali-G720-Immortalis MC12" -> "Immortalis-G720"
    -- 例: "Mali-G615 MC2"           -> "Mali-G615"
    -- 例: "Mali-T760 MP8"           -> "Mali-T760"
    local function extractMaliModelPrefix(name)
        if not name or (not name:find("Mali") and not name:find("Immortalis")) then
            return nil
        end
        local gNum = name:match("G(%d+)")
        if gNum then
            if name:find("Immortalis") then
                return "Immortalis-G" .. gNum
            end
            if name:find("Ultra") and gNum == "1" then
                return "Mali G1-Ultra"
            end
            return "Mali-G" .. gNum
        end
        local tNum = name:match("T(%d+)")
        if tNum then
            return "Mali-T" .. tNum
        end
        return nil
    end

    -- 按型号前缀在 gpu_scores 中模糊匹配，同型号取最低分（保守估计）
    local function lookupMaliGpuScore(fullName)
        local prefix = extractMaliModelPrefix(fullName)
        return lookupScoreByPrefix(gpu_scores, prefix)
    end

    -- 非 Mali/Adreno/Apple 的 gpu_scores 模糊匹配规则
    local gpu_fuzzy_score_rules = {
        {
            name = "xclipse",
            match = function(fullName)
                local num = fullName:match("[Xx]clipse%s*(%d+)")
                if num then
                    return lookupScoreByPrefix(gpu_scores, "Xclipse " .. num)
                end
            end,
        },
        {
            name = "powervr",
            match = function(fullName)
                if not fullName:find("PowerVR") and not fullName:find("^IMG ") then
                    return nil, nil
                end
                local tokenPatterns = {
                    "DXT%-[%d%-]+",
                    "BXM%-[%d%-]+",
                    "GT%d+",
                    "GX%d+",
                    "SGX[%w]+",
                    "GE%d+",
                    "G%d%d%d%d",
                }
                local minScore, matchedKey = nil, nil
                for _, pattern in ipairs(tokenPatterns) do
                    local token = fullName:match("(" .. pattern .. ")")
                    if token then
                        local score, key = lookupScoreByContains(gpu_scores, token, isPowerVRScoreKey)
                        if score ~= nil and (minScore == nil or score < minScore) then
                            minScore = score
                            matchedKey = key
                        end
                    end
                end
                return minScore, matchedKey
            end,
        },
    }

    local function lookupGpuScoreFuzzy(fullName)
        local score, matchedKey = lookupMaliGpuScore(fullName)
        if score ~= nil then
            return score, matchedKey, "mali"
        end

        for _, rule in ipairs(gpu_fuzzy_score_rules) do
            score, matchedKey = rule.match(fullName)
            if score ~= nil then
                return score, matchedKey, rule.name
            end
        end

        return nil, nil, nil
    end

    local function lookupXclipseRank(fullName)
        local num = fullName:match("[Xx]clipse%s*(%d+)")
        if num and gpu_samsung[num] ~= nil then
            return gpu_samsung[num], num
        end
        return nil, num
    end

    local function lookupPowerVRRank(fullName)
        if not fullName:find("PowerVR") and not fullName:find("^IMG ") then
            return nil, nil
        end
        local tokenPatterns = {
            "DXT%-[%d%-]+",
            "BXM%-[%d%-]+",
            "GM%d+",
            "GX[%w%d]+",
            "GT%d+",
            "SGX[%w]+",
            "GE%d+",
            "G%d%d%d%d",
        }
        local maxRank, matchedKey = nil, nil
        for _, pattern in ipairs(tokenPatterns) do
            local token = fullName:match("(" .. pattern .. ")")
            if token then
                local rank, key = lookupRankByContains(gpu_pvr, token)
                if rank ~= nil and (maxRank == nil or rank > maxRank) then
                    maxRank = rank
                    matchedKey = key
                end
            end
        end
        return maxRank, matchedKey
    end

    function QualitySettingsMgr.getQualityLevelByGPU(defaultQualityLevel)
        local fullName = normalizeGraphicsDeviceName(UnityEngine.SystemInfo.graphicsDeviceName)
        local systemMemory = UnityEngine.SystemInfo.systemMemorySize
        LuaLogger.ds("gpuName:", fullName)
        LuaLogger.ds("systemMemory:", systemMemory)

        -- 如果是苹果，怎内存超过3.5g，都这只极高，其他都是高
        if fullName:find("Apple") then
            if systemMemory >= 3584 then
                LuaLogger.ds("Apple systemMemory >= 3584 , return VeryHigh")
                return GE.GraphicsQualityType.VeryHigh
            else
                LuaLogger.ds("Apple systemMemory < 3584 , return High")
                return GE.GraphicsQualityType.High
            end
        end

        if fullName:find("Maleoon") then
            LuaLogger.ds("Maleoon , return VeryHigh")
            return GE.GraphicsQualityType.VeryHigh
        end

        local score = gpu_scores[fullName]
        if score == nil then
            local matchType
            local matchedKey
            score, matchedKey, matchType = lookupGpuScoreFuzzy(fullName)
            if score ~= nil then
                LuaLogger.ds("gpu fuzzy match, type:", matchType, "key:", matchedKey, "score:", score)
            end
        end
        if score ~= nil then
            local quality = QualitySettingsMgr.compareScoreToQuality(score)
            LuaLogger.ds("gpu score match, score:", score, "GraphicsQualityLevel:", quality)
            return quality
        end

        if fullName:find("Adreno") then
            local num = fullName:match("%d+$")
            LuaLogger.ds("Adreno num:", num)
            -- 如果有精确匹配则返回排名
            if gpu_adreno[num] ~= nil then
                LuaLogger.ds("Adreno rank:", gpu_adreno[num])
                local quality = QualitySettingsMgr.compareToThreshold(gpu_adreno[num])
                LuaLogger.ds("Adreno GraphicsQualityLevel:", quality)
                return quality
            else
                num = tonumber(num)
                if num > VERY_HIGH_Adreno then
                    LuaLogger.ds("Adreno num > VERY_HIGH_Adreno , return VeryHigh")
                    return GE.GraphicsQualityType.VeryHigh
                else
                    LuaLogger.ds("Adreno num <= VERY_HIGH_Adreno , return Medium")
                    return defaultQualityLevel
                end
            end
        end

        if fullName:find("[Xx]clipse") then
            local rank, num = lookupXclipseRank(fullName)
            LuaLogger.ds("Xclipse num:", num)
            if rank ~= nil then
                LuaLogger.ds("Xclipse rank:", rank)
                local quality = QualitySettingsMgr.compareToThreshold(rank)
                LuaLogger.ds("Xclipse GraphicsQualityLevel:", quality)
                return quality
            else
                num = tonumber(num)
                if num and num > VERY_HIGH_Samsung then
                    LuaLogger.ds("Xclipse num > VERY_HIGH_Samsung , return VeryHigh")
                    return GE.GraphicsQualityType.VeryHigh
                else
                    LuaLogger.ds("Xclipse num <= VERY_HIGH_Samsung , return Medium")
                    return defaultQualityLevel
                end
            end
        end

        -- Mali 系列
        if fullName:find("Mali")then
            if fullName:find("Immortalis") or fullName:find("Ultra") then
                LuaLogger.ds("Mali Immortalis or Ultra , return VeryHigh")
                return GE.GraphicsQualityType.VeryHigh
            end

            local mali = fullName:gsub("^ARM ", "")
                    :gsub("^Mali ", "")

            if mali:find("G") then
                local gNum = mali:match("G(%d+)")
                LuaLogger.ds("Mali G num:", gNum)
                local rank = nil
                for key, value in pairs(gpu_mali_g) do
                    if key:find("^G" .. gNum) then
                        rank = value
                        break
                    end
                end
                if rank ~= nil then
                    LuaLogger.ds("Mali G rank:", rank)
                    local quality = QualitySettingsMgr.compareToThreshold(rank)
                    LuaLogger.ds("Mali G GraphicsQualityLevel:", quality)
                    return quality
                else

                    gNum = tonumber(gNum)
                    if gNum > VERY_HIGH_Mali_G then
                        LuaLogger.ds("Mali G num > VERY_HIGH_Mali_G , return VeryHigh")
                        return GE.GraphicsQualityType.VeryHigh
                    else
                        LuaLogger.ds("Mali G num <= VERY_HIGH_Mali_G , return Medium")
                        return defaultQualityLevel
                    end
                end
            elseif mali:find("T") then
                local tNum = mali:match("T(%d+)")
                LuaLogger.ds("Mali T num:", tNum)
                local rank = nil
                for key, value in pairs(gpu_mali_t) do
                    if key:find("^T" .. tNum) then
                        if rank == nil or value > rank then
                            rank = value
                        end
                    end
                end
                if rank ~= nil then
                    LuaLogger.ds("Mali T rank:", rank)
                    local quality = QualitySettingsMgr.compareToThreshold(rank)
                    LuaLogger.ds("Mali T GraphicsQualityLevel:", quality)
                    return quality
                end
                LuaLogger.ds("Mali T , return Medium")
                return GE.GraphicsQualityType.Medium

            end

        end

        if fullName:find("PowerVR") or fullName:find("^IMG ") then
            local rank, matchedKey = lookupPowerVRRank(fullName)
            if rank ~= nil then
                LuaLogger.ds("PowerVR rank:", rank, "key:", matchedKey)
                local quality = QualitySettingsMgr.compareToThreshold(rank)
                LuaLogger.ds("PowerVR GraphicsQualityLevel:", quality)
                return quality
            end
            LuaLogger.ds("PowerVR , return Medium")
            return GE.GraphicsQualityType.Medium
        end

        LuaLogger.ds("Other GPU , return default")
        return defaultQualityLevel
    end

    function QualitySettingsMgr.getDefaultQualityLevel()
    
        local systemMemory = UnityEngine.SystemInfo.systemMemorySize

        -- 如果内存超过8G，默认返回High
        if systemMemory >= 8192 then
            return GE.GraphicsQualityType.High
        end

        return GE.GraphicsQualityType.Medium
    end

end

return extend