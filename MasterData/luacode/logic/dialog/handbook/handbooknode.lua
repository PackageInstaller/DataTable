local HandBookNode = class("HandBookNode")
local UIManager = CS.PixelNeko.UI.UIManager
HandBookNode.AssetBundleName = ""
HandBookNode.AssetName = ""

function HandBookNode:Ctor(parendWnd, parentNode, nodecfg)
  self._parentNode = parentNode
  self._nodeWindow = UIManager.CreateLuaWindow(self.AssetBundleName .. ".assetbundle", self.AssetName, parendWnd)
  if self._parentNode then
    local _, parentXOffect, _, parentYOffect = self._parentNode._nodeWindow:GetPosition()
    self._nodeWindow:SetPosition(0.5, parentXOffect + nodecfg.xAxisPan, 0.5, parentYOffect + nodecfg.yAxisPan)
  else
    self._nodeWindow:SetPosition(0.5, nodecfg.xAxisPan - 100, 0.5, nodecfg.yAxisPan - 100)
  end
end

function HandBookNode:Destroy()
  UIManager.Destroy(self._nodeWindow._uiObject)
end

function HandBookNode:GetChild(path)
  return UIManager.GetChildLuaWindow(self._nodeWindow._uiObject, path)
end

return HandBookNode
