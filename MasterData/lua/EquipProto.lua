EquipProto = {
	EquipSetNewCallBack = nil,--装备设置是否为新完成回调
}

-----------------------------------客户端发送--------------
--获取装备列表
function EquipProto:GetEquips()
	EquipMgr:Clear()
	local proto = {"EquipProto:GetEquips", {}}
	NetMgr.net:Send(proto);
end

--装备穿戴
function EquipProto:EquipUp(equipId, cardId)
	local proto = {"EquipProto:EquipUp", {equip_id = equipId, target_card_id = cardId}}
	NetMgr.net:Send(proto);
end

--装备卸载
function EquipProto:EquipDown(equipId)
	local proto = {"EquipProto:EquipDown", {equip_ids = equipId}}
	NetMgr.net:Send(proto);
end

--设置装备是否为新装备
function EquipProto:SetIsNew(equipId, callBack)
	if callBack then
		self.EquipSetNewCallBack = callBack;
	end
	local proto = {"EquipProto:SetIsNew", {sids = equipId, is_new = 0}}
	NetMgr.net:Send(proto);
end

--设置装备加锁
function EquipProto:SetLock(infos)
	local state = isLock and 1 or 0;
	local proto = {"EquipProto:EquipLock", {infos=infos}}
	NetMgr.net:Send(proto);
end

--设置装备格子扩容
function EquipProto:AddGrid(num)
	local proto = {"EquipProto:EquipGridAdd", {num = num}}
	NetMgr.net:Send(proto);
end

--装备升级
function EquipProto:EquipUpgrade(sid, equipIds, goodIds)
	local proto = {"EquipProto:EquipUpgrade", {sid = sid, equip_ids = equipIds, items = goodIds}}
	NetMgr.net:Send(proto);
end

--装备出售
function EquipProto:EquipSell(ids)
	local sids,rangs=GCalHelp:GetRangNum(ids);
	if sids then
		local proto = {"EquipProto:EquipSell", {sids = sids,rangs=rangs}};
		NetMgr.net:Send(proto);
	end
end

--批量穿戴装备
function EquipProto:EquipUps(cid,ids,callBack)
	if callBack then
		self.EquipUpsCallBack = callBack;
	end
	if cid and ids then
		local proto = {"EquipProto:EquipUps", {target_card_id=cid,equip_ids=ids}}
		NetMgr.net:Send(proto);
	end
end

--获取装备记录
function EquipProto:EquipLogs()
	local proto = {"EquipProto:EquipLogs"}
	NetMgr.net:Send(proto);
end

--设置装备记录
function EquipProto:SetEquipLogs(cid,index)
	if cid and index then
		local proto = {"EquipProto:SetEquipLogs", {cid=cid,index=index}}
		NetMgr.net:Send(proto);
	end
end

--添加装备记录槽位
function EquipProto:AddEquipLogSlot()
	local proto = {"EquipProto:AddEquipLogSlot", {}}
	NetMgr.net:Send(proto);
end

function EquipProto:UseEquipLogs(cardId,index)
	if cardId and index then
		local proto = {"EquipProto:UseEquipLogs", {cid=cardId,index=index}}
		NetMgr.net:Send(proto);
	end
end

-----------------------------------回调--------------
--获取装备列表返回
function EquipProto:GetEquipsRet(proto)
	EquipMgr:SetData(proto);
	EventMgr.Dispatch(EventType.Init_Equip_Finish)
end

--装备穿戴返回
function EquipProto:EquipUpRet(proto)
	if proto then
		EquipMgr.curSize = proto.cur_size;
		EquipMgr:EquipUp(proto.equip_id, proto.target_card_id);
		local equip=EquipMgr:GetEquip(proto.equip_id);
		local data={
			chip_item={{
				chip_id=equip:GetID(),
				chip_cfgID=equip:GetCfgID(),
				chip_name=equip:GetName(),
				chip_star=equip:GetStars(),
				chip_level=equip:GetLv(),
			}},
			role_id=proto.target_card_id,
		}

		if CSAPI.IsADV()==false then
			BuryingPointMgr:TrackEvents("chipWear", data)
		end
		EventMgr.Dispatch(EventType.Equip_UpOne_Ret,{equipId=proto.equip_id, cardId=proto.target_card_id})
	end
end

--卸载回调
function EquipProto:EquipDownRet(proto)
	local ids=nil;
	if proto then
		EquipMgr.curSize = proto.cur_size;
		ids=proto.equip_ids;
		for k,v in ipairs(proto.equip_ids) do
			EquipMgr:EquipDown(v);
		end
	end
	EventMgr.Dispatch(EventType.Equip_Down_Ret,ids)
end

--装备是否为新返回
function EquipProto:SetIsNewRet(proto)
	if proto and proto.sids then
		for k, v in ipairs(proto.sids) do
			local equip = EquipMgr:GetEquip(v);
			equip:SetNew(proto.is_new == 1);
		end
	end
	if self.EquipSetNewCallBack then
		self.EquipSetNewCallBack(proto);
		self.EquipSetNewCallBack = nil;
	end
end

--锁定返回
function EquipProto:EquipLockRet(proto)
	for k,v in ipairs(proto.infos) do
		local equip = EquipMgr:GetEquip(v.sid);
		equip:SetLock(v.lock == 1);
	end
	EventMgr.Dispatch(EventType.Equip_SetLock_Ret,proto)
end

--装备格子扩容返回
function EquipProto:EquipAddGridRet(proto)
	EquipMgr.maxSize = proto.max_size;
	EventMgr.Dispatch(EventType.Equip_GridNum_Refresh)
	EquipMgr:CheckBagRedInfo();
end

--装备升级返回
function EquipProto:EquipUpgradeRet(proto)
	EquipMgr:Update(proto.equip);
	local tips = nil;
	if proto.id then  --暴击
		local cfg = Cfgs.CfgEquipExpRand:GetByID(proto.id);
		local val = cfg.fRand;
		tips = val ~= 1 and cfg.sDescribe or nil;
		EquipMgr.stuffList.stuffTotalExp = EquipMgr.stuffList.stuffTotalExp * val;--总经验实际值
	end
	if proto and proto.equip then
		local equip=EquipMgr:GetEquip(proto.equip.sid);
		local data={
			chip_id=equip:GetID(),
			chip_cfgID=equip:GetCfgID(),
			chip_name=equip:GetName(),
			chip_star=equip:GetStars(),
			chip_level=equip:GetLv(),
		}
		if CSAPI.IsADV()==false then
			BuryingPointMgr:TrackEvents("chipUpgrading", data)
		end
	end
	EventMgr.Dispatch(EventType.Equip_Upgrade_Ret,tips)
end

--出售回调
function EquipProto:EquipSellRet(proto)
	EquipMgr.curSize = proto.cur_size;
	local ids=GCalHelp:RangNumToArr(proto.sids, proto.rangs)
	if ids then
		local data={
			chip_item={},
			item_gain={},
		}
		local chipMap={};--记录分解芯片的数据 index:数组下标，num：当前数量
		local gainMap={};--记录分解芯片的数据 index:数组下标，num：当前数量
		local price=0;
		for k, v in pairs(ids) do
			local equip=EquipMgr:GetEquip(v);
			chipMap[equip:GetCfgID()]=chipMap[equip:GetCfgID()] or {};
			local num=chipMap[equip:GetCfgID()].num==nil and 1 or chipMap[equip:GetCfgID()].num+1;
			if num<=1 then
				local chip={
					chip_id=equip:GetID(),
					chip_cfgID=equip:GetCfgID(),
					chip_name=equip:GetName(),
					chip_num=num,
				};
				table.insert(data.chip_item,chip);
				chipMap[equip:GetCfgID()].num=num;
				chipMap[equip:GetCfgID()].index=#data.chip_item;
			else
				chipMap[equip:GetCfgID()].num=num;
				data.chip_item[chipMap[equip:GetCfgID()].index].chip_num=num;
			end
			price = price + equip:GetSellPrice();
			local rewards=equip:GetSellRewards();
			if rewards then
				for _,val in ipairs(rewards) do
					gainMap[val.id]=gainMap[val.id] or {};
					if gainMap[val.id].num==nil then
						gainMap[val.id].num=val.num;
						local cfg=Cfgs.ItemInfo:GetByID(val.id);
						local item={
							item_id=val.id,
							item_name=cfg==nil and "未找到配置" or cfg.name,
							get_num=val.num,
						}
						table.insert(data.item_gain,item);
						gainMap[val.id].index=#data.item_gain;
					else
						gainMap[val.id].num=val.num+gainMap[val.id].num;
						data.item_gain[gainMap[val.id].index].get_num=gainMap[val.id].num;
					end
				end
			end
			EquipMgr:RemoveEquip(v);
		end
		local c=Cfgs.ItemInfo:GetByID(ITEM_ID.GOLD);
		table.insert(data.item_gain,{
			item_id=ITEM_ID.GOLD,
			item_name=c.name,
			get_num=price,
		});
		if CSAPI.IsADV()==false then
			BuryingPointMgr:TrackEvents("chipDecompose", data)
		end
	end
	EventMgr.Dispatch(EventType.Equip_Sell_Ret)
end

function EquipProto:EquipUpsRet(proto)
	-- EquipMgr.curSize = proto.cur_size;
	if proto then
		if proto.down_ids then
			for k,v in ipairs(proto.down_ids) do
				EquipMgr:EquipDown(v);
			end
		end
		if proto.up_ids then
			local data={
				role_id=proto.target_card_id,
				chip_item={},
			}
			for k,v in ipairs(proto.up_ids) do
				local equip=EquipMgr:GetEquip(v);
				local chip={
					chip_id=equip:GetID(),
					chip_cfgID=equip:GetCfgID(),
					chip_name=equip:GetName(),
					chip_star=equip:GetStars(),
					chip_level=equip:GetLv(),
				}
				table.insert(data.chip_item,chip);
				EquipMgr:EquipUp(v, proto.target_card_id);
			end
			if CSAPI.IsADV()==false then
				BuryingPointMgr:TrackEvents("chipWear", data)
			end
		end
	end
	EventMgr.Dispatch(EventType.Equip_Ups_Ret,proto)
	-- if self.EquipUpsCallBack then
	-- 	self.EquipUpsCallBack();
    --     self.EquipUpsCallBack=nil;
    -- end
end

function EquipProto:EquipLogsRet(proto)
	EventMgr.Dispatch(EventType.Equip_GetPrefabs_Ret,proto)
end

function EquipProto:SetEquipLogsRet(proto)
	EventMgr.Dispatch(EventType.Equip_SetPrefab_Ret,proto)
end

function EquipProto:AddEquipLogSlotRet(proto)
	EventMgr.Dispatch(EventType.Equip_AddPrefab_Ret,proto)
end

function EquipProto:UseEquipLogsRet(proto)
	if proto then
		if proto.down_ids then
			for k,v in ipairs(proto.down_ids) do
				EquipMgr:EquipDown(v);
			end
		end
		if proto.up_ids then
			for k,v in ipairs(proto.up_ids) do
				EquipMgr:EquipUp(v, proto.cid);
			end
		end
	end
	EventMgr.Dispatch(EventType.Equip_UsePrefab_Ret)
end

-----------------------------------服务器推送--------------
--新增装备通知
function EquipProto:EquipAdd(proto)
	if proto then
		EquipMgr.curSize = proto.cur_size;
		EquipMgr.maxSize = proto.max_size;
		for k, v in ipairs(proto.equips) do
			EquipMgr:Update(v);
		end
		EquipMgr:CheckBagRedInfo();
	end
end

--装备移除通知
function EquipProto:EquipDelete(proto)
	if proto then
		EquipMgr.curSize = proto.cur_size;
		EquipMgr.maxSize = proto.max_size;
		for k, v in ipairs(proto.sids) do
			EquipMgr:RemoveEquip(v);
		end
	end
end 

--装备更新通知
function EquipProto:EquipUpdate(proto)
	if proto then
		EquipMgr.curSize = proto.cur_size;
		EquipMgr.maxSize = proto.max_size;
		for k, v in ipairs(proto.equips) do
			EquipMgr:Update(v);
		end
		EventMgr.Dispatch(EventType.Equip_Update)
	end
end

--装备合成
function EquipProto:EquipMerge(equip_ids,fixedSlot)
	if equip_ids then
		local proto = {"EquipProto:EquipMerge", {equip_ids=equip_ids,nSlot=fixedSlot}}
		NetMgr.net:Send(proto);
	end
end

function EquipProto:EquipMergeRet(proto)
	EventMgr.Dispatch(EventType.Equip_Combine_Ret,proto);
end

--装备洗炼
function EquipProto:EquipRefresh(sid,lockSkills,isLockSlot)
	if sid then
		local proto = {"EquipProto:EquipRefresh", {sid=sid,lockSkills=lockSkills,isLockSlot=isLockSlot}}
		NetMgr.net:Send(proto);
	end
end

--洗炼结果预览
function EquipProto:EquipRefreshRet(proto)
	if proto then
		EquipMgr:SetRefreshLastData({
			sid=proto.sid,
			newEquipId=proto.newEquipId,
			skills=proto.skills,
		});
	end
	EventMgr.Dispatch(EventType.Equip_Refining_Ret,proto);
end

--洗炼结果确认
function EquipProto:EquipRefreshConfirm(sid)
	if sid then
		local proto = {"EquipProto:EquipRefreshConfirm", {sid=sid}}
		NetMgr.net:Send(proto);
	end
end

function EquipProto:EquipRefreshConfirmRet(proto)
	--洗炼确定返回
	if proto and proto.equipData then
		EquipMgr:Update(proto.equipData);
	end
	EquipMgr:SetRefreshLastData();--清空最后一次的洗炼数据
	EventMgr.Dispatch(EventType.Equip_Refining_Comfirm,proto);
end

function EquipProto:EquipRefreshGetLastData(isWeekNet)
	local proto = {"EquipProto:EquipRefreshGetLastData",{isWeekNet=isWeekNet==true and true or false}}
	NetMgr.net:Send(proto);
end

function EquipProto:EquipRefreshGetLastDataRet(proto)
	EquipMgr:SetRefreshLastData(proto);
	local isConfirm=false;
	if proto==nil or (proto and proto.sid==0) then
		isConfirm=true;
	end
	EventMgr.Dispatch(EventType.Equip_Refining_Update,isConfirm);
end

function EquipProto:EquipRefreshClearLastData()
	EquipMgr:SetRefreshLastData();
	local proto = {"EquipProto:EquipRefreshClearLastData"}
	NetMgr.net:Send(proto);
end

function EquipProto:EquipMaterialConvertWindow()
	local proto = {"EquipProto:EquipMaterialConvertWindow"}
	NetMgr.net:Send(proto);
end

function EquipProto:EquipMaterialConvertWindowRet(proto)
	UIUtil:OpenReward({{{id=ITEMS_ID.EQUIP_EXP,num=BagMgr:GetCount(ITEMS_ID.EQUIP_EXP),type=RandRewardType.ITEM}}});
	EquipMgr:SetHasConvert(not proto.is_ok);
end