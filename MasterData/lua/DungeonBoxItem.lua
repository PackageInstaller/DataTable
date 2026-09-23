--箱子物品
local index = 0
local reward = nil
local item = nil

function SetIndex(idx)
	index = idx
end

function Refresh(_data)
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
	end
end

function SetTextShow(isGet)
	CSAPI.SetGOActive(desc, isGet)
end 
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
itemParent=nil;
desc=nil;
txtDesc=nil;
view=nil;
end
----#End#----