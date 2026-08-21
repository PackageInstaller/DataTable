local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local FU = require("Common/FriendUtil")
local U = require("Common/Util")
local FU = require("Common/FriendUtil")
local U = require("Common/Util")
local m_vip

function Start()
end

function SetData(data)
  local msdkInfo = data.msdkInfo
  local playerInfo = data.playerInfo
  local accountCache = this:GetData("accountCache")
  if msdkInfo ~= nil then
    REF.PlayerMsdkNameLabel.gameObject:SetActive(true)
    REF.PlayerMsdkNameLabel.UILabel.text = "(" .. msdkInfo.nickName .. ")"
    REF.PlayerSexSprite.UISprite.spriteName = FU.GetGenderIcon(msdkInfo.gender)
  else
    REF.PlayerMsdkNameLabel.gameObject:SetActive(false)
  end
  if playerInfo ~= nil then
    REF.PlayerSexSprite.UISprite.spriteName = FU.GetGenderIcon(playerInfo.sex)
    REF.PlayerNameLabel.UILabel.text = playerInfo.name
  end
end
