local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_actor, m_type

function SetupWindow()
  WU.BindButtonEvent(REF.BtnConfirm, function()
    if m_type == PB.enum.ActivityType.CustomActorCultivation then
      OnClickConfirm()
    else
      OnCoupleConfirm()
    end
  end)
  WU.BindButtonEvent(REF.BtnCancel, function()
    WU.RecycleWindow(this)
  end)
end

function SetActor(uid, type)
  m_type = type
  m_actor = this:GetData("fci/actor/" .. uid)
  REF.LabelTitle.UIHtmlLabel.text = WU.GetString(fif(m_type == PB.enum.ActivityType.CustomActorCultivation, "Window_Hint", "Window_CoupleHint"))
  REF.LabelHint.UILabel.text = WU.GetString(fif(m_type == PB.enum.ActivityType.CustomActorCultivation, "CustomActorCultivation_MsgHint", "CoupleActorCultivation_MsgHint"))
  REF.WidgetIconActor["$SetActor"](m_actor)
end

function OnClickConfirm()
  local activity = this:GetData("CustomActorCultivation/CurActivity")
  this:GameRequest("fci/custom-actor-cultivation/"):Put({
    activityType = PB.enum.ActivityType.CustomActorCultivation,
    activityId = activity.activityId,
    actorId = m_actor.id
  }, function(resp)
    this:SetData("fci/custom-actor-cultivation/", resp)
    WU.RecycleWindow(this)
  end)
end

function OnCoupleConfirm()
  this:GameRequest("fci/couple/choose/"):Patch({
    coupleActorId = m_actor.id
  }, function(resp)
    this:SetData("fci/couple/", resp)
    WU.RecycleWindow(this)
  end)
end
