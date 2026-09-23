--技能训练
local this = MgrRegister("RoleSkillMgr")

function this:Init()
	self:Clear()
	self:CardSkillUpgradelist()
	
	-- self.idDatasKey = PlayerClient:GetID() .. "_roleskillmgr_successids"
	-- PlayerProto:GetClientData(self.idDatasKey)
end


function this:Clear()
	self.infos = {}
	--self.successIDs = {}  --技能升级完成的角色，且未进入角色详情查看的  value= 1:未查看过  2：未查看，但被取消查看  
	self.curLookID = nil --当前在详情查看的卡牌id
end

-- --技能升级经验
-- function this:GetNeedExp(_lv)
-- 	return Cfgs.CardSkillExp:GetByID(_lv).exp
-- end
--角色升级中的技能列表
function this:GetSkills(_cid)
	if(self.infos) then
		return self.infos[_cid]
	end
	return nil
end

--角色升级中的技能数据  sCardSkillUpgrade
function this:GetUpData(_cid, _skill_id)
	if(self.infos and self.infos[_cid]) then
		return self.infos[_cid] [_skill_id]
	end
	return nil
end

-- --能升级到的等级
-- function this:GetCanRiseToLv(id, curExp, addExp)
-- 	local curCfg = Cfgs.skill:GetByID(id)
-- 	local endCfg = curCfg
-- 	local needExp = Cfgs.CardSkillExp:GetByID(curCfg.lv).exp
-- 	local allExp = curExp + addExp
-- 	while curCfg.next_id and allExp >= needExp do
-- 		endCfg = Cfgs.skill:GetByID(endCfg.next_id)
-- 		allExp = allExp - needExp
-- 		needExp = Cfgs.CardSkillExp:GetByID(endCfg.lv).exp
-- 	end
-- 	return endCfg
-- end
--某个技能最大等级
function this:GetMaxLv(id)
	local cfg = Cfgs.skill:GetByID(id)
	if(cfg.group) then
		local _cfgs = Cfgs.skill:GetGroup(cfg.group)
		return _cfgs[#_cfgs].lv
	end
	return cfg.lv
end

--获取特殊技能及类型
function this:GetSpeciallSkill(_roleCfg)
	local _id = _roleCfg.tcSkills and _roleCfg.tcSkills[1] or nil
	local _resultID = nil
	local _resultType = nil
	if(_id) then
		--形态转换
		if(_roleCfg.tTransfo) then
			_resultID = _roleCfg.tTransfo[1]
			_resultType = SpecialSkillType.Trans
		elseif(_roleCfg.fit_result) then
			_resultID = _roleCfg.fit_result
			_resultType = SpecialSkillType.Fit
		elseif(_roleCfg.summon) then
			_resultID = _roleCfg.summon
			_resultType = SpecialSkillType.Summon
		end
	end
	return _id, _resultID, _resultType
end

function this:GetSpecialSkillType(id)
	local cfg = Cfgs.skill:GetByID(id)
	local type = 1
	if(cfg.type == 3) then
		type = SpecialSkillType.Summon
	elseif(cfg.type == 4) then
		type = SpecialSkillType.Fit
	elseif(cfg.type == 8) then
		type = SpecialSkillType.Trans
	end
	return type
end


--卡牌当前被动技能增加的sp值
function this:GetAddSP(cardData, cfg)
	local quality = cardData and cardData:GetQuality() or 1
	local upCfg = Cfgs.CfgMainTalentSkillUpgrade:GetByID(quality)
	local addSp = upCfg.infos[cfg.lv].nAddSp or 0
	return addSp
end


-----------------------------------------------检测------------------------
--是否已训练技能
function this:CheckIsIn(_cid)
	if(self.infos and self.infos[_cid]) then
		for i, v in pairs(self.infos[_cid]) do
			for k, m in pairs(v) do
				if(m ~= nil) then
					return true
				end
			end
		end
	end
	return false
end

-- --卡牌是否有技能已完成
-- function this:CheckSuccessByCid(cid)
-- 	return self.successIDs[cid .. ""] ~= nil
-- end

-- --卡牌是否有技能已完成
-- function this:CheckSuccessByCid(cid)
-- 	local isSuccess = false
-- 	local t_end = nil  --最快完成的时间点
-- 	if(self.infos) then
-- 		local infos = self.infos[cid]
-- 		if(infos) then
-- 			for k, m in pairs(infos) do
-- 				if(m.t_end - TimeUtil:GetTime() <= 0) then
-- 					isSuccess = true	
-- 					break	
-- 				else
-- 					if(t_end == nil or m.t_end < t_end) then
-- 						t_end = m.t_end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- 	return isSuccess, t_end
-- end
-- --卡牌某技能是否已完成
-- function this:CheckSuccessByCidSkill(cid, skill_id)
-- 	local isSuccess = false
-- 	if(self.infos) then
-- 		local infos = self.infos[cid]
-- 		local info = infos and infos[skill_id] or nil
-- 		if(info) then
-- 			if(info.t_end - TimeUtil:GetTime() <= 0) then
-- 				isSuccess = true		
-- 			end
-- 		end
-- 	end
-- 	return isSuccess
-- end

-- --检查红点数据（有技能完成，未查看或者取消查看都要显示红点）
-- function this:CheckRedPointData()
-- 	local num = nil
-- 	for i, v in pairs(self.successIDs) do
-- 		num = v
-- 		break
-- 	end
-- 	RedPointMgr:UpdateData(RedPointType.RoleList, num)
-- end

-- --检查红点数据（有技能完成）
-- function this:CheckRedPointData()
-- 	local isSuccess = false
-- 	local t_end = nil  --最快完成的时间点
-- 	if(self.infos) then
-- 		for i, v in pairs(self.infos) do
-- 			for k, m in pairs(v) do
-- 				if(m.t_end - TimeUtil:GetTime() <= 0) then
-- 					isSuccess = true	
-- 					break
-- 				else
-- 					if(t_end == nil or m.t_end < t_end) then
-- 						t_end = m.t_end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- 	local num1 = isSuccess and 1 or nil
-- 	RedPointMgr:UpdateData(RedPointType.RoleList, num1)
-- 	self:CheckToRefresh(t_end)
-- 	return isSuccess, t_end
-- end
-- function this:CheckToRefresh(t_end)
-- 	local timer = t_end ~= nil and(t_end - TimeUtil:GetTime()) or 0
-- 	if(self.isCheck == nil and timer > 0) then
-- 		FuncUtil:Call(self.CheckEnd, self, timer * 1000)
-- 	end
-- end
-- function this:CheckEnd()
-- 	self.isCheck = nil
-- 	self:CheckRedPointData()
-- end
-----------------------------------------------协议------------------------
--主天赋升级回调
function this:MainTalentUpgradeRet(proto)
	--EventMgr.Dispatch(EventType.Talent_Upgrade, proto)
	RoleMgr:UpdateCardEvent(CardUpdateType.MainTalentUpgradeRet, proto.cid, proto, {cid = proto.cid, skill_id = proto.skill_id, new_skill_id = proto.new_skill_id, t_start = 0, t_end = 0})
end

--技能升级列表
function this:CardSkillUpgradelist()
	local proto = {"PlayerProto:CardSkillUpgradelist"}
	NetMgr.net:Send(proto)
end
function this:CardSkillUpgradelistRet(proto)
	if(proto) then
		for i, v in pairs(proto.infos) do
			self.infos[i] = v
		end
		if(proto.is_finish) then
			--EventMgr.Dispatch(EventType.Role_Skill_Update)
			--self:CheckRedPointData()
		end
	end
end

--技能升级
function this:CardSkillUpgrade(_cid, _skill_id)
	local proto = {"PlayerProto:CardSkillUpgrade", {cid = _cid, skill_id = _skill_id}}
	NetMgr.net:Send(proto)
end

function this:CardSkillUpgradeRet(proto)
	self.infos = self.infos == nil and {} or self.infos
	self.infos[proto.cid] = self.infos[proto.cid] == nil and {} or self.infos[proto.cid]
	self.infos[proto.cid] [proto.info.id] = proto.info
	--EventMgr.Dispatch(EventType.Role_Skill_Update,{cid = proto.cid})
	--RoleMgr:UpdateCardEvent(CardUpdateType.CardSkillUpgradeRet, proto.cid, proto)
	--self:RefreshEndTime()
	--self:CheckRedPointData()
end

-- --完成
-- function this:CardSkillUpgradeFinish(_cid, _skill_id)
-- 	local proto = {"PlayerProto:CardSkillUpgradeFinish", {cid = _cid, skill_id = _skill_id}}
-- 	NetMgr.net:Send(proto)
-- end
-- function this:CardSkillUpgradeFinishRet(proto)
-- 	Self:SetSuccessIDs({proto.card})
-- 	if(proto) then
-- 		RoleMgr:UpdateData({proto.card})
-- 		local _start_time = 0
-- 		local _end_time = 0
-- 		if(self.infos[proto.card.cid]) then
-- 			_start_time = self.infos[proto.card.cid] [proto.skill_id].t_start
-- 			_end_time = self.infos[proto.card.cid] [proto.skill_id].t_end
-- 			self.infos[proto.card.cid] [proto.skill_id] = nil
-- 		end
-- 		local _cid = proto.card.cid
-- 		local _new_skill_id = proto.new_skill_id
-- 		--EventMgr.Dispatch(EventType.Role_Skill_Update, {isSuccess = true, cid = _cid, new_skill_id = _new_skill_id, t_start = _start_time, t_end = _end_time})
-- 		RoleMgr:UpdateCardEvent(CardUpdateType.CardSkillUpgradeFinishRet, proto.card.cid, proto, {skill_id = proto.skill_id, cid = _cid, new_skill_id = _new_skill_id, t_start = _start_time, t_end = _end_time})
-- 	end
-- 	--self:RefreshEndTime()
-- 	self:CheckRedPointData()
-- end
function this:CardSkillUpgradeFinishRet(proto)
	local infos = proto.infos
	local cards = {}
	for i, v in pairs(infos) do
		table.insert(cards, v.card)
		if(self.infos[v.cid]) then
			local len = #v.ids
			for i = 2, len, 2 do
				self.infos[v.cid] [v.ids[i]] = nil
			end
		end
	end
	RoleMgr:UpdateData(cards)
	
	RoleMgr:UpdateCardEvent(CardUpdateType.CardSkillUpgradeFinishRet)
	
	-- local infos = proto.infos
	-- self:AddSuccessIDs(infos)
	-- --
	-- local event = false
	-- local cards = {}
	-- for i, v in pairs(infos) do
	-- 	table.insert(cards, v.card)
	-- 	if(self.infos[v.cid]) then
	-- 		local len = #v.ids
	-- 		for i = 1, len, 2 do
	-- 			self.infos[v.cid] [v.ids[i]] = nil
	-- 		end
	-- 	end
	-- 	if(self.curLookID and self.curLookID == v.cid) then
	-- 		event = true
	-- 	end
	-- end
	-- RoleMgr:UpdateData(cards)
	-- self:CheckRedPointData()
	-- if(event) then
	-- 	RoleMgr:UpdateCardEvent(CardUpdateType.CardSkillUpgradeFinishRet, self.curLookID)
	-- end
end

-- --记录已完成的id（当前在详情查看的卡牌不用记录）
-- function this:AddSuccessIDs(infos)
-- 	local isAdd = false
-- 	for i, v in pairs(infos) do
-- 		if(self.curLookID == nil or(self.curLookID and v.cid ~= self.curLookID)) then
-- 			self.successIDs[v.cid .. ""] = 1
-- 			isAdd = true
-- 		end
-- 	end
-- 	if(isAdd) then
-- 		self:SetSuccessDatas()	
-- 	end
-- end
-- --全部标记为已查看
-- function this:CancelAllSuccessIDs()
-- 	for i, v in pairs(self.successIDs) do
-- 		self.successIDs[i] = 2
-- 	end
-- 	self:SetSuccessDatas()
-- end
-- --是否需要弹窗提示
-- function this:NeedToShowSuccessID()
-- 	for i, v in pairs(self.successIDs) do
-- 		if(v == 1) then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end
-- --角色详情当前查看的卡牌
-- function this:SetCurLookID(cid)
-- 	self.curLookID = cid
-- 	if(cid) then
-- 		local num = self.successIDs[cid .. ""]
-- 		if(num ~= nil) then
-- 			self.successIDs[cid .. ""] = nil
-- 			self:SetSuccessDatas()
-- 			self:CheckRedPointData()
-- 		end
-- 	end
-- end
-- --保存数据
-- function this:SetSuccessDatas()
-- 	PlayerProto:SetClientData(self.idDatasKey, self.successIDs)
-- end

-- --登录时请求服务器的数据，但不覆盖本地数据,因为本地的才是最新的
-- function this:GetSuccessDatasRet(_datas)
-- 	if(_datas) then
-- 		for i, v in pairs(_datas) do
-- 			if(not self.successIDs[i]) then
-- 				self.successIDs[i] = v
-- 			end
-- 		end
-- 		--self:CheckRedPointData()
-- 	end
-- end

-- --卡牌被删除时，移除其红点
-- function this:RemoveDeleteCard(ids)
-- 	local isChange = false
-- 	for i, v in pairs(ids) do
-- 		local num = self.successIDs[v .. ""]
-- 		if(num ~= nil) then
-- 			self.successIDs[v .. ""] = nil
-- 			isChange = true
-- 		end
-- 	end
-- 	if(isChange) then
-- 		self:SetSuccessDatas()
-- 		--self:CheckRedPointData()
-- 	end
-- end


--[[--升级取消
function this:CardSkillUpgradeCancel(_cid, _skill_id)
	local proto = {"PlayerProto:CardSkillUpgradeCancel", {cid = _cid, skill_id = _skill_id}}
	NetMgr.net:Send(proto)
end
function this:CardSkillUpgradeCancelRet(proto)
	self.infos = self.infos == nil and {} or self.infos
	self.infos[proto.cid] = self.infos[proto.cid] == nil or {} or self.infos[proto.cid]
	self.infos[proto.cid] [proto.info.skill_id] = nil
	EventMgr.Dispatch(EventType.Role_Skill_Update)
end

--扩容
function this:CardSkillGirdAdd(_num)
	local proto = {"PlayerProto:CardSkillGirdAdd", {num = _num}}
	NetMgr.net:Send(proto)
end
function this:CardSkillGirdAddRet(proto)
	if(proto) then
		self.grid_max = proto.max_size
		EventMgr.Dispatch(EventType.Role_Skill_GridAdd)
	end
end
]]
--被动升级 需要的数量
function this:GetTalentUIMatCount(qualtiy, talentID)
	local cfg = Cfgs.skill:GetByID(talentID)
	local tCfg = Cfgs.CfgMainTalentSkillUpgrade:GetByID(qualtiy)
	local uCfg = tCfg.infos[cfg.lv]
	return uCfg.nFullCost or 0
end




return this 