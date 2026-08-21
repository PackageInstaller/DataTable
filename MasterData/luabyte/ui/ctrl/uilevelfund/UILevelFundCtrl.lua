-- 成长基金
-- baoruichang
-- 2023/6/20 20:27:59
local UILevelFundCtrl = BaseClass("UILevelFundCtrl", BaseUICtrl)
local M = UILevelFundCtrl
local UILvFundItemCtrl = require("UI.Ctrl.UILevelFund.UILvFundItemCtrl")
local UILvFundItemView = require("UI.View.UILevelFund.UILvFundItemView")
local PAYID = 61 -- 策划说成长基金的充值id61不会改

function M:Init()
    self.grid = self._view.grid
    self.grid:Init(UILvFundItemCtrl, UILvFundItemView)
    self.grid:SetCreateItemCallback(Bind(self, self._onCreateItem))
    self._view.btnRecharge:onClick(Bind(self, self._RechargeClick))
    self._view.btnGetAll:onClick(Bind(self, self._GetAllClick))
    self._view.PropertyBar:Action(6)
    self._rechargeCallback = EventMgr:AddListener(UIMessageNames.LEVELFUND_RECHARGE, Bind(self, self.InitRechargeState))
end

-- 进入UI，可传参数
function M:OnEnter()
    self.level = IPlayerData.level
    self:InitRechargeState()
    self:InitData()
end

function M:OnVisible()
    self:OnEnter()
end

function M:InitRechargeState()
    self.PayId, self.AwardMask, self.AwardMaskPaid = LevelFundMgr:GetInstance():GetData()
    self._view.rechargeState:SetState(self.PayId > 0 and 1 or 2)
    if self.PayId > 0 then
        return
    end
    local truePrice = ConfigHelper.GetCfgPropByLua("pay", PAYID, "truePrice")
    local recharge = ConfigHelper.GetLocalString(543)
    -- if truePrice % 100 == 0 then
    --     recharge = recharge .. math.modf(truePrice / 100)
    -- else
    --     recharge = recharge .. truePrice / 100
    -- end
    local price = string.format("%d", truePrice / 100)
    -- if string.sub(price, -1) == "0" then
    --     price = string.sub(price, 1, -2)
    -- end
    self._view.labRecharge:SetText(recharge .. price)
end

function M:_onCreateItem(UILvFundItemCtrl)
    UILvFundItemCtrl:SetClick(Bind(self, self._onClickAward), Bind(self, self._onClickMaskAward))
end

function M:_RechargeClick()
    SDKHelper.Pay(PAYID, function(isOk)
        if not isOk then
            GameHelper.TipsById(5789) -- 充值失败
            return
        end
    end)
end

function M:_GetAllClick()
    if not self.getAllState then
        return
    end
    self:GetContext():RequestGrowGoldAwards(0)
end

function M:_onClickAward(id)
    self:GetContext():RequestGrowGoldAwards(id, 0)
end

function M:_onClickMaskAward(id)
    self:GetContext():RequestGrowGoldAwards(id, 1)
end

function M:RefList()
    self.PayId, self.AwardMask, self.AwardMaskPaid = LevelFundMgr:GetInstance():GetData()
    self:InitData()
end

function M:InitData()
    self.growGolds = ConfigHelper.GetCfgs("growGold")
    self.getAllState = false
    for _, growGold in pairs(self.growGolds) do
        local id = growGold.id
        local isLock = self.level < growGold.level -- 等级限制

        local tempDatafree = {}
        tempDatafree.id = growGold.freeReward[1]
        tempDatafree.num = growGold.freeReward[2]
        tempDatafree.isLock = isLock
        tempDatafree.isBuy = true
        tempDatafree.isReward = self:_IsReward(id, self.AwardMask)
        tempDatafree.canReward = not isLock and not tempDatafree.isReward
        growGold.freeData = tempDatafree

        local tempDataPaid = {}
        tempDataPaid.id = growGold.payReward[1]
        tempDataPaid.num = growGold.payReward[2]
        tempDataPaid.isLock = isLock
        tempDataPaid.isBuy = self.PayId > 0
        tempDataPaid.isReward = self:_IsReward(id, self.AwardMaskPaid)
        tempDataPaid.canReward = not isLock and not tempDataPaid.isReward and tempDataPaid.isBuy
        growGold.paidData = tempDataPaid

        self.getAllState = self.getAllState or tempDatafree.canReward or tempDataPaid.canReward
    end
    self.grid:SetDataList(self.growGolds)
    self._view.btnState:SetState(self.getAllState and 1 or 2)
end

function M:_IsReward(id, mask)
    return 1 << id & mask > 0
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.LEVELFUND_RECHARGE, self._rechargeCallback)
    M.super.OnDispose(self)
end

return UILevelFundCtrl
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O\ = /O
--                        ____/`---'\____
--						  . ' \\| |// `.
--                       / \\||| : |||// \
--                     / _||||| -:- |||||- \
--                       | | \\\ - --/ | |
--                     | \_| ''\---/'' | |
--                      \ .-\__ `-` ___/-. /
--                   ___`. .' /--.--\ `. . __
--                ."" '< `.___\_<|>_/___.' >'"".
--               | | : `- \`.;`\ _ /`;.`/ - ` : | |
--                 \ \ `-. \_ __\ /__ _/ .-` / /
--         ======`-.____`-.___\_____/___.-`____.-'======
--                            `=---='
--
--         .............................................
--                  佛祖镇楼                  BUG辟易
--          佛曰:
--                  写字楼里写字间，写字间里程序员；
--                  程序人员写程序，又拿程序换酒钱。
--                  酒醒只在网上坐，酒醉还来网下眠；
--                  酒醉酒醒日复日，网上网下年复年。
--                  但愿老死电脑间，不愿鞠躬老板前；
--                  奔驰宝马贵者趣，公交自行程序员。
--                  别人笑我忒疯癫，我笑自己命太贱；
--                  不见满街漂亮妹，哪个归得程序员？
