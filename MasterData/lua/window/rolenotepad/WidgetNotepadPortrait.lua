local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local m_kCallback
local m_bSelected = false
local m_nowData

function Start()
  WU.BindButtonEvent(REF.ButtonSlot, OnTabClick)
end

function OnTabClick(go)
  if m_kCallback ~= nil then
    m_kCallback(REF["$gameObject"])
  end
end

function SetClickCallback(callback)
  m_kCallback = callback
end

function SetSelected(selected)
  m_bSelected = selected
  WU.ToggleRendering(REF.BG_Selected, selected)
end

function NowData()
  return m_nowData
end

function SetData(dataItem)
  REF["$UIPlayTween"]:Play(true)
  m_nowData = dataItem
  REF["@data"] = dataItem
  local role = PB.get("Role", dataItem.roleId)
  REF.IconHeader.UITexture.mainTexturePath = "Texture/ActorJourneyHead/actor_head_" .. role.animRes
  REF.IconName.UISprite.spriteName = "actor_name_outline_" .. role.animRes
  REF.IconBgName.UISprite.width = REF.IconName.UISprite:GetAtlasSprite().width
  WU.ToggleRendering(REF.SpriteNew, false)
  ManageFavourLevel(dataItem)
end

function ManageFavourLevel(result)
  if result then
    REF.IntimateLevelLabel.UILabel.text = result.favourLevel
  end
end

function BindRedMark(data)
  if m_nowData ~= nil then
    RU.UnbindRedMark(this, "RoleNotePad/" .. m_nowData.roleId)
  end
  m_nowData = data
  if data ~= nil then
    RU.BindRedMark(this, "RoleNotePad/" .. m_nowData.roleId, OnRedMarkChange)
  end
end

function OnRedMarkChange(isred)
  WU.ToggleRendering(REF.SpriteNew, isred)
end
