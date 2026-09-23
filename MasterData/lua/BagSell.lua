--背包出售装备逻辑
local this={};
local root=nil;
local data=nil;
local sellList={};
local qualitys=nil; --自动选中的品质

function this.SetData(_root,_data)
	sellList={};
    root=_root;
    data=_data;
end


function this.Refresh()
    local list = EquipMgr:GetNotEquippedItem(nil,false, false);
	root.Refresh(list);
	this.CountSellPrice();
end

-- function this.GetScreenDataType()
--     return EquipViewKey.Sell;
-- end

function this.GetElseData(data)
    local isSelect=false
    if sellList then
        for k, v in ipairs(sellList) do
            if v:GetID() == data:GetID() then
                isSelect = true;
                break;
            end
        end
    end
    return  {isClick = true, isSelect = isSelect,selectType=4,showNew=true,removeFunc = nil};
end

function this.OnClickGrid(tab)
	if tab.data:IsNew() then
		EquipProto:SetIsNew({tab.data:GetID()}, function()
			tab.SetNewState(tab.data:IsNew());
		end);
    end
    --批量出售
    if sellList == nil then
        sellList = {};
    end
	if g_EquipChooiseNum <= #sellList and not tab.IsSelect() then
        Tips.ShowTips(LanguageMgr:GetTips(16003));
        do return end
    end
    if tab.data:IsLock() then
        Tips.ShowTips(LanguageMgr:GetTips(16000));
        do return end
    end
	if EquipMgr:CheckIsRefreshLast(tab.data:GetID()) then
		do return end
	end
    local isSelect = not tab.IsSelect();
    tab.SetChoosie(isSelect);
    if tab.IsSelect() then
        table.insert(sellList, tab.data);
    else
        for k, v in ipairs(sellList) do
            if v:GetID() == tab.data:GetID() then
                table.remove(sellList, k)
                break;
            end
        end
    end
	this.SetEquipInfo(tab.IsSelect() and tab.data or nil);
    this.CountSellPrice();
end

--统计出售结算信息
function this.CountSellPrice()
	local price = 0;
	local rewardsNum = 0;
	local num = 0;
	if sellList then
		for k, v in ipairs(sellList) do
			price = price + v:GetSellPrice();
			local num = v:GetSellRewards() == nil and 0 or v:GetSellRewards() [1].num;
			rewardsNum = rewardsNum + num;
		end
		num = #sellList;
	end
	--刷新计算信息
	root.SetSellPrice(num,price,rewardsNum);
end

--点击批量出售按钮
function this.OnClickSendSell()
	--弹确认框
	if sellList and #sellList > 0 then
		local dialogdata = {
			content = LanguageMgr:GetTips(16001),
			okCallBack = function()
				this.SendSell();
			end,
		}
		CSAPI.OpenView("Dialog", dialogdata)
	else
		Tips.ShowTips(LanguageMgr:GetTips(16002));
	end
end

function this.SendSell()
	--出售
	local ids = {};
	local price = 0;
	local index=1;
	--获取奖励物品信息
	for k, v in ipairs(sellList) do
		table.insert(ids, v:GetID());
		price = price + v:GetSellPrice();
	end
	--发送出售协议
	EquipProto:EquipSell(ids);
end

function this.OnSellRet()
	this.ClearSellList();
	this.CountSellPrice();
	this.Refresh();
	root.RefreshNumObj();
	this.SetEquipInfo();
end

function this.ClearSellList()
	sellList = {};
end

function this.OnClickReturn()
	root.SetSellStyle(1);
	this.ClearSellList();
	root.PlaySellTween(false);
	FuncUtil:Call(function()
		root.ChangeLayout(BagMgr:GetSelChildTabIndex(),EquipBagType.Normal,BagType.Equipped);
		root.PlaySellTween(true);
	end,nil,460);
end

function this.AutoSelect(_qualitys)
	this.ClearSellList();
	qualitys=_qualitys;
	local list = EquipMgr:GetAllEquipArr(nil, false);
	-- list = EquipMgr:DoScreen(list, EquipMgr:GetScreenData(this.GetScreenDataType()));
	list=SortMgr:Sort(11,list);
	if list and #list > 0 then
		if sellList == nil then
			sellList = {};
		end
		local hasChoosie = false;
		for i = 1, #list do
			if #sellList>=g_EquipChooiseNum then --限制选中数量
				break;
			end
			local v = list[i];
			local has = false;
			local hasQuality=false;
			if qualitys then
				for _,quality in ipairs(qualitys) do
					if v:GetQuality()==quality then
						hasQuality=true;
						break;
					end
				end
			end
			--已存在的和加锁的不选,4,5星不选，强化过的不选
			if v:IsLock() == true or hasQuality~=true or v:IsEquipped() == true then
				has = true;
			else
				for _, val in ipairs(sellList) do
					if val:GetID() == v:GetID() then 
						has = true;		
						break;
					end
				end
			end
			if has == false then
				hasChoosie = true;
				table.insert(sellList, v);
			end
		end
	end
	this.SetEquipInfo();
end

function this.SetEquipInfo(equip)
	if equip~=nil then
		root.SetSellEquipInfo(equip);
	elseif sellList~=nil and #sellList>0 then
		root.SetSellEquipInfo(sellList[1]);
	else
		root.SetSellEquipInfo();
	end
end

return this