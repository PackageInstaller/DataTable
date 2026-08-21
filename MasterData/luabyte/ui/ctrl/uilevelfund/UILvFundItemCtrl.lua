-- 成长基金Item
-- 2023/6/20 20:27:59
local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UILvFundItemCtrl = BaseClass("UILvFundItemCtrl", CircularScrollViewItem)
local M = UILvFundItemCtrl
local sfmt = string.format

function M:Init()
    self._view.ItemPfb1:SetOnClick(Bind(self, self._onClickAward))
    self._view.ItemPfb2:SetOnClick(Bind(self, self._onClickPaid))
end

function M:UpdateItem(data)
    self.data = data
    local title = ConfigHelper.GetLocalString(6288)
    title = sfmt(title, data.level)
    self._view.labTitle:SetText(title)
    self._view.ItemPfb1:UpdateData(data.freeData)
    self._view.ItemPfb2:UpdateData(data.paidData)
end

function M:SetClick(callBackAward, callBackPaid)
    self.callBackAward = callBackAward
    self.callBackPaid = callBackPaid
end

function M:_onClickAward()
    if self.callBackAward then
        self.callBackAward(self.data.id)
    end
end

function M:_onClickPaid()
    if self.callBackPaid then
        self.callBackPaid(self.data.id)
    end
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return UILvFundItemCtrl
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

