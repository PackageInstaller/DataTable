local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local U = require("Common/Util")
local NU = require("Common/NotepadUtil")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local m_reuseTable = REF.WrapContentReward.ReuseTable
local m_rankInfo, m_rewardInfo
local m_sortedRewards = _ENV["!"]({})

function SetupWindow()
  m_reuseTable.onInitializeItem = UpdateSlot
  m_reuseTable.onGetChildWidget = Trans2BoundsWidget
  m_reuseTable:SetDataCount(0)
end

function InitWindow()
  m_reuseTable:ResetPosition(true)
  this:Bind("fci/maidcafe/rank-mode", OnRankInfoChange)
end

function UpdateSlot(go, wrapIndex, realIndex)
  if m_sortedRewards ~= nil and realIndex < #m_sortedRewards then
    local ref = _ENV["$"](go)
    local rewardInfo = m_sortedRewards[realIndex + 1]
    if rewardInfo then
      if rewardInfo.typeDesc then
        ref["@type"] = 1
        WU.SetActive(ref.DescSlot, true)
        WU.SetActive(ref.RewardSlot, false)
        WU.SetActive(ref.RightDesc, rewardInfo.typeDesc ~= 0)
        local rank
        if rewardInfo.typeDesc == 0 then
          local legendInfo = m_rankInfo.rankModeInfo[PB.enum.MaidCafeRankModeType.Legend]
          if legendInfo.unlocked then
            local rankData = this:GetData("fci/maidcafe/rank-mode/legend-rank/my-rank/")
            if rankData and rankData.rank ~= 0 then
              rank = math.ceil(rankData.rank * 100 / rankData.rankTotal)
              if 60 <= rank then
                rank = WU.GetString("MaidCafe_NotInRange")
              else
                rank = rank .. "%"
              end
            else
              rank = WU.GetString("MaidCafe_RankMode_NoRank")
            end
          else
            rank = WU.GetString("MaidCafe_RankMode_LegendLocked")
          end
          ref.LeftDesc.UIHtmlLabel.text = WU.GetString("MaidCafe_RankMode_PreviewDescLeftType0", rank)
        else
          ref.LeftDesc.UIHtmlLabel.text = WU.GetString("MaidCafe_RankMode_PreviewDescLeftType" .. rewardInfo.typeDesc)
          ref.RightDesc.UIHtmlLabel.text = WU.GetString("MaidCafe_RankMode_PreviewDescRightType" .. rewardInfo.typeDesc)
        end
      else
        ref["@type"] = 2
        WU.SetActive(ref.DescSlot, false)
        WU.SetActive(ref.RewardSlot, true)
        WU.SetActive(ref.SpriteGot, rewardInfo.got)
        for i = 0, #ref.RewardList - 1 do
          local rewardRef = ref.RewardList[i]
          WU.SetActive(rewardRef.root, i < #rewardInfo.reward)
          if i < #rewardInfo.reward then
            local _size = fif(rewardInfo.reward[i + 1].type == PB.enum.ResourceType.ResUniqueWeapon, "S", nil)
            rewardRef["$$SetData"](rewardInfo.reward[i + 1].type, rewardInfo.reward[i + 1].id, rewardInfo.reward[i + 1].count, _size)
            if rewardInfo.reward[i + 1].type == PB.enum.ResourceType.ResUniqueWeapon then
              rewardRef["$$ShowCustom"]({
                hideLevel = true,
                showEquip = false,
                phase = 1,
                showStar = false
              })
            end
            if rewardInfo.rankModeType == PB.enum.MaidCafeRankModeType.Legend then
              WU.SetActive(ref.LabelTitle4, rewardInfo.rankModeValue == 10000)
              WU.SetActive(ref.LabelTitle3, rewardInfo.rankModeValue < 10000)
              WU.SetActive(ref.LabelTitle2, rewardInfo.rankModeValue < 10000)
              ref.LabelTitle3.UILabel.text = rewardInfo.rankModeValue // 100 .. "%"
              WU.SetActive(ref.LabelTitle, false)
              WU.SetActive(ref.Legend, true)
            else
              WU.SetActive(ref.LabelTitle, true)
              WU.SetActive(ref.Legend, false)
              ref.LabelTitle.UILabel.text = rewardInfo.rankModeValue
            end
          end
        end
        ref.RewardList.UIGrid:Reposition()
      end
    end
  end
end

function Trans2BoundsWidget(trans)
  local ref = _ENV["$"](trans)
  if ref["@type"] == 1 then
    ref.Container.UIWidget.height = 60
  elseif ref["@type"] == 2 then
    ref.Container.UIWidget.height = 160
  end
  return ref.Container.UIWidget
end

function OnRankInfoChange(data)
  if data == nil then
    return
  end
  m_sortedRewards = _ENV["!"]({})
  m_rankInfo = data
  m_rewardInfo = data.rankModeRewardInfo
  for _, v in pairs(m_rewardInfo) do
    if m_sortedRewards:count() == 0 or m_sortedRewards[m_sortedRewards:count()].rankModeType ~= v.rankModeType then
      table.insert(m_sortedRewards, {
        typeDesc = v.rankModeType
      })
      table.insert(m_sortedRewards, v)
    else
      table.insert(m_sortedRewards, v)
    end
  end
  table.insert(m_sortedRewards, {typeDesc = 0})
  m_reuseTable:SetDataCount(#m_sortedRewards)
end
