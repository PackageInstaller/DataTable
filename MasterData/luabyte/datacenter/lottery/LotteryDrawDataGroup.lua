local LotteryDrawDataGroup = BaseClass("LotteryDrawDataGroup")
local M = LotteryDrawDataGroup
local tInsert = table.insert

function M:__init()
    self._page2Id = {}
    self._allLotteryId2Datas = {}
    self:ResetCfg()
end

function M:ResetCfg()    
    local arr = ConfigHelper.GetCfgsByLua("luckDraw")
    self._page2Cfg = {}
    self._allPages = {}
    self.firstHeroId = 0
    self.firstItemId = 0
    for key, value in pairs(arr) do
        local cfg = value
        --检查有效期内的抽卡
        if GameUtil.CheckInTime( cfg.showTime , cfg.startTime ) then
            cfg.state = LotteryConst.LuckDrawState.Notice
        elseif GameUtil.CheckInTime( cfg.startTime , cfg.lastTime ) then
            cfg.state = LotteryConst.LuckDrawState.Active
        else
            cfg.state = LotteryConst.LuckDrawState.Overdue
        end

        if  cfg.sign == 3  
        and table.indexof(self._allPages,cfg.page) then--限时卡池取配置  若当前卡池处于非关闭状态 比较ID 大盖小
            if cfg.state ~= LotteryConst.LuckDrawState.Overdue  then 
                self._page2Id[cfg.page]=cfg.id
                if not table.indexof(self._allPages , cfg.page ) then 
                    tInsert( self._allPages , cfg.page )
                end
                self._page2Cfg[cfg.page] = cfg
            end
        else
            self._page2Id[cfg.page]=cfg.id
            if not table.indexof(self._allPages , cfg.page ) then 
                tInsert( self._allPages , cfg.page )
            end
            self._page2Cfg[cfg.page] = cfg
        end


    end
    table.sort(self._allPages,function(a, b) return a<b end)

end

function M:UpdateDrawData(roleLottoRec,opt)
    local lotterItemCls = require "DataCenter.Lottery.LotteryDrawData"
    local LottyId = roleLottoRec.LottoId
    local lotterItem = nil 
    if opt == protocol.Options.DB_UPDATE or opt == protocol.Options.DB_ADD then 
        if self._allLotteryId2Datas[LottyId] == nil then 
            lotterItem = lotterItemCls.New()
            self._allLotteryId2Datas[LottyId] = lotterItem
        else
            lotterItem = self._allLotteryId2Datas[LottyId]
        end
        lotterItem:SetData(roleLottoRec)  
    elseif opt == protocol.Options.DB_DELETE then 
        if self._allLotteryId2Datas[LottyId] then
            self._allLotteryId2Datas[LottyId] = nil 
        end
    end
end

-- function M:GetDrawDataBySign(sign)
--     return self._allLotteryId2Datas[sign]
-- end

function M:GetDrawDataById(id)
    return self._allLotteryId2Datas[id]
end

function M:GetDrawDataByPage(page)
    local Id = self._page2Id[page]
    return self:GetDrawDataById(Id)
end

--通过卡池标记获取第一个满足的记录
function M:GetFirstDataBySign(sign)
    for key, value in pairs(self._allLotteryId2Datas) do
        if value.Sign == sign then
            return value
        end
    end
    return nil
end

function M:GetCfgByPage(page)
    return self._page2Cfg[page]
end

function M:GetAllPages()
    return self._allPages
end

function M:SetFirstHeroId(heroid)
    self.firstHeroId = heroid
end

function M:GetFirstHeroId()
    return self.firstHeroId 
end

function M:SetFirstItemId(itemid)
    self.firstItemId = itemid
end

function M:GetFirstItemId()
    return self.firstItemId 
end

return LotteryDrawDataGroup