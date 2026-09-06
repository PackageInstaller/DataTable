local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager

local function func(guideFrame)
  if guideFrame[1] then
    local baseSceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if baseSceneController then
      return function()
        local sizeAndPos = baseSceneController:GetBuildingSizeAndPos(guideFrame[1])
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
