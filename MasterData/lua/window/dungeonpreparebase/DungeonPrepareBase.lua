local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local GU = require("Common/GroupUtil")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local S = require("Common/Singleton")
local AM = S:Get("ActivityManager")
local DBH = require("Manager/DataBindingHandler")
local m_activityManager = S:Get("ActivityManager")
local ACU = require("Common/ActivityUtil")
local m_customData = {
  replaceChip = false,
  showFirstReward = false,
  showReceivedTip = false
}
local m_reward
local m_dropDisplay = {}
local m_customDropList = {}

function ShowAffixList(dungeonId)
  if dungeonId then
    local actorList = {}
    local monsterList = {}
    local showTypeList = {}
    local showDescList = {}
    local storyDungeons = PB.get("StoryDungeon", dungeonId)
    local dungeons = PB.get("DungeonMonster", dungeonId)
    local isStoryMode = storyDungeons ~= nil
    if isStoryMode then
      for j = 1, #storyDungeons.monsterId do
        actorList[j] = storyDungeons.monsterId[j]
      end
      for j = 1, #dungeons.monsterId do
        monsterList[j] = dungeons.monsterId[j]
      end
    else
      for j = 1, #dungeons.monsterId do
        monsterList[j] = dungeons.monsterId[j]
      end
    end
    for j = 1, #dungeons.showType do
      showTypeList[j] = dungeons.showType[j]
    end
    REF.AffixWidget["$ShowAffixWidget"](dungeonId)
    if REF.LabelTeam then
      REF.LabelTeam.UIHtmlLabel.text = WU.GetString("WindowDungeonInfo_StoryTeamName")
    end
    if 0 < #actorList then
      ShowStoryDungeonActorList(monsterList, showTypeList)
      local fightActorInfo = {
        {
          playerId = this:GetData("playerId"),
          actors = {
            {},
            {},
            {},
            {},
            {},
            {}
          }
        }
      }
      this:SetData("FightActorInfo", fightActorInfo)
    else
      ShowStoryDungeonActorList(monsterList, showTypeList)
    end
  end
end

function SetDungeonInfo(dungeonId, chapterId, record)
  if record and record.unlocked then
    local dungeonTitle = ""
    local dungeonType = m_reward.type
    local reward = m_reward
    m_customDropList = {}
    for k, v in pairs(m_dropDisplay) do
      m_customDropList[k] = v
    end
    local dropDisplay = m_customDropList
    if chapterId then
      local chapterText = WU.GetString("ChapterName_" .. chapterId)
      dungeonTitle = dungeonTitle .. HU.ApplyFontSize(chapterText, 42)
    end
    local dungeonText = WU.GetString("DungeonName_" .. dungeonId)
    local spaceText = "&nbsp;"
    REF.LabelDungeonTitle.UIHtmlLabel.text = dungeonTitle .. HU.ApplyFontSize(spaceText, 42) .. HU.ApplyFontSize(spaceText, 42) .. HU.ApplyFontSize(dungeonText, 42)
    REF.LabelTeamTitle.UILabel.text = WU.GetString("Window_Opponent")
    REF.LabelTeam.gameObject:SetActive(false)
    local dungeonMonster = PB.get("DungeonMonster", dungeonId)
    REF.TextureStage.UITexture.mainTexturePath = "Texture/StageThumb/" .. dungeonMonster.stageID
    local doneTaskMap = {}
    for i = 1, #record.targetsDone do
      doneTaskMap[record.targetsDone[i]] = true
    end
    local winTypeResult = DU.GetDungeonWinTypeText(dungeonMonster.winParam)
    REF.LabelWinTitle.UIHtmlLabel.text = WU.GetString("WinType_Title") .. tostring(winTypeResult[1])
    if #reward.target > 0 then
      for i = 1, #reward.target do
        local target = reward.target[i]
        local targetText = WU.GetDungeonTargetText(target)
        if doneTaskMap[target.id] then
          targetText = HU.ApplyFontColor(targetText, "white")
        end
        local refLabel = REF["LabelTarget" .. target.id]
        if refLabel == nil then
          warning("Debug", "error target id:" .. target.id)
        else
          refLabel.gameObject:SetActive(true)
          REF["SpriteStar" .. target.id].gameObject:SetActive(true)
          refLabel.UIHtmlLabel.text = targetText
          REF["SpriteStar" .. target.id].UISprite.graify = not doneTaskMap[target.id]
        end
      end
    else
      for i = 1, 3 do
        REF["LabelTarget" .. i].gameObject:SetActive(false)
        REF["SpriteStar" .. i].gameObject:SetActive(false)
      end
    end
    local hasCost = 0 < #reward.cost
    if hasCost then
      local cost = reward.cost[1]
      local costWin = reward.costWin[1]
      REF.LabelCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count + costWin.count)
    end
    WU.ToggleRendering(REF.LabelCost, hasCost)
    this:BroadcastGameEvent("SetDungeonPrepareFightButton", dungeonType, record)
    local label1X = fif(WU.IsRendering(REF.LabelCost), -50, 0)
    REF.Label1.transform.localPosition = {x = label1X}
    if record.new then
      if m_customData.showReceivedTip then
        _ENV["$"](REF.NodeDrops).LabelTitle.UILabel.text = WU.GetString("WindowDungeon_PassGet")
      else
        _ENV["$"](REF.NodeDrops).LabelTitle.UILabel.text = WU.GetString("WindowDungeon_FirstGet")
      end
      REF.NodeDrops.gameObject:SetActive(true)
      REF.NodeTeam.transform.localPosition = {
        x = REF.NodeTeam.transform.localPosition.x,
        y = -290,
        z = 0
      }
      m_customData.showFirstReward = true
      LU.Set(REF.DropContent, #reward.dropDisplayFirst)
    else
      do
        local isStoryMode = PB.get("StoryDungeon", dungeonId) ~= nil
        local extraRewardParams = {
          type = fif(isStoryMode, PB.enum.ActivityExtraRewardRuleType.Dungeon_Story, PB.enum.ActivityExtraRewardRuleType.Dungeon_Normal),
          chapterId = chapterId,
          dungeonId = dungeonId
        }
        AM.GetTimeLimitExtraReward(extraRewardParams, function(extra)
          if #extra ~= 0 then
            for i = 1, #extra do
              table.insert(dropDisplay, extra[i])
            end
          end
          if dropDisplay == nil or #dropDisplay == 0 then
            REF.NodeDrops.gameObject:SetActive(false)
            REF.NodeTeam.transform.localPosition = {
              x = REF.NodeTeam.transform.localPosition.x,
              y = 23,
              z = 0
            }
          else
            REF.NodeDrops.gameObject:SetActive(true)
            REF.NodeTeam.transform.localPosition = {
              x = REF.NodeTeam.transform.localPosition.x,
              y = -290,
              z = 0
            }
          end
        end)
        if m_customData.showReceivedTip then
          _ENV["$"](REF.NodeDrops).LabelTitle.UILabel.text = WU.GetString("WindowDungeon_AlreadyGot")
        else
          _ENV["$"](REF.NodeDrops).LabelTitle.UILabel.text = WU.GetString("WindowDungeon_MaybeGet")
        end
        m_customData.showFirstReward = false
        LU.Set(REF.DropContent, #dropDisplay)
      end
    end
  else
    WU.ShowHintText(WU.GetString("Error_DungeonLocked"))
    WU.RecycleWindow(this)
  end
end

function ButtonFightClick(dungeonId, chapterId)
  local dungeonType = m_reward.type
  if dungeonType == PB.enum.DungeonType.Story or dungeonType == PB.enum.DungeonType.Training or dungeonType == PB.enum.DungeonType.Challenge then
    if not DU.IsWaitingForJob(FightStaticGroup) then
      FightStaticGroup(dungeonId)
    end
  else
    this:SetData("ActorGroup/DungeonId", dungeonId)
    this:SetData("ActorGroup/ChapterId", chapterId)
    if DU.IsSemifixedDungeon(dungeonId) then
      WU.AcquireWindowAsync("SemiFixedChapterActorGroup")
    else
      WU.AcquireWindowAsync("ActorGroup")
    end
  end
end

function FightStaticGroup(dungeonId)
  if m_reward then
    if #m_reward.cost > 0 then
      local cost = m_reward.cost[1]
      local costWin = m_reward.costWin[1]
      WU.TryToPay(cost.type, cost.id, cost.count + costWin.count, function()
        Fight(dungeonId)
      end)
    else
      Fight(dungeonId)
    end
  end
end

function Fight(dungeonId)
  local dungeonType = m_reward.type
  if dungeonId then
    if dungeonType == PB.enum.DungeonType.Story or dungeonType == PB.enum.DungeonType.Training or dungeonType == PB.enum.DungeonType.Challenge then
      WU.EnterStoryDungeon(dungeonId, nil, nil, dungeonType)
    end
  else
    info("Dungeon", "Invalid dungeon id")
  end
end

function SetFightMembers(members)
  local actorList = {}
  this:RegisterGameEvent("fci/actor/", function()
    SetSelectActorGroupId(actorList)
  end)
  local isRemoteData = false
  for i = 1, #members do
    local member = members[i]
    if member.actorUid and member.actorUid ~= 0 then
      if not this:GetData("fci/actor/" .. member.actorUid) then
        isRemoteData = true
      end
      this:Bind("fci/actor/" .. member.actorUid, function(actorInfo)
        if actorInfo ~= nil and actorInfo.id ~= 0 then
          actorList[member.index + 1] = actorInfo
        else
          actorList[member.index + 1] = {}
        end
      end)
    else
      actorList[member.index + 1] = {}
    end
  end
  if not isRemoteData then
    SetSelectActorGroupId(actorList)
  end
end

function SetSelectActorGroupId(actorList)
  local fightActorInfo = {
    {
      playerId = this:GetData("playerId"),
      actors = actorList
    }
  }
  this:SetData("FightActorInfo", fightActorInfo)
end

function ShowStoryDungeonActorList(monsterIds, showTypeList)
  local actors = GU.MonsterGroup(monsterIds)
  REF.WidgetDungeonGroup["$SetTips"](showTypeList, true)
  REF.WidgetDungeonGroup["$SetViewByActors"](actors, true, true)
end

function InitEnemyAttr(dungeonId)
  local dungeons = PB.get("DungeonMonster", dungeonId)
  local mainMonster = {}
  local assistMonster = {}
  local monsterList = {}
  local count = 0
  local hp = 0
  local speed = 0
  local index = 1
  local mainIndex = 1
  local subIndex = 4
  local mainMonsterLv = 0
  for i = 1, 6 do
    local monsterID = 0
    local monsterLv = 0
    count = count + 1
    if (i - 1) % 2 == 0 then
      monsterID = dungeons.monsterId[mainIndex]
      monsterLv = dungeons.level[mainIndex]
      mainIndex = mainIndex + 1
    else
      monsterID = dungeons.monsterId[subIndex]
      monsterLv = dungeons.level[subIndex]
      subIndex = subIndex + 1
    end
    local ret = WU.GetMonsterAttr(monsterID, monsterLv)
    if ret and ret[PB.enum.AttrType.Hp] then
      hp = hp + ret[PB.enum.AttrType.Hp].value
    end
    if ret and ret[PB.enum.AttrType.Speed] and ret[PB.enum.AttrType.Speed].value ~= 0 then
      speed = ret[PB.enum.AttrType.Speed].value
      mainMonsterLv = monsterLv
    end
    if count == 2 then
      local refAttr = _ENV["$"](REF[string.format("NodeAttr%d", index)])
      refAttr.SpeedValue.UIHtmlLabel.text = tostring(speed)
      refAttr.LifeValue.UIHtmlLabel.text = tostring(hp)
      count = 0
      hp = 0
      speed = 0
      index = index + 1
    end
  end
end

function InitHelp(dungeonId)
  local dungeon = PB.get("DungeonMonster", dungeonId)
  REF.TipsMethonLabel.UIHtmlLabel.text = WU.GetString(string.format("RecommendDesc_%d", dungeon.recommendDesc))
  for i = 1, 3 do
    local refActor = REF.GameObjectRole[i - 1]
    local actorID = dungeon.recommendID[i]
    if actorID and actorID ~= 0 then
      refActor.root.gameObject:SetActive(true)
      refActor["$$SetData"](actorID)
    else
      refActor.root.gameObject:SetActive(false)
    end
  end
end

function InitMonsterInfo(dungeonId)
  local dungeon = PB.get("DungeonMonster", dungeonId)
  if dungeon == nil then
    warning("DungeonTeam", "DungeonMonster.xlsx no dungeonId : " .. tostring(dungeonId))
    return
  end
  local player = WU.GetString("Window_OurSide")
  local enemy = WU.GetString("Window_EnemySide")
  local affixList = _ENV["!"]({})
  affixList:append(dungeon.team1Affix or {})
  affixList:append(dungeon.team2Affix or {})
  affixList = affixList:distinct()
  local setupedIndex = 0
  for index = 1, 3 do
    local affix = affixList[index]
    local refBuff = _ENV["$"](REF[string.format("NodeBuff%d", index)])
    if affix then
      local affixContent = WU.GetString("AffixDesc_" .. affix)
      local desc = WU.GetString("AffixTitle_" .. affix)
      local playerDesc = ""
      local playerOwn = false
      if table.has(dungeon.team1Affix, affix) then
        playerDesc = playerDesc .. player
        playerOwn = true
      end
      if table.has(dungeon.team2Affix, affix) then
        if playerOwn then
          playerDesc = playerDesc .. "/"
        end
        playerDesc = playerDesc .. enemy
      end
      refBuff.AffixTitleLabel.UIHtmlLabel.text = desc .. " - " .. playerDesc
      refBuff.AffixDescLabel.UIHtmlLabel.text = affixContent
      setupedIndex = index
    end
    refBuff["$gameObject"]:SetActive(affix ~= nil)
  end
  return setupedIndex
end

function UpdateDropSlot(ref, wrapIndex, realIndex)
  local widgetIconSlot = ref.root
  local dataSource = {}
  
  local function ManageDisplay(dataSource)
    local dropDisplay = dataSource[realIndex + 1]
    if dropDisplay.type == PB.enum.ResourceType.ResPlayerGold or dropDisplay.type == PB.enum.ResourceType.ResPlayerExp or dropDisplay.type == PB.enum.ResourceType.ResPlayerMoney then
      widgetIconSlot["$SetData"](dropDisplay.type, dropDisplay.id, dropDisplay.count)
    else
      widgetIconSlot["$SetData"](dropDisplay.type, dropDisplay.id)
    end
    widgetIconSlot["$SetClickCallback"](function()
      WU.ShowResourceDetail(dropDisplay.type, dropDisplay.id)
    end)
    if m_customData.showReceivedTip and dropDisplay.type ~= PB.enum.ResourceType.ResPlayerExp then
      widgetIconSlot["$SetTips"](fif(m_customData.showReceivedTip, "received", nil))
    end
  end
  
  if (not m_customData.showFirstReward or m_customData.replaceChip) and m_customDropList ~= nil and realIndex < #m_customDropList then
    ManageDisplay(m_customDropList)
  end
  if not m_customData.replaceChip and m_customData.showFirstReward and realIndex < #m_reward.dropDisplayFirst then
    ManageDisplay(m_reward.dropDisplayFirst)
  end
end

function SetCustom(param)
  m_customData.replaceChip = param.replaceChip
  m_customData.showFirstReward = param.showFirstReward
  m_customData.showReceivedTip = param.showReceivedTip
end

function SetDrop(reward, dropDisplay)
  m_reward = reward
  m_dropDisplay = dropDisplay
end

function BindDrop()
  LU.Bind(REF.DropContent, {
    updateRow = UpdateDropSlot
  })
end

function RefreshDrop()
  LU.Set(REF.DropContent, #m_customDropList)
end

function Goto(dungeonId)
  if type(dungeonId) ~= "number" then
    dungeonId = math.floor(tonumber(dungeonId))
  end
  this:SetData("DungeonPrepare/ChapterId", DU.GetChapterId(dungeonId))
  this:SetData("DungeonPrepare/DungeonId", dungeonId)
end
