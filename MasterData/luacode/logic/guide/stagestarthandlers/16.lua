local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager

local function func(guideFrame)
  local baseSceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  if baseSceneController and baseSceneController._lights and baseSceneController._lightPoints then
    local lightObject_1 = baseSceneController._lights[baseSceneController._lightPoints[1]]._gameObject
    if lightObject_1 then
      return function()
        local sizeAndPos = baseSceneController:GetSizeAndPos(lightObject_1)
        return {
          width = sizeAndPos.width,
          height = sizeAndPos.height,
          posX = sizeAndPos.posX,
          posY = sizeAndPos.posY
        }
      end
    end
  end
end

return func
