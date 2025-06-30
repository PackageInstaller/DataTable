-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/utils/camera.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local Camera = {}
Camera.LookAtCamera = function(transform, camera)
  -- function num : 0_0 , upvalues : TransformStaticFunctions
  local position = nil
  if camera.orthographic then
    position = transform.position - (camera.transform).forward
  else
    position = (camera.transform).position
  end
  ;
  (TransformStaticFunctions.LookAt)(transform, position, (camera.transform).up)
end

return Camera

