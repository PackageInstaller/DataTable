local M = BaseClass("NoticePopupImageSytelCtrl",UIBaseComponent)

function M:__init()
    self._view.closeMask:onClick(Bind(self,self._Close))
    self._view.close:SetOnClick(Bind(self,self._Close))
    self._view.tipAgain:OnToggleClick(Bind(self,self._OnToggle))
    self._allItems = {}
    self._view.PageTemplate:SetActive(false)
end

function M:SetList( csNoticeDataList ,closeCallback )
    self._closeCallback = closeCallback
    self._csNoticeDataList = csNoticeDataList
    self:_SetItems(csNoticeDataList)
end

function M:_SetItems(csNoticeDataList)
    local content = self._view.ScrollView.listItem.transform
    local childNum = content.childCount
    for i = 0 , childNum -1 do 
        local child = content:GetChild(i)
        child:SetActive(false)
    end
    local len = csNoticeDataList.Count
    for i = 0 , len - 1 do 
        local d = csNoticeDataList[i]
        self:_SetItem(d)
    end
    --INoticeDataMgr:SetRead(csNoticeDataList[0].Id)
    self:_CheckAgain()
    self._view.tipAgain:SetActive(csNoticeDataList[0].DisplayState~=1)
    self._view.ScrollView:UpdateContent()
end

function M:_SetItem(csNoticeData)
    local item = self._view.PageTemplate:Instantiate(self._view.ScrollView.listItem.transform)
    table.insert(self._allItems,item)
    item:SetActive(true)
    local loadingImg = item.transform:GetChild(0)
    loadingImg:SetActive(true)
    item:SetColor(255,255,255,0)
    item:SetUrlImage(csNoticeData.Picture,function()
        loadingImg:SetActive(false)
        item:SetColor(255,255,255,255)
    end)
    if csNoticeData.JumpLink > 0 or (csNoticeData.WebUrl ~= '' and csNoticeData.WebUrl ~= nil) then 
        item:SetOnClick(Bind(self,self._OnClick))
    end
end

function M:_OnClick(go)
    local idx =  self._view.ScrollView:GetCurIndex() 
    local csNoticeData = self._csNoticeDataList[idx]
    --INoticeDataMgr:SetRead(csNoticeData.Id)
    self:_CheckAgain()
    if csNoticeData.JumpLink > 0 then 
        JumpMgr:GetInstance():Execute(csNoticeData.JumpLink)
    elseif csNoticeData.WebUrl ~= '' and csNoticeData.WebUrl ~= nil then
        --外置浏览器
        if csNoticeData.WebOpenOut == 1 then 
            CS.UnityEngine.Application.OpenURL(csNoticeData.WebUrl);
        else
            UIContextMgr:GetInstance():Show("WebUI",csNoticeData.WebUrl)
        end
        
    end
    if self._closeCallback then 
        self._closeCallback(false)
    end
end

function M:OnDestroy()
    self._allItems = {}
    self._csNoticeDataList = nil
    M.super.OnDestroy(self)
end

function M:_Close(go)
    local idx =  self._view.ScrollView:GetCurIndex() 
    local csNoticeData = self._csNoticeDataList[idx]
    local isOn = self._view.tipAgain:GetIsOn()
    INoticeDataMgr:SetRead(csNoticeData.Id,isOn)
    if self._view.ScrollView:GetCurIndex() == self._view.ScrollView:GetTotalPage() - 1 then 
        if self._closeCallback then 
            self._closeCallback(true)
        end
        return 
    end
    idx = self._view.ScrollView:GetCurIndex() + 1
    csNoticeData = self._csNoticeDataList[idx]
    
    self._view.ScrollView:BtnRightGo()
    self._view.tipAgain:SetActive(csNoticeData.DisplayState~=1)
    INoticeDataMgr:SetRead(csNoticeData.Id,isOn)
end

function M:_OnToggle(isOn)
    self:_CheckAgain()
end

function M:_CheckAgain()
    local isOn = self._view.tipAgain:GetIsOn()
    --不再提示
    local idx =  self._view.ScrollView:GetCurIndex() 
    local csNoticeData = self._csNoticeDataList[idx]
    INoticeDataMgr:SetRead(csNoticeData.Id,isOn)
end

return M