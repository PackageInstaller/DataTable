local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UIHeadCtrl = BaseClass("UIHeadCtrl", CircularScrollViewItem)
local M = UIHeadCtrl

function M:Init()
    self._view.HeroHeadItem.selectBack = Bind(self, self._OnClickItem)
    -- self._view.HeroHeadItem.checkSelect = Bind(self,self._OnCheckSelect)
    
end

function M:UpdateItem(data)
    self.data = data
    --教学关卡需要取模板数据
    local dataOrigin = data.isTeach and 1 or 2
    self._view.HeroHeadItem:SetHeroId(data.heroId, data.lv, dataOrigin)
    self.state = data.state
    --在黑名单中，不可以选中
    if data.isInBacklist then
        self._view.HeroHeadItem.canSelect = false
        self._view.HeroHeadItem:SetInBackList(true)
    else
        self._view.HeroHeadItem.canSelect = true
        self._view.HeroHeadItem:SetInBackList(false)
    end
    if data.canAdd then
        self._view.HeroHeadItem.checkSelect = nil
    else
        self._view.HeroHeadItem.checkSelect = Bind(self, self._OnCheckSelect)
    end
    self._view.HeroHeadItem:SetSelect(self.state)
    self._view.stateBreak:Updata(self.data.rare, self.data.grade)
    self._view.tfSame:SetActive(self.data.isSame and true or false)
end

function M:_OnClickItem(v,_)
    EventMgr:Broadcast(UIMessageNames.TEAM_CLICKHERO, self.data.heroId, not self.state)
end

function M:_OnCheckSelect()
    GameHelper.TipsById(5447)
end


function M:Dispose()
    M.super.Dispose(self)
end

return UIHeadCtrl
