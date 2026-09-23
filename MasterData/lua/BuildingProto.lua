-- 基地协议
BuildingProto = {}

-- 获取基地信息
function BuildingProto:BuildsBaseInfo()
    local proto = {"BuildingProto:BuildsBaseInfo"}
    NetMgr.net:Send(proto)
end

function BuildingProto:BuildsBaseInfoRet(proto)
    MatrixMgr:SetMatrixInfo(proto)
end

-- 获取建筑信息列表
function BuildingProto:BuildsList()
    local proto = {"BuildingProto:BuildsList"}
    NetMgr.net:Send(proto)
end
function BuildingProto:BuildsListRet(proto)
    MatrixMgr:AddNotice(proto)
    if (proto.is_finish) then
        EventMgr.Dispatch(EventType.Matrix_Building_Update)
        MatrixMgr:CheckCreateUpOutline()
    end
end

-- 建筑添加（登录请求不走这条） 
function BuildingProto:AddNotice(proto)
    MatrixMgr:AddNotice(proto)
end

-- 建筑信息更新 (已弃用) 改用UpdateNotices
function BuildingProto:UpdateNotice(proto)
    MatrixMgr:UpdateNotice(proto.build)
    EventMgr.Dispatch(EventType.Matrix_Building_Update)
end

-- 建筑建造
function BuildingProto:BuildCreate(_cfgId, _pos)
    local proto = {"BuildingProto:BuildCreate", {
        cfgId = _cfgId,
        pos = _pos
    }}
    NetMgr.net:Send(proto)
end

-- 建造返回（同时推送AddNotice）
function BuildingProto:BuildCreateRet(proto)
    if (proto.ok) then
        EventMgr.Dispatch(EventType.Matrix_Building_Update)
        EventMgr.Dispatch(EventType.Matrix_Building_CreateRet)
    end
end

-- 建筑移除
function BuildingProto:BuildRemove(_id)
    local proto = {"BuildingProto:BuildRemove", {
        id = _id
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:BuildRemoveRet(proto)
    if (proto.ok) then
        MatrixMgr:BuildRemoveRet(proto.id)
        EventMgr.Dispatch(EventType.Matrix_Building_Update)
    end
end

-- 建筑移动
function BuildingProto:BuildMove(_infos)
    local proto = {"BuildingProto:BuildMove", {
        infos = _infos
    }}
    NetMgr.net:Send(proto)
end
-- 不推送 UpdateNotice 要单独处理
function BuildingProto:BuildMoveRet(proto)
    for i, v in ipairs(proto.infos) do
        MatrixMgr:UpdateNotice({
            id = v.id,
            pos = v.pos
        })
    end
    EventMgr.Dispatch(EventType.Matrix_Building_Update)
end

-- 入驻刷新 (会返回建筑更新、宿舍更新)
function BuildingProto:BuildSetRole(_infos)
    local proto = {"BuildingProto:BuildSetRole", {
        infos = _infos
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:BuildSetRoleRet(proto)
    EventMgr.Dispatch(EventType.Dorm_SetRoleList)
end

-- 获取奖励
function BuildingProto:GetRewards(_ids, _cb)
    self.getRewardCB = _cb
    local proto = {"BuildingProto:GetRewards", {
        ids = _ids
    }}
    NetMgr.net:Send(proto)
end

function BuildingProto:GetRewardsRet(proto)
    if (self.getRewardCB) then
        self.getRewardCB(proto.rewards)
        self.getRewardCB = nil
    else
        self:ShowRewardPanel(proto)
    end
end

-- 单独获取奖励
function BuildingProto:GetOneReward(_id, _giftsIds, _giftsExIds)
    local proto = {"BuildingProto:GetOneReward", {
        id = _id,
        giftsIds = _giftsIds,
        giftsExIds = _giftsExIds
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:GetOneRewardRet(proto)
    self:ShowRewardPanel(proto)
end

-- 升级
function BuildingProto:Upgrade(_id, _cb)
    local proto = {"BuildingProto:Upgrade", {
        id = _id
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:UpgradeRet(proto)
    if (proto.ok and proto.id) then
        local data = MatrixMgr:GetData(proto.id)
        if (data) then
            LanguageMgr:ShowTips(2006, data:GetBuildingName())
        end
    end
end

-- 订单交易
function BuildingProto:Trade(_id, _orderId)
    local proto = {"BuildingProto:Trade", {
        id = _id,
        orderId = _orderId
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:TradeRet(proto)
    self:ShowRewardPanel(proto)
end

-- 订单移除
function BuildingProto:DeleteTradeOrder(_buildId, _orderId)
    local proto = {"BuildingProto:DeleteTradeOrder", {
        id = _buildId,
        orderId = _orderId
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:DeleteTradeOrderRet(proto)
    -- body
end

-- 订单合成
function BuildingProto:Combine(_id, _orderId, _cnt)
    -- self.CombineCB = _cb
    local proto = {"BuildingProto:Combine", {
        id = _id,
        orderId = _orderId,
        cnt = _cnt
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:CombineRet(proto)
    -- if(proto.enoughItem) then
    -- 	if(#proto.rewards <= 0) then
    -- 		self.CombineCB() --合成失败
    -- 	else
    -- 		self:ShowRewardPanel(proto)
    -- 	end
    -- end
    -- self.CombineCB = nil
    EventMgr.Dispatch(EventType.Matrix_Compound_Success, proto)
end

-- 完成 订单合成
function BuildingProto:CombineFinish(_id, _orderId, _isSpeedUp)
    local proto = {"BuildingProto:CombineFinish", {
        id = _id,
        orderId = _orderId,
        isSpeedUp = _isSpeedUp
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:CombineFinishRet(proto)
    -- self:ShowRewardPanel(proto)
end

-- 改造
function BuildingProto:Remould(_id, _orderId, _euqipId, _slot)
    local proto = {"BuildingProto:Remould", {
        id = _id,
        orderId = _orderId,
        euqipId = _euqipId,
        slot = _slot
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:RemouldRet(proto)
    -- body
end

-- 完成 改造
function BuildingProto:RemouldFinish(_id, _orderId, _poolId)
    local proto = {"BuildingProto:RemouldFinish", {
        id = _id,
        orderId = _orderId,
        poolId = _poolId
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:RemouldFinishRet(proto)
    self:ShowRewardPanel(proto)
end

-- 添加hp
function BuildingProto:AddHp(_id, _cnt)
    local proto = {"BuildingProto:AddHp", {
        id = _id,
        cnt = _cnt
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:AddHpRet(proto)
    -- body
end

-- 设置预警级别
function BuildingProto:SetWarningLv(_lv)
    local proto = {"BuildingProto:SetWarningLv", {
        lv = _lv
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:SetWarningLvRet(proto)
    MatrixMgr:UpdateMatrixInfo({
        warningLv = proto.lv
    })
    EventMgr.Dispatch(EventType.Matrix_WarningLv_Update)
end

-- 突袭开始 --当次测试，默认未开放的系统 rui/20220608
function BuildingProto:AssualtStart(proto)
    -- MatrixAssualtTool:AssualtStart(proto.info)
end

-- 突袭结束
function BuildingProto:AssualtStop(proto)
    MatrixAssualtTool:AssualtStop(proto.info)
end

-- 反击突袭
function BuildingProto:AssualtAttack(_id, _index, _teamId, _nSkillGroup)
    local proto = {"BuildingProto:AssualtAttack", {
        id = _id,
        index = _index,
        teamId = _teamId,
        nSkillGroup = _nSkillGroup
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:AssualtAttackRet(proto)
    MatrixAssualtTool:AssualtAttackRet(proto)
end

-- 获取突袭信息
function BuildingProto:AssualtInfo()
    local proto = {"BuildingProto:AssualtInfo"}
    NetMgr.net:Send(proto)
end
function BuildingProto:AssualtInfoRet(proto)
    MatrixAssualtTool:AssualtInfoRet(proto.info)
end

-- 弹出奖励面板
function BuildingProto:ShowRewardPanel(proto)
    if (proto.rewards and #proto.rewards > 0) then
        UIUtil:OpenReward({proto.rewards})
    end
end

-- 批量更新建筑
function BuildingProto:UpdateNotices(proto)
    local ids = {}
    for i, v in ipairs(proto.builds) do
        MatrixMgr:UpdateNotice(v)
        ids[v.id] = 1
    end
    -- 未接收完
    if (not proto.is_finish) then
        return
    end
    if (self.GetBuildUpdateCB) then
        self.GetBuildUpdateCB()
        self.GetBuildUpdateCB = nil
    else
        EventMgr.Dispatch(EventType.Matrix_Building_Update, ids)
    end
end

-- 获取突袭信息
function BuildingProto:StoreBuild(_id)
    local proto = {"BuildingProto:StoreBuild", {
        id = _id
    }}
    NetMgr.net:Send(proto)
end

-- 开始远征
function BuildingProto:StartExpedition(_id, _taskType, _index, _cids, _evens)
    local proto = {"BuildingProto:StartExpedition", {
        id = _id,
        taskType = _taskType,
        index = _index,
        cids = _cids,
        evens = _evens
    }}
    NetMgr.net:Send(proto)
end
-- 完成远征
function BuildingProto:FinishExpedition(_id, _taskType, _index)
    local proto = {"BuildingProto:FinishExpedition", {
        id = _id,
        taskType = _taskType,
        index = _index
    }}
    NetMgr.net:Send(proto)
end
-- 移除远征任务
function BuildingProto:DelExpTask(_id, _taskType, _index)
    local proto = {"BuildingProto:DelExpTask", {
        id = _id,
        taskType = _taskType,
        index = _index
    }}
    NetMgr.net:Send(proto)
end

-- 更新建筑
function BuildingProto:GetBuildUpdate(_ids, _cb)
    self.GetBuildUpdateCB = _cb
    local proto = {"BuildingProto:GetBuildUpdate", {
        ids = _ids
    }}
    NetMgr.net:Send(proto)
end

----------------------------------好友订单---------------------------------------------------
-- 点赞记录
function BuildingProto:GetBuildOpLog(_ix, _cnt, _cb)
    self.GetBuildOpLogCB = _cb
    local proto = {"BuildingProto:GetBuildOpLog", {
        ix = _ix,
        cnt = _cnt
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:GetBuildOpLogRet(proto)
    if (self.GetBuildOpLogCB) then
        self.GetBuildOpLogCB(proto)
    end
    self.GetBuildOpLogCB = nil
end

-- 交易中心加速订单(返回建筑更新)
function BuildingProto:TradeSpeedOrder(_id)
    local proto = {"BuildingProto:TradeSpeedOrder", {
        id = _id
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:TradeSpeedOrderRet(proto)

end

-- 点赞好友
function BuildingProto:Agree(_fid, _cb)
    self.AgreeCB = _cb
    local proto = {"BuildingProto:Agree", {
        fid = _fid
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:AgreeRet(proto)
    if (self.AgreeCB) then
        self.AgreeCB(proto)
    end
    self.AgreeCB = nil
end

-- 好友订单
function BuildingProto:FlrTradeOrders(_fid)
    -- self.FlrTradeOrdersCB = _cb
    local proto = {"BuildingProto:FlrTradeOrders", {
        fid = _fid
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:FlrTradeOrdersRet(proto)
    -- if(self.FlrTradeOrdersCB) then
    -- 	self.FlrTradeOrdersCB(proto)
    -- end
    -- self.FlrTradeOrdersCB = nil
    EventMgr.Dispatch(EventType.Matrix_Trading_FlrUpgrade, proto)
end

-- 交易好友订单信息
function BuildingProto:TradeFlrOrder(_fid, _orderId, _cb)
    self.TradeFlrOrderCB = _cb
    local proto = {"BuildingProto:TradeFlrOrder", {
        fid = _fid,
        orderId = _orderId
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:TradeFlrOrderRet(proto)
    self:ShowRewardPanel(proto)
    if (#proto.rewards > 0 and self.TradeFlrOrderCB) then
        self.TradeFlrOrderCB(proto)
    end
    self.TradeFlrOrderCB = nil
end

function BuildingProto:PhySleep(_roleId, _sleep_ix)
    local _id = MatrixMgr:GetBuildingDataByType(BuildsType.PhyRoom):GetID()
    local proto = {"BuildingProto:PhySleep", {
        id = _id,
        roleId = _roleId,
        sleep_ix = _sleep_ix
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:PhySleepRet(proto)
    local cRoleData = CRoleMgr:GetData(proto.roleId)
    if (cRoleData) then
        cRoleData:SetLv(cRoleData.lv)
        cRoleData:SetExp(cRoleData.exp)
        cRoleData:SetHeartIndex(proto.sleep_ix)
        FavourMgr:SetCMCount(proto.phyGameCnt)
        EventMgr.Dispatch(EventType.Favour_CM_Success, proto)
    end
end

----------------------------------------队伍预设------------------------------------------
-- 预设队伍角色设置
function BuildingProto:BuildSetPresetRole(_id, _teamId, _roleIds)
    local proto = {"BuildingProto:BuildSetPresetRole", {
        id = _id,
        teamId = _teamId,
        roleIds = _roleIds
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:BuildSetPresetRoleRet(proto)
    local matrixData = MatrixMgr:GetBuildingDataById(proto.id)
    matrixData:SetPresetRoles(proto.infos)
    EventMgr.Dispatch(EventType.Matrix_Add_PresetTeam)
end

-- 更改预设队伍名字
function BuildingProto:BuildSetPresetTeamName(_id, _teamId, _name)
    local proto = {"BuildingProto:BuildSetPresetTeamName", {
        id = _id,
        teamId = _teamId,
        name = _name
    }}
    NetMgr.net:Send(proto)
end
function BuildingProto:BuildSetPresetTeamNameRet(proto)
    local matrixData = MatrixMgr:GetBuildingDataById(proto.id)
    matrixData:SetTeamName(proto.infos)
    EventMgr.Dispatch(EventType.Matrix_Add_PresetTeam)
end

-- 新增预设队伍
function BuildingProto:BuildAddPresetTeam(_id)
    local proto = {"BuildingProto:BuildAddPresetTeam"}
    NetMgr.net:Send(proto)
end
function BuildingProto:BuildAddPresetTeamRet(proto)
    MatrixMgr:SetExtraPresetTeamNum(proto.extraPresetTeamNum)
    EventMgr.Dispatch(EventType.Matrix_Add_PresetTeam)
end
