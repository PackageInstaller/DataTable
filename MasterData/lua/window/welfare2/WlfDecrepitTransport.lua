local WU, DB, REF = require("Common/WindowUtil")(this)
local S = require("Common/Singleton")
local PB = require("Common/PbHelper")
local m_activityManager = S:Get("ActivityManager")
local m_decrepitActivityInfo, m_theActorActivityInfo, m_transportObjs
local ActorTypePrefix = {
  "Window_ActorMainPrefix",
  "Window_ActorAssistPrefix"
}

function Awake()
  WU.BindButtonEvent(REF.ButtonConfirm, OnConfirm)
end

function OnConfirm()
  if m_transportObjs ~= nil and 0 < #m_transportObjs then
    local isOpen, _ = m_activityManager.IsActivityReallyOpen(PB.enum.ActivityType.DiffActorInherit)
    if isOpen then
      WU.AcquireWindowAsync("DecrepitTransportation", function(window)
        _ENV["$"](window)["$$InitData"](m_theActorActivityInfo, m_transportObjs)
      end)
    else
      WU.ShowHintText(WU.GetString("WindowActivity_IsNotOpen"))
    end
  else
    WU.ShowHintText(WU.GetString("Window_DecrepitTransportNoActor"))
  end
end

function InitTransportList(actorID)
  m_transportObjs = _ENV["!"]({})
  local actorAll = DB:GetData("fci/actor/")
  m_transportObjs = table.linq(actorAll):where(function(_, val)
    return val.id == actorID
  end):toarray()
  table.sort(m_transportObjs, function(a, b)
    if a.quality ~= b.quality then
      return a.quality > b.quality
    else
      return a.level > b.level
    end
  end)
end

function InitData(activityID)
  m_theActorActivityInfo = nil
  local all = PB.all("DiffActorInherit")
  for _, v in pairs(all) do
    if v.activityId == activityID then
      m_theActorActivityInfo = v
      break
    end
  end
  if m_theActorActivityInfo == nil then
    error("\232\175\183\231\173\150\229\136\146\233\133\141\231\189\174\230\173\163\231\161\174\231\154\132\230\151\182\233\151\180")
    return
  end
  local theActorInfo = PB.get("ActorConfig", m_theActorActivityInfo.actorId)
  local atorName = WU.GetString("ActorName_" .. theActorInfo.id)
  REF.LabelActorTips.UILabel.text = WU.GetString("EventActivity_DecrepitTransportTip")
  REF.LabelActorDesc.UILabel.text = WU.GetString("EventActivity_DecrepitTransportDesc", atorName)
  REF.IconActorName.UISprite.spriteName = "actor_name_" .. theActorInfo.animRes
  REF.IconActorTag.UISprite.spriteName = "actor_type_" .. theActorInfo.id
  local textKind = WU.GetString(ActorTypePrefix[theActorInfo.kind])
  textKind = string.sub(textKind, 1, string.len(textKind) - 1)
  local textCategory = WU.GetString("ActorCategory_" .. tostring(theActorInfo.category))
  REF.LabelKind.UILabel.text = textKind
  REF.LabelAtkKind.UILabel.text = textCategory
  REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortraitFull/actor_portrait_full_" .. theActorInfo.animRes
  InitTransportList(m_theActorActivityInfo.actorId)
end
