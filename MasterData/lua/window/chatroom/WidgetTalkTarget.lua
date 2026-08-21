local WU, DB, REF = require("Common/WindowUtil")(this)
local HU = require("Common/HtmlUtil")
local m_data

function Start()
  WU.BindButtonEvent(REF["$"], function()
    local data = "{ \"pmTarget\" : { \"playerId\" : \"" .. (m_data.senderId or m_data.playerId) .. "\", \"playerName\" : \"" .. (m_data.sender or m_data.name) .. "\" } }"
    this:BroadcastGameEvent("OnLinkClick", data)
  end)
end

function SetWidgetTalkTarget(target, privateTalkPID)
  m_data = target
  local senderId = target.senderId or target.playerId
  local newCount = target.newCount
  local nickName = target.sender or target.name or senderId
  if senderId == privateTalkPID then
    REF.SpriteBg.gameObject:SetActive(true)
    REF.LabelPlayerName.UIHtmlLabel.color = CS.NGUIMath.HexToColor(1248105727)
    REF.SpriteRedPoint.gameObject:SetActive(false)
  else
    REF.SpriteBg.gameObject:SetActive(false)
    REF.LabelPlayerName.UIHtmlLabel.color = CS.NGUIMath.HexToColor(4294967295)
    if newCount and newCount ~= 0 then
      REF.SpriteRedPoint.gameObject:SetActive(true)
    else
      REF.SpriteRedPoint.gameObject:SetActive(false)
    end
  end
  REF.LabelPlayerName.UIHtmlLabel.text = nickName
end
