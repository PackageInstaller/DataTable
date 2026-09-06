local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager

local function func(guideFrame)
  local dialog = DialogManager.GetDialog(guideFrame[1])
  if dialog then
    local baseSceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if baseSceneController then
      local x, y, z = TransformStaticFunctions.GetPosition(baseSceneController._sceneRef._base_gate.gameObject)
      local xx, yy = UIManager.ScreenPointToLocalPointInRectangle(nil, UIManager.WorldToScreenPointInMargin("Main", x, y, z))
      return {
        parent = dialog._rootWindow._uiObject,
        effectPos = {posX = xx, posY = yy}
      }
    end
  end
end

return func
