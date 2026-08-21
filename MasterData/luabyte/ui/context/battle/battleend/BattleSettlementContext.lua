local M = BaseClass("BattleSettlementContext", BaseContext)


function M:Open(isWin, star, items, extItems, battleStyle, mission, totalExp, bossInfo)
    self.isWin = isWin

    ITimeMgr:ChangeTimeMode(CS.GameX.TimeMode.BattleSingle)
    totalExp = totalExp or IPlayerData.Exp
    self.m_item = items or { Count = 0 }
    self.m_extItems = extItems or { Count = 0 }
    local awards, roleGiftId = {}, {}

    for i = 0, self.m_item.Count - 1 do
        local item = self.m_item[i]
        local mId = item.Id
        if not awards[mId] then
            local cfg = ConfigHelper.GetCfg("item", mId) or {}
            awards[mId] = { id = mId, num = item.Cnt, order = cfg.order or 1, state = 1 }
        else
            awards[mId].num = awards[mId].num + item.Cnt
        end

        local cfg = ConfigHelper.GetCfg("item", item.SrcId)
        if cfg and cfg.type == BagConst.ItemType.EIT_Hero then
            local obj = {}
            obj.ObjId = item.SrcId
            obj.ObjNum = 1
            if item.SrcId ~= item.Id then
                obj.ChipId = item.Id --下面是用chipID是否为0判断是否发生转换
            end
            obj.ChipNum = item.Cnt
            roleGiftId[#roleGiftId + 1] = obj --获得英雄
        end
    end

    local newAwards, isMop, newMission = {}, mission ~= nil, mission or IBattle.context.missionData
    for _, v in pairs(awards) do table.insert(newAwards, v) end
    table.sort(newAwards, function(v1, v2) return v1.order > v2.order end) -- 排序

    local extAwards = {}
    for i = 0, self.m_extItems.Count - 1 do
        local awardExt = self.m_extItems[i]
        local awds, _type = awardExt.Awards, awardExt.Tp or 0 -- 0/1/2
        if type(awds) == "table" then
            for _, item in ipairs(awds or {}) do
                local cfg = ConfigHelper.GetCfg("item", item.Id) or {}
                table.insert(extAwards, { id = item.Id, num = item.Cnt, order = cfg.order or 1, state = 4 + _type })
            end
        else
            local len = awds and awds.Count or 0
            for j = 0, len - 1 do
                local item = awds[j]
                local cfg = ConfigHelper.GetCfg("item", item.Id) or {}
                table.insert(extAwards, { id = item.Id, num = item.Cnt, order = cfg.order or 1, state = 4 + _type })
            end
        end
    end
    table.sort(extAwards, function(v1, v2) return v1.order > v2.order end) -- 排序

    for _, v in ipairs(extAwards) do table.insert(newAwards, v) end        -- 额外奖励

    if #roleGiftId > 0 then
        self.m_newMission = newMission
        self.m_newAwards = newAwards
        self.m_extItems = extItems
        self.m_bossInfo = bossInfo
        self.m_type = battleStyle
        self.m_exp = totalExp
        self.m_isMop = isMop
        self.m_star = star
        GameHelper.ShowRolesStarSuccess(roleGiftId, Bind(self, self.ShowUI))
    else
        self:_Show(newAwards, star, battleStyle, newMission, isMop, totalExp, bossInfo)
    end

    if GameHelper.CheckUnShowBattleSetElementUI(newMission.id) then
        self:GetCtrl():OnChageModule()
        return
    end
end

function M:ShowUI()
    self:_Show(self.m_newAwards, self.m_star, self.m_type, self.m_newMission, self.m_isMop, self.m_exp, self.m_bossInfo)
end

function M:IsWin()
    return self.isWin == 1
end

return M
