local LotteryContext = BaseClass("LotteryContext", BaseContext)
local M = LotteryContext
local MessageId = Proto.MessageId
local tInsert = table.insert
function M:Init()
    self._extraHero = nil
    self._otherAwardItem = nil
    self._allItem = nil --该次抽奖获得的所有物品
    self._lotteryId = 0
    self._lottoDataGroup = require("DataCenter.Lottery.LotteryDrawDataGroup").New()
    self._isOpen = false
    self._curIdx = 0
    self._otherItemId = {} --额外的道具Id 用来做展示列表排序

    self._requestLottoCallback = function(messageId, result, msg)
        self._isLoading = false
        self._otherItemId = {}
        if self._lottoComplete then
            self._lottoComplete(msg.Result == 0)
        end
        self._lottoComplete = nil
        if result ~= 0 then
            return
        end
        local lottoId = msg.LottoId
        local curCfg = ConfigHelper.GetCfg("luckDraw", lottoId)
        -- if curCfg == nil or curCfg.type ~= 1 then
        if curCfg == nil then
            return
        end


        --此处需要处理总次数
        self._allItem = {}

        --观光资源
        self._otherAwardItem = nil
        if not IsNull(msg.Other) and #msg.Other ~= 0 then
            self._otherAwardItem = {}
            for i = 1, #msg.Other do
                local data = msg.Other[i]
                tInsert(self._otherItemId, data.Id)
                self._otherAwardItem[data.Id] = data.Cnt
                if self._allItem[data.Id] ~= nil then
                    self._allItem[data.Id] = self._allItem[data.Id] + data.Cnt
                else
                    self._allItem[data.Id] = data.Cnt
                end
            end
        end

        local hasExtra = false
        local heros = {}
        local oitems = {} --原始 没经过转化的道具
        self._extraHero = nil
        hasExtra = #msg.Data > 10
        Logger.Log("Has 11 Hero ???::" .. #msg.Data)
        for i = 1, #msg.Data do
            --记录获取的所有道具
            local luckdrawData = ConfigHelper.GetCfg("luckDraw", msg.LottoId)
            local rec = msg.Data[i]

            --记录英雄品级
            local itemData = ConfigHelper.GetCfgByLua("item", rec.ObjId)
            if itemData == nil then
                Logger.LogError("Can't Find Id:" .. rec.ObjId .. "  In Item")
            end
            rec.quality = itemData.quality --把品级也丢到数据里 后面展示界面排序要用

            if luckdrawData ~= nil then
                rec.Sign = luckdrawData.sign
            end
            --self._lottoDataGroup:UpdateDrawData(rec , protocol.Options.DB_UPDATE)--感觉没必要每次抽卡update  会有updatelottoREC推送回来 靠那个更新
            if rec.ChipId ~= 0 then
                if self._allItem[rec.ChipId] then
                    self._allItem[rec.ChipId] = self._allItem[rec.ChipId] + rec.ChipNum
                else
                    self._allItem[rec.ChipId] = rec.ChipNum
                end
            else
                if self._allItem[rec.ObjId] then
                    self._allItem[rec.ObjId] = self._allItem[rec.ObjId] + 1
                else
                    self._allItem[rec.ObjId] = 1
                end
            end

            --记录原始道具data

            if oitems[rec.ObjId] then
                oitems[rec.ObjId] = oitems[rec.ObjId] + rec.ObjNum
            else
                oitems[rec.ObjId] = rec.ObjNum
            end


            if self._extraHero == nil and hasExtra then
                local cfg = ConfigHelper.GetCfg("item", rec.ObjId)
                if cfg.quality >= 4 then
                    self._extraHero = rec
                else
                    tInsert(heros, rec)
                end
            else
                tInsert(heros, rec)
            end
        end

        self._lotteryId = msg.LottoId
        self._waitCommonShowOver = true
        --local mian_view = ModuleMgr:GetInstance():GetCurrentModule():GetViewAndCtrl("Display02")

        local lotteryModuel = ModuleMgr:GetInstance():GetCurrentModule()
        if lotteryModuel.ChangeLotteryState then
            lotteryModuel:ChangeLotteryState(curCfg.type)
        end

        if curCfg.type == 1 then --英雄抽卡
            self:_Broadcast(UIMessageNames.LOTTERY_TIMELINE_PLAY_START, msg.LottoId, heros)
            self:DataCollectionHero(#msg.Data > 1, msg.LottoId)
        elseif curCfg.type == 2 then --礼物抽卡
            -- mian_view.lotteryObjs:SetActive(false)
            -- mian_view.luckdrawObjs:SetActive(true)
            local itemIds = {}
            local itemNums = {}
            for key, value in pairs(self._allItem) do
                tInsert(itemIds, key)
                tInsert(itemNums, value)
            end
            self:_Broadcast(UIMessageNames.LOTTERY_LUCKDRAW_TIMELINE_PLAY_START, oitems, itemIds, itemNums)
            self:DataCollectionGift(#msg.Data > 1)
        end

        for key, value in pairs(heros) do
            --策划说 十连就存10条单抽。。。。--2022/4/20
            GameHelper.SaveLuckDrawData(curCfg.type, curCfg.id, value.ObjId, 1, value.ChipId == 0) --chipId为0则没走转换
        end

        if hasExtra then
            GameHelper.SaveLuckDrawData(curCfg.type, curCfg.id, self._extraHero.ObjId, 1, self._extraHero.ChipId == 0)
            GameKeyNodeMgr:GetInstance():Record(EGameKeyNode.ElevenDrawTrigger)
        end
    end
    self._notify_UpdateLottoCallback = function(messageId, result, msg)
        if result ~= 0 then
            return
        end
        self._lottoDataGroup:UpdateDrawData(msg.Data, protocol.Options.DB_UPDATE)
        local cfg = ConfigHelper.GetCfgByLua("luckDraw", msg.Data.LottoId)
        local page = 0
        if cfg ~= nil then
            page = cfg.page
        end

        self:_Broadcast(UIMessageNames.UPDATE_LOTTERY_DATA, page, msg.Data)
    end
    self._timePlayHandler = EventMgr:AddListener(UIMessageNames.LOTTERY_TIMELINE_PLAY_OVER,
        Bind(self, self._TimePlayOver))
    self._timeSkipHandler = EventMgr:AddListener(UIMessageNames.LOTTERY_TIMELINE_SKIP, Bind(self, self._SkipTimeLineNEW))

    NetPack:RegistResponse(MessageId.ResponseGameLotto, self._requestLottoCallback)
    NetPack:RegistResponse(MessageId.NotifyUpdateLottoRec, self._notify_UpdateLottoCallback)

    self._allLotterySign2Datas = {}
    self._configs = nil
    self._isLoading = false
    self._isForTest = false
    self._waitShowCom = false
    self._waitCommonShowOver = false
end

function M:_TimePlayOver(lotteryId, heros)
    if self._waitCommonShowOver then
        self._waitCommonShowOver = false
        self:_ShowResult(lotteryId, heros, Bind(self, self._LotteryWinClose), self._extraHero == nil)
    else
        --额外送的，或者观光奖励都要单独显示
        if self._extraHero or self._otherAwardItem then
            self._waitShowCom = true
            local items = {}
            if self._extraHero then
                tInsert(items, self._extraHero)
                self:_ShowResult(lotteryId, items, Bind(self, self._ExtraLotteryWinClose), true)
                return
            end
            if self._otherAwardItem then
                self:_ExtraLotteryWinClose(true)
            end
        end
    end
end

function M:_SkipTimeLineNEW(lotteryId, heros)
    if self._waitCommonShowOver then
        self._waitCommonShowOver = false
        self:_SkipShowResultNew(lotteryId, heros, Bind(self, self._LotteryWinClose), self._extraHero == nil)
    else
        --额外送的，或者观光奖励都要单独显示
        if self._extraHero or self._otherAwardItem then
            self._waitShowCom = true
            local items = {}
            if self._extraHero then
                tInsert(items, self._extraHero)
                self:_SkipShowResultNew(lotteryId, items, Bind(self, self._ExtraLotteryWinClose), true)
                return
            end
            if self._otherAwardItem then
                self:_ExtraLotteryWinClose(true)
            end
        end
    end
end

--弃用 防止后面策划回滚 先留着
function M:_SkipTimeLine(lotteryId, heros)
    if self._waitCommonShowOver then
        self._waitCommonShowOver = false
        self:_SkipShowResult(lotteryId, heros, Bind(self, self._LotteryWinClose), self._extraHero == nil)
        --local c = ConfigHelper.GetCfgByLua( "luckDraw", lotteryId )
        --local cfgArr = self._configs[c.type]
        --UIContextMgr:GetInstance():Show("Lottery10Result",heros , cfgArr ,self._extraHero == nil,Bind(self,self._ExtraLotteryWinClose))
    else
        --额外送的，或者观光奖励都要单独显示
        if self._extraHero or self._otherAwardItem then
            self._waitShowCom = true
            local items = {}
            if self._extraHero then
                tInsert(items, self._extraHero)
                self:_SkipShowResult(lotteryId, items, Bind(self, self._ExtraLotteryWinClose), true)
                return
            end
            if self._otherAwardItem then
                self:_ExtraLotteryWinClose(true)
            end
        end
    end
end

function M:_ShowResult(lotteryId, heros, onResultComplete, showNext)
    local len = #heros
    local heroDatas = {}
    for index, value in ipairs(heros) do
        -- body
        tInsert(heroDatas, value)
    end
    --3D->立绘->总览->显示奖励
    local c = ConfigHelper.GetCfgByLua("luckDraw", lotteryId)
    -- local cfgArr = self._configs[c.type]
    local cfgArr = self._lottoDataGroup:GetCfgByPage(c.page)
    GameHelper.ShowRolesStarSuccess(heroDatas, function()
        UIContextMgr:GetInstance():Show("Lottery10Result", heros, cfgArr, showNext, onResultComplete)
    end, heros)
end

function M:_SkipShowResultNew(lotteryId, heros, onResultComplete, showNext)
    local len = #heros
    local heroDatas = {}
    local SSrHeroData = {}
    for index, value in ipairs(heros) do
        --local itemData = ConfigHelper.GetCfgByLua("item", value.ObjId)
        --value.quality = itemData.quality --把品级也丢到数据里 后面展示界面排序要用
        tInsert(heroDatas, value)
        if value.quality >= 4 then --ssr
            tInsert(SSrHeroData, value)
        end
    end
    local c = ConfigHelper.GetCfgByLua("luckDraw", lotteryId)

    local cfgArr = self._lottoDataGroup:GetCfgByPage(c.page)
    GameHelper.ShowRolesStarSuccess(heroDatas, function()
        UIContextMgr:GetInstance():Show("Lottery10Result", heros, cfgArr, showNext, onResultComplete)
    end, SSrHeroData)
end

--弃用 防止后面策划回滚 先留着
function M:_SkipShowResult(lotteryId, heros, onResultComplete, showNext)
    local len = #heros
    local heroDatas = {}
    for index, value in ipairs(heros) do
        -- body
        tInsert(heroDatas, value)
    end

    local c = ConfigHelper.GetCfgByLua("luckDraw", lotteryId)
    -- local cfgArr = self._configs[c.type]
    local cfgArr = self._lottoDataGroup:GetCfgByPage(c.page)
    UIContextMgr:GetInstance():Show("Lottery10Result", heros, cfgArr, showNext, onResultComplete)
    -- GameHelper.ShowRolesStarSuccess( heroDatas , function()
    --     UIContextMgr:GetInstance():Show("Lottery10Result",heros , cfgArr ,showNext,onResultComplete)
    -- end)
end

function M:_ExtraLotteryWinClose(isNormalClose)
    --非正常关闭，即为点击继续抽卡关闭，则不处理

    if not isNormalClose then
        return
    end
    local d = {}
    local isOk = false
    -- if self._extraHero then
    --     if self._extraHero.m_nChipId == 0 then
    --         d[self._extraHero.HeroId] = 1
    --     else
    --         d[self._extraHero.m_nChipId] = 1
    --     end
    --     isOk = true
    -- end
    -- if self._otherAwardItem then
    --     for k,v in pairs(self._otherAwardItem) do
    --         d[k]=v
    --     end
    --     isOk = true
    -- end

    if self._allItem then
        for k, v in pairs(self._allItem) do
            d[k] = v
        end
        isOk = true
    end

    --排序 把道具放到前面
    for _, value in pairs(self._otherItemId) do
        if d[value] ~= nil then
            local temValue = d[value]
            d[value] = nil
            d[value] = temValue
        end
    end

    if isOk then
        GameHelper.ShowGetItems(d, function()
            self:Open(self.showPage)
        end)
    else
        self:Open(self.showPage)
    end
    self._otherAwardItem = nil
    self._extraHero = nil
    self._allItem = nil
end

--展示结束
function M:_LotteryWinClose(isNormalClose)
    if self._extraHero then
        UIContextMgr:GetInstance():Show("LotteryLoading", function()
                self:_Broadcast(UIMessageNames.LOTTERY_TIMELINE_PLAY_START, self._lotteryId, { self._extraHero }, 370)
            end,
            self._extraHero)
    elseif self._otherAwardItem then
        self:_ExtraLotteryWinClose(isNormalClose)
    else
        self:Open()
        UIContextMgr:GetInstance():Close("Lottery10Result")
    end
end

--抽卡
function M:Lotto(lottotId, times, lottoComplete)
    if self._isLoading then
        --return
    end
    self._lottoComplete = lottoComplete

    local items = LotteryHelper.CheckLotteryCost(lottotId, times == 1)
    local cfg = ConfigHelper.GetCfg("luckDraw", lottotId)

    if (items == nil) or (#items == 0) then --抽卡消耗不足
        if lottotId == 2 then               -- 新手卡池有个bug，先暂时修复，关联luckDraw表id=2-liu
            GameHelper.Tips("征募凭据不足！")
            return
        end

        local showItems = LotteryHelper.CheckLotteryCostByInfiniteDiamond(lottotId, times == 1)
        local showlanguage = ConfigHelper.GetLocalString(1283)
        local showtipstr = " "
        for i = 1, #showItems do
            local itemcfg = ConfigHelper.GetCfg("item", showItems[i].Id)
            local itemName = ConfigHelper.GetLocalString(itemcfg.name)
            showtipstr = showtipstr .. itemName .. " x " .. showItems[i].Cnt .. " "
        end
        showtipstr = string.replace(showlanguage, "{1}", tostring(times))
        UIContextMgr:GetInstance():Show(UIDefine.UILottery_Exchange, showtipstr, showItems, cfg, function(ok)
            if ok then
                local desc = ConfigHelper.GetLocalString(6266)
                GameHelper.ShowTipByRecord(desc, function(_ok)
                    if _ok then
                        JumpMgr:GetInstance():Execute(55)
                    end
                end)
            end
        end)

        return
    end
    local drawData = self._lottoDataGroup:GetDrawDataById(lottotId)
    if drawData then
        if TimeUtil.IsToday(drawData.ConditionTime, 5) then
            local costList
            if times == 1 then
                costList = cfg.singleItem
            else
                costList = cfg.tenItem
            end
            local cost_dic = {}
            for i = 1, #costList, 2 do
                cost_dic[costList[i]] = costList[i + 1]
            end
            local cost = 0
            for _, v in pairs(items) do
                if v.Id == cfg.condition then -- 只限制condition里面的道具使用
                    cost = cost + (cost_dic[v.Id] or 0) * v.Cnt
                end
            end
            if cost > math.max(0, cfg.valueCondition - drawData.ConditionValue) then
                GameHelper.Tips("今日精密星斯征募次数已用完！")
                return
            end
        end
    end

    local itemIds = {}
    for _, value in pairs(items) do
        tInsert(itemIds, value.Id)
    end
    local hasSpCost = LotteryHelper.CheckSpecialCost(lottotId, times == 1, itemIds) --检测是否有需要提示的道具
    local language = ConfigHelper.GetLocalString(1283)
    --拼接提示需要的货币的字符串
    local tipstr = " "
    for i = 1, #items do
        local itemcfg = ConfigHelper.GetCfg("item", items[i].Id)
        local itemName = ConfigHelper.GetLocalString(itemcfg.name)
        tipstr = tipstr .. itemName .. " x " .. items[i].Cnt .. " "
    end
    if #items > 1 or hasSpCost then --当混合付费或有特殊道具时则提示
        tipstr = string.replace(language, "{1}", tostring(times))
        UIContextMgr:GetInstance():Show(UIDefine.UILottery_Exchange, tipstr, items, cfg, function(ok)
            if ok then
                self:LottoRequest(lottotId, times, items)
                -- 资源转换埋点
                for _, item in pairs(items) do
                    if item.Id == 5 then
                        local dataValues = { 1, item.Cnt }
                        IBuriedPointDataMgr:SubmitData(BuriedPointConst.Item5Use, dataValues)
                    elseif item.Id == 6 then
                        local dataValues = { 1, item.Cnt }
                        IBuriedPointDataMgr:SubmitData(BuriedPointConst.Item6Use, dataValues)
                    end
                end
            end
        end)
    else
        --不涉及道具转换 用带记录的提示
        local tipstr = string.replace(language, "{0}", tipstr)
        tipstr = string.replace(tipstr, "{1}", tostring(times))
        GameHelper.ShowTipByRecord(tipstr, function(ok)
            if ok then
                self:LottoRequest(lottotId, times, items)
            end
        end, "lotto")
    end
end

function M:LottoRequest(lottotId, times, items)
    self._isLoading = true
    local request = {}
    request.LottoId = lottotId
    request.Times = times
    request.Items = items
    NetPack:SendMessage(MessageId.RequestGameLotto, request)
end

--加载抽卡数据，返回协议
function M:_OnLoadLottto(messageId, result, msg)
    self._isLoading = false
    if result ~= 0 then
        return
    end
    if not self._isOpen then
        return
    end
    local datas = msg.Data
    for i, d in ipairs(datas) do
        local roleLottoRec = datas[i]
        if roleLottoRec.LottoId == nil and roleLottoRec.LottyId ~= nil then
            roleLottoRec.LottoId = roleLottoRec.LottyId --临时帮兵兵纠正一下拼写错误 后面他改
        end
        self._lottoDataGroup:UpdateDrawData(roleLottoRec, protocol.Options.DB_ADD)

        --通知UI刷新
        local cfg = ConfigHelper.GetCfgByLua("luckDraw", d.LottoId)
        local page = 0
        if cfg ~= nil then
            page = cfg.page
        end
        self:_Broadcast(UIMessageNames.UPDATE_LOTTERY_DATA, page, roleLottoRec)
    end
    --设置是否首抽过
    if msg.FirstHeroId ~= nil then
        self._lottoDataGroup:SetFirstHeroId(msg.FirstHeroId)
    end
    if self.showPage == nil then
        self:_Show(LotteryType.Normal, self._lottoDataGroup)
    else
        self:_Show(self.showPage, self._lottoDataGroup)
    end
    UIContextMgr:GetInstance():Close("Lottery10Result")
end

function M:ResetcurIdx()
    self._curIdx = 0 --玮哥说每次进入都重置
end

function M:Open(page, msg)
    if self._isLoading then
        return
    end
    if page ~= nil then
        Logger.Log("Lottery: -- LotteryContext :" .. page)
    end
    self.showPage = page
    self._isOpen = true
    self:_initCfg()
    self._lottoDataGroup:ResetCfg(1)
    if msg == nil then
        local request = {}
        if self._loadLottoCallback then
            NetPack:UnRegistResponse(MessageId.ResponseLoadLottoRec, self._loadLottoCallback)
        end
        self._loadLottoCallback = NetPack:RegistResponse(MessageId.ResponseLoadLottoRec, Bind(self, self._OnLoadLottto))
        NetPack:SendMessage(MessageId.RequestLoadLottoRec, request)
    else
        self:_OnLoadLottto(0, 0, msg)
    end
end

function M:OnClose()
    self._isOpen = false
    NetPack:UnRegistResponse(MessageId.ResponseLoadLottoRec, self._loadLottoCallback)
    M.super.OnClose(self)
end

--初始化抽卡界面配置
function M:_initCfg()

end

--英雄抽卡埋点
function M:DataCollectionHero(mode, id)
    local times = 0
    if mode then
        times = 10
    else
        times = 1
    end
    --抽卡埋点
    local cfg = ConfigHelper.GetCfgByLua("luckDraw", id)
    local type = cfg.page
    local dataKey = { "darw_mode", "draw_type" }
    local dataValues = { tostring(times), tostring(type) }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.LotteryDraw, dataValues)
end

--礼物抽卡埋点
function M:DataCollectionGift(mode)
    local times = 0
    if mode then
        times = 5
    else
        times = 1
    end
    local dataKey = { "darw_mode", }
    local dataValues = { tostring(times) }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Contraband_draw, dataValues)
end

return LotteryContext
