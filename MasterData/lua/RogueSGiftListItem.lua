
--箱子物品
local index = 0
local reward = nil
local item = nil

function SetIndex(idx)
	index = idx
end

function Refresh(_data,isGet)
	reward = _data
	if reward then
		if item == nil then
			_, item = ResUtil:CreateGridItem(itemParent.transform);
		end
		local itemData = nil;
		itemData = GridUtil.RandRewardConvertToGridObjectData(reward);
		item.Refresh(itemData)
		item.SetClickCB(GridClickFunc.OpenInfoSmiple);
		if reward.type == RandRewardType.CARD then
			item.SetClickState(false)
		end
        CSAPI.SetGOActive(desc, isGet)
	end
end
