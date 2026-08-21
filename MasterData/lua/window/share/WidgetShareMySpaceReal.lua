local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")

function SetShareInfo(data)
  local info = DB:GetData("Space/SelectedPlayer")
  local guild = this:GetData("fci/guild/")
  local photo = PB.get("PlayerHeadPhoto", info.headPhoto)
  REF.PlayerHeadPhoto["$SetPlayerInfo"](info)
  SetAura(info)
  SetMedals(info)
  SetMembers(info)
  REF.LabelName.UILabel.text = info.name
  REF.LabelLevel.UILabel.text = WU.GetString("Sort_ActorLevel") .. "\239\188\154Lv." .. info.level
  if guild then
    REF.LabelGuild.UILabel.text = WU.GetString("WindowSpace_Guild") .. guild.name
  else
    REF.LabelGuild.UILabel.text = WU.GetString("Window_GuildNotExist")
  end
  REF.SignLabel.UILabel.text = U.trim(info.sign)
end

function SetMedals(playerInfo)
  SetMedal(REF.WidgetIconSlotFight, playerInfo.fightMedal, nil, true)
  for i = 1, #REF.NodeMedalsGrid do
    local medalId
    if playerInfo.showMedals[i] then
      medalId = playerInfo.showMedals[i]
    end
    SetMedal(REF.NodeMedalsGrid[i - 1].WidgetIconSlotShow, medalId, nil, false)
  end
end

function SetMedal(medalRef, medalId, pos, isFight)
  local hasMedal = medalId ~= nil and medalId ~= 0
  if hasMedal then
    medalRef["$SetData"](PB.enum.ResourceType.ResMedal, medalId)
    medalRef["$ShowCustom"]({name = false})
  else
    medalRef["$SetEmpty"](4)
    WU.SetActive(REF.SpriteEquipedMedal, false)
  end
end

function SetAura(playerInfo)
  local ref = REF.WidgetIconSlotAssist
  if playerInfo.auraActorId ~= nil and playerInfo.auraActorId > 0 then
    local actorId = playerInfo.auraActorId
    ref["$SetActorCustom"]({
      id = actorId,
      quality = playerInfo.auraActorQuality
    })
    WU.SetActive(REF.SpritePlayerAssist, true)
  else
    WU.SetActive(REF.SpritePlayerAssist, false)
    ref["$SetEmpty"](4)
  end
end

function SetMembers(playerInfo)
  local members = playerInfo.showGroup["1"].members
  local groupActors = {}
  for index = 1, 6 do
    if members and members[index] then
      table.insert(groupActors, members[index].actor)
    end
  end
  REF.WidgetDungeonGroup["$SetCustomActorId"](-4)
  REF.WidgetDungeonGroup["$SetViewByActors"](groupActors)
  REF.WidgetDungeonGroup["$SetSpriteLine"](false)
end
