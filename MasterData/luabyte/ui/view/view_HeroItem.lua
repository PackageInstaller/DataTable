---自动生成代码----start----
local view_HeroItem = BaseClass( 'view_HeroItem' , BaseView )
local M = view_HeroItem 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.rimg_roleIcon = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.RawImage) , "Rolemask/rimg_roleIcon" )
  self.img_quality = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "img_quality" )
  self.trans_star0 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Star/trans_star0" )
  self.trans_star1 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Star/trans_star1" )
  self.trans_star2 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Star/trans_star2" )
  self.trans_star3 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Star/trans_star3" )
  self.trans_star4 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Star/trans_star4" )
  self.img_proIcon = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "profession/img_proIcon" )
  self.iconItem_Item = UIUtil.FindComponent( trans , typeof(CS.GameX.AvatarInfoUI) , "iconItem_Item" )
end
return view_HeroItem
---自动生成代码----end----