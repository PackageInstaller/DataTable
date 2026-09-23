local top = nil

function OnInit()
	top = UIUtil:AddTop2("DungeonDetials2", topParent, OnClickBack, nil, {})
	CSAPI.SetGOActive(top.btn_home, false)
end

function OnOpen()
    if data and #data > 0 then
        SetItems()
    end
end

function SetItems()
    local item = nil
    for i, v in ipairs(data) do
        ResUtil:CreateUIGOAsync("DungeonDetail/DungeonDetailList", rewardNode, function(go)
            item = ComUtil.GetLuaTable(go)
            item.SetTweenDelay(i)
            item.Refresh(GetRewardCfgGoods(v.rewards,v.elseData))
            item.ShowLine(not v.isNotLine)
            item.SetTitle(v.languageText)
        end)
    end
end

--读取掉落表中的信息
function GetRewardCfgGoods(list, elseData)
	local tab = {};
	if list then
		for k, v in ipairs(list) do
            if type(v) == "table" then
                local item = nil;
				if v[3] == nil then
					v[3] = RandRewardType.ITEM
				end
				if v[3] == RandRewardType.ITEM then
					item = GoodsData({id = v[1], num = v[2]});
				elseif v[3] == RandRewardType.EQUIP then
					item = EquipData();
					item:InitCfg(v[1]);
				elseif v[3] == RandRewardType.CARD then
					item = RoleMgr:GetFakeData(v[1], v[2])
					item:InitCfg(v[1]);
				end
				table.insert(tab, {data = item,elseData = elseData})
            else
                local goodsData = GoodsData();
				goodsData:InitCfg(v);
				table.insert(tab, {data = goodsData,elseData = elseData});
            end
		end
	end
	return tab
end

function OnClickBack()
    view:Close()
end