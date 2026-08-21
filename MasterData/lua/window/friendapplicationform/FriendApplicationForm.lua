local WU, DB, REF = require("Common/WindowUtil")(this)
local LU = require("Common/ListUtil")
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local FU = require("Common/FriendUtil")
local m_listData, m_mode, m_onClosing, m_limitLevel, m_limitLevelMax, m_limitLevelMin

function SetupWindow()
  if REF.ButtonApplyLevelLimit then
    WU.BindButtonEvent(REF.ButtonApplyLevelLimit, OnClickButtonApplyLevelLimit)
    WU.BindButtonEvent(REF.ButtonApplyDeleteAll, OnClickButtonApplyDeleteAll)
  end
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRow
  })
end

function UninitWindow()
  m_onClosing = false
end

function BackWindow()
  this:BroadcastGameEvent("PlayerOptionChange")
end

function SetMode(mode)
  LU.Set(REF.WrapContent, 0)
  REF.PlayerOptionApply.gameObject:SetActive(false)
  REF.PlayerOptionBlock.gameObject:SetActive(false)
  if mode == "Applylist" then
    m_mode = 3
    m_limitLevelMax = PB.all("Misc"):first().friendApplyLevelMax
    m_limitLevelMin = PB.all("Misc"):first().friendApplyLevelMin
    if not m_limitLevelMax or not m_limitLevelMin then
      m_limitLevelMax = 99
      m_limitLevelMin = 6
    end
    REF.LimitLevelTipsLabel.gameObject:SetActive(true)
    REF.PlayerOptionApply.gameObject:SetActive(true)
    this:Bind("fci/baseinfo/", function(baseInfo)
      if baseInfo and baseInfo.friendApplyLevelLimit then
        m_limitLevel = baseInfo.friendApplyLevelLimit
      else
        m_limitLevel = 6
      end
      REF.LimitLevelTipsLabel.UIHtmlLabel.text = WU.GetString("Window_FriendApplyLevelLimit1", m_limitLevel)
    end)
    this:Bind("fci/applylist/", function(result)
      if result ~= nil then
        if 0 < #result then
          REF.SpriteFriendEmpty.gameObject:SetActive(false)
          OnListChange(result)
        else
          OnListChange(result)
          REF.SpriteFriendEmpty.gameObject:SetActive(true)
        end
      end
    end)
  elseif mode == "Blacklist" then
    m_mode = 5
    REF.PlayerOptionBlock.gameObject:SetActive(true)
    this:Bind("fci/blacklist/", function(result)
      if result ~= nil then
        OnListChange(result)
      end
    end)
  end
end

function OnListChange(data)
  m_listData = data
  LU.Set(REF.WrapContent, #m_listData)
end

function UpdateRow(rowRef, wrapIndex, realIndex)
  if m_listData ~= nil and realIndex ~= nil and realIndex < #m_listData then
    rowRef["$$SetData"](m_listData[realIndex + 1], m_mode)
  end
end

function OnClickButtonApplyLevelLimit()
  WU.RecordButtonClick(109017)
  WU.ShowSliderBox({
    windowName = "FriendApplicationForm",
    title = WU.GetString("Window_FriendApplyLimit"),
    tips = WU.GetString("Window_FriendApplyLevelLimit2", m_limitLevel),
    maxValue = m_limitLevelMax,
    minValue = m_limitLevelMin,
    scales = {
      6,
      20,
      40,
      60,
      80,
      99
    },
    value = m_limitLevel,
    invertFill = true
  }, function(result)
    if result ~= m_limitLevel then
      WU.RecordButtonClick(109018)
    end
    SetLimitLevel(result)
  end)
end

function OnClickButtonApplyDeleteAll()
  WU.RecordButtonClick(109014)
  local playerIdList = {}
  for _, v in pairs(m_listData) do
    table.insert(playerIdList, v.playerId)
  end
  this:GameRequest("fci/applylist/"):Patch({targetList = playerIdList, isAgree = false}, function()
    DB:SetData("fci/applylist/", {})
  end)
end

function SetLimitLevel(result)
  local a = result
  this:GameRequest("fci/applylist/"):Patch({friendApplyLevelLimit = result}, function(eee)
    local baseInfo = DB:GetData("fci/baseinfo")
    if baseInfo and baseInfo.friendApplyLevelLimit then
      baseInfo.friendApplyLevelLimit = result
      DB:SetData("fci/baseinfo", baseInfo)
    end
  end)
end

function Focus(on)
  if m_mode == 3 then
    WU.RecordWindowFocus(100155, on)
  else
    WU.RecordWindowFocus(100157, on)
  end
end
