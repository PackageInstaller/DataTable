-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luamaininit.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
do
  if NEKO_LUA_DEBUG then
    local breakSocketHandle, debugXpCall = (require("luadebug"))("localhost", 7003)
  end
  ;
  ((require("luapanda")).start)("127.0.0.1", 8818)
  LuaUpdateManager = require("framework.luaupdatemanager")
  ;
  (LuaUpdateManager.Init)()
  require("framework.table")
  require("framework.string")
  require("logic.utils.stringutils")
  require("framework.class")
  require("framework.utils.log")
  JSON = require("framework.json")
  SdkManager = require("logic.sdk.sdkmanager")
  ;
  (SdkManager.Init)()
  ThinkingAnalyticsInterface = require("logic.sdk.thinkinganalyticsinterface")
  NoticeManager = require("logic.manager.noticemanager")
  ;
  (NoticeManager.Init)()
  local CVarConfigLuaFile = require("data.exceldata.var.cvarconfig")
  global_var_language_id = tonumber(((CVarConfigLuaFile.Data)[101]).Value)
  global_var_debug = tonumber(((CVarConfigLuaFile.Data)[17]).Value) == 1
  global_var_local_check = tonumber(((CVarConfigLuaFile.Data)[15]).Value) == 1
  global_var_isTest = tonumber(((CVarConfigLuaFile.Data)[16]).Value) == 1
  global_var_showFrameRate = tonumber(((CVarConfigLuaFile.Data)[63]).Value) == 1
  global_var_thinkingAnalyticsOpen = tonumber(((CVarConfigLuaFile.Data)[65]).Value) == 1
  client_server_list = {}
  local isTestPack = ((((CS.PixelNeko).P1).PackageTypeManager).IsTestPack)()
  local StartGame = function()
  -- function num : 0_0 , upvalues : _ENV, isTestPack
  LogInfo("luamaininit", (string.format)("debug %s", global_var_debug))
  LogInfo("luamaininit", (string.format)("check %s", global_var_local_check))
  LogInfo("luamaininit", (string.format)("isTest %s", global_var_isTest))
  require("luamain")
  ;
  (((CS.PixelNeko).LuaManager).CloseUpdateDialog)()
  local userid = (((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0")
  if userid ~= "0" then
    (((CS.UnityEngine).PlayerPrefs).SetString)("lastUserId", userid)
  end
  ;
  (((CS.UnityEngine).PlayerPrefs).SetString)("currentUserId", "0")
  local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
  if global_var_thinkingAnalyticsOpen and ThinkingAnalyticsInterface then
    local mode = (ThinkingAnalyticsInterface.DebugMode).NORMAL
    local appID = nil
    local severUrl = (CVarconfig:GetRecorder(67)).Value
    if isTestPack then
      appID = (CVarconfig:GetRecorder(72)).Value
    else
      appID = (CVarconfig:GetRecorder(68)).Value
    end
    local jsonStr = (JSON.encode)({appID = appID, severUrl = severUrl, mode = mode, log = "false"})
    ;
    (ThinkingAnalyticsInterface.Init_TA)(jsonStr)
  end
  do
    local languageID = tonumber((CVarconfig:GetRecorder(101)).Value)
    if languageID ~= 1 then
      local recorder = ((BeanManager.GetTableByName)("overseas.clanguagechangeconfig")):GetRecorder(languageID)
      local fontAssetBundles = {}
      local fontnames = {}
      for i,v in ipairs(recorder.fontAssetBundle) do
        (table.insert)(fontAssetBundles, v)
      end
      for i,v in ipairs(recorder.fontname) do
        (table.insert)(fontnames, v)
      end
      ;
      (((((CS.PixelNeko).P1).Localization).UILanguageManager).SetLanguageAsset)(recorder.assetBundle, recorder.assetName, fontAssetBundles, fontnames)
    end
  end
end

  local loadLocalServerlist = function(callback)
  -- function num : 0_1 , upvalues : _ENV, isTestPack
  local l, file = nil, nil
  LogInfo("luamaininit", (string.format)("isTestPack %s", isTestPack))
  if isTestPack then
    local cfgPath = ((((CS.PixelNeko).P1).PackageTypeManager).GetTestPackServerListPath)()
    file = ((((CS.PixelNeko).Lua).CfgStaticFunction).GetCfgFile)(cfgPath)
  else
    do
      do
        local filename = nil
        if (SdkManager.GetChannel)() == "leit" then
          filename = "serverlist_sdk.json"
        else
          if (SdkManager.GetChannel)() == "yost" then
            filename = "serverlist_yostar.json"
          else
            if (SdkManager.GetChannel)() == "qian" then
              filename = "serverlist_qian.json"
            else
              if (SdkManager.GetChannel)() == "mqan" then
                filename = "serverlist_qian.json"
              else
                filename = "serverlist_apps.json"
              end
            end
          end
        end
        file = ((((CS.PixelNeko).Lua).CfgStaticFunction).GetCfgFile)(filename)
        if file then
          if ((((CS.PixelNeko).Lua).NewtonsoftJsonUtility).StringToDictionary)(file) then
            l = (JSON.decode)(file)
          else
            LogError("luamaininit", (string.format)("serverlist file (json %s) decode wrong", file))
          end
        else
          LogError("luamaininit", (string.format)("local serverlist file is not found, isTestPack %s", isTestPack))
        end
        local sList = {}
        if l then
          if SdkManager.IsOverseas then
            (((CS.PixelNeko).NetManager).HttpGetRequestAsync)(l.downloadurl .. "?time=" .. tostring((os.time)()), function(result)
    -- function num : 0_1_0 , upvalues : _ENV, sList, l, callback
    if not result then
      if global_var_isTest then
        sList = l.intranet
      else
        sList = l.internet
      end
    else
      sList = (JSON.decode)(result)
      warn("Get Result: ", result)
      for _,v in ipairs(sList) do
        warn(v.name, (v.ipServerDomain)[1])
      end
    end
    do
      client_server_list = {}
      if sList then
        for _,d in ipairs(sList) do
          (table.insert)(client_server_list, d)
        end
      else
        do
          LogError("luamaininit", (string.format)("using test is %s, serverlist is null", global_var_isTest))
          do return  end
          if callback then
            callback()
          end
        end
      end
    end
  end
)
          else
            if global_var_isTest then
              sList = l.intranet
            else
              sList = l.internet
            end
            client_server_list = {}
            if sList then
              for _,d in ipairs(sList) do
                (table.insert)(client_server_list, d)
              end
            else
              do
                LogError("luamaininit", (string.format)("using test is %s, serverlist is null", global_var_isTest))
                do return  end
                if callback then
                  callback()
                end
              end
            end
          end
        end
      end
    end
  end
end

  local isEditor = tonumber(((CVarConfigLuaFile.Data)[18]).Value) == 1
  LogInfo("luamaininit", (string.format)("isEditor %s(no use)", isEditor))
  loadLocalServerlist(StartGame)
  local LuaCodeVersionManager = require("logic.manager.luacodeversionmanager")
  local luacodeVersion = (LuaCodeVersionManager.GetLuaCodeVersion)()
  LogInfoFormat("luamaininit", "luacodeVersion %s", luacodeVersion)
  local battleDataVersion = (LuaCodeVersionManager.GetBattleDataVersion)()
  LogInfoFormat("luamaininit", "battleDataVersion %s", battleDataVersion)
  local behaviorVersion = (LuaCodeVersionManager.GetBehaviorVersion)()
  LogInfoFormat("luamaininit", "behaviorVersion %s", behaviorVersion)
  local dungeonDataVersion = (LuaCodeVersionManager.GetDungeonDataVersion)()
  LogInfoFormat("luamaininit", "dungeonDataVersion %s", dungeonDataVersion)
  local excelDataVersion = (LuaCodeVersionManager.GetExcelDataVersion)()
  LogInfoFormat("luamaininit", "excelDataVersion %s", excelDataVersion)
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

