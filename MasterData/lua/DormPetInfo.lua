-- 宿舍宠物
local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitData(_data, _isRealCard)
    self.id = _data.id
    self.data = _data.data -- 数据快 {id,build_id}

    -- 是否是自己的真实获得
    if (_isRealCard ~= nil) then
        self.isRealCard = _isRealCard
    end
end

function this:IsHad()
    if (self.isHad ~= nil) then
        return self.isHad
    end
    local itemId = self:GetCfg().item_id
    local cur = BagMgr:GetCount(itemId)
    if (cur > 0) then
        self.isHad = true
    end
    return cur > 0
end

function this:IsPet()
    return true
end

function this:GetID()
    return self.id
end

function this:GetCfgID()
    return self:GetCfg().id
end

-- 表
function this:GetCfg()
    if (not self.cfg) then
        self.cfg = Cfgs.CfgDormPet:GetByID(self:GetID())
    end
    return self.cfg
end

-- 物品表
function this:GetItemCfg()
    if (not self.itemCfg) then
        self.itemCfg = Cfgs.ItemInfo:GetByID(self:GetCfg().item_id)
    end
    return self.itemCfg
end

-- 排序
function this:GetCfgIndex()
    return self:GetCfg() and self:GetCfg().index or 1
end

function this:GetName()
    return self:GetItemCfg().name
end

-- 代号
function this:GetAlias()
    return self:GetName()
end

-- 英文名
function this:GetEnName()
    return ""
end

-- 多语言音效名
function this:GetSoundLanguageName()

end

-- 稀有度 
function this:GetQuality()
    return self:GetItemCfg().quality
end

-- 获取阵营 小队
function this:GetCamp()
    return 1
end

--  {1商店皮肤  2跃升皮肤  3同调皮肤}
function this:GetSkinTypeArr()
    return {1}
end

-- 所有皮肤 字典 [moduleid] = RoleSkinInfo 
function this:GetAllSkins(containJieJin)
    local skins = {}
    return skins
end

function this:GetAllSkinsArr(onlyInSell)
    local skins = {}
    return skins
end

-- 第一张皮肤 id
function this:GetFirstSkinId()
    return self:GetID()
end

-- 第一张卡牌 id 
function this:GetFirstCardId()

end

function this:GetBaseModel()

end

function this:GetCurModel()
    return self:GetCfg()
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
    return self:GetCfg() and self:GetCfg().bHadLv or false
end

-- 好感度 str
function this:GetFavorability()
    local cfg = Cfgs.CfgCardRoleUpgrade:GetByID(self:GetLv())
    return cfg and cfg.sName or ""
end

-- 性别 id
function this:GetGender()
    return self:GetCfg() and self:GetCfg().sSex or 1
end

-- 小队 id
function this:GetTeam()
    return self:GetCfg() and self:GetCfg().sTeam or 1
end

-- 出生地 id
function this:GetBlood()
    return self:GetCfg() and self:GetCfg().sBirthPlace or 1
end

function this:GetBelonging()
    return self:GetCfg() and self:GetCfg().sBelonging or 1
end

-- 取第一个能力
function this:GetAbilityId()
    return self:GetCfg().nAbilityId and self:GetCfg().nAbilityId[1] or nil
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
    if self:GetCfg() then
        if self:GetCfg().bShowInAltas then
            isShow = true
        end
        if isShow and self:GetCfg().sShowTime then
            if self.showTime == nil then
                self.showTime = TimeUtil:GetTimeStampBySplit(self:GetCfg().sShowTime)
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
    local id = self:GetCfg().nAbilityId[1] or nil
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

function this:SetData(_data)
    self.data = _data
end

function this:GetData()
    return self.data or {}
end

-- 事件开始时间
function this:GetEStart()
    return nil
end

-- 疲劳值
function this:GetTriedValue()
    return 0
end

-- 当前真实疲劳 改体力
function this:GetCurRealTv()
    return 100
end

-- 更新间隔(即增减一点的时间)
function this:GetPerTimer()
    local perTimer = nil
    return perTimer
end

-- 音效是否已获得
function this:CheckAudioIsGet(audioId)
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
    return 1
end

function this:GetOldBreakLevel(lv)
    if (lv) then
        self.oldB_lv = lv
    end
    return self.oldB_lv
end

-- 好感度等级 
function this:GetLv()
    return 1
end
function this:SetLv(lv)

end
-- 是否是最大等级
function this:IsMax()
    return true
end

-- exp
function this:GetExp()
    return 0, 0
end
function this:SetExp(exp)

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

--
function this:GetEvent()
    return nil
end

-- 返回是否是新卡牌
function this:IsNew()
    return self:GetData() and self:GetData().is_new == true or false
end
function this:SetIsNew(b)
    self:GetData().is_new = b
end

-- 身体模型 body 
function this:GetModelNames()
    local body = self:GetCfg().body
    return {body}
end

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
    return self:GetCfg() and self:GetCfg().daze or 1
end

-- 点击望向镜头类型
function this:GetClick()
    return self:GetCfg() and self:GetCfg().click or 1
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

return this
