local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_worldInfo

function Start()
  WU.BindButtonEvent(REF.ButtonSelect, OnSelectClick)
end

function UpdateSlot(data)
  m_worldInfo = data.worldInfo
  REF.LabelName.UILabel.text = m_worldInfo.worldName
  REF.ButtonSelect.UIButton.normalSprite = m_worldInfo.iconName
  REF.ButtonSelect.UIButton.isEnabled = m_worldInfo.openStat ~= 2
  local statusName = ""
  if m_worldInfo.openTime ~= 0 then
    statusName = "server_opening_soon"
  elseif m_worldInfo.openStat == PB.enum.EServerStatus.Full then
    statusName = "server_hot"
  elseif m_worldInfo.openStat == PB.enum.EServerStatus.Maintenance then
    statusName = "server_maintenance"
  elseif m_worldInfo.isNewWorld then
    statusName = "server_new"
  elseif m_worldInfo.openStat == PB.enum.EServerStatus.Normal then
    statusName = ""
  end
  REF.SpriteStatus.gameObject:SetActive(statusName ~= "")
  if statusName ~= "" then
    local sprite = REF.SpriteStatus.UISprite
    sprite.spriteName = statusName
    sprite:SnapWithoutScale()
  end
end

function OnSelectClick()
  if m_worldInfo.openTime == 0 then
    WU.RecycleWindow("World")
    this:SetData("CurrentWorld", m_worldInfo)
  else
    WU.ShowHintText(WU.GetString("WindowLogin_ServerOpenTips") .. WU.RenderTime(m_worldInfo.openTime))
  end
end
