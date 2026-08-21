---自动生成代码----start----
local OtakuEmployeeOverivewHeroItemUI = BaseClass( 'OtakuEmployeeOverivewHeroItemUI' , BaseView )
local M = OtakuEmployeeOverivewHeroItemUI 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.noPos = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "noPos" )
  self.lock = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "lock" )
  self.icon = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "container/icon" )
  self.state = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "container/state" )
  self.Slider = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Slider) , "container/Slider" )
  self.plus = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "plus" )
  self.container = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "container" )
end
return OtakuEmployeeOverivewHeroItemUI
---自动生成代码----end----