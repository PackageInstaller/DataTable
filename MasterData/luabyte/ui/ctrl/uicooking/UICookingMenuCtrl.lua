--baoruichang
--烹饪界面菜单Class
local UICookingMenuCtrl = BaseClass("UICookingMenuCtrl", UIBaseComponent)
local M = UICookingMenuCtrl
local ITEMNUM = 4

function M:__init()
end

function M:UpdateData(data)
    self.data = data
    local name = ConfigHelper.GetCfgPropByLua("item", data.id, "name")
    self._view.labName:SetText(name)
    self._view.imgIcon:SetItemIcon(data.id)
    local menu = ConfigHelper.GetCfg("menu", data.id)
    
    for i = 1, ITEMNUM do
        local id = menu.itemCost[i]
        if id then
            local haveNum = self:GetHaveNum(id)
            local needNum = menu.itemNum[i]
            self.view["Bg" .. i]:UpdateData({id = id,haveNum = haveNum,needNum = needNum})
        else
            self.view["Bg" .. i]:UpdateData()
        end
    end
end

function M:GetHaveNum(id)
    for _, v in pairs(self.data.cookItems) do
        if v.Id == id then
            return v.Num
        end
    end
    return 0
end


return UICookingMenuCtrl
