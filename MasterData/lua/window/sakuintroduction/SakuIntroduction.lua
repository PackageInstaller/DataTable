local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local m_tutorialManager = S:Get("TutorialManager")
local m_time = 0

function SetupWindow()
  WU.BindButtonEvent(REF.Black, EnterFirstDungeon)
end

function InitWindow()
  REF.WidgetBoardActor["$PlayByActorID"](9999)
  REF.SpriteActor["$PlayRandomAnimation"](true, false)
  WU.SetActive(REF.GuideHand, false)
end

function UpdateWindow(delta)
  m_time = m_time + delta
  if 2 < m_time then
    WU.SetActive(REF.GuideHand, true)
  end
end

function EnterFirstDungeon()
  m_tutorialManager.TutorialDone(99)
  local allTutorial = m_tutorialManager.GetAllTutorial()
  this:SetData("CurrentTutorial", 21)
  WU.RecycleWindow("SakuIntroduction")
  WU.AcquireWindowAsync("ChapterNormal")
end
