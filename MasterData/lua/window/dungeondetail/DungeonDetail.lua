local BASE = inherit("Window/DungeonPrepareBase/DungeonPrepareBase", _ENV)
local PB = require("Common/PbHelper")
local WU, DB, REF = require("Common/WindowUtil")(this)
local HU = require("Common/HtmlUtil")
local ACU = require("Common/ActivityUtil")
local LU = require("Common/ListUtil")
local GU = require("Common/GroupUtil")

function SetupWindow()
end

function InitWindow()
end

function InitOpponent(dungeonId)
  local monsterList = {}
  local showTypeList = {}
  local showDescList = {}
  local dungeons = PB.get("DungeonMonster", dungeonId)
  if dungeons == nil then
    warning("DungeonMonster.xlsx", "id:" .. tostring(dungeonId))
    return
  end
  for j = 1, #dungeons.monsterId do
    monsterList[j] = dungeons.monsterId[j]
  end
  for j = 1, #dungeons.showType do
    showTypeList[j] = dungeons.showType[j]
  end
  local actors = GU.MonsterGroup(monsterList)
  SetTips(showTypeList, true)
  SetViewByActors(actors, true)
end

function SetTips(titleIds, isReversed)
  REF.MonsterInfo.gameObject:SetActive(true)
  for index = 1, 6 do
    local trueIndex = index
    if isReversed then
      trueIndex = 7 - index
    end
    WU.ClearPressEvent(REF["ShowDesc" .. index])
    local flag = titleIds[trueIndex] and titleIds[trueIndex] ~= 0
    WU.ToggleRendering(REF["ShowDesc" .. index], flag)
    if flag then
      WU.BindPressEvent(REF["ShowDesc" .. index], function(go, pressed)
        if pressed then
        else
        end
      end)
    end
  end
end

function SetViewByActors(actors, isReversed)
  for index = 1, 6 do
    local actorIndex = index
    if isReversed then
      actorIndex = 7 - index
    end
    local actor = actors[actorIndex]
    if actor then
      _ENV["$"](REF.Members)["WidgetIconActor" .. index]["$SetActorCustom"](actor)
      _ENV["$"](REF.Members)["WidgetIconActor" .. index]["$ShowCustom"]({showLock = false})
    end
  end
end

function SetData(dungeonId, activityId, level)
  local dungeonName = WU.GetString("DungeonTeam_MonsterInfo")
  if activityId then
    local activityId2GroupId = this:GetData("fci/teamdungeongroups/") or {}
    dungeonName = WU.GetString("DungeonTeamName_" .. tostring(activityId2GroupId[tostring(activityId)]))
    dungeonName = dungeonName .. WU.GetString("Window_Level", level or "")
  end
  REF.MonsterInfo.gameObject:SetActive(false)
  REF.DungeonTitle.UILabel.text = dungeonName
  InitOpponent(dungeonId)
  BASE.InitEnemyAttr(dungeonId)
  BASE.InitHelp(dungeonId)
  local index = BASE.InitMonsterInfo(dungeonId)
  REF.Buff.gameObject:SetActive(index ~= 0)
  local position = fif(index ~= 0, CS.UnityEngine.Vector3(-464, 0, 0), CS.UnityEngine.Vector3.zero)
  REF.LeftContent.transform.localPosition = position
end
