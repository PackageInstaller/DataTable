local M = BaseClass("ResourceChapterItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self.m_tipsId = 0
    self.m_chapter = nil
    self.m_itemIcons = { self._view.img_itemIcon }
    self._view.transform.localEulerAngles = Vector3.zero
    self._view.node_lock:onClick(Bind(self, self.OnLockClick))
    self._view.node_normal:onClick(Bind(self, self.OnNormalClick))
end

function M:OnDispose()
    for _, v in ipairs(self.m_itemIcons) do v:OnDestroy() end
    self.m_tipsId = nil
    self.m_chapter = nil
    self.m_itemIcons = nil
    M.super.OnDispose(self)
end

function M:UpdateItem(data)
    if data == nil then return end

    self.m_chapter = data.Chapter
    local lockId, isOpenToday = data.LockId, false
    if lockId == 0 then -- 主要解锁条件
        ----此处新增解锁、限制开放需求：
        --- 1、自玩家创建角色的当日5点—7日后的5点, 此时间区间内openCondition达成了, 则不需要满足weekOpenCondition即可开放；
        --- 2、过了【自玩家创建角色的当日5点—7日后的5点】后, 解锁条件依然是 openCondition 和 weekOpenCondition
        isOpenToday = (data.IsNewRoleOpen or data.IsActivityOpen) and true or data.IsWeekDay
    else
        isOpenToday = data.IsWeekDay
    end

    self.m_tipsId = self:_GetLockDesc(lockId)
    self._view.txt_lock:SetText(self.m_tipsId)
    self._view.txt_chName:SetText(self.m_chapter.name)
    self._view.img_banner:SetPic(self.m_chapter.banner)
    self._view.txt_enName:SetText(self.m_chapter.nameEN)
    self._view.activityTag:SetActive(data.IsActivityOpen) -- 活动标签
    self._view.txt_desc:SetText(self.m_chapter.chapterName)
    self._view.txt_openDesc:SetText(self.m_chapter.openDesc)
    self._view.txt_itemName:SetText(self.m_chapter.rewardDes[0])
    self._view.node_lock:SetActive(not ((lockId == 0) and isOpenToday))
    self._view.limitOpen:SetActive(data.IsNewRoleOpen and not data.IsActivityOpen) --新手限时标签
    self:_CheckDoubleActivity(data.Double)
    self:_ShowChapterRewards()
end

function M:OnLockClick(go)
    if self.m_tipsId > 0 then
        GameHelper.TipsById(self.m_tipsId)
    else
        Logger.Log("tips id == 0")
    end
end

function M:OnNormalClick(go)
    JumpMgr:GetInstance():Execute(100, EnumConst.EBattleStyle.Normal, self.m_chapter)
end

-- 双倍标签
function M:_CheckDoubleActivity(doubleData)
    if doubleData and (doubleData.RemainTimes > 0) and not doubleData.IsAllDouble then
        local stages = self.m_chapter.stages
        for i = 0, stages.Length - 1, 1 do
            if doubleData.DoubleDic[stages[i]] then
                self._view.limitTimeTag:SetActive(true) -- 限时副本状态
                return
            end
        end
    end
    self._view.limitTimeTag:SetActive(false) -- 限时副本状态
end

function M:_ShowChapterRewards()
    local groupId = self.m_chapter.chapterReward
    local group = ConfigHelper.GetCfgByLua("itemGroup", groupId)
    local len = group and #group.items or 0
    if len > 0 then
        for i, itemId in ipairs(group and group.items or {}) do
            local icon = self.m_itemIcons[i]
            if not icon then
                icon = self._view.img_itemIcon:Instantiate()
                table.insert(self.m_itemIcons, icon)
            end
            icon:SetItemIcon(itemId)
            icon:SetActive(true)
        end
        for i = len + 1, #self.m_itemIcons do
            self.m_itemIcons[i]:SetActive(false)
        end
    else
        for _, v in ipairs(self.m_itemIcons) do v:SetActive(false) end
    end
end

function M:_GetLockDesc(lockId)
    if lockId <= 0 then return 5864 end

    local openCfg = ConfigHelper.GetCfgByLua("openCondition", lockId)
    if openCfg then
        return openCfg.tips
    else
        Logger.LogError("openCondition is nil, id = " .. tostring(lockId))
    end
    return 0
end

return M
