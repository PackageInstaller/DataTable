local M = BaseClass("ClothItemCtrl")

function M:__init(view)
    self._view = view
    self._view.rectItem:onClick(Bind(self, self.OnItemClick))
end

function M:UpdateItem(data)
    if data == nil then return end

    self.data = data
    local shopSkin = self.data.cfg
    local skinCfg = ConfigHelper.GetCfgByLua("skin", shopSkin.itemId)
    local itemCfg = ConfigHelper.GetCfg("item", shopSkin.itemId)
    self.heroId = skinCfg.heroId
    self._view.txtDes:SetText(itemCfg.name)
    self._view.imgIcon:SetSkinDrawing(skinCfg.id)
    self.isHave = ItemDataMgr:GetInstance():GetItemNumById(shopSkin.itemId) > 0
    if self.isHave then
        self._view.State:SetState(2)
    else
        self._view.State:SetState(1)
        local itemNum = ItemDataMgr:GetInstance():GetItemNumById(shopSkin.finalItem)
        local finalCfg = ConfigHelper.GetCfg("item", shopSkin.finalItem)
        if finalCfg ~= nil then
            self._view.iconCost:SetPic(finalCfg.icon)
            if shopSkin.finalNum == 0 then
                self._view.txtCost:SetText(5083)
                self.isEnough = true
            else
                self._view.txtCost:SetText(tostring(shopSkin.finalNum))
                if itemNum > 0 then
                    local num = itemNum
                    if num >= shopSkin.finalNum then
                        self.isEnough = true
                    else
                        self.isEnough = false
                    end
                else
                    self.isEnough = false
                end
            end
        end
    end
end

function M:OnItemClick()
    if self.isHave == false then
        --将当前商城中的状态以跳转的形式添加
        JumpMgr:GetInstance():TryReplaceLastCommand(58)
        JumpMgr:GetInstance():Execute(69, self.heroId)
        --ModuleMgr:GetInstance():ChangeModule(ModuleConfig.RoleDevelopModule.id, self.heroId, 8)
    end
end

function M:Dispose()
    self._view.rectItem:onClick(nil)
    self:OnDispose()
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
    end

    self._view = nil
end

return M
