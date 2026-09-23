--分享


function OnOpen()
	UIUtil:ShowAction(root, nil, UIUtil.active2)
end

function OnClickWB()
	--Log("分享")
	Tips.ShowTips(StringConstant.tips1)
end 

function OnClickWX()
	--Log("分享")
	Tips.ShowTips(StringConstant.tips1)
end 

function OnClickTT()
	--Log("分享")
	Tips.ShowTips(StringConstant.tips1)
end

function OnClickClose()
    Close()
end 

function Close(func)
	UIUtil:HideAction(root, function()
		if(func) then
			func()
		end
		view:Close()
	end, UIUtil.active4)
end 
