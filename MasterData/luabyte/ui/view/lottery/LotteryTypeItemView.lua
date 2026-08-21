---自动生成代码----start----
local LotteryTypeItemView = BaseClass( 'LotteryTypeItemView' , BaseView )
local M = LotteryTypeItemView 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.rimg_role3 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.RawImage) , "rimg_role3" )
  self.rimg_role2 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.RawImage) , "rimg_role2" )
  self.rimg_role1 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.RawImage) , "rimg_role1" )
  self.tsBtn_once = UIUtil.FindComponent( trans , typeof(CS.TSButton) , "BtnGroup/tsBtn_once" )
  self.tsBtn_ten = UIUtil.FindComponent( trans , typeof(CS.TSButton) , "BtnGroup/tsBtn_ten" )
  self.trans_consume1 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "BtnGroup/trans_consume1" )
  self.img_Icon = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "BtnGroup/trans_consume1/img_Icon" )
  self.txt_valueTf = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "BtnGroup/trans_consume1/txt_valueTf" )
  self.trans_consume2 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "BtnGroup/trans_consume2" )
  self.img_Icon = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "BtnGroup/trans_consume2/img_Icon" )
  self.txt_valueTf = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "BtnGroup/trans_consume2/txt_valueTf" )
  self.tsBtn_playInfo = UIUtil.FindComponent( trans , typeof(CS.TSButton) , "BtnGroup/tsBtn_playInfo" )
  self.tsBtn_history = UIUtil.FindComponent( trans , typeof(CS.TSButton) , "BtnGroup/tsBtn_history" )
  self.txt_restTimeTf = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "Time/txt_restTimeTf" )
end
return LotteryTypeItemView
---自动生成代码----end----