local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local DBH = require("Manager/DataBindingHandler")
local EnumMode = {showOne = 1, showList = 2}
local m_mode, m_inviteeList, m_curInvitee, m_curIndex, m_shareOn, m_stBusy

function SetupWindow()
  WU.BindButtonEvent(REF.BtnReward, OnRewardClick)
  WU.BindButtonEvent(REF.BtnSave, OnSaveClick)
  WU.BindButtonEvent(REF.BtnShare, OnShareClick)
  WU.BindButtonEvent(REF.BtnLeft, function()
    MoveStep(-1)
  end)
  WU.BindButtonEvent(REF.BtnRight, function()
    MoveStep(1)
  end)
end

function InitWindow()
  this:RegisterGameEvent("CPIR/OnScreenshotSuccess", OnScreenshotSuccess)
  this:RegisterGameEvent("CPIR/OnScreenshotFailure", OnScreenshotFailure)
  _ENV["$"](REF.ButtonClose)["$$SetCallback"](OnCloseClick)
  m_shareOn = WU.IsShareSwitchOn()
  if m_shareOn then
    this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  end
  ResetUI()
  UpdateData()
end

function OnWindowUninited(window)
  if window.name == "Share" and WU.TopWindow().name == "ChristmasPartyInviteResult" then
    RebuildUI(true)
  end
end

function ResetUI()
  m_stBusy = false
  REF.EffectBg.gameObject:SetActive(false)
  REF.TextureActor.gameObject:SetActive(false)
end

function UpdateData()
  m_mode = this:GetData("ChristmasParty/ResultMode")
  local bShowList = m_mode == EnumMode.showList
  if bShowList then
    m_curIndex = 1
    m_inviteeList = this:GetData("ChristmasParty/InviteeList")
    m_curInvitee = m_inviteeList[m_curIndex]
  else
    m_curInvitee = this:GetData("ChristmasParty/CurrentInvitee")
    local giftBoxId = PB.get("ActivityShopGoods", m_curInvitee.config.goodId).res[1].id
    local gift = this:GetData("fci/item/" .. giftBoxId) or {}
    local isGiftPacked = gift.count ~= nil and gift.count ~= 0
    m_curInvitee.isGiftPacked = true
  end
  UpdateUI()
end

function UpdateUI()
  if m_mode == EnumMode.showList then
    REF.BtnLeft.gameObject:SetActive(1 < m_curIndex)
    REF.BtnRight.gameObject:SetActive(m_curIndex < #m_inviteeList)
  else
    REF.BtnLeft.gameObject:SetActive(false)
    REF.BtnRight.gameObject:SetActive(false)
  end
  local hasInvited = m_curInvitee.hasInvited
  local isGiftPacked = m_curInvitee.isGiftPacked
  local config = m_curInvitee.config
  REF.BtnShare.gameObject:SetActive(hasInvited and m_shareOn)
  REF.BtnSave.gameObject:SetActive(hasInvited)
  REF.Grid.UIGrid:Reposition()
  RU.SetRedMark("Welfare/Christmas/Invite/" .. config.goodId, isGiftPacked)
  REF.LabelTip.gameObject:SetActive(hasInvited and not isGiftPacked)
  REF.LabelTip.UILabel.text = WU.GetString("Christmas_GetSignboardTip", WU.GetString("ActorName_" .. m_curInvitee.config.actorId))
  REF.BtnReward.gameObject:SetActive(m_mode == EnumMode.showList)
  local color = fif(hasInvited, CS.NGUIMath.HexToColor(4294967295), CS.NGUIMath.HexToColor(2300396287))
  REF.TextureActor.UITexture.mainTexturePath = "Texture/WelfarePostcard/Christmas/Christmas_" .. config.animRes
  REF.TextureActor.UITexture.color = color
  REF.TextureActor.UITexture.solidColor = not hasInvited
  local pos = REF.TextureActor.transform.localPosition
  REF.TextureActor.transform.localPosition = {
    x = pos.x + config.animResOffsetX,
    y = pos.y + config.animResOffsetY,
    z = 0
  }
  REF.LabelBless.UIHtmlLabel.text = fif(hasInvited, WU.GetString("ChristmasBless_" .. config.roleId), WU.GetString("Christmas_ActorIsNotInvited"))
  local nameAnimRes = PB.get("ActorConfig", config.actorId).animRes
  REF.SpriteName.UISprite.spriteName = "actor_name_" .. nameAnimRes
  if m_mode == EnumMode.showList then
    REF.TextureActor.gameObject:SetActive(true)
  else
    REF.NodeText.UIPlayTween:Play(true)
    local tex = WU.AcquireAsset("Texture/WelfarePostcard/Christmas/Christmas_" .. m_curInvitee.config.animRes)
    REF.Role.MeshRenderer.material:SetTexture("_MainTex", tex)
    REF.EffectBg.gameObject:SetActive(true)
    m_stBusy = true
    REF.EffectBg.EffectGenerator:Play(function()
      m_stBusy = false
    end)
  end
end

function MoveStep(step)
  local t = m_curIndex + step
  if t <= 0 or t > #m_inviteeList then
    return
  end
  m_curIndex = t
  m_curInvitee = m_inviteeList[m_curIndex]
  UpdateUI()
end

function OnRewardClick()
  if m_stBusy then
    return
  end
  ShowReward()
end

function ShowReward()
  local title = WU.GetString("Christmas_ActorGift", WU.GetString("ActorName_" .. m_curInvitee.config.actorId))
  local rewardList = PB.get("ActivityShopGoods", m_curInvitee.config.goodId).goods
  local buttonTitle = WU.GetString("WindowGacha_Close")
  local content = WU.GetString("Christmas_InviteActorCanGetGift")
  WU.AcquireWindowAsync("RewardPreview", function(ui)
    local isGot = m_curInvitee.hasInvited and not m_curInvitee.isGiftPacked
    _ENV["$"](ui)["$$SetView"](rewardList, title, content, isGot, buttonTitle)
    for i, v in ipairs(rewardList) do
      if v.type == PB.enum.ResourceType.ResActor then
        _ENV["$"](ui)["$$SetCustomActorInfo"](v.id, info.quality)
      end
    end
  end)
end

function RebuildUI(visible)
  local hasInvited = m_curInvitee.hasInvited
  local isGiftPacked = m_curInvitee.isGiftPacked
  local bShowList = m_mode == EnumMode.showList
  REF.BtnReward.gameObject:SetActive(visible and hasInvited)
  REF.LabelTip.gameObject:SetActive(visible and hasInvited and not isGiftPacked)
  REF.BtnSave.gameObject:SetActive(visible and hasInvited)
  REF.BtnShare.gameObject:SetActive(visible and hasInvited and m_shareOn)
  REF.BtnLeft.gameObject:SetActive(visible and bShowList and 1 < m_curIndex)
  REF.BtnRight.gameObject:SetActive(visible and bShowList and m_curIndex < #m_inviteeList)
  REF.ButtonClose.gameObject:SetActive(visible)
end

function OnShareClick()
  if m_stBusy then
    return
  end
  this:SetData("ShareConfig", {
    shareName = "ChristmasPartyInviteResult",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  RebuildUI(false)
  WU.AcquireWindowAsync("Share")
end

function OnSaveClick()
  if m_stBusy then
    return
  end
  m_stBusy = true
  RebuildUI(false)
  WU.ToggleTopBar("ChristmasPartyInviteResult", false)
  local time = CS.GameTime.serverUtc
  local fileName = "screencapture" .. time .. ".png"
  this:DelayInvokeInSeconds(1, function()
    local m_imagePath = CS.ResourceManager.Instance.SharePath .. "/" .. fileName
    CS.GameUtility.ScreenCapture(m_imagePath)
    CS.NativeInterface.External_SaveToAlbum(m_imagePath, "CPIR/OnScreenshotSuccess", "CPIR/OnScreenshotFailure")
  end)
end

function OnScreenshotSuccess()
  RebuildUI(true)
  WU.ToggleTopBar("ChristmasPartyInviteResult", true)
  m_stBusy = false
  WU.ShowHintText(WU.GetString("Window_SaveSuccess"))
end

function OnScreenshotFailure()
  RebuildUI(true)
  WU.ToggleTopBar("ChristmasPartyInviteResult", true)
  m_stBusy = false
  WU.ShowHintText(WU.GetString("Window_SaveFail"))
end

function OnCloseClick()
  if m_stBusy then
    return
  end
  WU.RecycleWindow("ChristmasPartyInviteResult")
  if m_mode == EnumMode.showOne then
    WU.RecycleWindow("ChristmasPartyInviteDetail")
    WU.RecycleWindow("ChristmasPartyInvite")
    this:BroadcastGameEvent("ChristmasParty/OnActorIsInvited", m_curInvitee)
  end
end
