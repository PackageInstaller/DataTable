local item = nil
local reward = nil

function Refresh(_data,_elseData)
	local reward = {type = _data[3], num = _data[2], id = _data[1]}	
	if reward then
		if(not item) then
			local go = ResUtil:CreateUIGO("Grid/GridSignInContinueItem", itemParent.transform)
			item = ComUtil.GetLuaTable(go)
		end
		local itemData = GridUtil.RandRewardConvertToGridObjectData(reward)
		CSAPI.SetText(txtName,itemData:GetName() or "")
		CSAPI.SetText(txtCount,reward.num .. "" or "0")
		item.Refresh(itemData)
		item.SetClickCB(GridClickFunc.OpenInfoSmiple)
		CSAPI.LoadImg(bg,"UIs/SignInContinue4/img_11_0" .. itemData:GetQuality()..".png",true,nil,true)
		CSAPI.LoadImg(img,"UIs/SignInContinue4/img_12_0" .. itemData:GetQuality()..".png",true,nil,true)
	end
end
