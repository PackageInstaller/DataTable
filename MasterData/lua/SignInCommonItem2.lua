local item = nil
local reward = nil

function Refresh(_data,_elseData)
	local num1 =  (_elseData and _elseData.isSpecial) and 1 or 2
	CSAPI.LoadImg(bg,"UIs/SignInContinue3/img_08_0" .. num1..".png",true,nil,true)
	local num2 = (_elseData and _elseData.isSpecial) and 2 or 1
	CSAPI.LoadImg(img,"UIs/SignInContinue3/img_07_0" .. num2..".png",true,nil,true)

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
		local iconName = "img_12_0" .. itemData:GetQuality()
		CSAPI.LoadImg(icon,"UIs/SignInContinue3/" .. iconName..".png",true,nil,true)
	end
end
