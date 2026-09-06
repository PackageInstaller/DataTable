local NoticeManager = {}
local _addr
local _error = {}
local _update = {}
local _ingame = {}
local _ingamered = false
local _timers
local _pending = false
local _autopopup = true

function NoticeManager.Init()
  _ingame = {
    system = {},
    activity = {}
  }
  _ingamered = false
  _autopopup = true
  local path = CS.PixelNeko.P1.PackageTypeManager.GetNoticeAddrPath()
  if path == "" or not path then
    if SdkManager.GetChannel() == "leit" then
      path = "noticelist_sdk.json"
    elseif SdkManager.GetChannel() == "qian" then
      path = "noticelist_qian.json"
    elseif SdkManager.GetChannel() == "mqan" then
      path = "noticelist_qian.json"
    elseif SdkManager.GetChannel() == "quka" or SdkManager.GetChannel() == "qukb" then
      path = "noticelist_qian.json"
    else
      path = "noticelist_apps.json"
    end
  end
  local file = CS.PixelNeko.Lua.CfgStaticFunction.GetCfgFile(path)
  local info
  if file then
    if CS.PixelNeko.Lua.NewtonsoftJsonUtility.StringToDictionary(file) then
      info = JSON.decode(file)
    else
      LogError("notice", "invalid json file " .. path)
    end
  else
    LogError("notice", "invalid notice server path " .. path)
  end
  local str = "%s/%s.json"
  local id, url
  if SdkManager.GetChannel() == "none" then
    id = "notice_none"
  elseif SdkManager.GetChannel() == "leit" then
    id = "notice_leit"
  elseif SdkManager.GetChannel() == "qian" then
    id = "notice_qian"
  elseif SdkManager.GetChannel() == "mqan" then
    id = "notice_qian"
  elseif SdkManager.GetChannel() == "quka" or SdkManager.GetChannel() == "qukb" then
    id = "notice_qian"
  end
  _addr = str:format(info.base, id)
end

function NoticeManager.UnInit()
  _error = {}
  _update = {}
  _ingame = {}
  _pending = false
  _autopopup = true
  if _timers then
    for _, v in pairs(_timers) do
      GameTimer.RemoveTask(v)
    end
    _timers = nil
  end
  _ingamered = false
end

local function remove_standalone_p_br(text)
  text = text:gsub("<p><br -/-></p>", "\n")
  text = text:gsub("<p>", "")
  text = text:gsub("</p>", "\n")
  text = text:gsub("<br -/->", "\n")
  return text
end

local function parse_login_notice(json, dst)
  if json.platform ~= "Any" and json.platform ~= SdkManager.GetPlatform() then
    return
  end
  if not json.visible then
    return
  end
  local version = tonumber(json.version)
  if dst.version and version < dst.version then
    return
  end
  dst.title = string.restorehtmlspecialchars(remove_standalone_p_br(NoticeManager.SimpleTransform(json.title)))
  dst.content = string.restorehtmlspecialchars(remove_standalone_p_br(NoticeManager.SimpleTransform(json.content)))
  dst.version = version
end

function NoticeManager.IsPending()
  return _pending
end

function NoticeManager.NeedAutoPopup()
  return _autopopup
end

function NoticeManager.SetAutoPopup(value)
  _autopopup = value
end

function NoticeManager.LoadDefaultLoginNotice()
  local json = CS.PixelNeko.Lua.CfgStaticFunction.GetCfgFile("default_notice.json")
  NoticeManager.ParseLoginNotice(json)
end

function NoticeManager.ParseLoginNotice(json)
  local list = JSON.decode(json)
  for _, v in ipairs(list) do
    if v.type == "error" then
      parse_login_notice(v, _error)
    elseif v.type == "update" then
      parse_login_notice(v, _update)
    else
      LogError("notice", "invalid notice type " .. v.type)
      return
    end
  end
  local error_version, update_version = NoticeManager.GetLocalVersion()
  if _error.version and error_version < _error.version then
    _error.popup = true
  elseif _update.version and update_version < _update.version then
    _update.popup = true
  end
  NoticeManager.UpdateLocalVersion()
end

function NoticeManager.GetLocalVersion()
  local error_version = CS.UnityEngine.PlayerPrefs.GetInt("error_version", 0)
  local update_version = CS.UnityEngine.PlayerPrefs.GetInt("update_version", 0)
  return error_version, update_version
end

function NoticeManager.UpdateLocalVersion()
  local error_version, update_version = NoticeManager.GetLocalVersion()
  CS.UnityEngine.PlayerPrefs.SetInt("error_version", math.max(error_version, _error.version or 0))
  CS.UnityEngine.PlayerPrefs.SetInt("update_version", math.max(update_version, _update.version or 0))
end

function NoticeManager.GetLoginNotice()
  return _error, _update
end

local function request_ingame_notice(type, url)
  CS.PixelNeko.NetManager.HttpGetRequestAsync(url, function(result)
    _pending = false
    if not result then
      return
    end
    if CS.PixelNeko.Lua.NewtonsoftJsonUtility.StringToDictionary(result) then
      NoticeManager.ParseInGameNotice(type, result)
      local ingame_ver_temp = {}
      for index, value in ipairs(_ingame[type]) do
        ingame_ver_temp[index] = {}
        ingame_ver_temp[index].title = value.title
        ingame_ver_temp[index].sortindex = value.sortindex
        ingame_ver_temp[index].raw = value.raw
        ingame_ver_temp[index].showtime = value.showtime
        ingame_ver_temp[index].hidetime = value.hidetime
        ingame_ver_temp[index].version = value.version
      end
      CS.UnityEngine.PlayerPrefs.SetString(tostring(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid) .. "_last_ingame_ver_" .. tostring(type), JSON.encode(ingame_ver_temp))
    else
      LogError("notice", "invalid notice")
    end
    if #_ingame.activity ~= 0 and #_ingame.system ~= 0 then
      LuaNotificationCenter.PostNotification(Common.n_InGameAnnouncement, NoticeManager, type)
    end
  end)
end

function NoticeManager.RequestInGameNotice()
  _pending = true
  CS.PixelNeko.NetManager.HttpGetRequestAsync(_addr, function(result)
    _pending = false
    if result then
      if CS.PixelNeko.Lua.NewtonsoftJsonUtility.StringToDictionary(result) then
        local addr = JSON.decode(result)
        if CS.PixelNeko.P1.PackageTypeManager.IsTestPack() then
          request_ingame_notice("activity", addr.test.activity.url)
          request_ingame_notice("system", addr.test.system.url)
        else
          request_ingame_notice("activity", addr.publish.activity.url)
          request_ingame_notice("system", addr.publish.system.url)
        end
      else
        LogError("notice", "invalid notice")
      end
    end
  end)
end

function NoticeManager.RequestInGameNoticeVersionFromLocal()
  for type, _ in pairs(_ingame) do
    local last_ingame_ver = CS.UnityEngine.PlayerPrefs.GetString(tostring(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid) .. "_last_ingame_ver_" .. tostring(type), "")
    if last_ingame_ver ~= "" then
      _ingame[type] = JSON.decode(last_ingame_ver)
    end
  end
end

function NoticeManager.GetInGameNotice()
  return _ingame
end

function NoticeManager.ClearInGameNotice()
  if _ingame then
    for key, _ in pairs(_ingame) do
      _ingame[key] = {}
    end
  end
end

local function get_valid_notice_list_and_sort(servertime, noticeList)
  local returnList = {}
  for _, piece in pairs(noticeList) do
    local n = {
      id = tonumber(piece.ID),
      title = piece.title,
      sortindex = tonumber(piece.sortindex),
      raw = tonumber(piece.displaytime),
      time = os.date("!*t", tonumber(piece.displaytime)),
      showtime = tonumber(piece.effectivedate),
      hidetime = tonumber(piece.whendisplay),
      content = NoticeManager.Transform(piece.content),
      version = tonumber(piece.version)
    }
    if n.showtime and servertime and n.hidetime and servertime > n.showtime and servertime < n.hidetime then
      table.insert(returnList, n)
    end
  end
  table.sort(returnList, function(lhs, rhs)
    if lhs.sortindex ~= rhs.sortindex then
      return lhs.sortindex < rhs.sortindex
    else
      return lhs.raw > rhs.raw
    end
  end)
  return returnList
end

local function get_valid_notice_list_and_sort_minimal(servertime, noticeList)
  local returnList = {}
  for _, piece in pairs(noticeList) do
    local n = {
      title = piece.title,
      sortindex = tonumber(piece.sortindex),
      raw = tonumber(piece.displaytime),
      showtime = tonumber(piece.effectivedate),
      hidetime = tonumber(piece.whendisplay),
      version = tonumber(piece.version)
    }
    if n.showtime and servertime and n.hidetime and servertime > n.showtime and servertime < n.hidetime then
      table.insert(returnList, n)
    end
  end
  table.sort(returnList, function(lhs, rhs)
    if lhs.sortindex ~= rhs.sortindex then
      return lhs.sortindex < rhs.sortindex
    else
      return lhs.raw > rhs.raw
    end
  end)
  return returnList
end

function NoticeManager.ParseInGameNotice(type, json)
  local list = JSON.decode(json)
  local servertime = ServerGameTimer.GetServerTime() / 1000
  _ingame[type] = get_valid_notice_list_and_sort(servertime, list)
end

local function check_ingame_notice(type, result)
  local list = JSON.decode(result)
  local servertime = ServerGameTimer.GetServerTime() / 1000
  local validList = get_valid_notice_list_and_sort_minimal(servertime, list)
  if #_ingame[type] ~= #validList then
    return true
  end
  for i = 1, #validList do
    local lhs = _ingame[type][i]
    local rhs = validList[i]
    if lhs.title ~= rhs.title or lhs.version ~= tonumber(rhs.version) then
      return true
    end
  end
  return false
end

function NoticeManager.CheckNewInGameNotice()
  local function request(type, url)
    CS.PixelNeko.NetManager.HttpGetRequestAsync(url, function(result)
      if not result then
        return
      end
      if CS.PixelNeko.Lua.NewtonsoftJsonUtility.StringToDictionary(result) then
        if check_ingame_notice(type, result) then
          _ingamered = true
          LuaNotificationCenter.PostNotification(Common.n_NewInGameAnnouncement, NoticeManager)
          print("new notice", type, url, debug.traceback())
        else
          _ingamered = false
          print("no new notice", type, url)
        end
      end
    end)
  end
  
  if not _timers then
    _timers = {
      GameTimer.AddTask(60, 60, function()
        CS.PixelNeko.NetManager.HttpGetRequestAsync(_addr, function(result)
          if not result then
            return
          end
          if CS.PixelNeko.Lua.NewtonsoftJsonUtility.StringToDictionary(result) then
            local addr = JSON.decode(result)
            if CS.PixelNeko.P1.PackageTypeManager.IsTestPack() then
              request("activity", addr.test.activity.url)
              request("system", addr.test.system.url)
            else
              request("activity", addr.publish.activity.url)
              request("system", addr.publish.system.url)
            end
          else
            LogError("notice", "invalid notice")
          end
        end)
      end)
    }
  end
end

function NoticeManager.SetInGameRedPoint(pt)
  _ingamered = pt
end

function NoticeManager.GetInGameRedPoint()
  return _ingamered
end

local function preprocess_link(link)
  if string.find(link:lower(), "^goto.*gacha.*") then
    LogInfo("noticemanager", "preprocess_link have create protocol with protocol.card.crefreshcardui")
    LuaNetManager.CreateProtocol("protocol.card.crefreshcardui"):Send()
  end
end

local function preprocess_card_link(card_link)
  LogInfo("noticemanager", "preprocess_link have create protocol with protocol.card.crefreshcardui")
  LuaNetManager.CreateProtocol("protocol.card.crefreshcardui"):Send()
end

local tagHeadPattern = "<(%w+)%s*(.-)>"
local emptyPattern = "^%s*$"
local _parseHTML2Table

function _parseHTML2Table(text, index, rootNode, fatherNode)
  local i, j
  local newNode = {}
  table.insert(rootNode, newNode)
  i = index
  local _, en, g1, g2 = string.find(text, tagHeadPattern, i)
  newNode.tag = g1
  newNode.attr = g2
  newNode.content = {}
  newNode.father = fatherNode
  i = en + 1
  j = i
  while true do
    local isEndFind, endFind = string.startWith(text, "</" .. newNode.tag, j)
    if isEndFind then
      local preContent = string.sub(text, i, j - 1)
      if preContent ~= nil and string.find(preContent, emptyPattern) == nil then
        table.insert(newNode.content, preContent)
      end
      j = endFind[2] + 2
      break
    elseif string.startWith(text, tagHeadPattern, j) then
      local preContent = string.sub(text, i, j - 1)
      if preContent ~= nil and string.find(preContent, emptyPattern) == nil then
        table.insert(newNode.content, preContent)
      end
      j = _parseHTML2Table(text, j, newNode.content, newNode) - 1
      i = j + 1
    elseif j > string.len(text) then
      LogError("noticemanager", "ERROR! parseHTML2Table Out of index!")
      break
    end
    j = j + 1
  end
  return j
end

local pretreatmentPattern1 = {
  {
    "<a%s+href%s*=%s*\"%s*goto%s*:%s*gacha%s*/%s*(.-)\".->",
    preprocess_card_link
  }
}
local pretreatmentPattern2 = {
  {
    "<(.-)%s*(/?)>",
    "<%1%2>"
  },
  {
    "<img(%s*.-)/?>",
    "<img%1></img>"
  },
  {
    "<p></?br/?></p>",
    "<br>"
  },
  {"</?br/?>", "<br></br>"},
  {
    "ql%-align%-right",
    "right"
  },
  {
    "ql%-align%-center",
    "center"
  },
  {
    "ql%-align%-justify",
    "justify"
  },
  {"</?hr/?>", ""},
  {"</?pre>", ""}
}

local function parseHTML2Table(text, index)
  local rootNode = {}
  for _, pattern in pairs(pretreatmentPattern1) do
    local tmpRes = select(3, string.find(text, pattern[1]))
    if tmpRes ~= nil then
      pattern[2](tmpRes)
    end
  end
  for _, pattern in pairs(pretreatmentPattern2) do
    text = string.gsub(text, pattern[1], pattern[2])
  end
  text = string.format("<root>%s</root>", text)
  local resultI = _parseHTML2Table(text, index, rootNode)
  return rootNode, resultI == string.len(text) + 1
end

local function tag2Text(content)
  return {
    content = content,
    attrs = {text = true}
  }
end

local function tag2Color(node, content)
  local attr = node.attr
  if attr ~= nil then
    attr = string.gsub(attr, "style%s-=%s-['\"]color%s-:%s-rgb%((%d-),%s-(%d-),%s-(%d-)%);?['\"]", function(r, g, b)
      return string.format("style=\"color:#%02X%02X%02X;\"", r, g, b)
    end)
    _, _, attr = string.find(attr, "style%s-=%s-['\"]color%s-:%s-([#%w]-);?['\"]")
    return string.format("<color=%s>%s</color>", attr, content)
  else
    return string.format("<color>%s</color>", content)
  end
end

local function tag2Link(node, content)
  local attr = node.attr
  if attr ~= nil then
    _, _, attr = string.find(attr, "href%s-=%s-['\"](.-)['\"]")
    return string.format("<link=%s>%s</link>", attr, content)
  else
    return string.format("<link>%s</link>", content)
  end
end

local function tag2B(content)
  return string.format("<b>%s</b>", content)
end

local function tag2I(content)
  return string.format("<i>%s</i>", content)
end

local function tagBR()
  return "\n"
end

local function tagDivP(node, content)
  if node.attr then
    local _, _, align = string.find(node.attr, "class%s-=%s-\"(.-)\"")
    if align ~= nil then
      return {
        content = content,
        attrs = {align = align}
      }
    end
  end
  return string.format("%s\n", content)
end

local function tagH1(content)
  return {
    content = content,
    attrs = {level = 1}
  }
end

local function tagH2(content)
  return {
    content = content,
    attrs = {level = 2}
  }
end

local function tagImg(node)
  local attr = node.attr
  if attr ~= nil then
    local _, _, url, width, height = string.find(attr, "src%s-=%s-\"(.*)%?width=(%d+)%+height=(%d+)\"")
    local link
    if node.father.tag == "a" and node.father.attr ~= nil then
      _, _, link = string.find(node.father.attr, "href%s-=%s-['\"](.-)['\"]")
    end
    return {
      content = url,
      attrs = {
        img = true,
        width = width,
        height = height,
        link = link
      }
    }
  end
end

local _htmlNode2SpeTMP

function _htmlNode2SpeTMP(rootNode, resTable)
  local res = {}
  local attachRes = {}
  local tempRes
  for i = 1, #rootNode do
    local node = rootNode[i]
    if next(attachRes) ~= nil then
      break
    end
    if type(node) == "table" then
      tempRes, attachRes = _htmlNode2SpeTMP(node.content, resTable)
      if next(attachRes) == nil then
        rootNode[i] = -1
      end
      if node.tag == "p" or node.tag == "div" then
        if tempRes ~= "" then
          tempRes = tagDivP(node, tempRes)
          if type(tempRes) == "string" then
            table.insert(res, tempRes)
          else
            table.insert(attachRes, 1, tempRes)
          end
        end
      elseif node.tag == "h1" then
        if tempRes ~= "" then
          tempRes = tagH1(tempRes)
          table.insert(attachRes, 1, tempRes)
        end
      elseif node.tag == "h2" then
        if tempRes ~= "" then
          tempRes = tagH2(tempRes)
          table.insert(attachRes, 1, tempRes)
        end
      elseif node.tag == "a" then
        if tempRes ~= "" then
          tempRes = tag2Link(node, tempRes)
          table.insert(res, tempRes)
        end
      elseif node.tag == "span" then
        if tempRes ~= "" then
          tempRes = tag2Color(node, tempRes)
          table.insert(res, tempRes)
        end
      elseif node.tag == "img" then
        tempRes = tagImg(node)
        table.insert(attachRes, 1, tempRes)
      elseif node.tag == "br" then
        tempRes = tagBR()
        table.insert(res, tempRes)
      elseif node.tag == "strong" then
        if tempRes ~= "" then
          tempRes = tag2B(tempRes)
          tempRes = tag2Color(node, tempRes)
          table.insert(res, tempRes)
        end
      elseif node.tag == "address" then
        if tempRes ~= "" then
          tempRes = tag2I(tempRes)
          table.insert(res, tempRes)
        end
      elseif node.tag == "root" then
        if tempRes ~= "" then
          table.insert(resTable, tag2Text(tempRes))
        end
        if next(attachRes) ~= nil then
          for _, value in ipairs(attachRes) do
            table.insert(resTable, value)
          end
          return false
        end
        return true
      else
        LogWarning("noticemanager", string.format("ERROR! htmlNode2SpeTMP find unknown tag \"%s\"! The tag has been skipped.", node.tag))
      end
    elseif type(node) == "string" then
      table.insert(res, node)
      rootNode[i] = -1
    end
  end
  return table.concat(res), attachRes
end

local function htmlNode2SpeTMP(resNode)
  local resTable = {}
  local loopLimit = 100
  while not _htmlNode2SpeTMP(resNode, resTable) and 0 < loopLimit do
    loopLimit = loopLimit - 1
  end
  return resTable, loopLimit ~= 0
end

function NoticeManager.Transform(text)
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

function NoticeManager.SimpleTransform(text)
  local result = text
  local pattern = "<(.-) .-></%1>"
  while result:find(pattern) do
    result = result:gsub(pattern, "")
  end
  result = result:gsub("<span style='color -: -([#%w]-);'>(.-)</span>", "<color=%1>%2</color>")
  result = result:gsub("(<span style=\"color -: -rgb%((%d-), -(%d-), -(%d-)%);\">(.-)</span>)", function(_, r, g, b, content)
    return string.gsub("<color=$rgb$>$content$</color>", "%$(.-)%$", {
      rgb = string.format("#%02X%02X%02X", r, g, b),
      content = content
    })
  end)
  result = result:gsub("<strong style='color -: -([#%w]-);'>(.-)</strong>", "<b><color=%1>%2</color></b>")
  result = result:gsub("(<strong style=\"color -: -rgb%((%d-), -(%d-), -(%d-)%);\">(.-)</strong>)", function(_, r, g, b, content)
    return string.gsub("<b><color=$rgb$>$content$</color></b>", "%$(.-)%$", {
      rgb = string.format("#%02X%02X%02X", r, g, b),
      content = content
    })
  end)
  result = result:gsub("(</?)strong>", "%1b>")
  result = result:gsub("(</?)address>", "%1i>")
  result = result:gsub("</?pre>", "")
  result = result:gsub("<a href=\"(.-)\".->", function(match)
    preprocess_link(match)
    return string.gsub("<link=\"%1\">", "%%1", match)
  end)
  result = result:gsub("</a>", "</link>")
  result = result:gsub("<p><br -/-></p>", "\n")
  return result
end

return NoticeManager
