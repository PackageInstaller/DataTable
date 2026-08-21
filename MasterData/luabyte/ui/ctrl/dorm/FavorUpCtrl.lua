local FavorUpCtrl = BaseClass("FavorUpCtrl", BaseUICtrl)
local M = FavorUpCtrl

function M:Init()
    self.LockScrollView = self._view.LockScrollView
    self.LockScrollView:Init(require("UI.Ctrl.Dorm.LockItemCtrl"), require("UI.View.Dorm.LockItemView"))
    self._view.MaskClose:onClick(Bind(self, self.OnClickMask))
end

--初始化好感度界面
function M:OnEnter(heroId, favorLevel, curLevel)
    if heroId == 0 then
        return
    end
    self._heroId = heroId
    self._curLevel = curLevel
    self:InitLock(heroId, favorLevel)
    local dataValues = { tostring(curLevel) }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Favorability, dataValues)
    local data = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    data.showFavorLevel = favorLevel
    if curLevel == data.showFavorLevel then
        data.favorLevelChange = false
    end
end

-- 初始化好感度解锁
function M:InitLock(heroId, level)
    self.lockList = OtakuHelper.GetFellingLevelUnlock(heroId, level)
    self.LockScrollView:SetDataList(self.lockList)
end

function M:OnClickMask()
    local continue, level = OtakuHelper.CheckFavorUp(self._heroId, self._curLevel)
    if continue == true then
        self:OnEnter(self._heroId, level, self._curLevel)
    else
        self:Close()
    end
end

function M:OnClose()
end

return FavorUpCtrl
