-- 物品礼包面板
local grid = nil;
function OnOpen()
	if(data) then
		if(goodsItems) then
			for _, goodItems in ipairs(goodsItems) do
				goodItems.Remove()
			end
			goodsItems = nil
		end
		-- if grid==nil then
		--     _,grid=ResUtil:CreateGridItem(gridNode.transform);
		-- end
		-- grid.Clean();
		-- grid.SetClickState(false);
		-- grid.LoadIcon(data.icon);
		-- grid.LoadFrame(data.quality or 1);
		if data.isMember ~= true then --非月卡礼包
			if data.cfgId then -- 根据掉落ID显示
				ShowByRewardID(data)
			elseif data.rewardList then -- 根据传入的id列表显示
				ShowByRewardList(data)
			elseif data.commodity then --商品
				ShowByCommodity(data)
			end
		else --月卡礼包
			ShowByMember(data);
		end
		if goodsItems then
			CSAPI.SetScriptEnable(sv, "ScrollRect", #goodsItems > 14)
            if #goodsItems < 14 then
                for i = #goodsItems + 1, 14 do
                    CreateGrid()
                end
            end
		end
	else
		LogError("打开物品礼包界面失败！参数无效")
	end
end

function ShowByRewardID(data)
	local cfgId = data.cfgId
	local cfgGoodsPack = Cfgs.RewardInfo:GetByID(cfgId)
	if(cfgGoodsPack and cfgGoodsPack.item) then
		for _, v in ipairs(cfgGoodsPack.item) do
			-- if v.probability and v.probability ~= 0 then
				local itemData = GridUtil.RandRewardConvertToGridObjectData(v);
				CreateGrid(itemData, false, false);
			-- end
		end
	end
end

function ShowByRewardList(data)
	for _, v in ipairs(data.rewardList) do
		local itemData = GridUtil.RandRewardConvertToGridObjectData({id = v[1], num = v[2], type = v[3]});
		CreateGrid(itemData, false, false);
	end
end

function ShowByCommodity(data)
	for _, v in ipairs(data.commodity) do
		local itemData = GridUtil.RandRewardConvertToGridObjectData({id = v.cid, type = v.type, num = v.num});
		CreateGrid(itemData, false, false);
	end
end

--月卡
function ShowByMember(data)
	local list = data.item:GetCommodityList();
	for k, v in ipairs(list) do
		if v.type == RandRewardType.ITEM and v.data:GetType() == ITEM_TYPE.PROP and v.data:GetDyVal1() == PROP_TYPE.MemberReward then
			for key, val in ipairs(v.data:GetCfg().dy_tb) do
				local good = GoodsData();
				good:InitCfg(val[1]);
				local itemData = {icon = good:GetIcon(), quality = good:GetQuality(), cid = val[1], num = val[2], type = val[3], name = good:GetName()};
				CreateGrid(itemData, false, true);
			end
		else
			local itemData = {
				icon = v.data:GetIcon(),
				quality = v.data:GetQuality(),
				name = v.data:GetName(),
				num = v.num,
				type = v.type,
				cid = v.cid,
			};
			CreateGrid(itemData, true, true);
		end
	end
end

--isOnce:是否是首次获得，isDesc:是否显示说明文本
function CreateGrid(itemData, isOnce, isDesc)
	ResUtil:CreateUIGOAsync("DepositGrid/DepositGrid", goodsNode, function(go)
        CSAPI.SetScale(go, 1.2, 1.2, 1.2)
		if itemData then
			local tab = ComUtil.GetLuaTable(go);
			tab.Init(itemData);
			tab.SetDesc(isOnce and LanguageMgr:GetByID(24020) or "");
			tab.ShowDesc(isDesc);
			goodsItems = goodsItems or {}
			table.insert(goodsItems, tab);
		end
	end);
end

-- 关闭
function OnClickClose() Close() end

function Close()
	view:Close()
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
root=nil;
txt_Titile=nil;
sv=nil;
goodsNode=nil;
gridNode=nil;
txt_anyway=nil;
view=nil;
end
----#End#----