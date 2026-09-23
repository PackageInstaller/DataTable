-- 卡牌角色基类
local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitData(_data, isRealCard)
    self.id = _data.id
    self.data = _data.data -- 数据快
    self.cfg = Cfgs.CfgCardRole:GetByID(self.id)
    if (self.cfg == nil) then
        LogError("CfgCardRole表找不到id：" .. self.id)
    end

    if (not self.oldB_lv) then
        self.oldB_lv = self:GetBreakLevel()
    end

    self.cfgModel = Cfgs.character:GetByID(self.cfg.aModels)

    -- 是否是自己的真实获得的卡牌
    if (isRealCard ~= nil) then
        self.isRealCard = isRealCard
    end
end

function this:IsPet()
    return false
end

-- function this:GetId()
-- 	return self.id
-- end
function this:GetID()
    return self.id
end

-- 表
function this:GetCfg()
    return self.cfg
end

function this:GetCfgID()
    return self.cfg.id
end

-- 排序
function this:GetCfgIndex()
    return self.cfg and self.cfg.index or 1
end

function this:GetName()
    if (self.sName) then
        return self.sName
    else
        local id = RoleMgr.GetCurrSexCardCfgId() -- 主角卡牌id
        if (id == self.cfg.id) then
            self.sName = PlayerClient:GetName()
        end
        if (self.sName == nil) then
            self.sName = self.cfg and self.cfg.sName or ""
        end
        return self.sName
    end
end

-- 代号
function this:GetAlias()
    if (self.sAliasName) then
        return self.sAliasName
    else
        if (g_FlowOnSetPlrName ~= nil and g_FlowOnSetPlrName == true) then
            local id = RoleMgr.GetCurrSexCardCfgId() -- 主角卡牌id
            if (id == self.cfg.id) then
                self.sAliasName = PlayerClient:GetName()
            end
        end
        if (self.sAliasName == nil) then
            self.sAliasName = self.cfg and self.cfg.sAliasName or ""
        end
        return self.sAliasName
    end
end

-- 英文名
function this:GetEnName()
    return self.cfg and self.cfg.eName
end

-- 多语言音效名
function this:GetSoundLanguageName()
    return self.cfg and self.cfg.soundLanguageName
end

-- 稀有度 
function this:GetQuality()
    if (not self.quality) then
        local _cfg = Cfgs.CardData:GetByID(self.cfg.aCards[1])
        self.quality = _cfg and _cfg.quality or 1
    end
    return self.quality or 1
end

-- 获取阵营 小队
function this:GetCamp()
    if (not self.nClass) then
        local _cfg = Cfgs.CardData:GetByID(self.cfg.aCards[1])
        self.nClass = _cfg and _cfg.nClass or 1
    end
    return self.nClass or 1
end

--  {1商店皮肤  2跃升皮肤  3同调皮肤}
function this:GetSkinTypeArr()
    local arr = nil
    local _skins = RoleSkinMgr:GetDatas(self.cfg.id)
    for k, v in pairs(_skins) do
        if (v:GetSkinType() ~= 0 and v:CheckCanUse()) then
            arr = arr or {}
            table.insert(arr, v:GetSkinType())
        end
    end
    return arr
end

-- 所有皮肤 字典 [moduleid] = RoleSkinInfo 
function this:GetAllSkins(containJieJin)
    local skins = {}
    local _skins = RoleSkinMgr:GetDatas(self.cfg.id, containJieJin)
    for n, m in pairs(_skins) do
        skins[n] = m
    end
    return skins
end

-- onlyInSell: true:非突破皮肤未获得时，在商店出售时才插入列表  false:都插入列表
function this:GetAllSkinsArr(onlyInSell)
    local skins = {}
    local _skins = RoleSkinMgr:GetDatas(self.cfg.id, true)
    for n, v in pairs(_skins) do
        if (onlyInSell) then
            if (v:CheckIsBreakType() or v:CheckCanUse() or v:IsInSell()) then
                table.insert(skins, v)
            end
        else
            table.insert(skins, v)
        end
    end
    if (#skins > 1) then
        table.sort(skins, function(a, b)
            if (a:CheckCanUse() == b:CheckCanUse()) then
                return a:GetIndex() < b:GetIndex()
            else
                return a:CheckCanUse()
            end
        end)
    end
    return skins
end

-- 第一张皮肤 id
function this:GetFirstSkinId()
    return self.cfg.aModels
end

-- 第一张卡牌 id 
function this:GetFirstCardId()
    return self.cfg.id
end

function this:GetBaseModel()
    return self.cfgModel
end

function this:GetCurModel()
    local cardData = RoleMgr:GetDataByCfgID(self:GetFirstCardId())
    if (cardData) then
        local skinID = cardData:GetSkinID()
        return Cfgs.character:GetByID(skinID)
    end
    return self.cfgModel
end

-- 列表 图
function this:Card_head()
    local cfgModel = self:GetCurModel()
    if (cfgModel) then
        return cfgModel.Card_head
    end
    return nil
end

-- 矩形
function this:GetIcon()
    local cfgModel = self:GetCurModel()
    if (cfgModel) then
        return cfgModel.List_head
    end
end

-- 正方形
function this:GetBaseIcon()
    local cfgModel = self:GetCurModel()
    if (cfgModel) then
        return cfgModel.icon
    end
    return nil
end

-- 半身
function this:FightCard()
    local cfgModel = self:GetCurModel()
    if (cfgModel) then
        return cfgModel.Fight_head
    end
    return nil
end

function this:IsShowLV()
    return self.cfg and self.cfg.bHadLv or false
end

-- 好感度 str
function this:GetFavorability()
    local cfg = Cfgs.CfgCardRoleUpgrade:GetByID(self:GetLv())
    return cfg and cfg.sName or ""
end

-- 性别 id
function this:GetGender()
    return self.cfg and self.cfg.sSex or 1
end

-- 小队 id
function this:GetTeam()
    return self.cfg and self.cfg.sTeam or 1
end

-- 出生地 id
function this:GetBlood()
    return self.cfg and self.cfg.sBirthPlace or 1
end

function this:GetBelonging()
    return self.cfg and self.cfg.sBelonging or 1
end

-- 取第一个能力
function this:GetAbilityId()
    return self.cfg.nAbilityId and self.cfg.nAbilityId[1] or nil
end

-- 当前能力集合（所有等级）
function this:GetAbilityCfg()
    if (self:GetAbilityId()) then
        return Cfgs.CfgCardRoleAbilityPool:GetByID(self:GetAbilityId())
    end
    return nil
end

-- 能力类型  
function this:GetAbilityType()
    if (self:GetAbilityId()) then
        local cfg = Cfgs.CfgCardRoleAbilityPool:GetByID(self:GetAbilityId())
        return cfg.type
    end
    return nil
end

-- 排序用 4009  13能力的排前面
function this:GetAbilitySortType13()
    local type = self:GetAbilityType() or 10000
    if (type == 13) then
        return 0
    end
    return type
end

--皮肤最新的获得时间
function this:GetSkinsNTime()
    return RoleSkinMgr:GetNTime(self:GetID())
end

-- 当前等级的能力
function this:GetAbilityCurCfg()
    local cfgID = self:GetAbilityId()
    if (cfgID) then
        local poolCfg = Cfgs.CfgCardRoleAbilityPool:GetByID(cfgID)
        if (poolCfg) then
            for i, v in ipairs(poolCfg.arr) do
                if (self:GetLv() >= v.roleLvMin and self:GetLv() <= v.roleLvMax) then
                    return v
                end
            end
        end
    end
    return nil
end

-- 在图集中是否显示
function this:IsShowInAltas()
    local isShow = false
    if self.cfg then
        if self.cfg.bShowInAltas then
            isShow = true
        end
        if isShow and self.cfg.sShowTime then
            if self.showTime == nil then
                self.showTime = TimeUtil:GetTimeStampBySplit(self.cfg.sShowTime)
            end
            isShow = self.showTime <= TimeUtil:GetTime()
        end
    end
    return isShow
end

-- 在该建筑时能力是否生效  
function this:CheckSkillCanUseByBuildID(roomId)
    if (self.oldRoomId and self.oldRoomId == roomId) then
        return self.isUsable
    end
    self.oldRoomId = roomId

    self.isUsable = false
    local roomType = DormMgr:GetRoomTypeByID(roomId) -- 房间类型
    if (roomType == RoomType.building) then
        local buildData = MatrixMgr:GetBuildingDataById(roomId)
        local buildType = buildData:GetType()
        self.isUsable = self:CheckSkillCanUseByBuildType(buildType)
        return self.isUsable
    end
    return self.isUsable
end

-- 在该建筑时能力是否生效  
function this:CheckSkillCanUseByBuildType(buildType)
    local id = self.cfg.nAbilityId[1] or nil
    if (id) then
        local cfg = Cfgs.CfgCardRoleAbilityPool:GetByID(id)
        local needBuildTypes = cfg.needBuildTypes or {}
        for k, m in ipairs(needBuildTypes) do
            if (m == buildType) then
                return true
            end
        end
    end
    return false
end

-- 所在房间名称  --todo  
function this:GetRoomNama()
    local str = nil
    local roomType = DormMgr:GetRoomTypeByID(self:GetRoomBuildID())
    if (roomType and roomType == RoomType.dorm) then
        local room = DormMgr:GetRoomData(self:GetRoomBuildID()) -- 1
        str = room and room:GetName() or ""
    elseif (roomType and roomType == RoomType.building) then
        local room = MatrixMgr:GetBuildingDataById(self:GetRoomBuildID()) -- 2
        str = room and room:GetBuildingName() or ""
    end
    return str
end

function this:ChangeClothes(_data)
    self.data.clothes = _data
end

-- 能否与该角色id发生交互; {交互动作id，交互文本id}
function this:CheckCanInte(cRoleID)
    local highfives = self:GetCfg().highfives
    if (highfives == nil) then
        return true
    end
    for k, v in ipairs(highfives) do
        if (v == cRoleID) then
            return false
        end
    end
    return true
end

-- pl表情变更时间 50、100 
function this:GetPLChangeTime()
    -- local pl = self:GetCurRealTv()
    -- if (pl >= 100) then
    --     return nil, pl
    -- elseif (pl > 50) then
    --     return self:GetTF(), pl
    -- else
    --     local len = 50 - pl
    --     local timer = math.ceil(len / 50 * (self:GetTF() - TimeUtil:GetTime()))
    --     return timer, pl
    -- end
    --
    -- 改下一点pl更新时间 （0-10：红  11-50：黄色  51-100：绿）
    return self:GetPerTimer(), self:GetCurRealTv()
end

--------------------------------------------数据快内容----------------------------------------------------
function this:GetData()
    return self.data
end

-- 事件开始时间
function this:GetEStart()
    return self:GetData().e_start
end

-- 疲劳值
function this:GetTriedValue()
    return self:GetData().tv or 0
end

-- 当前真实疲劳 改体力
function this:GetCurRealTv()
    local cur = self:GetTriedValue()
    local tf = self:GetTF()
    if (tf == nil or tf == 0) then
        return cur
    else
        -- 如果在宿舍或者不在建筑，那就是减pl
        local b = self:IsInBuilding()
        if (not b) then
            -- 增疲劳
            local curTime = TimeUtil:GetTime()
            if (curTime >= tf) then
                return 100
            else
                local tv = self:GetPreTV()
                local p = (curTime - tv) / (tf - tv)
                local num = math.floor(p * (100 - cur)) + cur
                num = num >= 100 and 100 or num
                return num
            end
        else
            -- 减pl
            local curTime = TimeUtil:GetTime()
            if (curTime >= tf) then
                return 0
            else
                local tv = self:GetPreTV()
                local p = (curTime - tv) / (tf - tv)
                local num = cur - math.floor(p * cur)
                num = num <= 0 and 0 or num
                return num
            end
        end
    end
end

-- 更新间隔(即增减一点的时间)
function this:GetPerTimer()
    local perTimer = nil
    local tf = self:GetTF()
    if (tf ~= nil and tf ~= 0 and tf > TimeUtil:GetTime()) then
        local cur = self:GetTriedValue()
        local b = self:IsInBuilding()
        local num = b and cur or (100 - cur)
        local time = tf - self:GetPreTV()
        perTimer = math.floor(time / num)
    end
    return perTimer
end

-- 音效是否已获得
function this:CheckAudioIsGet(audioId)
    local cfg = Cfgs.Sound:GetByID(audioId)
    if (cfg.bookDisplay) then
        if(cfg.openModel)then 
            if(not RoleSkinMgr:CheckModelsIsGet(cfg.openModel)) then 
                return false
            end 
        end 
        if (cfg.openLv) then
            return cfg.openLv <= self:GetLv()
        else
            if (self:GetData().audio) then
                return self:GetData().audio[audioId] ~= nil
            end
        end
    end
    return false
end

-- 入手时间
function this:GetCreateTime()
    return self:GetData().t_create or 0
end

-- 已解锁的故事列表
function this:GetStoryIds()
    return self:GetData().story_ids or {}
end

-- 插入一个解锁的故事
function this:SetStoryIds(index)
    self.data.story_ids = self.data.story_ids or {}
    table.insert(self.data.story_ids, index)
end

-- 最高突破等级
function this:GetBreakLevel()
    return self:GetData().b_lv or 1
end

function this:GetOldBreakLevel(lv)
    if (lv) then
        self.oldB_lv = lv
    end
    return self.oldB_lv
end

-- 好感度等级 
function this:GetLv()
    return self:GetData().lv or 1
end
function this:SetLv(lv)
    self:GetData().lv = lv
end
-- 是否是最大等级
function this:IsMax()
    return self:GetLv() >= CRoleMgr:GetCRoleMaxLv()
end

-- exp
function this:GetExp()
    local cur, max
    cur = self:GetData().exp or 0
    if (self:IsMax()) then
        max = cur
    else
        local cfg = Cfgs.CfgCardRoleUpgrade:GetByID(self:GetLv())
        max = cfg.nExp
    end
    return cur, max
end
function this:SetExp(exp)
    self:GetData().exp = exp
end

-- 房间/建筑id
function this:GetRoomBuildID()
    local build_id = self:GetData().build_id
    if (build_id == nil or build_id == 0) then
        return nil
    end
    return build_id
end

-- 是否在建筑
function this:IsInBuilding()
    local build_id = self:GetRoomBuildID()
    local roomType = build_id and DormMgr:GetRoomTypeByID(build_id) or nil -- 房间类型
    return (roomType ~= nil and roomType == RoomType.building) and true or false
end

-- 是否在宿舍
function this:IsInDorm()
    local build_id = self:GetRoomBuildID()
    local roomType = build_id and DormMgr:GetRoomTypeByID(build_id) or nil -- 房间类型
    return (roomType ~= nil and roomType == RoomType.dorm) and true or false
end

-- 是否在咨询室
function this:IsInPhyRoom()
    if (self:IsInBuilding()) then
        local build_id = self:GetRoomBuildID()
        local buildData = MatrixMgr:GetBuildingDataById(build_id)
        return buildData:GetType() == BuildsType.PhyRoom
    end
    return false
end

-- 本建筑已入驻
function this:Sort_CheckInBuilding(buildId)
    local build_id = self:GetRoomBuildID()
    if (build_id and build_id == buildId) then
        return 1
    end
    return 0
end
-- 其他建筑未入驻
function this:Sort_CheckBuildingIsNil()
    local build_id = self:GetRoomBuildID()
    return build_i == nil and 1 or 0
end

-- --所在房间id
-- function this:GetRoomID()
-- 	local _id = self:GetRoomBuildID()
-- 	if(GCalHelp:IsDormId(_id)) then
-- 		_id = nil
-- 	end
-- 	return _id
-- end
-- --所在建筑id
-- function this:GetBuildID()
-- 	local _id = self:GetRoomBuildID()
-- 	if(not GCalHelp:IsDormId(_id)) then
-- 		_id = nil
-- 	end
-- 	return _id
-- end
-- 上次pl更新时间
function this:GetPreTV()
    return self:GetData().t_pre_tv
end

-- 满pl的时间，为0时不计算
function this:GetTF()
    return self:GetData().tf
end

function this:GetClothes()
    return self.data.clothes
end

function this:GetEvent()
    return self:GetData().e_id, self:GetData().e_story, self:GetData().e_start
end

-- 返回是否是新卡牌
function this:IsNew()
    return self:GetData() and self:GetData().is_new == true or false
end
function this:SetIsNew(b)
    self:GetData().is_new = b
end

-- 身体模型 body face hair
function this:GetModelNames()
    local modleNames = {}
    local _cfg = self.cfgModel
    local cardData = RoleMgr:GetDataByCfgID(self:GetFirstCardId())
    if (cardData) then
        local skinID = cardData:GetSkinID()
        _cfg = Cfgs.character:GetByID(skinID)
    end
    if (_cfg.body) then
        table.insert(modleNames, _cfg.body)
    end
    if (_cfg.face) then
        table.insert(modleNames, _cfg.face)
    end
    if (_cfg.hair) then
        table.insert(modleNames, _cfg.hair)
    end
    return modleNames
end

-- -- 身体模型 body face hair
-- function this:GetModelNames()
--     local modleNames = {}
--     local cfg = self:GetCfg()
--     local clothes = self:GetClothes()
--     local _cfg = nil -- 皮肤
--     if (clothes and #clothes > 0) then
--         local itemId = clothes[1]
--         _cfg = Cfgs.CfgClothes:GetByID(itemId)
--     end

--     --测试显示 
--     if(cfg.body1)then 
--         table.insert(modleNames,  cfg.id .. "/" .. cfg.body1)
--     elseif ((_cfg and _cfg.body) or cfg.body) then
--         local s = (_cfg and _cfg.body) and _cfg.body or cfg.body
--         table.insert(modleNames, "Body/" .. s)
--     end

--     if ((_cfg and _cfg.face) or cfg.face) then
--         local s = (_cfg and _cfg.face) and _cfg.face or cfg.face
--         table.insert(modleNames, cfg.id .. "/" .. s)
--     end
--     if ((_cfg and _cfg.hair) or cfg.hair) then
--         local s = (_cfg and _cfg.hair) and _cfg.hair or cfg.hair
--         table.insert(modleNames, cfg.id .. "/" .. s)
--     end
--     return modleNames
-- end

-- 当前到满级需要经验
function this:GetMExp(lv)
    lv = lv == nil and self:GetLv() or lv
    local cfg1 = Cfgs.CfgCardRoleUpgrade:GetByID(self:GetLv())
    local mExp1 = cfg1.mExp or 0
    local cfg2 = Cfgs.CfgCardRoleUpgrade:GetByID(#CfgCardRoleUpgrade)
    local mExp2 = cfg2.mExp or 0
    return mExp2 - mExp1
end

-- 根据经验判断等级
function this:GetNextLvByExp(totalExp)
    local curLv = self:GetLv()
    local had = curLv > 1 and Cfgs.CfgCardRoleUpgrade:GetByID(curLv).mExp or 0
    had = had + self:GetExp() + totalExp
    local cfgs = Cfgs.CfgCardRoleUpgrade:GetAll()
    for i, v in ipairs(cfgs) do
        if (v.mExp > had) then
            return i - 1
        end
    end
    return #cfgs
end

-- 发呆类型
function this:GetDaze()
    return self.cfg and self.cfg.daze or 1
end

-- 点击望向镜头类型
function this:GetClick()
    return self.cfg and self.cfg.click or 1
end

-- 当前内心独白的阶段
function this:GetHeartIndex()
    local cur = self:GetData().sleep_ix or 0
    local cfg = Cfgs.CfgCardRoleUpgrade:GetByID(self:GetLv())
    local max = cfg.inwardWorld or 0
    return cur, max
end
function this:SetHeartIndex(sleep_ix)
    self:GetData().sleep_ix = sleep_ix
end

-- 是自己真实获得的卡牌（不是假数据、助战、满级假卡）
-- function this:SetRealCard()
--     self.isRealCard = true
-- end
function this:CheckIsRealCard()
    return self.isRealCard
end

-- 红点 是否无体力了
function this:CheckIsRed()
    return self:GetCurRealTv() <= 0
end

-- 皮肤列表（未查看的）
function this:GetClothes()
    return self.data.look_skins or {}
end
function this:CheckHadNewSkin()
    local skins = self:GetAllSkins()
    for k, v in pairs(skins) do
        if (v:CheckIsNew()) then
            return true
        end
    end
    return false
end
function this:CheckSkinIsNew(id)
    local skins = self:GetClothes()
    for k, v in ipairs(skins) do
        if (v == id) then
            return true
        end
    end
    return false
end
function this:RemoveNewSkin(id)
    local skins = self:GetClothes()
    for k, v in ipairs(skins) do
        if (v == id) then
            table.remove(skins, k)
            break
        end
    end
end

-- 卡牌是否有限时皮肤
function this:IsHadLimitSkin()
    return RoleSkinMgr:IsHadLimitSkin(self:GetID())
end

-- 可用的皮肤，字典
function this:GetAllCanUseSkinDic()
    local skinDic = {}
    local _skins = RoleSkinMgr:GetDatas(self.cfg.id, true)
    for n, v in pairs(_skins) do
        if (v:CheckCanUse()) then
            skinDic[v:GetSkinID()] = 1
        end
    end
    return skinDic
end

-- --身体模型 body face hair
-- function this:GetModelNames()
-- 	local modleNames = {}
-- 	local sSex = self:GetGender()
-- 	--body
-- 	local _name = ""	
-- 	if(sSex == 1) then
-- 		_name = "Dorm_Boy_Body"
-- 	else
-- 		local s = {"s1", "m1", "b1"}
-- 		local index = CSAPI.RandomInt(1, 3)
-- 		_name = string.format("Dorm_Girl_%s_Body", s[index])
-- 	end
-- 	table.insert(modleNames, "Body/" .. _name)
-- 	--face
-- 	if(sSex == 1) then
-- 		_name = "Dorm_Boy_Face"
-- 	else
-- 		local s = {"10020", "10260"}
-- 		local index = CSAPI.RandomInt(1, 2)
-- 		_name = string.format("Dorm_%s_Face", s[index])
-- 	end
-- 	table.insert(modleNames, "Face/" .. _name)
-- 	--hair
-- 	if(sSex == 1) then
-- 		_name = "Dorm_Boy_Hair"
-- 	else
-- 		if(_name ~= "Dorm_10020_Face") then
-- 			local s = {"10260", "40310"}
-- 			local index = CSAPI.RandomInt(1, 2)
-- 			_name = string.format("Dorm_%s_Hair", s[index])
-- 		else
-- 			_name = ""
-- 		end
-- 	end
-- 	if(_name ~= "") then
-- 		table.insert(modleNames, "Hair/" .. _name)
-- 	end
-- 	return modleNames
-- end

return this
