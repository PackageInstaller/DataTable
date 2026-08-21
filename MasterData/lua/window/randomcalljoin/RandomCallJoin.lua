local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local m_info, m_ac
local m_clickAble = false

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonEnter, OnEnter)
  WU.BindButtonEvent(REF.ButtonPrizePreview, OnPrizePreview)
end

function InitWindow()
  RefreshContent()
  m_ac = this:GetData("RandomCall/Activity")
  WU.SetLabel(REF.LabelDurationTime, "--" .. WU.RenderTime24(m_ac.timestampStart, m_ac.timestampClose) .. "--")
  this:RegisterGameEvent("RandomCall/RewardRefresh", RefreshContent)
end

function OnPrizePreview()
  if not m_clickAble then
    return
  end
  local prizes = PB.all("RDPVPReward")
  WU.AcquireWindowAsync("RandomCallPrizePreview", function(window)
    _ENV["$"](window)["$$SetPrizes"](prizes, true)
  end)
end

function OnEnter()
  if not m_info.locked then
    DB:GameRequest("fci/RDPVPInfo/"):Post({}, function(result)
      DBH.ResChange(result.resChange)
      m_info = result
      m_info.resChange = nil
      this:SetData("fci/RDPVPInfo/", m_info)
      WU.AcquireWindowAsync("RandomCallMatching")
    end)
  else
    WU.AcquireWindowAsync("RandomCallMatching")
  end
end

function RefreshContent()
  m_clickAble = false
  WU.EnableToRequest("RandomCall/UpdateAble", "fci/RDPVPInfo/", function(result)
    m_info = result
    m_clickAble = true
    WU.SetLabel(REF.LabelWinCnt, WU.GetString("Tournament_BurstLinkWinCount", m_info.baseInfo.winCount, m_info.baseInfo.totalNum))
  end)
end
