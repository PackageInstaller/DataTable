local WU, DB, REF = require("Common/WindowUtil")(this)

function SetupWindow()
  WU.BindButtonEvent(REF.Black, function()
    WU.RecycleWindow("SimpleTitleEffect")
  end)
end

function SetEffect(effectName, effectBgName, callback, clickContinue)
  WU.SetActive(REF.LabelContinue, clickContinue)
  REF.effect.EffectGenerator.m_EffectName = effectName
  REF.effect.EffectGenerator:Reset()
  REF.effectBg.EffectGenerator.m_EffectName = effectBgName
  REF.effectBg.EffectGenerator:Reset()
  REF.effectBg.EffectGenerator:Play()
  REF.effect.EffectGenerator:Play(callback)
end
