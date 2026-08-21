local WU, DB, REF = require("Common/WindowUtil")(this)
local GotoUtil = require("Common/GotoUtil")
local AU = require("Common/ActorUtil")
local m_call

function Awake()
  m_call = nil
  WU.BindButtonEvent(REF.ButtonSlot, function()
    if m_call then
      m_call()
    end
  end)
end

function SetData(actorId)
  InitData()
  REF.SpriteEmpty.gameObject:SetActive(false)
  REF.AlphaControl.gameObject:SetActive(true)
  REF.SpriteIcon.UISprite.spriteName = "actor_head_" .. actorId .. "a"
end

function SetClickCallBack(call)
  m_call = call
end

function SetSelected(selected)
  REF.NodeAcSelected.gameObject:SetActive(selected)
end

function ShowGraify(show, enableButton)
  if enableButton == nil then
    enableButton = true
  end
  REF.NodeDisable.gameObject:SetActive(show)
  REF.ButtonSlot.BoxCollider2D.enabled = not show and enableButton
end

function ShowLink(actor, linkInfo)
  if linkInfo == nil or #linkInfo <= 0 then
    return
  end
  REF.NodeLink.gameObject:SetActive(true)
  WU.TraverseChildren(REF.NodeLink, function(go, index)
    local realIndex = index + 1
    _ENV["$"](go).root.gameObject:SetActive(false)
    if realIndex > #linkInfo then
      return
    end
    local link = linkInfo[realIndex].link
    for k, v in pairs(link) do
      if v.actorID ~= actor.id then
        _ENV["$"](go).root.gameObject:SetActive(true)
        REF["Link" .. realIndex].UISprite.spriteName = "actor_head_" .. v.actorID .. "a"
      end
    end
  end)
end

function ShowSpeed(actor)
  if actor.speed == nil then
    return
  end
  REF.NodeSpeed.gameObject:SetActive(true)
  WU.SetLabel(REF.LabelSpeed, actor.speed)
end

function InitData()
  REF.ButtonSlot.BoxCollider2D.enabled = true
  REF.NodeDisable.gameObject:SetActive(false)
  REF.NodeAcSelected.gameObject:SetActive(false)
  REF.NodeLink.gameObject:SetActive(false)
  REF.NodeSpeed.gameObject:SetActive(false)
  REF.SpriteEmpty.gameObject:SetActive(true)
  REF.AlphaControl.gameObject:SetActive(false)
  m_call = nil
end

function SetEmpty()
  InitData()
end
