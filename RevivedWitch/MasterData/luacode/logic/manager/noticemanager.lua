-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/noticemanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NoticeManager = {}
local _addr = nil
local _error = {}
local _update = {}
local _ingame = {}
local _ingamered = false
local _timers = nil
local _pending = false
local _autopopup = true
NoticeManager.Init = function()
  -- function num : 0_0 , upvalues : _ingame, _ingamered, _autopopup, _ENV, _addr
  _ingame = {
system = {}
, 
activity = {}
}
  _ingamered = false
  _autopopup = true
  local path = ((((CS.PixelNeko).P1).PackageTypeManager).GetNoticeAddrPath)()
  if path == "" or not path then
    if (SdkManager.GetChannel)() == "leit" then
      path = "noticelist_sdk.json"
    else
      if (SdkManager.GetChannel)() == "qian" then
        path = "noticelist_qian.json"
      else
        if (SdkManager.GetChannel)() == "mqan" then
          path = "noticelist_qian.json"
        else
          path = "noticelist_apps.json"
        end
      end
    end
  end
  ;
  (((((CS.PixelNeko).Lua).CfgStaticFunction).GetCfgFile)(path))
  local file = nil
  local info = nil
  if file then
    if ((((CS.PixelNeko).Lua).NewtonsoftJsonUtility).StringToDictionary)(file) then
      info = (JSON.decode)(file)
    else
      LogError("notice", "invalid json file " .. path)
    end
  else
    LogError("notice", "invalid notice server path " .. path)
  end
  local str = "%s/%s.json?time=%s"
  local id, url = nil, nil
  if (SdkManager.GetChannel)() == "none" then
    id = "notice_none"
  else
    if (SdkManager.GetChannel)() == "leit" then
      id = "notice_leit"
    else
      if (SdkManager.GetChannel)() == "qian" then
        id = "notice_qian"
      else
        if (SdkManager.GetChannel)() == "mqan" then
          id = "notice_qian"
        end
      end
    end
  end
  _addr = str:format(info.base, id, (os.time)())
end

NoticeManager.UnInit = function()
  -- function num : 0_1 , upvalues : _error, _update, _ingame, _pending, _autopopup, _timers, _ENV, _ingamered
  _error = {}
  _update = {}
  _ingame = {}
  _pending = false
  _autopopup = true
  if _timers then
    for _,v in pairs(_timers) do
      (GameTimer.RemoveTask)(v)
    end
    _timers = nil
  end
  _ingamered = false
end

local remove_standalone_p_br = function(text)
  -- function num : 0_2
  text = text:gsub("<p><br -/-></p>", "\n")
  text = text:gsub("<p>", "")
  text = text:gsub("</p>", "\n")
  text = text:gsub("<br -/->", "\n")
  return text
end

local parse_login_notice = function(json, dst)
  -- function num : 0_3 , upvalues : _ENV, remove_standalone_p_br, NoticeManager
  if json.platform ~= "Any" and json.platform ~= (SdkManager.GetPlatform)() then
    return 
  end
  if not json.visible then
    return 
  end
  local version = tonumber(json.version)
  if dst.version and version < dst.version then
    return 
  end
  dst.title = (string.restorehtmlspecialchars)(remove_standalone_p_br((NoticeManager.SimpleTransform)(json.title)))
  dst.content = (string.restorehtmlspecialchars)(remove_standalone_p_br((NoticeManager.SimpleTransform)(json.content)))
  dst.version = version
end

NoticeManager.IsPending = function()
  -- function num : 0_4 , upvalues : _pending
  return _pending
end

NoticeManager.NeedAutoPopup = function()
  -- function num : 0_5 , upvalues : _autopopup
  return _autopopup
end

NoticeManager.SetAutoPopup = function(value)
  -- function num : 0_6 , upvalues : _autopopup
  _autopopup = value
end

NoticeManager.RequestLoginNotice = function()
  -- function num : 0_7 , upvalues : _pending, _ENV, _addr, NoticeManager
  _pending = true
  ;
  (((CS.PixelNeko).NetManager).HttpGetRequestAsync)(_addr, function(result)
    -- function num : 0_7_0 , upvalues : NoticeManager, _ENV, _pending
    if not result then
      (NoticeManager.LoadDefaultLoginNotice)()
    else
      if ((((CS.PixelNeko).Lua).NewtonsoftJsonUtility).StringToDictionary)(result) then
        ((JSON.decode)(result))
        local addr = nil
        local url = nil
        if ((((CS.PixelNeko).P1).PackageTypeManager).IsTestPack)() then
          url = ((addr.test).game).url
        else
          url = ((addr.publish).game).url
        end
        ;
        (((CS.PixelNeko).NetManager).HttpGetRequestAsync)(url .. "?time=" .. tostring((os.time)()), function(result)
      -- function num : 0_7_0_0 , upvalues : _pending, NoticeManager, _ENV
      _pending = false
      if not result then
        (NoticeManager.LoadDefaultLoginNotice)()
      else
        if ((((CS.PixelNeko).Lua).NewtonsoftJsonUtility).StringToDictionary)(result) then
          (NoticeManager.ParseLoginNotice)(result)
        else
          LogError("notice", "invalid notice")
          ;
          (NoticeManager.LoadDefaultLoginNotice)()
        end
      end
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_LoginAnnouncement, NoticeManager, nil)
    end
)
      else
        do
          LogError("notice", "invalid notice")
          ;
          (NoticeManager.LoadDefaultLoginNotice)()
        end
      end
    end
  end
)
end

NoticeManager.LoadDefaultLoginNotice = function()
  -- function num : 0_8 , upvalues : _ENV, NoticeManager
  local json = ((((CS.PixelNeko).Lua).CfgStaticFunction).GetCfgFile)("default_notice.json")
  ;
  (NoticeManager.ParseLoginNotice)(json)
end

NoticeManager.ParseLoginNotice = function(json)
  -- function num : 0_9 , upvalues : _ENV, parse_login_notice, _error, _update, NoticeManager
  local list = (JSON.decode)(json)
  for _,v in ipairs(list) do
    if v.type == "error" then
      parse_login_notice(v, _error)
    else
      if v.type == "update" then
        parse_login_notice(v, _update)
      else
        LogError("notice", "invalid notice type " .. v.type)
        return 
      end
    end
  end
  local error_version, update_version = (NoticeManager.GetLocalVersion)()
  if _error.version and error_version < _error.version then
    _error.popup = true
  else
    if _update.version and update_version < _update.version then
      _update.popup = true
    end
  end
  ;
  (NoticeManager.UpdateLocalVersion)()
end

NoticeManager.GetLocalVersion = function()
  -- function num : 0_10 , upvalues : _ENV
  local error_version = (((CS.UnityEngine).PlayerPrefs).GetInt)("error_version", 0)
  local update_version = (((CS.UnityEngine).PlayerPrefs).GetInt)("update_version", 0)
  return error_version, update_version
end

NoticeManager.UpdateLocalVersion = function()
  -- function num : 0_11 , upvalues : NoticeManager, _ENV, _error, _update
  local error_version, update_version = (NoticeManager.GetLocalVersion)()
  ;
  (((CS.UnityEngine).PlayerPrefs).SetInt)("error_version", (math.max)(error_version, _error.version or 0))
  ;
  (((CS.UnityEngine).PlayerPrefs).SetInt)("update_version", (math.max)(update_version, _update.version or 0))
end

NoticeManager.GetLoginNotice = function()
  -- function num : 0_12 , upvalues : _error, _update
  return _error, _update
end

local request_ingame_notice = function(type, url)
  -- function num : 0_13 , upvalues : _ENV, _pending, NoticeManager, _ingame
  (((CS.PixelNeko).NetManager).HttpGetRequestAsync)(url .. "?time=" .. tostring((os.time)()), function(result)
    -- function num : 0_13_0 , upvalues : _pending, _ENV, NoticeManager, type, _ingame
    _pending = false
    if not result then
      return 
    end
    if ((((CS.PixelNeko).Lua).NewtonsoftJsonUtility).StringToDictionary)(result) then
      (NoticeManager.ParseInGameNotice)(type, result)
      local ingame_ver_temp = {}
      for index,value in ipairs(_ingame[type]) do
        ingame_ver_temp[index] = {}
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (ingame_ver_temp[index]).title = value.title
        -- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (ingame_ver_temp[index]).sortindex = value.sortindex
        -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (ingame_ver_temp[index]).raw = value.raw
        -- DECOMPILER ERROR at PC37: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (ingame_ver_temp[index]).showtime = value.showtime
        -- DECOMPILER ERROR at PC40: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (ingame_ver_temp[index]).hidetime = value.hidetime
        -- DECOMPILER ERROR at PC43: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (ingame_ver_temp[index]).version = value.version
      end
      ;
      (((CS.UnityEngine).PlayerPrefs).SetString)(tostring((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid) .. "_last_ingame_ver_" .. tostring(type), (JSON.encode)(ingame_ver_temp))
    else
      do
        LogError("notice", "invalid notice")
        if #_ingame.activity ~= 0 and #_ingame.system ~= 0 then
          (LuaNotificationCenter.PostNotification)(Common.n_InGameAnnouncement, NoticeManager, type)
        end
      end
    end
  end
)
end

NoticeManager.RequestInGameNotice = function()
  -- function num : 0_14 , upvalues : _pending, _ENV, _addr, request_ingame_notice
  _pending = true
  ;
  (((CS.PixelNeko).NetManager).HttpGetRequestAsync)(_addr .. "?time=" .. tostring((os.time)()), function(result)
    -- function num : 0_14_0 , upvalues : _pending, _ENV, request_ingame_notice
    _pending = false
    if result then
      if ((((CS.PixelNeko).Lua).NewtonsoftJsonUtility).StringToDictionary)(result) then
        local addr = (JSON.decode)(result)
        if ((((CS.PixelNeko).P1).PackageTypeManager).IsTestPack)() then
          request_ingame_notice("activity", ((addr.test).activity).url)
          request_ingame_notice("system", ((addr.test).system).url)
        else
          request_ingame_notice("activity", ((addr.publish).activity).url)
          request_ingame_notice("system", ((addr.publish).system).url)
        end
      else
        do
          LogError("notice", "invalid notice")
        end
      end
    end
  end
)
end

NoticeManager.RequestInGameNoticeVersionFromLocal = function()
  -- function num : 0_15 , upvalues : _ENV, _ingame
  for type,_ in pairs(_ingame) do
    local last_ingame_ver = (((CS.UnityEngine).PlayerPrefs).GetString)(tostring((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid) .. "_last_ingame_ver_" .. tostring(type), "")
    if last_ingame_ver ~= "" then
      _ingame[type] = (JSON.decode)(last_ingame_ver)
    end
  end
end

NoticeManager.GetInGameNotice = function()
  -- function num : 0_16 , upvalues : _ingame
  return _ingame
end

NoticeManager.ClearInGameNotice = function()
  -- function num : 0_17 , upvalues : _ingame, _ENV
  if _ingame then
    for key,_ in pairs(_ingame) do
      _ingame[key] = {}
    end
  end
end

local get_valid_notice_list_and_sort = function(servertime, noticeList)
  -- function num : 0_18 , upvalues : _ENV, NoticeManager
  local returnList = {}
  for _,piece in pairs(noticeList) do
    local n = {id = tonumber(piece.ID), title = piece.title, sortindex = tonumber(piece.sortindex), raw = tonumber(piece.displaytime), time = (os.date)("!*t", tonumber(piece.displaytime)), showtime = tonumber(piece.effectivedate), hidetime = tonumber(piece.whendisplay), content = (NoticeManager.Transform)(piece.content), version = tonumber(piece.version)}
    if n.showtime and servertime and n.hidetime and n.showtime < servertime and servertime < n.hidetime then
      (table.insert)(returnList, n)
    end
  end
  ;
  (table.sort)(returnList, function(lhs, rhs)
    -- function num : 0_18_0
    if lhs.sortindex >= rhs.sortindex then
      do return lhs.sortindex == rhs.sortindex end
      do return rhs.raw < lhs.raw end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  return returnList
end

local get_valid_notice_list_and_sort_minimal = function(servertime, noticeList)
  -- function num : 0_19 , upvalues : _ENV
  local returnList = {}
  for _,piece in pairs(noticeList) do
    local n = {title = piece.title, sortindex = tonumber(piece.sortindex), raw = tonumber(piece.displaytime), showtime = tonumber(piece.effectivedate), hidetime = tonumber(piece.whendisplay), version = tonumber(piece.version)}
    if n.showtime and servertime and n.hidetime and n.showtime < servertime and servertime < n.hidetime then
      (table.insert)(returnList, n)
    end
  end
  ;
  (table.sort)(returnList, function(lhs, rhs)
    -- function num : 0_19_0
    if lhs.sortindex >= rhs.sortindex then
      do return lhs.sortindex == rhs.sortindex end
      do return rhs.raw < lhs.raw end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  return returnList
end

NoticeManager.ParseInGameNotice = function(type, json)
  -- function num : 0_20 , upvalues : _ENV, _ingame, get_valid_notice_list_and_sort
  local list = (JSON.decode)(json)
  local servertime = (ServerGameTimer.GetServerTime)() / 1000
  _ingame[type] = get_valid_notice_list_and_sort(servertime, list)
end

local check_ingame_notice = function(type, result)
  -- function num : 0_21 , upvalues : _ENV, get_valid_notice_list_and_sort_minimal, _ingame
  local list = (JSON.decode)(result)
  local servertime = (ServerGameTimer.GetServerTime)() / 1000
  local validList = get_valid_notice_list_and_sort_minimal(servertime, list)
  if #_ingame[type] ~= #validList then
    return true
  end
  for i = 1, #validList do
    local lhs = (_ingame[type])[i]
    local rhs = validList[i]
    if lhs.title ~= rhs.title or lhs.version ~= tonumber(rhs.version) then
      return true
    end
  end
  return false
end

NoticeManager.CheckNewInGameNotice = function()
  -- function num : 0_22 , upvalues : _ENV, check_ingame_notice, _ingamered, NoticeManager, _timers, _addr
  local request = function(type, url)
    -- function num : 0_22_0 , upvalues : _ENV, check_ingame_notice, _ingamered, NoticeManager
    (((CS.PixelNeko).NetManager).HttpGetRequestAsync)(url .. "?time=" .. tostring((os.time)()), function(result)
      -- function num : 0_22_0_0 , upvalues : _ENV, check_ingame_notice, type, _ingamered, NoticeManager, url
      if not result then
        return 
      end
      if ((((CS.PixelNeko).Lua).NewtonsoftJsonUtility).StringToDictionary)(result) then
        if check_ingame_notice(type, result) then
          _ingamered = true
          ;
          (LuaNotificationCenter.PostNotification)(Common.n_NewInGameAnnouncement, NoticeManager)
          print("new notice", type, url, (debug.traceback)())
        else
          _ingamered = false
          print("no new notice", type, url)
        end
      end
    end
)
  end

  if not _timers then
    _timers = {(GameTimer.AddTask)(60, 60, function()
    -- function num : 0_22_1 , upvalues : _ENV, _addr, request
    (((CS.PixelNeko).NetManager).HttpGetRequestAsync)(_addr .. "?time=" .. tostring((os.time)()), function(result)
      -- function num : 0_22_1_0 , upvalues : _ENV, request
      if not result then
        return 
      end
      if ((((CS.PixelNeko).Lua).NewtonsoftJsonUtility).StringToDictionary)(result) then
        local addr = (JSON.decode)(result)
        if ((((CS.PixelNeko).P1).PackageTypeManager).IsTestPack)() then
          request("activity", ((addr.test).activity).url)
          request("system", ((addr.test).system).url)
        else
          request("activity", ((addr.publish).activity).url)
          request("system", ((addr.publish).system).url)
        end
      else
        do
          LogError("notice", "invalid notice")
        end
      end
    end
)
  end
)}
  end
end

NoticeManager.SetInGameRedPoint = function(pt)
  -- function num : 0_23 , upvalues : _ingamered
  _ingamered = pt
end

NoticeManager.GetInGameRedPoint = function()
  -- function num : 0_24 , upvalues : _ingamered
  return _ingamered
end

local preprocess_link = function(link)
  -- function num : 0_25 , upvalues : _ENV
  if (string.find)(link:lower(), "^goto.*gacha.*") then
    LogInfo("noticemanager", "preprocess_link have create protocol with protocol.card.crefreshcardui")
    ;
    ((LuaNetManager.CreateProtocol)("protocol.card.crefreshcardui")):Send()
  end
end

local preprocess_card_link = function(card_link)
  -- function num : 0_26 , upvalues : _ENV
  LogInfo("noticemanager", "preprocess_link have create protocol with protocol.card.crefreshcardui")
  ;
  ((LuaNetManager.CreateProtocol)("protocol.card.crefreshcardui")):Send()
end

local tagHeadPattern = "<(%w+)%s*(.-)>"
local emptyPattern = "^%s*$"
local _parseHTML2Table = nil
_parseHTML2Table = function(text, index, rootNode, fatherNode)
  -- function num : 0_27 , upvalues : _ENV, tagHeadPattern, emptyPattern, _parseHTML2Table
  local i, j = nil, nil
  local newNode = {}
  ;
  (table.insert)(rootNode, newNode)
  i = index
  local _, en, g1, g2 = (string.find)(text, tagHeadPattern, i)
  newNode.tag = g1
  newNode.attr = g2
  newNode.content = {}
  newNode.father = fatherNode
  i = en + 1
  j = i
  while 1 do
    local isEndFind, endFind = (string.startWith)(text, "</" .. newNode.tag, j)
    if isEndFind then
      local preContent = (string.sub)(text, i, j - 1)
      if preContent ~= nil and (string.find)(preContent, emptyPattern) == nil then
        (table.insert)(newNode.content, preContent)
      end
      j = endFind[2] + 2
      break
    else
      do
        if (string.startWith)(text, tagHeadPattern, j) then
          local preContent = (string.sub)(text, i, j - 1)
          if preContent ~= nil and (string.find)(preContent, emptyPattern) == nil then
            (table.insert)(newNode.content, preContent)
          end
          j = _parseHTML2Table(text, j, newNode.content, newNode) - 1
          i = j + 1
        else
          do
            do
              if (string.len)(text) < j then
                LogError("noticemanager", "ERROR! parseHTML2Table Out of index!")
                break
              end
              j = j + 1
              -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  return j
end

local pretreatmentPattern1 = {
{"<a%s+href%s*=%s*\"%s*goto%s*:%s*gacha%s*/%s*(.-)\".->", preprocess_card_link}
}
local pretreatmentPattern2 = {
{"<(.-)%s*(/?)>", "<%1%2>"}
, 
{"<img(%s*.-)/?>", "<img%1></img>"}
, 
{"<p></?br/?></p>", "<br>"}
, 
{"</?br/?>", "<br></br>"}
, 
{"ql%-align%-right", "right"}
, 
{"ql%-align%-center", "center"}
, 
{"ql%-align%-justify", "justify"}
, 
{"</?hr/?>", ""}
, 
{"</?pre>", ""}
}
local parseHTML2Table = function(text, index)
  -- function num : 0_28 , upvalues : _ENV, pretreatmentPattern1, pretreatmentPattern2, _parseHTML2Table
  local rootNode = {}
  for _,pattern in pairs(pretreatmentPattern1) do
    local tmpRes = select(3, (string.find)(text, pattern[1]))
    if tmpRes ~= nil then
      (pattern[2])(tmpRes)
    end
  end
  for _,pattern in pairs(pretreatmentPattern2) do
    text = (string.gsub)(text, pattern[1], pattern[2])
  end
  text = (string.format)("<root>%s</root>", text)
  local resultI = _parseHTML2Table(text, index, rootNode)
  do return rootNode, resultI == (string.len)(text) + 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local tag2Text = function(content)
  -- function num : 0_29
  return {content = content, 
attrs = {text = true}
}
end

local tag2Color = function(node, content)
  -- function num : 0_30 , upvalues : _ENV
  local attr = node.attr
  if attr ~= nil then
    attr = (string.gsub)(attr, "style%s-=%s-[\'\"]color%s-:%s-rgb%((%d-),%s-(%d-),%s-(%d-)%);?[\'\"]", function(r, g, b)
    -- function num : 0_30_0 , upvalues : _ENV
    return (string.format)("style=\"color:#%02X%02X%02X;\"", r, g, b)
  end
)
    _ = (string.find)(attr, "style%s-=%s-[\'\"]color%s-:%s-([#%w]-);?[\'\"]")
    return (string.format)("<color=%s>%s</color>", attr, content)
  else
    return (string.format)("<color>%s</color>", content)
  end
end

local tag2Link = function(node, content)
  -- function num : 0_31 , upvalues : _ENV
  local attr = node.attr
  if attr ~= nil then
    _ = (string.find)(attr, "href%s-=%s-[\'\"](.-)[\'\"]")
    return (string.format)("<link=%s>%s</link>", attr, content)
  else
    return (string.format)("<link>%s</link>", content)
  end
end

local tag2B = function(content)
  -- function num : 0_32 , upvalues : _ENV
  return (string.format)("<b>%s</b>", content)
end

local tag2I = function(content)
  -- function num : 0_33 , upvalues : _ENV
  return (string.format)("<i>%s</i>", content)
end

local tagBR = function()
  -- function num : 0_34
  return "\n"
end

local tagDivP = function(node, content)
  -- function num : 0_35 , upvalues : _ENV
  do
    if node.attr then
      local _, _, align = (string.find)(node.attr, "class%s-=%s-\"(.-)\"")
      if align ~= nil then
        return {content = content, 
attrs = {align = align}
}
      end
    end
    return (string.format)("%s\n", content)
  end
end

local tagH1 = function(content)
  -- function num : 0_36
  return {content = content, 
attrs = {level = 1}
}
end

local tagH2 = function(content)
  -- function num : 0_37
  return {content = content, 
attrs = {level = 2}
}
end

local tagImg = function(node)
  -- function num : 0_38 , upvalues : _ENV
  local attr = node.attr
  if attr ~= nil then
    local _, _, url, width, height = (string.find)(attr, "src%s-=%s-\"(.*)%?width=(%d+)%+height=(%d+)\"")
    local link = nil
    -- DECOMPILER ERROR at PC25: Overwrote pending register: R3 in 'AssignReg'

    if (node.father).tag == "a" and (node.father).attr ~= nil then
      do return {content = url, 
attrs = {img = true, width = width, height = height, link = link}
} end
    end
  end
end

local _htmlNode2SpeTMP = nil
_htmlNode2SpeTMP = function(rootNode, resTable)
  -- function num : 0_39 , upvalues : _ENV, _htmlNode2SpeTMP, tagDivP, tagH1, tagH2, tag2Link, tag2Color, tagImg, tagBR, tag2B, tag2I, tag2Text
  local res = {}
  local attachRes = {}
  local tempRes = nil
  for i = 1, #rootNode do
    local node = rootNode[i]
    if next(attachRes) == nil then
      do
        if type(node) == "table" then
          tempRes = _htmlNode2SpeTMP(node.content, resTable)
          if next(attachRes) == nil then
            rootNode[i] = -1
          end
          -- DECOMPILER ERROR at PC42: Unhandled construct in 'MakeBoolean' P1

          if (node.tag == "p" or node.tag == "div") and tempRes ~= "" then
            tempRes = tagDivP(node, tempRes)
            if type(tempRes) == "string" then
              (table.insert)(res, tempRes)
            else
              ;
              (table.insert)(attachRes, 1, tempRes)
            end
          end
          -- DECOMPILER ERROR at PC69: Unhandled construct in 'MakeBoolean' P1

          if node.tag == "h1" and tempRes ~= "" then
            tempRes = tagH1(tempRes)
            ;
            (table.insert)(attachRes, 1, tempRes)
          end
          -- DECOMPILER ERROR at PC85: Unhandled construct in 'MakeBoolean' P1

          if node.tag == "h2" and tempRes ~= "" then
            tempRes = tagH2(tempRes)
            ;
            (table.insert)(attachRes, 1, tempRes)
          end
          -- DECOMPILER ERROR at PC102: Unhandled construct in 'MakeBoolean' P1

          if node.tag == "a" and tempRes ~= "" then
            tempRes = tag2Link(node, tempRes)
            ;
            (table.insert)(res, tempRes)
          end
          -- DECOMPILER ERROR at PC118: Unhandled construct in 'MakeBoolean' P1

          if node.tag == "span" and tempRes ~= "" then
            tempRes = tag2Color(node, tempRes)
            ;
            (table.insert)(res, tempRes)
          end
          if node.tag == "img" then
            tempRes = tagImg(node)
            ;
            (table.insert)(attachRes, 1, tempRes)
          else
            if node.tag == "br" then
              tempRes = tagBR()
              ;
              (table.insert)(res, tempRes)
            else
              -- DECOMPILER ERROR at PC159: Unhandled construct in 'MakeBoolean' P1

              if node.tag == "strong" and tempRes ~= "" then
                tempRes = tag2B(tempRes)
                tempRes = tag2Color(node, tempRes)
                ;
                (table.insert)(res, tempRes)
              end
            end
          end
          -- DECOMPILER ERROR at PC179: Unhandled construct in 'MakeBoolean' P1

          if node.tag == "address" and tempRes ~= "" then
            tempRes = tag2I(tempRes)
            ;
            (table.insert)(res, tempRes)
          end
          if node.tag == "root" then
            if tempRes ~= "" then
              (table.insert)(resTable, tag2Text(tempRes))
            end
            if next(attachRes) ~= nil then
              for _,value in ipairs(attachRes) do
                (table.insert)(resTable, value)
              end
              return false
            end
            return true
          else
            LogWarning("noticemanager", (string.format)("ERROR! htmlNode2SpeTMP find unknown tag \"%s\"! The tag has been skipped.", node.tag))
          end
        else
          if type(node) == "string" then
            (table.insert)(res, node)
            rootNode[i] = -1
          end
        end
        -- DECOMPILER ERROR at PC239: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC239: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  return (table.concat)(res), attachRes
end

local htmlNode2SpeTMP = function(resNode)
  -- function num : 0_40 , upvalues : _htmlNode2SpeTMP
  local resTable = {}
  local loopLimit = 100
  while not _htmlNode2SpeTMP(resNode, resTable) and loopLimit > 0 do
    loopLimit = loopLimit - 1
  end
  do return resTable, loopLimit ~= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

NoticeManager.Transform = function(text)
  -- function num : 0_41 , upvalues : _ENV, parseHTML2Table, htmlNode2SpeTMP
  if text == nil then
    LogError("noticemanager", "Transform text is nil!")
  end
  local resNode, isSuccess1 = parseHTML2Table(text, 1)
  if not isSuccess1 then
    LogError("noticemanager", "parseHTML2Table failed!")
  end
  local restable, isSuccess2 = htmlNode2SpeTMP(resNode)
  if not isSuccess2 then
    LogError("noticemanager", "htmlNode2SpeTMP failed!")
  end
  return restable
end

NoticeManager.SimpleTransform = function(text)
  -- function num : 0_42 , upvalues : _ENV, preprocess_link
  local result = text
  local pattern = "<(.-) .-></%1>"
  while result:find(pattern) do
    result = result:gsub(pattern, "")
  end
  result = result:gsub("<span style=\'color -: -([#%w]-);\'>(.-)</span>", "<color=%1>%2</color>")
  result = result:gsub("(<span style=\"color -: -rgb%((%d-), -(%d-), -(%d-)%);\">(.-)</span>)", function(_, r, g, b, content)
    -- function num : 0_42_0 , upvalues : _ENV
    return (string.gsub)("<color=$rgb$>$content$</color>", "%$(.-)%$", {rgb = (string.format)("#%02X%02X%02X", r, g, b), content = content})
  end
)
  result = result:gsub("<strong style=\'color -: -([#%w]-);\'>(.-)</strong>", "<b><color=%1>%2</color></b>")
  result = result:gsub("(<strong style=\"color -: -rgb%((%d-), -(%d-), -(%d-)%);\">(.-)</strong>)", function(_, r, g, b, content)
    -- function num : 0_42_1 , upvalues : _ENV
    return (string.gsub)("<b><color=$rgb$>$content$</color></b>", "%$(.-)%$", {rgb = (string.format)("#%02X%02X%02X", r, g, b), content = content})
  end
)
  result = result:gsub("(</?)strong>", "%1b>")
  result = result:gsub("(</?)address>", "%1i>")
  result = result:gsub("</?pre>", "")
  result = result:gsub("<a href=\"(.-)\".->", function(match)
    -- function num : 0_42_2 , upvalues : preprocess_link, _ENV
    preprocess_link(match)
    return (string.gsub)("<link=\"%1\">", "%%1", match)
  end
)
  result = result:gsub("</a>", "</link>")
  result = result:gsub("<p><br -/-></p>", "\n")
  return result
end

return NoticeManager

