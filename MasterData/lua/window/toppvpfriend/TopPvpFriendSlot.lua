local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local FU = require("Common/FriendUtil")
local DBH = require("Manager/DataBindingHandler")
local PU = require("Common/PlatformUtil")
local DU = require("Common/DungeonUtil")
local TPU = require("Common/TopPvpUtil")
local Msdk = CS.Msdk
local m_data, m_playerId, m_type, m_clickCallback, m_giftRequest

function Start()
  WU.BindButtonEvent(REF.Collider, function()
    WU.RecordButtonClick(9903)
    if m_type ~= 6 then
      WU.ShowPlayerOption(m_data, function()
        SetHighLighted(false)
      end)
    end
    SetHighLighted(true)
    if m_clickCallback ~= nil then
      m_clickCallback()
    end
  end)
  WU.BindButtonEvent(REF.BtnFight, function()
    OnBtnFight()
  end)
end

function OnEnable()
  this:RegisterGameEvent("WidgetPlayer/Unselect", SetHighLighted)
end

function OnDisable()
  this:UnregisterGameEvent("WidgetPlayer/Unselect", SetHighLighted)
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function SetHighLighted(flag)
  REF.SelectSprite.gameObject:SetActive(flag)
end

function SetPlayerInfo(playerInfo)
  if playerInfo then
    m_data = playerInfo
    REF.PlayerLvLabel.UILabel.text = WU.GetString("Window_Level", playerInfo.level)
    REF.WidgetPlayerName["$SetData"]({playerInfo = playerInfo})
    REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](playerInfo)
    WU.ToggleRendering(REF.Visual, true)
  end
end

function SetData(data)
  m_type = type
  if data == nil then
    return
  end
  m_playerId = data.playerId
  SetPlayerInfo(data)
end

function OnBtnFight()
  local function func()
    this:DelayInvokeInSeconds(0.1, function()
      OnMatchClick()
    end)
  end
  
  if not DU.IsWaitingForJob(func) then
    OnMatchClick()
  end
end

function OnMatchClick()
  if TPU.IsFriendPVPUnlock(m_data.level) then
    TPU.InviteFriendPVP(m_playerId)
  else
    WU.ShowHintText(WU.GetString("TopPvpJoin_Tips68"))
  end
end
