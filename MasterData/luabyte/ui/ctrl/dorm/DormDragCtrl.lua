local DormDragCtrl = BaseClass("DormDragCtrl")
local M = DormDragCtrl
DormDragCtrl.temp = 0

function M:__init(container, heroId)
    self._container = container
    self._dragItem = nil
    self._parentItem = nil
    DormDragCtrl.temp = DormDragCtrl.temp + 1
    self._temp = DormDragCtrl.temp
end

function M:SetFavorProgress(favorProgress)
    self._favorProgress = favorProgress
end

function M:SetHeroId(heroId)
    self._heroId = heroId
end

function M:DragEventHandle(eventType, item, eventData, isInRange)
    if eventType == UITouchHandle.EventType.StartDrag then
        self:StartDrag(item, eventData)
    elseif eventType == UITouchHandle.EventType.Draging then
        self:Draging(eventData, isInRange)
    elseif eventType == UITouchHandle.EventType.EndDrag then
        self:EndDrag(eventData, isInRange)
    end
end

function M:StartDrag(giftItem, eventData)
    self._dragItem = giftItem:Copy(self._container)
    self._dragItem._view.transform:ResetLayout()
    self._dragItem:SetDraging(false)
    self._dragItem:SetDragMode()
    self._dragItem.parent:SetSelect(true)
end

function M:Draging(eventData, isInRange)
    self._dragItem:SetPosByScreen(self._container, eventData.position)
end

function M:EndDrag(eventData, isInRange)
    if self._dragItem then
        local data = self._dragItem:GetData().data
        local itemId = data.Id
        local itemNum = data.Num > 0 and 1 or 0
        
        if itemNum == 0 then
            GameHelper.TipsById(4123)
            return 
        end
        
        self._parentItem = self._dragItem.parent
        
        if self._parentItem then
            self._parentItem:SetSelect(false)
        end
        
        self._dragItem:Destory()
        --此处需要改为立即destory才可以检测
        if eventData:IsOnUI() then
            return 
        end
        
        if isInRange then
            if self._favorProgress == 1.0 then
                local desc = ConfigHelper.GetLocalString(4124) --"当前阶段已满，赠送礼物不会增加好感度数值" .. "<color=red>是否还继续赠送</color>"
                GameHelper.ShowTipByRecord(
                    desc,
                    function(ok)
                        if ok then
                            DormDataMgr:GiftGiving(self._heroId, itemId, itemNum, Bind(self, self._GiveCallback))
                        end
                    end,
                    "favor"
                )
            else
                DormDataMgr:GiftGiving(self._heroId, itemId, itemNum, Bind(self, self._GiveCallback))
            end
        end
    else
        Logger.Log("dragItem is nil ")
    end
    
    self._dragItem = nil
end

function M:_GiveCallback(heroId, addFavor)
    if self._parentItem then
        self._parentItem:Refresh()
    end
    
    self._parentItem = nil
    local curItems = DormDataMgr:GetGiftItems(self._heroId)
    EventMgr:Broadcast(UIMessageNames.DORM_GIVE_GIFT, heroId, addFavor, curItems)
end

function M:Dispose()
    self._container = nil
    self._heroId = 0
    
    if self._dragItem then
        self._dragItem:Destory()
    end
    
    self._dragItem = nil
    self._parentItem = nil
end

return DormDragCtrl
