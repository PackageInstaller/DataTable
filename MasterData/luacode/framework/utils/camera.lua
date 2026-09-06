local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local Camera = {}

function Camera.LookAtCamera(transform, camera)
  local position
  if camera.orthographic then
    position = transform.position - camera.transform.forward
  else
    position = camera.transform.position
  end
  TransformStaticFunctions.LookAt(transform, position, camera.transform.up)
end

return Camera
