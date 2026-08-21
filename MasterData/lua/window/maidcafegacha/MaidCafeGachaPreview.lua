local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_allGachaInfo

function SetupWindow()
  LU.Bind(REF.WrapContent, {
    dataSource = function(dataIndex)
      return m_allGachaInfo ~= nil and m_allGachaInfo[dataIndex]
    end,
    updateSlot = UpdateRewardSlot,
    delta = 0.02
  })
end

function InitWindow()
end

function SetData(data)
  if data == nil then
    return
  end
  m_allGachaInfo = data
  LU.Set(REF.WrapContent, #m_allGachaInfo)
end

function UpdateRewardSlot(slotRef, gachaInfo)
  if gachaInfo then
    local _size = fif(gachaInfo.reward.type == PB.enum.ResourceType.ResUniqueWeapon, "S", nil)
    slotRef["$$SetData"](gachaInfo.reward.type, gachaInfo.reward.id, gachaInfo.reward.count, _size)
    if gachaInfo.reward.type == PB.enum.ResourceType.ResUniqueWeapon then
      local custom = {
        hideLevel = true,
        showEquip = false,
        phase = 1,
        showStar = false
      }
      slotRef["$$ShowCustom"](custom)
      slotRef["$$SetClickCallback"](function()
        WU.ShowArmDetailById(gachaInfo.reward.id, nil, custom)
      end)
    end
    local tip = fif(gachaInfo.gachaCountTotal - gachaInfo.gachaCount == 0, "soldOut", nil)
    slotRef["$$SetTips"](tip)
    slotRef["$$SetBottomText"](WU.GetString("MaidCafe_GachaGot", gachaInfo.gachaCount, gachaInfo.gachaCountTotal))
  else
    slotRef["$$ClearSlot"]()
  end
end
