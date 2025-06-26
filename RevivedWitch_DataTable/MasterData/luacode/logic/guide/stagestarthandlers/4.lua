-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/4.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV, TransformStaticFunctions, UIManager
  local dialog = (DialogManager.GetDialog)(guideFrame[1])
  if dialog then
    local baseSceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
    if baseSceneController then
      local x, y, z = (TransformStaticFunctions.GetPosition)(((baseSceneController._sceneRef)._base_gate).gameObject)
      local xx, yy = (UIManager.ScreenPointToLocalPointInRectangle)(nil, (UIManager.WorldToScreenPointInMargin)("Main", x, y, z))
      return {parent = (dialog._rootWindow)._uiObject, 
effectPos = {posX = xx, posY = yy}
}
    end
  end
end

return func

