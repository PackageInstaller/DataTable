---自动生成代码----start----
local OtakuemployeeOverviewUI = BaseClass( 'OtakuemployeeOverviewUI' , BaseView )
local M = OtakuemployeeOverviewUI 
--desc

function M:__init(go)
--require
  local OtakuemployeeOverviewRoomItemUI = require( 'UI.View.Otaku.Employee.OtakuemployeeOverviewRoomItemUI')
  local OtakuemployeeOverviewHeroSimpleItemUI = require( 'UI.View.Otaku.Employee.OtakuemployeeOverviewHeroSimpleItemUI')
--declare
  local trans = go.transform 
  self.detailItem = OtakuemployeeOverviewRoomItemUI.New(trans:Find("detailRight/detailScrollView/Viewport/Content/detailItem").gameObject)
  self.detailScrollView = UIUtil.FindComponent( trans , typeof(CS.CircularScrollView.UICircularScrollView) , "detailRight/detailScrollView" )
  self.simpleItem1 = OtakuemployeeOverviewHeroSimpleItemUI.New(trans:Find("detail/container/simpleItem1").gameObject)
  self.simpleItem2 = OtakuemployeeOverviewHeroSimpleItemUI.New(trans:Find("detail/container/simpleItem2").gameObject)
  self.simpleItem3 = OtakuemployeeOverviewHeroSimpleItemUI.New(trans:Find("detail/container/simpleItem3").gameObject)
  self.simpleItem4 = OtakuemployeeOverviewHeroSimpleItemUI.New(trans:Find("detail/container/simpleItem4").gameObject)
  self.simpleItem5 = OtakuemployeeOverviewHeroSimpleItemUI.New(trans:Find("detail/container/simpleItem5").gameObject)
  self.tab = UIUtil.FindComponent( trans , typeof(CS.GameX.BaseTab) , "detailRight/tab" )
  self.roomHeroNum = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "detail/settledBg/roomHeroNum" )
  self.roomHeroMax = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "detail/settledBg/image (1)/roomHeroMax" )
end
return OtakuemployeeOverviewUI
---自动生成代码----end----