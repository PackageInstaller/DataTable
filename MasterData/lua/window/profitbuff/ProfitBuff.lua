local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_profitBuffArray = {}
local m_coroutine

function SetupWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = OnWrapContentUpdate
  })
end

function InitWindow()
  WU.ToggleRendering(REF.WrapContent.UIWrapContent, false)
  RequestData()
end

function UninitWindow()
  if m_coroutine ~= nil then
    this:StopCoroutine(m_coroutine)
    m_coroutine = nil
  end
end

function RequestData()
  this:BindRemote(DB:GameRequest("fci/profit/"), function(response)
    if response ~= nil then
      WU.ToggleRendering(REF.WrapContent.UIWrapContent, true)
      if m_coroutine == nil then
        m_coroutine = this:RepeatInvokeInSeconds(1, function()
          UpdateData()
        end)
      end
      REF.WrapContent.UIWrapContent:UpdateContent(#m_profitBuffArray, true)
      REF.ScrollView.UIScrollView:ResetPosition()
    end
  end)
end

function UpdateData()
  local profitBuffArray = this:GetData("fci/profit/") or {}
  m_profitBuffArray = _ENV["!"](profitBuffArray.result):where(function(k, v)
    return v.endTime > CS.GameTime.serverUtc or v.endTime == 0 and v.startTime == 0
  end):toarray()
  LU.Set(REF.WrapContent, #m_profitBuffArray, false)
  WU.ToggleRendering(REF.NodeEmpty, #m_profitBuffArray == 0)
end

function OnWrapContentUpdate(rowRef, wrapIndex, realIndex)
  if realIndex ~= nil and m_profitBuffArray then
    local profitData = m_profitBuffArray[realIndex + 1]
    if profitData then
      rowRef.ProfitBuffIcon.UISprite.spriteName = "profitbuff_icon_" .. profitData.id
      local text = WU.GetString("Buff_Profit_Id_" .. profitData.id, string.format("%.1f%%", profitData.add / 100))
      rowRef.LabelDesc.UIHtmlLabel.text = text
      if profitData.endTime == 0 and profitData.startTime == 0 then
        rowRef.LabelTime.UIHtmlLabel.text = WU.GetString("Platform_Tips5")
        rowRef.ProgressBarTime.UIProgressBar.value = 1
      elseif profitData.cnt ~= 0 and profitData.cntTotal ~= 0 then
        REF.LabelTime.UIHtmlLabel.text = WU.GetString("Windwo_ProfitLeftTimes", profitData.cnt, profitData.cntTotal)
        REF.ProgressBarTime.UIProgressBar.value = profitData.cnt / profitData.cntTotal
      else
        rowRef.LabelTime.UIHtmlLabel.text = WU.RenderCountDownTime(profitData.endTime - CS.GameTime.serverUtc, rowRef.LabelTime.UIHtmlLabel.fontSize)
        local value = (profitData.endTime - CS.GameTime.serverUtcMs / 1000) / (profitData.endTime - profitData.startTime)
        rowRef.ProgressBarTime.UIProgressBar.value = value
      end
      local isLastItem = realIndex + 1 == #m_profitBuffArray
      WU.ToggleRendering(rowRef.SpriteLine, not isLastItem)
    end
  end
end
