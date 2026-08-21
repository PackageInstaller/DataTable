inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local RU = require("Common/RedMarkUtil")
local GotoUtil = require("Common/GotoUtil")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local activityManager = S:Get("ActivityManager")

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonGuildMembers, OnGuildMembersClick)
  WU.BindButtonEvent(REF.ButtonGuildSkill, OnGuildSkillClick)
  WU.BindButtonEvent(REF.ButtonGuildSupport, OnGuildSupportClick)
  WU.BindButtonEvent(REF.ButtonGuildStore, OnGuildStoreClick)
  WU.BindButtonEvent(REF.ButtonGuildRecords, OnGuildRecordsClick)
  WU.BindButtonEvent(REF.ButtonGuildPendingMembers, OnGuildPendingMembersClick)
  WU.BindButtonEvent(REF.ButtonGuildMission, OnGuildMissionClick)
  WU.BindButtonEvent(REF.ButtonGuildList, OnGuildListClick)
  WU.BindButtonEvent(REF.ButtonGuildDungeons, OnGuildDungeonsClick)
  WU.BindButtonEvent(REF.ButtonRecruit, OnRecruitClick)
end

function InitWindow()
  WU.SetActive(REF.EffectLevelup, false)
  this:SetData("GuildQuitNotified", nil)
  this:Bind("guildId", ValidateRestrictions)
  this:Bind("fci/guild-player/", OnGuildPlayerChanged)
  local guildVote = this:GetData("fci/guild/vote/")
  if guildVote and guildVote.endTime > CS.GameTime.serverUtc then
    local guildPlayer = this:GetData("fci/guild-player/")
    if guildPlayer.type ~= PB.enum.GuildMemberType.President then
      local playerId = this:GetData("playerId")
      local voted = table.find(guildVote.playersSupport, function(k, v)
        return v == playerId
      end) or table.find(guildVote.playersKick, function(k, v)
        return v == playerId
      end)
      if not voted then
        WU.AcquireWindowAsync("GuildVote")
      end
    end
  end
  RU.BindRedMark(this, "Relation/Guild/Message", function(flag)
    _ENV["$"](REF.ButtonGuildRecords).SpriteNew.gameObject:SetActive(flag)
  end)
  RU.BindRedMark(this, "Relation/Guild/Pending", function(flag)
    _ENV["$"](REF.ButtonGuildPendingMembers).SpriteNew.gameObject:SetActive(flag)
  end)
  RU.BindRedMark(this, "Relation/Guild/Support", function(flag)
    _ENV["$"](REF.ButtonGuildSupport).SpriteNew.gameObject:SetActive(flag)
  end)
  WU.SetGameDataCache("seenGuild", true)
  RU.SetRedMark("Relation/Guild/New", false)
  UpdateGuildDungeonUI()
end

function UpdateGuildDungeonUI()
  local start, open = GU.IsGuildDungeonOn()
  if open then
    RU.BindRedMark(this, "Relation/Guild/Dungeon", function(flag)
      WU.SetActive(_ENV["$"](REF.ButtonGuildDungeons).SpriteNew, flag)
    end)
  else
    WU.SetActive(_ENV["$"](REF.ButtonGuildDungeons).SpriteNew, false)
  end
  WU.SetActive(REF.NodeNotOpen, not start)
  WU.SetActive(REF.SpriteTip, start)
  _ENV["$"](REF.ButtonGuildDungeons)["@start"] = start
  _ENV["$"](REF.ButtonGuildDungeons)["@open"] = open
end

function OnGuildPlayerChanged(guildPlayer)
  CheckGuildUpgrade(guildPlayer)
  REF.ButtonRecruit.gameObject:SetActive(guildPlayer.type == PB.enum.GuildMemberType.President or guildPlayer.type == PB.enum.GuildMemberType.VicePresident)
end

function CheckGuildUpgrade(guildPlayer)
  local top = WU.TopWindow()
  if top and top.name == this.name and guildPlayer and guildPlayer.guildLevelChanged then
    WU.SetActive(REF.EffectLevelup, true)
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Event")
    REF.EffectLevelup.EffectGenerator:Play(function()
      WU.SetActive(REF.EffectLevelup, false)
      guildPlayer.guildLevelChanged = false
      this:GameRequest("fci/guild-player/"):Patch({guildLevelChanged = false}, function(result)
        this:SetData("fci/guild-player/", result)
      end)
    end)
  end
end

function Focus(on)
  WU.RecordWindowFocus(100110, on)
  if on then
    ValidateRestrictions(this:GetData("guildId"))
    CheckGuildUpgrade(this:GetData("fci/guild-player/"))
  end
end

function OnGuildMembersClick()
  WU.RecordButtonClick(110005)
  WU.AcquireWindowAsync("GuildMembers")
end

function OnGuildSkillClick()
  WU.RecordButtonClick(110003)
  if this:GetData("fci/guild/skill/") then
    if GU.CheckFunctionCD("Window_GuildProfitCD") then
      WU.AcquireWindowAsync("GuildSkill")
    end
  else
    WU.ShowHintText(WU.GetString("Window_GuildSkillNotAvailable"))
  end
end

function OnGuildSupportClick()
  WU.RecordButtonClick(110001)
  if GU.CheckFunctionCD("Window_GuildSupportCD") then
    WU.AcquireWindowAsync("GuildSupport")
  end
end

function OnGuildStoreClick()
  WU.RecordButtonClick(110004)
  if GU.CheckFunctionCD("Window_GuildShopCD") then
    WU.AcquireWindowAsync("Shop", function(window)
      _ENV["$"](window)["$$SetSelected"](U.GuildShopId)
    end)
  end
end

function OnGuildRecordsClick()
  WU.RecordButtonClick(110006)
  WU.AcquireWindowAsync("GuildRecords")
end

function OnGuildDungeonsClick(go)
  local ref = _ENV["$"](go)
  if ref["@start"] and GU.CheckDungeonCD() then
    if ref["@open"] then
      WU.AcquireWindowAsync("DungeonGuildStage")
    else
      WU.ShowHintText(WU.GetString("DungeonGuild_OpenTimeTip"))
    end
  end
end

function OnRecruitClick()
  local guildId = this:GetData("guildId")
  this:GameRequest("fci/guild-recruit-self/" .. guildId .. "/"):Get(function(result)
    WU.AcquireWindowAsync("GuildRecruit", function(window)
      _ENV["$"](window)["$$SetContent"](result)
    end)
  end)
end

function OnGuildPendingMembersClick()
  WU.RecordButtonClick(110007)
  if GU.IsGuildManager() then
    WU.AcquireWindowAsync("GuildPendingMembers")
  else
    WU.ShowHintText(WU.GetString("Window_GuildPower"))
  end
end

function OnGuildListClick()
  WU.RecordButtonClick(110008)
  this:GameRequest("fci/guild-recommend/"):Post(nil, function(guildRecommend)
    if guildRecommend then
      this:SetData("fci/guild-recommend/", guildRecommend)
      WU.AcquireWindowAsync("GuildList")
    end
  end)
end

function OnGuildMissionClick()
  WU.RecordButtonClick(110002)
  GotoUtil.Goto("Deploy")
end
