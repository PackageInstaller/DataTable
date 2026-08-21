-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/story.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EventTriggerHelper = (((CS.PixelNeko).P1).TimeLine).EventTriggerHelper
local GuideType = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local State = {}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, EventTriggerHelper, GuideType
  LogInfo("BaseMainFSM", "Story Enter")
  ;
  ((((((CS.PixelNeko).P1).TimeLine).TimelineManager).GetPlayableDirector)(controller._timeline)):Play()
  ;
  (EventTriggerHelper.AddGraphStopListener)(controller._timeline, function()
    -- function num : 0_0_0 , upvalues : controller, _ENV, GuideType
    (controller._baseMainFSM):SetBoolean("toUnloadStory", true)
    local storyId = (controller._baseMainFSM):GetParameter("storyId")
    if storyId == 2001 then
      ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuideType.mirror_1, 1)
    else
      if storyId == 2003 then
        ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuideType.GUIDE_2003, 1)
      else
        if storyId == 2004 then
          ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuideType.FOREST_BOSS_BACK, 1)
        else
          if storyId == 2006 then
            ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuideType.RUNE, 1)
          else
            if storyId == 2007 then
              ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuideType.GUIDE_2007, 1)
            else
              if storyId == 2008 then
                ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuideType.GUIDE_2008, 1)
              else
                if storyId == 2009 then
                  ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuideType.GUIDE_2009, 1)
                else
                  if storyId == 2010 then
                    ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuideType.GUIDE_2010, 1)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
, controller)
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("BaseMainFSM", "Story Exit")
  ;
  (controller._baseMainFSM):SetBoolean("toUnloadStory", false)
end

return State

