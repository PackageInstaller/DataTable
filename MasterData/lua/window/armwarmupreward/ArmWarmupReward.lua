local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local m_allList = PB.all("WarmupChapterProgressConfig")
local m_storyList, m_progressInfo, m_chapterList, m_warmupInfo, m_currentChapterId, m_currentProgressId, m_chapterId, m_rewardList, m_secretPlan

function SetupWindow()
  m_chapterList = {}
  for k, v in pairs(m_allList) do
    if m_chapterList[v.chapterId] == nil then
      m_chapterList[v.chapterId] = {}
    end
    table.insert(m_chapterList[v.chapterId], v)
  end
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRowRewards
  })
  WU.BindButtonEvent(REF.BtnBuyAllOtherRewards, OnYes)
end

function InitWindow()
  this:BindRemote(DB:GameRequest("fci/warmup"), function(info)
    m_warmupInfo = info
    if m_warmupInfo and m_warmupInfo.chapterRecords then
      m_currentChapterId = m_warmupInfo.currentChapterId
      local index = table.find(m_warmupInfo.chapterRecords, function(k, v)
        return v.chapterId == m_warmupInfo.currentChapterId
      end)
      m_currentProgressId = m_warmupInfo.chapterRecords[index].currentProgressId
    else
      error("no info in fci/warmup")
      return
    end
    m_secretPlan = info.secretPlan
    REF.BtnBuyAllOtherRewards.gameObject:SetActive(not m_secretPlan)
    REF.LabelHasBuy.gameObject:SetActive(m_secretPlan)
    SetChapterList()
    WU.TraverseChildren(REF.NodeToggleGroup, function(go, i)
      _ENV["$"](go).Label.UILabel.text = WU.GetString("ArmWarmup_ChapterTitle_" .. i + 1)
      WU.BindButtonEvent(go, function()
        m_chapterId = i + 1
        if m_rewardList and m_rewardList[m_chapterId] then
          LU.Set(REF.WrapContent, #m_rewardList[m_chapterId])
        end
      end)
    end)
  end)
end

function UpdateRowRewards(refRow, wrapIndex, realIndex)
  if realIndex ~= nil and m_rewardList ~= nil and realIndex < #m_rewardList[m_chapterId] then
    local resInfo = m_rewardList[m_chapterId][realIndex + 1]
    if resInfo then
      refRow["$$SetData"](resInfo)
    end
  end
end

function SetChapterId(chapterId)
  m_chapterId = chapterId
  REF.NodeToggleGroup[m_chapterId - 1]["$"].UIToggle.value = true
  LU.Set(REF.WrapContent, #m_rewardList[m_chapterId])
end

function SetChapterList()
  m_rewardList = {}
  for i = 1, #m_chapterList do
    for k, v in pairs(m_chapterList[i]) do
      if v.progressType == PB.enum.WarmupProgressType.Reward then
        if i < m_currentChapterId then
          v.hasGet = true
        elseif m_currentChapterId == i then
          if v.progressId <= m_currentProgressId then
            v.hasGet = true
          else
            v.hasGet = false
          end
        else
          v.hasGet = false
        end
        v.hasSecretPlan = m_secretPlan
        if m_rewardList[i] == nil then
          m_rewardList[i] = {}
        end
        table.insert(m_rewardList[i], v)
      end
    end
  end
end

function OnYes()
  local cost = PB.all("WarmupMiscConfig")[1].secretPlanCost
  if cost then
    WU.TryToRefresh(cost.type, cost.count, function()
      WU.TryToPayResource(cost, function()
        this:GameRequest("fci/warmup/active-secret-plan/"):Post({}, function(result)
          if result and result.resChange then
            DBH.ResChange(result.resChange)
            WU.ShowRewards(result.resChange)
            local info = this:GetData("fci/warmup")
            info.secretPlan = true
            this:SetData("fci/warmup", info)
          end
        end)
      end)
    end, "ArmWarmup_ConfirmToBuySecretPlan")
  else
    error("WarmupMiscConfig has no secretPlanCost")
  end
end
