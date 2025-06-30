-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/handbooknode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HandBookNode = class("HandBookNode")
local UIManager = ((CS.PixelNeko).UI).UIManager
HandBookNode.AssetBundleName = ""
HandBookNode.AssetName = ""
HandBookNode.Ctor = function(self, parendWnd, parentNode, nodecfg)
  -- function num : 0_0 , upvalues : UIManager
  self._parentNode = parentNode
  self._nodeWindow = (UIManager.CreateLuaWindow)(self.AssetBundleName .. ".assetbundle", self.AssetName, parendWnd)
  if self._parentNode then
    local _, parentXOffect, _, parentYOffect = ((self._parentNode)._nodeWindow):GetPosition()
    ;
    (self._nodeWindow):SetPosition(0.5, parentXOffect + nodecfg.xAxisPan, 0.5, parentYOffect + nodecfg.yAxisPan)
  else
    do
      ;
      (self._nodeWindow):SetPosition(0.5, nodecfg.xAxisPan - 100, 0.5, nodecfg.yAxisPan - 100)
    end
  end
end

HandBookNode.Destroy = function(self)
  -- function num : 0_1 , upvalues : UIManager
  (UIManager.Destroy)((self._nodeWindow)._uiObject)
end

HandBookNode.GetChild = function(self, path)
  -- function num : 0_2 , upvalues : UIManager
  return (UIManager.GetChildLuaWindow)((self._nodeWindow)._uiObject, path)
end

return HandBookNode

