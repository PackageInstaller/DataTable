---自动生成代码----start----
local BridgeInfoPanel = BaseClass( 'BridgeInfoPanel' , BaseView )
local M = BridgeInfoPanel 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.cancel = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "cancel" )
  self.Num = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "container/BridgeInfoPanel/NumBg/Num" )
  self.Star1 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "container/BridgeInfoPanel/StarsGroup/StarBg/Star" )
  self.Star2 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "container/BridgeInfoPanel/StarsGroup/StarBg (1)/Star" )
  self.Star3 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "container/BridgeInfoPanel/StarsGroup/StarBg (2)/Star" )
  self.Star4 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "container/BridgeInfoPanel/StarsGroup/StarBg (3)/Star" )
  self.Star5 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "container/BridgeInfoPanel/StarsGroup/StarBg (4)/Star" )
  self.Star6 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "container/BridgeInfoPanel/StarsGroup/StarBg (5)/Star" )
  self.Star7 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "container/BridgeInfoPanel/StarsGroup/StarBg (6)/Star" )
  self.Star8 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "container/BridgeInfoPanel/StarsGroup/StarBg (7)/Star" )
  self.Star9 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "container/BridgeInfoPanel/StarsGroup/StarBg (8)/Star" )
  self.Star10 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "container/BridgeInfoPanel/StarsGroup/StarBg (9)/Star" )
  self.sRect_Iteams = UIUtil.FindComponent( trans , typeof(CS.CircularScrollView.UICircularScrollView) , "container/UpgradeConsumePanel/sRect_Iteams" )
end
return BridgeInfoPanel
---自动生成代码----end----