local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local m_customBg, m_affixDescText

function Start()
  m_affixDescText = ""
  WU.BindPressEvent(REF["$"], OnAffixWidgetPress)
  for i = 0, #REF.NodeAlpha - 1 do
    WU.ToggleRendering(REF.NodeAlpha[i]["$"], false)
  end
end

function ShowAffixWidget(dungeonId)
  local dungeon = PB.get("DungeonMonster", dungeonId)
  if dungeon == nil then
    error("no DungeonMonster for dungeonId:" .. tostring(dungeonId))
    return
  end
  if table.empty(dungeon.team1Affix) and table.empty(dungeon.team2Affix) then
    REF["$"].gameObject:SetActive(false)
    return
  end
  REF["$"].gameObject:SetActive(true)
  local affixList = _ENV["!"]({})
  affixList:append(dungeon.team1Affix)
  affixList:append(dungeon.team2Affix)
  affixList = affixList:distinct()
  local player = WU.GetString("Window_OurSide")
  local enemy = WU.GetString("Window_EnemySide")
  m_affixDescText = ""
  local index = 0
  for i = 0, #REF.NodeAlpha - 1 do
    WU.ToggleRendering(REF.NodeAlpha[i]["$"], false)
  end
  for _, affix in pairs(affixList) do
    m_affixDescText = m_affixDescText .. WU.GetString("AffixDesc_" .. affix) .. HU.HtmlSplitLine("Common.Line_dark")
    local desc = WU.GetString("AffixTitle_" .. affix) .. ":"
    local playerDesc = ""
    local playerOwn = false
    if table.has(dungeon.team1Affix, affix) then
      playerDesc = playerDesc .. player
      playerOwn = true
    end
    if table.has(dungeon.team2Affix, affix) then
      if playerOwn then
        playerDesc = playerDesc .. "/"
      end
      playerDesc = playerDesc .. enemy
    end
    if index < #REF.NodeAlpha then
      REF.NodeAlpha[index].AffixTitleLabel.UIHtmlLabel.text = desc
      REF.NodeAlpha[index].AffixLabel.UIHtmlLabel.text = playerDesc
      REF.NodeAlpha[index].AffixBG.UISprite.spriteName = fif(m_customBg, m_customBg, "Widget_bg2_9")
      WU.ToggleRendering(REF.NodeAlpha[index]["$"], true)
    end
    index = index + 1
  end
end

function OnAffixWidgetPress(go, pressed)
  if pressed and m_affixDescText ~= nil then
    WU.ShowHoverTips3(m_affixDescText)
  else
    WU.HideHoverTips()
  end
end

function SetCustomBg(name)
  m_customBg = name
end
