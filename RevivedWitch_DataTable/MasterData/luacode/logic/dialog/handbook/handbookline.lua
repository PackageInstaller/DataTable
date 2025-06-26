-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/handbookline.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HandBookLine = class("HandBookLine")
local UIManager = ((CS.PixelNeko).UI).UIManager
HandBookLine.Ctor = function(self, parendWnd, beginNode, endNode)
  -- function num : 0_0 , upvalues : UIManager, _ENV
  self._lineWindow = (UIManager.CreateLuaWindow)("ui/layouts.tujian.assetbundle", "BookRelationLine", parendWnd)
  local _, xOffect, _, yOffect = (beginNode._nodeWindow):GetPosition()
  local width, height = (beginNode._nodeWindow):GetRectSize()
  ;
  (self._lineWindow):SetPosition(0.5, xOffect + width / 2, 0.5, yOffect + height / 2)
  local endX, endY = (endNode._nodeWindow):GetLocalPosition()
  local beginX, beginY = (beginNode._nodeWindow):GetLocalPosition()
  local dir = ((CS.UnityEngine).Vector3)(endX - beginX, endY - beginY, 0)
  local sizedata = ((CS.UnityEngine).Vector2)(dir.magnitude, 30)
  ;
  (self._lineWindow):SetDeltaSize(sizedata.x, sizedata.y)
  local angle = (math.atan)(dir.y, dir.x)
  ;
  (self._lineWindow):SetLocalEuler(0, 0, angle * 57.29578)
end

HandBookLine.Destroy = function(self)
  -- function num : 0_1 , upvalues : UIManager
  (UIManager.Destroy)((self._lineWindow)._uiObject)
end

return HandBookLine

