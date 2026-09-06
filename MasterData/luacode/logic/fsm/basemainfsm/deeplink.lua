local State = {}
local controllera

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "DeepLink Enter")
  controllera = controller
  if CS.PixelNeko.P1.DeepLink.GetDeepLinkJsonString then
    CS.PixelNeko.P1.DeepLink.GetDeepLinkJsonString()
  end
  local deeplinkStr = CS.PixelNeko.P1.DeepLink.GetInfo()
  LogInfoFormat("DeepLinkFSM", "deeplinkStr = %s", deeplinkStr)
  if deeplinkStr and string.len(deeplinkStr) > 0 then
    NekoData.BehaviorManager.BM_GotoDialog:HandleDeepLink(deeplinkStr)
  end
  State.GoNormal()
end

function State.Update(controller)
end

function State.GoNormal()
  controllera._baseMainFSM:SetBoolean("toDeeplink", false)
  controllera._baseMainFSM:SetBoolean("toNormal", true)
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "DeepLink Exit")
end

return State
