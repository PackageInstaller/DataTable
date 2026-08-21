local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")

function SetupWindow()
  REF.Black["$SetCallback"](function()
    WU.SetLockFlag(PB.enum.LockInputFlag.UITransition, true)
    WU.SetActive(REF.Content, false)
    WU.SetActive(REF.EffectTitle, false)
    REF.EffectBG.EffectGenerator.m_EffectName = "UI_panle_bg_middleB_PlayerLevelUp"
    REF.EffectBG.EffectGenerator:Reset()
    DB:DelayInvokeInScaledSeconds(REF.EffectBG.EffectGenerator.Duration, function()
      WU.RecycleWindow(this)
    end)
  end)
end

function InitWindow()
  WU.SetActive(REF.EffectBG, false)
  WU.SetActive(REF.Content, false)
  WU.SetActive(REF.EffectTitle, true)
  WU.SetLockFlag(PB.enum.LockInputFlag.UITransition, true)
  DB:DelayInvokeInScaledSeconds(REF.EffectTitle.EffectGenerator.Duration, function()
    WU.SetActive(REF.EffectBG, true)
    REF.EffectBG.EffectGenerator.m_EffectName = "UI_panle_bg_middleA_PlayerLevelUp"
    REF.EffectBG.EffectGenerator:Reset()
    WU.SetActive(REF.Content, true)
    WU.SetLockFlag(PB.enum.LockInputFlag.UITransition, false)
  end)
end

function UninitWindow()
  WU.SetLockFlag(PB.enum.LockInputFlag.UITransition, false)
end
