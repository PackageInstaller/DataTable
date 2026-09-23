
--一些格子的通用点击事件
GridClickFunc = {
	EquipDetails = function(tab, func) --打开装备详情界面
		if tab.data ~= nil then
			if tab.data:GetType()==EquipType.Normal then
				CSAPI.OpenView("EquipFullInfo", tab.data, 3);
			else
				CSAPI.OpenView("GoodsFullInfo",{data=tab.data} , 3);
			end
		end
	end,
	CardTips = function(tab)
		if tab.data ~= nil then
			CSAPI.OpenView("RoleInfo", tab.data, RoleInfoOpenType.LookNoGet)
		end
	end,
	OpenInfoHandy = function(tab)--打开物品描述不显示使用和数量按钮
		if tab.data ~= nil then
			UIUtil:OpenGoodsInfo(tab.data, 4);
		end
	end,
	OpenInfoSmiple = function(tab) --打开物品描述不显示持有数和获取途径和按钮
		if tab.data ~= nil then
			UIUtil:OpenGoodsInfo( tab.data, 3);
		end
	end,
	OpenInfoShort = function(tab) --打开物品描述不显示使用按钮
		if tab.data ~= nil then
			UIUtil:OpenGoodsInfo(tab.data, 2);
		end
	end,
	OpenInfo = function(tab)--正常打开物品信息框
		if tab.data ~= nil then
			UIUtil:OpenGoodsInfo(tab.data);
		end
	end	,
	OpenNotGet=function(tab) --打开未获取的物品
		if tab.data ~= nil then
			local fakeGoods=BagMgr:GetFakeData(tab.data:GetID())--获取背包中的假数据
			UIUtil:OpenGoodsInfo( fakeGoods, 4);
		end
	end,
	OpenEquipInfo=function(tab) --正常查看装备
		if tab.data ~= nil then
			if tab.data:GetType()==EquipType.Normal then
				CSAPI.OpenView("EquipFullInfo", tab.data, 1);
			else
				CSAPI.OpenView("GoodsFullInfo",{data=tab.data} , 1);
			end
		end
	end,
}

--奖励格子通用点击
function GridRewardGridFunc(tab)
	if(not tab.data) then 
		return 
	end 
	local classType = tab.data:GetClassType()
	if (classType) then
		if (classType == "CharacterCardsData") then
			GridClickFunc.CardTips(tab)
		elseif (classType == "EquipData") then
			GridClickFunc.EquipDetails(tab)
		elseif (classType == "GoodsData") then
			GridClickFunc.OpenInfoShort(tab)
		end
	end
end

--已存在的数据
GridEntityData = function(reward)
	local result = nil
	local clickCB = nil
	if(reward.type == nil or reward.type == RandRewardType.ITEM) then   --背包
		result = BagMgr:GetData(reward.id)
		clickCB = GridClickFunc.OpenInfo
	elseif(reward.type == RandRewardType.CARD) then        --卡牌
		result = RoleMgr:GetData(reward.id)
		clickCB = GridClickFunc.CardTips
	elseif(reward.type == RandRewardType.EQUIP) then       --装备
		result = EquipMgr:GetEquip(reward.id)
		clickCB = GridClickFunc.EquipDetails
	end
	return result, clickCB
end

--假数据 {id,num,type,sid} disRealData：不根据配置包ID查询真实的装备数据
GridFakeData = function(reward,disRealData)
	local result = nil
	local clickCB = nil
	if(reward.type == nil or reward.type == RandRewardType.ITEM) then   --背包
		result = BagMgr:GetFakeData(reward.id,reward.num)
		clickCB = GridClickFunc.OpenInfoShort--GridClickFunc.OpenInfoSmiple
	elseif(reward.type == RandRewardType.CARD) then        --卡牌
		result = RoleMgr:GetFakeData(reward.id,reward.num)
		clickCB = GridClickFunc.CardTips
	elseif(reward.type == RandRewardType.EQUIP) then       --装备
		if disRealData~=true then
			result = EquipMgr:GetEquipByCfgID(reward.id)
		end
		if(result == nil) then
			result = EquipMgr:GetFakeData(reward.id)
		end
		clickCB = GridClickFunc.EquipDetails
	end
	return result, clickCB
end


--通用生成奖励格子 
-- rewards  json数据 [[id,num,type],[id,num,type]...]
--limit 限制生成长度 nil时默认全部生成
GridAddRewards = function(items, rewards, parent, scale, limit)
	items = items or {}
	scale = scale or 1
	limit = limit or #rewards
	local item = nil
	local count = 1
	for i, v in ipairs(rewards) do		
		local reward = {id = v[1], num = v[2], type = v[3]}
		if(i <= #items) then
			local result, clickCB = GridFakeData(reward)
			item = items[i]
			CSAPI.SetGOActive(item.gameObject, true)
			item.Refresh(result)
			item.SetClickCB(clickCB)
		else
			item = ResUtil:CreateRandRewardGrid(reward,parent.transform)
			table.insert(items, item)
		end
		if(v[4]) then
			item.SetCount2(v[4])
		else
			item.SetCount(reward.num)
		end
		CSAPI.SetScale(item.gameObject,scale,scale,scale)
		
		count = count + 1
		if(count > limit) then
			break
		end
	end
	for i = count, #items do
		CSAPI.SetGOActive(items[i].gameObject, false)
	end
end

local this = {};

--将随机奖励数据转为GridObjectData类型的数据 {id,num,type}
function this.RandRewardConvertToGridObjectData(_d)
	local obj = nil;
	local data = nil;
	if(_d.type == RandRewardType.TEMPLATE) then
		local rewardCfg = Cfgs.RewardInfo:GetByID(_d.id);
		local goodCfgs = Cfgs.ItemInfo:GetByID(tonumber(rewardCfg.icon));
		local icon=goodCfgs.icon
		if goodCfgs.type==ITEM_TYPE.CARD_CORE_ELEM then
			icon=string.format("%s_%s",goodCfgs.icon,goodCfgs.quality);
		end
		data = {
			id = _d.id,
			icon = goodCfgs.icon,
			quality = goodCfgs.quality,
			lv = 0,
			count = goodCfgs.count,
			stars = 0,
			isNew = false,
			isLock = false,
			type=_d.type,
			desc = "",
		};
	elseif(_d.type == RandRewardType.ITEM) then   --道具
		local tempData = GoodsData();
		tempData:InitCfg(_d.id);
		data = {
			id = _d.id,
			icon = tempData:GetIcon(),
			name = tempData:GetName(),
			cfg = tempData:GetCfg(),
			quality = tempData:GetQuality(),
			iconScale = tempData:GetIconScale(),
			iconLoader = tempData:GetIconLoader(),
			lv = tempData:GetLv(),
			count = _d.num,
			stars = tempData:GetStars(),
			isNew = false,
			type=tempData:GetClassType(),
			isLock = false,
			desc = tempData:GetDesc(),
		};
	elseif(_d.type == RandRewardType.CARD) then        --卡牌
		local tempData = CharacterCardsData();
		tempData:InitCfg(_d.id);
		tempData:InitModel(tempData:GetSkinID())
		data = {
			id = _d.id,
			icon = tempData:GetIcon(),
			cfg = tempData:GetCfg(),
			name = tempData:GetName(),
			quality = tempData:GetQuality(),
			iconScale = tempData:GetIconScale(),
			iconLoader = tempData:GetIconLoader(),
			lv = 0,
			count = 0,
			stars = tempData:GetStars(),
			isNew = false,
			isLock = false,
			type=tempData:GetClassType(),
			desc = tempData:GetDesc(),
		};
	elseif(_d.type == RandRewardType.EQUIP) then       --装备
		local tempData = EquipData();
		tempData:InitCfg(_d.id);
		data = {
			id = _d.id,
			icon = tempData:GetIcon(),
			cfg = tempData:GetCfg(),
			name = tempData:GetName(),
			quality = tempData:GetQuality(),
			iconScale = tempData:GetIconScale(),
			iconLoader = tempData:GetIconLoader(),
			lv = tempData:GetLv(),
			count = 0,
			stars = tempData:GetStars(),
			isNew = false,
			isLock = false,
			type=tempData:GetClassType(),
			desc = tempData:GetDesc(),
		};
	end
	if data then
		obj = GridObjectData(data);
	end	
	return obj;
end

--批量转换随机奖励数据   ewards {{id=,type=,num=}} --字典格式
function this.GetGridObjectDatas(rewards)
	local list = nil;
	if rewards then
		list = {};
		for k, v in ipairs(rewards) do
			table.insert(list, this.RandRewardConvertToGridObjectData(v));
		end
	end
	return list;
end

--批量转换随机奖励数据   rewards {{x,x,x}} --非字典格式
function this.GetGridObjectDatas2(rewards)
	local list = nil;
	if rewards then
		list = {};
		local newRewards = {}
		for i, v in ipairs(rewards) do
			table.insert(newRewards, {id = v[1], num = v[2], type = v[3]})
		end
		for k, v in ipairs(newRewards) do
			table.insert(list, this.RandRewardConvertToGridObjectData(v))
		end
	end
	return list;
end

--星源小角标 go:icon,go2:tIcon
function this.LoadTIcon(go,go2,cfg,isBig)
	--星源类型需要额外读取另一个小图标
	if go==nil or cfg==nil then
		return;
	end
	local dyVal=cfg.dy_value2;
	if dyVal then
		local dyVal2=cfg.dy_arr;
		if dyVal>100000 and dyVal2 then --角色ID
			if go2 then
				CSAPI.SetGOActive(go2,true)
			end
			if #dyVal2>1 then --总队长星源
				local sex=PlayerClient:GetSex();
				dyVal2=sex==1 and dyVal2[1] or dyVal2[2]
			else
				dyVal2=dyVal2[1]
			end
			--设置缩放和位置
			local cfg2=Cfgs.CardData:GetByID(dyVal2);
			local mCfg=Cfgs.character:GetByID(cfg2.model);
			ResUtil.RoleCard:Load(go,mCfg.icon);
			if isBig then
				CSAPI.SetScale(go,0.3,0.3,0.3);
				CSAPI.SetAnchor(go,80,80);
				CSAPI.SetAnchor(go2,80,80);
			else
				CSAPI.SetScale(go,0.3,0.3,0.3);
				CSAPI.SetAnchor(go,68,68);
				CSAPI.SetAnchor(go2,68,68);
			end
		else--小队枚举ID
			if go2 then
				CSAPI.SetGOActive(go2,false)
			end
			local cfg=Cfgs.CfgTeamEnum:GetByID(dyVal);
			ResUtil.IconGoods:Load(go,cfg.itemIcon);
			if isBig then
				CSAPI.SetScale(go,1,1,1);
			else
				CSAPI.SetScale(go,0.8,0.8,0.8);
			end
			CSAPI.SetAnchor(go,0,0);	
		end
	end
end

--加载显示在物品格子中的卡牌图标 cfg:物品配置表
function this.LoadCIcon(go1,go,cfg,isBig)
	if go1==nil or go==nil or cfg==nil then
		return;
	end
	ResUtil.IconGoods:Load(go1, cfg.icon);
	local dyVal=cfg.dy_value1;
	if dyVal then
		local dyVal2=cfg.dy_arr;
		if dyVal then --角色ID
			if dyVal2 and #dyVal2>1 then --总队长
				local sex=PlayerClient:GetSex();
				dyVal=sex==1 and dyVal2[1] or dyVal2[2]
			end
			--设置缩放和位置
			local cfg2=Cfgs.CardData:GetByID(dyVal);
			local mCfg=Cfgs.character:GetByID(cfg2.model);
			ResUtil.RoleCard:Load(go,mCfg.icon);
			if isBig then
				CSAPI.SetScale(go,0.468,0.468,0.468);
				CSAPI.SetAnchor(go,-5,-15);
			else
				CSAPI.SetScale(go,0.36,0.36,0.36);
				CSAPI.SetAnchor(go,-4,-11);
			end
		end
	end
end

--加载显示在物品格子中的卡牌图标 cfg:卡牌配置表
function this.LoadCIconByCard(go1,go,cfg,isBig)
	if go1==nil or go==nil or cfg==nil then
		return;
	end
	ResUtil.IconGoods:Load(go1, "rolecard_"..tostring(cfg.quality));
	--设置缩放和位置
	local mCfg=Cfgs.character:GetByID(cfg.model);
	ResUtil.RoleCard:Load(go,mCfg.icon);
	if isBig then
		CSAPI.SetScale(go,0.468,0.468,0.468);
		CSAPI.SetAnchor(go,-5,-15);
	else
		CSAPI.SetScale(go,0.36,0.36,0.36);
		CSAPI.SetAnchor(go,-4,-11);
	end
end

--加载物品信息界面的装备图标 cfg:ItemInfo isShopPre:是否是商店购买预览界面
function this.LoadEquipIcon(go1,go,iconName,quality,isMatiral,isBig,isShopPre)
	if go1==nil or go==nil or iconName==nil then
		return;
	end
	if isMatiral then
		-- ResUtil.IconGoods:Load(go1, "rolecard_"..tostring(cfg.quality));
		ResUtil.IconGoods:Load(go1, iconName.."_02");
		CSAPI.SetAnchor(go1,0,0);
	else
		ResUtil.EquipSkillIcon:Load(go1, "btn_12_0"..tostring(quality));
		ResUtil.EquipSkillIcon:Load(go,iconName);
		CSAPI.SetAnchor(go,0,0);
	end
	if isBig then
		CSAPI.SetScale(go1,1,1,1)
		CSAPI.SetScale(go,1,1,1)
	else
		CSAPI.SetScale(go1,0.8,0.8,0.8)
		CSAPI.SetScale(go,0.8,0.8,0.8)
	end
end

--根据奖励类型来转换id [id,num,type]
function this.GetGoodsID(reward)
	if reward[3] and reward[3] == RandRewardType.TEMPLATE then
		local rewardCfg = Cfgs.RewardInfo:GetByID(reward[1]);
		if rewardCfg and rewardCfg.item then
			local goodsId = nil
			for i, v in ipairs(rewardCfg.item) do
				if v.sex and v.sex == PlayerClient:GetSex() then
					goodsId = v.id
					break
				end
			end
			if goodsId == nil then
				goodsId = tonumber(rewardCfg.icon)
			end
			return goodsId
		end
	else
		return reward and reward[1]
	end
end

return this 