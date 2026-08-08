if GV.IsServer and GF.checkNeedInitHotfixModule("ConfigReload") then
    require "ConfigReload"
end

if not Config or not Config.table then
    Config = {}
    Config.table = {}
end

G.Declare("LocalStrEnum", "LocalizationLanguage")
G.Declare("UILanguageEnum", "LocalizationLanguage")


local tablePath = "../common/table/lua/server/%s.lua"
local function loadTableFromFile(name)
    if not GV.IsServer then
        return RequireDbg(name)
    end

    local filename = string.format(tablePath, name)
    local file = io.open(filename, "r")
    local code = file:read("*a")
    file:close()
    local chunk, err = loadstring(code, filename)
    assert(chunk ~= nil, err)
    return chunk()
end

function Config.loadTableList(tableList, isHotfix)
    local compoundKey = ReloadModule("ConfigGenCompoundKey")
    local changeCfg = ReloadModule("ConfigChangeField")

    for i, v in ipairs(tableList) do
        local tb, err
        if GV.TableShareCenter or GV.TableShareSub then
            if GV.TableShareCenter then
                local ttb = loadTableFromFile(v)
                --local ttb, err = ReloadModule(v)
                if not ttb then
                    LuaLogger.e("Load table %s failed %s", v, tostring(err))
                else
                    changeCfg:changeFieldData(v, ttb)
                    local tempTb = 
                    {
                        source = ttb,
                        compound = compoundKey:genCompoundKey(v, ttb),
                    }
                    GV.sharetable.loadtable(v, tempTb)
                end
            end

            if isHotfix then
                GV.sharetable.update(v)
            else
                tb = GV.sharetable.query(v)
            end

        else
            local ttb, err = ReloadModule(v)
            if not ttb then
                LuaLogger.e("Load table %s failed %s", v, tostring(err))
            else
                changeCfg:changeFieldData(v, ttb)
                tb = 
                {
                    source = ttb,
                    compound = compoundKey:genCompoundKey(v, ttb),
                }
            end
        end

        if tb then
            Config.table[v] = tb
        end
    end

    return true
end

function Config.Load(isHotfix)
    if Config.IsLoaded then
        return Config
    end

    GV.IsCensoredMode = true--临时接入的和谐模式开关，正式版等待具体功能需求

    if GV.IsServer or GV.IsNginx then
        LocalizationLanguage = LocalLanguage.ChineseSimplified
    else
        local language = UnityEngine.Application.systemLanguage
        if language == UnityEngine.SystemLanguage.ChineseTraditional and not GV.GlobalConfig.IsInternalFormal() then
            LocalizationLanguage = LocalLanguage.ChineseTraditional
        else
            LocalizationLanguage = LocalLanguage.ChineseSimplified
        end
        --LocalizationLanguage = LocalLanguage.ChineseTraditional
    end

    local localStrFile = "LocalStrEnum_" .. LocalizationLanguage

    if LocalizationLanguage == LocalLanguage.ChineseSimplified and GV.IsCensoredMode then
        localStrFile = "LocalStrEnum_" .. LocalLanguage.ChineseSimplifiedCensored
    end


    local uiLocalStrFile = "UILanguageKey_" .. LocalizationLanguage

    if LocalizationLanguage == LocalLanguage.ChineseSimplified and GV.IsCensoredMode then
        uiLocalStrFile = "UILanguageKey_" .. LocalLanguage.ChineseSimplifiedCensored
    end

    ---------------------------------------------------------------------------------------------------------------------
    local loadTableNames = {
        "SkillTable", 
        "BuffTable", 
        "CharacterTable",
        "MonsterTable",
        "ChapterTable",
        "ConfigTable",
        "CharacterRestraintTable",
        "PveLevelTable",
        "PveLevelTriggerTable",
        "ItemTable",
        "EffectTable",
        "EffectTriggerTable",
        "EffectTriggerConditionTable",
        "EquipmentTable",
        "EquipLevelTable",
        "MapTerrainTypeTable",
        "SignalTable",
        "TalentTreeTable",
        "TalentTreeStageTable",
        "FilterTable",
        "ConstructionTable",
        "LevelconfigTable",
        "WeaponTable",
        "WeaponEntryTable",
        "MapTable",
        "TaskTable",
        "ActivitySecondaryTable",
        "RandomAwardTable",
        "SiftConditionTable",
        "PveLevelAchieveTable",
        "ActionTable",
        "BattleMapTable",
        "StoryArraryTable",
        "CharacterSkinTable",
        "StoryResourceTable",
        "BannerTable",
        "GachaPoolTable",
        "GachaGuarantTable",
        "GachaTable",
        "MonsterActivationTable",
        "HeadportraitTable",
        "SkillRangeShowTable",
        "HomeMoveTable",
        "HomeMovePointTable",
        "NormalExplainTable",
        "FunctionTabTable",
        "SkipFuncTable",
        "FunctionOpenTable",
        "ConstructionLevelTable",
        "ScriptLinesTable",
        "HomeScreenLinesTable", 
        "LoadingPictureTable",  
        "LoadingTipsTable",
        "WeaponProductionTable",
        "BGMTable",
        "ChapterStarTable",
        "SoundAndEffectTable",
        "TechnologyTreeTable",
        "TechnologyTreePointTable",
        "TechnologyTreeStartTable",
        "TapSoundTable",
        "AffectionTable",
        "AffectionSoundTable",
        "ArchiveTable",
        "RandomNameTable",
        "HomeEventTable",
        "EventTriggerTable",
        "GiftTable",
        "ShopListTable",
        "ShopMerchandiseTable",
        "GuideMainTable",
        "EffectInfoTable",
        "GuideStepTable",
        "DispatchTable",
        "DispatchPointTable",
        "DispatchLineTable",
        "DispatchBattleTable",
        "AiOperateTable",
        "AiSearchAndMoveTable",
        "AiParameterTable",
        "PveExerciseStoreyTable",
        "PveExerciseLevelTable",
        "ActivityTable",
        "HomeTouchTable",
        "InterfaceSoundTable",
        "BulletTable",
        "SkinActionTable",
        "ActionDesignTable",
        "fightTestTable",
        "QuestionnaireTable",
        "HomeWeatherTable",
        "HomeActionTable",
        "HomeActivateTable",
        "HomeResourceTable",
        "ReservedAccountTable",
        "OpenBetaTest01Table",
        "ShopRecommendTable",
        "HomeTouchTopicTable",
        "HomeTouchWordsTable",
        "HomeTouchReplyTable",
        "PassportTable",
        "HomeFightTable",
        "MonthCardTable",
        "SignInTable",
        "SignAwardTable",
        "PveBossBattleTable",
        "PveBossBattleLevelTable",
        "PveBossBattleScoreTable",
        "PveBossBattleEffectTable",
        "PlotTable",
        "PlotChapterTable",
        "HomeTouchConstructionTable",
        "TrialTable",
        "MailTable",

        "PassportMainTable",
		"IntelligenceTable",
        "CoveStoryLineTable",
        "ProsperityTable",
        "ProsperityConstructionTable",
        "WeatherReportTable",
        "SurvivorSkillTable",
        "SurvivorRoleTable",
        "SurvivorItemTable",

    }

    --仅客户端加载的表
    local loadOnlyClientTableNames = {

        --自走棋
        "AutoChessHeroTable",
        "AutoChessSkillTable",
        "AutoChessBulletTable",
        "AutoChessBuffTable",
		"WeatherParameterTable",
        "HomeInteractiveDialogueTable",
    }

    local function loadLocalStrEnum()
        if GV.TableShareCenter or GV.TableShareSub then
            if GV.TableShareCenter then
                LocalStrEnum = loadTableFromFile(localStrFile)
                --LocalStrEnum = ReloadModule(localStrFile)
                ReloadModule "TempLang"
                GV.sharetable.loadtable("LocalStrEnum", LocalStrEnum)
            end

            if isHotfix then
                GV.sharetable.update("LocalStrEnum")
            else
                LocalStrEnum = GV.sharetable.query("LocalStrEnum")
            end

        else
            LocalStrEnum = ReloadModule(localStrFile)
            ReloadModule "TempLang"
        end
        --新增原表
        if not GV.IsServer then
            --编译器模式下提示
            if UnityEngine and UnityEngine.Application.isEditor then
                setmetatable(LocalStrEnum, {__index = function(_, key)
                    if key then
                        return "缺少多语言" .. key
                    else
                        return "缺少多语言 nil"
                    end
                end})
            else
                --外网环境下不提示 改为""
                setmetatable(LocalStrEnum, {__index = function(_, key)
                    return ""
                end})
            end
        end
    end


    local function loadUILocalStrEnum()
        if GV.TableShareCenter or GV.TableShareSub then
            if GV.TableShareCenter then
                UILanguageEnum = loadTableFromFile(uiLocalStrFile)
                --UILanguageEnum = ReloadModule(uiLocalStrFile)
                --ReloadModule "TempLang"
                GV.sharetable.loadtable("UILanguageEnum", UILanguageEnum)
            end

            if isHotfix then
                GV.sharetable.update("UILanguageEnum")
            else
                UILanguageEnum = GV.sharetable.query("UILanguageEnum")
            end

        else
            UILanguageEnum = ReloadModule(uiLocalStrFile)
            --ReloadModule "TempLang"
        end
        --新增原表
        if not GV.IsServer then
            --编译器模式下提示
            if UnityEngine and UnityEngine.Application.isEditor then
                setmetatable(UILanguageEnum, {__index = function(_, key)
                    if key then
                        return "缺少多语言" .. key
                    else
                        return "缺少多语言 nil"
                    end
                end})
            else
                --外网环境下不提示 改为""
                setmetatable(UILanguageEnum, {__index = function(_, key)
                    return ""
                end})
            end
        end
    end

    local function loadUnchangedTable()
        loadLocalStrEnum()
        loadUILocalStrEnum()
        Config.loadTableList(loadTableNames, isHotfix)

        if not GV.IsServer then
            Config.loadTableList(loadOnlyClientTableNames, isHotfix)
        end
    end

    -- local function _forShareTable(name, tb)
    --     local err
    --    if GV.TableShareCenter or GV.TableShareSub then
    --         if GV.TableShareCenter then
    --             GV.sharetable.loadtable(name, tb)
    --         end

    --         if isHotfix then
    --             GV.sharetable.update(name)
    --             GV.sharetable.freeOldVersion(name)
    --         else
    --             Config.table[name] = GV.sharetable.query(name)
    --         end

    --     else
    --         Config.table[name] = tb
    --     end
    -- end

    -- local function _ConfigTimeStrToStamp(name)
    --     local tb = ReloadModule(name)
    --     for k, value in pairs(tb) do
    --         value.startTime = DLuaUtil.ParseConfigTime(value.startTime)
    --         value.endTime = DLuaUtil.ParseConfigTime(value.endTime)
    --     end
    --     _forShareTable(name, tb)
    -- end

    -- local function _ConfigTimeStrToStampClient(name)
    --     local tb = ReloadModule(name)
    --     for k, value in pairs(tb) do
    --         value.startTime = DLuaUtil.ParseConfigTimeClient(value.startTime)
    --         value.endTime = DLuaUtil.ParseConfigTimeClient(value.endTime)
    --     end
    --     _forShareTable(name, tb)
    -- end

    --Config.loadedTable = {}
    --for k, v in pairs(Config.table) do
    --    Config.loadedTable[k] = true
    --end
    ---------------------------------------------------------------------------------------------------------------------

    -- Config.UnitStatusSequence = DLuaUtil.GetEnumInOrder(UnitStatus)

    loadUnchangedTable()

    function Config.GetAllConfig(name)
        if Config.table[name] then
            return Config.table[name].source
        end
        return nil
    end

    function Config.GetAllCompoundData(name)
        if Config.table[name] then
            return Config.table[name].compound
        end
        return nil
    end

    function Config.GetCompoundInfoByKey(data, ...)
        local args = {...}
        if #args == 0 or not data then
            return nil
        end

        for __, v in pairs(args) do
            data = data[v]
            if not data then
                return nil
            end
        end

        return data
    end

    function Config.GetCompoundInfo(typeStr, ...)
        local args = {...}
        local data = Config.GetAllCompoundData(typeStr)
        if not data then
            return nil
        end

        return Config.GetCompoundInfoByKey(data, ...)
    end

    function Config.GetMoreCompoundInfo(typeStr, compoundTableKey, ...)
        local data = Config.GetAllCompoundData(typeStr)
        if not data then
            return nil
        end

        return Config.GetCompoundInfoByKey(data[compoundTableKey], ...)
    end

    ---@param typeStr string
    ---@return table|nil
    function Config.CommonGetInfo(typeStr, ...)
        local args = {...}
        local data = Config.GetAllConfig(typeStr)
        if not data then
            return nil
        end

        -- LuaLogger.ds("#args", #args)
        if #args == 0 then
            -- LuaLogger.e("%s's key is nil", typeStr) --todo:recover
            return nil
        end

        for __,v in pairs(args) do
            -- LuaLogger.ds("_, v", _, v)
            local key = v
            if not key then
                LuaLogger.es(typeStr, "'s is nil key:", ...)
                return nil
            end
            data = data[key]
            -- LuaLogger.ds("data[key]", tablex.dump(data))
            if not data then
                -- LuaLogger.es(typeStr, "Info is not existed key:", ...)--todo:recover
            end
        end

        -- LuaLogger.ds("return data", tablex.dump(data))

        return data
    end

    ---@return SkillTable|nil
    function Config.GetSkillInfo(...)
        return Config.CommonGetInfo("SkillTable", ...)
    end

    -- if GV.TableShareCenter or not GV.TableShareSub then
    --     Config.GenSkillTable()
    --     Config.GenBuffTable()
    -- end



    --config.lua 修改配置表数据注意事项
    --1,使用RequireDbg, _forShareTable修改保存
    --2,不能存储函数
    --3,考虑服务器是否使用，用GV.IsServer
    -- function Config.GenOtherTable()
    --     if GV.IsServer then
    --         _ConfigTimeStrToStamp("GachaPoolTable")
    --     else
    --         _ConfigTimeStrToStampClient("GachaPoolTable")
    --     end
    -- end

    --Config.GenOtherTable()

    function Config.CommonGetLevelInfo(tb, key, level, def)
        local cnt = #tb
        for i,v in ipairs(tb) do
            if i + 1 > cnt then
                return tb[cnt]
            end

            if level >= v[key] and level < tb[i + 1][key] then
                return v
            end
        end
    end

    ----------------------------------------------------------------------------

    function Config.GetConfigInfo(key)
        local value = Config.CommonGetInfo("ConfigTable", key)
        if not value then
            return nil
        end
        return loadstring("return " .. value.value)()
    end

    ---@return CharacterTable|nil
    function Config.GetCharacterInfo(...)
        return Config.CommonGetInfo("CharacterTable", ...)
    end

    ---@return MonsterTable|nil
    function Config.GetMonsterInfo(...)
        return Config.CommonGetInfo("MonsterTable", ...)
    end

    ---@return CharacterRestraintTable|nil
    function Config.GetCharacterRestraintInfo(...)
        return Config.CommonGetInfo("CharacterRestraintTable", ...)
    end

    ---@return PveLevelTable|nil
    function Config.GetPveLevelInfo(...)
        return Config.CommonGetInfo("PveLevelTable", ...)
    end

    ---@return PveLevelTriggerTable|nil
    function Config.GetPveLevelTriggerInfo(...)
        return Config.CommonGetInfo("PveLevelTriggerTable", ...)
    end

    ---@return ItemTable|nil
    function Config.GetItemInfo(...)
        return Config.CommonGetInfo("ItemTable", ...)
    end

    ---@return TrialTable|nil
    function Config.GetTrialInfo(...)
        return Config.CommonGetInfo("TrialTable", ...)
    end

    ---@return EffectTable|nil
    function Config.GetEffectInfo(...)
        return Config.CommonGetInfo("EffectTable", ...)
    end

    ---@return EffectTriggerTable|nil
    function Config.GetEffectTriggerInfo(...)
        return Config.CommonGetInfo("EffectTriggerTable", ...)
    end

    ---@return EffectTriggerConditionTable|nil
    function Config.GetEffectTriggerConditionInfo(...)
        return Config.CommonGetInfo("EffectTriggerConditionTable", ...)
    end

    ---@return EquipmentTable|nil
    function Config.GetEquipmentInfo(...)
        return Config.CommonGetInfo("EquipmentTable", ...)
    end

    ---@return EquipLevelTable|nil
    function Config.GetEquipLevelInfo(...)
        return Config.CommonGetInfo("EquipLevelTable", ...)
    end

    ---@return BuffTable|nil
    function Config.GetBuffInfo(...)
        return Config.CommonGetInfo("BuffTable", ...)
    end

    ---@return MapTerrainTypeTable|nil
    function Config.GetMapTerrainTypeInfo(...)
        return Config.CommonGetInfo("MapTerrainTypeTable", ...)
    end

    ---@return SignalTable|nil
    function Config.SignalInfo(...)
        return Config.CommonGetInfo("SignalTable", ...)
    end

    ---@return TalentTreeTable|nil
    function Config.TalentTreeInfo(...)
        return Config.CommonGetInfo("TalentTreeTable", ...)
    end

    ---@return TalentTreeStageTable|nil
    function Config.TalentTreeStageInfo(...)
        return Config.CommonGetInfo("TalentTreeStageTable", ...)
    end

    ---@return FilterTable|nil
    function Config.FilterInfo(...)
        return Config.CommonGetInfo("FilterTable", ...)
    end

    ---@return ConstructionTable|nil
    function Config.GetConstructionInfo(...)
        return Config.CommonGetInfo("ConstructionTable", ...)
    end

    ---@return ConstructionLevelTable|nil
    function Config.GetConstructionLevelInfo(...)
        return Config.CommonGetInfo("ConstructionLevelTable", ...)
    end

    ---@return ChapterTable|nil
    function Config.GetChapterInfo(...)
        return Config.CommonGetInfo("ChapterTable", ...)
    end

    ---@return LevelconfigTable|nil
    function Config.LevelconfigInfo(...)
        return Config.CommonGetInfo("LevelconfigTable", ...)
    end

    ---@return WeaponTable|nil
    function Config.GetWeaponInfo(...)
        return Config.CommonGetInfo("WeaponTable", ...)
    end

    ---@return WeaponEntryTable|nil
    function Config.GetWeaponEntryInfo(...)
        return Config.CommonGetInfo("WeaponEntryTable", ...)
    end

    ---@return MapTable|nil
    function Config.MapInfo(...)
        return Config.CommonGetInfo("MapTable", ...)
    end

    ---@return TaskTable|nil
    function Config.GetTaskTableInfo(...)
        return Config.CommonGetInfo("TaskTable", ...)
    end
    
    ---@return ActivitySecondaryTable|nil
    function Config.GetActivitySecondaryInfo(...)
        return Config.CommonGetInfo("ActivitySecondaryTable", ...)
    end

    ---@return RandomAwardTable|nil
    function Config.GetRandomAwardInfo(...)
        return Config.CommonGetInfo("RandomAwardTable", ...)
    end

    ---@return SiftConditionTable|nil
    function Config.GetSiftConditionInfo(...)
        return Config.CommonGetInfo("SiftConditionTable", ...)
    end

    ---@return PveLevelAchieveTable|nil
    function Config.GetPveLevelAchieveInfo(...)
        return Config.CommonGetInfo("PveLevelAchieveTable", ...)
    end

    ---@return ActionTable|nil
    function Config.GetActionInfo(...)
        return Config.CommonGetInfo("ActionTable", ...)
    end

    ---@return BattleMapTable|nil
    function Config.GetBattleMapInfo(...)
        return Config.CommonGetInfo("BattleMapTable", ...)
    end

    ---@return StoryArraryTable|nil
    function Config.GetStoryArraryInfo(...)
        return Config.CommonGetInfo("StoryArraryTable", ...)
    end

    ---@return CharacterSkinTable|nil
    function Config.GetCharacterSkinInfo(...)
        return Config.CommonGetInfo("CharacterSkinTable", ...)
    end

    ---@return StoryResourceTable|nil
    function Config.GetStoryResourceInfo(...)
        return Config.CommonGetInfo("StoryResourceTable", ...)
    end

    ---@return BannerTable|nil
    function Config.GetBannerInfo(...)
        return Config.CommonGetInfo("BannerTable", ...)
    end

    ---@return GachaPoolTable|nil
    function Config.GetGachaPoolInfo(...)
        return Config.CommonGetInfo("GachaPoolTable", ...)
    end

    ---@return GachaGuarantTable|nil
    function Config.GetGachaGuarantInfo(...)
        return Config.CommonGetInfo("GachaGuarantTable", ...)
    end

    ---@return GachaTable|nil
    function Config.GetGachaInfo(...)
        return Config.CommonGetInfo("GachaTable", ...)
    end

    ---@return MonsterActivationTable|nil
    function Config.GetMonsterActivationInfo(...)
        return Config.CommonGetInfo("MonsterActivationTable", ...)
    end

    ---@return HeadportraitTable|nil
    function Config.GetHeadportraitInfo(...)
        return Config.CommonGetInfo("HeadportraitTable", ...)
    end

    ---@return SkillRangeShowTable|nil
    function Config.GetSkillRangeShowInfo(...)
        return Config.CommonGetInfo("SkillRangeShowTable", ...)
    end

    ---@return NormalExplainTable|nil
    function Config.GetNormalExplainInfo(...)
        return Config.CommonGetInfo("NormalExplainTable", ...)
    end

    ---@return FunctionTabTable|nil
    function Config.GetFunctionTabInfo(...)
        return Config.CommonGetInfo("FunctionTabTable", ...)
    end

    ---@return SkipFuncTable|nil
    function Config.SkipFuncInfo(...)
        return Config.CommonGetInfo("SkipFuncTable", ...)
    end

    ---@return FunctionOpenTable|nil
    function Config.GetFunctionOpenInfo(...)
        return Config.CommonGetInfo("FunctionOpenTable", ...)
    end

    ---@return ScriptLinesTable|nil
    function Config.GetScriptLinesInfo(...)
        return Config.CommonGetInfo("ScriptLinesTable", ...)
    end

    ---@return HomeScreenLinesTable|nil
    function Config.GetHomeScreenLinesInfo(...)
        return Config.CommonGetInfo("HomeScreenLinesTable", ...)
    end

    ---@return LoadingPictureTable|nil
    function Config.GetLoadingPictureInfo(...)
        return Config.CommonGetInfo("LoadingPictureTable", ...)
    end

    ---@return LoadingTipsTable|nil
    function Config.GetLoadingTipsInfo(...)
        return Config.CommonGetInfo("LoadingTipsTable", ...)
    end

    ---@return WeaponProductionTable|nil
    function Config.GetWeaponProductionInfo(...)
        return Config.CommonGetInfo("WeaponProductionTable", ...)
    end

    ---@return BGMTable|nil
    function Config.GetBGMInfo(...)
        return Config.CommonGetInfo("BGMTable", ...)
    end

    ---@return ChapterStarTable|nil
    function Config.GetChapterStarInfo(...)
        return Config.CommonGetInfo("ChapterStarTable", ...)
    end

    ---@return SoundAndEffectTable|nil
    function Config.GetSoundAndEffectInfo(...)
        return Config.CommonGetInfo("SoundAndEffectTable", ...)
    end


    ---@return BulletTable|nil
    function Config.GetBulletInfo(...)
        return Config.CommonGetInfo("BulletTable", ...)
    end

    ---@return TapSoundTable|nil
    --获得装备突破所需材料
    function Config.GetTapSoundInfo(...)
        return Config.CommonGetInfo("TapSoundTable", ...)
    end

    ---@return AffectionTable|nil
    function Config.GetAffectionInfo(...)
        return Config.CommonGetInfo("AffectionTable", ...)
    end

    ---@return AffectionSoundTable|nil
    function Config.GetAffectionSoundInfo(...)
        return Config.CommonGetInfo("AffectionSoundTable", ...)
    end

    ---@return TechnologyTreeTable|nil
    function Config.GetTechnologyTreeInfo(...)
        return Config.CommonGetInfo("TechnologyTreeTable", ...)
    end

      ---@return TechnologyTreePointTable|nil
    function Config.GetTechnologyTreePointInfo(...)
        return Config.CommonGetInfo("TechnologyTreePointTable", ...)
    end

    ---@return TechnologyTreeStartTable|nil
    function Config.GetTechnologyTreeStartInfo(...)
        return Config.CommonGetInfo("TechnologyTreeStartTable", ...)
    end

    ---@return ArchiveTable|nil
    function Config.GetArchiveInfo(...)
        return Config.CommonGetInfo("ArchiveTable", ...)
    end

    ---@return RandomNameTable|nil
    function Config.GetRandomNameInfo(...)
        return Config.CommonGetInfo("RandomNameTable", ...)
    end

    ---@return HomeEventTable|nil
    function Config.GetHomeEventInfo(...)
        return Config.CommonGetInfo("HomeEventTable", ...)
    end

    ---@return EventTriggerTable|nil
    function Config.GetEventTriggerInfo(...)
        return Config.CommonGetInfo("EventTriggerTable", ...)
    end

    ---@return EffectInfoTable|nil
    function Config.GetEffectInfoInfo(...)
        return Config.CommonGetInfo("EffectInfoTable", ...)
    end

    ---@return GiftTable|nil
    function Config.GetGiftInfo(...)
        return Config.CommonGetInfo("GiftTable", ...)
    end

    ---@return GiftTable[]|nil
    function Config.GetAllGiftInfo()
        return Config.table.GiftTable
    end

    ---@return ShopListTable|nil
    function Config.GetShopListInfo(...)
        return Config.CommonGetInfo("ShopListTable", ...)
    end

    ---@return ShopMerchandiseTable|nil
    function Config.GetShopMerchandiseInfo(...)
        return Config.CommonGetInfo("ShopMerchandiseTable", ...)
    end

    ---@return GuideMainTable|nil
    function Config.GetGuideMainInfo(...)
        return Config.CommonGetInfo("GuideMainTable", ...)
    end

    ---@return GuideStepTable|nil
    function Config.GetGuideStepInfo(...)
        return Config.CommonGetInfo("GuideStepTable", ...)
    end

    ---@return DispatchTable|nil
    function Config.GetDispatchInfo(...)
        return Config.CommonGetInfo("DispatchTable", ...)
    end

    ---@return DispatchPointTable|nil
    function Config.GetDispatchPointInfo(...)
        return Config.CommonGetInfo("DispatchPointTable", ...)
    end

    ---@return DispatchLineTable|nil
    function Config.GetDispatchLineInfo(...)
        return Config.CommonGetInfo("DispatchLineTable", ...)
    end

    ---@return DispatchBattleTable|nil
    function Config.GetDispatchBattleInfo(...)
        return Config.CommonGetInfo("DispatchBattleTable", ...)
    end

    ---@return AiOperateTable?
    function Config.GetAiOperateInfo(...)
        return Config.CommonGetInfo("AiOperateTable", ...)
    end

    ---@return AiSearchAndMoveTable?
    function Config.GetAiSearchAndMoveInfo(...)
        return Config.CommonGetInfo("AiSearchAndMoveTable",...)
    end

    ---@return AiParameterTable?
    function Config.GetAiParameterInfo(...)
        return Config.CommonGetInfo("AiParameterTable",...)
    end

    ---@return PveExerciseStoreyTable|nil
    function Config.GetPveExerciseStoreyInfo(...)
        return Config.CommonGetInfo("PveExerciseStoreyTable", ...)
    end

    ---@return PveExerciseLevelTable|nil
    function Config.GetPveExerciseLevelInfo(...)
        return Config.CommonGetInfo("PveExerciseLevelTable", ...)
    end

    ---@return ActivityTable|nil
    function Config.GetActivityInfo(...)
        return Config.CommonGetInfo("ActivityTable", ...)
    end

    ---@return PassportTable|nil
    function Config.GetPassPortInfo(...)
        return Config.CommonGetInfo("PassportTable", ...)
    end

     ---@return PassportMainTable|nil
    function Config.GetPassportMainInfo(...)
        return Config.CommonGetInfo("PassportMainTable", ...)
    end

    ---@return HomeTouchTable|nil
    function Config.GetHomeTouchInfo(...)
        return Config.CommonGetInfo("HomeTouchTable", ...)
    end

    ---@return InterfaceSoundTable|nil
    function Config.GetInterfaceSoundInfo(...)
        return Config.CommonGetInfo("InterfaceSoundTable", ...)
    end

    ---@return SkinActionTable|nil
    function Config.GetSkinActionInfo(...)
        return Config.CommonGetInfo("SkinActionTable", ...)
    end

    ---@return ActionDesignTable|nil
    function Config.GetActionDesignInfo(...)
        return Config.CommonGetInfo("ActionDesignTable", ...)
    end

    ---@return fightTestTable|nil
    function Config.GetBattleTestInfo(...)
        return Config.CommonGetInfo("fightTestTable", ...)
    end


    ---@return QuestionnaireTable|nil
    function Config.GetQuestionnaireInfo(...)
        return Config.CommonGetInfo("QuestionnaireTable", ...)
    end

    ---@return HomeTouchWordsTable|nil
    function Config.GetHomeTouchWordsInfo(...)
        return Config.CommonGetInfo("HomeTouchWordsTable", ...)
    end

    ---@return HomeTouchTopicTable|nil
    function Config.GetHomeTouchTopicInfo(...)
        return Config.CommonGetInfo("HomeTouchTopicTable", ...)
    end

    ---@return HomeFightTable|nil
    function Config.GetHomeFightTableInfo(...)
        return Config.CommonGetInfo("HomeFightTable", ...)
    end

    ---@return signInTable|nil
    function Config.GetsignInInfo(...)
        return Config.CommonGetInfo("SignInTable", ...)
    end

    ---@return signAwardTable|nil
    function Config.GetsignAwardInfo(...)
        return Config.CommonGetInfo("SignAwardTable", ...)
    end

    ---@return PveBossBattleTable|nil
    function Config.GetPveBossBattleInfo(...)
        return Config.CommonGetInfo("PveBossBattleTable", ...)
    end

    ---@return PveBossBattleLevelTable|nil
    function Config.GetPveBossBattleLevelInfo(...)
        return Config.CommonGetInfo("PveBossBattleLevelTable", ...)
    end

    ---@return PveBossBattleScoreTable|nil
    function Config.GetPveBossBattleScoreInfo(...)
        return Config.CommonGetInfo("PveBossBattleScoreTable", ...)
    end

    ---@return PveBossBattleEffectTable|nil
    function Config.GetPveBossBattleEffectInfo(...)
        return Config.CommonGetInfo("PveBossBattleEffectTable", ...)
    end

    ---@return PlotTable|nil
    function Config.GetPlotInfo(...)
        return Config.CommonGetInfo("PlotTable", ...)
    end

    ---@return PlotChapterTable|nil
    function Config.GetPlotChapterInfo(...)
        return Config.CommonGetInfo("PlotChapterTable", ...)
    end

    ---@return HomeTouchConstructionTable|nil
    function Config.GetHomeTouchConstructionInfo(...)
        return Config.CommonGetInfo("HomeTouchConstructionTable", ...)
    end

    ---@return ProsperityTable|nil
    function Config.GetProsperityInfo(...)
        return Config.CommonGetInfo("ProsperityTable", ...)
    end

    ---@return ProsperityConstructionTable|nil
    function Config.GetProsperityConstructionInfo(...)
        return Config.CommonGetInfo("ProsperityConstructionTable", ...)
    end

    ---@return SurvivorSkillTable|nil
    function Config.GetSurvivorSkillInfo(...)
        return Config.CommonGetInfo("SurvivorSkillTable", ...)
    end

    ---@return SurvivorRoleTable|nil
    function Config.GetSurvivorRoleInfo(...)
        return Config.CommonGetInfo("SurvivorRoleTable", ...)
    end

    ---@return SurvivorItemTable|nil
    function Config.GetSurvivorItemInfo(...)
        return Config.CommonGetInfo("SurvivorItemTable", ...)
    end

    ----------------------------------------------------------------------------
    --获取复合键内容接口 Config.GetCompoundInfo
    ----------------------------------------------------------------------------
    --根据建筑id和等级获取对应建筑等级信息
    function Config.GetConstructionLevelInfoByTypeLevel(ttype, level)
        return Config.GetCompoundInfo("ConstructionLevelTable", "compound1", ttype, level)
    end

    --根据建筑id获取对应建筑等级信息
    function Config.GetConstructionLevelInfoByType(ttype)
        return Config.GetCompoundInfo("ConstructionLevelTable", "compound2", ttype)
    end

    --根据pageid获取科技树点位配置
    function Config.GetTechnologyTreePointInfoByPage(page)
        return Config.GetCompoundInfo("TechnologyTreePointTable", "compound1", page)
    end

    function Config.GetActivityByType(type)
        return Config.GetCompoundInfo("ActivityTable", "compound1", type)
    end

    --根据chapter获取Plot列表
    function Config.GetPlotInfoByChapter(chapter)
        return Config.GetCompoundInfo("PlotTable", "compound1", chapter)
    end

    --根据lineid获取派遣配置
    function Config.GetDispatchInfoByGroupId(groupId)
        return Config.GetCompoundInfo("DispatchTable", "compound1", groupId)
    end

    --根据type获取派遣配置
    function Config.GetDispatchInfoByType(type)
        return Config.GetCompoundInfo("DispatchTable", "compound2", type)
    end

    --根据groupId获取对应的loading描述信息
    function Config.GetLoadingTipsInfoByGroup(groupId)
        return Config.GetCompoundInfo("LoadingTipsTable", groupId)
    end

    --根据groupId获取科技树
    function Config.GetTechnologyTreeListByGroup(groupId)
        return Config.GetCompoundInfo("TechnologyTreeTable", "compound1", groupId)
    end

      --根据groupId lv获取科技树
    function Config.GetTechnologyTreeListByGroupAndLv(groupId, lv)
        --LuaLogger.e(groupId.." "..lv)
        return Config.GetCompoundInfo("TechnologyTreeTable", "compound2", groupId, lv)
    end

    --根据groupId获取派遣路线
    function Config.GetDispatchLineByGroup(groupId)
        return Config.GetCompoundInfo("DispatchLineTable", groupId)
    end

    function Config.GetSignAwardInfoByGroup(groupId)
        return Config.GetCompoundInfo("SignAwardTable", groupId)
    end

    --根据groupId获取派遣路线
    function Config.GetDispatchPointByGroup(groupId)
        return Config.GetCompoundInfo("DispatchPointTable", groupId)
    end


    --根据角色id查找对应皮肤列表
    function Config.GetCharacterSkinInfoByCharacterID(heroCid)
        return Config.GetCompoundInfo("CharacterSkinTable", heroCid)
    end

    --根据系统id查找对应筛选数据
    function Config.GetFilterInfoBySystem(systemId)
        return Config.GetCompoundInfo("FilterTable", systemId)
    end

    --通过阶段id和天赋树组获取天赋树阶段数据
    function Config.GetTalentTreeStageInfoByTreeIdStageId(treeId, stageId)
        return Config.GetCompoundInfo("TalentTreeStageTable", "compound1", treeId, stageId)
    end

    --通过阶段id获取天赋树阶段数据
    function Config.GetTalentTreeStageInfoByTreeId(treeId)
        return Config.GetCompoundInfo("TalentTreeStageTable", "compound2", treeId)
    end

    --根据战斗事件组id获取对应战斗事件
    ---@return PveLevelTriggerTable[]?
    function Config.GetPveLevelTriggerInfoByBaseId(groupid)
        return Config.GetCompoundInfo("PveLevelTriggerTable", groupid)
    end

    --根据战斗事件组id获取对应战斗事件
    function Config.GetWeaponEntryInfoByGroup(groupId)
        return Config.GetCompoundInfo("WeaponEntryTable", groupId)
    end

    --根据组id寻找对应表情动作组
    function Config.GetActionInfoByGroup(groupId)
        return Config.GetCompoundInfo("ActionTable", groupId)
    end

    --根据组id寻找对应卡池内容组
    function Config.GetGachaInfoByGroup(groupId)
        return Config.GetCompoundInfo("GachaTable", groupId)
    end

    --根据计数组id获取保底配置组
    function Config.GetGachaGuarantInfoByPoolIdGroupId(poolId, groupId)
        return Config.GetCompoundInfo("GachaGuarantTable", poolId, groupId)
    end

    --根据chapter获取StoryArrary列表
    function Config.GetStoryArraryInfoByChapter(chapter)
        return Config.GetCompoundInfo("StoryArraryTable", chapter)
    end

    --根据组id寻找对应表情动作组
    function Config.GetHomeMoveInfoByBelongArea(areaId)
        return Config.GetCompoundInfo("HomeMoveTable", areaId)
    end

    --根据组id寻找对应表情动作组
    function Config.GetHomeMovePointInfo(pointId)
        return Config.GetCompoundInfo("HomeMovePointTable", pointId)
    end

    --根据皮肤id获取对应台词列表
    function Config.GetHomeScreenLinesInfoBySkinId(skinId)
        return Config.GetCompoundInfo("HomeScreenLinesTable", skinId)
    end

    --获取建筑能生效的词条类型
    function Config.GetConstructionInfoTagType(consId)
        return Config.GetCompoundInfo("ConstructionTable", consId)
    end

    --根据章节id获取对应的章节奖励信息
    function Config.GetChapterStarInfoByChapterId(consId)
        return Config.GetCompoundInfo("ChapterStarTable", consId)
    end

    --根据类型id获取对应功能开启信息
    function Config.GetFunctionOpenInfoByType(unLockType)
        return Config.GetCompoundInfo("FunctionOpenTable", unLockType)
    end

    --根据类型获取章节列表
    function Config.GetChapterInfoByTypeDeepType(typeId, deepType)
        return Config.GetMoreCompoundInfo("ChapterTable", "compound1", typeId, deepType)
    end

    --根据海图获取章节列表
    function Config.GetChapterInfoByMap(mapId)
        return Config.GetMoreCompoundInfo("ChapterTable", "compound2", mapId)
    end

    --根据 类型和等级 查找阶段等级信息
    function Config.GetLevelconfigInfoByTypeLevel(typeIndex, level)
        return Config.GetMoreCompoundInfo("LevelconfigTable", "compound1", typeIndex, level)
    end

    --根据类型查找阶段等级信息
    function Config.GetLevelconfigInfoByType(typeIndex)
        return Config.GetMoreCompoundInfo("LevelconfigTable", "compound2", typeIndex)
    end

    --根据天赋树阶段和天赋树id查找对应stage的所有信息
    function Config.GetTalentTreeInfoByTreeIdStageId(treeId, stageId)
        return Config.GetMoreCompoundInfo("TalentTreeTable", "compound1", treeId, stageId)
    end

    --根据天赋树iD获取天赋信息
    function Config.GetTalentTreeInfoByTreeId(treeId)
        return Config.GetMoreCompoundInfo("TalentTreeTable", "compound2", treeId)
    end

    --根据升级组和等级查找装备升级信息
    function Config.GetEquipLevelByGroupAndLevel(type, levelGroup, level)
        return Config.GetMoreCompoundInfo("EquipLevelTable", "compound1", type, levelGroup, level)
    end

    --根据升级组查找装备等级列表
    function Config.GetEquipLevelByLevelGroup(type, levelGroup)
        return Config.GetMoreCompoundInfo("EquipLevelTable", "compound2", type, levelGroup)
    end

    --获得装备突破所需材料
    function Config.GetEquipLevelByBreakGroup(type, breakGroup, star)
        return Config.GetMoreCompoundInfo("EquipLevelTable", "compound3", type, breakGroup, star)
    end

    --根据角色id获取列表信息
    function Config.GetArchiveInfoById(roleId)
        return Config.GetMoreCompoundInfo("ArchiveTable", "compound2", roleId)
    end

    --根据类型id和角色id获取对应的档案信息
    function Config.GetArchiveInfoByType(roleId, typeId)
        return Config.GetMoreCompoundInfo("ArchiveTable", "compound1", roleId, typeId)
    end

    --根据角色id获取语音列表
    function Config.GetAffectionSoundInfoById(roleId)
        return Config.GetCompoundInfo("AffectionSoundTable", roleId)
    end

    --根据商品组获得对应的商品列表
    function Config.GetShopMerchandiseByGroupId(groupId)
        return Config.GetCompoundInfo("ShopMerchandiseTable", "compound1", groupId)
    end

    --根据商店id获得对应的商品列表
    function Config.GetShopMerchandiseByShopId(shop)
        return Config.GetCompoundInfo("ShopMerchandiseTable", "compound2", shop)
    end

    --根据当期id及层数id获取关卡列表
    function Config.GetPveExerciseLevelByIssueAndStorey(issueId, storeyId)
        return Config.GetCompoundInfo("PveExerciseLevelTable", "compound1", issueId, storeyId)
    end

    --根据当期id及关卡id获取关卡信息
    function Config.GetPveExerciseLevelInfoByIssueAndLevelId(issueId, levelId)
        return Config.GetCompoundInfo("PveExerciseLevelTable", "compound2", issueId, levelId)
    end

    --根据层数id获取扫荡层表数据
    function Config.GetPveExerciseStoreyInfoByStoreyNum(storeyNum)
        return Config.GetCompoundInfo("PveExerciseStoreyTable", storeyNum)
    end

    --根据效果id获取对应道具列表
    function Config.GetItemInfoByEffectId(effectId)
        return Config.GetCompoundInfo("ItemTable", effectId)
    end

    --根据角色id获取对应的英雄事件
    function Config.GetHeroEventByCharacterId(characterId)
        return Config.GetCompoundInfo("HomeEventTable", characterId)
    end

    --根据事件类型id获取对应的事件触发器
    function Config.GetEventTriggerByType(typeId)
        return Config.GetCompoundInfo("EventTriggerTable","compound1", typeId)
    end

    --根据触发上限获取对应的事件触发器
    function Config.GetEventTriggerByLimitId(limitId)
        return Config.GetCompoundInfo("EventTriggerTable","compound2", limitId)
    end

    --根据皮肤id获取spine互动表组
    function Config.GetSkinActionInfoBySkinId(skinId)
        return Config.GetCompoundInfo("SkinActionTable", skinId)
    end

    --根据组id获取看板娘动作组
    function Config.GetActionDesignInfoByGroupId(groupId)
        return Config.GetCompoundInfo("ActionDesignTable", groupId)
    end

    -- 获取预留的账号是否存在
    function Config.GetReversedAccount(account_md5)
        return Config.GetCompoundInfo("ReservedAccountTable", account_md5)
    end

    -- 获取一测手机号
    function Config.GetOpenBetaTest01Phone(phone)
        return Config.GetCompoundInfo("OpenBetaTest01Table", phone)
    end

    --根据taskType获取任务组
    function Config.GetTaskInfoByTaskType(taskType)
        return Config.GetCompoundInfo("TaskTable", "compound1", taskType)
    end

    --根据group获取活动配置
    function Config.GetActivitySecondaryInfoByGroup(group)
        return Config.GetCompoundInfo("ActivitySecondaryTable", "compound1", group)
    end

    --根据taskType、taskGroup获取任务列表
    function Config.GetTaskInfoByTaskTypeAndGroup(taskType, taskGroup)
        return Config.GetCompoundInfo("TaskTable", "compound2", taskType, taskGroup)
    end

    --根据taskType、taskGroup、type获取任务列表
    function Config.GetTaskInfoByTaskTypeGroupType(taskType, taskGroup, type)
        return Config.GetCompoundInfo("TaskTable", "compound3", taskType, taskGroup, type)
    end

    --根据组passportId获取通行证组数据
    function Config.GetPassportByPassportId(passportId)
        return Config.GetCompoundInfo("PassportTable", "compound1", passportId)
    end

    --根据PassportId、Level获取通行证
    function Config.GetPassportLevelInfoByPassportIdAndLevel(passportId, level)
        return Config.GetCompoundInfo("PassportTable", "compound2", passportId, level)
    end

    --根据组passportId获取通行证组数据
    function Config.GetMailTableById(mailId)
        return Config.GetCompoundInfo("MailTable", mailId)
    end


    function Config.GetHomeWeatherTable()
        local t = Config.GetAllConfig("HomeWeatherTable")
        return t
    end

    ---@return WeatherParameterTable?
    function Config.GetWeatherParameterById(id)
        local t = Config.CommonGetInfo("WeatherParameterTable", id)
        return t
    end


    ---@return table<integer, IntelligenceTable>
    function Config.GetIntelligenceTable()
        local t = Config.GetAllConfig("IntelligenceTable")
        return t
    end

    ---@return IntelligenceTable?
    function Config.GetIntelligenceById(id)
        local t = Config.CommonGetInfo("IntelligenceTable", id)
        return t
    end

    ---@return HomeActionTable[]
    function Config.GetHomeActionTable()
        local t = Config.GetAllConfig("HomeActionTable")
        return t
    end

       ---@return HomeActionTable?
    function Config.GetHomeActionCfg(id)
        local t = Config.CommonGetInfo("HomeActionTable", id)
        return t
    end

    ---@return HomeActivateTable?
    function Config.GetHomeActivateCfg(id)
        local t = Config.CommonGetInfo("HomeActivateTable", id)
        return t
    end
    ---@param actionType number 行为类型
    ---@param param number? 参数类型
    ---@return HomeActivateTable?
    function Config.GetHomeActivateCfgByactionType(actionType, param)
        local t = Config.GetAllConfig("HomeActivateTable")
        if not t then
            return nil
        end
        for __,v in pairs(t) do
            if v.activateType == actionType and (param == nil or v.param == param) then
                return v
            end
        end
        return nil
    end

    ---@param actionType number 行为类型
    ---@return HomeActivateTable[]?
    function Config.GetHomeActivateCfgsByactionType(actionType)
        local t = Config.GetAllConfig("HomeActivateTable")
        if not t then
            return nil
        end
        local result = nil
        for __,v in pairs(t) do
            if v.activateType == actionType then
                if not result then
                    result = {}
                end
                table.insert(result, v)
            end
        end
        return result
    end



    ---@return HomeResourceTable?
    function Config.GetHomeResourceCfg(id)
        local t = Config.CommonGetInfo("HomeResourceTable", id)
        return t
    end

    --根据组id（角色id）获取对应的触摸话题列表
    function Config.GetHomeTouchTopicInfoByGroupId(id)
        local t = Config.GetAllConfig("HomeTouchTopicTable")
        local result = {}
        for __,v in pairs(t) do
            if v.group == id then
                table.insert(result, v)
            end
        end
        return result
    end

    --根据组passportId获取通行证组数据
    function Config.GetHomeTouchWordsInfoByGroupId(group)
        return Config.GetCompoundInfo("HomeTouchWordsTable", "compound1", group)
    end

    --根据PassportId、Level获取通行证
    function Config.GetHomeTouchWordsInfoByPassageId(samePassage)
        return Config.GetCompoundInfo("HomeTouchWordsTable", "compound2", samePassage)
    end

    ---@return MonthCardTable
    function Config.GetMonthCardInfo(...)
        return Config.CommonGetInfo("MonthCardTable", ...)
    end

    --根据期数id获取boss战当期表数据
    function Config.GetPveBossBattleInfoByIssue(issue)
        return Config.GetCompoundInfo("PveBossBattleTable", issue)
    end

    --根据tag组id获取boss战tag列表
    function Config.GetPveBossBattleEffectInfoByTag(tagGroupId)
        return Config.GetCompoundInfo("PveBossBattleEffectTable", tagGroupId)
    end

    --根据问卷id获取问卷数据
    function Config.GetQuestionnaireInfoByCodeid(codeid)
        return Config.GetCompoundInfo("QuestionnaireTable", codeid)
    end


    ---@return HomeTouchReplyTable|nil
    function Config.GetHomeTouchReplyInfo(...)
        return Config.CommonGetInfo("HomeTouchReplyTable", ...)
    end

    ---@return HomeTouchReplyTable[]|nil
    function Config.GetHomeTouchReplyTable(...)
        local data = Config.GetAllConfig("HomeTouchReplyTable")
        return data
    end

    ---@return CoveStoryLineTable[]|nil
    function Config.GetCoveStroyLineInfo(...)
        return Config.CommonGetInfo("CoveStoryLineTable", ...)
    end

    ---@return CoveStoryLineTable[]|nil
    function Config.GetCoveStoryLineTable(groupId)
        return Config.GetMoreCompoundInfo("CoveStoryLineTable", "compound1", groupId)
    end

    --根据繁荣等级获取繁荣配置
    ---@param levelTask number
    ---@return ProsperityTable|nil
    function Config.GetProsperityInfoBylevelTask(levelTask)
        return Config.GetCompoundInfo("ProsperityTable", "compound1", levelTask)
    end


    ---@return WeatherReportTable|nil
    function Config.GetWeatherReportInfo(...)
        return Config.CommonGetInfo("WeatherReportTable", ...)
    end

    ---获得对应英雄的天气对话配置
    ---@param character int
    ---@return WeatherReportTable[][]|nil
    function Config.GetWeatherReportTable(character)
        return Config.GetMoreCompoundInfo("WeatherReportTable", "compound1", character)
    end


    ---获得对应英雄的交互对话配置
    ---@param type int
    ---@return HomeInteractiveDialogueTable[]?
    function Config.GetHomeInteractiveDialogueTable(type)
        return Config.GetMoreCompoundInfo("HomeInteractiveDialogueTable", "compound1", type)
    end


----------------------------------------------------------------------------

--region  自走棋相关
    ---@param id int
    ---@return AutoChessHeroTable?
       function Config.GetAutoChessHeroTable(id)
        local t = Config.CommonGetInfo("AutoChessHeroTable", id)
        return t
    end

    ---@param id int
    ---@return AutoChessSkillTable?
       function Config.GetAutoChessSkillTable(id)
        local t = Config.CommonGetInfo("AutoChessSkillTable", id)
        return t
    end
    ---@param id int
    ---@return AutoChessBulletTable?
       function Config.GetAutoChessBulletTable(id)
        local t = Config.CommonGetInfo("AutoChessBulletTable", id)
        return t
    end

    ---@param id int
    ---@param lv int
    ---@return AutoChessBuffTable?
    function Config.GetAutoChessBuffTable(id, lv)
        local t = Config.CommonGetInfo("AutoChessBuffTable", "compound1", id, lv)
        return t
    end


    ---@param id int
    ---@return AutoChessConditionTable?
    function Config.GetAutoChessConditionTable(id)
        local t = Config.CommonGetInfo("AutoChessConditionTable", id)
        return t
    end

    ---@param id int
    ---@return AutoChessSiftConditionTable?
    function Config.GetAutoChessSiftConditionTable(id)
        local t = Config.CommonGetInfo("AutoChessSiftConditionTable", id)
        return t
    end

    ---@param id int
    ---@return AutoChessModifierTable?
    function Config.GetAutoChessModifierTable(id)
        local t = Config.CommonGetInfo("AutoChessModifierTable", id)
        return t
    end

    

---endregion

    --ReloadModule "SkillBasicConfig"
    ReloadModule "CommonConstant"
    if not GV.IsServer then
        --客户端可能重复调用load()函数，避免重复加载
        Config.IsLoaded = true
    end
    return Config
end

--------------------------------------------------------
--------------------------------------------------------
function Config.reloadTableList(tableList)
    if not GV.IsServer then
        return
    end

    local suc = Config.loadTableList(tableList, true)
    if suc then
        for _, name in pairs(tableList) do
            GV.sharetable.freeOldVersion(name)
        end
    end

end

function Config.reloadAll()
    if not GV.IsServer then
        return
    end

    local config = Config.Load(true)
    if config then
        GV.sharetable.freeOldVersion()
    end

end

return Config