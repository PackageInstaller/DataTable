local EventTriggerHelper = CS.PixelNeko.P1.TimeLine.EventTriggerHelper
local GuideType = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local Guide = class("Guide")

function Guide:Ctor(delegate)
  if delegate:GetSceneID() == 12005 and NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuideType.YARD_APPEAR) ~= 1 then
    LuaNotificationCenter.AddObserver(self, self.OnDialogCloseBtnClick, Common.n_DialogCloseBtnClick, nil)
    if EventManager.FindByConfigID(100345) then
      self._timeLine = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(delegate._sceneRef._rootGameObject, "W1_Area_05_ForBuild_06")
      if self._timeLine then
        self._handler = EventTriggerHelper.AddGraphStopListener(self._timeLine, function()
          DialogManager.CreateSingletonDialog("newbattle.battleteachguidedialog"):Init(6)
        end, self)
      end
    else
      DialogManager.CreateSingletonDialog("newbattle.battleteachguidedialog"):Init(6)
    end
  end
end

function Guide:Destroy()
  if self._timeLine then
    EventTriggerHelper.RemoveGraphStopListener(self._timeLine, self._handler)
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function Guide:OnDialogCloseBtnClick(notification)
  if notification.userInfo._dialogName == "newbattle.battleteachguidedialog" then
    local GuideType = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
    NekoData.BehaviorManager.BM_Game:SetGuideTag(GuideType.YARD_APPEAR, 1)
    LuaNotificationCenter.RemoveObserver(self)
  end
end

return Guide
