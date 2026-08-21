---自动生成代码----start----
local OtakuRoomsOverivewUI = BaseClass( 'OtakuRoomsOverivewUI' , BaseView )
local M = OtakuRoomsOverivewUI 
--desc

function M:__init(go)
--require
  local OtakuRoomsOverivewItemUI = require( 'UI.View.Otaku.MainUI.OtakuRoomsOverivewItemUI')
--declare
  local trans = go.transform 
  self.item = OtakuRoomsOverivewItemUI.New(trans:Find("ScrollView/Viewport/Content/item").gameObject)
  self.ScrollView = UIUtil.FindComponent( trans , typeof(CS.CircularScrollView.UICircularScrollView) , "ScrollView" )
end
return OtakuRoomsOverivewUI
---自动生成代码----end----