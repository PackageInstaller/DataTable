local AltasRedPointChecker = BaseClass("AltasRedPointChecker" , require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = AltasRedPointChecker

function M:__init()
    self._refreshRedPoint = Bind(self,self._OnRefreshRedPoint)
    self._curlockNum = {}
    self._privousLockNum = {}
end

function M:Check(bookType)
    if not self:OnChanged(bookType) then
        return
    end

    bookType = bookType or 0
    PlotAtlasDataMgr:GetInstance():SetBookStateRestCallback(self._refreshRedPoint)
    self._curlockNum[bookType] = PlotAtlasDataMgr:GetInstance():GetPlotAtlasUnlockNum(bookType)
    local curNum = self._curlockNum[bookType] or 0
    local preNum = self._privousLockNum[bookType] or 0
    if curNum > preNum then
        self.checkResult = 1
    else
        self.checkResult = 0
    end
end

function M:_OnRefreshRedPoint(bookType)
    bookType = bookType or 0
    self._privousLockNum[bookType] = self._curlockNum[bookType]
end

return AltasRedPointChecker