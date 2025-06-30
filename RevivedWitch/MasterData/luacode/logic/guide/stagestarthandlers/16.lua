-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/16.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local baseSceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  if baseSceneController and baseSceneController._lights and baseSceneController._lightPoints then
    local lightObject_1 = ((baseSceneController._lights)[(baseSceneController._lightPoints)[1]])._gameObject
    do
      if lightObject_1 then
        return function()
    -- function num : 0_0_0 , upvalues : baseSceneController, lightObject_1
    local sizeAndPos = baseSceneController:GetSizeAndPos(lightObject_1)
    return {width = sizeAndPos.width, height = sizeAndPos.height, posX = sizeAndPos.posX, posY = sizeAndPos.posY}
  end

      end
    end
  end
end

return func

