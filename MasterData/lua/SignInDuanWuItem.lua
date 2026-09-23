local item = nil
local reward = nil
local frames = GridFrame

function Refresh(_data,_elseData)
	-- local num = (_elseData and _elseData.isSpecial) and 2 or 1
	-- CSAPI.LoadImg(nameObj,"UIs/SignInContinue8/img_07_0" .. num..".png",true,nil,true)
	CSAPI.SetGOActive(getObj,_elseData and _elseData.isGet or false)
	local isHide = _elseData and _elseData.isHide
	CSAPI.SetGOActive(countObj,not isHide)
	local reward = {type = _data[3], num = _data[2], id = _data[1]}	
	if reward then
		if(not item) then
			local go = ResUtil:CreateUIGO("Grid/GridSignInContinueItem", itemParent.transform)
			item = ComUtil.GetLuaTable(go)
		end
		local itemData = GridUtil.RandRewardConvertToGridObjectData(reward)
		-- CSAPI.SetText(txtName,itemData:GetName() or "")
		CSAPI.SetText(txtCount,reward.num .. "" or "0")
		item.Refresh(itemData)
		item.SetClickCB(GridClickFunc.OpenInfoSmiple)
        ResUtil.IconGoods:Load(icon,frames[itemData:GetQuality()])
		-- local iconName = "img_12_0" .. itemData:GetQuality()
		-- CSAPI.LoadImg(icon,"UIs/SignInContinue8/" .. iconName..".png",true,nil,true)
	end
end
