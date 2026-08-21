local base = inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local U = require("Common/Util")
local PB = require("Common/PbHelper")
local FU = require("Common/FriendUtil")
local PU = require("Common/PlatformUtil")
local S = require("Common/Singleton")
local m_uiManager = S:Get("UIWindowManager")
local m_clickCallback
local m_contentScale = 1
local m_playerInfo
local m_allowHeadPhoto = false
local m_allowHeadFrame = true
local m_allowDefaultFrame = false
local m_lockHeadFrame = true
local m_remainTime
local m_isHeadChooseMode = false

function Start()
  base.Start()
  WU.BindButtonEvent(REF["$"], OnHeadPhotoClick)
  WU.BindButtonEvent(REF.SpriteWX, function()
    WU.ShowHintText(WU.GetString("Platform_Tips3"))
  end)
  m_selfPlayerId = this:GetData("playerId")
end

function OnEnable()
  this:RegisterGameEvent("OnMsdkHeadPhotoFetched", OnHeadPhoto)
end

function OnDisable()
  this:UnregisterGameEvent("OnMsdkHeadPhotoFetched", OnHeadPhoto)
end

function OnHeadPhoto(playerId, texture)
  if m_playerInfo and m_playerInfo.playerId == playerId then
    REF.PlayerHead.UITexture.mainTexture = texture
  end
end

function OnHeadPhotoClick()
  if m_clickCallback then
    m_clickCallback()
  end
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function ResetState()
  m_contentScale = 1
  REF["$BoxCollider2D"].enabled = false
  m_clickCallback = nil
  m_playerInfo = nil
end

function Draw()
  WU.SetActive(REF.PlayerHeadFrameDefault, m_allowDefaultFrame)
  WU.SetActive(REF.PlayerHeadSprite, m_allowHeadPhoto)
  WU.SetActive(REF.PlayerHead, m_allowHeadPhoto)
  WU.SetActive(REF.PlayerHeadBox, m_allowHeadFrame)
  if m_remainTime ~= nil and 0 < m_remainTime then
    WU.SetActive(REF.RemainTime, true)
    _ENV["$"](REF.RemainTime).Label.UILabel.text = WU.GetString("Window_Day", m_remainTime)
  else
    WU.SetActive(REF.RemainTime, false)
  end
  local v3 = CS.UnityEngine.Vector3(m_contentScale, m_contentScale, 1)
  REF["$transform"].localScale = v3
  REF.SpriteVip.gameObject:SetActive(false)
  REF.SpriteWX.gameObject:SetActive(false)
  if m_playerInfo ~= nil then
    REF["$BoxCollider2D"].enabled = m_clickCallback ~= nil
    local isSelf = false
    local myData
    local accountCache = this:GetData("accountCache")
    if m_playerInfo.playerId and m_playerInfo.playerId == m_selfPlayerId then
      isSelf = true
      myData = DB:GetData("fci/gamecenter")
    end
    local vip = 0
    local svip = 0
    local switch = this:GetData("AccountSwitch")
    if switch.QQVipPrivilege then
      if m_playerInfo.qqvip then
        vip = m_playerInfo.qqvip & PB.enum.QQVIPFlag.VIP_NORMAL
        svip = m_playerInfo.qqvip & PB.enum.QQVIPFlag.VIP_SUPER
      elseif isSelf and myData then
        vip = myData.qqvip & PB.enum.QQVIPFlag.VIP_NORMAL
        svip = myData.qqvip & PB.enum.QQVIPFlag.VIP_SUPER
      end
    end
    local channel = CS.Msdk.WGPlatform.Instance:WGGetChannelId()
    local isPrivilegeIgnore = PU.IsPrivilegeIgnore(channel)
    if svip == PB.enum.QQVIPFlag.VIP_SUPER and accountCache.socialPlatform == m_playerInfo.socialPlatform and not isPrivilegeIgnore then
      REF.SpriteVip.gameObject:SetActive(true)
      REF.SpriteVip.UISprite.spriteName = "login_qq_svip"
    elseif vip == PB.enum.QQVIPFlag.VIP_NORMAL and accountCache.socialPlatform == m_playerInfo.socialPlatform and not isPrivilegeIgnore then
      REF.SpriteVip.gameObject:SetActive(true)
      REF.SpriteVip.UISprite.spriteName = "login_qq_vip"
    else
      REF.SpriteVip.gameObject:SetActive(false)
    end
    local socialPlatform = 0
    local gamecenterLoginTime = 0
    if m_playerInfo.socialPlatform then
      socialPlatform = m_playerInfo.socialPlatform
      gamecenterLoginTime = m_playerInfo.gamecenterLoginTime
    elseif isSelf and myData then
      socialPlatform = accountCache.socialPlatform
      gamecenterLoginTime = myData.gamecenterLoginTime
    end
    local eSocialPlatform = U.ToEnum(CS.Msdk.ePlatform, socialPlatform)
    if eSocialPlatform == CS.Msdk.ePlatform.ePlatform_Weixin and switch.WXGameCenterPrivilege and accountCache.socialPlatform == socialPlatform then
      local now = CS.GameTime.serverNow
      local loginTime = CS.GameTime.UtcToLocal(gamecenterLoginTime)
      local isLogin = now.Day == loginTime.Day
      REF.SpriteWX.gameObject:SetActive(isLogin and not isPrivilegeIgnore)
    end
    if m_playerInfo.headPhoto and 0 < m_playerInfo.headPhoto then
      local photo = PB.get("PlayerHeadPhoto", m_playerInfo.headPhoto)
      REF.PlayerHeadSprite.UISprite.spriteName = photo.sprite
      REF.PlayerHead.UITexture.mainTexture = nil
    else
      local sp = m_playerInfo.socialPicture
      local flag = sp ~= nil and U.trim(sp) ~= ""
      REF.PlayerHeadSprite.UISprite.spriteName = "playerheadicon_bg"
      if flag then
        local head = m_uiManager.MsdkHeadPhotoFromCache(m_playerInfo.playerId or m_selfPlayerId, m_playerInfo.socialPicture)
        if head == nil then
          REF.PlayerHead.UITexture.mainTexture = nil
          m_uiManager.AddSocialPicToFetcher(m_playerInfo.socialPicture, m_playerInfo.playerId or m_selfPlayerId)
        else
          REF.PlayerHead.UITexture.mainTexture = head
        end
      else
        REF.PlayerHead.UITexture.mainTexture = nil
      end
    end
    if not m_isHeadChooseMode then
      if m_playerInfo.headFrame and 0 < m_playerInfo.headFrame then
        WU.SetActive(REF.PlayerHeadBox, true)
        local frame = PB.get("PlayerHeadFrame", m_playerInfo.headFrame)
        SetHeadFrameImpl(frame.id)
      else
        WU.SetActive(REF.PlayerHeadBox, false)
      end
    end
  end
end

function SetData(id)
  m_isHeadChooseMode = true
  m_allowHeadPhoto = true
  m_allowHeadFrame = false
  m_contentScale = 1.52
  SetHeadPhotoImpl(id)
  MarkAsDirty()
end

function SetPlayerInfo(playerInfo, scale)
  m_allowHeadFrame = true
  m_allowHeadPhoto = true
  m_isHeadChooseMode = false
  if playerInfo.playerId == nil then
    playerInfo.playerId = this:GetData("playerId")
  end
  m_playerInfo = playerInfo
  m_contentScale = fif(scale == nil, 1, scale)
  MarkAsDirty()
end

function SetHeadBox(headPhotoId, headFrameId, frameRemainTime, lockFrame)
  m_isHeadChooseMode = true
  m_allowHeadPhoto = fif(headPhotoId, true, false)
  m_allowHeadFrame = fif(headFrameId, true, false)
  m_lockHeadFrame = fif(lockFrame, true, false)
  m_remainTime = frameRemainTime
  REF.PlayerHeadFrameDefault.UISprite.spriteName = fif(m_lockHeadFrame, "head_frame_lock", "head_frame_unlock")
  m_contentScale = fif(m_allowHeadFrame, 1.3, 1.52)
  if m_allowHeadPhoto then
    SetHeadPhotoImpl(headPhotoId)
  end
  if m_allowHeadFrame then
    SetHeadFrameImpl(headFrameId)
  end
  MarkAsDirty()
end

function SetHeadPhotoImpl(id)
  if id and 0 < id then
    local photo = PB.get("PlayerHeadPhoto", id)
    if photo == nil then
      error("Photo", "no id " .. id .. " in PlayerHeadPhoto.xlsx")
    else
      REF.PlayerHeadSprite.UISprite.spriteName = photo.sprite
    end
  else
    REF.PlayerHeadSprite.UISprite.spriteName = "playerheadicon_bg"
  end
end

function SetHeadFrameImpl(id)
  m_allowDefaultFrame = true
  if id and 0 < id then
    local frame = PB.get("PlayerHeadFrame", id)
    if frame == nil then
      error("Frame", "no id" .. id .. " in PlayerHeadFrame.xlsx")
    elseif REF.PlayerHeadBox.UITexture ~= nil then
      REF.PlayerHeadBox.UITexture.mainTexturePath = "Texture/ItemIcon/head_frame_" .. frame.textureId
    end
  else
    m_allowHeadFrame = false
  end
end
