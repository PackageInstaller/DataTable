local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local HU = require("Common/HtmlUtil")
local m_data

function SetGuildContent(data)
  if data == nil then
    return
  end
  m_data = data
  REF["@type"] = 3
  REF["@context"] = data
  local guildPlayer = this:GetData("fci/guild-player/")
  local maxMemberCount = PB.index("GuildLevel", m_data.guildLevel).maxMemberCount
  WU.SetLabel(REF.LabelName, data.guildName)
  WU.SetLabel(REF.LabelMember, data.guildMemberCount .. "/" .. maxMemberCount)
  WU.SetLabel(REF.LabelInfo, data.bulletinContent)
  WU.SetActive(REF.ButtonApply, guildPlayer == nil or guildPlayer.guildId == 0)
  WU.SetLabel(REF.LabelHeat, m_data.guildScore)
  REF.SpriteIcon.UISprite.spriteName = "guild_emblem_" .. string.format("%02d", tonumber(m_data.guildIcon) or 1) .. "s"
  WU.ClearButtonEvent(REF.ButtonApply)
  WU.BindButtonEvent(REF.ButtonApply, function()
    local guildId = m_data.guildId
    if guildId and guildId ~= 0 then
      DB:GameRequest("fci/guild/" .. guildId .. "/pending-members/"):Put({
        playerId = DB:GetData("playerId")
      }, function()
        WU.ShowHintText(WU.GetString("Window_GuildApplicationSent"))
      end)
    end
  end)
  WU.ClearButtonEvent(REF.ButtonDetail)
  WU.BindButtonEvent(REF.ButtonDetail, function()
    this:GameRequest("fci/guild/" .. m_data.guildId .. "/members/"):Get(function(members)
      WU.AcquireWindowAsync("OtherGuildDetail", function(ui)
        _ENV["$"](ui)["$$SetData"](m_data, members)
      end)
    end)
  end)
end
