local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local U = require("Common/Util")
local S = require("Common/Singleton")
local m_chapterId = 0
local m_dunId = 0
local m_normalChapterId = 0
local m_displayIcon = {
  [2] = "reward",
  [3] = "hard",
  [4] = "impression"
}

function Awake()
  WU.BindButtonEvent(REF["$"], OnDungeonClick)
end

function Start()
end

function GetChapterId()
  return m_chapterId
end

function GetDunId()
  return m_dunId
end

function SetIcon(dungeonRecord)
  local dungeonRef = REF
  local dungeonId = m_dunId
  local dungeonMonster = PB.get("DungeonMonster", dungeonId)
  local stageIcon = "none"
  local stageLockIcon = 0
  if dungeonMonster ~= nil then
    stageIcon = dungeonMonster.stageIcon
    stageLockIcon = dungeonMonster.stageLockIcon
  else
    warning("DungeonMonster.xlsx", "id not found : " .. tostring(dungeonId))
  end
  local isUnlock = DU._IsDungeonUnlock(dungeonRecord)
  if stageLockIcon == 0 or stageLockIcon == nil then
    if REF.GroupFull then
      REF.GroupFull.gameObject:SetActive(false)
    end
    if REF.Group then
      REF.Group.gameObject:SetActive(true)
    end
    if REF.Group then
      dungeonRef = _ENV["$"](REF.Group)
    end
    if dungeonRef.DungeonTexture then
      if 0 < stageIcon then
        dungeonRef.DungeonTexture.UITexture.mainTexturePath = "Texture/NormalChapter/" .. stageIcon
      end
      if not isUnlock then
        dungeonRef.DungeonTexture.UITexture.graify = true
        if dungeonRef.DungeonBossTexture then
          dungeonRef.DungeonBossTexture.UITexture.graify = true
        end
      else
        dungeonRef.DungeonTexture.UITexture.graify = false
        if dungeonRef.DungeonBossTexture then
          dungeonRef.DungeonBossTexture.UITexture.graify = false
        end
      end
    end
  else
    if REF.Group then
      REF.Group.gameObject:SetActive(false)
    end
    if REF.GroupFull then
      REF.GroupFull.gameObject:SetActive(true)
    end
    dungeonRef = _ENV["$"](REF.GroupFull)
    if isUnlock then
      dungeonRef.DungeonTexture.UITexture.mainTexturePath = "Texture/NormalChapter/" .. stageIcon
    else
      dungeonRef.DungeonTexture.UITexture.mainTexturePath = "Texture/NormalChapter/" .. stageLockIcon
    end
  end
end

function SetStatus(dungeonRecord)
  local dungeonRef = REF
  local dungeonId = m_dunId
  local dungeonMonster = PB.get("DungeonMonster", dungeonId)
  local stageIcon = "none"
  local stageLockIcon = 0
  if dungeonMonster ~= nil then
    stageIcon = dungeonMonster.stageIcon
    stageLockIcon = dungeonMonster.stageLockIcon
  else
    warning("DungeonMonster.xlsx", "id not found : " .. tostring(dungeonId))
  end
  SetIcon(dungeonRecord)
  local label = WU.GetString("DungeonTitle_" .. dungeonId)
  if dungeonRef.DungeonLabel then
    dungeonRef.DungeonLabel.UIHtmlLabel.text = label
  end
  local isShowStar = false
  if dungeonRecord then
    isShowStar = DU.IsShowStar(dungeonRecord.dungeonId)
  end
  if not isShowStar and REF.GridStar then
    REF.GridStar.gameObject:SetActive(false)
  end
  for j = 0, 2 do
    local star = dungeonRef["Star" .. j]
    if star then
      if dungeonRecord ~= nil and dungeonRecord.finished == true and isShowStar then
        star.UISprite.enabled = true
        local starName = "star_dark"
        if j < #dungeonRecord.targetsDone then
          starName = "star_light"
        end
        star.UISprite.spriteName = starName
      else
        star.UISprite.enabled = false
      end
    end
  end
  local groupRef = REF
  if REF.Group then
    local groupRef = _ENV["$"](REF.Group)
    if stageLockIcon ~= 0 and stageLockIcon and REF.GroupFull then
      groupRef = _ENV["$"](REF.GroupFull)
    end
  end
  if groupRef.Reward then
    groupRef.Reward.UIPlayTween:Stop()
  end
  if groupRef.NormalContainer then
    local function SetRewardNode(node, dungeonRecord, iconOnPath, iconOffPath)
      REF.GridStar.gameObject:SetActive(false)
      
      groupRef.NormalContainer.gameObject:SetActive(false)
      node.gameObject:SetActive(true)
      local refNode = _ENV["$"](node)
      local isUnlock = DU._IsDungeonUnlock(dungeonRecord)
      if dungeonRecord and dungeonRecord.finished == false and isUnlock then
        node.UIPlayTween:Play(true)
      end
      if not isUnlock then
        refNode.RewardBG.UISprite.spriteName = iconOffPath
      else
        refNode.RewardBG.UISprite.spriteName = iconOnPath
      end
    end
    
    local rewardInfo = PB.get("DungeonReward", dungeonId)
    local displayIcon = m_displayIcon[rewardInfo.displayType]
    local iconOn, iconOff
    if displayIcon then
      iconOn = displayIcon .. "_on"
      iconOff = displayIcon .. "_off"
    end
    if displayIcon then
      SetRewardNode(REF.Reward, dungeonRecord, iconOn, iconOff)
    else
      groupRef.NormalContainer.gameObject:SetActive(true)
      REF.Reward.gameObject:SetActive(false)
      REF.GridStar.gameObject:SetActive(true)
    end
  end
end

function _SetData(data)
  m_chapterId = data.chapterId
  m_dunId = data.dungeonId
end

function SetData(data)
  _SetData(data)
  local chapter = data.chapter
  local dungeonRef = REF
  local dungeonButton = dungeonRef["$gameObject"]
  local dungeonId = data.dungeonId
  m_normalChapterId = data.normalChapterId
  local dungeonRecord = chapter.recordDungeons[dungeonId]
  local sprites = dungeonButton:GetComponentsInChildren(typeof(CS.UISprite), true)
  for s = 0, sprites.Length - 1 do
    if not string.find(sprites[s].name, "Star") and not string.find(sprites[s].name, "RoadSprite") then
      sprites[s].graify = not dungeonRecord or not dungeonRecord.unlocked
    end
  end
  SetStatus(dungeonRecord)
end

function OnDungeonClick(go)
  if m_chapterId == nil then
    warning("Debug", "No chapterID")
    return
  end
  local chapter = this:GetData("fci/dungeon/chapter/" .. m_chapterId)
  if chapter then
    local dungeonId = m_dunId
    local dungeonRecord = chapter.recordDungeons[dungeonId]
    local isUnlock, strTime = DU._IsDungeonUnlock(dungeonRecord)
    if isUnlock then
      this:SetData("WindowDungeon/DungeonId", dungeonId)
      this:SetData("WindowDungeon/ChapterId", m_chapterId)
      this:SetData("DungeonPrepare/ChapterId", m_chapterId)
      this:SetData("DungeonPrepare/DungeonId", dungeonId)
      this:BroadcastGameEvent("SaveChapterPos", m_chapterId)
      if m_dunId == 2 or m_dunId == 5 or m_dunId == 7 or m_dunId == 9 or m_dunId == 13 or m_dunId == 15 then
        WU.AcquireWindowAsync("DungeonTraining")
      else
        WU.AcquireWindowAsync("DungeonStory")
      end
    elseif strTime then
      WU.ShowHintText(WU.GetString("Window_DungeonOpenTime3", strTime))
    else
      WU.ShowHintText(WU.GetString("Error_DungeonLocked"))
    end
  end
end
