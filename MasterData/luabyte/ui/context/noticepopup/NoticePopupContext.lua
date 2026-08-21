local M = BaseClass("NoticePopupContext",BaseContext)

function M:__init()
    self._lastIds = {}
end

function M:Open(closeCallback)
    if IGuideMgr.IsGuiding then 
        closeCallback()
        return
    end
    local nowTimer = TimeUtil.GetNowTimeStamp()

    INoticeDataMgr:GetNoticeListByTypeAysn(CS.GameX.NoticeType.Popup,
    function(csNoticeDatalist)
        if IsNull(csNoticeDatalist) or csNoticeDatalist.Count == 0 then 
            closeCallback()
            return 
        end
    
        --完成一样的，就不再显示
        if self:_CheckSameNotices(csNoticeDatalist) then 
            closeCallback()
            return 
        end
        self._lastIds = {}
        self:_Show(csNoticeDatalist,closeCallback)
        for i = 0 , csNoticeDatalist.Count - 1 do 
            local  csNotice = csNoticeDatalist[i]
            table.insert(self._lastIds , csNotice.Id) 
        end
    end)
    
end

function M:_CheckSameNotices(csNoticeDatalist)
    
    if #self._lastIds ~= csNoticeDatalist.Count then 
        return false 
    end
    for i = 0 , csNoticeDatalist.Count - 1 do 
        local  csNotice = csNoticeDatalist[i]
        if not table.indexof(self._lastIds , csNotice.Id) then 
            return false
        end
    end
    return true
end

return M 