---自动生成代码----start----
local OtakuEmployeeOverviewItemUI = BaseClass( 'OtakuEmployeeOverviewItemUI' , BaseView )
local M = OtakuEmployeeOverviewItemUI 
--desc

function M:__init(go)
--require
  local OtakuEmployeeOverivewHeroItemUI = require( 'UI.View.Otaku.EmployeeOverview.OtakuEmployeeOverivewHeroItemUI')
--declare
  local trans = go.transform 
  self.name = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "name" )
  self.num = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "num" )
  self.heroItem1 = OtakuEmployeeOverivewHeroItemUI.New(trans:Find("itemContainer/heroItem1").gameObject)
  self.heroItem2 = OtakuEmployeeOverivewHeroItemUI.New(trans:Find("itemContainer/heroItem2").gameObject)
  self.heroItem3 = OtakuEmployeeOverivewHeroItemUI.New(trans:Find("itemContainer/heroItem3").gameObject)
  self.heroItem4 = OtakuEmployeeOverivewHeroItemUI.New(trans:Find("itemContainer/heroItem4").gameObject)
  self.heroItem5 = OtakuEmployeeOverivewHeroItemUI.New(trans:Find("itemContainer/heroItem5").gameObject)
  self.select = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "select" )
  self.bg = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "bg" )
end
return OtakuEmployeeOverviewItemUI
---自动生成代码----end----