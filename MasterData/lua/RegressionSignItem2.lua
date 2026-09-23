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
		CSAPI.SetText(txtNum,reward.num .. "" or "0")
		item.Refresh(itemData)
		item.SetClickCB(GridClickFunc.OpenInfoSmiple)
		local iconName = "img_06_0" .. itemData:GetQuality()
		CSAPI.LoadImg(icon,"UIs/RegressionActivity1/" .. iconName..".png",true,nil,true)
	end
end
