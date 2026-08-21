---自动生成代码----start----
local OtakuemployeeOverviewRoomItemUI = BaseClass( 'OtakuemployeeOverviewRoomItemUI' , BaseView )
local M = OtakuemployeeOverviewRoomItemUI 
--desc

function M:__init(go)
--require
  local OtakuRoomsOverivewHeroItemUI = require( 'UI.View.Otaku.MainUI.OtakuRoomsOverivewHeroItemUI')
--declare
  local trans = go.transform 
  self.name = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "BannerBg/name" )
  self.num = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "BannerBg/Icon/num" )
  self.heroItem1 = OtakuRoomsOverivewHeroItemUI.New(trans:Find("itemContainer/heroItem1").gameObject)
  self.heroItem2 = OtakuRoomsOverivewHeroItemUI.New(trans:Find("itemContainer/heroItem2").gameObject)
  self.heroItem3 = OtakuRoomsOverivewHeroItemUI.New(trans:Find("itemContainer/heroItem3").gameObject)
  self.heroItem4 = OtakuRoomsOverivewHeroItemUI.New(trans:Find("itemContainer/heroItem4").gameObject)
  self.heroItem5 = OtakuRoomsOverivewHeroItemUI.New(trans:Find("itemContainer/heroItem5").gameObject)
  self.Select = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Select" )
  self.bg = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "bg" )
  self.Star1 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "BannerBg/StarsGroup/StarBg/Star1" )
  self.Star2 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "BannerBg/StarsGroup/StarBg (1)/Star2" )
  self.Star3 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "BannerBg/StarsGroup/StarBg (2)/Star3" )
  self.Star4 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "BannerBg/StarsGroup/StarBg (3)/Star4" )
  self.Star5 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "BannerBg/StarsGroup/StarBg (4)/Star5" )
  self.Star6 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "BannerBg/StarsGroup/StarBg (5)/Star6" )
  self.Star7 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "BannerBg/StarsGroup/StarBg (6)/Star7" )
  self.Star8 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "BannerBg/StarsGroup/StarBg (7)/Star8" )
  self.Star9 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "BannerBg/StarsGroup/StarBg (8)/Star9" )
  self.Star10 = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "BannerBg/StarsGroup/StarBg (9)/Star10" )
  self.order = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "BannerBg/order" )
  self.shortName = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "BannerBg/order/shortName" )
  self.BannerBg = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.RawImage) , "BannerBg" )
end
return OtakuemployeeOverviewRoomItemUI
---自动生成代码----end----