---自动生成代码----start----
local TrainingHeroPrefab = BaseClass( 'TrainingHeroPrefab' , BaseView )
local M = TrainingHeroPrefab 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.img_bg = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , nil )
  self.img_head = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "img_Head" )
  self.txt_name = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "txt_Name" )
  self.txt_lv = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "txt_Lv" )
  self.select = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "select" )
end
return TrainingHeroPrefab
---自动生成代码----end----