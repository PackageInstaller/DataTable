-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/guide.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EventTriggerHelper = (((CS.PixelNeko).P1).TimeLine).EventTriggerHelper
local GuideType = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local Guide = class("Guide")
Guide.Ctor = function(self, delegate)
  -- function num : 0_0 , upvalues : _ENV, GuideType, EventTriggerHelper
  if delegate:GetSceneID() == 12005 and ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuideType.YARD_APPEAR) ~= 1 then
    (LuaNotificationCenter.AddObserver)(self, self.OnDialogCloseBtnClick, Common.n_DialogCloseBtnClick, nil)
    if (EventManager.FindByConfigID)(100345) then
      self._timeLine = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((delegate._sceneRef)._rootGameObject, "W1_Area_05_ForBuild_06")
      if self._timeLine then
        self._handler = (EventTriggerHelper.AddGraphStopListener)(self._timeLine, function()
    -- function num : 0_0_0 , upvalues : _ENV
    ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(6)
  end
, self)
      end
    else
      ;
      ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(6)
    end
  end
end

Guide.Destroy = function(self)
  -- function num : 0_1 , upvalues : EventTriggerHelper, _ENV
  if self._timeLine then
    (EventTriggerHelper.RemoveGraphStopListener)(self._timeLine, self._handler)
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

Guide.OnDialogCloseBtnClick = function(self, notification)
  -- function num : 0_2 , upvalues : _ENV
  if (notification.userInfo)._dialogName == "newbattle.battleteachguidedialog" then
    local GuideType = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
    ;
    ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuideType.YARD_APPEAR, 1)
    ;
    (LuaNotificationCenter.RemoveObserver)(self)
  end
end

return Guide

