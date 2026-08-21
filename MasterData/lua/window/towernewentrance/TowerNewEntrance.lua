local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local m_difficulties, m_recommend, m_summary, m_ticketCnt

function InitWindow()
  local ticket = PB.index("Misc", 1).extremeChallengeTicket
  m_ticketCnt = this:GetData("fci/item/" .. ticket.id).count
  REF.LabelTimes.UIHtmlLabel.text = WU.GetString("Tower_TimeLeft") .. m_ticketCnt
  DB:GameRequest("fci/extreme-challenge/difficulty/"):Get(function(response)
    if response == nil then
      return
    end
    m_difficulties = response.difficulty
    m_recommend = response.recommended
    m_summary = this:GetData("fci/extreme-challenge/summary/")
    ManageButtonEvents()
    this:RegisterGameEvent("Tower/DifficultyRefresh", function()
    end)
  end)
end

function ManageButtonEvents()
  WU.TraverseChildren(REF.EntranceGroup, function(go, index)
    local gasket = _ENV["$"](go)
    local realIndex = index + 1
    if m_difficulties[realIndex] then
      _ENV["$"](go).SpriteRecommend.gameObject:SetActive(m_difficulties[realIndex] == m_recommend)
      _ENV["$"](go).Label.UILabel.text = WU.GetString("Tower_DifficultyRecommend_" .. m_difficulties[realIndex])
    end
    WU.ClearButtonEvent(gasket.ButtonTip)
    WU.BindButtonEvent(gasket.ButtonTip, function()
      if 0 < m_ticketCnt then
        EnterNewPrepare(realIndex)
      else
        WU.ShowHintText(WU.GetString("Tower_NoTicket"))
      end
    end)
  end)
end

function EnterNewPrepare(realIndex)
  if m_summary and m_summary.curDifficulty == 0 then
    WU.ShowMessageYesNo(WU.GetString("Window_TowerDifficultyConfirm", WU.GetString("Tower_DifficultyRecommend_" .. m_difficulties[realIndex])), function(result)
      if result == "YES" then
        DB:GameRequest("fci/extreme-challenge/difficulty/"):Post({
          difficulty = m_difficulties[realIndex]
        }, function(result)
          if result.result then
            DBH.ResChange(result.resChange)
            m_summary.curDifficulty = result.curDifficulty
            m_summary.enemyGroups = result.enemyGroups
            m_summary.locked = true
            WU.AcquireWindowAsync("TowerNewPrepare", nil, true)
          end
        end)
      else
        return
      end
    end)
  end
end

function SetEffect(result)
  WU.TraverseChildren(REF.EntranceGroup, function(go, index)
    local realIndex = index + 1
    local diffIdx = table.find(m_difficulties, function(k, v)
      return v == result.curDifficulty
    end)
    go.gameObject:SetActive(diffIdx == realIndex or result.curDifficulty == 0)
  end)
  REF.EntranceGroup.UIPlayTween:Play(result.curDifficulty ~= 0)
end

function ShowResetHint()
  WU.ShowHintText(WU.GetString("Tower_ResetTip"))
end

function Focus(on)
  WU.RecordWindowFocus(100121, on)
end
