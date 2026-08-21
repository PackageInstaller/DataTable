local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_dungeonId, m_chapterId

function Start()
  WU.BindButtonEvent(REF["$"], OnDungeonClick)
end

function SetData(dungeonRecord, chapterId)
  m_dungeonId = dungeonRecord.dungeonId
  m_chapterId = chapterId
  REF.LabelName.UILabel.text = WU.GetString("DungeonName_" .. m_dungeonId)
  REF.LabelDesc.UILabel.text = WU.GetString("DungeonDescribe_" .. m_dungeonId)
  for i = 0, 2 do
    local star = REF["Star" .. i]
    if star then
      if dungeonRecord and dungeonRecord.finished then
        star.UISprite.enabled = true
        local starName = "star_dark"
        if i < #dungeonRecord.targetsDone then
          starName = "star_light"
        end
        star.UISprite.spriteName = starName
      else
        star.UISprite.enabled = false
      end
    end
  end
  local dungeonMonster = PB.get("DungeonMonster", m_dungeonId)
  if dungeonMonster ~= nil then
    REF.TextureDungeon.UITexture.mainTexturePath = "Texture/ChallengeChapter/challenge_stage_" .. dungeonMonster.stageIcon
  else
    error("DungeonMonster.xlsx", "cannot find entry by dungeonId: " .. m_dungeonId)
  end
end

function OnDungeonClick()
  WU.RecordButtonClick(m_chapterId .. m_dungeonId)
  this:SetData("DungeonPrepare/ChapterId", m_chapterId)
  this:SetData("WindowDungeon/DungeonId", m_dungeonId)
  this:SetData("DungeonPrepare/DungeonId", m_dungeonId)
  WU.AcquireWindowAsync("DungeonTraining")
end
