-- 档案ITEM 
local RoleProfileStoryItemCtrl = BaseClass("RoleProfileStoryItemCtrl", UIBaseComponent)
local M = RoleProfileStoryItemCtrl
local numPath = "UI/SpritePics/common/RomanNum/ui_develop_text_"

function M:__init()
    self._module = ModuleMgr:GetInstance():GetCurrentModule()
    self._view.btn:onClick(Bind(self,self._OnClickItem))
end

function M:SetInfo(heroPersonaCfg, clickCallback, state, isOpen, idx)
    self._clickCallback = clickCallback
    self.isOpen = isOpen
    self.idx = idx
    self._view.Name1:SetText(heroPersonaCfg.storyTitle[idx])
    self._view.Name2:SetText(heroPersonaCfg.storyTitle[idx])
    self._view.tfRedPoint:SetActive(not state)
    self._view.UIState:SetState(isOpen and 1 or 2)
    if not isOpen then
        local str = ConfigHelper.GetLocalString(1244)
        self._view.UlockText:SetText(string.format(str, heroPersonaCfg.storyLimit[idx]))
    end
    local line = math.modf(idx / 10) -- 取整数
    local mod = math.fmod(idx, 10) -- 取余数
    self._view.imgNum2:SetPic(numPath .. line)
    self._view.imgNum1:SetPic(numPath .. mod)
end

function M:_OnClickItem()
    if not self.isOpen then
        return
    end
    if self._clickCallback then
        self._clickCallback(self.idx)
    end
end

function M:OnDestroy()
    self._clickCallback = nil
    M.super.OnDestroy(self)
end

return RoleProfileStoryItemCtrl
