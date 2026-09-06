local EventTriggerHelper = CS.PixelNeko.P1.TimeLine.EventTriggerHelper
local GuideType = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "Story Enter")
  CS.PixelNeko.P1.TimeLine.TimelineManager.GetPlayableDirector(controller._timeline):Play()
  EventTriggerHelper.AddGraphStopListener(controller._timeline, function()
    controller._baseMainFSM:SetBoolean("toUnloadStory", true)
    local storyId = controller._baseMainFSM:GetParameter("storyId")
    if storyId == 2001 then
      NekoData.BehaviorManager.BM_Game:SetGuideTag(GuideType.mirror_1, 1)
    elseif storyId == 2003 then
      NekoData.BehaviorManager.BM_Game:SetGuideTag(GuideType.GUIDE_2003, 1)
    elseif storyId == 2004 then
      NekoData.BehaviorManager.BM_Game:SetGuideTag(GuideType.FOREST_BOSS_BACK, 1)
    elseif storyId == 2006 then
      NekoData.BehaviorManager.BM_Game:SetGuideTag(GuideType.RUNE, 1)
    elseif storyId == 2007 then
      NekoData.BehaviorManager.BM_Game:SetGuideTag(GuideType.GUIDE_2007, 1)
    elseif storyId == 2008 then
      NekoData.BehaviorManager.BM_Game:SetGuideTag(GuideType.GUIDE_2008, 1)
    elseif storyId == 2009 then
      NekoData.BehaviorManager.BM_Game:SetGuideTag(GuideType.GUIDE_2009, 1)
    elseif storyId == 2010 then
      NekoData.BehaviorManager.BM_Game:SetGuideTag(GuideType.GUIDE_2010, 1)
    end
  end, controller)
end

function State.Update(controller)
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "Story Exit")
  controller._baseMainFSM:SetBoolean("toUnloadStory", false)
end

return State
