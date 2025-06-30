-- UIGameEventRechargeSubView
---@class UIGameEventNewbieTaskSubView
local PropSubView = {}
local this = PropSubView

-- 初始化
---@param self UIGameEventMainView
---@param gameObject UnityEngine.GameObject
---@param eventId number
function this.OnCreate(self, gameObject, eventId)
    ---@type ReferenceCollector
    local rc = gameObject:GetComponent("ReferenceCollector")

    local entryModuleId = self.model.data[self.model.index].gameEvent.entryModuleId

    UIUtil.AddBtnEvent(rc:GetObject("DescButton"), function()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIHelpText, {
            text =  LangUtil.GetConfLang(Z_GameEvents[eventId][entryModuleId], "Desc")
        })
    end)
    this.text = LangUtil.BindText(rc:GetObject("Text"))
    this.monthCardText1 = LangUtil.BindText(rc:GetObject("MonthCardText1"))
    this.monthCardText2 = LangUtil.BindText(rc:GetObject("MonthCardText2"))
    LangUtil.BindText(rc:GetObject("DescText")).text = LangUtil.GetSysLang(1341)
end

---@param self UIGameEventMainView
function this.OnRefresh(self)
    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")

    PublicRequest.SendRequest(
        PROTOCOL.PaymentInfoReq,
        {},
        function(response)
            this.RefreshPaidText(self, response.payment_info.total_paid)
        end,
        function(errorCode)
        end
    )

    ---@type MonthCardComponent
    local monthCardComponent = Game.Scene.Player:GetComponent("MonthCardComponent")

    -- 小月卡 id 1
    local monthCard1 = monthCardComponent:GetMonthCard(1)
    local count1
    if monthCard1 == nil then
        count1 = 0
    else
        count1 = monthCard1.totalDay
    end
    if count1 > 60 then
        count1 = 60
    end
    local text1 = string.gsub(LangUtil.GetSysLang(1339),"XX", monthCard1.config.Name)
    this.monthCardText1.text = string.gsub(text1,"YY", count1)

    -- 大月卡 id 2
    local monthCard2 = monthCardComponent:GetMonthCard(2)
    local count2
    if monthCard1 == nil then
        count2 = 0
    else
        count2 = monthCard2.totalDay
    end
    if count2 > 60 then
        count2 = 60
    end
    local text2 = string.gsub(LangUtil.GetSysLang(1339),"XX", monthCard2.config.Name)
    this.monthCardText2.text = string.gsub(text2,"YY", count2)
end

function this.RefreshPaidText(self, count) -- 美分
    local text

    local dollar = count / 100

    if count % 100 == dollar then
        text = string.gsub(LangUtil.GetSysLang(1338),"XX", count%100)
    else
        text = string.gsub(LangUtil.GetSysLang(1338),"XX", count/100)
    end

    local rebateRatio =95.01 -- 正常返还比例
    local rebateAmount -- 返利金额

    if dollar <= 20 then
        rebateAmount = math.ceil(dollar * rebateRatio * 3)
    elseif dollar <= 300 then
        rebateAmount = math.ceil(20 * rebateRatio * 3 + (dollar - 20) * rebateRatio * 2.5)
    elseif dollar <= 1500 then
        rebateAmount = math.ceil(20 * rebateRatio * 3 + 280 * rebateRatio * 2.5 + (dollar - 300) * rebateRatio * 2)
    else
        rebateAmount = math.ceil(20 * rebateRatio * 3 + 280 * rebateRatio * 2.5 + 1200 * rebateRatio * 2 + (dollar - 1500) * rebateRatio * 1.5)
    end

    this.text.text = string.gsub(text,"YY", rebateAmount)
end

---@param self UIGameEventMainView
function this.OnGameEventUpdate(self)
    this.OnRefresh(self)
end

---@param self UIGameEventMainView
function this.OnTaskUpdate(self)
end

return this