---自动生成代码----start----
local OtakuemployeeOverviewHeroSimpleItemUI = BaseClass( 'OtakuemployeeOverviewHeroSimpleItemUI' , BaseView )
local M = OtakuemployeeOverviewHeroSimpleItemUI 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.normal = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Bg/normalbg" )
  self.lock = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Bg/lock" )
  self.empty = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Bg/empty" )
  self.name = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "Bg/normalbg/normal/name" )
  self.state = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "Bg/normalbg/normal/state" )
  self.value = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "Bg/normalbg/normal/valuelabel/value" )
end
return OtakuemployeeOverviewHeroSimpleItemUI
---自动生成代码----end----