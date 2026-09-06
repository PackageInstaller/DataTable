local HandBookLine = class("HandBookLine")
local UIManager = CS.PixelNeko.UI.UIManager

function HandBookLine:Ctor(parendWnd, beginNode, endNode)
  self._lineWindow = UIManager.CreateLuaWindow("ui/layouts.tujian.assetbundle", "BookRelationLine", parendWnd)
  local _, xOffect, _, yOffect = beginNode._nodeWindow:GetPosition()
  local width, height = beginNode._nodeWindow:GetRectSize()
  self._lineWindow:SetPosition(0.5, xOffect + width / 2, 0.5, yOffect + height / 2)
  local endX, endY = endNode._nodeWindow:GetLocalPosition()
  local beginX, beginY = beginNode._nodeWindow:GetLocalPosition()
  local dir = CS.UnityEngine.Vector3(endX - beginX, endY - beginY, 0)
  local sizedata = CS.UnityEngine.Vector2(dir.magnitude, 30)
  self._lineWindow:SetDeltaSize(sizedata.x, sizedata.y)
  local angle = math.atan(dir.y, dir.x)
  self._lineWindow:SetLocalEuler(0, 0, angle * 57.29578)
end

function HandBookLine:Destroy()
  UIManager.Destroy(self._lineWindow._uiObject)
end

return HandBookLine
