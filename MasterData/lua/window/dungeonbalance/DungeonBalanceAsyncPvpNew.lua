local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local BASE = inherit("Window/DungeonBalance/DungeonBalanceBase", _ENV)
local m_balanceCommon, m_balanceAsyncPvp

function SetupWindow()
  WU.BindButtonEvent(REF.NodeContinue, function()
    BASE.OnButtonContinueClick()
  end)
end

function InitWindow()
  local data = this:GetData("DungeonBalance/result")
  m_balanceCommon = data.common.balanceInfo
  m_balanceAsyncPvp = data.asyncPvpV2
  WU.SetActive(REF.NodeReward, false)
  local isWin = m_balanceCommon.win
  local ref = _ENV["$"](REF.NodePlayer)
  local myGroup = this:GetData("AsyncPvpNew/FightGroup")
  local baseInfo = this:GetData("fci/baseinfo/")
  AU.SetPlayerName(ref.LabelName, this:GetData("accountCache"), baseInfo)
  ref.WidgetOpponentGroup["$ResetStyle"]()
  ref.WidgetOpponentGroup["$SetViewStyle"]({showArm = true})
  ref.WidgetOpponentGroup["$SetViewByMembers"](myGroup, false)
  local asyncPvpInfo = this:GetData("AsyncPvpNew/BaseInfo")
  local segInfo = PB.get("AsyncPvpRankReward", asyncPvpInfo.curSeg)
  ref.SpriteRank.UISprite.spriteName = "icon_" .. segInfo.segRank
  WU.SetActive(ref.SpriteWin, isWin)
  ref = _ENV["$"](REF.NodeOpponent)
  local opponent = this:GetData("AsyncPvpNew/Opponent")
  ref.LabelName.UILabel.text = opponent.team.playerName
  ref.WidgetOpponentGroup["$ResetStyle"]()
  ref.WidgetOpponentGroup["$SetViewStyle"]({showArm = true})
  ref.WidgetOpponentGroup["$SetViewByActors"](opponent.team.battleActors, true)
  local segInfo = PB.get("AsyncPvpRankReward", opponent.team.curSeg)
  ref.SpriteRank.UISprite.spriteName = "icon_" .. segInfo.segRank
  WU.SetActive(ref.SpriteWin, not isWin)
  local resultList = m_balanceAsyncPvp.continueWinInfo
  local resultCount = #resultList
  for i = 0, #REF.ListProgress - 1 do
    local ref = REF.ListProgress[i]
    local flag = resultList[i + 1]
    local showEffect = i + 1 == resultCount
    WU.SetActive(ref.SpriteWin, flag == true and not showEffect)
    WU.SetActive(ref.SpriteFail, flag == false and not showEffect)
    WU.SetActive(ref.EffectWin, flag == true and showEffect)
    WU.SetActive(ref.EffectFail, flag == false and showEffect)
    WU.SetActive(ref.SpriteEmpty, flag == nil)
  end
  DBH.ResChange(m_balanceCommon.resChange)
  local item = WU.GetRewardList(m_balanceCommon.resChange)
  WU.SetActive(REF.NodeReward, false)
  if 0 < #item then
    WU.SetActive(REF.NodeReward, true)
    WU.SetItemToWidgetIconSlot(REF.ListReward[0], item[1])
  end
  local valueStr = WU.GetString("NAsyncPvp_AssessmentFormat", m_balanceAsyncPvp.cumulativeScore, m_balanceAsyncPvp.winScore)
  REF.LabelAssessment.UIHtmlLabel.text = WU.GetString("NAsyncPvp_AssessmentScore", valueStr)
  DB:SetData("AsyncPvpNew/BaseInfo", nil)
end
