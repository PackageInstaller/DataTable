--素材背包
local this={};
local root=nil;
local data=nil;
function this.SetData(_root,_data)
    root=_root;
    data=_data;
end

function this.Refresh()
    local list = this.GetShowGoods();  
    root.Refresh(list);
end

-- function this.GetScreenDataType()
--     return EquipViewKey.Bag;
-- end

--返回显示的素材信息
function this.GetShowGoods()
	local bagDatas = BagMgr:GetDatas();
	local arr = {};
	if(bagDatas) then
		for _, data in pairs(bagDatas) do
			if(data~=nil) then 
				if data:IsExipiryType() then--判断是否是限时物品，限时物品特殊处理
					--判断当前物品的get_infos中有多少个分栏显示道具
					if data:GetData().get_infos and #data:GetData().get_infos>1 then
						for k,v in ipairs(data:GetData().get_infos) do
							local tempData=table.copy(data:GetData());
							tempData.num=v[1];
							tempData.id=v[3];
							tempData.get_infos={v};
							local tempGoods=GoodsData(tempData);
							local cfgGoods = tempGoods:GetCfg();
							if cfgGoods and cfgGoods.hide == nil and tempData.num>0 then
								table.insert(arr, tempGoods);
							end
						end
					else
						local cfgGoods = data:GetCfg();
						if cfgGoods and cfgGoods.hide == nil then
							table.insert(arr, data);
						end
					end
				else
					local cfgGoods = data:GetCfg();
					if cfgGoods and cfgGoods.hide == nil then
						table.insert(arr, data);
					end
				end
			end
		end
		--根据品质和id进行排序
		table.sort(arr, function(a, b)
			if a:GetQuality() == b:GetQuality() then
				return a:GetID() < b:GetID();
			else
				return a:GetQuality() > b:GetQuality()
			end
		end);
	end
	return arr;
end

function this.GetElseData(element)
    return {isClick = true, isSelect = false,selectType=1,showNew=true,checkRed=true,removeFunc = nil};
end

function this.OnClickGrid(tab)
	UIUtil:OpenGoodsInfo( tab.data);
	BagMgr:SetNewState(tab.data:GetID(),false);
	tab.SetNewState(BagMgr:IsNew(tab.data:GetID()));
end

function this.OnClickReturn()
    root.Close();
end

return this;