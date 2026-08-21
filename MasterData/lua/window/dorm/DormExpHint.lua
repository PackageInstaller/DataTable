local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DormUtil")
local LU = require("Common/ListUtil")
local m_expList, m_expAddPer

function SetupWindow()
  LU.Bind(REF.WrapContentExp, {
    updateRow = UpdateSlot
  })
end

function UninitWindow()
  if this:GetData("fci/dorm/{playerId}").dormInfo.foodCount <= 0 then
    this:DelayInvokeInFrames(1, function()
      WU.AcquireWindowAsync("DormFeedMessageBox")
    end)
  end
end

function SetData(expList)
  m_expList = expList
  LU.Set(REF.WrapContentExp, #m_expList)
end

function UpdateSlot(goRef, wrapIndex, realIndex)
  if realIndex and m_expList and realIndex < #m_expList then
    local data = m_expList[realIndex + 1]
    goRef["$$SetExp"](data.uid, data, this:GetData("Dorm/ExpAddPerHour"))
  end
end
