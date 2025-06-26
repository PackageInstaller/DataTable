-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/22.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  if guideFrame[1] then
    local baseSceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
    do
      if baseSceneController then
        return function()
    -- function num : 0_0_0 , upvalues : baseSceneController, guideFrame
    local sizeAndPos = baseSceneController:GetBuildingSizeAndPos(guideFrame[1])
    return {width = sizeAndPos.width, height = sizeAndPos.height, posX = sizeAndPos.posX, posY = sizeAndPos.posY}
  end

      end
    end
  end
end

return func

