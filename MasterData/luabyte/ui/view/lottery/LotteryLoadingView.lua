---自动生成代码----start----
local LotteryLoadingView = BaseClass( 'LotteryLoadingView' , BaseView )
local M = LotteryLoadingView 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.LotteryLoading = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Animator) , nil )
end
return LotteryLoadingView
---自动生成代码----end----