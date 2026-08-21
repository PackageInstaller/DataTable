-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/textmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TextManager = {}
TextManager.FunctionType = {Gift = 1, Friend = 2, Dialogue = 3, Skill = 4, RandomName = 5, Character = 6, ClientTip = 7, ClientString = 8, Yard = 9, NPC = 10, Task = 11, Shop = 12, Head = 13, Handbook = 14, Battle = 15, Equip = 16, Scene = 17, Pay = 18, Item = 19, Copy = 20, Guild = 21, Buff = 22, EnemyInfo = 23, Guide = 24}
local _functionType = TextManager.FunctionType
local _fucntionOriginalTableName = {[1] = "word.cwordgift", [2] = "word.cwordfriend", [3] = "word.cworddialogue", [4] = "word.cwordskill", [6] = "word.cwordrole", [7] = "word.cwordclienttip", [8] = "word.cwordclientstring", [9] = "word.cwordyard", [10] = "word.cwordnpc", [11] = "word.cwordtask", [12] = "word.cwordshop", [13] = "word.cwordhead", [14] = "word.cwordhandbook", [15] = "word.cwordbattle", [16] = "word.cwordequip", [17] = "word.cwordscene", [18] = "word.cwordtopup", [19] = "word.cworditem", [20] = "word.cworddungeonselect", [21] = "word.cwordguild", [22] = "word.cwordbuff", [23] = "word.cenemyinfo", [24] = "word.cwordguide"}
local _regionNameTable = {[1] = "_ch", [2] = "_en", [3] = "_kr", [4] = "_jp"}
local _functionTableName = {}
local _textTableCache = {}
local _fallbackRegion = _regionNameTable.ch
local TABLECAPACITYMAX = 100000
TextManager.Init = function()
  -- function num : 0_0 , upvalues : _ENV, _regionNameTable, _functionType, _fucntionOriginalTableName, _functionTableName
  local languageID = (((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(101)).Value
  local regionName = _regionNameTable[tonumber(languageID)]
  for k,v in pairs(_functionType) do
    local originalName = _fucntionOriginalTableName[v]
    if originalName == nil then
      _functionTableName[v] = nil
    else
      _functionTableName[v] = originalName .. regionName
    end
  end
end

TextManager.GetText = function(textID, ...)
  -- function num : 0_1 , upvalues : _ENV, TABLECAPACITYMAX, _textTableCache, _functionTableName, _fucntionOriginalTableName, _fallbackRegion
  if textID <= 0 then
    return ""
  end
  local typeID = (math.ceil)(textID / TABLECAPACITYMAX)
  local textTable = _textTableCache[typeID]
  do
    if textTable == nil then
      local functionTableName = _functionTableName[typeID]
      if functionTableName == nil then
        LogError("TextManager", "no type : " .. typeID)
        return ""
      end
      textTable = (BeanManager.GetTableByName)(functionTableName)
      if textTable == nil then
        LogError("TextManager", "no table : " .. functionTableName)
        textTable = (BeanManager.GetTableByName)(_fucntionOriginalTableName[typeID] .. _fallbackRegion)
      end
      _textTableCache[typeID] = textTable
    end
    local record = textTable:GetRecorder(textID)
    if record == nil then
      LogError("TextManager", "no text id : " .. textID)
      return ""
    end
    local retValue = record.text
    for i,v in ipairs((table.pack)(...)) do
      retValue = (string.gsub)(retValue, "%$parameter" .. tostring(R14_PC71) .. R14_PC71, v)
    end
    return retValue
  end
end

TextManager.StartCheck = function()
  -- function num : 0_2 , upvalues : TextManager
  (TextManager.CheckConfig)("welfare.crunechatlist", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("welfare.crunechatlist", "choose", "chooseTextID")
  ;
  (TextManager.CheckConfig)("welfare.crunechatlist", "content", "contentTextID")
  ;
  (TextManager.CheckConfig)("welfare.cruneresults", "txtTitle", "txtTitleTextID")
  ;
  (TextManager.CheckConfig)("welfare.cruneresults", "txtContent", "txtContentTextID")
  ;
  (TextManager.CheckConfig)("friend.cfriendconfig", "FirstMessage", "FirstMessageTextID")
  ;
  (TextManager.CheckConfig)("dialog.chomechatlist", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("dialog.chomechatlist", "content", "contentTextID")
  ;
  (TextManager.CheckConfig)("dialog.chomechatlist", "choose", "chooseTextID")
  ;
  (TextManager.CheckConfig)("dialog.cbattlechatlist", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("dialog.cbattlechatlist", "content", "contentTextID")
  ;
  (TextManager.CheckConfig)("dialog.cbattlechatlist", "choose", "chooseTextID")
  ;
  (TextManager.CheckConfig)("dialog.cdramachatlist", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("dialog.cdramachatlist", "choose", "chooseTextID")
  ;
  (TextManager.CheckConfig)("dialog.cdramachatlist", "content", "contentTextID")
  ;
  (TextManager.CheckConfig)("dialog.cquestenddialogconfig", "content", "contentTextID")
  ;
  (TextManager.CheckConfig)("role.roleconfig", "name", "nameTextID")
  ;
  (TextManager.CheckNewIdConfig)("role.roleconfig", "title", "titleTextID", "role.cwordrole_ch")
  ;
  (TextManager.CheckConfig)("role.cattreffectidname", "classname", "classnameTextID")
  ;
  (TextManager.CheckConfig)("role.cattreffectidname", "classgrowthname", "classgrowthnameTextID")
  ;
  (TextManager.CheckConfig)("role.cbattletypecfg", "typename", "typenameTextID")
  ;
  (TextManager.CheckNewIdConfig)("role.cvocationcfg", "nameid", "nameTextID", "role.cwordrole_ch")
  ;
  (TextManager.CheckConfig)("role.cvocationcfg", "vocationDescribe", "vocationDescribeTextID")
  ;
  (TextManager.CheckNewIdConfig)("role.cracecfg", "nameid", "nameTextID", "role.cwordrole_ch")
  ;
  (TextManager.CheckChangeIdConfig)("role.csortcriteria", "nameid", "role.cwordrole_ch")
  ;
  (TextManager.CheckChangeIdConfig)("role.cscreeningconditions", "nameid", "role.cwordrole_ch")
  ;
  (TextManager.CheckChangeIdConfig)("role.cscreeningconditions", "typename", "role.cwordrole_ch")
  ;
  (TextManager.CheckConfig)("popups.cpopupgetitem", "titleText", "titleTextID")
  ;
  (TextManager.CheckConfig)("popups.cpopupgetitem", "contentText", "contentTextID")
  ;
  (TextManager.CheckConfig)("popups.cpopupdialogconfig", "Content", "ContentTextID")
  ;
  (TextManager.CheckConfig)("message.cbuttontip", "Content", "ContentTextID")
  ;
  (TextManager.CheckConfig)("message.cstringres", "msg", "msgTextID")
  ;
  (TextManager.CheckConfig)("message.ctopmessage", "msgTitle", "msgTitleTextID")
  ;
  (TextManager.CheckConfig)("message.ctopmessage", "msgNum", "msgNumTextID")
  ;
  (TextManager.CheckConfig)("message.ctopmessage", "msgMain", "msgMainTextID")
  ;
  (TextManager.CheckConfig)("message.csecondconfirm", "message", "messageTextID")
  ;
  (TextManager.CheckConfig)("message.csecondconfirm", "leftbutton", "leftbuttonTextID")
  ;
  (TextManager.CheckConfig)("message.csecondconfirm", "rightbutton", "rightbuttonTextID")
  ;
  (TextManager.CheckConfig)("message.cmessagetip", "msg", "msgTextID")
  ;
  (TextManager.CheckConfig)("message.cloadingtip", "tipMsg", "tipMsgTextID")
  ;
  (TextManager.CheckConfig)("message.cbattlemessage", "message", "messageTextID")
  ;
  (TextManager.CheckConfig)("courtyard.ccourtyardname", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("courtyard.cexplorearea", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("courtyard.cexplorearea", "destribe", "destribeTextID")
  ;
  (TextManager.CheckConfig)("courtyard.cyardskill", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("courtyard.cyardskill", "desc", "descTextID")
  ;
  (TextManager.CheckConfig)("courtyard.ccourtyardlvup", "unlockEffect", "unlockEffectTextID")
  ;
  (TextManager.CheckConfig)("courtyard.calchemyformulatype", "typeName", "typeNameTextID")
  ;
  (TextManager.CheckConfig)("courtyard.cdormfurnituretype", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("courtyard.cdormfurnituregroup", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("npc.cnpcothername", "otherName", "otherNameTextID")
  ;
  (TextManager.CheckConfig)("npc.cnpc", "Name", "NameTextID")
  ;
  (TextManager.CheckConfig)("npc.cnpcchat", "chat", "chatTextID")
  ;
  (TextManager.CheckConfig)("mission.cmissionconfig", "missionname", "missionnameTextID")
  ;
  (TextManager.CheckConfig)("mission.cmissionconfig", "location", "locationTextID")
  ;
  (TextManager.CheckConfig)("mission.cmissionconfig", "short_description", "short_descriptionTextID")
  ;
  (TextManager.CheckConfig)("mission.cmissionconfig", "description", "descriptionTextID")
  ;
  (TextManager.CheckConfig)("mission.cmissionconfig", "progressname", "progressnameTextID")
  ;
  (TextManager.CheckConfig)("mission.cdailygoldenmissionconfig", "missionname", "missionnameTextID")
  ;
  (TextManager.CheckConfig)("mission.cdailygoldenmissionconfig", "description", "descriptionTextID")
  ;
  (TextManager.CheckConfig)("mission.cdailygoldenmissionconfig", "progressname", "progressnameTextID")
  ;
  (TextManager.CheckConfig)("mission.cdailygoldenmissionconfig", "instruction", "instructionTextID")
  ;
  (TextManager.CheckConfig)("mission.cdailymissionconfig", "missionname", "missionnameTextID")
  ;
  (TextManager.CheckConfig)("mission.cdailymissionconfig", "description", "descriptionTextID")
  ;
  (TextManager.CheckConfig)("mission.cdailymissionconfig", "progressname", "progressnameTextID")
  ;
  (TextManager.CheckConfig)("mission.cdailymissionconfig", "instruction", "instructionTextID")
  ;
  (TextManager.CheckConfig)("mission.cweekmissionconfig", "missionname", "missionnameTextID")
  ;
  (TextManager.CheckConfig)("mission.cweekmissionconfig", "description", "descriptionTextID")
  ;
  (TextManager.CheckConfig)("mission.cweekmissionconfig", "progressname", "progressnameTextID")
  ;
  (TextManager.CheckConfig)("mission.cweekmissionconfig", "instruction", "instructionTextID")
  ;
  (TextManager.CheckConfig)("mission.ccoinmissionconfig", "missionname", "missionnameTextID")
  ;
  (TextManager.CheckConfig)("mission.ccoinmissionconfig", "description", "descriptionTextID")
  ;
  (TextManager.CheckConfig)("mission.cachievebadgeconfig", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("mission.cachievebadgeconfig", "description", "descriptionTextID")
  ;
  (TextManager.CheckConfig)("mission.cachievemissionconfig", "missionname", "missionnameTextID")
  ;
  (TextManager.CheckConfig)("mission.cachievemissionconfig", "description", "descriptionTextID")
  ;
  (TextManager.CheckConfig)("mission.cachievemissionconfig", "instruction", "instructionTextID")
  ;
  (TextManager.CheckConfig)("mission.ccharactermissionconfig", "missionname", "missionnameTextID")
  ;
  (TextManager.CheckConfig)("mission.ccharactermissionconfig", "location", "locationTextID")
  ;
  (TextManager.CheckConfig)("mission.ccharactermissionconfig", "short_description", "short_descriptionTextID")
  ;
  (TextManager.CheckConfig)("mission.ccharactermissionconfig", "description", "descriptionTextID")
  ;
  (TextManager.CheckConfig)("mission.ccharactermissionconfig", "progressname", "progressnameTextID")
  ;
  (TextManager.CheckConfig)("recharge.cshoptypeconfig", "Name", "NameTextID")
  ;
  (TextManager.CheckConfig)("recharge.cshoptypeshow", "TypeName", "TypeNameTextID")
  ;
  (TextManager.CheckConfig)("headphoto.cheadphotoconfig", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("headphoto.cheadphotoconfig", "description", "descriptionTextID")
  ;
  (TextManager.CheckConfig)("headphoto.cheadphotoframeconfig", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("headphoto.cheadphotoframeconfig", "description", "descriptionTextID")
  ;
  (TextManager.CheckConfig)("handbook.cmonster_handbook", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("handbook.cmonster_handbook", "area", "areaTextID")
  ;
  (TextManager.CheckConfig)("handbook.cmonster_handbook", "description", "descriptionTextID")
  ;
  (TextManager.CheckConfig)("handbook.crelationship_handbook", "relationName", "relationNameTextID")
  ;
  (TextManager.CheckConfig)("handbook.ccardroleconfig_handbook", "artist", "artistTextID")
  ;
  (TextManager.CheckConfig)("handbook.ccardroleconfig_handbook", "cv", "cvTextID")
  ;
  (TextManager.CheckNewIdConfig)("handbook.ccardroleconfig_handbook", "sex", "sexTextID", "handbook.cwordhandbook_ch")
  ;
  (TextManager.CheckConfig)("handbook.ccardroleconfig_handbook", "hobby", "hobbyTextID")
  ;
  (TextManager.CheckNewIdConfig)("handbook.ccardroleconfig_handbook", "backStory", "backStoryTextID", "handbook.cwordhandbook_ch")
  ;
  (TextManager.CheckNewIdConfig)("handbook.ccardroleconfig_handbook", "title", "titleTextID", "handbook.cword_handbook", "handbook.cwordhandbook_ch")
  ;
  (TextManager.CheckConfig)("handbook.cnpcconfig_handbook", "NPCName", "NPCNameTextID")
  ;
  (TextManager.CheckNewIdConfig)("handbook.cnpcconfig_handbook", "backStory", "backStoryTextID", "handbook.cwordhandbook_ch")
  ;
  (TextManager.CheckNewIdConfig)("handbook.cnpcconfig_handbook", "title", "titleTextID", "handbook.cword_handbook", "handbook.cwordhandbook_ch")
  ;
  (TextManager.CheckConfig)("handbook.cworldconfig_handbook", "worldName", "worldNameTextID")
  ;
  (TextManager.CheckConfig)("handbook.CAffiliation_handbook", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("handbook.CEquip_handbook", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("handbook.CEquip_handbook", "destribe", "destribeTextID")
  ;
  (TextManager.CheckChangeIdConfig)("handbook.cmonster_handbookscreeningconditions", "nameid", "handbook.cword_handbook", "handbook.cwordhandbook_ch")
  ;
  (TextManager.CheckChangeIdConfig)("handbook.cmonster_handbookscreeningconditions", "typename", "handbook.cword_handbook", "handbook.cwordhandbook_ch")
  ;
  (TextManager.CheckChangeIdConfig)("handbook.cscreeningconditions_handbook", "nameid", "handbook.cword_handbook", "handbook.cwordhandbook_ch")
  ;
  (TextManager.CheckChangeIdConfig)("handbook.csoundtitle", "otherTitle", "handbook.cword_handbook", "handbook.cwordhandbook_ch")
  ;
  (TextManager.CheckChangeIdConfig)("handbook.csoundtitle", "relationTitle", "handbook.cword_handbook", "handbook.cwordhandbook_ch")
  ;
  (TextManager.CheckConfig)("npc.cmonsterconfig", "name", "nameTextID")
  ;
  (TextManager.CheckChangeIdConfig)("equip.cequipsuitcfg", "txtid", "equip.cword_equip", "equip.cwordequip_ch")
  ;
  (TextManager.CheckChangeIdConfig)("equip.cequipsortcriteria", "nameid", "equip.cword_equip", "equip.cwordequip_ch")
  ;
  (TextManager.CheckChangeIdConfig)("equip.cequipscreeningconditions", "nameid", "equip.cword_equip", "equip.cwordequip_ch")
  ;
  (TextManager.CheckChangeIdConfig)("equip.cequipscreeningconditions", "typename", "equip.cword_equip", "equip.cwordequip_ch")
  ;
  (TextManager.CheckChangeIdConfig)("equip.cequipstrengthenitemsortcriteria", "nameid", "equip.cword_equip", "equip.cwordequip_ch")
  ;
  (TextManager.CheckChangeIdConfig)("equip.cequipstrengthenitemscreeningconditions", "nameid", "equip.cword_equip", "equip.cwordequip_ch")
  ;
  (TextManager.CheckChangeIdConfig)("equip.cequipenchantitemsortcriteria", "nameid", "equip.cword_equip", "equip.cwordequip_ch")
  ;
  (TextManager.CheckChangeIdConfig)("equip.cequipenchantitemscreeningconditions", "nameid", "equip.cword_equip", "equip.cwordequip_ch")
  ;
  (TextManager.CheckConfig)("scene.csceneinfostatic", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("item.citemattr", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("item.citemattr", "destribe", "destribeTextID")
  ;
  (TextManager.CheckConfig)("item.ccardpool", "poolName", "poolNameTextID")
  ;
  (TextManager.CheckConfig)("item.ccardpool", "describetitle", "describetitleTextID")
  ;
  (TextManager.CheckConfig)("item.ccardpool", "detaileddescribe", "detaileddescribeTextID")
  ;
  (TextManager.CheckConfig)("item.CItemClassToLoad", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cdungeonselectmainline", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cdungeonselectmainline", "describe", "describeTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cbossrush", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cweeklybossrush", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cgoblinchestconfig", "describe", "describeTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cgoblinchesteffectconfig", "effectdescribe", "effectdescribeTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cstoryconfig", "storyName", "storyNameTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cstoryconfig", "storyContent", "storyContentTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cstoryconfig", "optionOne", "optionOneTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cstoryconfig", "optionTwo", "optionTwoTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cstoryoptionconfig", "optionResultDescribe", "optionResultDescribeTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cstoryoptionconfig", "effectDescribe", "effectDescribeTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.ctowerdungeontype", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.ctowerdungeontype", "describe", "describeTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.ctowerdungeontype", "unlockdescribe", "unlockdescribeTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cresourcedungeontype", "unlockConditionDesc", "unlockConditionDescTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cresourcedungeontype", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cresourcedungeonstage", "typeName", "typeNameTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cresourcedungeonstage", "describe", "describeTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cresourcedungeonstage", "stageStrengthName", "stageStrengthNameTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cresourcedungeoninfo", "name", "nameTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cresourcedungeoninfo", "world", "worldTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cdungeonselectworld", "chapter", "chapterTextID")
  ;
  (TextManager.CheckConfig)("dungeonselect.cdungeonselectworld", "detail", "detailTextID")
end

TextManager.CheckConfig = function(configTableName, textFieldName, idFieldName)
  -- function num : 0_3 , upvalues : _ENV, TextManager
  local errorData = {}
  local configTable = (BeanManager.GetTableByName)(configTableName)
  local ids = configTable:GetAllIds()
  for i,id in ipairs(ids) do
    local record = configTable:GetRecorder(id)
    -- DECOMPILER ERROR at PC32: Unhandled construct in 'MakeBoolean' P1

    if type(record[textFieldName]) == "string" and record[textFieldName] ~= (TextManager.GetText)(record[idFieldName]) and not errorData[(TextManager.GetText)(record[idFieldName])] then
      key = record[idFieldName]
      if key ~= 0 then
        errorData[record[idFieldName]] = (TextManager.GetText)(record[idFieldName])
      end
    end
    if type(record[textFieldName]) == "table" then
      for i,v1 in ipairs(record[textFieldName]) do
        if (record[textFieldName])[i] ~= (TextManager.GetText)((record[idFieldName])[i]) and not errorData[(TextManager.GetText)((record[idFieldName])[i])] then
          key = (record[idFieldName])[i]
          if key ~= 0 then
            errorData[key] = (TextManager.GetText)((record[idFieldName])[i])
          end
        end
      end
    end
  end
  if (table.nums)(errorData) ~= 0 then
    LogError("----------------------", "----------------------")
    LogErrorFormat("TextManager", "表名:%s ,字段名:%s", configTableName, idFieldName)
    for i,v in pairs(errorData) do
      LogErrorFormat("TextManager", "错误ID:%s   内容：= %s", i, v)
    end
  else
    do
      LogError("TextManager", "Config All Right")
    end
  end
end

TextManager.CheckChangeIdConfig = function(configTableName, textFieldName, oldTableName, newTableName)
  -- function num : 0_4 , upvalues : _ENV
  local errorData = {}
  local configTable = (BeanManager.GetTableByName)(configTableName)
  local ids = configTable:GetAllIds()
  local newTable = (BeanManager.GetTableByName)(newTableName)
  local oldTable = (BeanManager.GetTableByName)(oldTableName)
  for i,id in ipairs(ids) do
    local record = configTable:GetRecorder(id)
    if type(record[textFieldName]) == "string" then
      local textID = (configTable:GetRecorder(id))[textFieldName]
      if (newTable:GetRecorder(textID)).text ~= (oldTable:GetRecorder(textID)).ch and not errorData[textID] then
        errorData[textID] = (newTable:GetRecorder(textID)).text
      end
    else
      do
        if type(record[textFieldName]) == "table" then
          for i1,v1 in ipairs(record[textFieldName]) do
            local textID = ((configTable:GetRecorder(id))[textFieldName])[i1]
            if (newTable:GetRecorder(textID)).text ~= (oldTable:GetRecorder(textID)).ch and not errorData[textID] then
              errorData[textID] = (newTable:GetRecorder(textID)).text
            end
          end
        end
        do
          -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if (table.nums)(errorData) ~= 0 then
    LogError("----------------------", "----------------------")
    LogErrorFormat("TextManager", "表名:%s", configTableName)
    for i,v in pairs(errorData) do
      LogErrorFormat("TextManager", "错误ID:%s   内容：= %s", i, v)
    end
  else
    do
      LogError("TextManager", "Config All Right")
    end
  end
end

TextManager.CheckNewIdConfig = function(configTableName, oldFieldName, newFieldName, oldTableName, newTableName)
  -- function num : 0_5 , upvalues : _ENV
  local errorData = {}
  local configTable = (BeanManager.GetTableByName)(configTableName)
  local ids = configTable:GetAllIds()
  local newTable = (BeanManager.GetTableByName)(newTableName)
  local oldTable = (BeanManager.GetTableByName)(oldTableName)
  for i,id in ipairs(ids) do
    local record = configTable:GetRecorder(id)
    if type(record[textFieldName]) == "string" then
      local oldTextID = (configTable:GetRecorder(id))[oldFieldName]
      local newTextID = (configTable:GetRecorder(id))[newFieldName]
      if (newTable:GetRecorder(newTextID)).text ~= (oldTable:GetRecorder(oldTextID)).ch and not errorData[newTextID] then
        errorData[newTextID] = (newTable:GetRecorder(newTextID)).text
      end
    else
      do
        if type(record[textFieldName]) == "table" then
          for i1,v1 in ipairs(record[textFieldName]) do
            local oldTextID = ((configTable:GetRecorder(id))[oldFieldName])[i1]
            local newTextID = ((configTable:GetRecorder(id))[newFieldName])[i1]
            if (newTable:GetRecorder(newTextID)).text ~= (oldTable:GetRecorder(oldTextID)).ch and not errorData[newTextID] then
              errorData[newTextID] = (newTable:GetRecorder(newTextID)).text
            end
          end
        end
        do
          -- DECOMPILER ERROR at PC96: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC96: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC96: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if (table.nums)(errorData) ~= 0 then
    LogError("----------------------", "----------------------")
    LogErrorFormat("TextManager", "表名:%s", configTableName)
    for i,v in pairs(errorData) do
      LogErrorFormat("TextManager", "错误ID:%s   内容：= %s", i, v)
    end
  else
    do
      LogError("TextManager", "Config All Right")
    end
  end
end

return TextManager

