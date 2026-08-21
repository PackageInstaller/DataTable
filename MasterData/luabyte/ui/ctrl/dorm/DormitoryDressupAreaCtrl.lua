local DormitoryDressupAreaCtrl = BaseClass("DormitoryDressupAreaCtrl")
local M = DormitoryDressupAreaCtrl
local tInsert = table.insert
function M:__init(view)
    self._view = view
    self.areaArray = {}
    tInsert(self.areaArray, DormConst.DormArea.MainArea)
    tInsert(self.areaArray, DormConst.DormArea.SofaArea)
    tInsert(self.areaArray, DormConst.DormArea.BedArea)
    tInsert(self.areaArray, DormConst.DormArea.ConsoleArea)
    tInsert(self.areaArray, DormConst.DormArea.ShelfArea)
    tInsert(self.areaArray, DormConst.DormArea.PhotowallArea)
    tInsert(self.areaArray, DormConst.DormArea.Photowall2Area)
    tInsert(self.areaArray, DormConst.DormArea.Photowall3Area)
    self._view.BtnL.transform:onClick(Bind(self, self.OnClickBtnL))
    self._view.BtnR.transform:onClick(Bind(self, self.OnClickBtnR))
    self.callback = nil
    self.context = UIContextMgr:GetInstance():GetContext("DormitoryDressupUI")
    self.areaItems = {}
    self.isTemplateShow = false
    self.index = 1
    self.max = #self.areaArray
    self.min = 1
end

function M:OnClickBtnL(go)
    self.index = self.min
    self._view.ScrollView:Nevigate(self.areaItems[self.index]._view.Rect)
end

function M:OnClickBtnR(go)
    self.index = self.max
    self._view.ScrollView:Nevigate(self.areaItems[self.index]._view.Rect)
end

function M:UpdateDropdown()
    if #self.areaItems > 0 then
        for i = 1, #self.areaItems do
            GameUtil.DestroyGo(self.areaItems[i]._view.gameObject)
        end
    end
    local ctrlItemCls = require("UI.Ctrl.Dorm.DormitoryDressupAreaItemCtrl")
    for key, value in pairs(self.areaArray) do
        local areaItem = self._view.Item:Instantiate()
        areaItem:SetParent(self._view.Content)
        areaItem:SetActive(true)
        local ctrlItem = ctrlItemCls.New(areaItem)
        ctrlItem:UpdataData(value)
        ctrlItem:SetCallback(Bind(self,self.CheckSave))
        tInsert(self.areaItems, ctrlItem)
        if OtakuFurniturDataMgr:CheckFurnitureAreaTypeRedPoint(value.type) then
            self.index = key
        end 
    end
    coroutine.start(Bind(self, self._WaitForReady))
end

function M:_WaitForReady()
    coroutine.waitforseconds(1)
    self._view.ScrollView:Nevigate(self.areaItems[self.index]._view.Rect)
end

function M:SelectArea(area)
    for i = 1, #self.areaItems do
        if self.areaItems[i].data.type == area.type then
            self.areaItems[i]:OnClickItem()
        end
    end
end

function M:UpdateData(area)
    self.curArea = area
    if self.callback then
        self.callback(self.curArea)
    end
end

function M:SetCallback(callback)
    self.callback = callback
end

function M:CheckSave(area)
    for i = 1, #self.areaItems do
        if self.areaItems[i].data.type ~= area.type then
            self.areaItems[i]:SetSelect(false)
        end
    end
    self.context:CheckSave(function()
        self:UpdateData(area)
    end)
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:OnDispose()
    self.areaArray = {}
    for key, value in pairs(self.areaItems) do
        value:OnDispose()
    end
    self.areaItems = nil
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return DormitoryDressupAreaCtrl
