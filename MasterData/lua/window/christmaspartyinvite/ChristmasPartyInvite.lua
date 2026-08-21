local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_inviteeList, m_itemId, m_item

function SetupWindow()
  WU.TraverseChildren(REF.ActorGrid, function(go)
    WU.BindButtonEvent(_ENV["$"](go).root, OnInviteClick)
  end)
  WU.BindButtonEvent(REF.LabelItem, function()
    WU.ShowItemDetail(m_item.id, false)
  end)
end

function InitWindow()
  m_inviteeList = this:GetData("ChristmasParty/InviteeList")
  local goodId = m_inviteeList[1].config.goodId
  local goodInfo = PB.get("ActivityShopGoods", goodId)
  REF.LabelTip.UIHtmlLabel.text = WU.GetString("Christmas_InvitationTip", goodInfo.costs[1].count)
  local itemId = goodInfo.costs[1].id
  this:Bind("fci/item/" .. tostring(itemId), function(item)
    m_item = item
    local count = item and item.count or 0
    REF.LabelItem.UIHtmlLabel.text = WU.GetString("Christmas_ItemCount", itemId, count)
  end)
  UpdateUI()
end

function UpdateUI()
  for i = 0, #REF.ActorGrid - 1 do
    local index = i + 1
    local ref = REF.ActorGrid[i]
    local invitee = m_inviteeList[index]
    local actorConfig = PB.get("ActorConfig", invitee.config.actorId)
    ref.TextureActorHead.UITexture.mainTexturePath = "Texture/ActorHeadBig/actor_head_big_" .. actorConfig.animRes
    ref.SpriteActorName.UISprite.spriteName = "actor_name_" .. actorConfig.animRes
    ref.SpriteActorName.UISprite:SnapWithoutScale()
    ref.SpriteInParty.gameObject:SetActive(invitee.hasInvited)
    ref["@info"] = invitee
  end
  REF.ActorGrid.UIPlayTween:Play(true)
end

function OnInviteClick(go)
  local info = _ENV["$"](go)["@info"]
  if info.hasInvited then
    WU.ShowHintText(WU.GetString("Christmas_ActorHasInvited"))
    return
  end
  local goodsInfo = PB.get("ActivityShopGoods", info.config.goodId)
  if m_item == nil or m_item.count == nil or m_item.count < goodsInfo.costs[1].count then
    WU.ShowHintText(WU.GetString("Window_ItemNotEnough"))
    return
  end
  this:SetData("ChristmasParty/CurrentInvitee", info)
  WU.AcquireWindowAsync("ChristmasPartyInviteDetail")
end
